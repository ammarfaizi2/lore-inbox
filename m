Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTGAH7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTGAH7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:59:24 -0400
Received: from u156n67.hfx.eastlink.ca ([24.222.156.67]:55948 "EHLO
	llama.nslug.ns.ca") by vger.kernel.org with ESMTP id S261188AbTGAH7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:59:15 -0400
Date: Tue, 1 Jul 2003 05:13:36 -0300
To: linux-kernel@vger.kernel.org
Subject: some edits to the Kconfig online help (2.5.73)
Message-ID: <20030701081336.GA26749@llama.nslug.ns.ca>
References: <20030701061915.GA26385@llama.nslug.ns.ca> <20030701080249.GA2548@finwe.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20030701080249.GA2548@finwe.eu.org>
User-Agent: Mutt/1.3.28i
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2003 at 10:02:50AM +0200, Jacek Kawa wrote:
> Peter Cordes wrote:
> 
> >  Attached is a patch to arch/i386/Kconfig for Linux 2.5.73.  
> 
> Hmm, you may want to repost it with patch (really) attached :-)
> 

 Yeah, good idea :)

 please CC on replies.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug.n , s.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i386-Kconfig.patch"

--- linux-2.5.73/arch/i386/Kconfig.old	Sun Jun 22 15:32:34 2003
+++ linux-2.5.73/arch/i386/Kconfig	Tue Jul  1 02:39:18 2003
@@ -57,17 +57,17 @@
 config X86_NUMAQ
 	bool "NUMAQ (IBM/Sequent)"
 	help
-	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
-	  multiquad box. This changes the way that processors are bootstrapped,
-	  and uses Clustered Logical APIC addressing mode instead of Flat Logical.
-	  You will need a new lynxer.elf file to flash your firmware with - send
-	  email to Martin.Bligh@us.ibm.com
+	  Support for (IBM/Sequent) NUMA multiquad box.  This changes the
+	  way that processors are bootstrapped, and uses Clustered Logical
+	  APIC addressing mode instead of Flat Logical.  You will need a new
+	  lynxer.elf file to flash your firmware with - send email to
+	  Martin.Bligh@us.ibm.com
 
 config X86_SUMMIT
 	bool "Summit/EXA (IBM x440)"
 	depends on SMP
 	help
-	  This option is needed for IBM systems that use the Summit/EXA chipset.
+	  Support for IBM systems that use the Summit/EXA chipset.
 	  In particular, it is needed for the x440.
 
 	  If you don't have one of these computers, you should say N here.
@@ -76,8 +76,8 @@
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
 	depends on SMP
 	help
-	  This option is needed for the systems that have more than 8 CPUs
-	  and if the system is not of any sub-arch type above.
+	  Support for systems that have more than 8 CPUs, other than the
+	  sub-arch types above.
 
 	  If you don't have such a system, you should say N here.
 
@@ -96,7 +96,7 @@
        bool "Generic architecture (Summit, bigsmp, default)"
        depends on SMP
        help
-          This option compiles in the Summit, bigsmp, default subarchitectures.
+          Compile in the Summit, bigsmp, default subarchitectures.
 	  It is intended for a generic binary kernel.
 
 config X86_ES7000
@@ -303,9 +303,9 @@
 config X86_GENERIC
        bool "Generic x86 support" 
        help
-       	  Including some tuning for non selected x86 CPUs too.
-	  when it has moderate overhead. This is intended for generic 
-	  distributions kernels.
+       	  Including some tuning for non-selected x86 CPUs,
+	  when it has only moderate overhead. 
+	  This is intended for generic distributions kernels.
 
 #
 # Define implied options from the CPU selection here
@@ -400,7 +400,7 @@
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
-	  This enables support for huge pages.  User space applications
+	  Enable support for huge pages.  User space applications
 	  can make use of this support with the sys_alloc_hugepages and
 	  sys_free_hugepages system calls.  If your applications are
 	  huge page aware and your processor (Pentium or later for x86)
