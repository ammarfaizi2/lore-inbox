Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270351AbTGNOvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270612AbTGNOvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:51:08 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:11479 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270351AbTGNOtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:49:49 -0400
Date: Mon, 14 Jul 2003 17:04:26 +0200
To: Dave Jones <davej@codemonkey.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [CORRECT PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714150426.GE20708@h55p111.delphi.afb.lu.se>
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <20030714135948.GA27930@suse.de> <20030714142152.GC20708@h55p111.delphi.afb.lu.se> <20030714142838.GA29413@suse.de> <20030714145429.GD20708@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714145429.GD20708@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19c4sN-0007kW-00*qw6Gme.zdS6*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:54:29PM +0200, Anders Gustafsson wrote:
> >  > The real patch contains cleaned up HZ-ifdefs.
> > 
> > good good..
> 
> Testing it an extra time now.

And here it is.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet
  1.1459 03/07/14 16:56:06 andersg@0x63.nu +10 -0
  Added XBox Gaming System subarchitecture.

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.1 03/07/14 16:55:48 andersg@0x63.nu +10 -0

  include/asm-i386/mach-xbox/mach_pci_blacklist.h
    1.0 03/07/14 16:55:48 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-xbox/mach_pci_blacklist.h

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.1 03/07/14 16:55:47 andersg@0x63.nu +6 -0

  arch/i386/mach-xbox/setup.c
    1.1 03/07/14 16:55:47 andersg@0x63.nu +79 -0

  include/asm-i386/mach-default/mach_pci_blacklist.h
    1.0 03/07/14 16:55:47 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/include/asm-i386/mach-default/mach_pci_blacklist.h

  arch/i386/mach-xbox/setup.c
    1.0 03/07/14 16:55:47 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/setup.c

  arch/i386/mach-xbox/reboot.c
    1.1 03/07/14 16:55:46 andersg@0x63.nu +51 -0

  arch/i386/mach-xbox/reboot.c
    1.0 03/07/14 16:55:46 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/reboot.c

  arch/i386/mach-xbox/Makefile
    1.1 03/07/14 16:55:45 andersg@0x63.nu +5 -0

  include/asm-i386/timex.h
    1.6 03/07/14 16:55:45 andersg@0x63.nu +5 -5
    The xbox has a different CLOCK_TICK_RATE.

  arch/i386/pci/direct.c
    1.19 03/07/14 16:55:45 andersg@0x63.nu +4 -0
    Added a mach-hook for blacklisting pci-devices.
    The xbox uses this to prevent it from touching some devices that makes
    it hang.

  arch/i386/mach-xbox/Makefile
    1.0 03/07/14 16:55:45 andersg@0x63.nu +0 -0
    BitKeeper file /data/dev/kernel/bk/xbox-2.5/arch/i386/mach-xbox/Makefile

  arch/i386/boot/compressed/Makefile
    1.17 03/07/14 16:55:45 andersg@0x63.nu +5 -0
    There is some strange interaction when paging is off, that makes 1.1 xboxen
    crash while decompressing kernel. Compiling the decompressor without
    optimization reliably works around this problem.

  arch/i386/Makefile
    1.53 03/07/14 16:55:45 andersg@0x63.nu +4 -0
    Added XBox Gaming System subarchitecture.

  arch/i386/Kconfig
    1.67 03/07/14 16:55:45 andersg@0x63.nu +19 -2
    Added configoption for XBox Gaming System subarchitecture.


 arch/i386/Kconfig                                  |   21 +++++
 arch/i386/Makefile                                 |    4 +
 arch/i386/boot/compressed/Makefile                 |    5 +
 arch/i386/mach-xbox/Makefile                       |    5 +
 arch/i386/mach-xbox/reboot.c                       |   51 +++++++++++++
 arch/i386/mach-xbox/setup.c                        |   79 +++++++++++++++++++++
 arch/i386/pci/direct.c                             |    4 +
 include/asm-i386/mach-default/mach_pci_blacklist.h |    6 +
 include/asm-i386/mach-xbox/mach_pci_blacklist.h    |   10 ++
 include/asm-i386/timex.h                           |   10 +-
 10 files changed, 188 insertions(+), 7 deletions(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jul 14 16:59:22 2003
+++ b/arch/i386/Kconfig	Mon Jul 14 16:59:22 2003
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
--- a/arch/i386/Makefile	Mon Jul 14 16:59:22 2003
+++ b/arch/i386/Makefile	Mon Jul 14 16:59:22 2003
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
--- a/arch/i386/boot/compressed/Makefile	Mon Jul 14 16:59:22 2003
+++ b/arch/i386/boot/compressed/Makefile	Mon Jul 14 16:59:22 2003
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
+++ b/arch/i386/mach-xbox/Makefile	Mon Jul 14 16:59:22 2003
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= setup.o reboot.o
diff -Nru a/arch/i386/mach-xbox/reboot.c b/arch/i386/mach-xbox/reboot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-xbox/reboot.c	Mon Jul 14 16:59:22 2003
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
+++ b/arch/i386/mach-xbox/setup.c	Mon Jul 14 16:59:22 2003
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
--- a/arch/i386/pci/direct.c	Mon Jul 14 16:59:22 2003
+++ b/arch/i386/pci/direct.c	Mon Jul 14 16:59:22 2003
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
+++ b/include/asm-i386/mach-default/mach_pci_blacklist.h	Mon Jul 14 16:59:22 2003
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+#define mach_pci_is_blacklisted(bus,dev,fn) 0
+
+#endif
diff -Nru a/include/asm-i386/mach-xbox/mach_pci_blacklist.h b/include/asm-i386/mach-xbox/mach_pci_blacklist.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-xbox/mach_pci_blacklist.h	Mon Jul 14 16:59:22 2003
@@ -0,0 +1,10 @@
+#ifndef __ASM_MACH_PCI_BLACKLIST_H
+#define __ASM_MACH_PCI_BLACKLIST_H
+
+static inline int mach_pci_is_blacklisted(int bus, int dev, int fn)
+{
+	return (bus > 1) || ((bus != 0) && ((dev != 0) || (fn != 0))) ||
+		(!bus && !dev && ((fn == 1) || (fn == 2)));
+}
+
+#endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Mon Jul 14 16:59:22 2003
+++ b/include/asm-i386/timex.h	Mon Jul 14 16:59:22 2003
@@ -11,12 +11,12 @@
 
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
+#elif defined(CONFIG_MELAN)
+# define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#elif defined(CONFIG_X86_XBOX)
+# define CLOCK_TICK_RATE 1124998 /* so has the Xbox */
 #else
-#ifdef CONFIG_MELAN
-#  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
-#else
-#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
-#endif
+# define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */

===================================================================


This BitKeeper patch contains the following changesets:
1.1459
## Wrapped with gzip_uu ##


M'XL( $K%$C\  ]5;>7?:2!+_&WV*CK-O%C(<NI&<R3QC;"<\'WB-/>O=S3Z]
M1FJ!QD)B)&&;6>:[;U5+R%S"1\+;'9('.JJKJWYU=/7A]^0F9M%^B08.B^*!
M\)Y\">-DOR0^ZDH]F,#]51C"?<.A"6TX[+YQQZ* ^8W^7>.Q'S[6Y+HF -4E
M3>PAN0<>^R6IKN1/DNF8[9>NCC_?G+6N!.'3)](>TF# >BPAGSX)21C=4]^)
M#V@R],.@GD0TB$<LH74[',URTIDLBC+\TZ2F(FKZ3-)%M3FS)4>2J"HQ1Y15
M0U<%A]ZST4$J8+U_U_>2N!Y ZR4^BMB45%&154V;:9HJF<(1D>J2JIE$5!IB
MLR&I1-+W-7U?U'\4Y7U1)!DX!QDHY$=))#51."3?5_RV8).6XS"'W!Z&C^0S
M'7G!@/2F<<)&))[T:60/O839R21B=>&4:+*A:<+E$Z)"[94?01"I*/R\JN ,
M>VIXBJ$W1M0>UM#0C7-ZQUS/9SF& )FF:C-)T0QE1N&[+VJN+1O4$)GT#2SU
MF:C)BKI!+"^P_8G#&C0>U598X94UMCVK[U/[SO?BI#Y<9FO,-$-M OB.8RA-
MT7#Z.G7=#9)^4R_F3#)530+AM_O&$QQ]B*\&/!I'+(Z9LP1*YC0J_,PD53;,
M&6..K"JVXJI:G[GZ%IBW\5VT'_0BFZ^0MU ^HRG!=]^@5')%6Q6IY/3=+0(6
M":3(</%"IXQ9,AG7[646S9D,&)DSU=3,?M.TS29SS*:MO)VC,5,T735 J-^]
M\9CY![X73!YK(]VXJX?1X%]S[/Z]P/+4#@/7&W"8). EJJ"8,9-5W3!FNB0K
MDB'2OBEI35VTMXBVP&<1)0WNC&?-MN;+B3=BCZG3SC.2J:HS'=[),THUUY&H
M:THNTT2W^7QH++!;$LXT#..%)HP8>NHJXOI,4S13FE'(CJZAFZ[LV)IMT&]@
MV03/,A5T]5%H#\&(,1NX=.(G]3!V?+3C K-LE(-8;SA>!#DWY2:+JJ1+FF@H
MXDQ5FXH\4XRFK34=T12IHX+66P1<9;:(F"[I>O/%*<]A7/ 7Y".(!473FC-3
MI8:B*+IC&!(SS'4<O[4C8R:)LB+S(7Y;KL=1_X(]$+S>WTHI_$)40?C^0Q,?
M[\7EP5[;5[6BP7XG8[U-#KWDE+$QBS@49%N!U=@*TRGA>D(AL)7LBJP!<4O$
M1T.6WE V[,HLTLO-HNVF!#LA$B^MH #IDEKTP/^#RL^@^WH(.R+1A/=0*.>1
MX88128:,\,&%9&4LD'P5POZOM6D)/ON?2#I A21+<F%AQ,VSX/,1-Z=\><2]
M+FD71%QA>?U_&G$Y3. ?J&>!3^1D$'&K0.PXXMY@EO6(*S2+)NTRY-+!^04Q
ME^/[MIB3A,8'@7S8'C)(T/6]>P^<Y81.[&$8D)_"]$'=31\<N!%C=3?Z&8E;
M'"SR>1(GU(UC)%_!#\G@?P/"^7TVV )-/&IX87WX,SQM?" /C#AA\->$3&(&
M^$])Z$)&"&-6)?U)0IR19\4V#4#  "8",?DK3 R!XWWH.:3\83RRQN$#BZS0
M=2ME?%CY*'A!DJ4**QE&$ZOOA?%'E &&=B]@,-7LWEJ]\T.KT[4.6[UC<-"V
M*(KK[[]T>]=6Z^CHZKC7(^FG+#ZJY,<U%I6"QNWN^7GKXNBIL?&*QD>MZQ;)
M/]!8?UGCSV?=P]:9=7S1.CP[SAO+&QNOH'+9:><*BX^2N/"^=]ZVVN='UF7W
M[\=7\%*4EU[U;@[SMQ:T/[Y&&JF8IOV/]AE"KXK%--V3$\P>*,97 =PL\6S"
M+8^N:XT]V[)'3GEB$(C"$3A?1?B/4 HGR8,U+I?+JQI5R$\_$:E2W6A?\!ML
MV8>62YI6-ULT(\>.LKY7"=%Z"U1>\%!>@[^Z]N1)"D"/5C?;%*C^ $ X$AC)
M@)T%4]Z$1DG9'M((@M.R)@%$5(K(.(*0N"N?'E]=6)V+DR[9Z[' P96617,E
M(=>@!HC5OP9[*,H2S)NM7/E(R+HT>5"F,?D2(=#6KQ8!&FT68$C])._[C\*"
M(9OZ/E\O9(0O+Q=>-4TOJ!::?[)J80[2*>%J%@QF<ZHKL@;#CFN%U]MDO50H
MM$G3W&FIP!=C7E JS-%]4Z70---*H72>AA&)Q\SV7,BZG"TOU[&7M4&=U^^-
M=-D&A_;5-_%HO.FQ%WC)QN?1;YO)$Q9%D_%*&ZPH$ IK&(9W\;RRX!7/.&(6
MM(HL[(F_)S6"UQZ%&3V,)U"U0&+"64B(.B:8CT#1O"=RSVRP:)Q6,N2(Q7;D
MC;'=/N)TR2+ 9,0+EX#9+(YI-%UH_7Q7R 5G0'MA!,D06N\M-+>I[Y,!35A<
M)^0$FOIL0.TI5#<4ZJVXRN=.G5X+F>2M8A(/PXGOD#Y[ZI\Y9,@B>.#R-EF:
M)&PT\9$]H>2RG7+ANCS0:1UNYX66Q?';@.93>N>/0!0+;!>7LQ$JL\*:!<9A
MG'"],K\J JP ]1,/8,DD75 [&=($-)N2(;UGH#T+ "\W(3"@DOZ4ZSU@ 8NH
MGVJ* E_]K5PA$5  &H#Q C=@@A8"8SDA>?"2X1)P$40WBU+CT8"_@D3I@0>0
M,+WM-+I0P<:D['MWC+1@2%OD#M+CG4_.+Y%)S'<\X@J$-&"" WEFL U6*+# 
M>\^%,HJTNQ<GG<_6K:%;9]TVE S8LU"B.(3F+=$^[W'T=<%(?RR'"[>(E<<3
M6(O_H"N"3+D'(_9/I  B>V3V9(O1,NC]*5;Z#F=A)]X].@'R&JUF',]A08)7
M<T\H969:,#1X.,X*&/HZQ"%;EBB:!!@WW8#\TNG]O9<:RP/LXUR$ 4NXL?HA
MC1P(JWLOQCB%Y,ZW\0IB8 6BA3HC1Q*R_GAST@$AL^VMN:9(6Y1@VBGL-.9B
M0I5,?<2-SY+F790KH.4-:N1EJJ)J3QW.4\P]!>.!1Z;*YMUSU^0R;%!W68\E
M3;-Z/$ZB"0@$88_V!/#@2B3D$_D/P:5R=+C,ZZL$TD/GXOKXZNKF\KI*Q"K9
MXR1[57)Q<W:6?O_Q<0%%>+N$HI,Y7NXD2^DBSM>3,H@Y]WH!M.<P<25C?S)8
M:[&0C^)P$MG@H0GY\D]\'*:Q??4W@BO"S,ER)NAL92-%?;A_W3F'VA2(-N"Y
MI-%3^DQ="MB4 94?$,(LA6+E^OJ%ZN6"]O7M-]>YNUJ9_Q.6OV^ %*IBU![J
MMC<TOB)KH'W'8GFGAGU%#:WOLH1.-VM62N@WF.)-E;6.XW.  [1EM7KGUGFK
M_<6Z;'>LP[-6^_2LT[NVON3K(%M(GM9C<MF\^$D\YI2AYJB"TU;=H$+X^DTZ
MSA?GD<)M_I<DD<+&K\D@WWB<H2!]&'^Z]%$,YBGAJA<Z;''+*[(&U\X3Q_>P
MYWK6*+3GKHXF96F#'VYY4=HHML*;<H8D?K>DD=5J7N C*2Z0%Z4/?(<IA!-A
M'N$7D$RP2HF@2HD"@CF&_$RD"IG-2)G?O?M$Q KYX0>XA4;9+;YU@_2F@K="
MJ51^A^1 ^ [I> ,@@>0DY?1P(P-]6O\LI*_-QPHP2^WR=(/P +/-Z8'#^AX-
M^-&70<0&_]Y^R$%49%E#MP(G U_B#FV^?*-7W>U9.\JM7^,U-5;,N?UQP@O:
MU+*I;!U:7$.YBWZ-4R:<A,#D"8I@F 7=P_2,0$7K1B&4S>$$IV\#J)='3S/A
M;)YVQV)@!*0H,)[B2T]^%"YF+>+YELC1(6[SU:&]3?&X)W1DF2A"R7-)>=M 
MBI'4.^M>HU-##/#[DYN+=G9?J8!'9T%1.^Y<_-(Z^RB45IQU\1C(;DZ<"?1N
M/#IPO $+D<_&LUG+)Q/0Y57)%+49^*DL<@?5E/\;!WW98=#TU%RA&WW+005-
M@^KE/;E%Q\]ZAM_Q.(P28>3Z=!#7_E)>6&K!78L*'E6H=8J'!F%DAQ$K:/A$
M]77%?XI.-;[&G[[IQ*40T]'!B,+4-J+W01]2X$INW7[N4A%-,%13E6::HLK-
M-!DV_^>G7GAJPQ71.$U:,3(<L'3NGRUE/ Q90,9T@'X(=*'K5A>2&J]2T&0L
M &YV1.,AM$#+.&R.!K;,CK60-CSS?+ZH.%RD@0R,ZXOA) $VX3CQ1M[OZ7IQ
MQ'R/]OTI>0BCNQA\(IS@RA0FX7$4]GTVJO/-EBV'"(IL\Y:H:!)-\%SV&RFO
M^W!U6A'>W][>+FC)%TV7],EAJZ6P$8@Q^!1#AT"E\ GMD[/6YYXU\F*['D(C
M#+:N*&R9W60G-9^/DV\[,BK<A[]"5AH>Q#!$UNW?GSDRJHNF)*N2K$ XF*+.
MPT%_531HNXJ&=* ?4MP. %1=" \8X]MGW?:I==V!KZO6]3$_AL\/NSY7$V=J
MO\73) 7S+WB_2]+RUID[W/GQ6>L"7"U[OBH=D23#!*5)XP-IG1^18Y\&7*,G
M?=R(_39A@3U]A[M8&SO)O7I;/[)JF@;V$X>\!_15/F  UR-)@UCI0,TG;6-A
M*I(A(XL;-+,_19?_\D]DL#P$9 >BT9-W=!H[+2'F=?-S_' .)T&5*TOR3%>!
M<>K%KTCJ@$Q-WF$%D<H:\M5>7N.^\.]+^!'SPF2:0? 6CU8UP$3([#CW+Z$$
MZ=DG>^O"[0DEF-&,A1*!P,2A)]4$KK(-#RC",9N2,WYR$K,\;CRM,X(B'GBD
M?%CZWH:0Z#.$*/; +.GV L5MI\#!G8'+=IJZ*>1R<+8(N+%:G^(&0YOY+()^
MFHI"SK_\7D6^G:-C\/_(<2+OGE7)T2]'57*,NV,!2ZKDIG?(MU,&$1T//3NN
MDUR>,!7[*<>3:3CA^I$]"V85#\SW]ZJ$><@LW;+A@D9L#&4Z&V$P'W:Z/5*V
M,^H*\@5C<S)D[H?4P1V K$O<0AWA/I$7X+9M.BC%C)%ADHSW&^GZ# ^M>KKP
M#U0#AG]0U<C%[KA<3"<D 0@_WXG@&UM<=#I7)O6Z[NU\:XN#%=,IN4BW8D-4
MZP$WA%80Z$\\WR$X[>1=]!E7!>H <-&OX$F2!%FEY+ QC'U\N_%=[D]'&);P
MMI/]+E&5D2S='X*9-K_I_J/U^?AJ?INFO"-)%77.(_U]"X_\C^%@7F[?Q9/1
1)]LUE+XK4N&_IB?W.'\W    
 
