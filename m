Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSKYQTY>; Mon, 25 Nov 2002 11:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKYQTU>; Mon, 25 Nov 2002 11:19:20 -0500
Received: from host194.steeleye.com ([66.206.164.34]:59404 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261448AbSKYQSu>; Mon, 25 Nov 2002 11:18:50 -0500
Message-Id: <200211251625.gAPGPup02807@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: Voyager subarchitecture (and other subarch updates) for 2.5.49
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_6809181040"
Date: Mon, 25 Nov 2002 10:25:56 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_6809181040
Content-Type: text/plain; charset=us-ascii

This patch adds

- missing CONFIG_X86_HT define from cpu/proc
- Subarchitecture menu (Adrian Bunk)
- Change voyager dump key to V and document it (Randy Dunlap)

The voyager project and the hardware is described at

http://www.hansenpartnership.com/voyager

The voyager project bitkeeper tree is at

http://linux-voyager.bkbits.net/voyager-2.5

James


--==_Exmh_6809181040
Content-Type: text/plain ; name="voyager-2.5.49.diff"; charset=us-ascii
Content-Description: voyager-2.5.49.diff
Content-Disposition: attachment; filename="voyager-2.5.49.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.857   -> 1.862  
#	arch/i386/kernel/process.c	1.19.1.18 -> 1.37   
#	include/asm-i386/desc.h	1.9.1.1 -> 1.11   
#	arch/i386/kernel/timers/Makefile	1.2     -> 1.4    
#	arch/i386/boot/setup.S	1.8.2.3 -> 1.16   
#	arch/i386/kernel/cpu/common.c	1.13    -> 1.14   
#	include/asm-i386/processor.h	1.31    -> 1.32   
#	arch/i386/kernel/irq.c	1.8.1.16 -> 1.21   
#	arch/i386/kernel/head.S	1.15.1.2 -> 1.18   
#	include/asm-i386/irq.h	1.3.1.4 -> 1.8    
#	arch/i386/mach-voyager/Makefile	1.1     ->         (deleted)      
#	   arch/i386/Kconfig	1.2.2.8 -> 1.14   
#	arch/i386/kernel/traps.c	1.20.1.16 -> 1.37   
#	arch/i386/kernel/Makefile	1.4.1.25 -> 1.34   
#	arch/i386/mach-voyager/irq_vectors.h	1.1     ->         (deleted)      
#	include/asm-i386/segment.h	1.2     -> 1.3    
#	arch/i386/kernel/entry.S	1.33.1.14 -> 1.44   
#	arch/i386/mach-voyager/voyager_basic.c	1.1     ->         (deleted)      
#	arch/i386/mach-generic/Makefile	1.1.1.5 -> 1.7    
#	arch/i386/kernel/mpparse.c	1.9.1.16 -> 1.27   
#	  arch/i386/Makefile	1.4.1.26 -> 1.25   
#	arch/i386/mach-voyager/setup_arch_post.h	1.1     ->         (deleted)      
#	arch/i386/mach-voyager/voyager_smp.c	1.1     ->         (deleted)      
#	arch/i386/kernel/trampoline.S	1.4.1.1 -> 1.6    
#	arch/i386/pci/common.c	1.21.1.13 -> 1.36   
#	arch/i386/mach-voyager/setup_arch_pre.h	1.1     ->         (deleted)      
#	     fs/binfmt_elf.c	1.25.1.8 -> 1.32   
#	arch/i386/kernel/setup.c	1.40.1.23 -> 1.67   
#	arch/i386/kernel/smpboot.c	1.15.1.25 -> 1.41   
#	Documentation/sysrq.txt	1.5     -> 1.6    
#	arch/i386/kernel/time.c	1.5.1.17 -> 1.22   
#	include/asm-i386/vic.h	1.1     ->         (deleted)      
#	include/asm-i386/smp.h	1.9.1.8 -> 1.19   
#	arch/i386/boot/compressed/misc.c	1.7.1.2 -> 1.10   
#	         MAINTAINERS	1.68.1.58 -> 1.99   
#	Documentation/voyager.txt	1.1     ->         (deleted)      
#	arch/i386/mach-voyager/voyager_thread.c	1.1     ->         (deleted)      
#	arch/i386/kernel/timers/timer_tsc.c	1.5.1.1 -> 1.7    
#	include/asm-i386/hardirq.h	1.5.1.11 -> 1.16   
#	arch/i386/kernel/mca.c	1.4.1.5 -> 1.11   
#	arch/i386/mach-voyager/do_timer.h	1.1     ->         (deleted)      
#	arch/i386/mach-voyager/setup.c	1.1     ->         (deleted)      
#	arch/i386/mach-voyager/entry_arch.h	1.1     ->         (deleted)      
#	      kernel/sched.c	1.51.1.96 -> 1.84   
#	arch/i386/mach-voyager/voyager_cat.c	1.1     ->         (deleted)      
#	arch/i386/kernel/timers/timer_pit.c	1.3.1.2 -> 1.8    
#	drivers/char/sysrq.c	1.9.1.14 -> 1.24   
#	arch/i386/kernel/cpu/proc.c	1.6     -> 1.7    
#	include/asm-i386/voyager.h	1.1     ->         (deleted)      
#	arch/i386/kernel/i8259.c	1.7.1.11 -> 1.19   
#	arch/i386/boot/compressed/head.S	1.2     -> 1.3    
#	arch/i386/kernel/timers/timer.c	1.3     -> 1.5    
#	include/asm-i386/hw_irq.h	1.9.1.6 -> 1.16   
#	arch/i386/kernel/i386_ksyms.c	1.18.1.22 -> 1.37   
#	 arch/i386/pci/irq.c	1.12.1.8 -> 1.21   
#	arch/i386/kernel/apic.c	1.19.1.8 -> 1.24   
#	               (new)	        -> 1.2     arch/i386/mach-voyager/entry_arch.h
#	               (new)	        -> 1.3     include/asm-i386/voyager.h
#	               (new)	        -> 1.2     arch/i386/mach-voyager/irq_vectors.h
#	               (new)	        -> 1.4     arch/i386/mach-voyager/setup_arch_post.h
#	               (new)	        -> 1.7     arch/i386/mach-voyager/voyager_cat.c
#	               (new)	        -> 1.4     include/asm-i386/vic.h
#	               (new)	        -> 1.4     arch/i386/mach-voyager/do_timer.h
#	               (new)	        -> 1.30    arch/i386/mach-voyager/voyager_smp.c
#	               (new)	        -> 1.8     arch/i386/mach-voyager/voyager_thread.c
#	               (new)	        -> 1.9     arch/i386/mach-voyager/Makefile
#	               (new)	        -> 1.11    arch/i386/mach-voyager/voyager_basic.c
#	               (new)	        -> 1.4     arch/i386/mach-voyager/setup.c
#	               (new)	        -> 1.2     Documentation/voyager.txt
#	               (new)	        -> 1.2     arch/i386/mach-voyager/setup_arch_pre.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/22	jejb@mulgrave.(none)	1.858
# Merge mulgrave.(none):/home/jejb/BK/voyager-2.5
# into mulgrave.(none):/home/jejb/BK/voyager-new-2.5
# --------------------------------------------
# 02/11/22	jejb@mulgrave.(none)	1.859
# [VOYAGER] update do_fork semantics
# --------------------------------------------
# 02/11/23	jejb@mulgrave.(none)	1.860
# correct MCA/VOYAGER config dependency
# --------------------------------------------
# 02/11/23	jejb@mulgrave.(none)	1.861
# voyager sysrq usage [rddunlap@osdl.org]
# 
# This patch (to 2.5.48 plain) moves the Voyager sysrq dump key
# from 'C' to 'V' and makes the 'V' a capital V in the help_msg.
# The latter is the way that the other sysrq help messages indicate
# which character key to use to invoke them, and it would be good
# if the Voyager sysrq dump did the same.
# 
# It also documents this key in Documentation/sysrq.txt .
# --------------------------------------------
# 02/11/25	jejb@mulgrave.(none)	1.862
# add subarchitecture menu [Adrian Bunk]
# 
# move all the subarchitecture options to their own menu with a default
# being the PC subarchitecture.
# --------------------------------------------
#
diff -Nru a/Documentation/sysrq.txt b/Documentation/sysrq.txt
--- a/Documentation/sysrq.txt	Mon Nov 25 10:17:14 2002
+++ b/Documentation/sysrq.txt	Mon Nov 25 10:17:14 2002
@@ -59,6 +59,8 @@
 
 'm'     - Will dump current memory info to your console.
 
+'v'	- Dumps Voyager SMP processor info to your console.
+
 '0'-'9' - Sets the console log level, controlling which kernel messages
           will be printed to your console. ('0', for example would make
           it so that only emergency messages like PANICs or OOPSes would
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/Kconfig	Mon Nov 25 10:17:13 2002
@@ -39,6 +39,33 @@
 menu "Processor type and features"
 
 choice
+	prompt "Subarchitecture Type"
+	default PC
+
+config PC
+	bool PC
+	help
+	  Choose this option if your computer is a standard PC or compatible.
+
+config VOYAGER
+	bool "NCR Voyager Architecture"
+	---help---
+	  Voyager is a MCA based 32 way capable SMP architecture proprietary
+	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are voyager based.
+	  
+	  *** WARNING ***
+	
+	  If you do not specifically know you have a Voyager based machine,
+	  say N here otherwise the kernel you build will not be bootable.
+
+# Visual Workstation support is utterly broken.
+# If you want to see it working mail an VW540 to hch@infradead.org 8)
+#bool 'SGI Visual Workstation support' CONFIG_VISWS
+
+endchoice
+
+
+choice
 	prompt "Processor family"
 	default M686
 
@@ -253,11 +280,6 @@
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486
 	default y
 
-config X86_TSC
-	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || M586TSC
-	default y
-
 config X86_GOOD_APIC
 	bool
 	depends on MK7 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX
@@ -337,6 +359,7 @@
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
+	depends on !VOYAGER
 	---help---
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -788,6 +811,7 @@
 
 
 menu "Power management options (ACPI, APM)"
+	depends on !VOYAGER
 
 source "drivers/acpi/Kconfig"
 
@@ -961,9 +985,6 @@
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
 
-# Visual Workstation support is utterly broken.
-# If you want to see it working mail an VW540 to hch@infradead.org 8)
-#bool 'SGI Visual Workstation support' CONFIG_VISWS
 config X86_VISWS_APIC
 	bool
 	depends on VISWS
@@ -971,11 +992,12 @@
 
 config X86_LOCAL_APIC
 	bool
-	depends on !VISWS && SMP || VISWS
+	depends on ((!VISWS && SMP) || VISWS) && !VOYAGER
 	default y
 
 config PCI
 	bool "PCI support" if !VISWS
+	depends on !VOYAGER
 	default y if VISWS
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
@@ -990,7 +1012,7 @@
 
 config X86_IO_APIC
 	bool
-	depends on !VISWS && SMP
+	depends on !VISWS && SMP && !VOYAGER
 	default y
 
 choice
@@ -1034,6 +1056,7 @@
 
 config SCx200
 	tristate "NatSemi SCx200 support"
+	depends on !VOYAGER
 	help
 	  This provides basic support for the National Semiconductor SCx200 
 	  processor.  Right now this is just a driver for the GPIO pins.
@@ -1047,6 +1070,7 @@
 
 config ISA
 	bool "ISA support"
+	depends on !VOYAGER
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
@@ -1072,13 +1096,17 @@
 
 config MCA
 	bool "MCA support"
-	depends on !VISWS
+	depends on !VISWS && !VOYAGER
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
+config MCA
+	depends on VOYAGER
+	default y if VOYAGER
+
 config HOTPLUG
 	bool "Support for hot-pluggable devices"
 	---help---
@@ -1614,12 +1642,12 @@
 
 config X86_EXTRA_IRQS
 	bool
-	depends on X86_LOCAL_APIC
+	depends on X86_LOCAL_APIC || VOYAGER
 	default y
 
 config X86_FIND_SMP_CONFIG
 	bool
-	depends on X86_LOCAL_APIC
+	depends on X86_LOCAL_APIC || VOYAGER
 	default y
 
 config X86_MPPARSE
@@ -1637,15 +1665,20 @@
 
 config X86_SMP
 	bool
-	depends on SMP
+	depends on SMP && !VOYAGER
 	default y
 
 config X86_HT
 	bool
-	depends on SMP
+	depends on SMP && !VOYAGER
 	default y
 
 config X86_BIOS_REBOOT
 	bool
+	depends on !VOYAGER
 	default y
 
+config X86_TRAMPOLINE
+	bool
+	depends on SMP
+	default y
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/Makefile	Mon Nov 25 10:17:13 2002
@@ -49,7 +49,11 @@
 ifdef CONFIG_VISWS
 MACHINE	:= mach-visws
 else
+ifdef CONFIG_VOYAGER
+MACHINE:= mach-voyager
+else
 MACHINE	:= mach-generic
+endif
 endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
diff -Nru a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
--- a/arch/i386/boot/compressed/head.S	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/boot/compressed/head.S	Mon Nov 25 10:17:14 2002
@@ -31,7 +31,7 @@
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
+	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
@@ -74,7 +74,7 @@
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	ljmp $(__BOOT_CS), $0x100000
 
 /*
  * We come here, if we were loaded high.
@@ -101,7 +101,7 @@
 	popl %eax	# hcount
 	movl $0x100000,%edi
 	cli		# make sure we don't get interrupted
-	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
+	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
 
 /*
  * Routine (template) for moving the decompressed kernel in place,
@@ -124,5 +124,5 @@
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	ljmp $(__BOOT_CS), $0x100000
 move_routine_end:
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/boot/compressed/misc.c	Mon Nov 25 10:17:14 2002
@@ -299,7 +299,7 @@
 struct {
 	long * a;
 	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
 
 static void setup_normal_output_buffer(void)
 {
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/boot/setup.S	Mon Nov 25 10:17:13 2002
@@ -476,6 +476,24 @@
 	movsb
 	popw	%ds
 no_mca:
+#ifdef CONFIG_VOYAGER
+	movb	$0xff, 0x40	# flag on config found
+	movb	$0xc0, %al
+	mov	$0xff, %ah
+	int	$0x15		# put voyager config info at es:di
+	jc	no_voyager
+	movw	$0x40, %si	# place voyager info in apm table
+	cld
+	movw	$7, %cx
+voyager_rep:
+	movb	%es:(%di), %al
+	movb	%al,(%si)
+	incw	%di
+	incw	%si
+	decw	%cx
+	jnz	voyager_rep
+no_voyager:	
+#endif
 # Check for PS/2 pointing device
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# aka INITSEG
@@ -740,6 +758,7 @@
 A20_ENABLE_LOOPS	= 255		# Total loops to try		
 
 
+#ifndef CONFIG_VOYAGER
 a20_try_loop:
 
 	# First, see if we are on a system with no A20 gate.
@@ -758,11 +777,14 @@
 	jnz	a20_done
 
 	# Try enabling A20 through the keyboard controller
+#endif /* CONFIG_VOYAGER */
 a20_kbc:
 	call	empty_8042
 
+#ifndef CONFIG_VOYAGER
 	call	a20_test			# Just in case the BIOS worked
 	jnz	a20_done			# but had a delayed reaction.
+#endif
 
 	movb	$0xD1, %al			# command write
 	outb	%al, $0x64
@@ -772,6 +794,7 @@
 	outb	%al, $0x60
 	call	empty_8042
 
+#ifndef CONFIG_VOYAGER
 	# Wait until a20 really *is* enabled; it can take a fair amount of
 	# time on certain systems; Toshiba Tecras are known to have this
 	# problem.
@@ -819,6 +842,7 @@
 	# If we get here, all is good
 a20_done:
 
+#endif /* CONFIG_VOYAGER */
 # set up gdt and idt
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
@@ -870,7 +894,7 @@
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
 # NOTE: For high loaded big kernels we need a
-#	jmpi    0x100000,__KERNEL_CS
+#	jmpi    0x100000,__BOOT_CS
 #
 #	but we yet haven't reloaded the CS register, so the default size 
 #	of the target offset still is 16 bit.
@@ -881,7 +905,7 @@
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
 code32:	.long	0x1000				# will be set to 0x100000
 						# for big kernels
-	.word	__KERNEL_CS
+	.word	__BOOT_CS
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
@@ -985,6 +1009,7 @@
 	.string	"INT15 refuses to access high mem, giving up."
 
 
+#ifndef CONFIG_VOYAGER
 # This routine tests whether or not A20 is enabled.  If so, it
 # exits with zf = 0.
 #
@@ -1015,6 +1040,8 @@
 	popw	%cx
 	ret	
 
+#endif /* CONFIG_VOYAGER */
+
 # This routine checks that the keyboard command queue is empty
 # (after emptying the output buffers)
 #
@@ -1075,13 +1102,19 @@
 
 # Descriptor tables
 #
-# NOTE: if you think the GDT is large, you can make it smaller by just
-# defining the KERNEL_CS and KERNEL_DS entries and shifting the gdt
-# address down by GDT_ENTRY_KERNEL_CS*8. This puts bogus entries into
-# the GDT, but those wont be used so it's not a problem.
+# NOTE: The intel manual says gdt should be sixteen bytes aligned for
+# efficiency reasons.  However, there are machines which are known not
+# to boot with misaligned GDTs, so alter this at your peril!  If you alter
+# GDT_ENTRY_BOOT_CS (in asm/segment.h) remember to leave at least two
+# empty GDT entries (one for NULL and one reserved).
+#
+# NOTE:	On some CPUs, the GDT must be 8 byte aligned.  This is
+# true for the Voyager Quad CPU card which will not boot without
+# This directive.  16 byte aligment is recommended by intel.
 #
+	.align 16
 gdt:
-	.fill GDT_ENTRY_KERNEL_CS,8,0
+	.fill GDT_ENTRY_BOOT_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
@@ -1094,12 +1127,17 @@
 	.word	0x9200				# data read/write
 	.word	0x00CF				# granularity = 4096, 386
 						#  (+5th nibble of limit)
+gdt_end:
+	.align	4
+	
+	.word	0				# alignment byte
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
-gdt_48:
-	.word	GDT_ENTRY_KERNEL_CS*8 + 16 - 1	# gdt limit
 
+	.word	0				# alignment byte
+gdt_48:
+	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
 # Include video setup & detection code
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/kernel/Makefile	Mon Nov 25 10:17:13 2002
@@ -20,7 +20,8 @@
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
-obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o trampoline.o
+obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/kernel/cpu/common.c	Mon Nov 25 10:17:13 2002
@@ -42,25 +42,6 @@
 }
 __setup("cachesize=", cachesize_setup);
 
-#ifndef CONFIG_X86_TSC
-static int tsc_disable __initdata = 0;
-
-static int __init tsc_setup(char *str)
-{
-	tsc_disable = 1;
-	return 1;
-}
-#else
-#define tsc_disable 0
-
-static int __init tsc_setup(char *str)
-{
-	printk("notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.\n");
-	return 1;
-}
-#endif
-__setup("notsc", tsc_setup);
-
 int __init get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
diff -Nru a/arch/i386/kernel/cpu/proc.c b/arch/i386/kernel/cpu/proc.c
--- a/arch/i386/kernel/cpu/proc.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/kernel/cpu/proc.c	Mon Nov 25 10:17:14 2002
@@ -74,7 +74,7 @@
 	/* Cache size */
 	if (c->x86_cache_size >= 0)
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_HT
 	if (cpu_has_ht) {
 		extern int phys_proc_id[NR_CPUS];
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/kernel/head.S	Mon Nov 25 10:17:13 2002
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
+#include <asm/cache.h>
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -46,7 +47,7 @@
  * Set segments to known values
  */
 	cld
-	movl $(__KERNEL_DS),%eax
+	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
@@ -306,7 +307,7 @@
 
 ENTRY(stack_start)
 	.long init_thread_union+8192
-	.long __KERNEL_DS
+	.long __BOOT_DS
 
 /* This is the default interrupt "handler" :-) */
 int_msg:
@@ -349,12 +350,12 @@
 	.long idt_table
 
 # boot GDT descriptor (later on used by CPU#0):
-
+	.word 0				# 32 bit align gdt_desc.address
 cpu_gdt_descr:
 	.word GDT_ENTRIES*8-1
 	.long cpu_gdt_table
 
-	.fill NR_CPUS-1,6,0		# space for the other GDT descriptors
+	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
 
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
@@ -405,10 +406,21 @@
  */
 .data
 
-ALIGN
 /*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
+#ifdef CONFIG_SMP
+/*
+ * The boot_gdt_table must mirror the equivalent in setup.S and is
+ * used only by the trampoline for booting other CPUs
+ */
+	.align L1_CACHE_BYTES
+ENTRY(boot_gdt_table)
+	.fill GDT_ENTRY_BOOT_CS,8,0
+	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
+#endif
+	.align L1_CACHE_BYTES
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/kernel/irq.c	Mon Nov 25 10:17:13 2002
@@ -167,7 +167,7 @@
 		if (cpu_online(j))
 			p += seq_printf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/kernel/timers/Makefile	Mon Nov 25 10:17:13 2002
@@ -2,10 +2,8 @@
 # Makefile for x86 timers
 #
 
-obj-y:= timer.o
+obj-y:= timer.o timer_tsc.o timer_pit.o
 
-obj-y += timer_tsc.o
-obj-y += timer_pit.o
-obj-$(CONFIG_X86_CYCLONE)   += timer_cyclone.o
+obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/kernel/timers/timer.c	Mon Nov 25 10:17:14 2002
@@ -8,9 +8,7 @@
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
 	&timer_tsc,
-#ifndef CONFIG_X86_TSC
 	&timer_pit,
-#endif
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Nov 25 10:17:14 2002
@@ -9,7 +9,9 @@
 #include <linux/irq.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
+#include <asm/smp.h>
 #include <asm/io.h>
+#include <asm/arch_hooks.h>
 
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 25 10:17:14 2002
@@ -11,6 +11,10 @@
 
 #include <asm/timer.h>
 #include <asm/io.h>
+/* processor.h for distable_tsc flag */
+#include <asm/processor.h>
+
+int tsc_disable __initdata = 0;
 
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
@@ -286,6 +290,18 @@
 	}
 	return -ENODEV;
 }
