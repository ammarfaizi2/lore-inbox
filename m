Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUKUQmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUKUQmD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUKUPje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:39:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42248 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261465AbUKUPgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:16 -0500
Date: Sun, 21 Nov 2004 16:36:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] asiliantfb.c: make some code static
Message-ID: <20041121153611.GQ2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below make some needlesly global code static.


diffstat output:
 drivers/video/asiliantfb.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/asiliantfb.c.old	2004-11-21 15:08:17.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/asiliantfb.c	2004-11-21 15:08:58.000000000 +0100
@@ -46,7 +46,7 @@
 #include <asm/io.h>
 
 /* Built in clock of the 69030 */
-const unsigned Fref = 14318180;
+static const unsigned Fref = 14318180;
 
 #define mmio_base (p->screen_base + 0x400000)
 
@@ -91,11 +91,6 @@
 }
 #define write_ar(num, val)	mm_write_ar(p, num, val)
 
-/*
- * Exported functions
- */
-int asiliantfb_init(void);
-
 static int asiliantfb_pci_init(struct pci_dev *dp, const struct pci_device_id *);
 static int asiliantfb_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info);
@@ -604,7 +599,7 @@
 	.remove =	__devexit_p(asiliantfb_remove),
 };
 
-int __init asiliantfb_init(void)
+static int __init asiliantfb_init(void)
 {
 	if (fb_get_options("asiliantfb", NULL))
 		return -ENODEV;

