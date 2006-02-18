Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWBRO5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWBRO5g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWBRO5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:57:36 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:39361 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751310AbWBRO5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:57:35 -0500
Date: Sat, 18 Feb 2006 15:57:32 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Bastian Blank <bastian@waldi.eu.org>,
       Arthur Othieno <apgo@patchbomb.org>, Jean Delvare <khali@linux-fr.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH/RFC] remove duplicate #includes, take II, A
Message-ID: <20060218145732.GB32618@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Bastian Blank <bastian@waldi.eu.org>,
	Arthur Othieno <apgo@patchbomb.org>,
	Jean Delvare <khali@linux-fr.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20060218145525.GA32618@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218145525.GA32618@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


probably correct hunks

---

diff -NurpP linux-2.6.16-rc4/arch/alpha/kernel/setup.c linux-2.6.16-rc4-rmd/arch/alpha/kernel/setup.c
--- linux-2.6.16-rc4/arch/alpha/kernel/setup.c	2005-06-22 02:37:51 +0200
+++ linux-2.6.16-rc4-rmd/arch/alpha/kernel/setup.c	2006-02-18 15:30:08 +0100
@@ -55,7 +55,6 @@ static struct notifier_block alpha_panic
 #include <asm/system.h>
 #include <asm/hwrpb.h>
 #include <asm/dma.h>
-#include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/console.h>
 
diff -NurpP linux-2.6.16-rc4/arch/arm26/kernel/armksyms.c linux-2.6.16-rc4-rmd/arch/arm26/kernel/armksyms.c
--- linux-2.6.16-rc4/arch/arm26/kernel/armksyms.c	2006-02-18 14:39:41 +0100
+++ linux-2.6.16-rc4-rmd/arch/arm26/kernel/armksyms.c	2006-02-18 15:30:15 +0100
@@ -9,7 +9,6 @@
  */
 #include <linux/module.h>
 #include <linux/config.h>
-#include <linux/module.h>
 #include <linux/user.h>
 #include <linux/string.h>
 #include <linux/fs.h>