+
+/* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
+ * in cpu/common.c */
+static int __init tsc_setup(char *str)
+{
+	tsc_disable = 1;
+	return 1;
+}
+
+__setup("notsc", tsc_setup);
+
+
 
 /************************************************************/
 
diff -Nru a/arch/i386/kernel/trampoline.S b/arch/i386/kernel/trampoline.S
--- a/arch/i386/kernel/trampoline.S	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/kernel/trampoline.S	Mon Nov 25 10:17:14 2002
@@ -54,7 +54,7 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
-	ljmpl	$__KERNEL_CS, $0x00100000
+	ljmpl	$__BOOT_CS, $0x00100000
 			# jump to startup_32 in arch/i386/kernel/head.S
 
 idt_48:
@@ -67,8 +67,8 @@
 #
 
 gdt_48:
-	.word	0x0800			# gdt limit = 2048, 256 GDT entries
-	.long	cpu_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
+	.word	__BOOT_DS + 7			# gdt limit
+	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl trampoline_end
 trampoline_end:
diff -Nru a/arch/i386/mach-voyager/setup.c b/arch/i386/mach-voyager/setup.c
--- a/arch/i386/mach-voyager/setup.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/mach-voyager/setup.c	Mon Nov 25 10:17:14 2002
@@ -29,6 +29,9 @@
 
 void __init pre_setup_arch_hook(void)
 {
+	/* Voyagers run their CPUs from independent clocks, so disable
+	 * the TSC code because we can't sync them */
+	tsc_disable = 1;
 }
 
 void __init trap_init_hook(void)
