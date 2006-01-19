Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWASXfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWASXfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWASXfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:35:21 -0500
Received: from smtp-30.ig.com.br ([200.226.132.30]:61838 "EHLO
	smtp-30.ig.com.br") by vger.kernel.org with ESMTP id S1422687AbWASXfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:35:20 -0500
To: linux-kernel@vger.kernel.org
From: mvaldinei <mvaldinei@ig.com.br>
Cc: mrval@itelefonica.com.br
Subject: ENC: Aplicando patch de  =?ISO-8859-1?Q?=20atualiza=E7=E3o?=
Date: Thu, 19 Jan 2006 21:35:03 -0200
X-Priority: 3 (Normal)
Message-ID: <20060119_233503_049940.mvaldinei@ig.com.br>
X-Originating-IP: [10.17.1.43]200.148.17.83
X-Mailer: iGMail [www.ig.com.br]
X-user: mvaldinei@ig.com.br
Teste: asaes
MIME-Version: 1.0
Content-type: multipart/mixed;
	boundary="Message-Boundary-by-Mail-Sender-1137713703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--Message-Boundary-by-Mail-Sender-1137713703
Content-type: text/plain; charset=ISO-8859-1
Content-description: Mail message body
Content-transfer-encoding: 8bit
Content-disposition: inline

Derrubei atualizações em www.conectiva.com.br/atualizacoes.Usei outro 
computador. 
Então agora localmente, após abrir os rpm obtive também varios  arquivos 
patch. 
Entrei no diretório /usr/src/linux/drivers/usb/host/ que continha o 
ohci-hcd.c e digitei: 
#patch ohci-hcd.c --dry-run --verbose 
(Coloquei --dry-run só para testar e evitar estragar algo.) 
a resposta foi que não achava a entrada, então acrescentei 
-i /usr/src/rpm/SOURCE/usb-ohci-hcd-.....patch e obtive um retorno como: 

Hmm...  Looks like a unified diff to me... 
can't find file to patch at input line 25 
Perhaps you should have used the -p or --strip option? 
The text leading up to this was: 
-------------------------- 
|# This is a BitKeeper generated patch for the following project: 
|# Project Name: Linux kernel tree 
|# This patch format is intended for GNU patch command version 2.5 or 
higher. 
|# This patch includes the following deltas: 
|#	           ChangeSet	1.481   -> 1.482 
|#	drivers/usb/host/ohci-hcd.c	1.15    -> 1.16 
|# 
|# The following is the BitKeeper ChangeSet Log 
|# -------------------------------------------- 
|# 02/06/13	david-b@pacbell.net	1.482 
|# [PATCH] ohci-hcd init err detect 
|# 
|# Here's a followup patch, should apply on top of what I sent 
|# this morning ... please do so!  (Sorry, same name but the 
|# patch is different.) 
|# 
|# Along with some cleanups, this actually restores a line that 
|# was dropped somewhere in 2.5 ... basically, at least SiS and 
|# OPTi violate the OHCI spec so they don't init "by the book". 
|# -------------------------------------------- 
|# 
|diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c 
|--- a/drivers/usb/host/ohci-hcd.c	Fri Jun 14 14:15:33 2002 
|+++ b/drivers/usb/host/ohci-hcd.c	Fri Jun 14 14:15:33 2002 
-------------------------- 
File to patch: 
Skip this patch? [y] 
Skipping patch. 
Hunk #1 ignored at 106. 
Hunk #2 ignored at 348. 
Hunk #3 ignored at 372. 
Hunk #4 ignored at 446. 
Hunk #5 ignored at 456. 
Hunk #6 ignored at 469. 
Hunk #7 ignored at 480. 
7 out of 7 hunks ignored 
done 

Quem é o "--- a/..." e o "+++ b/..." no diff acima ? 

experimentei usar o kompare: aplicar diferenças mas na hora de salvar na 
caixa de informação: 
Nâo foi possível atualizar o arquivo temporário para a localização destino . 
O arquivo temporário ainda está disponível em: 
/tmp/kde-root/kompares9NTGa.tmp. Você pode copiá-lo manualmente para o local 
correto. 

Onde seria o local correto ? drivers/usb/host/ohci-hcd.c ? Esse arquivo não 
tem semelhança nenhuma com o patch que estou querendo aplicar,nome de 
funções e linhas de comando, não entendi porque, o compare mostra muitas 
semelhanças. 

Experimentei também: 
cd /usr/src/linux 
patch --dry < ../rpm/SOURCES/usb-ohci-hcd.c      e quando: 
File to Patch:           informei drivers/usb//host/ohci-hcd.c 
obtive como retorno: 
Patching file drivers/usb/host/ohci-hcd.c 
reversed (or previously applied) Assume -R? [n]    aceitei o n ,pressionei 
<enter> 
Apply anyway ?[n]     aceitando,   <enter> obtenho: 
7 out of 7 hunks ignored -- saving rejects to file 
drivers/usb/host/ohci-hcd.c.rej 
mas, para que serviria esse arquivo ?     ( como usei --dry o arquivo não 
foi gerado ) 
e se aceito com y <enter> segue abaixo 7 FAILED e  7 out of 7 ... --saving 
... ohci-hcd.c.rej 

No diretório /usr/src/rpm/SPECS existe varios especs mas, que tipo de 
arquivo é a estensão .spec ? 
Alguem pode me ajudar com um passo a passo de como entender-se melhor com o 
patch ? 

Aguém poderia me ajudar com algum passo a passo do tipo: 
1) entre no diretório tal 
2) neste dir aplique o patch assim e deverá obter isso 
	se obter o erro x então ... 
		- 
		-	 
		- 
n) agora é só compilar o kernel, .... 

	 
Agradeço a ajuda, muito obrigado. 



--Message-Boundary-by-Mail-Sender-1137713703--

