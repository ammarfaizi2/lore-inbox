Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUKIBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUKIBQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKIBJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:09:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31242 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261331AbUKIBFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:05:43 -0500
Date: Tue, 9 Nov 2004 02:05:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [10/11] zoran_device.c: make zr36057_init_vfe static
Message-ID: <20041109010511.GY15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes function zr36057_init_vfe in 
drivers/media/video/zoran_device.c which has no external users static.


diffstat output:
 drivers/media/video/zoran_device.c |    5 ++++-
 drivers/media/video/zoran_device.h |    1 -
 2 files changed, 4 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.h.old	2004-11-07 17:11:04.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.h	2004-11-07 17:11:12.000000000 +0100
@@ -79,7 +79,6 @@
 				 int set_master);
 extern void zoran_init_hardware(struct zoran *zr);
 extern void zr36057_restart(struct zoran *zr);
-extern void zr36057_init_vfe(struct zoran *zr);
 
 /* i2c */
 extern int decoder_command(struct zoran *zr,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.c.old	2004-11-07 17:11:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.c	2004-11-07 17:12:25.000000000 +0100
@@ -80,6 +79,9 @@
 MODULE_PARM_DESC(lml33dpath,
 		 "Use digital path capture mode (on LML33 cards)");
 
+static void
+zr36057_init_vfe (struct zoran *zr);
+
 /*
  * General Purpose I/O and Guest bus access
  */
@@ -1701,7 +1703,7 @@
  * initialize video front end
  */
 
-void
+static void
 zr36057_init_vfe (struct zoran *zr)
 {
 	u32 reg;

