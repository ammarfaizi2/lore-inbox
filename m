Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUDEU4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDEU4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:56:52 -0400
Received: from waste.org ([209.173.204.2]:47759 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263204AbUDEU4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:56:16 -0400
Date: Mon, 5 Apr 2004 15:55:39 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: [PATCH] Drop exported symbols list if !modules
Message-ID: <20040405205539.GG6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Drop ksyms if we've built without module support

From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.1-rc1-tiny2

Index: linux-2.6.1-rc1-tiny2/arch/alpha/kernel/Makefile===================================================================
RCS file: /home/cvsroot/linux-2.6.1-rc1-tiny2/arch/alpha/kernel/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile


 tiny-mpm/arch/alpha/kernel/Makefile   |    4 ++--
 tiny-mpm/arch/i386/kernel/Makefile    |    4 ++--
 tiny-mpm/arch/ia64/kernel/Makefile    |    4 ++--
 tiny-mpm/arch/m68k/kernel/Makefile    |    4 ++--
 tiny-mpm/arch/parisc/kernel/Makefile  |    4 ++--
 tiny-mpm/arch/sh/kernel/Makefile      |    4 ++--
 tiny-mpm/arch/sparc64/kernel/Makefile |    4 ++--
 tiny-mpm/arch/x86_64/kernel/Makefile  |    4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

Index: tiny/arch/alpha/kernel/Makefile
===================================================================
--- tiny.orig/arch/alpha/kernel/Makefile	2003-12-17 20:58:48.000000000 -0600
+++ tiny/arch/alpha/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -8,13 +8,13 @@
 
 obj-y    := entry.o traps.o process.o init_task.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o semaphore.o \
-	    alpha_ksyms.o systbls.o err_common.o
+	    systbls.o err_common.o
 
 obj-$(CONFIG_VGA_HOSE)	+= console.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o
 obj-$(CONFIG_SRM_ENV)	+= srm_env.o
-obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_MODULES)	+= alpha_ksyms.o module.o
 
 ifdef CONFIG_ALPHA_GENERIC
 
Index: tiny/arch/i386/kernel/Makefile
===================================================================
--- tiny.orig/arch/i386/kernel/Makefile	2004-04-02 20:25:48.000000000 -0600
+++ tiny/arch/i386/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -6,7 +6,7 @@
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
+		pci-dma.o i387.o dmi_scan.o bootflag.o \
 		doublefault.o
 
 obj-y				+= cpu/
@@ -26,7 +26,7 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
-obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_MODULES)		+= module.o i386_ksyms.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
Index: tiny/arch/ia64/kernel/Makefile
===================================================================
--- tiny.orig/arch/ia64/kernel/Makefile	2004-04-02 20:24:32.000000000 -0600
+++ tiny/arch/ia64/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -4,7 +4,7 @@
 
 extra-y	:= head.o init_task.o vmlinux.lds.s
 
-obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
+obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
 	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o unwind.o mca.o mca_asm.o
 
@@ -14,7 +14,7 @@
 obj-$(CONFIG_IA64_HP_ZX1)	+= acpi-ext.o
 obj-$(CONFIG_IA64_PALINFO)	+= palinfo.o
 obj-$(CONFIG_IOSAPIC)		+= iosapic.o
-obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_MODULES)		+= ia64_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
Index: tiny/arch/m68k/kernel/Makefile
===================================================================
--- tiny.orig/arch/m68k/kernel/Makefile	2004-03-25 13:36:07.000000000 -0600
+++ tiny/arch/m68k/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -10,9 +10,9 @@
 extra-y	+= vmlinux.lds.s
 
 obj-y		:= entry.o process.o traps.o ints.o signal.o ptrace.o \
-			sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
+			sys_m68k.o time.o semaphore.o setup.o
 
 obj-$(CONFIG_PCI)	+= bios32.o
-obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_MODULES)	+= m68k_ksyms.o module.o
 
 EXTRA_AFLAGS := -traditional
