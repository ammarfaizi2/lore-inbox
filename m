Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbULPWUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbULPWUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbULPWTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:19:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56837 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262048AbULPWSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:18:13 -0500
Date: Thu, 16 Dec 2004 23:18:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [7/11] bttv-driver.c: make some variables static (fwd)
Message-ID: <20041216221807.GV12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Tue, 9 Nov 2004 02:00:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [7/11] bttv-driver.c: make some variables static

The patch below makes 3 variables in drivers/media/video/bttv-driver.c 
with no external users static.


diffstat output:
 drivers/media/video/bttv-driver.c |    6 +++---
 drivers/media/video/bttvp.h       |    3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>


--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h.old	2004-11-07 16:34:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h	2004-11-07 16:47:42.000000000 +0100
@@ -89,7 +89,6 @@
 	int   sram;
 };
 extern const struct bttv_tvnorm bttv_tvnorms[];
-extern const unsigned int BTTV_TVNORMS;
 
 struct bttv_format {
 	char *name;
@@ -101,8 +100,6 @@
 	int  flags;
 	int  hshift,vshift;   /* for planar modes   */
 };
-extern const struct bttv_format bttv_formats[];
-extern const unsigned int BTTV_FORMATS;
 
 /* ---------------------------------------------------------- */
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c.old	2004-11-07 16:40:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c	2004-11-07 16:41:55.000000000 +0100
@@ -321,12 +321,12 @@
 		.sram           = -1,
 	}
 };
-const unsigned int BTTV_TVNORMS = ARRAY_SIZE(bttv_tvnorms);
+static const unsigned int BTTV_TVNORMS = ARRAY_SIZE(bttv_tvnorms);
 
 /* ----------------------------------------------------------------------- */
 /* bttv format list
    packed pixel formats must come first */
-const struct bttv_format bttv_formats[] = {
+static const struct bttv_format bttv_formats[] = {
 	{
 		.name     = "8 bpp, gray",
 		.palette  = VIDEO_PALETTE_GREY,
@@ -478,7 +478,7 @@
 		.flags    = FORMAT_FLAGS_RAW,
 	}
 };
-const unsigned int BTTV_FORMATS = ARRAY_SIZE(bttv_formats);
+static const unsigned int BTTV_FORMATS = ARRAY_SIZE(bttv_formats);
 
 /* ----------------------------------------------------------------------- */
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

