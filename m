Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSLOPKK>; Sun, 15 Dec 2002 10:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSLOPKK>; Sun, 15 Dec 2002 10:10:10 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:34557 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261701AbSLOPJV>; Sun, 15 Dec 2002 10:09:21 -0500
Message-ID: <3DFC9CEB.6000909@quark.didntduck.org>
Date: Sun, 15 Dec 2002 10:16:59 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove Rules.make from Makefiles (1/3)
Content-Type: multipart/mixed;
 boundary="------------080509050902050505020001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509050902050505020001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Makefiles no longer need to include Rules.make, which is currently an
empty file.  This patch removes it from the arch tree Makefiles except 
for sparc, ia64, and cris.


--------------080509050902050505020001
Content-Type: text/plain;
 name="rules.make-arch-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rules.make-arch-2"

diff -urN linux-2.5.51-bk2/arch/alpha/kernel/Makefile linux/arch/alpha/kernel/Makefile
--- linux-2.5.51-bk2/arch/alpha/kernel/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/alpha/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -92,5 +92,3 @@
 endif
 
 endif # GENERIC
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/alpha/lib/Makefile linux/arch/alpha/lib/Makefile
--- linux-2.5.51-bk2/arch/alpha/lib/Makefile	Sat Dec 14 12:31:40 2002
+++ linux/arch/alpha/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -49,8 +49,6 @@
 
 obj-$(CONFIG_SMP) += dec_and_lock.o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/__divqu.o: $(obj)/$(ev6)divide.S
 	$(CC) $(AFLAGS) -DDIV -c -o $(obj)/__divqu.o $(obj)/$(ev6)divide.S
 
diff -urN linux-2.5.51-bk2/arch/alpha/math-emu/Makefile linux/arch/alpha/math-emu/Makefile
--- linux-2.5.51-bk2/arch/alpha/math-emu/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/alpha/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 CFLAGS += -I. -I$(TOPDIR)/include/math-emu -w
 
 obj-$(CONFIG_MATHEMU) += math.o qrnnd.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/alpha/mm/Makefile linux/arch/alpha/mm/Makefile
--- linux-2.5.51-bk2/arch/alpha/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/alpha/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 obj-y	:= init.o fault.o extable.o
 
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/kernel/Makefile linux/arch/arm/kernel/Makefile
--- linux-2.5.51-bk2/arch/arm/kernel/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/arm/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -40,8 +40,6 @@
 
 EXTRA_TARGETS := $(head-y) init_task.o
 
