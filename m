Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270273AbTGNNXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270257AbTGNNWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:22:06 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:57556 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270614AbTGNMe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:34:57 -0400
Date: Mon, 14 Jul 2003 14:49:33 +0200
From: Anders Gustafsson - xbox patch monkey <andersg@0x63.nu>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
X-Scanner: exiscan *19c2lp-0006Ua-00*mWELvA9JZ6I*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A wise man recently said:

''That pretty much cuts the list of "needs to be supported" down to x86,
  ia64, x86-64 and possibly sparc/alpha.''

Some parts of x86 are still not supported, namely the bastardized PC called
Xbox. The patch below fixes that. Rediffed to latest bk.

Please apply. Snälla.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1459 03/07/14 12:55:39 andersg@0x63.nu +10 -0
  Added XBox Gaming System subarchitecture.

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/07/14 12:48:09 andersg@0x63.nu +6 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/07/14 12:48:09 andersg@0x63.nu +6 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/07/14 12:48:09 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/07/14 12:48:09 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.1 03/07/14 12:48:08 andersg@0x63.nu +79 -0

  arch/i386/mach-xbox/setup.c
    1.0 03/07/14 12:48:08 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.1 03/07/14 12:48:07 andersg@0x63.nu +51 -0

  arch/i386/mach-xbox/Makefile
    1.1 03/07/14 12:48:07 andersg@0x63.nu +5 -0

  include/asm-i386/timex.h
    1.6 03/07/14 12:48:07 andersg@0x63.nu +5 -1
    The xbox has a different CLOCK_TICK_RATE.

  arch/i386/mach-xbox/reboot.c
    1.0 03/07/14 12:48:07 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.0 03/07/14 12:48:07 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/pci/direct.c
    1.19 03/07/14 12:48:06 andersg@0x63.nu +4 -0
    Added a mach-hook for blacklisting pci-devices.
    The xbox uses this to prevent it from touching some devices that makes
    it hang.

  arch/i386/boot/compressed/Makefile
    1.17 03/07/14 12:48:06 andersg@0x63.nu +5 -0
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel. Compiling the decompressor without
    optimization works around this problem.

  arch/i386/Makefile
    1.53 03/07/14 12:48:06 andersg@0x63.nu +4 -0
    Added XBox Gaming System subarchitecture.

  arch/i386/Kconfig
    1.67 03/07/14 12:48:06 andersg@0x63.nu +19 -2
    Added configoption for XBox Gaming System subarchitecture.


 arch/i386/Kconfig                                  |   21 +++++
 arch/i386/Makefile                                 |    4 +
 arch/i386/boot/compressed/Makefile                 |    5 +
 arch/i386/mach-xbox/Makefile                       |    5 +
 arch/i386/mach-xbox/reboot.c                       |   51 +++++++++++++
 arch/i386/mach-xbox/setup.c                        |   79 +++++++++++++++++++++
 arch/i386/pci/direct.c                             |    4 +
 include/asm-i386/mach-default/mach_pci_blacklist.h |    6 +
 include/asm-i386/mach-xbox/mach_pci_blacklist.h    |    6 +
 include/asm-i386/timex.h                           |    6 +
 10 files changed, 184 insertions(+), 3 deletions(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jul 14 13:17:53 2003
+++ b/arch/i386/Kconfig	Mon Jul 14 13:17:53 2003
@@ -43,6 +43,22 @@
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
+config X86_XBOX
+	bool "XBox Gaming System"
+	help
+	  This option is needed to make Linux boot on XBox Gaming Systems.
+	  
+	  The XBox can be considered as a standard PC with a Coppermine-based Celeron 733 MHz,
+	  IDE harddrive, DVD, Ethernet, USB and graphics. 
+	  
+	  To boot the kernel you need "_romwell", either used as a replacement BIOS (cromwell)
+	  or as a bootloader.
+	  
+	  For more information see http://xbox-linux.sourceforge.net/ 
+	  
+	  If you do not specifically need a kernel for XBOX machine,
+	  say N here otherwise the kernel you build will not be bootable.
+
 config X86_VOYAGER
 	bool "Voyager (NCR)"
 	help
@@ -409,6 +425,7 @@
 	  Otherwise, say N.
 
 config SMP
+	depends on !X86_XBOX
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
@@ -1104,7 +1121,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1403,7 +1420,7 @@
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	default y
 
 config X86_TRAMPOLINE
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Jul 14 13:17:53 2003
+++ b/arch/i386/Makefile	Mon Jul 14 13:17:53 2003
@@ -53,6 +53,10 @@
 # Default subarch .c files
 mcore-y  := mach-default
 
+# Xbox subarch support
+mflags-$(CONFIG_X86_XBOX)	:= -Iinclude/asm-i386/mach-xbox
+mcore-$(CONFIG_X86_XBOX)	:= mach-xbox
+
 # Voyager subarch support
 mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
 mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
diff -Nru a/arch/i386/boot/compressed/Makefile b/arch/i386/boot/compressed/Makefile
--- a/arch/i386/boot/compressed/Makefile	Mon Jul 14 13:17:53 2003
+++ b/arch/i386/boot/compressed/Makefile	Mon Jul 14 13:17:53 2003
@@ -5,6 +5,11 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+ifeq ($(CONFIG_X86_XBOX),y)
+#XXX Compiling with optimization makes 1.1-xboxen 
+#    crash while decompressing the kernel
+CFLAGS_misc.o   := -O0
+endif
 EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
diff -Nru a/arch/i386/mach-xbox/Makefile b/arch/i386/mach-xbox/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/Makefile	Mon Jul 14 13:17:53 2003
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Mon Jul 14 13:17:53 2003
@@ -0,0 +1,51 @@
+/*
+ * arch/i386/mach-xbox/reboot.c 
+ * Olivier Fauchon <olivier.fauchon@free.fr>
+ * Anders Gustafsson <andersg@0x63.nu>
+ *
+ */
+
+#include <asm/io.h>
+
+/* we don't use any of those, but dmi_scan.c needs 'em */
+void (*pm_power_off)(void);
+int reboot_thru_bios;
+
+#define XBOX_SMB_IO_BASE 0xC000
+#define XBOX_SMB_HOST_ADDRESS       (0x4 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_HOST_COMMAND       (0x8 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_HOST_DATA          (0x6 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_GLOBAL_ENABLE      (0x2 + XBOX_SMB_IO_BASE)
+
+#define XBOX_PIC_ADDRESS 0x10
+
+#define SMC_CMD_POWER 0x02
+#define SMC_SUBCMD_POWER_RESET 0x01
+#define SMC_SUBCMD_POWER_CYCLE 0x40
+#define SMC_SUBCMD_POWER_OFF 0x80
+
+
+static void xbox_pic_cmd(u8 command)
+{
+	outw_p(((XBOX_PIC_ADDRESS) << 1),XBOX_SMB_HOST_ADDRESS);
+	outb_p(SMC_CMD_POWER, XBOX_SMB_HOST_COMMAND);
+	outw_p(command, XBOX_SMB_HOST_DATA);
+	outw_p(inw(XBOX_SMB_IO_BASE),XBOX_SMB_IO_BASE);
+	outb_p(0x0a,XBOX_SMB_GLOBAL_ENABLE);
+}
+
+void machine_restart(char * __unused)
+{
+	printk(KERN_INFO "Sending POWER_RESET to XBOX-PIC.\n");
+	xbox_pic_cmd(SMC_SUBCMD_POWER_RESET);  
+}
+
+void machine_power_off(void)
+{
+	printk(KERN_INFO "Sending POWER_OFF to XBOX-PIC.\n");
+	xbox_pic_cmd(SMC_SUBCMD_POWER_OFF);  
+}
+
+void machine_halt(void)
+{
+}
diff -Nru a/arch/i386/mach-xbox/setup.c b/arch/i386/mach-xbox/setup.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/setup.c	Mon Jul 14 13:17:53 2003
@@ -0,0 +1,79 @@
+/*
+ *	Machine specific setup for xbox
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+}
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to initialise
+ *	the various board specific APIC traps.
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
+
diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Mon Jul 14 13:17:53 2003
+++ b/arch/i386/pci/direct.c	Mon Jul 14 13:17:53 2003
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include "mach_pci_blacklist.h"
 #include "pci.h"
 
 /*
@@ -20,6 +21,9 @@
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
+	if (mach_pci_is_blacklisted(bus,PCI_SLOT(devfn),PCI_FUNC(devfn)))
+		return -EINVAL;
+	
 	spin_lock_irqsave(&pci_config_lock, flags);
 
 	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
diff -Nru a/include/asm-i386/mach-default/mach_pci_blacklist.h b/include/asm-i386/mach-default/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Mon Jul 14 13:17:53 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Mon Jul 14 13:17:53 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Mon Jul 14 13:17:53 2003
+++ b/include/asm-i386/timex.h	Mon Jul 14 13:17:53 2003
@@ -15,7 +15,11 @@
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
-#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
+#  ifdef CONFIG_X86_XBOX
+#    define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
+#  else 
+#    define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
+#  endif
 #endif
 #endif
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1459
## Wrapped with gzip_uu ##


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
+3>'_M<FS>]DV    
 
