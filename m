Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUKIBYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUKIBYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUKIBXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:23:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60169 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261334AbUKIBBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:01:16 -0500
Date: Tue, 9 Nov 2004 02:00:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [7/11] bttv-driver.c: make some variables static
Message-ID: <20041109010042.GV15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 
