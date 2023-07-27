program HorseLinuxDeamonBlank;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse, Horse.Jhonson, Horse.HandleException, System.JSON, System.SysUtils;

{<<<<<<<<< Declara��o de variaveis >>>>>>>>}
var
  App: THorse;
  FPortaWS: string;

{<<<<<<<<< Fun��es >>>>>>>>}

procedure CarregaConfiguracao;
begin
  FPortaWS := '9000';
end;

{<<<<<<<<< Inicio da aplica��o >>>>>>>>}
begin
  try
    CarregaConfiguracao;
    App := THorse.Create;
    App.Use(Jhonson());
    App.Use(HandleException);
    App.Port := StrToIntDef(FPortaWS, 9000);
    App.Get('/online',
      procedure(Req: THorseRequest; Res: THorseResponse)
      begin
        Res.Send(FormatDateTime('dd/mm/yyyy hh:nn:ss', now)).Status(THTTPStatus.OK);
      end);

    App.Listen;
    WriteLn('Servi�o online na porta: '+FPortaWS);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
end.