@@ -411,15 +411,15 @@
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
-	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
-
-	  If you say N here, the kernel will run on single and multiprocessor
-	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
-	  will run faster if you say N here.
+	  Enable support for systems with more than one CPU.  If you have
+	  a system with only one CPU, like most personal computers, say N.
+	  If you have a system with more than one CPU, say Y.
+
+	  A kernel without SMP support will run on single and multiprocessor
+	  machines, but will use only one CPU even on machine with more.  A
+	  kernel with SMP support will run on most single processor machines,
+	  but more slowly than if it was compiled for only single processor
+	  machines.
 
 	  Note that if you say Y here and choose architecture "586" or
 	  "Pentium" under "Processor family", the kernel will not work on 486
@@ -442,9 +442,9 @@
 	depends on SMP
 	default "32"
 	help
-	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support.  The maximum supported value is 32 and the
-	  minimum value which makes sense is 2.
+	  Specify the maximum number of CPUs which this kernel will support.
+	  The maximum supported value is 32 and the minimum value which
+	  makes sense is 2.
 
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
@@ -452,11 +452,11 @@
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load.
+	  Reduce the latency of the kernel when reacting to real-time or
+	  interactive events by allowing a low priority process to be
+	  preempted even if it is in kernel mode executing a system call.
+	  This allows applications to run more reliably even when the system
+	  is under load.
 
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
@@ -466,13 +466,12 @@
 	depends on !(X86_VISWS || X86_VOYAGER)
 	---help---
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
-	  integrated interrupt controller in the CPU. If you have a single-CPU
+	  integrated interrupt controller in the CPU.  If you have a single-CPU
 	  system which has a processor with a local APIC, you can say Y here to
-	  enable and use it. If you say Y here even though your machine doesn't
-	  have a local APIC, then the kernel will still run with no slowdown at
-	  all. The local APIC supports CPU-generated self-interrupts (timer,
-	  performance counters), and the NMI watchdog which detects hard
-	  lockups.
+	  enable and use it.  This option won't slow down the kernel on a
+	  machine without a local APICs.  The local APIC supports
+	  CPU-generated self-interrupts (timer, performance counters), and
+	  the NMI watchdog which detects hard lockups. 
 
 	  If you have a system with several CPUs, you do not need to say Y
 	  here: the local APIC will be used automatically.
@@ -512,8 +511,8 @@
 	  Machine Check Exception support allows the processor to notify the
 	  kernel if it detects a problem (e.g. overheating, component failure).
 	  The action the kernel takes depends on the severity of the problem,
-	  ranging from a warning message on the console, to halting the machine.
-	  Your processor must be a Pentium or newer to support this - check the
+	  ranging from a warning message on the console to halting the machine.
+	  Your processor must be a Pentium or newer to support this;  Check the
 	  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
 	  have a design flaw which leads to false MCE events - hence MCE is
 	  disabled on all P5 processors, unless explicitly enabled with "mce"
@@ -528,19 +527,18 @@
 	help
 	  Enabling this feature starts a timer that triggers every 5 seconds which
 	  will look at the machine check registers to see if anything happened.
-	  Non-fatal problems automatically get corrected (but still logged).
+	  Non-fatal problems automatically get corrected (and logged).
 	  Disable this if you don't want to see these messages.
-	  Seeing the messages this option prints out may be indicative of dying hardware,
-	  or out-of-spec (ie, overclocked) hardware.
-	  This option only does something on certain CPUs.
-	  (AMD Athlon/Duron and Intel Pentium 4)
+	  Seeing the messages this option prints out may be indicative of
+	  dying hardware, or out-of-spec (ie, overclocked) hardware.
+	  This option only does anything on certain CPUs:
+	  AMD Athlon/Duron and Intel Pentium 4.
 
 config X86_MCE_P4THERMAL
 	bool "check for P4 thermal throttling interrupt."
 	depends on X86_MCE && (X86_UP_APIC || SMP)
 	help