diff -Nru a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
--- a/arch/i386/mach-voyager/voyager_basic.c	Mon Nov 25 10:17:13 2002
+++ b/arch/i386/mach-voyager/voyager_basic.c	Mon Nov 25 10:17:14 2002
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
+#include <linux/sysrq.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/voyager.h>
@@ -41,6 +42,21 @@
 
 struct voyager_SUS *voyager_SUS = NULL;
 
+#ifdef CONFIG_SMP
+static void
+voyager_dump(int dummy1, struct pt_regs *dummy2, struct tty_struct *dummy3)
+{
+	/* get here via a sysrq */
+	voyager_smp_dump();
+}
+
+static struct sysrq_key_op sysrq_voyager_dump_op = {
+	.handler	= voyager_dump,
+	.help_msg	= "Voyager",
+	.action_msg	= "Dump Voyager Status\n",
+};
+#endif
+
 void
 voyager_detect(struct voyager_bios_info *bios)
 {
@@ -62,6 +78,9 @@
 			printk("\n**WARNING**: Voyager HAL only supports Levels 4 and 5 Architectures at the moment\n\n");
 		/* install the power off handler */
 		pm_power_off = voyager_power_off;
+#ifdef CONFIG_SMP
+		register_sysrq_key('v', &sysrq_voyager_dump_op);
+#endif
 	} else {
 		printk("\n\n**WARNING**: No Voyager Subsystem Found\n");
 	}