Index: tiny/arch/parisc/kernel/Makefile
===================================================================
--- tiny.orig/arch/parisc/kernel/Makefile	2004-03-03 14:00:22.000000000 -0600
+++ tiny/arch/parisc/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -13,13 +13,13 @@
 obj-y	     	:= cache.o pacache.o setup.o traps.o time.o irq.o \
 		   pa7300lc.o syscall.o entry.o sys_parisc.o firmware.o \
 		   ptrace.o hardware.o inventory.o drivers.o semaphore.o \
-		   signal.o hpmc.o real2.o parisc_ksyms.o unaligned.o \
+		   signal.o hpmc.o real2.o unaligned.o \
 		   process.o processor.o pdc_cons.o pdc_chassis.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PA11)	+= pci-dma.o
 obj-$(CONFIG_PCI)	+= pci.o
-obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_MODULES)	+= parisc_ksyms.o module.o
 obj-$(CONFIG_PARISC64)	+= binfmt_elf32.o sys_parisc32.o ioctl32.o signal32.o
 # only supported for PCX-W/U in 64-bit mode at the moment
 obj-$(CONFIG_PARISC64)	+= perf.o perf_asm.o
Index: tiny/arch/sh/kernel/Makefile
===================================================================
--- tiny.orig/arch/sh/kernel/Makefile	2004-03-03 14:00:26.000000000 -0600
+++ tiny/arch/sh/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -6,7 +6,7 @@
 
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 	ptrace.o setup.o time.o sys_sh.o semaphore.o \
-	io.o io_generic.o sh_ksyms.o
+	io.o io_generic.o
 
 obj-y				+= cpu/
 
@@ -15,7 +15,7 @@
 obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o
 obj-$(CONFIG_SH_KGDB)		+= kgdb_stub.o kgdb_jmp.o
 obj-$(CONFIG_SH_CPU_FREQ)	+= cpufreq.o
-obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_MODULES)		+= sh_ksyms.o module.o
 
 USE_STANDARD_AS_RULE := true
 
Index: tiny/arch/sparc64/kernel/Makefile
===================================================================
--- tiny.orig/arch/sparc64/kernel/Makefile	2003-12-17 20:58:18.000000000 -0600
+++ tiny/arch/sparc64/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -11,7 +11,7 @@
 		   traps.o devices.o auxio.o \
 		   irq.o ptrace.o time.o sys_sparc.o signal.o \
 		   unaligned.o central.o pci.o starfire.o semaphore.o \
-		   power.o sbus.o iommu_common.o sparc64_ksyms.o chmc.o
+		   power.o sbus.o iommu_common.o chmc.o
 
 obj-$(CONFIG_PCI)	 += ebus.o isa.o pci_common.o pci_iommu.o \
 			    pci_psycho.o pci_sabre.o pci_schizo.o
@@ -19,7 +19,7 @@
 obj-$(CONFIG_SPARC32_COMPAT) += sys32.o sys_sparc32.o signal32.o ioctl32.o
 obj-$(CONFIG_BINFMT_ELF32) += binfmt_elf32.o
 obj-$(CONFIG_BINFMT_AOUT32) += binfmt_aout32.o
-obj-$(CONFIG_MODULES) += module.o
+obj-$(CONFIG_MODULES) += sparc64_ksyms.o module.o
 obj-$(CONFIG_US3_FREQ) += us3_cpufreq.o
 obj-$(CONFIG_US2E_FREQ) += us2e_cpufreq.o
 
Index: tiny/arch/x86_64/kernel/Makefile
===================================================================
--- tiny.orig/arch/x86_64/kernel/Makefile	2004-04-02 20:24:33.000000000 -0600
+++ tiny/arch/x86_64/kernel/Makefile	2004-04-02 20:28:12.000000000 -0600
@@ -6,7 +6,7 @@
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
-		x8664_ksyms.o i387.o syscall.o vsyscall.o \
+		i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o warmreboot.o
 obj-y += mce.o acpi/
 
@@ -26,7 +26,7 @@
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
 
-obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_MODULES)		+= x8664_ksyms.o module.o
 
 obj-y				+= topology.o
 


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
