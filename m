Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTFCPeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFCPeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:34:17 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:55719 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S265061AbTFCPeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:34:01 -0400
Date: Tue, 3 Jun 2003 17:47:17 +0200
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       mikpe@csd.uu.se, torvalds@transmeta.com
Subject: [PATCH] Support for mach-xbox (updated AGAIN)
Message-ID: <20030603154717.GB31893@h55p111.delphi.afb.lu.se>
References: <20030603091113.GD13285@h55p111.delphi.afb.lu.se> <20030603125940.GC13838@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603125940.GC13838@suse.de>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19NE0L-0008RC-00*LoUTj1DDQGs*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 01:59:40PM +0100, Dave Jones wrote:
> On Tue, Jun 03, 2003 at 11:11:13AM +0200, Anders Gustafsson wrote:
>  > Updated according to Sam and Mikaels comments.
> 
> you missed one 8-)
> 
...
> 
> Last 4 lines all use spaces instead of tabs.

Fixed in this version.

In the tradition of new subarches this patch will be resent to lkml a couple
of hundred times :)

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1266 03/06/03 17:39:41 andersg@0x63.nu +10 -0
  Added XBOX subarch

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/06/03 17:39:29 andersg@0x63.nu +6 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/06/03 17:39:29 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/06/03 17:39:28 andersg@0x63.nu +6 -0

  arch/i386/mach-xbox/setup.c
    1.1 03/06/03 17:39:28 andersg@0x63.nu +79 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/06/03 17:39:28 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.0 03/06/03 17:39:28 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.1 03/06/03 17:39:27 andersg@0x63.nu +51 -0

  arch/i386/mach-xbox/Makefile
    1.1 03/06/03 17:39:27 andersg@0x63.nu +5 -0

  include/asm-i386/timex.h
    1.5 03/06/03 17:39:27 andersg@0x63.nu +9 -5
    Added XBOX subarch

  arch/i386/pci/direct.c
    1.15 03/06/03 17:39:27 andersg@0x63.nu +4 -0
    Added XBOX subarch
    Added a mach-hook for blacklisting pci-devices. The xbox hangs solid
    if you touch some pci devices.

  arch/i386/mach-xbox/reboot.c
    1.0 03/06/03 17:39:27 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.0 03/06/03 17:39:27 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/boot/compressed/Makefile
    1.17 03/06/03 17:39:27 andersg@0x63.nu +5 -0
    Added XBOX subarch
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel, unless decompressor is compiled without
    optimization.

  arch/i386/Makefile
    1.52 03/06/03 17:39:27 andersg@0x63.nu +4 -0
    Added XBOX subarch

  arch/i386/Kconfig
    1.58 03/06/03 17:39:26 andersg@0x63.nu +19 -2
    Added XBOX subarch


 arch/i386/Kconfig                                  |   21 +++++
 arch/i386/Makefile                                 |    4 +
 arch/i386/boot/compressed/Makefile                 |    5 +
 arch/i386/mach-xbox/Makefile                       |    5 +
 arch/i386/mach-xbox/reboot.c                       |   51 +++++++++++++
 arch/i386/mach-xbox/setup.c                        |   79 +++++++++++++++++++++
 arch/i386/pci/direct.c                             |    4 +
 include/asm-i386/mach-default/mach_pci_blacklist.h |    6 +
 include/asm-i386/mach-xbox/mach_pci_blacklist.h    |    6 +
 include/asm-i386/timex.h                           |   14 ++-
 10 files changed, 188 insertions(+), 7 deletions(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Jun  3 17:40:27 2003
+++ b/arch/i386/Kconfig	Tue Jun  3 17:40:27 2003
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
@@ -395,6 +411,7 @@
 	  Otherwise, say N.
 
 config SMP
+	depends on !X86_XBOX
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
@@ -1090,7 +1107,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1571,7 +1588,7 @@
 
 config X86_BIOS_REBOOT
 	bool
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	default y
 
 config X86_TRAMPOLINE
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Tue Jun  3 17:40:27 2003
+++ b/arch/i386/Makefile	Tue Jun  3 17:40:27 2003
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
--- a/arch/i386/boot/compressed/Makefile	Tue Jun  3 17:40:27 2003
+++ b/arch/i386/boot/compressed/Makefile	Tue Jun  3 17:40:27 2003
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
+++ b/arch/i386/mach-xbox/Makefile	Tue Jun  3 17:40:27 2003
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Tue Jun  3 17:40:27 2003
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
+++ b/arch/i386/mach-xbox/setup.c	Tue Jun  3 17:40:27 2003
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
--- a/arch/i386/pci/direct.c	Tue Jun  3 17:40:27 2003
+++ b/arch/i386/pci/direct.c	Tue Jun  3 17:40:27 2003
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include "mach_pci_blacklist.h"
 #include "pci.h"
 
 /*
@@ -20,6 +21,9 @@
 	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
 		return -EINVAL;
 
+	if (mach_pci_is_blacklisted(bus,dev,fn))
+		return -EINVAL;
+	
 	spin_lock_irqsave(&pci_config_lock, flags);
 
 	outl(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8);
diff -Nru a/include/asm-i386/mach-default/mach_pci_blacklist.h b/include/asm-i386/mach-default/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Tue Jun  3 17:40:27 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Tue Jun  3 17:40:27 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Tue Jun  3 17:40:27 2003
+++ b/include/asm-i386/timex.h	Tue Jun  3 17:40:27 2003
@@ -12,11 +12,15 @@
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
 #else
-#ifdef CONFIG_MELAN
-#  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
-#else
-#  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
-#endif
+#  ifdef CONFIG_MELAN
+#    define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#  else
+#    ifdef CONFIG_X86_XBOX
+#      define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
+#    else 
+#      define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
+#    endif
+#  endif
 #endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */

===================================================================


This BitKeeper patch contains the following changesets:
1.1266
## Wrapped with uu ##


M(R!5<V5R.@EA;F1E<G-G"B,@2&]S=#H),'@V,RYN=0HC(%)O;W0Z"2]D871A
M+V1E=B]K97)N96PO8FLO>&)O>"TR+C4*"B,@4&%T8V@@=F5R<SH),2XS"B,@
M4&%T8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA;F=E4V5T(#T]"G1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"G1O<G9A;&1S0&AO;64N=')A;G-M
M971A+F-O;7Q#:&%N9V53971\,C P,S V,#,P,3(X-35\-38S.#@*1" Q+C$R
M-C8@,#,O,#8O,#,@,3<Z,SDZ-#$K,#(Z,# @86YD97)S9T P>#8S+FYU("LQ
M," M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E
M='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*8R!!
M9&1E9"!80D]8('-U8F%R8V@*2R U,38T. I0($-H86YG95-E= HM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"C!A
M, H^(&%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI,S@V+VUA8V@M>&)O
M>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,S$U,SDR.7PQ,C0R-WQE
M.3(U-S W.3<Q.#4W-F0W(&%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI
M,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,S$U
M,SDS,'PQ-34Q,0H^(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX
M8F]X+TUA:V5F:6QE?#(P,#,P-C S,34S.3(W?#$V-S$Y?&)A.3,X,68W-#(R
M-3%F-C,@86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O36%K
M969I;&5\,C P,S V,#,Q-3,Y,CA\,#4R,S0*/B!T;W)V86QD<T!A=&AL;VXN
M=')A;G-M971A+F-O;7QA<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F
M:6QE?#(P,#(P,C U,3<T,#(P?#$T,C@Y?&5E9#(T,V,S9C0U8F5F-B!A;F1E
M<G-G0#!X-C,N;G5\87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL
M97PR,# S,#8P,S$U,SDR-WPP,#(R.0H^('1O<G9A;&1S0&%T:&QO;BYT<F%N
M<VUE=&$N8V]M?&%R8V@O:3,X-B]-86ME9FEL97PR,# R,#(P-3$W-# R,'PQ
M.#<Q,'PQ8CAA83%F,&,T,&$Q9&)F(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS
M.#8O36%K969I;&5\,C P,S V,#,Q-3,Y,C=\,C(U.30*/B!A;F1E<G-G0#!X
M-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC?#(P,#,P-C S,34S
M.3(X?#(U,S4V?#EC-V(T9C Q9#DP,6(Y83D@86YD97)S9T P>#8S+FYU?&%R
M8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR,# S,#8P,S$U,SDR.7PS-38T
M. H^('II<'!E;$!L:6YU>"UM-CAK+F]R9UMT;W)V86QD<UU\87)C:"]I,S@V
M+TMC;VYF:6=\,C P,C$P,S P-#,R,3A\,C0V.#A\-C$R,S$X,&%B.3$U-S8P
M8R!A;F1E<G-G0#!X-C,N;G5\87)C:"]I,S@V+TMC;VYF:6=\,C P,S V,#,Q
M-3,Y,C9\,30X,C8*/B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7QI
M;F-L=61E+V%S;2UI,S@V+W1I;65X+FA\,C P,C R,#4Q-S,Y-#1\-C,X-C)\
M86$U9F0Q868Y,69E-3!F-R!A;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM
M:3,X-B]T:6UE>"YH?#(P,#,P-C S,34S.3(W?#8Q-38T"CX@86YD97)S9T P
M>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<F5B;V]T+F-\,C P,S V,#,Q
M-3,Y,C=\,#,Y-#!\83,V-V$Y8F0Y-V-D-&%C,"!A;F1E<G-G0#!X-C,N;G5\
M87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8WPR,# S,#8P,S$U,SDR.'PS
M,CDS.0H^(&UO8VAE;$!S96=F875L="YO<V1L+F]R9WQA<F-H+VDS.#8O:V5R
M;F5L+W!C:2]D:7)E8W0N8WPR,# R,#0Q-C$U,#@S,'PT-#<S,GPS.#=C-3=D
M,#DP860T.#@X(&%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O<&-I+V1I<F5C
M="YC?#(P,#,P-C S,34S.3(W?#4T,S$R"CX@86YD97)S9T P>#8S+FYU?&EN
M8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I7V)L86-K;&ES
M="YH?#(P,#,P-C S,34S.3(X?# R.3<V?&)F,#5A8V(R,3$S,#@U,6,@86YD
M97)S9T P>#8S+FYU?&EN8VQU9&4O87-M+6DS.#8O;6%C:"UD969A=6QT+VUA
M8VA?<&-I7V)L86-K;&ES="YH?#(P,#,P-C S,34S.3(Y?#$P,C,R"@H]/2!A
M<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE(#T]"DYE=R!F:6QE.B!A<F-H
M+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE"E8@- H*86YD97)S9T P>#8S+FYU
M?&%R8V@O:3,X-B]M86-H+7AB;W@O36%K969I;&5\,C P,S V,#,Q-3,Y,C=\
M,38W,3E\8F$Y,S@Q9C<T,C(U,68V,PI$(#$N," P,R\P-B\P,R Q-SHS.3HR
M-RLP,CHP,"!A;F1E<G-G0#!X-C,N;G4@*S @+3 *0B!T;W)V86QD<T!A=&AL
M;VXN=')A;G-M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P
M-#=\8S%D,3%A-#%E9# R-#@V- IC($)I=$ME97!E<B!F:6QE("]D871A+V1E
M=B]K97)N96PO8FLO>&)O>"TR+C4O87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME
M9FEL90I+(#$V-S$Y"E @87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL90I2
M(&)A.3,X,68W-#(R-3%F-C,*6" P>#@R,0HM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"@IA;F1E<G-G0#!X-C,N
M;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]-86ME9FEL97PR,# S,#8P,S$U,SDR
M-WPQ-C<Q.7QB83DS.#%F-S0R,C4Q9C8S"D0@,2XQ(# S+S V+S S(#$W.C,Y
M.C(W*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K-2 M, I"('1O<G9A;&1S0&%T
M:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ
M-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*1B Q"DL@-3(S- I/("UR=RUR=RUR
M+2T*4"!A<F-H+VDS.#8O;6%C:"UX8F]X+TUA:V5F:6QE"BTM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*23 @-0HC
M"B,@36%K969I;&4@9F]R('1H92!L:6YU>"!K97)N96PN"B,*7 IO8FHM>0D)
M"0DZ/2!S971U<"YO(')E8F]O="YO"@H]/2!A<F-H+VDS.#8O;6%C:"UX8F]X
M+W)E8F]O="YC(#T]"DYE=R!F:6QE.B!A<F-H+VDS.#8O;6%C:"UX8F]X+W)E
M8F]O="YC"E8@- H*86YD97)S9T P>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB
M;W@O<F5B;V]T+F-\,C P,S V,#,Q-3,Y,C=\,#,Y-#!\83,V-V$Y8F0Y-V-D
M-&%C, I$(#$N," P,R\P-B\P,R Q-SHS.3HR-RLP,CHP,"!A;F1E<G-G0#!X
M-C,N;G4@*S @+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O;7Q#
M:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R-#@V
M- IC($)I=$ME97!E<B!F:6QE("]D871A+V1E=B]K97)N96PO8FLO>&)O>"TR
M+C4O87)C:"]I,S@V+VUA8V@M>&)O>"]R96)O;W0N8PI+(#,Y-# *4"!A<F-H
M+VDS.#8O;6%C:"UX8F]X+W)E8F]O="YC"E(@83,V-V$Y8F0Y-V-D-&%C, I8
M(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QA<F-H+VDS.#8O;6%C:"UX
M8F]X+W)E8F]O="YC?#(P,#,P-C S,34S.3(W?# S.30P?&$S-C=A.6)D.3=C
M9#1A8S *1" Q+C$@,#,O,#8O,#,@,3<Z,SDZ,C<K,#(Z,# @86YD97)S9T P
M>#8S+FYU("LU,2 M, I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M
M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T
M.#8T"D,*1B Q"DL@,S(Y,SD*3R M<G<M<G<M<BTM"E @87)C:"]I,S@V+VUA
M8V@M>&)O>"]R96)O;W0N8PHM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#4Q"B\J"B J(&%R8V@O:3,X-B]M
M86-H+7AB;W@O<F5B;V]T+F,@"B J($]L:79I97(@1F%U8VAO;B \;VQI=FEE
M<BYF875C:&]N0&9R964N9G(^"B J($%N9&5R<R!'=7-T869S<V]N(#QA;F1E
M<G-G0#!X-C,N;G4^"B J"B J+PI<"B-I;F-L=61E(#QA<VTO:6\N:#X*7 HO
M*B!W92!D;VXG="!U<V4@86YY(&]F('1H;W-E+"!B=70@9&UI7W-C86XN8R!N
M965D<R G96T@*B\*=F]I9" H*G!M7W!O=V5R7V]F9BDH=F]I9"D["FEN="!R
M96)O;W1?=&AR=5]B:6]S.PI<"B-D969I;F4@6$)/6%]334)?24]?0D%312 P
M>$,P,# *(V1E9FEN92!80D]87U--0E](3U-47T%$1%)%4U,@(" @(" @*#!X
M-" K(%A"3UA?4TU"7TE/7T)!4T4I"B-D969I;F4@6$)/6%]334)?2$]35%]#
M3TU-04Y$(" @(" @("@P>#@@*R!80D]87U--0E])3U]"05-%*0HC9&5F:6YE
M(%A"3UA?4TU"7TA/4U1?1$%402 @(" @(" @(" H,'@V("L@6$)/6%]334)?
M24]?0D%312D*(V1E9FEN92!80D]87U--0E]'3$]"04Q?14Y!0DQ%(" @(" @
M*#!X,B K(%A"3UA?4TU"7TE/7T)!4T4I"EP*(V1E9FEN92!80D]87U!)0U]!
M1$1215-3(#!X,3 *7 HC9&5F:6YE(%--0U]#341?4$]715(@,'@P,@HC9&5F
M:6YE(%--0U]354)#341?4$]715)?4D53150@,'@P,0HC9&5F:6YE(%--0U]3
M54)#341?4$]715)?0UE#3$4@,'@T, HC9&5F:6YE(%--0U]354)#341?4$]7
M15)?3T9&(#!X.# *7 I<"G-T871I8R!V;VED('AB;WA?<&EC7V-M9"AU."!C
M;VUM86YD*0I["@EO=71W7W H*"A80D]87U!)0U]!1$1215-3*2 \/" Q*2Q8
M0D]87U--0E](3U-47T%$1%)%4U,I.PH);W5T8E]P*%--0U]#341?4$]715(L
M(%A"3UA?4TU"7TA/4U1?0T]-34%.1"D["@EO=71W7W H8V]M;6%N9"P@6$)/
M6%]334)?2$]35%]$051!*3L*"6]U='=?<"AI;G<H6$)/6%]334)?24]?0D%3
M12DL6$)/6%]334)?24]?0D%312D["@EO=71B7W H,'@P82Q80D]87U--0E]'
M3$]"04Q?14Y!0DQ%*3L*?0I<"G9O:60@;6%C:&EN95]R97-T87)T*&-H87(@
M*B!?7W5N=7-E9"D*>PH)<')I;G1K*$M%4DY?24Y&3R B4V5N9&EN9R!03U=%
M4E]215-%5"!T;R!80D]8+5!)0RY<;B(I.PH)>&)O>%]P:6-?8VUD*%--0U]3
M54)#341?4$]715)?4D53150I.R @"GT*7 IV;VED(&UA8VAI;F5?<&]W97)?
M;V9F*'9O:60I"GL*"7!R:6YT:RA+15).7TE.1D\@(E-E;F1I;F<@4$]715)?
M3T9&('1O(%A"3U@M4$E#+EQN(BD["@EX8F]X7W!I8U]C;60H4TU#7U-50D--
M1%]03U=%4E]/1D8I.R @"GT*7 IV;VED(&UA8VAI;F5?:&%L="AV;VED*0I[
M"GT*"CT](&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8R ]/0I.97<@9FEL
M93H@87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC"E8@- H*86YD97)S9T P
M>#8S+FYU?&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N8WPR,# S,#8P,S$U
M,SDR.'PR-3,U-GPY8S=B-&8P,60Y,#%B.6$Y"D0@,2XP(# S+S V+S S(#$W
M.C,Y.C(X*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K," M, I"('1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"F,@0FET2V5E<&5R(&9I;&4@+V1A
M=&$O9&5V+VME<FYE;"]B:R]X8F]X+3(N-2]A<F-H+VDS.#8O;6%C:"UX8F]X
M+W-E='5P+F,*2R R-3,U-@I0(&%R8V@O:3,X-B]M86-H+7AB;W@O<V5T=7 N
M8PI2(#EC-V(T9C Q9#DP,6(Y83D*6" P>#@R,0HM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"@IA;F1E<G-G0#!X
M-C,N;G5\87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC?#(P,#,P-C S,34S
M.3(X?#(U,S4V?#EC-V(T9C Q9#DP,6(Y83D*1" Q+C$@,#,O,#8O,#,@,3<Z
M,SDZ,C@K,#(Z,# @86YD97)S9T P>#8S+FYU("LW.2 M, I"('1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*1B Q"DL@,S4V-#@*3R M<G<M
M<G<M<BTM"E @87)C:"]I,S@V+VUA8V@M>&)O>"]S971U<"YC"BTM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*23 @
M-SD*+RH*("H)36%C:&EN92!S<&5C:69I8R!S971U<"!F;W(@>&)O> H@*B\*
M7 HC:6YC;'5D92 \;&EN=7@O8V]N9FEG+F@^"B-I;F-L=61E(#QL:6YU>"]S
M;7 N:#X*(VEN8VQU9&4@/&QI;G5X+VEN:70N:#X*(VEN8VQU9&4@/&QI;G5X
M+VER<2YH/@HC:6YC;'5D92 \;&EN=7@O:6YT97)R=7!T+F@^"B-I;F-L=61E
M(#QA<VTO87)C:%]H;V]K<RYH/@I<"B\J*@H@*B!P<F5?:6YT<E]I;FET7VAO
M;VL@+2!I;FET:6%L:7-A=&EO;B!P<FEO<B!T;R!S971T:6YG('5P(&EN=&5R
M<G5P="!V96-T;W)S"B J"B J($1E<V-R:7!T:6]N.@H@*@E097)F;W)M(&%N
M>2!N96-E<W-A<GD@:6YT97)R=7!T(&EN:71I86QI<V%T:6]N('!R:6]R('1O
M('-E='1I;F<@=7 *("H)=&AE(")O<F1I;F%R>2(@:6YT97)R=7!T(&-A;&P@
M9V%T97,N("!&;W(@;&5G86-Y(')E87-O;G,L('1H92!)4T$*("H):6YT97)R
M=7!T<R!S:&]U;&0@8F4@:6YI=&EA;&ES960@:&5R92!I9B!T:&4@;6%C:&EN
M92!E;75L871E<R!A(%!#"B J"6EN(&%N>2!W87DN"B J*B\*=F]I9"!?7VEN
M:70@<')E7VEN=')?:6YI=%]H;V]K*'9O:60I"GL*"6EN:71?25-!7VER<7,H
M*3L*?0I<"B\J*@H@*B!I;G1R7VEN:71?:&]O:R M('!O<W0@9V%T92!S971U
M<"!I;G1E<G)U<'0@:6YI=&EA;&ES871I;VX*("H*("H@1&5S8W)I<'1I;VXZ
M"B J"49I;&P@:6X@86YY(&EN=&5R<G5P=',@=&AA="!M87D@:&%V92!B965N
M(&QE9G0@;W5T(&)Y('1H92!G96YE<F%L"B J"6EN:71?25)1*"D@<F]U=&EN
M92X@(&EN=&5R<G5P=',@:&%V:6YG('1O(&1O('=I=&@@=&AE(&UA8VAI;F4@
M<F%T:&5R"B J"71H86X@=&AE(&1E=FEC97,@;VX@=&AE($DO3R!B=7,@*&QI
M:V4@05!)0R!I;G1E<G)U<'1S(&EN(&EN=&5L($U0"B J"7-Y<W1E;7,I(&%R
M92!S=&%R=&5D(&AE<F4N"B J*B\*=F]I9"!?7VEN:70@:6YT<E]I;FET7VAO
M;VLH=F]I9"D*>PHC:69D968@0T].1DE'7U@X-E],3T-!3%]!4$E#"@EA<&EC
M7VEN=')?:6YI="@I.PHC96YD:68*7 I]"EP*+RHJ"B J('!R95]S971U<%]A
M<F-H7VAO;VL@+2!H;V]K(&-A;&QE9"!P<FEO<B!T;R!A;GD@<V5T=7!?87)C
M:"@I(&5X96-U=&EO;@H@*@H@*B!$97-C<FEP=&EO;CH*("H)9V5N97)A;&QY
M('5S960@=&\@86-T:79A=&4@86YY(&UA8VAI;F4@<W!E8VEF:6,@:61E;G1I
M9FEC871I;VX*("H)<F]U=&EN97,@=&AA="!M87D@8F4@;F5E9&5D(&)E9F]R
M92!S971U<%]A<F-H*"D@<G5N<RX@($]N(%9)4U=3"B J"71H:7,@:7,@=7-E
M9"!T;R!G970@=&AE(&)O87)D(')E=FES:6]N(&%N9"!T>7!E+@H@*BHO"G9O
M:60@7U]I;FET('!R95]S971U<%]A<F-H7VAO;VLH=F]I9"D*>PI]"EP*+RHJ
M"B J('1R87!?:6YI=%]H;V]K("T@:6YI=&EA;&ES92!S>7-T96T@<W!E8VEF
M:6,@=')A<',*("H*("H@1&5S8W)I<'1I;VXZ"B J"4-A;&QE9"!A<R!T:&4@
M9FEN86P@86-T(&]F('1R87!?:6YI="@I+B @57-E9"!I;B!625-74R!T;R!I
M;FET:6%L:7-E"B J"71H92!V87)I;W5S(&)O87)D('-P96-I9FEC($%024,@
M=')A<',N"B J*B\*=F]I9"!?7VEN:70@=')A<%]I;FET7VAO;VLH=F]I9"D*
M>PI]"EP*<W1A=&EC('-T<G5C="!I<G%A8W1I;VX@:7)Q," @/2![('1I;65R
M7VEN=&5R<G5P="P@4T%?24Y415)255!4+" P+" B=&EM97(B+"!.54Q,+"!.
M54Q,?3L*7 HO*BH*("H@=&EM95]I;FET7VAO;VL@+2!D;R!A;GD@<W!E8VEF
M:6,@:6YI=&EA;&ES871I;VYS(&9O<B!T:&4@<WES=&5M('1I;65R+@H@*@H@
M*B!$97-C<FEP=&EO;CH*("H)375S="!P;'5G('1H92!S>7-T96T@=&EM97(@
M:6YT97)R=7!T('-O=7)C92!A="!(6B!I;G1O('1H92!)4E$@;&ES=&5D"B J
M"6EN(&ER<5]V96-T;W)S+F@Z5$E-15)?25)1"B J*B\*=F]I9"!?7VEN:70@
M=&EM95]I;FET7VAO;VLH=F]I9"D*>PH)<V5T=7!?:7)Q*# L("9I<G$P*3L*
M?0I<"@H]/2!I;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H7W!C
M:5]B;&%C:VQI<W0N:" ]/0I.97<@9FEL93H@:6YC;'5D92]A<VTM:3,X-B]M
M86-H+61E9F%U;'0O;6%C:%]P8VE?8FQA8VML:7-T+F@*5B T"@IA;F1E<G-G
M0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P
M8VE?8FQA8VML:7-T+FA\,C P,S V,#,Q-3,Y,CA\,#(Y-S9\8F8P-6%C8C(Q
M,3,P.#4Q8PI$(#$N," P,R\P-B\P,R Q-SHS.3HR."LP,CHP,"!A;F1E<G-G
M0#!X-C,N;G4@*S @+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M971A+F-O
M;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A-#%E9# R
M-#@V- IC($)I=$ME97!E<B!F:6QE("]D871A+V1E=B]K97)N96PO8FLO>&)O
M>"TR+C4O:6YC;'5D92]A<VTM:3,X-B]M86-H+61E9F%U;'0O;6%C:%]P8VE?
M8FQA8VML:7-T+F@*2R R.3<V"E @:6YC;'5D92]A<VTM:3,X-B]M86-H+61E
M9F%U;'0O;6%C:%]P8VE?8FQA8VML:7-T+F@*4B!B9C U86-B,C$Q,S X-3%C
M"E@@,'@X,C$*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM"@H*86YD97)S9T P>#8S+FYU?&EN8VQU9&4O87-M+6DS
M.#8O;6%C:"UD969A=6QT+VUA8VA?<&-I7V)L86-K;&ES="YH?#(P,#,P-C S
M,34S.3(X?# R.3<V?&)F,#5A8V(R,3$S,#@U,6,*1" Q+C$@,#,O,#8O,#,@
M,3<Z,SDZ,C@K,#(Z,# @86YD97)S9T P>#8S+FYU("LV("TP"D(@=&]R=F%L
M9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S
M,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PI&(#$*2R Q,#(S,@I/("UR
M=RUR=RUR+2T*4"!I;F-L=61E+V%S;2UI,S@V+VUA8V@M9&5F875L="]M86-H
M7W!C:5]B;&%C:VQI<W0N: HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDP(#8*(VEF;F1E9B!?7T%335]-04-(
M7U!#25]"3$%#2TQ)4U1?2 HC9&5F:6YE(%]?05--7TU!0TA?4$-)7T),04-+
M3$E35%]("EP*(V1E9FEN92!M86-H7W!C:5]I<U]B;&%C:VQI<W1E9"AB=7,L
M9&5V+&9N*2 P"EP*(V5N9&EF"@H]/2!I;F-L=61E+V%S;2UI,S@V+VUA8V@M
M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:" ]/0I.97<@9FEL93H@:6YC;'5D
M92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?8FQA8VML:7-T+F@*5B T
M"@IA;F1E<G-G0#!X-C,N;G5\:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O
M;6%C:%]P8VE?8FQA8VML:7-T+FA\,C P,S V,#,Q-3,Y,CE\,3(T,C=\93DR
M-3<P-SDW,3@U-S9D-PI$(#$N," P,R\P-B\P,R Q-SHS.3HR.2LP,CHP,"!A
M;F1E<G-G0#!X-C,N;G4@*S @+3 *0B!T;W)V86QD<T!A=&AL;VXN=')A;G-M
M971A+F-O;7Q#:&%N9V53971\,C P,C R,#4Q-S,P-39\,38P-#=\8S%D,3%A
M-#%E9# R-#@V- IC($)I=$ME97!E<B!F:6QE("]D871A+V1E=B]K97)N96PO
M8FLO>&)O>"TR+C4O:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P
M8VE?8FQA8VML:7-T+F@*2R Q,C0R-PI0(&EN8VQU9&4O87-M+6DS.#8O;6%C
M:"UX8F]X+VUA8VA?<&-I7V)L86-K;&ES="YH"E(@93DR-3<P-SDW,3@U-S9D
M-PI8(#!X.#(Q"BTM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+0H*"F%N9&5R<V= ,'@V,RYN=7QI;F-L=61E+V%S;2UI
M,S@V+VUA8V@M>&)O>"]M86-H7W!C:5]B;&%C:VQI<W0N:'PR,# S,#8P,S$U
M,SDR.7PQ,C0R-WQE.3(U-S W.3<Q.#4W-F0W"D0@,2XQ(# S+S V+S S(#$W
M.C,Y.C(Y*S R.C P(&%N9&5R<V= ,'@V,RYN=2 K-B M, I"('1O<G9A;&1S
M0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U
M-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*1B Q"DL@,34U,3$*3R M<G<M
M<G<M<BTM"E @:6YC;'5D92]A<VTM:3,X-B]M86-H+7AB;W@O;6%C:%]P8VE?
M8FQA8VML:7-T+F@*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM"@I)," V"B-I9FYD968@7U]!4TU?34%#2%]00TE?
M0DQ!0TM,25-47T@*(V1E9FEN92!?7T%335]-04-(7U!#25]"3$%#2TQ)4U1?
M2 I<"B-D969I;F4@;6%C:%]P8VE?:7-?8FQA8VML:7-T960H8G5S+&1E=BQF
M;BD@*" H8G5S/C$I('Q\("AB=7,F)BAD979\?&9N*2D@?'P@*"AB=7,]/3 @
M)B8@9&5V/3TP*2 F)B H*&9N/3TQ*7Q\*&9N/3TR*2DI("D*7 HC96YD:68*
M"CT](&%R8V@O:3,X-B]P8VDO9&ER96-T+F,@/3T*;6]C:&5L0'-E9V9A=6QT
M+F]S9&PN;W)G?&%R8V@O:3,X-B]K97)N96PO<&-I+V1I<F5C="YC?#(P,#(P
M-#$V,34P.#,P?#0T-S,R?#,X-V,U-V0P.3!A9#0X.#@*9W)E9T!K<F]A:"YC
M;VU;9W)E9UU\87)C:"]I,S@V+W!C:2]D:7)E8W0N8WPR,# S,#(R,#(R,C,S
M-7PT-C,U- I$(#$N,34@,#,O,#8O,#,@,3<Z,SDZ,C<K,#(Z,# @86YD97)S
M9T P>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC
M;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P
M,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: IC($%D9&5D(&$@;6%C:"UH
M;V]K(&9O<B!B;&%C:VQI<W1I;F<@<&-I+61E=FEC97,N(%1H92!X8F]X(&AA
M;F=S('-O;&ED"F,@:68@>6]U('1O=6-H('-O;64@<&-I(&1E=FEC97,N"DL@
M-30S,3(*3R M<G<M<G<M<BTM"E @87)C:"]I,S@V+W!C:2]D:7)E8W0N8PHM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2T*"DDV(#$*(VEN8VQU9&4@(FUA8VA?<&-I7V)L86-K;&ES="YH(@I),C(@
M,PH):68@*&UA8VA?<&-I7VES7V)L86-K;&ES=&5D*&)U<RQD978L9FXI*0H)
M"7)E='5R;B M14E.5D%,.PH)"@H]/2!A<F-H+VDS.#8O36%K969I;&4@/3T*
M=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\87)C:"]I,S@V+TUA:V5F
M:6QE?#(P,#(P,C U,3<T,#(P?#$X-S$P?#%B.&%A,68P8S0P83%D8F8*86MP
M;4!D:6=E;RYC;VU;=&]R=F%L9'-=?&%R8V@O:3,X-B]-86ME9FEL97PR,# S
M,#4P.# U,3,Q-7PQ,CDV.0I$(#$N-3(@,#,O,#8O,#,@,3<Z,SDZ,C<K,#(Z
M,# @86YD97)S9T P>#8S+FYU("LT("TP"D(@=&]R=F%L9'- 871H;&]N+G1R
M86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q
M9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: I+(#(R-3DT
M"D\@+7)W+7)W+7(M+0I0(&%R8V@O:3,X-B]-86ME9FEL90HM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"DDU-2 T
M"B,@6&)O>"!S=6)A<F-H('-U<'!O<G0*;69L86=S+20H0T].1DE'7U@X-E]8
M0D]8*0DZ/2 M26EN8VQU9&4O87-M+6DS.#8O;6%C:"UX8F]X"FUC;W)E+20H
M0T].1DE'7U@X-E]80D]8*0DZ/2!M86-H+7AB;W@*7 H*/3T@87)C:"]I,S@V
M+V)O;W0O8V]M<')E<W-E9"]-86ME9FEL92 ]/0IT;W)V86QD<T!A=&AL;VXN
M=')A;G-M971A+F-O;7QA<F-H+VDS.#8O8F]O="]C;VUP<F5S<V5D+TUA:V5F
M:6QE?#(P,#(P,C U,3<T,#(P?#$T,C@Y?&5E9#(T,V,S9C0U8F5F-@IS86U 
M;6%R<RYR879N8F]R9RYO<F=\87)C:"]I,S@V+V)O;W0O8V]M<')E<W-E9"]-
M86ME9FEL97PR,# S,#,P.3(Q-#<T,7PU,S0R-PI$(#$N,3<@,#,O,#8O,#,@
M,3<Z,SDZ,C<K,#(Z,# @86YD97)S9T P>#8S+FYU("LU("TP"D(@=&]R=F%L
M9'- 871H;&]N+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S
M,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B
M87)C: IC(%1H97)E(&ES('-O;64@<W1R86YG92!I;G1E<F%C=&EO;B!W:&5N
M('!A9VEN9R!I<R!O9F8L('1H870@;6%K97,@,2XQ('AB;WAE;@IC(&-R87-H
M('=H:6QE(&1E8V]M<')E<W-I;F<@:V5R;F5L+"!U;FQE<W,@9&5C;VUP<F5S
M<V]R(&ES(&-O;7!I;&5D('=I=&AO=70*8R!O<'1I;6EZ871I;VXN"DL@,C(Y
M"D\@+7)W+7)W+7(M+0I0(&%R8V@O:3,X-B]B;V]T+V-O;7!R97-S960O36%K
M969I;&4*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM"@I)-R U"FEF97$@*"0H0T].1DE'7U@X-E]80D]8*2QY*0HC
M6%A8($-O;7!I;&EN9R!W:71H(&]P=&EM:7IA=&EO;B!M86ME<R Q+C$M>&)O
M>&5N( HC(" @(&-R87-H('=H:6QE(&1E8V]M<')E<W-I;F<@=&AE(&ME<FYE
M; I#1DQ!1U-?;6ES8RYO(" @.CT@+4\P"F5N9&EF"@H]/2!I;F-L=61E+V%S
M;2UI,S@V+W1I;65X+F@@/3T*=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC
M;VU\:6YC;'5D92]A<VTM:3,X-B]T:6UE>"YH?#(P,#(P,C U,3<S.30T?#8S
M.#8R?&%A-69D,6%F.3%F934P9C<*86QA;D!L>&]R9W5K+G5K=74N;W)G+G5K
M6W1O<G9A;&1S77QI;F-L=61E+V%S;2UI,S@V+W1I;65X+FA\,C P,S S,C(P
M,C(V,C5\-3,Y,#0*1" Q+C4@,#,O,#8O,#,@,3<Z,SDZ,C<K,#(Z,# @86YD
M97)S9T P>#8S+FYU("LY("TU"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T
M82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q
M960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: I+(#8Q-38T"D\@+7)W
M+7)W+7(M+0I0(&EN8VQU9&4O87-M+6DS.#8O=&EM97@N: HM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*"D0Q-2 U
M"DDQ.2 Y"B,@(&EF9&5F($-/3D9)1U]-14Q!3@HC(" @(&1E9FEN92!#3$]#
M2U]424-+7U)!5$4@,3$X.3(P," O*B!!340@16QA;B!H87,@9&EF9F5R96YT
M(&9R97%U96YC>2$@*B\*(R @96QS90HC(" @(&EF9&5F($-/3D9)1U]8.#9?
M6$)/6 HC(" @(" @9&5F:6YE($-,3T-+7U1)0TM?4D%412 Q,3(T.3DX("\J
M('-O(&AA<R!T:&4@6&)O>" J+PHC(" @(&5L<V4@"B,@(" @("!D969I;F4@
M0TQ/0TM?5$E#2U]2051%(#$Q.3,Q.# @+RH@56YD97)L>6EN9R!(6B J+PHC
M(" @(&5N9&EF"B,@(&5N9&EF"@H]/2!A<F-H+VDS.#8O2V-O;F9I9R ]/0IZ
M:7!P96Q ;&EN=7@M;38X:RYO<F=;=&]R=F%L9'-=?&%R8V@O:3,X-B]+8V]N
M9FEG?#(P,#(Q,#,P,#0S,C$X?#(T-C@X?#8Q,C,Q.#!A8CDQ-3<V,&,*86MP
M;4!D:6=E;RYC;VU;=&]R=F%L9'-=?&%R8V@O:3,X-B]+8V]N9FEG?#(P,#,P
M-3 X,#4Q,S$U?#(X-38Q"D0@,2XU." P,R\P-B\P,R Q-SHS.3HR-BLP,CHP
M,"!A;F1E<G-G0#!X-C,N;G4@*S$Y("TR"D(@=&]R=F%L9'- 871H;&]N+G1R
M86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q
M9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(%A"3U@@<W5B87)C: I+(#$T.#(V
M"D\@+7)W+7)W+7(M+0I0(&%R8V@O:3,X-B]+8V]N9FEG"BTM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*230U(#$V
M"F-O;F9I9R!8.#9?6$)/6 H)8F]O;" B6$)O>"!'86UI;F<@4WES=&5M(@H)
M:&5L< H)("!4:&ES(&]P=&EO;B!I<R!N965D960@=&\@;6%K92!,:6YU>"!B
M;V]T(&]N(%A";W@@1V%M:6YG(%-Y<W1E;7,N"@D@( H)("!4:&4@6$)O>"!C
M86X@8F4@8V]N<VED97)E9"!A<R!A('-T86YD87)D(%!#('=I=&@@82!#;W!P
M97)M:6YE+6)A<V5D($-E;&5R;VX@-S,S($U(>BP*"2 @241%(&AA<F1D<FEV
M92P@1%9$+"!%=&AE<FYE="P@55-"(&%N9"!G<F%P:&EC<RX@"@D@( H)("!4
M;R!B;V]T('1H92!K97)N96P@>6]U(&YE960@(E]R;VUW96QL(BP@96ET:&5R
M('5S960@87,@82!R97!L86-E;65N="!"24]3("AC<F]M=V5L;"D*"2 @;W(@
M87,@82!B;V]T;&]A9&5R+@H)(" *"2 @1F]R(&UO<F4@:6YF;W)M871I;VX@
M<V5E(&AT=' Z+R]X8F]X+6QI;G5X+G-O=7)C969O<F=E+FYE="\@"@D@( H)
M("!)9B!Y;W4@9&\@;F]T('-P96-I9FEC86QL>2!N965D(&$@:V5R;F5L(&9O
M<B!80D]8(&UA8VAI;F4L"@D@('-A>2!.(&AE<F4@;W1H97)W:7-E('1H92!K
M97)N96P@>6]U(&)U:6QD('=I;&P@;F]T(&)E(&)O;W1A8FQE+@I<"DDS.3<@
M,0H)9&5P96YD<R!O;B A6#@V7UA"3U@*1#$P.3,@,0I),3 Y,R Q"@ED97!E
M;F1S(&]N("$H6#@V7U9)4U=3('Q\(%@X-E]63UE!1T52('Q\(%@X-E]80D]8
M*0I$,34W-" Q"DDQ-3<T(#$*"61E<&5N9',@;VX@(2A8.#9?5DE35U,@?'P@
M6#@V7U9/64%'15(@?'P@6#@V7UA"3U@I"@HC(%!A=&-H(&-H96-K<W5M/31D
'.64W96-D"@  
 