@@ -141,15 +160,6 @@
 	pg0[0] = old;
 	local_flush_tlb();
 	return retval;
-}
-
-void
-voyager_dump()
-{
-	/* get here via a sysrq */
-#ifdef CONFIG_SMP
-	voyager_smp_dump();
-#endif
 }
 
 /* voyager specific handling code for timer interrupts.  Used to hand
diff -Nru a/arch/i386/mach-voyager/voyager_smp.c b/arch/i386/mach-voyager/voyager_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c	Mon Nov 25 10:17:14 2002
+++ b/arch/i386/mach-voyager/voyager_smp.c	Mon Nov 25 10:17:14 2002
@@ -50,11 +50,6 @@
  * indexed physically */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
-/* Per CPU interrupt stacks */
-extern union thread_union init_irq_union;
-union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =
-	{ &init_irq_union, };
-
 /* physical ID of the CPU used to boot the system */
 unsigned char boot_cpu_id;
 
@@ -450,6 +445,7 @@
 	struct cpuinfo_x86 *c=&cpu_data[id];
 
 	*c = boot_cpu_data;
+
 	identify_cpu(c);
 }
 
@@ -512,6 +508,11 @@
 	/* if we're a quad, we may need to bootstrap other CPUs */
 	do_quad_bootstrap();
 