-include $(TOPDIR)/Rules.make
-
 # Spell out some dependencies that `make dep' doesn't spot
 $(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
 $(obj)/entry-armo.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
diff -urN linux-2.5.51-bk2/arch/arm/lib/Makefile linux/arch/arm/lib/Makefile
--- linux-2.5.51-bk2/arch/arm/lib/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/arm/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -41,8 +41,6 @@
 
 obj-$(CONFIG_CPU_26) += uaccess-armo.o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
diff -urN linux-2.5.51-bk2/arch/arm/mach-adifcc/Makefile linux/arch/arm/mach-adifcc/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-adifcc/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-adifcc/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-			:=
 
 export-objs		:=
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-anakin/Makefile linux/arch/arm/mach-anakin/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-anakin/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-anakin/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-			:=
 
 export-objs		:= 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-arc/Makefile linux/arch/arm/mach-arc/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-arc/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-arc/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,5 +17,3 @@
 EXTRA_TARGETS 		:= head.o
 
 AFLAGS_head.o		:= -DTEXTADDR=$(TEXTADDR)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-clps711x/Makefile linux/arch/arm/mach-clps711x/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-clps711x/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/arch/arm/mach-clps711x/Makefile	Sun Dec 15 10:09:28 2002
@@ -18,5 +18,3 @@
 obj-$(CONFIG_ARCH_P720T)    += p720t.o
 leds-$(CONFIG_ARCH_P720T)   += p720t-leds.o
 obj-$(CONFIG_LEDS)          += $(leds-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-clps7500/Makefile linux/arch/arm/mach-clps7500/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-clps7500/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-clps7500/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-			:=
 
 export-objs		:= 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-ebsa110/Makefile linux/arch/arm/mach-ebsa110/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-ebsa110/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-ebsa110/Makefile	Sun Dec 15 10:09:28 2002
@@ -12,5 +12,3 @@
 export-objs		:= io.o
 
 obj-$(CONFIG_LEDS)	+= leds.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-epxa10db/Makefile linux/arch/arm/mach-epxa10db/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-epxa10db/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-epxa10db/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,6 +10,3 @@
 obj-			:=
 
 export-objs		:= 
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-footbridge/Makefile linux/arch/arm/mach-footbridge/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-footbridge/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-footbridge/Makefile	Sun Dec 15 10:09:28 2002
@@ -25,5 +25,3 @@
 
 obj-$(CONFIG_PCI)	+=$(pci-y)
 obj-$(CONFIG_LEDS)	+=$(leds-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-ftvpci/Makefile linux/arch/arm/mach-ftvpci/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-ftvpci/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-ftvpci/Makefile	Sun Dec 15 10:09:28 2002
@@ -13,5 +13,3 @@
 
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_LEDS)	+= leds.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-integrator/Makefile linux/arch/arm/mach-integrator/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-integrator/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/arch/arm/mach-integrator/Makefile	Sun Dec 15 10:09:28 2002
@@ -11,5 +11,3 @@
 
 obj-$(CONFIG_LEDS)	+= leds.o
 obj-$(CONFIG_PCI)	+= pci_v3.o pci.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-iop310/Makefile linux/arch/arm/mach-iop310/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-iop310/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-iop310/Makefile	Sun Dec 15 10:09:28 2002
@@ -22,5 +22,3 @@
 obj-$(CONFIG_IOP310_DMA) += dma.o
 obj-$(CONFIG_IOP310_MU) += message.o
 obj-$(CONFIG_IOP310_PMON) += pmon.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-l7200/Makefile linux/arch/arm/mach-l7200/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-l7200/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-l7200/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-			:=
 
 export-objs		:= 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-pxa/Makefile linux/arch/arm/mach-pxa/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-pxa/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-pxa/Makefile	Sun Dec 15 10:09:28 2002
@@ -21,5 +21,3 @@
 
 # Misc features
 obj-$(CONFIG_PM) += pm.o sleep.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-rpc/Makefile linux/arch/arm/mach-rpc/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-rpc/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-rpc/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,6 +10,3 @@
 obj-			:=
 
 export-objs		:= 
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-sa1100/Makefile linux/arch/arm/mach-sa1100/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-sa1100/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/arm/mach-sa1100/Makefile	Sun Dec 15 10:09:28 2002
@@ -108,5 +108,3 @@
 
 # Miscelaneous functions
 obj-$(CONFIG_PM) += pm.o sleep.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-shark/Makefile linux/arch/arm/mach-shark/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-shark/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-shark/Makefile	Sun Dec 15 10:09:28 2002
@@ -12,5 +12,3 @@
 export-objs		:= 
 
 obj-$(CONFIG_LEDS)	+= leds.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mach-tbox/Makefile linux/arch/arm/mach-tbox/Makefile
--- linux-2.5.51-bk2/arch/arm/mach-tbox/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/mach-tbox/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-			:=
 
 export-objs		:= 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/mm/Makefile linux/arch/arm/mm/Makefile
--- linux-2.5.51-bk2/arch/arm/mm/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/arch/arm/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -38,5 +38,3 @@
 p-$(CONFIG_CPU_XSCALE)	+= proc-xscale.o  tlb-v4wbi.o copypage-xscale.o abort-xscale.o minicache.o
 
 obj-y		+= $(sort $(p-y))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/arm/nwfpe/Makefile linux/arch/arm/nwfpe/Makefile
--- linux-2.5.51-bk2/arch/arm/nwfpe/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/arm/nwfpe/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,5 +17,3 @@
 else
 nwfpe-objs		+= entry.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/boot/compressed/Makefile linux/arch/i386/boot/compressed/Makefile
--- linux-2.5.51-bk2/arch/i386/boot/compressed/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/arch/i386/boot/compressed/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,8 +7,6 @@
 EXTRA_TARGETS	:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional
 
-include $(TOPDIR)/Rules.make
-
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
diff -urN linux-2.5.51-bk2/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux-2.5.51-bk2/arch/i386/kernel/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/arch/i386/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -34,5 +34,3 @@
 
 export-objs += scx200.o
 obj-$(CONFIG_SCx200)		+= scx200.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/kernel/cpu/Makefile linux/arch/i386/kernel/cpu/Makefile
--- linux-2.5.51-bk2/arch/i386/kernel/cpu/Makefile	Sat Dec 14 12:32:00 2002
+++ linux/arch/i386/kernel/cpu/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,6 +17,3 @@
 
 obj-$(CONFIG_MTRR)	+= 	mtrr/
 obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/kernel/cpu/cpufreq/Makefile linux/arch/i386/kernel/cpu/cpufreq/Makefile
--- linux-2.5.51-bk2/arch/i386/kernel/cpu/cpufreq/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/Makefile	Sun Dec 15 10:09:28 2002
@@ -4,5 +4,3 @@
 obj-$(CONFIG_X86_P4_CLOCKMOD)	+= p4-clockmod.o
 obj-$(CONFIG_ELAN_CPUFREQ)	+= elanfreq.o
 obj-$(CONFIG_X86_LONGRUN)	+= longrun.o  
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/kernel/cpu/mcheck/Makefile linux/arch/i386/kernel/cpu/mcheck/Makefile
--- linux-2.5.51-bk2/arch/i386/kernel/cpu/mcheck/Makefile	Sat Dec 14 12:32:00 2002
+++ linux/arch/i386/kernel/cpu/mcheck/Makefile	Sun Dec 15 10:09:28 2002
@@ -1,5 +1,2 @@
 obj-y	=	mce.o k7.o p4.o p5.o p6.o winchip.o
 obj-$(CONFIG_X86_MCE_NONFATAL)	+=	non-fatal.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/i386/kernel/cpu/mtrr/Makefile linux/arch/i386/kernel/cpu/mtrr/Makefile
--- linux-2.5.51-bk2/arch/i386/kernel/cpu/mtrr/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/arch/i386/kernel/cpu/mtrr/Makefile	Sun Dec 15 10:09:28 2002
@@ -4,5 +4,3 @@
 obj-y		+= centaur.o
 
 export-objs	:= main.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/kernel/timers/Makefile linux/arch/i386/kernel/timers/Makefile
--- linux-2.5.51-bk2/arch/i386/kernel/timers/Makefile	Sat Dec 14 12:31:40 2002
+++ linux/arch/i386/kernel/timers/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-y += timer_tsc.o
 obj-y += timer_pit.o
 obj-$(CONFIG_X86_CYCLONE)   += timer_cyclone.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/lib/Makefile linux/arch/i386/lib/Makefile
--- linux-2.5.51-bk2/arch/i386/lib/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/arch/i386/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -11,5 +11,3 @@
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 obj-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/mach-generic/Makefile linux/arch/i386/mach-generic/Makefile
--- linux-2.5.51-bk2/arch/i386/mach-generic/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/i386/mach-generic/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 EXTRA_CFLAGS	+= -I../kernel
 
 obj-y				:= setup.o topology.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/mach-visws/Makefile linux/arch/i386/mach-visws/Makefile
--- linux-2.5.51-bk2/arch/i386/mach-visws/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/i386/mach-visws/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 obj-$(CONFIG_PCI)		+= pci-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/mach-voyager/Makefile linux/arch/i386/mach-voyager/Makefile
--- linux-2.5.51-bk2/arch/i386/mach-voyager/Makefile	Sat Dec 14 12:31:47 2002
+++ linux/arch/i386/mach-voyager/Makefile	Sun Dec 15 10:09:28 2002
@@ -13,5 +13,3 @@
 obj-y			:= setup.o voyager_basic.o voyager_thread.o
 
 obj-$(CONFIG_SMP)	+= voyager_smp.o voyager_cat.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/math-emu/Makefile linux/arch/i386/math-emu/Makefile
--- linux-2.5.51-bk2/arch/i386/math-emu/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/arch/i386/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -26,7 +26,5 @@
 
 obj-y =$(C_OBJS) $(A_OBJS)
 
-include $(TOPDIR)/Rules.make
-
 proto:
 	cproto -e -DMAKING_PROTO *.c >fpu_proto.h
diff -urN linux-2.5.51-bk2/arch/i386/mm/Makefile linux/arch/i386/mm/Makefile
--- linux-2.5.51-bk2/arch/i386/mm/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/arch/i386/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/i386/pci/Makefile linux/arch/i386/pci/Makefile
--- linux-2.5.51-bk2/arch/i386/pci/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/arch/i386/pci/Makefile	Sun Dec 15 10:09:28 2002
@@ -16,5 +16,3 @@
 
 endif		# CONFIG_X86_NUMAQ
 obj-y		+= irq.o common.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/amiga/Makefile linux/arch/m68k/amiga/Makefile
--- linux-2.5.51-bk2/arch/m68k/amiga/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/amiga/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-y		:= config.o amiints.o cia.o chipram.o amisound.o amiga_ksyms.o
 
 obj-$(CONFIG_AMIGA_PCMCIA)	+= pcmcia.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/apollo/Makefile linux/arch/m68k/apollo/Makefile
--- linux-2.5.51-bk2/arch/m68k/apollo/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/apollo/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y		:= config.o dn_ints.o dma.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/atari/Makefile linux/arch/m68k/atari/Makefile
--- linux-2.5.51-bk2/arch/m68k/atari/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68k/atari/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_HADES)	+= hades-pci.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/bvme6000/Makefile linux/arch/m68k/bvme6000/Makefile
--- linux-2.5.51-bk2/arch/m68k/bvme6000/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/bvme6000/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y		:= config.o bvmeints.o rtc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/fpsp040/Makefile linux/arch/m68k/fpsp040/Makefile
--- linux-2.5.51-bk2/arch/m68k/fpsp040/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/fpsp040/Makefile	Sun Dec 15 10:09:28 2002
@@ -13,6 +13,4 @@
 EXTRA_AFLAGS := -traditional
 EXTRA_LDFLAGS := -x
 
-include $(TOPDIR)/Rules.make
-
 $(OS_OBJS): fpsp.h
diff -urN linux-2.5.51-bk2/arch/m68k/hp300/Makefile linux/arch/m68k/hp300/Makefile
--- linux-2.5.51-bk2/arch/m68k/hp300/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68k/hp300/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y		:= ksyms.o config.o ints.o time.o reboot.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/ifpsp060/Makefile linux/arch/m68k/ifpsp060/Makefile
--- linux-2.5.51-bk2/arch/m68k/ifpsp060/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/ifpsp060/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 
 EXTRA_AFLAGS := -traditional
 EXTRA_LDFLAGS := -x
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/kernel/Makefile linux/arch/m68k/kernel/Makefile
--- linux-2.5.51-bk2/arch/m68k/kernel/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68k/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,8 +17,6 @@
 
 EXTRA_AFLAGS := -traditional
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/head.o: $(obj)/head.S $(obj)/m68k_defs.h
 
 $(obj)/entry.o: $(obj)/entry.S $(obj)/m68k_defs.h
diff -urN linux-2.5.51-bk2/arch/m68k/lib/Makefile linux/arch/m68k/lib/Makefile
--- linux-2.5.51-bk2/arch/m68k/lib/Makefile	Sun Sep 15 22:18:15 2002
+++ linux/arch/m68k/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 
 obj-y		:= ashldi3.o ashrdi3.o lshrdi3.o muldi3.o \
 			checksum.o memcmp.o memcpy.o memset.o semaphore.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/mac/Makefile linux/arch/m68k/mac/Makefile
--- linux-2.5.51-bk2/arch/m68k/mac/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/mac/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 
 obj-y		:= config.o bootparse.o macints.o iop.o via.o oss.o psc.o \
 			baboon.o macboing.o debug.o misc.o mac_ksyms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/math-emu/Makefile linux/arch/m68k/math-emu/Makefile
--- linux-2.5.51-bk2/arch/m68k/math-emu/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 
 obj-y		:= fp_entry.o fp_scan.o fp_util.o fp_move.o fp_movem.o \
 			fp_cond.o fp_arith.o fp_log.o fp_trig.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/mm/Makefile linux/arch/m68k/mm/Makefile
--- linux-2.5.51-bk2/arch/m68k/mm/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68k/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,6 +9,3 @@
 else
 obj-y		+= sun3kmap.o sun3mmu.o
 endif
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/mvme147/Makefile linux/arch/m68k/mvme147/Makefile
--- linux-2.5.51-bk2/arch/m68k/mvme147/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/mvme147/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,6 +3,3 @@
 #
 
 obj-y		:= config.o 147ints.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68k/mvme16x/Makefile linux/arch/m68k/mvme16x/Makefile
--- linux-2.5.51-bk2/arch/m68k/mvme16x/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/mvme16x/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 export-objs	:= mvme16x_ksyms.o
 
 obj-y		:= config.o 16xints.o rtc.o mvme16x_ksyms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/q40/Makefile linux/arch/m68k/q40/Makefile
--- linux-2.5.51-bk2/arch/m68k/q40/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/q40/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y		:= config.o q40ints.o 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/sun3/Makefile linux/arch/m68k/sun3/Makefile
--- linux-2.5.51-bk2/arch/m68k/sun3/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68k/sun3/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 
 obj-$(CONFIG_SUN3) += config.o mmu_emu.o leds.o dvma.o \
 			intersil.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/sun3/prom/Makefile linux/arch/m68k/sun3/prom/Makefile
--- linux-2.5.51-bk2/arch/m68k/sun3/prom/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/sun3/prom/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 
 obj-y := init.o console.o printf.o  misc.o
 #bootstr.o init.o misc.o segment.o console.o printf.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68k/sun3x/Makefile linux/arch/m68k/sun3x/Makefile
--- linux-2.5.51-bk2/arch/m68k/sun3x/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/m68k/sun3x/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 export-objs	:= sun3x_ksyms.o
 
 obj-y		:= config.o time.o dvma.o prom.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68knommu/Makefile linux/arch/m68knommu/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/arch/m68knommu/Makefile	Sun Dec 15 10:09:28 2002
@@ -96,8 +96,6 @@
 	   arch/m68knommu/platform/$(PLATFORM)/
 libs-y	+= arch/m68knommu/lib/
 
-include $(TOPDIR)/Rules.make
-
 prepare: include/asm-$(ARCH)/asm-offsets.h
 
 archmrproper:
diff -urN linux-2.5.51-bk2/arch/m68knommu/kernel/Makefile linux/arch/m68knommu/kernel/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/kernel/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,6 +8,3 @@
 	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o
 
 obj-$(CONFIG_COMEMPCI)	+= comempci.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/lib/Makefile linux/arch/m68knommu/lib/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/lib/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 obj-y	:= ashldi3.o ashrdi3.o lshrdi3.o \
 	   muldi3.o mulsi3.o divsi3.o udivsi3.o modsi3.o umodsi3.o \
 	   checksum.o semaphore.o memcpy.o memset.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68knommu/mm/Makefile linux/arch/m68knommu/mm/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/mm/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y += init.o fault.o memory.o kmap.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/5206/Makefile linux/arch/m68knommu/platform/5206/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/5206/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/5206/Makefile	Sun Dec 15 10:09:28 2002
@@ -19,6 +19,3 @@
 obj-y := config.o
 
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/5206e/Makefile linux/arch/m68knommu/platform/5206e/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/5206e/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/5206e/Makefile	Sun Dec 15 10:09:28 2002
@@ -19,6 +19,3 @@
 obj-y := config.o
 
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/5249/Makefile linux/arch/m68knommu/platform/5249/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/5249/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/5249/Makefile	Sun Dec 15 10:09:28 2002
@@ -19,6 +19,3 @@
 obj-y := config.o
 
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/5272/Makefile linux/arch/m68knommu/platform/5272/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/5272/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/5272/Makefile	Sun Dec 15 10:09:28 2002
@@ -19,6 +19,3 @@
 obj-y := config.o
 
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/5307/Makefile linux/arch/m68knommu/platform/5307/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/5307/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/5307/Makefile	Sun Dec 15 10:09:28 2002
@@ -22,6 +22,3 @@
 ifeq ($(CONFIG_M5307),y)
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
 endif
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/5407/Makefile linux/arch/m68knommu/platform/5407/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/5407/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/5407/Makefile	Sun Dec 15 10:09:28 2002
@@ -19,6 +19,3 @@
 obj-y := config.o
 
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/68328/Makefile linux/arch/m68knommu/platform/68328/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/68328/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/arch/m68knommu/platform/68328/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,8 +10,6 @@
 EXTRA_TARGETS := $(BOARD)/bootlogo.rh $(BOARD)/crt0_$(MODEL).o
 endif
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/$(BOARD)/bootlogo.rh: $(src)/bootlogo.h
 	perl $(src)/bootlogo.pl < $(src)/bootlogo.h > $(obj)/$(BOARD)/bootlogo.rh
 
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/68360/Makefile linux/arch/m68knommu/platform/68360/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/68360/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/68360/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,6 +5,3 @@
 obj-y := config.o commproc.o entry.o ints.o
 
 EXTRA_TARGETS := $(BOARD)/crt0_$(MODEL).o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/68EZ328/Makefile linux/arch/m68knommu/platform/68EZ328/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/68EZ328/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/68EZ328/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,8 +6,6 @@
 
 EXTRA_TARGETS := $(BOARD)/bootlogo.rh $(BOARD)/crt0_$(MODEL).o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/$(BOARD)/bootlogo.rh: $(src)/bootlogo.h
 	perl $(src)/../68328/bootlogo.pl < $(src)/bootlogo.h \
 		> $(obj)/$(BOARD)/bootlogo.rh
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/68VZ328/Makefile linux/arch/m68knommu/platform/68VZ328/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/68VZ328/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/68VZ328/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,8 +6,6 @@
 
 EXTRA_TARGETS := $(BOARD)/bootlogo.rh $(BOARD)/crt0_$(MODEL).o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/$(BOARD)/bootlogo.rh: $(src)/../68EZ328/bootlogo.h
 	perl $(src)/../68328/bootlogo.pl < $(src)/../68EZ328/bootlogo.h \
 		> $(obj)/$(BOARD)/bootlogo.rh
diff -urN linux-2.5.51-bk2/arch/m68knommu/platform/Makefile linux/arch/m68knommu/platform/Makefile
--- linux-2.5.51-bk2/arch/m68knommu/platform/Makefile	Sat Dec 14 12:31:58 2002
+++ linux/arch/m68knommu/platform/Makefile	Sun Dec 15 10:09:28 2002
@@ -1,6 +1,3 @@
 #
 # Makefile for the arch/m68knommu/platform.
 #
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/mips/arc/Makefile linux/arch/mips/arc/Makefile
--- linux-2.5.51-bk2/arch/mips/arc/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/arch/mips/arc/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 		   time.o file.o identify.o
 
 obj-$(CONFIG_ARC_CONSOLE)   += arc_con.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/au1000/common/Makefile linux/arch/mips/au1000/common/Makefile
--- linux-2.5.51-bk2/arch/mips/au1000/common/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/au1000/common/Makefile	Sun Dec 15 10:09:28 2002
@@ -16,7 +16,5 @@
 
 EXTRA_AFLAGS := $(CFLAGS)
 
-include $(TOPDIR)/Rules.make
-
 ramdisk.o: 
 	mkramobj ramdisk ramdisk.o
diff -urN linux-2.5.51-bk2/arch/mips/au1000/pb1000/Makefile linux/arch/mips/au1000/pb1000/Makefile
--- linux-2.5.51-bk2/arch/mips/au1000/pb1000/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/au1000/pb1000/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 #
 
 obj-y := init.o setup.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/baget/Makefile linux/arch/mips/baget/Makefile
--- linux-2.5.51-bk2/arch/mips/baget/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/baget/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,8 +9,6 @@
 obj-$(CONFIG_SERIAL)	+= vacserial.o
 obj-$(CONFIG_VAC_RTC)	+= vacrtc.o
 
-include $(TOPDIR)/Rules.make
-
 bagetIRQ.o : bagetIRQ.S
 	$(CC) $(CFLAGS) -c -o $@ $<
 
diff -urN linux-2.5.51-bk2/arch/mips/baget/prom/Makefile linux/arch/mips/baget/prom/Makefile
--- linux-2.5.51-bk2/arch/mips/baget/prom/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/arch/mips/baget/prom/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 L_TARGET := lib.a
 
 obj-y	:= init.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/boot/Makefile linux/arch/mips/boot/Makefile
--- linux-2.5.51-bk2/arch/mips/boot/Makefile	Sun Sep 15 22:18:48 2002
+++ linux/arch/mips/boot/Makefile	Sun Dec 15 10:09:28 2002
@@ -43,5 +43,3 @@
 	rm -f vmlinux.ecoff
 	rm -f addinitrd
 	rm -f elf2ecoff
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ddb5074/Makefile linux/arch/mips/ddb5074/Makefile
--- linux-2.5.51-bk2/arch/mips/ddb5074/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ddb5074/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 EXTRA_AFLAGS := $(CFLAGS)
 
 obj-y	:= setup.o irq.o time.o prom.o pci.o int-handler.o nile4.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ddb5476/Makefile linux/arch/mips/ddb5476/Makefile
--- linux-2.5.51-bk2/arch/mips/ddb5476/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ddb5476/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 obj-y				+= setup.o irq.o time.o prom.o pci.o \
 				   int-handler.o nile4.o
 obj-$(CONFIG_REMOTE_DEBUG)	+= dbg_io.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ddb5xxx/common/Makefile linux/arch/mips/ddb5xxx/common/Makefile
--- linux-2.5.51-bk2/arch/mips/ddb5xxx/common/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ddb5xxx/common/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y	 += irq.o irq_cpu.o nile4.o prom.o pci.o pci_auto.o rtc_ds1386.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ddb5xxx/ddb5477/Makefile linux/arch/mips/ddb5xxx/ddb5477/Makefile
--- linux-2.5.51-bk2/arch/mips/ddb5xxx/ddb5477/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ddb5xxx/ddb5477/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 obj-$(CONFIG_LL_DEBUG) 		+= debug.o
 obj-$(CONFIG_REMOTE_DEBUG)	+= kgdb_io.o
 obj-$(CONFIG_BLK_DEV_INITRD)	+= ramdisk.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/dec/Makefile linux/arch/mips/dec/Makefile
--- linux-2.5.51-bk2/arch/mips/dec/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/dec/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-y	 := int-handler.o setup.o irq.o time.o reset.o rtc-dec.o wbflush.o
 
 obj-$(CONFIG_PROM_CONSOLE)	+= promcon.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/dec/boot/Makefile linux/arch/mips/dec/boot/Makefile
--- linux-2.5.51-bk2/arch/mips/dec/boot/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/dec/boot/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 
 clean:
 	rm -f nbImage
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/dec/prom/Makefile linux/arch/mips/dec/prom/Makefile
--- linux-2.5.51-bk2/arch/mips/dec/prom/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/arch/mips/dec/prom/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,7 +9,5 @@
 
 EXTRA_AFLAGS := $(CFLAGS)
 
-include $(TOPDIR)/Rules.make
-
 dep:
 	$(CPP) $(CPPFLAGS) -M *.c > .depend
diff -urN linux-2.5.51-bk2/arch/mips/gt64120/common/Makefile linux/arch/mips/gt64120/common/Makefile
--- linux-2.5.51-bk2/arch/mips/gt64120/common/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/gt64120/common/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y	 := gt_irq.o pci.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/gt64120/momenco_ocelot/Makefile linux/arch/mips/gt64120/momenco_ocelot/Makefile
--- linux-2.5.51-bk2/arch/mips/gt64120/momenco_ocelot/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/gt64120/momenco_ocelot/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-y	 += int-handler.o irq.o pci.o prom.o reset.o setup.o
 
 obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ite-boards/generic/Makefile linux/arch/mips/ite-boards/generic/Makefile
--- linux-2.5.51-bk2/arch/mips/ite-boards/generic/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ite-boards/generic/Makefile	Sun Dec 15 10:09:28 2002
@@ -21,5 +21,3 @@
 endif
 
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ite-boards/ivr/Makefile linux/arch/mips/ite-boards/ivr/Makefile
--- linux-2.5.51-bk2/arch/mips/ite-boards/ivr/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ite-boards/ivr/Makefile	Sun Dec 15 10:09:28 2002
@@ -11,5 +11,3 @@
 
 obj-$(CONFIG_PCI) += pci_fixup.o
 obj-$(CONFIG_BLK_DEV_INITRD) += le_ramdisk.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/ite-boards/qed-4n-s01b/Makefile linux/arch/mips/ite-boards/qed-4n-s01b/Makefile
--- linux-2.5.51-bk2/arch/mips/ite-boards/qed-4n-s01b/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/ite-boards/qed-4n-s01b/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-y := init.o 
 obj-$(CONFIG_PCI) += pci_fixup.o
 obj-$(CONFIG_BLK_DEV_INITRD) += le_ramdisk.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/jazz/Makefile linux/arch/mips/jazz/Makefile
--- linux-2.5.51-bk2/arch/mips/jazz/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/jazz/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 	    floppy-jazz.o kbd-jazz.o
 
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/kernel/Makefile linux/arch/mips/kernel/Makefile
--- linux-2.5.51-bk2/arch/mips/kernel/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -46,5 +46,3 @@
 obj-$(CONFIG_NEW_PCI)          += pci.o
 obj-$(CONFIG_PCI_AUTO)         += pci_auto.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/lib/Makefile linux/arch/mips/lib/Makefile
--- linux-2.5.51-bk2/arch/mips/lib/Makefile	Sun Sep 15 22:18:19 2002
+++ linux/arch/mips/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -20,5 +20,3 @@
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
 obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
 obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/math-emu/Makefile linux/arch/mips/math-emu/Makefile
--- linux-2.5.51-bk2/arch/mips/math-emu/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_logb.o \
 	   sp_scalb.o sp_simple.o sp_tint.o sp_fint.o sp_tlong.o sp_flong.o \
 	   dp_sqrt.o sp_sqrt.o kernel_linkage.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/mips-boards/atlas/Makefile linux/arch/mips/mips-boards/atlas/Makefile
--- linux-2.5.51-bk2/arch/mips/mips-boards/atlas/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/mips-boards/atlas/Makefile	Sun Dec 15 10:09:28 2002
@@ -24,5 +24,3 @@
 #
 
 obj-y	:= atlas_int.o atlas_rtc.o atlas_setup.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/mips-boards/generic/Makefile linux/arch/mips/mips-boards/generic/Makefile
--- linux-2.5.51-bk2/arch/mips/mips-boards/generic/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/mips-boards/generic/Makefile	Sun Dec 15 10:09:28 2002
@@ -27,5 +27,3 @@
 obj-y				:= mipsIRQ.o pci.o reset.o display.o init.o \
 				   memory.o printf.o cmdline.o time.o
 obj-$(CONFIG_REMOTE_DEBUG)	+= gdb_hook.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/mips-boards/malta/Makefile linux/arch/mips/mips-boards/malta/Makefile
--- linux-2.5.51-bk2/arch/mips/mips-boards/malta/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/mips-boards/malta/Makefile	Sun Dec 15 10:09:28 2002
@@ -24,5 +24,3 @@
 #
 
 obj-y := malta_int.o malta_rtc.o malta_setup.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/mm/Makefile linux/arch/mips/mm/Makefile
--- linux-2.5.51-bk2/arch/mips/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,5 +17,3 @@
 obj-$(CONFIG_CPU_MIPS64)	+= mips32.o
 obj-$(CONFIG_SGI_IP22)		+= umap.o
 obj-$(CONFIG_BAGET_MIPS)	+= umap.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/philips/nino/Makefile linux/arch/mips/philips/nino/Makefile
--- linux-2.5.51-bk2/arch/mips/philips/nino/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/philips/nino/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,8 +8,6 @@
 
 obj-$(CONFIG_BLK_DEV_INITRD)	+= ramdisk.o
 
-include $(TOPDIR)/Rules.make
-
 ramdisk.o:
 		$(MAKE) -C ramdisk
 		mv ramdisk/ramdisk.o ramdisk.o
diff -urN linux-2.5.51-bk2/arch/mips/philips/nino/ramdisk/Makefile linux/arch/mips/philips/nino/ramdisk/Makefile
--- linux-2.5.51-bk2/arch/mips/philips/nino/ramdisk/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/arch/mips/philips/nino/ramdisk/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 
 ramdisk.o: ramdisk.gz ld.script
 	$(LD) $(LDFLAGS) -T ld.script -b binary -o $@ ramdisk.gz
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/sgi/kernel/Makefile linux/arch/mips/sgi/kernel/Makefile
--- linux-2.5.51-bk2/arch/mips/sgi/kernel/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/sgi/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 	   indyIRQ.o reset.o setup.o time.o
 
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/sni/Makefile linux/arch/mips/sni/Makefile
--- linux-2.5.51-bk2/arch/mips/sni/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips/sni/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 obj-y	 := int-handler.o io.o irq.o pci.o pcimt_scache.o reset.o setup.o
 
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips/tools/Makefile linux/arch/mips/tools/Makefile
--- linux-2.5.51-bk2/arch/mips/tools/Makefile	Sun Sep 15 22:18:22 2002
+++ linux/arch/mips/tools/Makefile	Sun Dec 15 10:09:28 2002
@@ -21,5 +21,3 @@
 mrproper:	
 	rm -f offset.[hs] $(TARGET).new
 	rm -f $(TARGET)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/arc/Makefile linux/arch/mips64/arc/Makefile
--- linux-2.5.51-bk2/arch/mips64/arc/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/arch/mips64/arc/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 
 obj-$(CONFIG_ARC_MEMORY) += memory.o
 obj-$(CONFIG_ARC_CONSOLE) += arc_con.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/boot/Makefile linux/arch/mips64/boot/Makefile
--- linux-2.5.51-bk2/arch/mips64/boot/Makefile	Sun Sep 15 22:18:53 2002
+++ linux/arch/mips64/boot/Makefile	Sun Dec 15 10:09:28 2002
@@ -31,5 +31,3 @@
 
 mrproper:
 	rm -f vmlinux.ecoff addinitrd elf2ecoff
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/kernel/Makefile linux/arch/mips64/kernel/Makefile
--- linux-2.5.51-bk2/arch/mips64/kernel/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -19,5 +19,3 @@
 AFLAGS_r4k_genex.o := -P
 AFLAGS_r4k_tlb_glue.o := -P
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/lib/Makefile linux/arch/mips64/lib/Makefile
--- linux-2.5.51-bk2/arch/mips64/lib/Makefile	Sun Sep 15 22:18:25 2002
+++ linux/arch/mips64/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 	  floppy-no.o ide-std.o ide-no.o kbd-std.o kbd-no.o rtc-std.o \
 	  rtc-no.o memset.o memcpy.o strlen_user.o strncpy_user.o \
 	  strnlen_user.o watch.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/math-emu/Makefile linux/arch/mips64/math-emu/Makefile
--- linux-2.5.51-bk2/arch/mips64/math-emu/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_logb.o \
 	   sp_scalb.o sp_simple.o sp_tint.o sp_fint.o sp_tlong.o sp_flong.o \
 	   dp_sqrt.o sp_sqrt.o kernel_linkage.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/mips-boards/atlas/Makefile linux/arch/mips64/mips-boards/atlas/Makefile
--- linux-2.5.51-bk2/arch/mips64/mips-boards/atlas/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/mips-boards/atlas/Makefile	Sun Dec 15 10:09:28 2002
@@ -24,5 +24,3 @@
 #
 
 obj-y   := atlas_int.o atlas_rtc.o atlas_setup.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/mips-boards/generic/Makefile linux/arch/mips64/mips-boards/generic/Makefile
--- linux-2.5.51-bk2/arch/mips64/mips-boards/generic/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/mips-boards/generic/Makefile	Sun Dec 15 10:09:28 2002
@@ -27,5 +27,3 @@
 obj-$(CONFIG_REMOTE_DEBUG)      += gdb_hook.o
 
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/mips-boards/malta/Makefile linux/arch/mips64/mips-boards/malta/Makefile
--- linux-2.5.51-bk2/arch/mips64/mips-boards/malta/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/mips-boards/malta/Makefile	Sun Dec 15 10:09:28 2002
@@ -24,5 +24,3 @@
 #
 
 obj-y := malta_int.o malta_rtc.o malta_setup.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/mm/Makefile linux/arch/mips64/mm/Makefile
--- linux-2.5.51-bk2/arch/mips64/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -12,5 +12,3 @@
 obj-$(CONFIG_CPU_NEVADA)	+= r4xx0.o
 obj-$(CONFIG_CPU_R10000)	+= andes.o
 obj-$(CONFIG_SGI_IP22)		+= umap.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/sgi-ip22/Makefile linux/arch/mips64/sgi-ip22/Makefile
--- linux-2.5.51-bk2/arch/mips64/sgi-ip22/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/arch/mips64/sgi-ip22/Makefile	Sun Dec 15 10:09:28 2002
@@ -9,5 +9,3 @@
 
 obj-y	+= ip22-berr.o ip22-mc.o ip22-sc.o ip22-hpc.o ip22-int.o ip22-rtc.o \
 	   ip22-setup.o system.o ip22-timer.o ip22-irq.o ip22-reset.o time.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/sgi-ip27/Makefile linux/arch/mips64/sgi-ip27/Makefile
--- linux-2.5.51-bk2/arch/mips64/sgi-ip27/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/sgi-ip27/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-y	:= ip27-berr.o ip27-console.o ip27-irq.o ip27-init.o ip27-irq-glue.o \
 	   ip27-klconfig.o ip27-klnuma.o ip27-memory.o ip27-nmi.o ip27-pci.o \
 	   ip27-pci-dma.o ip27-reset.o ip27-setup.o ip27-timer.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/sgi-ip32/Makefile linux/arch/mips64/sgi-ip32/Makefile
--- linux-2.5.51-bk2/arch/mips64/sgi-ip32/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/mips64/sgi-ip32/Makefile	Sun Dec 15 10:09:28 2002
@@ -11,5 +11,3 @@
 obj-$(CONFIG_PCI) += ip32-pci.o ip32-pci-dma.o
 
 EXTRA_AFLAGS := $(CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/mips64/tools/Makefile linux/arch/mips64/tools/Makefile
--- linux-2.5.51-bk2/arch/mips64/tools/Makefile	Sun Sep 15 22:18:20 2002
+++ linux/arch/mips64/tools/Makefile	Sun Dec 15 10:09:28 2002
@@ -21,5 +21,3 @@
 mrproper:	
 	rm -f offset.[hs] $(TARGET).new
 	rm -f $(TARGET)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/4xx_io/Makefile linux/arch/ppc/4xx_io/Makefile
--- linux-2.5.51-bk2/arch/ppc/4xx_io/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/4xx_io/Makefile	Sun Dec 15 10:09:28 2002
@@ -4,5 +4,3 @@
 
 
 obj-$(CONFIG_SERIAL_SICC)		+= serial_sicc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/8260_io/Makefile linux/arch/ppc/8260_io/Makefile
--- linux-2.5.51-bk2/arch/ppc/8260_io/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/8260_io/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 
 obj-$(CONFIG_FEC_ENET)	+= fcc_enet.o
 obj-$(CONFIG_SCC_ENET)	+= enet.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/8xx_io/Makefile linux/arch/ppc/8xx_io/Makefile
--- linux-2.5.51-bk2/arch/ppc/8xx_io/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/8xx_io/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,5 +10,3 @@
 obj-$(CONFIG_SCC_ENET)	+= enet.o
 obj-$(CONFIG_UCODE_PATCH) += micropatch.o
 obj-$(CONFIG_HTDMSOUND) += cs4218_tdm.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/amiga/Makefile linux/arch/ppc/amiga/Makefile
--- linux-2.5.51-bk2/arch/ppc/amiga/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/amiga/Makefile	Sun Dec 15 10:09:28 2002
@@ -8,5 +8,3 @@
 			chipram.o amiga_ksyms.o
 
 obj-$(CONFIG_AMIGA_PCMCIA) += pcmcia.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/boot/utils/Makefile linux/arch/ppc/boot/utils/Makefile
--- linux-2.5.51-bk2/arch/ppc/boot/utils/Makefile	Sun Sep 15 22:18:25 2002
+++ linux/arch/ppc/boot/utils/Makefile	Sun Dec 15 10:09:28 2002
@@ -18,5 +18,3 @@
 
 clean:
 	rm -f $(UTILS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/iSeries/Makefile linux/arch/ppc/iSeries/Makefile
--- linux-2.5.51-bk2/arch/ppc/iSeries/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/iSeries/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,8 +7,6 @@
 
 obj-$(CONFIG_PCI) += XmPciLpEvent.o iSeries_FlightRecorder.o iSeries_IoMmTable.o iSeries_VpdInfo.o iSeries_fixup.o iSeries_irq.o iSeries_pci.o iSeries_pci_proc.o iSeries_reset_device.o
 
-include $(TOPDIR)/Rules.make
-
 LparData.c:: ReleaseData.h
 
 ReleaseData.h: $(TOPDIR)/Makefile
diff -urN linux-2.5.51-bk2/arch/ppc/kernel/Makefile linux/arch/ppc/kernel/Makefile
--- linux-2.5.51-bk2/arch/ppc/kernel/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/ppc/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -40,7 +40,5 @@
 endif
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_misc.o
 
-include $(TOPDIR)/Rules.make
-
 find_name : find_name.c
 	$(HOSTCC) $(HOSTCFLAGS) -o find_name find_name.c
diff -urN linux-2.5.51-bk2/arch/ppc/lib/Makefile linux/arch/ppc/lib/Makefile
--- linux-2.5.51-bk2/arch/ppc/lib/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/arch/ppc/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-y			:= checksum.o string.o strcase.o dec_and_lock.o div64.o
 
 obj-$(CONFIG_SMP)	+= locks.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/math-emu/Makefile linux/arch/ppc/math-emu/Makefile
--- linux-2.5.51-bk2/arch/ppc/math-emu/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -11,5 +11,3 @@
 					mcrfs.o mffs.o mtfsb0.o mtfsb1.o \
 					mtfsf.o mtfsfi.o stfiwx.o stfs.o \
 					udivmodti4.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/mm/Makefile linux/arch/ppc/mm/Makefile
--- linux-2.5.51-bk2/arch/ppc/mm/Makefile	Sat Dec 14 12:32:00 2002
+++ linux/arch/ppc/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -13,5 +13,3 @@
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_hashtable.o iSeries_mmu.o tlb.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= cachemap.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/platforms/4xx/Makefile linux/arch/ppc/platforms/4xx/Makefile
--- linux-2.5.51-bk2/arch/ppc/platforms/4xx/Makefile	Sat Dec 14 12:31:40 2002
+++ linux/arch/ppc/platforms/4xx/Makefile	Sun Dec 15 10:09:28 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_REDWOOD_4)		+= ibmstb3.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
 obj-$(CONFIG_NP405H)		+= ibmnp405h.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/platforms/Makefile linux/arch/ppc/platforms/Makefile
--- linux-2.5.51-bk2/arch/ppc/platforms/Makefile	Sat Dec 14 12:32:00 2002
+++ linux/arch/ppc/platforms/Makefile	Sun Dec 15 10:09:28 2002
@@ -53,5 +53,3 @@
 obj-$(CONFIG_ALL_PPC)		+= pmac_smp.o chrp_smp.o
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_smp.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc/syslib/Makefile linux/arch/ppc/syslib/Makefile
--- linux-2.5.51-bk2/arch/ppc/syslib/Makefile	Sat Dec 14 12:32:00 2002
+++ linux/arch/ppc/syslib/Makefile	Sun Dec 15 10:09:28 2002
@@ -62,7 +62,5 @@
 obj-$(CONFIG_8260)		+= m8260_setup.o ppc8260_pic.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 
-include $(TOPDIR)/Rules.make
-
 find_name : find_name.c
 	$(HOSTCC) $(HOSTCFLAGS) -o find_name find_name.c
diff -urN linux-2.5.51-bk2/arch/ppc/xmon/Makefile linux/arch/ppc/xmon/Makefile
--- linux-2.5.51-bk2/arch/ppc/xmon/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc/xmon/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 obj-y		:= start.o
 endif
 obj-y		+= xmon.o ppc-dis.o ppc-opc.o subr_prf.o setjmp.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc64/kernel/Makefile linux/arch/ppc64/kernel/Makefile
--- linux-2.5.51-bk2/arch/ppc64/kernel/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/arch/ppc64/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -38,6 +38,3 @@
 obj-$(CONFIG_PROFILING)	+= profile.o
 
 obj-y += prom.o lmb.o rtas.o rtas-proc.o chrp_setup.o i8259.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/ppc64/lib/Makefile linux/arch/ppc64/lib/Makefile
--- linux-2.5.51-bk2/arch/ppc64/lib/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc64/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 
 obj-y           := checksum.o dec_and_lock.o string.o strcase.o copypage.o \
 		   memcpy.o copyuser.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc64/mm/Makefile linux/arch/ppc64/mm/Makefile
--- linux-2.5.51-bk2/arch/ppc64/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc64/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 
 obj-y           := fault.o init.o extable.o imalloc.o
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/ppc64/xmon/Makefile linux/arch/ppc64/xmon/Makefile
--- linux-2.5.51-bk2/arch/ppc64/xmon/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/ppc64/xmon/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 EXTRA_CFLAGS = -mno-minimal-toc
 
 obj-y       := start.o xmon.o ppc-dis.o ppc-opc.o subr_prf.o setjmp.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/s390/boot/Makefile linux/arch/s390/boot/Makefile
--- linux-2.5.51-bk2/arch/s390/boot/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/s390/boot/Makefile	Sun Dec 15 10:09:28 2002
@@ -4,8 +4,6 @@
 
 EXTRA_AFLAGS := -traditional
 
-include $(TOPDIR)/Rules.make
-
 quiet_cmd_listing = OBJDUMP $(echo_target)
 cmd_listing	  = $(OBJDUMP) --disassemble --disassemble-all \
 			--disassemble-zeroes --reloc vmlinux > $@
diff -urN linux-2.5.51-bk2/arch/s390/kernel/Makefile linux/arch/s390/kernel/Makefile
--- linux-2.5.51-bk2/arch/s390/kernel/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/s390/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,5 +17,3 @@
 # Kernel debugging
 #
 obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-stub.o #gdb-low.o 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/s390/lib/Makefile linux/arch/s390/lib/Makefile
--- linux-2.5.51-bk2/arch/s390/lib/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/arch/s390/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,6 +7,3 @@
 EXTRA_AFLAGS := -traditional
 
 obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/s390/math-emu/Makefile linux/arch/s390/math-emu/Makefile
--- linux-2.5.51-bk2/arch/s390/math-emu/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/s390/math-emu/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,7 +6,3 @@
 
 EXTRA_CFLAGS = -I. -I$(TOPDIR)/include/math-emu -w
 EXTRA_AFLAGS	:= -traditional
-
-include $(TOPDIR)/Rules.make
-
-
diff -urN linux-2.5.51-bk2/arch/s390/mm/Makefile linux/arch/s390/mm/Makefile
--- linux-2.5.51-bk2/arch/s390/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/s390/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y	 := init.o fault.o ioremap.o extable.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/s390x/boot/Makefile linux/arch/s390x/boot/Makefile
--- linux-2.5.51-bk2/arch/s390x/boot/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/s390x/boot/Makefile	Sun Dec 15 10:09:28 2002
@@ -4,8 +4,6 @@
 
 EXTRA_AFLAGS := -traditional
 
-include $(TOPDIR)/Rules.make
-
 quiet_cmd_listing = OBJDUMP $(echo_target)
 cmd_listing	  = $(OBJDUMP) --disassemble --disassemble-all \
 			--disassemble-zeroes --reloc vmlinux > $@
diff -urN linux-2.5.51-bk2/arch/s390x/kernel/Makefile linux/arch/s390x/kernel/Makefile
--- linux-2.5.51-bk2/arch/s390x/kernel/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/arch/s390x/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -24,8 +24,6 @@
 					 exec32.o exec_domain32.o
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
 
-include $(TOPDIR)/Rules.make
-
 #
 # This is just to get the dependencies...
 #
diff -urN linux-2.5.51-bk2/arch/s390x/lib/Makefile linux/arch/s390x/lib/Makefile
--- linux-2.5.51-bk2/arch/s390x/lib/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/arch/s390x/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,6 +7,3 @@
 EXTRA_AFLAGS := -traditional
 
 obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/s390x/mm/Makefile linux/arch/s390x/mm/Makefile
--- linux-2.5.51-bk2/arch/s390x/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/s390x/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y	 := init.o fault.o ioremap.o extable.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/sh/kernel/Makefile linux/arch/sh/kernel/Makefile
--- linux-2.5.51-bk2/arch/sh/kernel/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/sh/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -72,5 +72,3 @@
 ifeq ($(CONFIG_SH_GENERIC),y)
 obj-y		+= $(machine-specific-objs)
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/sh/lib/Makefile linux/arch/sh/lib/Makefile
--- linux-2.5.51-bk2/arch/sh/lib/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/arch/sh/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 L_TARGET = lib.a
 obj-y  = delay.o memcpy.o memset.o memmove.o memchr.o \
 	 checksum.o strcasecmp.o strlen.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/sh/mm/Makefile linux/arch/sh/mm/Makefile
--- linux-2.5.51-bk2/arch/sh/mm/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/sh/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -6,5 +6,3 @@
 
 obj-$(CONFIG_CPU_SH3) += cache-sh3.o
 obj-$(CONFIG_CPU_SH4) += cache-sh4.o __clear_user_page-sh4.o __copy_user_page-sh4.o ioremap.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/sh/stboards/Makefile linux/arch/sh/stboards/Makefile
--- linux-2.5.51-bk2/arch/sh/stboards/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/sh/stboards/Makefile	Sun Dec 15 10:09:28 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y := irq.o setup.o mach.o led.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/sparc64/kernel/Makefile linux/arch/sparc64/kernel/Makefile
--- linux-2.5.51-bk2/arch/sparc64/kernel/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/arch/sparc64/kernel/Makefile	Sun Dec 15 10:10:20 2002
@@ -36,7 +36,5 @@
   CMODEL_CFLAG := -m64 -mcmodel=medlow
 endif
 
-include $(TOPDIR)/Rules.make
-
 head.o: head.S ttable.S itlb_base.S dtlb_base.S dtlb_backend.S dtlb_prot.S \
 	etrap.S rtrap.S winfixup.S entry.S
diff -urN linux-2.5.51-bk2/arch/um/drivers/Makefile linux/arch/um/drivers/Makefile
--- linux-2.5.51-bk2/arch/um/drivers/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/arch/um/drivers/Makefile	Sun Dec 15 10:09:28 2002
@@ -60,8 +60,6 @@
 	null.o pty.o tty.o xterm.o
 USER_OBJS := $(foreach file,$(USER_OBJS),arch/um/drivers/$(file))
 
-include $(TOPDIR)/Rules.make
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
 
diff -urN linux-2.5.51-bk2/arch/um/kernel/Makefile linux/arch/um/kernel/Makefile
--- linux-2.5.51-bk2/arch/um/kernel/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/arch/um/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,7 +10,7 @@
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
 
-# user_syms.o not included here because Rules.make has its own ideas about
+# user_syms.o not included here because kbuild has its own ideas about
 # building anything in export-objs
 
 USER_OBJS := $(filter %_user.o,$(obj-y)) config.o helper.o process.o \
@@ -39,8 +39,6 @@
 
 CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
 
-include $(TOPDIR)/Rules.make
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
 
diff -urN linux-2.5.51-bk2/arch/um/os-Linux/Makefile linux/arch/um/os-Linux/Makefile
--- linux-2.5.51-bk2/arch/um/os-Linux/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/arch/um/os-Linux/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,8 +7,6 @@
 
 USER_OBJS := $(foreach file,$(obj-y),arch/um/os-Linux/$(file))
 
-include $(TOPDIR)/Rules.make
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
 
diff -urN linux-2.5.51-bk2/arch/um/os-Linux/drivers/Makefile linux/arch/um/os-Linux/drivers/Makefile
--- linux-2.5.51-bk2/arch/um/os-Linux/drivers/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/um/os-Linux/drivers/Makefile	Sun Dec 15 10:09:28 2002
@@ -14,7 +14,5 @@
 
 USER_OBJS = $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
 
-include $(TOPDIR)/Rules.make
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
diff -urN linux-2.5.51-bk2/arch/um/ptproxy/Makefile linux/arch/um/ptproxy/Makefile
--- linux-2.5.51-bk2/arch/um/ptproxy/Makefile	Sat Dec 14 12:31:40 2002
+++ linux/arch/um/ptproxy/Makefile	Sun Dec 15 10:09:28 2002
@@ -2,8 +2,6 @@
 
 USER_OBJS := $(foreach file,$(obj-y),arch/um/ptproxy/$(file))
 
-include $(TOPDIR)/Rules.make
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
 
diff -urN linux-2.5.51-bk2/arch/um/sys-i386/Makefile linux/arch/um/sys-i386/Makefile
--- linux-2.5.51-bk2/arch/um/sys-i386/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/arch/um/sys-i386/Makefile	Sun Dec 15 10:09:28 2002
@@ -10,8 +10,6 @@
 
 SYMLINKS = semaphore.c checksum.S extable.c highmem.c
 
-include $(TOPDIR)/Rules.make
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
 
diff -urN linux-2.5.51-bk2/arch/um/sys-i386/util/Makefile linux/arch/um/sys-i386/util/Makefile
--- linux-2.5.51-bk2/arch/um/sys-i386/util/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/um/sys-i386/util/Makefile	Sun Dec 15 10:09:28 2002
@@ -4,8 +4,6 @@
 
 mk_sc-objs	:= mk_sc.o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/mk_thread : $(obj)/mk_thread_kern.o $(obj)/mk_thread_user.o
 	$(CC) $(CFLAGS) -o $@ $^
 
diff -urN linux-2.5.51-bk2/arch/um/sys-ia64/Makefile linux/arch/um/sys-ia64/Makefile
--- linux-2.5.51-bk2/arch/um/sys-ia64/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/um/sys-ia64/Makefile	Sun Dec 15 10:09:28 2002
@@ -22,5 +22,3 @@
 	@$(MAKEBOOT) dep
 
 modules:
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/um/sys-ppc/Makefile linux/arch/um/sys-ppc/Makefile
--- linux-2.5.51-bk2/arch/um/sys-ppc/Makefile	Sat Dec 14 12:31:35 2002
+++ linux/arch/um/sys-ppc/Makefile	Sun Dec 15 10:09:28 2002
@@ -76,5 +76,3 @@
 dep:
 
 modules:
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/um/util/Makefile linux/arch/um/util/Makefile
--- linux-2.5.51-bk2/arch/um/util/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/um/util/Makefile	Sun Dec 15 10:09:28 2002
@@ -1,7 +1,5 @@
 EXTRA_TARGETS := mk_task mk_task_kern.o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/mk_task: $(obj)/mk_task_user.o $(obj)/mk_task_kern.o
 	$(CC) -o $@ $^
 
diff -urN linux-2.5.51-bk2/arch/v850/Makefile linux/arch/v850/Makefile
--- linux-2.5.51-bk2/arch/v850/Makefile	Sat Dec 14 12:32:06 2002
+++ linux/arch/v850/Makefile	Sun Dec 15 10:09:28 2002
@@ -31,9 +31,6 @@
 libs-y += $(arch_dir)/lib/
 
 
-include $(TOPDIR)/Rules.make
-
-
 # Deal with the initial contents of the root device
 ifdef ROOT_FS_IMAGE
 core-y += root_fs_image.o
diff -urN linux-2.5.51-bk2/arch/v850/kernel/Makefile linux/arch/v850/kernel/Makefile
--- linux-2.5.51-bk2/arch/v850/kernel/Makefile	Sat Dec 14 12:32:06 2002
+++ linux/arch/v850/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -34,6 +34,3 @@
 # feature-specific code
 obj-$(CONFIG_V850E_MA1_HIGHRES_TIMER)	+= highres_timer.o
 obj-$(CONFIG_PROC_FS)		+= procfs.o
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/v850/lib/Makefile linux/arch/v850/lib/Makefile
--- linux-2.5.51-bk2/arch/v850/lib/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/arch/v850/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 L_TARGET = lib.a
 obj-y  = ashrdi3.o ashldi3.o lshrdi3.o muldi3.o negdi2.o \
 	 checksum.o memcpy.o memset.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/x86_64/boot/Makefile linux/arch/x86_64/boot/Makefile
--- linux-2.5.51-bk2/arch/x86_64/boot/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/arch/x86_64/boot/Makefile	Sun Dec 15 10:09:28 2002
@@ -36,8 +36,6 @@
 
 boot: bzImage
 
-include $(TOPDIR)/Rules.make
-
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000
diff -urN linux-2.5.51-bk2/arch/x86_64/boot/compressed/Makefile linux/arch/x86_64/boot/compressed/Makefile
--- linux-2.5.51-bk2/arch/x86_64/boot/compressed/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/x86_64/boot/compressed/Makefile	Sun Dec 15 10:09:28 2002
@@ -14,8 +14,6 @@
 CFLAGS := -m32 -D__KERNEL__ -I$(TOPDIR)/include -O2  
 LDFLAGS := -m elf_i386
 
-include $(TOPDIR)/Rules.make
-
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32 -m elf_i386
 
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
diff -urN linux-2.5.51-bk2/arch/x86_64/ia32/Makefile linux/arch/x86_64/ia32/Makefile
--- linux-2.5.51-bk2/arch/x86_64/ia32/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/x86_64/ia32/Makefile	Sun Dec 15 10:09:28 2002
@@ -7,5 +7,3 @@
 obj-$(CONFIG_IA32_EMULATION) := ia32entry.o sys_ia32.o ia32_ioctl.o \
 	ia32_signal.o \
 	ia32_binfmt.o fpu32.o socket32.o ptrace32.o ipc32.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/x86_64/kernel/Makefile linux/arch/x86_64/kernel/Makefile
--- linux-2.5.51-bk2/arch/x86_64/kernel/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/arch/x86_64/kernel/Makefile	Sun Dec 15 10:09:28 2002
@@ -24,6 +24,3 @@
 obj-$(CONFIG_DUMMY_IOMMU) += pci-nommu.o
 
 EXTRA_AFLAGS := -traditional
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk2/arch/x86_64/lib/Makefile linux/arch/x86_64/lib/Makefile
--- linux-2.5.51-bk2/arch/x86_64/lib/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/x86_64/lib/Makefile	Sun Dec 15 10:09:28 2002
@@ -17,5 +17,3 @@
 
 obj-$(CONFIG_IO_DEBUG) += iodebug.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/x86_64/mm/Makefile linux/arch/x86_64/mm/Makefile
--- linux-2.5.51-bk2/arch/x86_64/mm/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/arch/x86_64/mm/Makefile	Sun Dec 15 10:09:28 2002
@@ -5,5 +5,3 @@
 export-objs := pageattr.o
 
 obj-y	 := init.o fault.o ioremap.o extable.o modutil.o pageattr.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk2/arch/x86_64/pci/Makefile linux/arch/x86_64/pci/Makefile
--- linux-2.5.51-bk2/arch/x86_64/pci/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/arch/x86_64/pci/Makefile	Sun Dec 15 10:09:28 2002
@@ -12,5 +12,3 @@
 
 
 obj-y		+= irq.o common.o
-
-include $(TOPDIR)/Rules.make

--------------080509050902050505020001--

