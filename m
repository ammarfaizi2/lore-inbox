Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVGIAjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVGIAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVGIAgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:36:45 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:51127 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263023AbVGIAew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:34:52 -0400
Message-ID: <42CF1BAA.2070304@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:34:50 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 1/14 2.6.13-rc2-mm1] V4L BTTV input
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010705000406020607010906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010705000406020607010906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010705000406020607010906
Content-Type: text/x-patch;
 name="v4l_bttv-input.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_bttv-input.diff"

Changes to comply with CodingStyle: // comments converted to /* */

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/ir-kbd-i2c.c |   51 ++++++++++---------------
 1 files changed, 21 insertions(+), 30 deletions(-)

diff -u linux-2.6.13/drivers/media/video/ir-kbd-i2c.c linux/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.13/drivers/media/video/ir-kbd-i2c.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/ir-kbd-i2c.c	2005-07-07 17:49:46.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-kbd-i2c.c,v 1.10 2004/12/09 12:51:35 kraxel Exp $
+ * $Id: ir-kbd-i2c.c,v 1.11 2005/07/07 16:42:11 mchehab Exp $
  *
  * keyboard input driver for i2c IR remote controls
  *
@@ -66,26 +66,26 @@
 	[ 29 ] = KEY_PAGEDOWN,
 	[ 19 ] = KEY_SOUND,
 
-	[ 24 ] = KEY_KPPLUSMINUS,	// CH +/-
-	[ 22 ] = KEY_SUBTITLE,		// CC
-	[ 13 ] = KEY_TEXT,		// TTX
-	[ 11 ] = KEY_TV,		// AIR/CBL
-	[ 17 ] = KEY_PC,		// PC/TV
-	[ 23 ] = KEY_OK,		// CH RTN
-	[ 25 ] = KEY_MODE, 		// FUNC
-	[ 12 ] = KEY_SEARCH, 		// AUTOSCAN
+	[ 24 ] = KEY_KPPLUSMINUS,	/* CH +/- */
+	[ 22 ] = KEY_SUBTITLE,		/* CC */
+	[ 13 ] = KEY_TEXT,		/* TTX */
+	[ 11 ] = KEY_TV,		/* AIR/CBL */
+	[ 17 ] = KEY_PC,		/* PC/TV */
+	[ 23 ] = KEY_OK,		/* CH RTN */
+	[ 25 ] = KEY_MODE, 		/* FUNC */
+	[ 12 ] = KEY_SEARCH, 		/* AUTOSCAN */
 
 	/* Not sure what to do with these ones! */
-	[ 15 ] = KEY_SELECT, 		// SOURCE
-	[ 10 ] = KEY_KPPLUS,		// +100
-	[ 20 ] = KEY_KPEQUAL,		// SYNC
-	[ 28 ] = KEY_MEDIA,             // PC/TV
+	[ 15 ] = KEY_SELECT, 		/* SOURCE */
+	[ 10 ] = KEY_KPPLUS,		/* +100 */
+	[ 20 ] = KEY_KPEQUAL,		/* SYNC */
+	[ 28 ] = KEY_MEDIA,             /* PC/TV */
 };
 
 static IR_KEYTAB_TYPE ir_codes_purpletv[IR_KEYTAB_SIZE] = {
 	[ 0x3  ] = KEY_POWER,
 	[ 0x6f ] = KEY_MUTE,
-	[ 0x10 ] = KEY_BACKSPACE,	// Recall
+	[ 0x10 ] = KEY_BACKSPACE,	/* Recall */
 
 	[ 0x11 ] = KEY_KP0,
 	[ 0x4  ] = KEY_KP1,
@@ -97,7 +97,7 @@
 	[ 0xc  ] = KEY_KP7,
 	[ 0xd  ] = KEY_KP8,
 	[ 0xe  ] = KEY_KP9,
-	[ 0x12 ] = KEY_KPDOT,		// 100+
+	[ 0x12 ] = KEY_KPDOT,		/* 100+ */
 
 	[ 0x7  ] = KEY_VOLUMEUP,
 	[ 0xb  ] = KEY_VOLUMEDOWN,
@@ -109,25 +109,16 @@
 	[ 0x13 ] = KEY_CHANNELDOWN,
 	[ 0x48 ] = KEY_ZOOM,
 
-	[ 0x1b ] = KEY_VIDEO,		// Video source
-#if 0
-	[ 0x1f ] = KEY_S,       	// Snapshot
-#endif
-	[ 0x49 ] = KEY_LANGUAGE,	// MTS Select
-	[ 0x19 ] = KEY_SEARCH,		// Auto Scan
+	[ 0x1b ] = KEY_VIDEO,		/* Video source */
+	[ 0x49 ] = KEY_LANGUAGE,	/* MTS Select */
+	[ 0x19 ] = KEY_SEARCH,		/* Auto Scan */
 
 	[ 0x4b ] = KEY_RECORD,
 	[ 0x46 ] = KEY_PLAY,
-	[ 0x45 ] = KEY_PAUSE,   	// Pause
+	[ 0x45 ] = KEY_PAUSE,   	/* Pause */
 	[ 0x44 ] = KEY_STOP,
-#if 0
-	[ 0x43 ] = KEY_T,    		// Time Shift
-	[ 0x47 ] = KEY_Y,    		// Time Shift OFF
-	[ 0x4a ] = KEY_O,    		// TOP
-	[ 0x17 ] = KEY_F,    		// SURF CH
-#endif
-	[ 0x40 ] = KEY_FORWARD,   	// Forward ?
-	[ 0x42 ] = KEY_REWIND,   	// Backward ?
+	[ 0x40 ] = KEY_FORWARD,   	/* Forward ? */
+	[ 0x42 ] = KEY_REWIND,   	/* Backward ? */
 
 };
 

--------------010705000406020607010906--
