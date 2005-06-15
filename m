Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVFOEDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVFOEDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 00:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFOEDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 00:03:34 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:57764 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261483AbVFOEDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 00:03:16 -0400
Date: Tue, 14 Jun 2005 23:03:07 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: jdl@freescale.com, linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: remove some unnecessary includes of prom.h
Message-ID: <Pine.LNX.4.61.0506142302180.3023@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fight the Good Fight: Limit prom.h header creep.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 4d829d08c1ae5ca5322435c71ffc45bc77917522
tree 0eeda2c7a188898bc484e3bb123e32e51e16cd4f
parent e970cbc91ac4e86f613e64c44010bcf76f6a2acc
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 15 Jun 2005 00:41:23 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 15 Jun 2005 00:41:23 -0500

 arch/ppc/platforms/83xx/mpc834x_sys.c        |    1 -
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    1 -
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    1 -
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c |    1 -
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    1 -
 arch/ppc/platforms/85xx/sbc8560.c            |    1 -
 arch/ppc/platforms/85xx/sbc85xx.c            |    1 -
 arch/ppc/platforms/85xx/stx_gp3.c            |    1 -
 arch/ppc/syslib/open_pic.c                   |    1 -
 arch/ppc/syslib/open_pic2.c                  |    1 -
 arch/ppc/syslib/ppc83xx_setup.c              |    1 -
 arch/ppc/syslib/ppc85xx_setup.c              |    3 ++-
 12 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -41,7 +41,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/ipic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -41,7 +41,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -41,7 +41,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
@@ -36,7 +36,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -42,7 +42,6 @@
 #include <asm/todc.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/i8259.h>
 #include <asm/bootinfo.h>
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -41,7 +41,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c
+++ b/arch/ppc/platforms/85xx/sbc85xx.c
@@ -35,7 +35,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -46,7 +46,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/open_pic.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c
+++ b/arch/ppc/syslib/open_pic.c
@@ -21,7 +21,6 @@
 #include <asm/signal.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/sections.h>
 #include <asm/open_pic.h>
 #include <asm/i8259.h>
diff --git a/arch/ppc/syslib/open_pic2.c b/arch/ppc/syslib/open_pic2.c
--- a/arch/ppc/syslib/open_pic2.c
+++ b/arch/ppc/syslib/open_pic2.c
@@ -25,7 +25,6 @@
 #include <asm/signal.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/sections.h>
 #include <asm/open_pic.h>
 #include <asm/i8259.h>
diff --git a/arch/ppc/syslib/ppc83xx_setup.c b/arch/ppc/syslib/ppc83xx_setup.c
--- a/arch/ppc/syslib/ppc83xx_setup.c
+++ b/arch/ppc/syslib/ppc83xx_setup.c
@@ -23,7 +23,6 @@
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
 
-#include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/mpc83xx.h>
 #include <asm/mmu.h>
diff --git a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -23,7 +23,6 @@
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
 
-#include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/mpc85xx.h>
 #include <asm/immap_85xx.h>
@@ -32,6 +31,8 @@
 #include <asm/kgdb.h>
 
 #include <syslib/ppc85xx_setup.h>
+
+extern void abort(void);
 
 /* Return the amount of memory */
 unsigned long __init
