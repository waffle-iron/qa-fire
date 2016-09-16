require 'exceptions'
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'], request.env['omniauth.strategy'])
    sign_in_and_redirect(@user, :event => :authentication)
    set_flash_message(:notice, :success, :kind => 'Github') if is_navigational_format?
  rescue ::Exceptions::NoValidEmailError
    redirect_to root_path
    set_flash_message(:alert, :failure, :kind => 'Github', reason: 'your account does not have a valid email address') if is_navigational_format?
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    root_path
  end

end