Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVFVVhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVFVVhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVFVVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:35:11 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:5347 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262517AbVFVV2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:28:17 -0400
Date: Wed, 22 Jun 2005 16:27:53 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, jdl@freescale.com
Subject: [PATCH] ppc32: remove some unnecessary includes of bootmem.h
Message-ID: <Pine.LNX.4.61.0506221626280.3350@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Continue the Good Fight:  Limit bootmem.h include creep.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit abb3b231caa4b32fbd41dc5d59e09754854b786f
tree ec2bfdad42d1227f3aabee400a6a6c6e277a756f
parent 0db0912993b08ae4870aa370db5e5e6f83f2c5a3
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 18:05:00 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 18:05:00 -0500

 arch/ppc/mm/44x_mmu.c          |    1 -
 arch/ppc/mm/4xx_mmu.c          |    1 -
 arch/ppc/mm/fsl_booke_mmu.c    |    1 -
 arch/ppc/platforms/chrp_pci.c  |    1 -
 arch/ppc/platforms/katana.c    |    2 +-
 arch/ppc/platforms/pmac_pci.c  |    1 -
 arch/ppc/syslib/cpm2_common.c  |    2 +-
 arch/ppc/syslib/indirect_pci.c |    1 -
 arch/ppc/syslib/mv64x60.c      |    1 -
 arch/ppc/syslib/mv64x60_win.c  |    1 -
 10 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/ppc/mm/44x_mmu.c b/arch/ppc/mm/44x_mmu.c
--- a/arch/ppc/mm/44x_mmu.c
+++ b/arch/ppc/mm/44x_mmu.c
@@ -39,7 +39,6 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
 #include <linux/highmem.h>
 
 #include <asm/pgalloc.h>
diff --git a/arch/ppc/mm/4xx_mmu.c b/arch/ppc/mm/4xx_mmu.c
--- a/arch/ppc/mm/4xx_mmu.c
+++ b/arch/ppc/mm/4xx_mmu.c
@@ -36,7 +36,6 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
 #include <linux/highmem.h>
 
 #include <asm/pgalloc.h>
diff --git a/arch/ppc/mm/fsl_booke_mmu.c b/arch/ppc/mm/fsl_booke_mmu.c
--- a/arch/ppc/mm/fsl_booke_mmu.c
+++ b/arch/ppc/mm/fsl_booke_mmu.c
@@ -41,7 +41,6 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
 #include <linux/highmem.h>
 
 #include <asm/pgalloc.h>
diff --git a/arch/ppc/platforms/chrp_pci.c b/arch/ppc/platforms/chrp_pci.c
--- a/arch/ppc/platforms/chrp_pci.c
+++ b/arch/ppc/platforms/chrp_pci.c
@@ -9,7 +9,6 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/ide.h>
-#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff --git a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
--- a/arch/ppc/platforms/katana.c
+++ b/arch/ppc/platforms/katana.c
@@ -27,12 +27,12 @@
 #include <linux/root_dev.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/bootmem.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx.h>
 #ifdef CONFIG_BOOTIMG
 #include <linux/bootimg.h>
 #endif
+#include <asm/io.h>
 #include <asm/page.h>
 #include <asm/time.h>
 #include <asm/smp.h>
diff --git a/arch/ppc/platforms/pmac_pci.c b/arch/ppc/platforms/pmac_pci.c
--- a/arch/ppc/platforms/pmac_pci.c
+++ b/arch/ppc/platforms/pmac_pci.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
diff --git a/arch/ppc/syslib/cpm2_common.c b/arch/ppc/syslib/cpm2_common.c
--- a/arch/ppc/syslib/cpm2_common.c
+++ b/arch/ppc/syslib/cpm2_common.c
@@ -21,8 +21,8 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/bootmem.h>
 #include <linux/module.h>
+#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mpc8260.h>
 #include <asm/page.h>
diff --git a/arch/ppc/syslib/indirect_pci.c b/arch/ppc/syslib/indirect_pci.c
--- a/arch/ppc/syslib/indirect_pci.c
+++ b/arch/ppc/syslib/indirect_pci.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
diff --git a/arch/ppc/syslib/mv64x60.c b/arch/ppc/syslib/mv64x60.c
--- a/arch/ppc/syslib/mv64x60.c
+++ b/arch/ppc/syslib/mv64x60.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/mv643xx.h>
 
diff --git a/arch/ppc/syslib/mv64x60_win.c b/arch/ppc/syslib/mv64x60_win.c
--- a/arch/ppc/syslib/mv64x60_win.c
+++ b/arch/ppc/syslib/mv64x60_win.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/bootmem.h>
 #include <linux/mv643xx.h>
 
 #include <asm/byteorder.h>