+	/* FIXME: this is rather a poor hack to prevent the CPU
+	 * activating softirqs while it's supposed to be waiting for
+	 * permission to proceed.  Without this, the new per CPU stuff
+	 * in the softirqs will fail */
+	local_irq_disable();
 	set_bit(cpuid, &cpu_callin_map);
 
 	/* signal that we're done */
@@ -519,6 +520,7 @@
 
 	while (!test_bit(cpuid, &smp_commenced_mask))
 		rep_nop();
+	local_irq_enable();
 
 	local_flush_tlb();
 
@@ -533,29 +535,7 @@
 	struct pt_regs regs;
 	/* don't care about the eip and regs settings since we'll
 	 * never reschedule the forked task. */
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
-}
-
-
-static void __init setup_irq_stack(struct task_struct *p, int cpu)
-{
-	unsigned long stk;
-
-	stk = __get_free_pages(GFP_KERNEL, THREAD_ORDER+1);
-	if (!stk)
-		panic("I can't seem to allocate my irq stack.  Oh well, giving up.");
-
-	irq_stacks[cpu] = (void *)stk;
-	memset(irq_stacks[cpu], 0, THREAD_SIZE);
-	irq_stacks[cpu]->thread_info.cpu = cpu;
-	irq_stacks[cpu]->thread_info.preempt_count = 1;
-					/* interrupts are not preemptable */
-	p->thread_info->irq_stack = irq_stacks[cpu];
-
-	/* If we want to make the irq stack more than one unit
-	 * deep, we can chain then off of the irq_stack pointer
-	 * here.
-	 */
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }
 
 
@@ -617,20 +597,17 @@
 	if(IS_ERR(idle))
 		panic("failed fork for CPU%d", cpu);
 