-	  Enabling this feature will cause a message to be printed when the P4
-	  enters thermal throttling.
+	  Cause a message to be printed when the P4 enters thermal throttling.
 
 config TOSHIBA
 	tristate "Toshiba Laptop support"
@@ -620,11 +618,11 @@
 	depends on EXPERIMENTAL
 	help
 	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
-	  Services real mode BIOS calls to determine which disk
-	  BIOS tries boot from.  This information is then exported via driverfs.
+	  Services real mode BIOS calls to determine which disk the BIOS
+	  tries to boot from.  This information is then exported via driverfs.
 
-	  This option is experimental, but believed to be safe,
-	  and most disk controller BIOS vendors do not yet implement this feature.
+	  This option is experimental, but believed to be safe.  However,
+	  most disk controller BIOS vendors do not yet implement this feature.
 
 choice
 	prompt "High Memory Support"
@@ -740,7 +738,7 @@
 	  is broken. Try "man bootparam" or see the documentation of your boot
 	  loader (lilo or loadlin) about how to pass options to the kernel at
 	  boot time.) This means that it is a good idea to say Y here if you
-	  intend to use this kernel on different machines.
+	  intend to use this kernel on different very old machines.
 
 	  More information about the internals of the Linux math coprocessor
 	  emulation can be found in <file:arch/i386/math-emu/README>.
@@ -759,7 +757,7 @@
 	  before bursting over the PCI/AGP bus. This can increase performance
 	  of image write operations 2.5 times or more. Saying Y here creates a
 	  /proc/mtrr file which may be used to manipulate your processor's
-	  MTRRs. Typically the X server should use this.
+	  MTRRs.  XFree86 4.0 and later uses this automatically.
 
 	  This code has a reasonably generic interface so that similar
 	  control registers on other processors can be easily supported
@@ -805,49 +803,44 @@
 	---help---
 	  "Power Management" means that parts of your computer are shut
 	  off or put into a power conserving "sleep" mode if they are not
-	  being used.  There are two competing standards for doing this: APM
-	  and ACPI.  If you want to use either one, say Y here and then also
-	  to the requisite support below.
-
-	  Power Management is most important for battery powered laptop
-	  computers; if you have a laptop, check out the Linux Laptop home
-	  page on the WWW at
-	  <http://www.cs.utexas.edu/users/kharker/linux-laptop/> and the
-	  Battery Powered Linux mini-HOWTO, available from
+	  being used.  There are two standards for doing this: APM and ACPI.
+	  If you want to use either one, say Y here and then also to the
+	  requisite support below.
+
+	  Power Management is most important for battery powered computers;
+	  if you have a laptop, check out the Linux Laptop home page on the
+	  WWW at <http://www.cs.utexas.edu/users/kharker/linux-laptop/> and
+	  the Battery Powered Linux mini-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
-	  Note that, even if you say N here, Linux on the x86 architecture
-	  will issue the hlt instruction if nothing is to be done, thereby
-	  sending the processor to sleep and saving power.
+	  Even if you say N here, Linux on the x86 architecture will issue
+	  the hlt instruction if nothing is to be done, thereby sending the
+	  processor to sleep until the next interrupt, saving power.
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
+	  Enable the possibilty of suspending the machine without using APM.
+	  You may suspend your machine with 'swsusp' or 'shutdown -z <time>'
+	  (patch for sysvinit needed).
+
+	  It creates an image which is saved in your active swaps. At the next
+	  boot, pass 'resume=/path/to/your/swap/file' and your kernel will 
+	  detect the saved image, restore the machine state from it, and
+	  continue to run from where it left off.  Use the 'noresume' option
+	  to boot without restoring, but your partitions will need an fsck,
+	  and your swap areas will need an mkswap.
+
+	  If you booting without resuming, it is dangerous to later restore
+	  the saved state, because disk buffers won't match what's on disk.
+
+	  SMP is supported ``as-is''.  There's code for it, but it doesn't work.
+	  There have been problems reported relating to SCSI.
+
+	  This option is nearly stable, but it lacks some features and
+	  support for saving/restoring the state of some hardware.  Thus, 
+	  be sure to check Documentation/swsusp.txt for caveats before using.
 
 source "drivers/acpi/Kconfig"
 
