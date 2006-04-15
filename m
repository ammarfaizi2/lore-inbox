Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWDOMfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWDOMfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 08:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWDOMfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 08:35:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17166 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932504AbWDOMfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 08:35:30 -0400
Date: Sat, 15 Apr 2006 14:35:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/: remove duplicate #include's
Message-ID: <20060415123527.GG15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded duplicate #include's of the same header 
file.

In the case of fbmon.c linux/pci.h is now #include'd unconditional, but 
this should be safe.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/fbmem.c |    2 --
 drivers/video/fbmon.c |    3 +--
 drivers/video/tgafb.c |    1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/video/fbmem.c.old	2006-04-15 14:07:45.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/fbmem.c	2006-04-15 14:08:09.000000000 +0200
@@ -34,7 +34,6 @@
 #endif
 #include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/efi.h>
 
@@ -162,7 +161,6 @@
 }
 
 #ifdef CONFIG_LOGO
-#include <linux/linux_logo.h>
 
 static inline unsigned safe_shift(unsigned d, int n)
 {
--- linux-2.6.17-rc1-mm2-full/drivers/video/fbmon.c.old	2006-04-15 14:08:24.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/fbmon.c	2006-04-15 14:09:17.000000000 +0200
@@ -29,9 +29,9 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <video/edid.h>
 #ifdef CONFIG_PPC_OF
-#include <linux/pci.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
@@ -1282,7 +1282,6 @@
 }
 
 #if defined(CONFIG_FB_FIRMWARE_EDID) && defined(__i386__)
-#include <linux/pci.h>
 
 /*
  * We need to ensure that the EDID block is only returned for
--- linux-2.6.17-rc1-mm2-full/drivers/video/tgafb.c.old	2006-04-15 14:12:38.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/tgafb.c	2006-04-15 14:12:47.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/selection.h>
 #include <asm/io.h>
 #include <video/tgafb.h>
-#include <linux/selection.h>
 
 /*
  * Local functions.

