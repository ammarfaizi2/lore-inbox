Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUKIA73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUKIA73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUKIA4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:56:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28169 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261330AbUKIAyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:54:00 -0500
Date: Tue, 9 Nov 2004 01:53:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [3/11] zoran_driver.c: make zoran_num_formats static
Message-ID: <20041109005327.GR15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zoran_num_formats was referenced from two other files as extern, but was 
used in none of them.


diffstat output:
 drivers/media/video/zoran_card.c   |    1 -
 drivers/media/video/zoran_device.c |    1 -
 drivers/media/video/zoran_driver.c |    2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_card.c.old	2004-11-07 17:12:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_card.c	2004-11-07 17:12:38.000000000 +0100
@@ -58,7 +58,6 @@
 #define I2C_NAME(x) (x)->name
 
 extern const struct zoran_format zoran_formats[];
-extern const int zoran_num_formats;
 
 static int card[BUZ_MAX] = { -1, -1, -1, -1 };
 module_param_array(card, int, NULL, 0);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.c.old	2004-11-07 17:11:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.c	2004-11-07 17:12:25.000000000 +0100
@@ -57,7 +57,6 @@
 		   ZR36057_ISR_JPEGRepIRQ )
 
 extern const struct zoran_format zoran_formats[];
-extern const int zoran_num_formats;
 
 extern int *zr_debug;
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_driver.c.old	2004-11-07 17:12:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_driver.c	2004-11-07 17:12:55.000000000 +0100
@@ -176,7 +176,7 @@
 			 ZORAN_FORMAT_COMPRESSED,
 	}
 };
-const int zoran_num_formats =
+static const int zoran_num_formats =
     (sizeof(zoran_formats) / sizeof(struct zoran_format));
 
 // RJ: Test only - want to test BUZ_USE_HIMEM even when CONFIG_BIGPHYS_AREA is defined

