Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUKIBHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUKIBHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUKIBEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:04:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261323AbUKIBCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:02:34 -0500
Date: Tue, 9 Nov 2004 02:02:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [8/11] saa7134-core.c: make saa7134_devcount static
Message-ID: <20041109010202.GW15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

saa7134_devcount in drivers/media/video/saa7134/saa7134-core.c currently 
has no users outside of this file.


diffstat output:
 drivers/media/video/saa7134/saa7134-core.c |    2 +-
 drivers/media/video/saa7134/saa7134.h      |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134.h.old	2004-11-07 17:04:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134.h	2004-11-07 17:04:42.000000000 +0100
@@ -446,7 +446,6 @@
 /* saa7134-core.c                                              */
 
 extern struct list_head  saa7134_devlist;
-extern unsigned int      saa7134_devcount;
 
 void saa7134_print_ioctl(char *name, unsigned int cmd);
 void saa7134_track_gpio(struct saa7134_dev *dev, char *msg);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-core.c.old	2004-11-07 17:04:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-core.c	2004-11-07 17:05:24.000000000 +0100
@@ -95,7 +95,7 @@
 MODULE_PARM_DESC(latency,"pci latency timer");
 
 struct list_head  saa7134_devlist;
-unsigned int      saa7134_devcount;
+static unsigned int      saa7134_devcount;
 
 #define dprintk(fmt, arg...)	if (core_debug) \
 	printk(KERN_DEBUG "%s/core: " fmt, dev->name , ## arg)