-	setup_irq_stack(idle, cpu);
-
 	init_idle(idle, cpu);
 
 	idle->thread.eip = (unsigned long) start_secondary;
 	unhash_process(idle);
-
-	/* The -4 is to correct for the fact that the stack pointer
-	 * is used to find the location of the thread_info structure
-	 * by masking off several of the LSBs.  Without the -4, esp
-	 * is pointing to the page after the one the stack is on.
-	 */
-	stack_start.esp = (void *)(THREAD_SIZE - 4 + (char *)idle->thread_info);
-
+	/* init_tasks (in sched.c) is indexed logically */
+#if 0
+	// for AC kernels
+	stack_start.esp = (THREAD_SIZE + (__u8 *)TSK_TO_KSTACK(idle));
+#else
+	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+#endif
 	/* Note: Don't modify initial ss override */
 	VDEBUG(("VOYAGER SMP: Booting CPU%d at 0x%lx[%x:%x], stack %p\n", cpu, 
 		(unsigned long)hijack_source.val, hijack_source.idt.Segment,
@@ -764,6 +741,9 @@
 
 	/* enable our own CPIs */
 	vic_enable_cpi();
+
+	set_bit(boot_cpu_id, &cpu_online_map);
+	set_bit(boot_cpu_id, &cpu_callout_map);
 	
 	/* loop over all the extended VIC CPUs and boot them.  The 
 	 * Quad CPUs must be bootstrapped by their extended VIC cpu */
@@ -1312,12 +1292,9 @@
 static inline void
 wrapper_smp_local_timer_interrupt(struct pt_regs *regs)
 {
-	__u8 cpu = smp_processor_id();
-
 	irq_enter();
 	smp_local_timer_interrupt(regs);
 	irq_exit();
-	
 }
 
 /* local (per CPU) timer interrupt.  It does both profiling and
diff -Nru a/drivers/char/sysrq.c b/drivers/char/sysrq.c
--- a/drivers/char/sysrq.c	Mon Nov 25 10:17:14 2002
+++ b/drivers/char/sysrq.c	Mon Nov 25 10:17:14 2002
@@ -35,10 +35,6 @@
 
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_VOYAGER
-#include <asm/voyager.h>
-#endif
-
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
@@ -323,14 +319,6 @@
 	.action_msg	= "Terminate All Tasks",
 };
 
-#ifdef CONFIG_VOYAGER
-static struct sysrq_key_op sysrq_voyager_dump_op = {
-	.handler	= voyager_dump,
-	.help_msg	= "voyager",
-	.action_msg	= "Dump Voyager Status\n",
-};
-#endif
-
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
@@ -364,11 +352,7 @@
 		 it is handled specially on the sparc
 		 and will never arrive */
 /* b */	&sysrq_reboot_op,
-#ifdef CONFIG_VOYAGER
-/* c */ &sysrq_voyager_dump_op,
-#else
-/* c */	NULL,
-#endif
+/* c */ NULL,
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
@@ -396,7 +380,7 @@
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,
-/* v */	NULL,
+/* v */	NULL, /* May be assigned at init time by SMP VOYAGER */
 /* w */	NULL,
 /* x */	NULL,
 /* y */	NULL,
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Mon Nov 25 10:17:13 2002
+++ b/include/asm-i386/desc.h	Mon Nov 25 10:17:13 2002
@@ -13,6 +13,7 @@
 struct Xgt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
+	unsigned short pad;
 } __attribute__ ((packed));
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
diff -Nru a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
--- a/include/asm-i386/hw_irq.h	Mon Nov 25 10:17:14 2002
+++ b/include/asm-i386/hw_irq.h	Mon Nov 25 10:17:14 2002
@@ -131,7 +131,7 @@
 
 #endif /* CONFIG_PROFILING */
  
-#ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
+#if defined(CONFIG_SMP) && !defined(CONFIG_VOYAGER) /*more of this file should probably be ifdefed SMP */
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
 		send_IPI_self(IO_APIC_VECTOR(i));
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Mon Nov 25 10:17:13 2002
+++ b/include/asm-i386/processor.h	Mon Nov 25 10:17:13 2002
@@ -18,6 +18,9 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 
+/* flag for disabling the tsc */
+extern int tsc_disable;
+
 struct desc_struct {
 	unsigned long a,b;
 };
diff -Nru a/include/asm-i386/segment.h b/include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Mon Nov 25 10:17:13 2002
+++ b/include/asm-i386/segment.h	Mon Nov 25 10:17:13 2002
@@ -69,6 +69,14 @@
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
+/* Simple and small GDT entries for booting only */
+
+#define GDT_ENTRY_BOOT_CS		2
+#define __BOOT_CS	(GDT_ENTRY_BOOT_CS * 8)
+
+#define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
+#define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
+
 /*
  * The interrupt descriptor table has room for 256 idt's,
  * the global descriptor table is dependent on the number
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Mon Nov 25 10:17:14 2002
+++ b/include/asm-i386/smp.h	Mon Nov 25 10:17:14 2002
@@ -6,6 +6,7 @@
  */
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
+#include <linux/kernel.h>
 #include <linux/threads.h>
 #endif
 
@@ -83,11 +84,22 @@
 #define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
+#define for_each_cpu(cpu, mask) \
+	for(mask = cpu_online_map; \
+	    cpu = __ffs(mask), mask != 0; \
+	    mask &= ~(1<<cpu))
+
 extern inline unsigned int num_online_cpus(void)
 {
 	return hweight32(cpu_online_map);
 }
 
+/* We don't mark CPUs online until __cpu_up(), so we need another measure */
+static inline int num_booting_cpus(void)
+{
+	return hweight32(cpu_callout_map);
+}
+
 extern inline int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
@@ -95,7 +107,7 @@
 
 	return -1;
 }
-
+#ifdef CONFIG_X86_LOCAL_APIC
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
@@ -108,12 +120,7 @@
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
 
-/* We don't mark CPUs online until __cpu_up(), so we need another measure */
-static inline int num_booting_cpus(void)
-{
-	return hweight32(cpu_callout_map);
-}
-
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
diff -Nru a/include/asm-i386/voyager.h b/include/asm-i386/voyager.h
--- a/include/asm-i386/voyager.h	Mon Nov 25 10:17:14 2002
+++ b/include/asm-i386/voyager.h	Mon Nov 25 10:17:14 2002
@@ -504,7 +504,6 @@
 extern int voyager_memory_detect(int region, __u32 *addr, __u32 *length);
 extern void voyager_smp_intr_init(void);
 extern __u8 voyager_extended_cmos_read(__u16 cmos_address);
-extern void voyager_dump(void);
 extern void voyager_smp_dump(void);
 extern void voyager_timer_interrupt(struct pt_regs *regs);
 extern void smp_local_timer_interrupt(struct pt_regs * regs);

--==_Exmh_6809181040--


