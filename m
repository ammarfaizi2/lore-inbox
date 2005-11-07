Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVKGDSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVKGDSA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVKGDR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:17:58 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:43603 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932434AbVKGDRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:54 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Ricardo Cerqueira <v4l@cerqueira.org>
Subject: [Patch 12/20] V4L(914) Use less generic name for saa7134 card 79
Date: Mon, 07 Nov 2005 00:58:09 -0200
Message-Id: <1131333341.25215.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- Use less-generic name for saa7134 card #79

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-cards.c |    8 ++++----
 drivers/media/video/saa7134/saa7134-input.c |    6 +++---
 drivers/media/video/saa7134/saa7134.h       |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--- hg.orig/drivers/media/video/saa7134/saa7134-cards.c
+++ hg/drivers/media/video/saa7134/saa7134-cards.c
@@ -2452,11 +2452,11 @@ struct saa7134_board saa7134_boards[] = 
 			.gpio = 0x0200000,
 		},
 	},
-	[SAA7134_BOARD_PCTV_CARDBUS] = {
+	[SAA7134_BOARD_SEDNA_PC_TV_CARDBUS] = {
 		/* Paul Tom Zalac <pzalac@gmail.com> */
 		/* Pavel Mihaylov <bin@bash.info> */
-		.name           = "PCTV Cardbus TV/Radio (ITO25 Rev:2B)",
-				/* Sedna Cardbus TV Tuner */
+		.name           = "Sedna/MuchTV PC TV Cardbus TV/Radio (ITO25 Rev:2B)",
+				/* Sedna/MuchTV (OEM) Cardbus TV Tuner */
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_TDA8290,
 		.radio_type     = UNSET,
@@ -3067,7 +3067,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_AVACSSMARTTV:
 	case SAA7134_BOARD_GOTVIEW_7135:
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
-	case SAA7134_BOARD_PCTV_CARDBUS:
+	case SAA7134_BOARD_SEDNA_PC_TV_CARDBUS:
 		dev->has_remote = SAA7134_REMOTE_GPIO;
 		break;
 	case SAA7134_BOARD_MD5044:
--- hg.orig/drivers/media/video/saa7134/saa7134.h
+++ hg/drivers/media/video/saa7134/saa7134.h
@@ -205,7 +205,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_MONSTERTV_MOBILE 76
 #define SAA7134_BOARD_PINNACLE_PCTV_110i 77
 #define SAA7134_BOARD_ASUSTeK_P7131_DUAL 78
-#define SAA7134_BOARD_PCTV_CARDBUS     79
+#define SAA7134_BOARD_SEDNA_PC_TV_CARDBUS     79
 #define SAA7134_BOARD_ASUSTEK_DIGIMATRIX_TV 80
 #define SAA7134_BOARD_PHILIPS_TIGER  81
 
--- hg.orig/drivers/media/video/saa7134/saa7134-input.c
+++ hg/drivers/media/video/saa7134/saa7134-input.c
@@ -546,7 +546,7 @@ static IR_KEYTAB_TYPE ir_codes_pinnacle[
 /* Mapping for the 28 key remote control as seen at
    http://www.sednacomputer.com/photo/cardbus-tv.jpg
    Pavel Mihaylov <bin@bash.info> */
-static IR_KEYTAB_TYPE pctv_cardbus_codes[IR_KEYTAB_SIZE] = {
+static IR_KEYTAB_TYPE pctv_sedna_codes[IR_KEYTAB_SIZE] = {
 	[    0 ] = KEY_KP0,
 	[    1 ] = KEY_KP1,
 	[    2 ] = KEY_KP2,
@@ -781,8 +781,8 @@ int saa7134_input_init1(struct saa7134_d
 		mask_keyup   = 0x004000;
 		polling      = 50; // ms
 		break;
-	case SAA7134_BOARD_PCTV_CARDBUS:
-		ir_codes     = pctv_cardbus_codes;
+	case SAA7134_BOARD_SEDNA_PC_TV_CARDBUS:
+		ir_codes     = pctv_sedna_codes;
 		mask_keycode = 0x001f00;
 		mask_keyup   = 0x004000;
 		polling      = 50; // ms


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

