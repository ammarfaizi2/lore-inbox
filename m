Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTDVSST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTDVSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:16:39 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:43016 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263330AbTDVSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:14:38 -0400
Date: Tue, 22 Apr 2003 10:51:32 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
       video4linux-list@redhat.com
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/media/video
Message-ID: <20030422155132.GA7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are three trivial patches converting the files to use C99
initializers. The patches are against the current BK.

Art Haas

===== drivers/media/video/bttv-cards.c 1.16 vs edited =====
--- 1.16/drivers/media/video/bttv-cards.c	Tue Mar 18 11:00:00 2003
+++ edited/drivers/media/video/bttv-cards.c	Wed Apr  2 07:11:12 2003
@@ -1173,7 +1173,7 @@
 	.tuner_type     = -1,
 	.pll            = PLL_28,
 	.muxsel         = { 2 },
-	gpiomask:       0
+	.gpiomask       = 0
 },{
         /* Tomasz Pyra <hellfire@sedez.iq.pl> */
         .name           = "Prolink Pixelview PV-BT878P+ (Rev.4C,8E)",
@@ -1260,7 +1260,7 @@
 },{
         .name           = "Powercolor MTV878/ MTV878R/ MTV878F",
         .video_inputs   = 3,
-        audio_inputs:   2, 
+        .audio_inputs   = 2, 
 	.tuner		= 0,
         .svhs           = 2,
         .gpiomask       = 0x1C800F,  // Bit0-2: Audio select, 8-12:remote control 14:remote valid 15:remote reset
@@ -1300,7 +1300,7 @@
 },{
         .name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
         .video_inputs   = 4,
-        audio_inputs:   3, 
+        .audio_inputs   = 3, 
         .tuner          = 0,
         .svhs           = 2,
         .gpiomask       = 7,
===== drivers/media/video/bttv-driver.c 1.27 vs edited =====
--- 1.27/drivers/media/video/bttv-driver.c	Thu Mar 13 08:26:40 2003
+++ edited/drivers/media/video/bttv-driver.c	Wed Apr  2 07:10:09 2003
@@ -2786,8 +2786,8 @@
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	type:     VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
-	          VID_TYPE_CLIPPING|VID_TYPE_SCALES,
+	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	            VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
 	.minor    = -1,
===== drivers/media/video/tvaudio.c 1.16 vs edited =====
--- 1.16/drivers/media/video/tvaudio.c	Sun Mar 23 01:17:51 2003
+++ edited/drivers/media/video/tvaudio.c	Wed Apr  2 07:11:37 2003
@@ -1319,7 +1319,7 @@
 			     PIC16C54_MISC_SND_NOTMUTE},
 		.inputmute  = PIC16C54_MISC_SND_MUTE,
 	},
-	{ name: NULL } /* EOF */
+	{ .name = NULL } /* EOF */
 };
 
 
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
