Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUKIBHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUKIBHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKIBFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:05:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14858 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261335AbUKIBDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:03:52 -0500
Date: Tue, 9 Nov 2004 02:03:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [9/11] bttv-i2c.c: make two functions static
Message-ID: <20041109010317.GX15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below makes two functions in drivers/media/video/bttv-i2c.c 
without external users static.


diffstat output:
 drivers/media/video/bttv-i2c.c |    4 ++--
 drivers/media/video/bttv.h     |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv.h.old	2004-11-07 17:31:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv.h	2004-11-07 16:45:37.000000000 +0100
@@ -328,8 +307,6 @@
 /* ---------------------------------------------------------- */
 /* i2c                                                        */
 
-extern void bttv_bit_setscl(void *data, int state);
-extern void bttv_bit_setsda(void *data, int state);
 extern void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg);
 extern int bttv_I2CRead(struct bttv *btv, unsigned char addr, char *probe_for);
 extern int bttv_I2CWrite(struct bttv *btv, unsigned char addr, unsigned char b1,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-i2c.c.old	2004-11-07 16:43:56.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-i2c.c	2004-11-07 16:44:33.000000000 +0100
@@ -55,7 +55,7 @@
 /* ----------------------------------------------------------------------- */
 /* I2C functions - bitbanging adapter (software i2c)                       */
 
-void bttv_bit_setscl(void *data, int state)
+static void bttv_bit_setscl(void *data, int state)
 {
 	struct bttv *btv = (struct bttv*)data;
 
@@ -67,7 +67,7 @@
 	btread(BT848_I2C);
 }
 
-void bttv_bit_setsda(void *data, int state)
+static void bttv_bit_setsda(void *data, int state)
 {
 	struct bttv *btv = (struct bttv*)data;
 

