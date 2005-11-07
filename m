Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVKGDR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVKGDR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVKGDRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:17:24 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:13972 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932434AbVKGDRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:19 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: [Patch 03/20] V4L(901) Added function for nxt200x to change pll
	input
Date: Mon, 07 Nov 2005 00:58:06 -0200
Message-Id: <1131333341.25215.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirk Lapray <kirk.lapray@gmail.com>

- Added function for nxt200x to change pll input

Signed-off-by: Kirk Lapray <kirk.lapray@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/cx88/cx88-dvb.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

--- hg.orig/drivers/media/video/cx88/cx88-dvb.c
+++ hg/drivers/media/video/cx88/cx88-dvb.c
@@ -296,10 +296,20 @@ static int nxt200x_set_ts_param(struct d
 	return 0;
 }
 
+static int nxt200x_set_pll_input(u8* buf, int input)
+{
+	if (input)
+		buf[3] |= 0x08;
+	else
+		buf[3] &= ~0x08;
+	return 0;
+}
+
 static struct nxt200x_config ati_hdtvwonder = {
 	.demod_address    = 0x0a,
 	.pll_address      = 0x61,
 	.pll_desc         = &dvb_pll_tuv1236d,
+	.set_pll_input    = nxt200x_set_pll_input,
 	.set_ts_params    = nxt200x_set_ts_param,
 };
 #endif


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

