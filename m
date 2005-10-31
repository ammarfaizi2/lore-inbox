Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVJaWvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVJaWvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVJaWvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:51:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58804 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932166AbVJaWvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:51:06 -0500
Date: Mon, 31 Oct 2005 23:50:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] suspend-to-ram: update docs
Message-ID: <20051031225047.GB1663@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds few more working systems.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -11,9 +11,9 @@ boot video card. (Kernel usually does no
 driver -- vesafb and vgacon are widely used).
 
 This is not problem for swsusp, because during swsusp resume, BIOS is
-run normally so video card is normally initialized. S3 has absolutely
-no chance of working with SMP/HT. Be sure it to turn it off before
-testing (swsusp should work ok, OTOH).
+run normally so video card is normally initialized. It should not be
+problem for S1 standby, because hardware should retain its state over
+that.
 
 There are a few types of systems where video works after S3 resume:
 
@@ -64,7 +64,7 @@ your video card (good luck getting docs 
 (proper X, knowing your hardware, not XF68_FBcon) might have better
 chance of working.
 
-Table of known working systems:
+Table of known working notebooks:
 
 Model                           hack (or "how to do it")
 ------------------------------------------------------------------------------
@@ -73,7 +73,7 @@ Acer TM 242FX			vbetool (6)
 Acer TM C110			video_post (8)
 Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6) or video_post (8)
 Acer TM 4052LCi		        s3_bios (2)
-Acer TM 636Lci			s3_bios vga=normal (2)
+Acer TM 636Lci			s3_bios,s3_mode (4)
 Acer TM 650 (Radeon M7)		vga=normal plus boot-radeon (5) gets text console back
 Acer TM 660			??? (*)
 Acer TM 800			vga=normal, X patches, see webpage (5) or vbetool (6)
@@ -137,6 +137,13 @@ Toshiba Satellite P10-554       s3_bios,
 Toshiba M30                     (2) xor X with nvidia driver using internal AGP
 Uniwill 244IIO			??? (*)
 
+Known working desktop systems
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Mainboard	    Graphics card                 hack (or "how to do it")
+------------------------------------------------------------------------------
+Asus A7V8X	    nVidia RIVA TNT2 model 64	  s3_bios,s3_mode (4)
+
 
 (*) from http://www.ubuntulinux.org/wiki/HoaryPMResults, not sure
     which options to use. If you know, please tell me.

-- 
Thanks, Sharp!