diff -NurpP linux-2.6.16-rc4/arch/cris/arch-v32/mm/init.c linux-2.6.16-rc4-rmd/arch/cris/arch-v32/mm/init.c
--- linux-2.6.16-rc4/arch/cris/arch-v32/mm/init.c	2005-08-29 22:24:51 +0200
+++ linux-2.6.16-rc4-rmd/arch/cris/arch-v32/mm/init.c	2006-02-18 15:30:09 +0100
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/mm.h>
-#include <linux/config.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/types.h>
diff -NurpP linux-2.6.16-rc4/arch/i386/kernel/cpuid.c linux-2.6.16-rc4-rmd/arch/i386/kernel/cpuid.c
--- linux-2.6.16-rc4/arch/i386/kernel/cpuid.c	2006-02-18 14:39:43 +0100
+++ linux-2.6.16-rc4-rmd/arch/i386/kernel/cpuid.c	2006-02-18 15:30:10 +0100
@@ -35,7 +35,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
diff -NurpP linux-2.6.16-rc4/arch/ia64/ia32/ia32priv.h linux-2.6.16-rc4-rmd/arch/ia64/ia32/ia32priv.h
--- linux-2.6.16-rc4/arch/ia64/ia32/ia32priv.h	2006-01-03 17:29:09 +0100
+++ linux-2.6.16-rc4-rmd/arch/ia64/ia32/ia32priv.h	2006-02-18 15:30:09 +0100
@@ -291,7 +291,6 @@ struct old_linux32_dirent {
 #define _ASM_IA64_ELF_H		/* Don't include elf.h */
 
 #include <linux/sched.h>
-#include <asm/processor.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff -NurpP linux-2.6.16-rc4/arch/ia64/ia32/sys_ia32.c linux-2.6.16-rc4-rmd/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.16-rc4/arch/ia64/ia32/sys_ia32.c	2006-02-18 14:39:43 +0100
+++ linux-2.6.16-rc4-rmd/arch/ia64/ia32/sys_ia32.c	2006-02-18 15:30:14 +0100
@@ -36,7 +36,6 @@
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
 #include <linux/quota.h>
-#include <linux/syscalls.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/cache.h>
diff -NurpP linux-2.6.16-rc4/arch/ia64/kernel/setup.c linux-2.6.16-rc4-rmd/arch/ia64/kernel/setup.c
--- linux-2.6.16-rc4/arch/ia64/kernel/setup.c	2006-02-18 14:39:43 +0100
+++ linux-2.6.16-rc4-rmd/arch/ia64/kernel/setup.c	2006-02-18 15:30:15 +0100
@@ -60,7 +60,6 @@
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/unistd.h>
-#include <asm/system.h>
 
 #if defined(CONFIG_SMP) && (IA64_CPU_SIZE > PAGE_SIZE)
 # error "struct cpuinfo_ia64 too big!"
diff -NurpP linux-2.6.16-rc4/arch/ia64/kernel/time.c linux-2.6.16-rc4-rmd/arch/ia64/kernel/time.c
--- linux-2.6.16-rc4/arch/ia64/kernel/time.c	2006-02-18 14:39:43 +0100
+++ linux-2.6.16-rc4-rmd/arch/ia64/kernel/time.c	2006-02-18 15:30:08 +0100
@@ -19,7 +19,6 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/efi.h>
-#include <linux/profile.h>
 #include <linux/timex.h>
 
 #include <asm/machvec.h>
diff -NurpP linux-2.6.16-rc4/arch/ia64/sn/kernel/setup.c linux-2.6.16-rc4-rmd/arch/ia64/sn/kernel/setup.c
--- linux-2.6.16-rc4/arch/ia64/sn/kernel/setup.c	2006-02-18 14:39:43 +0100
+++ linux-2.6.16-rc4-rmd/arch/ia64/sn/kernel/setup.c	2006-02-18 15:30:08 +0100
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
 #include <linux/compiler.h>
-#include <linux/sched.h>
 #include <linux/root_dev.h>
 #include <linux/nodemask.h>
 #include <linux/pm.h>
diff -NurpP linux-2.6.16-rc4/arch/m68knommu/platform/5206e/config.c linux-2.6.16-rc4-rmd/arch/m68knommu/platform/5206e/config.c
--- linux-2.6.16-rc4/arch/m68knommu/platform/5206e/config.c	2004-12-25 01:54:45 +0100
+++ linux-2.6.16-rc4-rmd/arch/m68knommu/platform/5206e/config.c	2006-02-18 15:30:15 +0100
@@ -21,7 +21,6 @@
 #include <asm/mcftimer.h>
 #include <asm/mcfsim.h>
 #include <asm/mcfdma.h>
-#include <asm/irq.h>
 
 /***************************************************************************/
 
diff -NurpP linux-2.6.16-rc4/arch/mips/kernel/signal_n32.c linux-2.6.16-rc4-rmd/arch/mips/kernel/signal_n32.c
--- linux-2.6.16-rc4/arch/mips/kernel/signal_n32.c	2006-02-18 14:39:45 +0100
+++ linux-2.6.16-rc4-rmd/arch/mips/kernel/signal_n32.c	2006-02-18 15:30:16 +0100
@@ -17,7 +17,6 @@
  */
 #include <linux/cache.h>
 #include <linux/sched.h>
-#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
diff -NurpP linux-2.6.16-rc4/arch/mips/mips-boards/sim/sim_time.c linux-2.6.16-rc4-rmd/arch/mips/mips-boards/sim/sim_time.c
--- linux-2.6.16-rc4/arch/mips/mips-boards/sim/sim_time.c	2006-01-03 17:29:12 +0100
+++ linux-2.6.16-rc4-rmd/arch/mips/mips-boards/sim/sim_time.c	2006-02-18 15:30:15 +0100
@@ -17,7 +17,6 @@
 #include <linux/timex.h>
 #include <asm/mipsregs.h>
 #include <asm/ptrace.h>
-#include <asm/hardirq.h>
 #include <asm/irq.h>
 #include <asm/div64.h>
 #include <asm/cpu.h>
diff -NurpP linux-2.6.16-rc4/arch/mips/tx4938/common/setup.c linux-2.6.16-rc4-rmd/arch/mips/tx4938/common/setup.c
--- linux-2.6.16-rc4/arch/mips/tx4938/common/setup.c	2006-01-03 17:29:12 +0100
+++ linux-2.6.16-rc4-rmd/arch/mips/tx4938/common/setup.c	2006-02-18 15:30:15 +0100
@@ -31,7 +31,6 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/time.h>
-#include <asm/time.h>
 #include <asm/tx4938/rbtx4938.h>
 
 extern void toshiba_rbtx4938_setup(void);
diff -NurpP linux-2.6.16-rc4/arch/parisc/kernel/signal.c linux-2.6.16-rc4-rmd/arch/parisc/kernel/signal.c
--- linux-2.6.16-rc4/arch/parisc/kernel/signal.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/parisc/kernel/signal.c	2006-02-18 15:30:10 +0100
@@ -35,7 +35,6 @@
 #include <asm/asm-offsets.h>
 
 #ifdef CONFIG_COMPAT
-#include <linux/compat.h>
 #include "signal32.h"
 #endif
 
diff -NurpP linux-2.6.16-rc4/arch/powerpc/kernel/btext.c linux-2.6.16-rc4-rmd/arch/powerpc/kernel/btext.c
--- linux-2.6.16-rc4/arch/powerpc/kernel/btext.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/kernel/btext.c	2006-02-18 15:30:09 +0100
@@ -12,7 +12,6 @@
 #include <asm/sections.h>
 #include <asm/prom.h>
 #include <asm/btext.h>
-#include <asm/prom.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/kernel/iommu.c linux-2.6.16-rc4-rmd/arch/powerpc/kernel/iommu.c
--- linux-2.6.16-rc4/arch/powerpc/kernel/iommu.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/kernel/iommu.c	2006-02-18 15:30:08 +0100
@@ -32,7 +32,6 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
-#include <linux/init.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <asm/prom.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/kernel/time.c linux-2.6.16-rc4-rmd/arch/powerpc/kernel/time.c
--- linux-2.6.16-rc4/arch/powerpc/kernel/time.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/kernel/time.c	2006-02-18 15:30:09 +0100
@@ -70,7 +70,6 @@
 #include <asm/iseries/it_lp_queue.h>
 #include <asm/iseries/hv_call_xm.h>
 #endif
-#include <asm/smp.h>
 
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
diff -NurpP linux-2.6.16-rc4/arch/powerpc/mm/hash_utils_64.c linux-2.6.16-rc4-rmd/arch/powerpc/mm/hash_utils_64.c
--- linux-2.6.16-rc4/arch/powerpc/mm/hash_utils_64.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/mm/hash_utils_64.c	2006-02-18 15:30:09 +0100
@@ -50,7 +50,6 @@
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
 #include <asm/cputable.h>
-#include <asm/abs_addr.h>
 #include <asm/sections.h>
 
 #ifdef DEBUG
diff -NurpP linux-2.6.16-rc4/arch/powerpc/mm/hugetlbpage.c linux-2.6.16-rc4-rmd/arch/powerpc/mm/hugetlbpage.c
--- linux-2.6.16-rc4/arch/powerpc/mm/hugetlbpage.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/mm/hugetlbpage.c	2006-02-18 15:30:15 +0100
@@ -25,7 +25,6 @@
 #include <asm/cputable.h>
 #include <asm/tlb.h>
 
-#include <linux/sysctl.h>
 
 #define NUM_LOW_AREAS	(0x100000000UL >> SID_SHIFT)
 #define NUM_HIGH_AREAS	(PGTABLE_RANGE >> HTLB_AREA_SHIFT)
diff -NurpP linux-2.6.16-rc4/arch/powerpc/mm/init_32.c linux-2.6.16-rc4-rmd/arch/powerpc/mm/init_32.c
--- linux-2.6.16-rc4/arch/powerpc/mm/init_32.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/mm/init_32.c	2006-02-18 15:30:09 +0100
@@ -43,7 +43,6 @@
 #include <asm/machdep.h>
 #include <asm/btext.h>
 #include <asm/tlb.h>
-#include <asm/prom.h>
 #include <asm/lmb.h>
 #include <asm/sections.h>
 
diff -NurpP linux-2.6.16-rc4/arch/powerpc/mm/mem.c linux-2.6.16-rc4-rmd/arch/powerpc/mm/mem.c
--- linux-2.6.16-rc4/arch/powerpc/mm/mem.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/mm/mem.c	2006-02-18 15:30:10 +0100
@@ -43,7 +43,6 @@
 #include <asm/machdep.h>
 #include <asm/btext.h>
 #include <asm/tlb.h>
-#include <asm/prom.h>
 #include <asm/lmb.h>
 #include <asm/sections.h>
 #include <asm/vdso.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/cell/iommu.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/cell/iommu.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/cell/iommu.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/cell/iommu.c	2006-02-18 15:30:15 +0100
@@ -29,7 +29,6 @@
 #include <linux/bootmem.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
-#include <linux/kernel.h>
 #include <linux/compiler.h>
 
 #include <asm/sections.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/chrp/setup.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/chrp/setup.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/chrp/setup.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/chrp/setup.c	2006-02-18 15:30:10 +0100
@@ -36,7 +36,6 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
-#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/chrp/smp.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/chrp/smp.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/chrp/smp.c	2006-01-03 17:29:13 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/chrp/smp.c	2006-02-18 15:30:15 +0100
@@ -32,7 +32,6 @@
 #include <asm/time.h>
 #include <asm/open_pic.h>
 #include <asm/machdep.h>
-#include <asm/smp.h>
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/iseries/setup.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/iseries/setup.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/iseries/setup.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/iseries/setup.c	2006-02-18 15:30:15 +0100
@@ -43,7 +43,6 @@
 #include <asm/time.h>
 #include <asm/paca.h>
 #include <asm/cache.h>
-#include <asm/sections.h>
 #include <asm/abs_addr.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call_event.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/powermac/low_i2c.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/powermac/low_i2c.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/powermac/low_i2c.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/powermac/low_i2c.c	2006-02-18 15:30:08 +0100
@@ -41,7 +41,6 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/completion.h>
 #include <linux/timer.h>
 #include <asm/keylargo.h>
 #include <asm/uninorth.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/powermac/udbg_adb.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/powermac/udbg_adb.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/powermac/udbg_adb.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/powermac/udbg_adb.c	2006-02-18 15:30:10 +0100
@@ -13,7 +13,6 @@
 #include <asm/xmon.h>
 #include <asm/prom.h>
 #include <asm/bootx.h>
-#include <asm/machdep.h>
 #include <asm/errno.h>
 #include <asm/pmac_feature.h>
 #include <asm/processor.h>
diff -NurpP linux-2.6.16-rc4/arch/powerpc/platforms/pseries/lpar.c linux-2.6.16-rc4-rmd/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.16-rc4/arch/powerpc/platforms/pseries/lpar.c	2006-02-18 14:39:46 +0100
+++ linux-2.6.16-rc4-rmd/arch/powerpc/platforms/pseries/lpar.c	2006-02-18 15:30:09 +0100
@@ -36,7 +36,6 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
-#include <asm/abs_addr.h>
 #include <asm/cputable.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
diff -NurpP linux-2.6.16-rc4/arch/ppc/platforms/85xx/stx_gp3.c linux-2.6.16-rc4-rmd/arch/ppc/platforms/85xx/stx_gp3.c
--- linux-2.6.16-rc4/arch/ppc/platforms/85xx/stx_gp3.c	2006-02-18 14:39:47 +0100
+++ linux-2.6.16-rc4-rmd/arch/ppc/platforms/85xx/stx_gp3.c	2006-02-18 15:30:08 +0100
@@ -53,7 +53,6 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/cpm2.h>
-#include <asm/mpc85xx.h>
 #include <asm/ppc_sys.h>
 
 #include <syslib/cpm2_pic.h>
diff -NurpP linux-2.6.16-rc4/arch/ppc/platforms/chrp_setup.c linux-2.6.16-rc4-rmd/arch/ppc/platforms/chrp_setup.c
--- linux-2.6.16-rc4/arch/ppc/platforms/chrp_setup.c	2006-02-18 14:39:47 +0100
+++ linux-2.6.16-rc4-rmd/arch/ppc/platforms/chrp_setup.c	2006-02-18 15:30:15 +0100
@@ -36,7 +36,6 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
-#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff -NurpP linux-2.6.16-rc4/arch/ppc/syslib/gt64260_pic.c linux-2.6.16-rc4-rmd/arch/ppc/syslib/gt64260_pic.c
--- linux-2.6.16-rc4/arch/ppc/syslib/gt64260_pic.c	2006-01-03 17:29:14 +0100
+++ linux-2.6.16-rc4-rmd/arch/ppc/syslib/gt64260_pic.c	2006-02-18 15:30:14 +0100
@@ -37,7 +37,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 
diff -NurpP linux-2.6.16-rc4/arch/ppc/syslib/mpc52xx_pic.c linux-2.6.16-rc4-rmd/arch/ppc/syslib/mpc52xx_pic.c
--- linux-2.6.16-rc4/arch/ppc/syslib/mpc52xx_pic.c	2005-06-22 02:37:57 +0200
+++ linux-2.6.16-rc4-rmd/arch/ppc/syslib/mpc52xx_pic.c	2006-02-18 15:30:14 +0100
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 
diff -NurpP linux-2.6.16-rc4/arch/ppc/syslib/mv64360_pic.c linux-2.6.16-rc4-rmd/arch/ppc/syslib/mv64360_pic.c
--- linux-2.6.16-rc4/arch/ppc/syslib/mv64360_pic.c	2006-01-03 17:29:15 +0100
+++ linux-2.6.16-rc4-rmd/arch/ppc/syslib/mv64360_pic.c	2006-02-18 15:30:09 +0100
@@ -38,7 +38,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
diff -NurpP linux-2.6.16-rc4/arch/ppc/xmon/start.c linux-2.6.16-rc4-rmd/arch/ppc/xmon/start.c
--- linux-2.6.16-rc4/arch/ppc/xmon/start.c	2006-02-18 14:39:47 +0100
+++ linux-2.6.16-rc4-rmd/arch/ppc/xmon/start.c	2006-02-18 15:30:09 +0100
@@ -16,7 +16,6 @@
 #include <asm/xmon.h>
 #include <asm/prom.h>
 #include <asm/bootx.h>
-#include <asm/machdep.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
diff -NurpP linux-2.6.16-rc4/arch/sh/kernel/sh_ksyms.c linux-2.6.16-rc4-rmd/arch/sh/kernel/sh_ksyms.c
--- linux-2.6.16-rc4/arch/sh/kernel/sh_ksyms.c	2006-02-18 14:39:48 +0100
+++ linux-2.6.16-rc4-rmd/arch/sh/kernel/sh_ksyms.c	2006-02-18 15:30:08 +0100
@@ -19,7 +19,6 @@
 #include <asm/delay.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
 
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 extern struct hw_interrupt_type no_irq_type;
diff -NurpP linux-2.6.16-rc4/arch/sh/kernel/smp.c linux-2.6.16-rc4-rmd/arch/sh/kernel/smp.c
--- linux-2.6.16-rc4/arch/sh/kernel/smp.c	2006-02-18 14:39:48 +0100
+++ linux-2.6.16-rc4-rmd/arch/sh/kernel/smp.c	2006-02-18 15:30:14 +0100
@@ -22,7 +22,6 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
-#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/processor.h>
diff -NurpP linux-2.6.16-rc4/arch/sh64/kernel/signal.c linux-2.6.16-rc4-rmd/arch/sh64/kernel/signal.c
--- linux-2.6.16-rc4/arch/sh64/kernel/signal.c	2005-10-28 20:49:15 +0200
+++ linux-2.6.16-rc4-rmd/arch/sh64/kernel/signal.c	2006-02-18 15:30:09 +0100
@@ -26,7 +26,6 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/personality.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -NurpP linux-2.6.16-rc4/arch/sh64/kernel/traps.c linux-2.6.16-rc4-rmd/arch/sh64/kernel/traps.c
--- linux-2.6.16-rc4/arch/sh64/kernel/traps.c	2005-06-22 02:37:59 +0200
+++ linux-2.6.16-rc4-rmd/arch/sh64/kernel/traps.c	2006-02-18 15:30:09 +0100
@@ -244,7 +244,6 @@ DO_ERROR(12, SIGILL,  "reserved instruct
 #endif /* CONFIG_SH64_ID2815_WORKAROUND */
 
 
-#include <asm/system.h>
 
 /* Called with interrupts disabled */
 asmlinkage void do_exception_error(unsigned long ex, struct pt_regs *regs)
diff -NurpP linux-2.6.16-rc4/arch/sparc/kernel/irq.c linux-2.6.16-rc4-rmd/arch/sparc/kernel/irq.c
--- linux-2.6.16-rc4/arch/sparc/kernel/irq.c	2005-03-02 12:38:25 +0100
+++ linux-2.6.16-rc4-rmd/arch/sparc/kernel/irq.c	2006-02-18 15:30:08 +0100
@@ -19,7 +19,6 @@
 #include <linux/linkage.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/random.h>
diff -NurpP linux-2.6.16-rc4/arch/sparc64/kernel/module.c linux-2.6.16-rc4-rmd/arch/sparc64/kernel/module.c
--- linux-2.6.16-rc4/arch/sparc64/kernel/module.c	2005-06-22 02:38:00 +0200
+++ linux-2.6.16-rc4-rmd/arch/sparc64/kernel/module.c	2006-02-18 15:30:15 +0100
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/mm.h>
 
 #include <asm/processor.h>
diff -NurpP linux-2.6.16-rc4/arch/sparc64/kernel/process.c linux-2.6.16-rc4-rmd/arch/sparc64/kernel/process.c
--- linux-2.6.16-rc4/arch/sparc64/kernel/process.c	2006-02-18 14:39:49 +0100
+++ linux-2.6.16-rc4-rmd/arch/sparc64/kernel/process.c	2006-02-18 15:30:14 +0100
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/compat.h>
diff -NurpP linux-2.6.16-rc4/arch/sparc64/kernel/sys_sparc32.c linux-2.6.16-rc4-rmd/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.6.16-rc4/arch/sparc64/kernel/sys_sparc32.c	2006-02-18 14:39:49 +0100
+++ linux-2.6.16-rc4-rmd/arch/sparc64/kernel/sys_sparc32.c	2006-02-18 15:30:09 +0100
@@ -54,7 +54,6 @@
 #include <linux/vfs.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/ptrace.h>
-#include <linux/highuid.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
diff -NurpP linux-2.6.16-rc4/arch/sparc64/kernel/sys_sunos32.c linux-2.6.16-rc4-rmd/arch/sparc64/kernel/sys_sunos32.c
--- linux-2.6.16-rc4/arch/sparc64/kernel/sys_sunos32.c	2006-02-18 14:39:49 +0100
+++ linux-2.6.16-rc4-rmd/arch/sparc64/kernel/sys_sunos32.c	2006-02-18 15:30:08 +0100
@@ -56,7 +56,6 @@
 #include <linux/personality.h>
 
 /* For SOCKET_I */
-#include <linux/socket.h>
 #include <net/sock.h>
 #include <net/compat.h>
 
diff -NurpP linux-2.6.16-rc4/arch/sparc64/kernel/time.c linux-2.6.16-rc4-rmd/arch/sparc64/kernel/time.c
--- linux-2.6.16-rc4/arch/sparc64/kernel/time.c	2006-02-18 14:39:49 +0100
+++ linux-2.6.16-rc4-rmd/arch/sparc64/kernel/time.c	2006-02-18 15:30:08 +0100
@@ -29,7 +29,6 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
-#include <linux/profile.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
diff -NurpP linux-2.6.16-rc4/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.16-rc4-rmd/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.16-rc4/arch/x86_64/kernel/x8664_ksyms.c	2006-02-18 14:39:50 +0100
+++ linux-2.6.16-rc4-rmd/arch/x86_64/kernel/x8664_ksyms.c	2006-02-18 15:30:09 +0100
@@ -30,7 +30,6 @@
 #include <asm/kdebug.h>
 #include <asm/unistd.h>
 #include <asm/tlbflush.h>
-#include <asm/kdebug.h>
 
 extern spinlock_t rtc_lock;
 
diff -NurpP linux-2.6.16-rc4/arch/xtensa/kernel/align.S linux-2.6.16-rc4-rmd/arch/xtensa/kernel/align.S
--- linux-2.6.16-rc4/arch/xtensa/kernel/align.S	2005-10-28 20:49:18 +0200
+++ linux-2.6.16-rc4-rmd/arch/xtensa/kernel/align.S	2006-02-18 15:30:16 +0100
@@ -17,7 +17,6 @@
 
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
-#include <asm/ptrace.h>
 #include <asm/current.h>
 #include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
diff -NurpP linux-2.6.16-rc4/arch/xtensa/kernel/asm-offsets.c linux-2.6.16-rc4-rmd/arch/xtensa/kernel/asm-offsets.c
--- linux-2.6.16-rc4/arch/xtensa/kernel/asm-offsets.c	2005-08-29 22:24:57 +0200
+++ linux-2.6.16-rc4-rmd/arch/xtensa/kernel/asm-offsets.c	2006-02-18 15:30:15 +0100
@@ -19,7 +19,6 @@
 #include <linux/thread_info.h>
 #include <linux/ptrace.h>
 #include <asm/ptrace.h>
-#include <asm/processor.h>
 #include <asm/uaccess.h>
 
 #define DEFINE(sym, val) asm volatile("\n->" #sym " %0 " #val : : "i" (val))
diff -NurpP linux-2.6.16-rc4/arch/xtensa/kernel/vectors.S linux-2.6.16-rc4-rmd/arch/xtensa/kernel/vectors.S
--- linux-2.6.16-rc4/arch/xtensa/kernel/vectors.S	2005-10-28 20:49:18 +0200
+++ linux-2.6.16-rc4-rmd/arch/xtensa/kernel/vectors.S	2006-02-18 15:30:08 +0100
@@ -44,7 +44,6 @@
 
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
-#include <asm/ptrace.h>
 #include <asm/current.h>
 #include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
diff -NurpP linux-2.6.16-rc4/arch/xtensa/mm/init.c linux-2.6.16-rc4-rmd/arch/xtensa/mm/init.c
--- linux-2.6.16-rc4/arch/xtensa/mm/init.c	2005-10-28 20:49:18 +0200
+++ linux-2.6.16-rc4-rmd/arch/xtensa/mm/init.c	2006-02-18 15:30:09 +0100
@@ -34,7 +34,6 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
-#include <asm/pgtable.h>
 
 
 #define DEBUG 0
diff -NurpP linux-2.6.16-rc4/arch/xtensa/platform-iss/console.c linux-2.6.16-rc4-rmd/arch/xtensa/platform-iss/console.c
--- linux-2.6.16-rc4/arch/xtensa/platform-iss/console.c	2006-02-18 14:39:50 +0100
+++ linux-2.6.16-rc4-rmd/arch/xtensa/platform-iss/console.c	2006-02-18 15:30:15 +0100
@@ -21,7 +21,6 @@
 #include <linux/param.h>
 #include <linux/serial.h>
 #include <linux/serialP.h>
-#include <linux/console.h>
 
 #include <asm/uaccess.h>
 #include <asm/irq.h>
diff -NurpP linux-2.6.16-rc4/arch/xtensa/platform-iss/network.c linux-2.6.16-rc4-rmd/arch/xtensa/platform-iss/network.c
--- linux-2.6.16-rc4/arch/xtensa/platform-iss/network.c	2006-01-03 17:29:20 +0100
+++ linux-2.6.16-rc4-rmd/arch/xtensa/platform-iss/network.c	2006-02-18 15:30:09 +0100
@@ -32,7 +32,6 @@
 #include <linux/bootmem.h>
 #include <linux/ethtool.h>
 #include <linux/rtnetlink.h>
-#include <linux/timer.h>
 #include <linux/platform_device.h>
 
 #include <xtensa/simcall.h>
diff -NurpP linux-2.6.16-rc4/drivers/atm/lanai.c linux-2.6.16-rc4-rmd/drivers/atm/lanai.c
--- linux-2.6.16-rc4/drivers/atm/lanai.c	2006-01-03 17:29:21 +0100
+++ linux-2.6.16-rc4-rmd/drivers/atm/lanai.c	2006-02-18 15:30:15 +0100
@@ -65,7 +65,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
 
 /* -------------------- TUNABLE PARAMATERS: */
 
diff -NurpP linux-2.6.16-rc4/drivers/block/viodasd.c linux-2.6.16-rc4-rmd/drivers/block/viodasd.c
--- linux-2.6.16-rc4/drivers/block/viodasd.c	2006-02-18 14:39:52 +0100
+++ linux-2.6.16-rc4-rmd/drivers/block/viodasd.c	2006-02-18 15:30:09 +0100
@@ -41,7 +41,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/vio.h>
diff -NurpP linux-2.6.16-rc4/drivers/char/drm/drm_memory.h linux-2.6.16-rc4-rmd/drivers/char/drm/drm_memory.h
--- linux-2.6.16-rc4/drivers/char/drm/drm_memory.h	2006-01-03 17:29:21 +0100
+++ linux-2.6.16-rc4-rmd/drivers/char/drm/drm_memory.h	2006-02-18 15:30:15 +0100
@@ -45,7 +45,6 @@
 
 #if __OS_HAS_AGP
 
-#include <linux/vmalloc.h>
 
 #ifdef HAVE_PAGE_AGP
 #include <asm/agp.h>
diff -NurpP linux-2.6.16-rc4/drivers/char/lcd.c linux-2.6.16-rc4-rmd/drivers/char/lcd.c
--- linux-2.6.16-rc4/drivers/char/lcd.c	2006-01-03 17:29:25 +0100
+++ linux-2.6.16-rc4-rmd/drivers/char/lcd.c	2006-02-18 15:30:15 +0100
@@ -29,7 +29,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <linux/delay.h>
 
 #include "lcd.h"
 
diff -NurpP linux-2.6.16-rc4/drivers/char/ppdev.c linux-2.6.16-rc4-rmd/drivers/char/ppdev.c
--- linux-2.6.16-rc4/drivers/char/ppdev.c	2006-01-03 17:29:26 +0100
+++ linux-2.6.16-rc4-rmd/drivers/char/ppdev.c	2006-02-18 15:30:15 +0100
@@ -68,7 +68,6 @@
 #include <asm/uaccess.h>
 #include <linux/ppdev.h>
 #include <linux/smp_lock.h>
-#include <linux/device.h>
 
 #define PP_VERSION "ppdev: user-space parallel port driver"
 #define CHRDEV "ppdev"
diff -NurpP linux-2.6.16-rc4/drivers/char/synclink.c linux-2.6.16-rc4-rmd/drivers/char/synclink.c
--- linux-2.6.16-rc4/drivers/char/synclink.c	2006-02-18 14:39:54 +0100
+++ linux-2.6.16-rc4-rmd/drivers/char/synclink.c	2006-02-18 15:30:15 +0100
@@ -89,7 +89,6 @@
 #include <linux/init.h>
 #include <asm/serial.h>
 
-#include <linux/delay.h>
 #include <linux/ioctl.h>
 
 #include <asm/system.h>
diff -NurpP linux-2.6.16-rc4/drivers/input/gameport/gameport.c linux-2.6.16-rc4-rmd/drivers/input/gameport/gameport.c
--- linux-2.6.16-rc4/drivers/input/gameport/gameport.c	2006-02-18 14:39:56 +0100
+++ linux-2.6.16-rc4-rmd/drivers/input/gameport/gameport.c	2006-02-18 15:30:08 +0100
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
-#include <linux/sched.h>	/* HZ */
 
 /*#include <asm/io.h>*/
 
diff -NurpP linux-2.6.16-rc4/drivers/macintosh/therm_pm72.c linux-2.6.16-rc4-rmd/drivers/macintosh/therm_pm72.c
--- linux-2.6.16-rc4/drivers/macintosh/therm_pm72.c	2006-02-18 14:39:57 +0100
+++ linux-2.6.16-rc4-rmd/drivers/macintosh/therm_pm72.c	2006-02-18 15:30:15 +0100
@@ -112,7 +112,6 @@
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/kmod.h>
-#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
diff -NurpP linux-2.6.16-rc4/drivers/media/video/arv.c linux-2.6.16-rc4-rmd/drivers/media/video/arv.c
--- linux-2.6.16-rc4/drivers/media/video/arv.c	2006-02-18 14:39:58 +0100
+++ linux-2.6.16-rc4-rmd/drivers/media/video/arv.c	2006-02-18 15:30:09 +0100
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
diff -NurpP linux-2.6.16-rc4/drivers/mtd/chips/jedec_probe.c linux-2.6.16-rc4-rmd/drivers/mtd/chips/jedec_probe.c
--- linux-2.6.16-rc4/drivers/mtd/chips/jedec_probe.c	2006-01-03 17:29:35 +0100
+++ linux-2.6.16-rc4-rmd/drivers/mtd/chips/jedec_probe.c	2006-02-18 15:30:08 +0100
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/init.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
diff -NurpP linux-2.6.16-rc4/drivers/mtd/devices/m25p80.c linux-2.6.16-rc4-rmd/drivers/mtd/devices/m25p80.c
--- linux-2.6.16-rc4/drivers/mtd/devices/m25p80.c	2006-02-18 14:40:01 +0100
+++ linux-2.6.16-rc4-rmd/drivers/mtd/devices/m25p80.c	2006-02-18 15:30:09 +0100
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
-#include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
diff -NurpP linux-2.6.16-rc4/drivers/net/bonding/bond_sysfs.c linux-2.6.16-rc4-rmd/drivers/net/bonding/bond_sysfs.c
--- linux-2.6.16-rc4/drivers/net/bonding/bond_sysfs.c	2006-02-18 14:40:02 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/bonding/bond_sysfs.c	2006-02-18 15:30:15 +0100
@@ -33,7 +33,6 @@
 #include <linux/inetdevice.h>
 #include <linux/in.h>
 #include <linux/sysfs.h>
-#include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/inet.h>
 #include <linux/rtnetlink.h>
diff -NurpP linux-2.6.16-rc4/drivers/net/fs_enet/fs_enet-main.c linux-2.6.16-rc4-rmd/drivers/net/fs_enet/fs_enet-main.c
--- linux-2.6.16-rc4/drivers/net/fs_enet/fs_enet-main.c	2006-01-03 17:29:37 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/fs_enet/fs_enet-main.c	2006-02-18 15:30:15 +0100
@@ -42,7 +42,6 @@
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
 
-#include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
diff -NurpP linux-2.6.16-rc4/drivers/net/gianfar.h linux-2.6.16-rc4-rmd/drivers/net/gianfar.h
--- linux-2.6.16-rc4/drivers/net/gianfar.h	2006-02-18 14:40:02 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/gianfar.h	2006-02-18 15:30:08 +0100
@@ -46,7 +46,6 @@
 #include <linux/crc32.h>
 #include <linux/workqueue.h>
 #include <linux/ethtool.h>
-#include <linux/netdevice.h>
 #include <linux/fsl_devices.h>
 #include "gianfar_mii.h"
 
diff -NurpP linux-2.6.16-rc4/drivers/net/gianfar_ethtool.c linux-2.6.16-rc4-rmd/drivers/net/gianfar_ethtool.c
--- linux-2.6.16-rc4/drivers/net/gianfar_ethtool.c	2006-02-18 14:40:02 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/gianfar_ethtool.c	2006-02-18 15:30:15 +0100
@@ -36,7 +36,6 @@
 #include <linux/module.h>
 #include <linux/crc32.h>
 #include <asm/types.h>
-#include <asm/uaccess.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
diff -NurpP linux-2.6.16-rc4/drivers/net/mipsnet.c linux-2.6.16-rc4-rmd/drivers/net/mipsnet.c
--- linux-2.6.16-rc4/drivers/net/mipsnet.c	2006-01-03 17:29:40 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/mipsnet.c	2006-02-18 15:30:09 +0100
@@ -12,7 +12,6 @@
 #include <linux/netdevice.h>
 #include <linux/sched.h>
 #include <linux/etherdevice.h>
-#include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/mips-boards/simint.h>
diff -NurpP linux-2.6.16-rc4/drivers/net/mv643xx_eth.c linux-2.6.16-rc4-rmd/drivers/net/mv643xx_eth.c
--- linux-2.6.16-rc4/drivers/net/mv643xx_eth.c	2006-02-18 14:40:02 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/mv643xx_eth.c	2006-02-18 15:30:15 +0100
@@ -38,7 +38,6 @@
 #include <linux/udp.h>
 #include <linux/etherdevice.h>
 #include <linux/in.h>
-#include <linux/ip.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff -NurpP linux-2.6.16-rc4/drivers/net/via-velocity.c linux-2.6.16-rc4-rmd/drivers/net/via-velocity.c
--- linux-2.6.16-rc4/drivers/net/via-velocity.c	2006-02-18 14:40:03 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/via-velocity.c	2006-02-18 15:30:08 +0100
@@ -65,7 +65,6 @@
 #include <linux/wait.h>
 #include <asm/io.h>
 #include <linux/if.h>
-#include <linux/config.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 #include <linux/inetdevice.h>
diff -NurpP linux-2.6.16-rc4/drivers/net/wireless/ipw2200.h linux-2.6.16-rc4-rmd/drivers/net/wireless/ipw2200.h
--- linux-2.6.16-rc4/drivers/net/wireless/ipw2200.h	2006-02-18 14:40:04 +0100
+++ linux-2.6.16-rc4-rmd/drivers/net/wireless/ipw2200.h	2006-02-18 15:30:08 +0100
@@ -45,7 +45,6 @@
 
 #include <linux/firmware.h>
 #include <linux/wireless.h>
-#include <linux/dma-mapping.h>
 #include <asm/io.h>
 
 #include <net/ieee80211.h>
diff -NurpP linux-2.6.16-rc4/drivers/parisc/ccio-dma.c linux-2.6.16-rc4-rmd/drivers/parisc/ccio-dma.c
--- linux-2.6.16-rc4/drivers/parisc/ccio-dma.c	2006-02-18 14:40:04 +0100
+++ linux-2.6.16-rc4-rmd/drivers/parisc/ccio-dma.c	2006-02-18 15:30:15 +0100
@@ -75,7 +75,6 @@
 #undef CCIO_MAP_STATS
 #endif
 
-#include <linux/proc_fs.h>
 #include <asm/runway.h>		/* for proc_runway_root */
 
 #ifdef DEBUG_CCIO_INIT
diff -NurpP linux-2.6.16-rc4/drivers/scsi/NCR_D700.c linux-2.6.16-rc4-rmd/drivers/scsi/NCR_D700.c
--- linux-2.6.16-rc4/drivers/scsi/NCR_D700.c	2005-06-22 02:38:23 +0200
+++ linux-2.6.16-rc4-rmd/drivers/scsi/NCR_D700.c	2006-02-18 15:30:15 +0100
@@ -97,7 +97,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mca.h>
-#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
diff -NurpP linux-2.6.16-rc4/drivers/scsi/seagate.c linux-2.6.16-rc4-rmd/drivers/scsi/seagate.c
--- linux-2.6.16-rc4/drivers/scsi/seagate.c	2006-01-03 17:29:49 +0100
+++ linux-2.6.16-rc4-rmd/drivers/scsi/seagate.c	2006-02-18 15:30:09 +0100
@@ -97,7 +97,6 @@
 #include <linux/delay.h>
 #include <linux/blkdev.h>
 #include <linux/stat.h>
-#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
diff -NurpP linux-2.6.16-rc4/drivers/spi/spi_butterfly.c linux-2.6.16-rc4-rmd/drivers/spi/spi_butterfly.c
--- linux-2.6.16-rc4/drivers/spi/spi_butterfly.c	2006-02-18 14:40:14 +0100
+++ linux-2.6.16-rc4-rmd/drivers/spi/spi_butterfly.c	2006-02-18 15:30:08 +0100
@@ -187,7 +187,6 @@ static void butterfly_chipselect(struct 
 //#define	spidelay	ndelay
 
 #define	EXPAND_BITBANG_TXRX
-#include <linux/spi/spi_bitbang.h>
 
 static u32
 butterfly_txrx_word_mode0(struct spi_device *spi,
diff -NurpP linux-2.6.16-rc4/drivers/video/fbmem.c linux-2.6.16-rc4-rmd/drivers/video/fbmem.c
--- linux-2.6.16-rc4/drivers/video/fbmem.c	2006-02-18 14:40:20 +0100
+++ linux-2.6.16-rc4-rmd/drivers/video/fbmem.c	2006-02-18 15:30:08 +0100
@@ -34,7 +34,6 @@
 #endif
 #include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/efi.h>
 
diff -NurpP linux-2.6.16-rc4/drivers/video/tgafb.c linux-2.6.16-rc4-rmd/drivers/video/tgafb.c
--- linux-2.6.16-rc4/drivers/video/tgafb.c	2006-01-03 17:29:55 +0100
+++ linux-2.6.16-rc4-rmd/drivers/video/tgafb.c	2006-02-18 15:30:09 +0100
@@ -26,7 +26,6 @@
 #include <linux/selection.h>
 #include <asm/io.h>
 #include <video/tgafb.h>
-#include <linux/selection.h>
 
 /*
  * Local functions.
diff -NurpP linux-2.6.16-rc4/drivers/w1/matrox_w1.c linux-2.6.16-rc4-rmd/drivers/w1/matrox_w1.c
--- linux-2.6.16-rc4/drivers/w1/matrox_w1.c	2005-08-29 22:25:30 +0200
+++ linux-2.6.16-rc4-rmd/drivers/w1/matrox_w1.c	2006-02-18 15:30:15 +0100
@@ -33,7 +33,6 @@
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
-#include <linux/timer.h>
 
 #include "w1.h"
 #include "w1_int.h"
diff -NurpP linux-2.6.16-rc4/fs/compat_ioctl.c linux-2.6.16-rc4-rmd/fs/compat_ioctl.c
--- linux-2.6.16-rc4/fs/compat_ioctl.c	2006-02-18 14:40:21 +0100
+++ linux-2.6.16-rc4-rmd/fs/compat_ioctl.c	2006-02-18 15:30:10 +0100
@@ -122,7 +122,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/dvb/frontend.h>
 #include <linux/dvb/video.h>
-#include <linux/lp.h>
 
 /* Aiee. Someone does not find a difference between int and long */
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
diff -NurpP linux-2.6.16-rc4/fs/namei.c linux-2.6.16-rc4-rmd/fs/namei.c
--- linux-2.6.16-rc4/fs/namei.c	2006-02-18 14:40:22 +0100
+++ linux-2.6.16-rc4-rmd/fs/namei.c	2006-02-18 15:30:15 +0100
@@ -31,7 +31,6 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fcntl.h>
-#include <linux/namei.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
diff -NurpP linux-2.6.16-rc4/include/asm-alpha/core_cia.h linux-2.6.16-rc4-rmd/include/asm-alpha/core_cia.h
--- linux-2.6.16-rc4/include/asm-alpha/core_cia.h	2004-12-25 01:55:22 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-alpha/core_cia.h	2006-02-18 15:30:15 +0100
@@ -482,7 +482,6 @@ __EXTERN_INLINE int cia_bwx_is_mmio(cons
 #define cia_bwx_trivial_io_bw	1
 #define cia_bwx_trivial_io_lq	1
 #define cia_bwx_trivial_iounmap	1
-#include <asm/io_trivial.h>
 
 #undef __IO_PREFIX
 #ifdef CONFIG_ALPHA_PYXIS
diff -NurpP linux-2.6.16-rc4/include/asm-ia64/pgtable.h linux-2.6.16-rc4-rmd/include/asm-ia64/pgtable.h
--- linux-2.6.16-rc4/include/asm-ia64/pgtable.h	2006-01-03 17:30:05 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-ia64/pgtable.h	2006-02-18 15:30:15 +0100
@@ -154,7 +154,6 @@
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
-#include <asm/processor.h>
 
 /*
  * Next come the mappings that determine how mmap() protection bits
diff -NurpP linux-2.6.16-rc4/include/asm-mips/tx4938/tx4938.h linux-2.6.16-rc4-rmd/include/asm-mips/tx4938/tx4938.h
--- linux-2.6.16-rc4/include/asm-mips/tx4938/tx4938.h	2006-01-03 17:30:06 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-mips/tx4938/tx4938.h	2006-02-18 15:30:16 +0100
@@ -81,7 +81,6 @@
 #else
 #define _CONST64(c)	c##ull
 
-#include <asm/byteorder.h>
 
 #ifdef __BIG_ENDIAN
 #define endian_def_l2(e1,e2)	\
diff -NurpP linux-2.6.16-rc4/include/asm-ppc/page.h linux-2.6.16-rc4-rmd/include/asm-ppc/page.h
--- linux-2.6.16-rc4/include/asm-ppc/page.h	2006-01-03 17:30:07 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-ppc/page.h	2006-02-18 15:30:15 +0100
@@ -15,7 +15,6 @@
 #define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
 #ifdef __KERNEL__
-#include <linux/config.h>
 
 /* This must match what is in arch/ppc/Makefile */
 #define PAGE_OFFSET	CONFIG_KERNEL_START
diff -NurpP linux-2.6.16-rc4/include/asm-sparc/system.h linux-2.6.16-rc4-rmd/include/asm-sparc/system.h
--- linux-2.6.16-rc4/include/asm-sparc/system.h	2006-02-18 14:40:31 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-sparc/system.h	2006-02-18 15:30:16 +0100
@@ -4,7 +4,6 @@
 #ifndef __SPARC_SYSTEM_H
 #define __SPARC_SYSTEM_H
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>	/* NR_CPUS */
 #include <linux/thread_info.h>
diff -NurpP linux-2.6.16-rc4/include/asm-x86_64/unistd.h linux-2.6.16-rc4-rmd/include/asm-x86_64/unistd.h
--- linux-2.6.16-rc4/include/asm-x86_64/unistd.h	2006-02-18 14:40:32 +0100
+++ linux-2.6.16-rc4-rmd/include/asm-x86_64/unistd.h	2006-02-18 15:30:08 +0100
@@ -814,7 +814,6 @@ asmlinkage long sys_pipe(int *fildes);
 #include <linux/linkage.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/ptrace.h>
 
 asmlinkage long sys_iopl(unsigned int level, struct pt_regs *regs);
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
diff -NurpP linux-2.6.16-rc4/include/linux/atalk.h linux-2.6.16-rc4-rmd/include/linux/atalk.h
--- linux-2.6.16-rc4/include/linux/atalk.h	2006-02-18 14:40:32 +0100
+++ linux-2.6.16-rc4-rmd/include/linux/atalk.h	2006-02-18 15:30:15 +0100
@@ -85,7 +85,6 @@ static inline struct atalk_sock *at_sk(s
 	return (struct atalk_sock *)sk;
 }
 
-#include <asm/byteorder.h>
 
 struct ddpehdr {
 #ifdef __LITTLE_ENDIAN_BITFIELD
diff -NurpP linux-2.6.16-rc4/include/linux/memory_hotplug.h linux-2.6.16-rc4-rmd/include/linux/memory_hotplug.h
--- linux-2.6.16-rc4/include/linux/memory_hotplug.h	2006-01-03 17:30:09 +0100
+++ linux-2.6.16-rc4-rmd/include/linux/memory_hotplug.h	2006-02-18 15:30:08 +0100
@@ -3,7 +3,6 @@
 
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
-#include <linux/mmzone.h>
 #include <linux/notifier.h>
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff -NurpP linux-2.6.16-rc4/include/linux/nfs_fs.h linux-2.6.16-rc4-rmd/include/linux/nfs_fs.h
--- linux-2.6.16-rc4/include/linux/nfs_fs.h	2006-02-18 14:40:35 +0100
+++ linux-2.6.16-rc4-rmd/include/linux/nfs_fs.h	2006-02-18 15:30:15 +0100
@@ -27,7 +27,6 @@
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_xdr.h>
-#include <linux/rwsem.h>
 #include <linux/mempool.h>
 
 /*
diff -NurpP linux-2.6.16-rc4/include/net/ieee80211.h linux-2.6.16-rc4-rmd/include/net/ieee80211.h
--- linux-2.6.16-rc4/include/net/ieee80211.h	2006-02-18 14:40:36 +0100
+++ linux-2.6.16-rc4-rmd/include/net/ieee80211.h	2006-02-18 15:30:09 +0100
@@ -177,7 +177,6 @@ const char *escape_essid(const char *ess
 #define IEEE80211_DEBUG_RX(f, a...)  IEEE80211_DEBUG(IEEE80211_DL_RX, f, ## a)
 #define IEEE80211_DEBUG_QOS(f, a...)  IEEE80211_DEBUG(IEEE80211_DL_QOS, f, ## a)
 #include <linux/netdevice.h>
-#include <linux/wireless.h>
 #include <linux/if_arp.h>	/* ARPHRD_ETHER */
 
 #ifndef WIRELESS_SPY
diff -NurpP linux-2.6.16-rc4/kernel/kexec.c linux-2.6.16-rc4-rmd/kernel/kexec.c
--- linux-2.6.16-rc4/kernel/kexec.c	2006-02-18 14:40:37 +0100
+++ linux-2.6.16-rc4-rmd/kernel/kexec.c	2006-02-18 15:30:08 +0100
@@ -17,7 +17,6 @@
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
-#include <linux/syscalls.h>
 #include <linux/ioport.h>
 #include <linux/hardirq.h>
 
diff -NurpP linux-2.6.16-rc4/kernel/profile.c linux-2.6.16-rc4-rmd/kernel/profile.c
--- linux-2.6.16-rc4/kernel/profile.c	2005-08-29 22:25:43 +0200
+++ linux-2.6.16-rc4-rmd/kernel/profile.c	2006-02-18 15:30:15 +0100
@@ -21,7 +21,6 @@
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
-#include <linux/profile.h>
 #include <linux/highmem.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
diff -NurpP linux-2.6.16-rc4/kernel/rcupdate.c linux-2.6.16-rc4-rmd/kernel/rcupdate.c
--- linux-2.6.16-rc4/kernel/rcupdate.c	2006-02-18 14:40:37 +0100
+++ linux-2.6.16-rc4-rmd/kernel/rcupdate.c	2006-02-18 15:30:15 +0100
@@ -45,7 +45,6 @@
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
-#include <linux/rcupdate.h>
 #include <linux/cpu.h>
 
 /* Definition for rcupdate control block. */
diff -NurpP linux-2.6.16-rc4/kernel/rcutorture.c linux-2.6.16-rc4-rmd/kernel/rcutorture.c
--- linux-2.6.16-rc4/kernel/rcutorture.c	2006-02-18 14:40:37 +0100
+++ linux-2.6.16-rc4-rmd/kernel/rcutorture.c	2006-02-18 15:30:08 +0100
@@ -34,7 +34,6 @@
 #include <linux/sched.h>
 #include <asm/atomic.h>
 #include <linux/bitops.h>
-#include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
diff -NurpP linux-2.6.16-rc4/kernel/sysctl.c linux-2.6.16-rc4-rmd/kernel/sysctl.c
--- linux-2.6.16-rc4/kernel/sysctl.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/kernel/sysctl.c	2006-02-18 15:30:15 +0100
@@ -28,7 +28,6 @@
 #include <linux/capability.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
-#include <linux/capability.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff -NurpP linux-2.6.16-rc4/kernel/time.c linux-2.6.16-rc4-rmd/kernel/time.c
--- linux-2.6.16-rc4/kernel/time.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/kernel/time.c	2006-02-18 15:30:15 +0100
@@ -35,7 +35,6 @@
 #include <linux/syscalls.h>
 #include <linux/security.h>
 #include <linux/fs.h>
-#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
diff -NurpP linux-2.6.16-rc4/mm/mempolicy.c linux-2.6.16-rc4-rmd/mm/mempolicy.c
--- linux-2.6.16-rc4/mm/mempolicy.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/mm/mempolicy.c	2006-02-18 15:30:15 +0100
@@ -82,7 +82,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/compat.h>
-#include <linux/mempolicy.h>
 #include <linux/swap.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
diff -NurpP linux-2.6.16-rc4/mm/swap.c linux-2.6.16-rc4-rmd/mm/swap.c
--- linux-2.6.16-rc4/mm/swap.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/mm/swap.c	2006-02-18 15:30:08 +0100
@@ -29,7 +29,6 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
-#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
diff -NurpP linux-2.6.16-rc4/mm/swapfile.c linux-2.6.16-rc4-rmd/mm/swapfile.c
--- linux-2.6.16-rc4/mm/swapfile.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/mm/swapfile.c	2006-02-18 15:30:08 +0100
@@ -1070,7 +1070,6 @@ out:
 }
 
 #if 0	/* We don't need this yet */
-#include <linux/backing-dev.h>
 int page_queue_congested(struct page *page)
 {
 	struct backing_dev_info *bdi;
diff -NurpP linux-2.6.16-rc4/net/atm/lec.c linux-2.6.16-rc4-rmd/net/atm/lec.c
--- linux-2.6.16-rc4/net/atm/lec.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/net/atm/lec.c	2006-02-18 15:30:10 +0100
@@ -22,7 +22,6 @@
 #include <net/dst.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 /* TokenRing if needed */
diff -NurpP linux-2.6.16-rc4/net/bridge/netfilter/ebt_log.c linux-2.6.16-rc4-rmd/net/bridge/netfilter/ebt_log.c
--- linux-2.6.16-rc4/net/bridge/netfilter/ebt_log.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/net/bridge/netfilter/ebt_log.c	2006-02-18 15:30:09 +0100
@@ -15,7 +15,6 @@
 #include <linux/netfilter.h>
 #include <linux/module.h>
 #include <linux/ip.h>
-#include <linux/in.h>
 #include <linux/if_arp.h>
 #include <linux/spinlock.h>
 
diff -NurpP linux-2.6.16-rc4/net/bridge/netfilter/ebt_ulog.c linux-2.6.16-rc4-rmd/net/bridge/netfilter/ebt_ulog.c
--- linux-2.6.16-rc4/net/bridge/netfilter/ebt_ulog.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/net/bridge/netfilter/ebt_ulog.c	2006-02-18 15:30:08 +0100
@@ -37,7 +37,6 @@
 #include <linux/timer.h>
 #include <linux/netlink.h>
 #include <linux/netdevice.h>
-#include <linux/module.h>
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_ulog.h>
 #include <net/sock.h>
diff -NurpP linux-2.6.16-rc4/net/ipv4/ip_output.c linux-2.6.16-rc4-rmd/net/ipv4/ip_output.c
--- linux-2.6.16-rc4/net/ipv4/ip_output.c	2006-02-18 14:40:39 +0100
+++ linux-2.6.16-rc4-rmd/net/ipv4/ip_output.c	2006-02-18 15:30:15 +0100
@@ -76,7 +76,6 @@
 #include <net/icmp.h>
 #include <net/checksum.h>
 #include <net/inetpeer.h>
-#include <net/checksum.h>
 #include <linux/igmp.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_bridge.h>
diff -NurpP linux-2.6.16-rc4/net/ipv4/ipvs/ip_vs_ctl.c linux-2.6.16-rc4-rmd/net/ipv4/ipvs/ip_vs_ctl.c
--- linux-2.6.16-rc4/net/ipv4/ipvs/ip_vs_ctl.c	2006-02-18 14:40:39 +0100
+++ linux-2.6.16-rc4-rmd/net/ipv4/ipvs/ip_vs_ctl.c	2006-02-18 15:30:08 +0100
@@ -29,7 +29,6 @@
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
 #include <linux/swap.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <linux/netfilter.h>
diff -NurpP linux-2.6.16-rc4/net/ipv4/netfilter/ipt_CLUSTERIP.c linux-2.6.16-rc4-rmd/net/ipv4/netfilter/ipt_CLUSTERIP.c
--- linux-2.6.16-rc4/net/ipv4/netfilter/ipt_CLUSTERIP.c	2006-02-18 14:40:39 +0100
+++ linux-2.6.16-rc4-rmd/net/ipv4/netfilter/ipt_CLUSTERIP.c	2006-02-18 15:30:15 +0100
@@ -20,7 +20,6 @@
 #include <linux/udp.h>
 #include <linux/icmp.h>
 #include <linux/if_arp.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <net/checksum.h>
diff -NurpP linux-2.6.16-rc4/net/ipv4/tcp_cubic.c linux-2.6.16-rc4-rmd/net/ipv4/tcp_cubic.c
--- linux-2.6.16-rc4/net/ipv4/tcp_cubic.c	2006-02-18 14:40:42 +0100
+++ linux-2.6.16-rc4-rmd/net/ipv4/tcp_cubic.c	2006-02-18 15:30:10 +0100
@@ -52,7 +52,6 @@ MODULE_PARM_DESC(bic_scale, "scale (scal
 module_param(tcp_friendliness, int, 0644);
 MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
 
-#include <asm/div64.h>
 
 /* BIC TCP Parameters */
 struct bictcp {
diff -NurpP linux-2.6.16-rc4/net/ipv6/tcp_ipv6.c linux-2.6.16-rc4-rmd/net/ipv6/tcp_ipv6.c
--- linux-2.6.16-rc4/net/ipv6/tcp_ipv6.c	2006-02-18 14:40:42 +0100
+++ linux-2.6.16-rc4-rmd/net/ipv6/tcp_ipv6.c	2006-02-18 15:30:09 +0100
@@ -57,7 +57,6 @@
 #include <net/inet_ecn.h>
 #include <net/protocol.h>
 #include <net/xfrm.h>
-#include <net/addrconf.h>
 #include <net/snmp.h>
 #include <net/dsfield.h>
 #include <net/timewait_sock.h>
diff -NurpP linux-2.6.16-rc4/net/netfilter/nf_conntrack_proto_tcp.c linux-2.6.16-rc4-rmd/net/netfilter/nf_conntrack_proto_tcp.c
--- linux-2.6.16-rc4/net/netfilter/nf_conntrack_proto_tcp.c	2006-02-18 14:40:43 +0100
+++ linux-2.6.16-rc4-rmd/net/netfilter/nf_conntrack_proto_tcp.c	2006-02-18 15:30:15 +0100
@@ -39,7 +39,6 @@
 
 #include <net/tcp.h>
 
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <net/netfilter/nf_conntrack.h>
diff -NurpP linux-2.6.16-rc4/net/netfilter/nf_conntrack_proto_udp.c linux-2.6.16-rc4-rmd/net/netfilter/nf_conntrack_proto_udp.c
--- linux-2.6.16-rc4/net/netfilter/nf_conntrack_proto_udp.c	2006-02-18 14:40:43 +0100
+++ linux-2.6.16-rc4-rmd/net/netfilter/nf_conntrack_proto_udp.c	2006-02-18 15:30:09 +0100
@@ -22,7 +22,6 @@
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <net/netfilter/nf_conntrack_protocol.h>
diff -NurpP linux-2.6.16-rc4/net/sched/act_police.c linux-2.6.16-rc4-rmd/net/sched/act_police.c
--- linux-2.6.16-rc4/net/sched/act_police.c	2006-02-18 14:40:43 +0100
+++ linux-2.6.16-rc4-rmd/net/sched/act_police.c	2006-02-18 15:30:15 +0100
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <linux/module.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <net/sock.h>
diff -NurpP linux-2.6.16-rc4/net/sunrpc/auth_gss/svcauth_gss.c linux-2.6.16-rc4-rmd/net/sunrpc/auth_gss/svcauth_gss.c
--- linux-2.6.16-rc4/net/sunrpc/auth_gss/svcauth_gss.c	2006-02-18 14:40:43 +0100
+++ linux-2.6.16-rc4-rmd/net/sunrpc/auth_gss/svcauth_gss.c	2006-02-18 15:30:09 +0100
@@ -44,7 +44,6 @@
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/gss_err.h>
-#include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/cache.h>
 
diff -NurpP linux-2.6.16-rc4/net/wanrouter/wanmain.c linux-2.6.16-rc4-rmd/net/wanrouter/wanmain.c
--- linux-2.6.16-rc4/net/wanrouter/wanmain.c	2006-02-18 14:40:43 +0100
+++ linux-2.6.16-rc4-rmd/net/wanrouter/wanmain.c	2006-02-18 15:30:09 +0100
@@ -58,7 +58,6 @@
 
 #include <linux/vmalloc.h>	/* vmalloc, vfree */
 #include <asm/uaccess.h>        /* copy_to/from_user */
-#include <linux/init.h>         /* __initfunc et al. */
 #include <net/syncppp.h>
 
 #define KMEM_SAFETYZONE 8
diff -NurpP linux-2.6.16-rc4/sound/core/rawmidi.c linux-2.6.16-rc4-rmd/sound/core/rawmidi.c
--- linux-2.6.16-rc4/sound/core/rawmidi.c	2006-02-18 14:40:45 +0100
+++ linux-2.6.16-rc4-rmd/sound/core/rawmidi.c	2006-02-18 15:30:08 +0100
@@ -30,7 +30,6 @@
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
-#include <linux/wait.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
diff -NurpP linux-2.6.16-rc4/sound/oss/rme96xx.c linux-2.6.16-rc4-rmd/sound/oss/rme96xx.c
--- linux-2.6.16-rc4/sound/oss/rme96xx.c	2006-02-18 14:40:50 +0100
+++ linux-2.6.16-rc4-rmd/sound/oss/rme96xx.c	2006-02-18 15:30:09 +0100
@@ -55,7 +55,6 @@ TODO:
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/wait.h>
 