@@ -868,14 +861,14 @@
 	  Note that the APM support is almost completely disabled for
 	  machines with more than one CPU.
 
-	  In order to use APM, you will need supporting software. For location
-	  and more information, read <file:Documentation/pm.txt> and the
-	  Battery Powered Linux mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
+	  In order to use APM, you will need supporting software. Read
+	  <file:Documentation/pm.txt> and the Battery Powered Linux
+	  mini-HOWTO, available from <http://www.tldp.org/docs.html#howto>.
 
 	  This driver does not spin down disk drives (see the hdparm(8)
-	  manpage ("man 8 hdparm") for that), and it doesn't turn off
-	  VESA-compliant "green" monitors.
+	  man page ("man hdparm") for that), and it doesn't turn off
+	  VESA-compliant "green" monitors (see XF86Config(5) and/or xset(1)
+	  for XFree86, or setterm(1) on the console for that).
 
 	  This driver does not support the TI 4000M TravelMate and the ACER
 	  486/DX4/75 because they don't have compliant BIOSes. Many "green"
@@ -904,7 +897,7 @@
 	  8) disable the cache from your BIOS settings
 	  9) install a fan for the video card or exchange video RAM
 	  10) install a better fan for the CPU
-	  11) exchange RAM chips
+	  11) test (with memtest86) and/or exchange RAM chips
 	  12) exchange the motherboard.
 
 	  To compile this driver as a module ( = code which can be inserted in
@@ -1023,10 +1016,11 @@
 	depends on !X86_VOYAGER
 	default y if X86_VISWS
 	help
-	  Find out whether you have a PCI motherboard. PCI is the name of a
-	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  Modern PCs have PCI, but some Pentium and earlier computers don't.
+	  If your computer is of that vintage, you'll need to check.  PCI is
+	  the name of a bus system, i.e. the way the CPU talks to the other
+	  stuff inside your box.  Other bus systems are ISA, EISA,
+	  MicroChannel (MCA) or VESA.  If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>, contains valuable
@@ -1121,8 +1115,8 @@
 	tristate "NatSemi SCx200 support"
 	depends on !X86_VOYAGER
 	help
-	  This provides basic support for the National Semiconductor SCx200 
-	  processor.  Right now this is just a driver for the GPIO pins.
+	  Basic support for the National Semiconductor SCx200 processor.
+	  Right now this is just a driver for the GPIO pins. 
 
 	  If you don't know what to do here, say N.
 
@@ -1308,9 +1302,7 @@
 	tristate "Sound card support"
 	---help---
 	  If you have a sound card in your computer, i.e. if it can say more
-	  than an occasional beep, say Y.  Be sure to have all the information
-	  about your sound card and its configuration down (I/O port,
-	  interrupt and DMA channel), because you will be asked for it.
+	  than an occasional beep, say Y.
 
 	  You want to read the Sound-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>. General information about
@@ -1328,6 +1320,11 @@
 	  this, say M here and read <file:Documentation/modules.txt> as well
 	  as <file:Documentation/sound/README.modules>; the module will be
 	  called soundcore.
+	  
+	  If your sound card is connected to the ISA bus, and you're not
+	  using kernel ISA PnP support, be sure to have all the information 
+	  about your sound card and its configuration down (I/O port,
+	  interrupt and DMA channel), because you will be asked for it.
 
 	  I'm told that even without a sound card, you can make your computer
 	  say more than an occasional beep, by programming the PC speaker.
@@ -1403,7 +1400,7 @@
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
 	help
-	  This options enables addition error checking for high memory systems.
+	  This options enables additional error checking for high memory systems.
 	  Disable for production systems.
 
 config KALLSYMS

--azLHFNyN32YCQGCU--
