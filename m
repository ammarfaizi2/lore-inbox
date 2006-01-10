Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWAJAyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWAJAyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWAJAyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:54:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13581 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750776AbWAJAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:54:51 -0500
Date: Tue, 10 Jan 2006 01:54:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060110005449.GY3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following changes:

Adrian Bunk:
      spelling: s/usefull/useful/
      s/assoicated/associated/
      spelling: s/retreive/retrieve/
      spelling: s/trough/through/
      MAINTAINERS: remove BUSLOGIC entry
      remove the outdated arch/i386/kernel/cpu/{,mtrr/}changelog
      Documentation/filesystems/proc.txt: indentation fix

Jesper Juhl:
      Small fixups to the EHCI Kconfig help text


 Documentation/filesystems/proc.txt           |    2 
 Documentation/i2o/ioctl                      |    2 
 Documentation/networking/sk98lin.txt         |    2 
 Documentation/power/swsusp.txt               |    4 
 MAINTAINERS                                  |    7 
 Makefile                                     |    2 
 arch/arm/mach-omap1/board-perseus2.c         |    2 
 arch/i386/kernel/cpu/changelog               |   63 -----
 arch/i386/kernel/cpu/mtrr/changelog          |  229 -------------------
 arch/powerpc/kernel/prom.c                   |    2 
 arch/powerpc/kernel/rtas.c                   |    2 
 arch/powerpc/kernel/setup_64.c               |    2 
 arch/powerpc/mm/hash_utils_64.c              |    2 
 arch/powerpc/platforms/powermac/cpufreq_64.c |    2 
 arch/xtensa/kernel/time.c                    |    2 
 drivers/cdrom/cm206.c                        |    2 
 drivers/macintosh/therm_pm72.c               |    4 
 drivers/macintosh/windfarm_pm81.c            |    2 
 drivers/media/radio/radio-sf16fmr2.c         |    2 
 drivers/message/i2o/README.ioctl             |    2 
 drivers/net/hp100.c                          |    2 
 drivers/net/pcmcia/xirc2ps_cs.c              |    2 
 drivers/net/sk98lin/skdim.c                  |    2 
 drivers/net/sk98lin/skge.c                   |    2 
 drivers/net/sk98lin/skgepnmi.c               |    8 
 drivers/parisc/led.c                         |    2 
 drivers/usb/host/Kconfig                     |   10 
 drivers/usb/serial/cypress_m8.c              |    2 
 drivers/usb/serial/usb-serial.c              |    2 
 drivers/video/aty/radeon_monitor.c           |    2 
 drivers/video/logo/Makefile                  |    2 
 drivers/w1/Kconfig                           |    2 
 fs/9p/vfs_inode.c                            |    2 
 include/asm-powerpc/smu.h                    |    6 
 include/linux/elevator.h                     |    2 
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c  |    4 
 net/netfilter/nf_conntrack_proto_tcp.c       |    4 
 scripts/Makefile.modpost                     |    2 
 scripts/mksysmap                             |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c       |    2 
 40 files changed, 50 insertions(+), 349 deletions(-)


diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index a4dcf42..944cf10 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -418,7 +418,7 @@ VmallocChunk:   111088 kB
        Dirty: Memory which is waiting to get written back to the disk
    Writeback: Memory which is actively being written back to the disk
       Mapped: files which have been mmaped, such as libraries
-              Slab: in-kernel data structures cache
+        Slab: in-kernel data structures cache
  CommitLimit: Based on the overcommit ratio ('vm.overcommit_ratio'),
               this is the total amount of  memory currently available to
               be allocated on the system. This limit is only adhered to
diff --git a/Documentation/i2o/ioctl b/Documentation/i2o/ioctl
index 3e17497..1e77fac 100644
--- a/Documentation/i2o/ioctl
+++ b/Documentation/i2o/ioctl
@@ -185,7 +185,7 @@ VII. Getting Parameters
       ENOMEM      Kernel memory allocation error
 
    A return value of 0 does not mean that the value was actually
-   properly retreived.  The user should check the result list
+   properly retrieved.  The user should check the result list
    to determine the specific status of the transaction.
 
 VIII. Downloading Software
diff --git a/Documentation/networking/sk98lin.txt b/Documentation/networking/sk98lin.txt
index 851fc97..f9d979e 100644
--- a/Documentation/networking/sk98lin.txt
+++ b/Documentation/networking/sk98lin.txt
@@ -245,7 +245,7 @@ Default:      Both
 This parameters is only relevant if auto-negotiation for this port is 
 not set to "Sense". If auto-negotiation is set to "On", all three values
 are possible. If it is set to "Off", only "Full" and "Half" are allowed.
-This parameter is usefull if your link partner does not support all
+This parameter is useful if your link partner does not support all
 possible combinations.
 
 Flow Control
diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index cd0fcd8..08c79d4 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -212,7 +212,7 @@ A: Try running
 
 cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
 
-after resume. swapoff -a; swapon -a may also be usefull.
+after resume. swapoff -a; swapon -a may also be useful.
 
 Q: What happens to devices during swsusp? They seem to be resumed
 during system suspend?
@@ -323,7 +323,7 @@ to be useless to try to suspend to disk 
 A: No, it should work okay, as long as your app does not mlock()
 it. Just prepare big enough swap partition.
 
-Q: What information is usefull for debugging suspend-to-disk problems?
+Q: What information is useful for debugging suspend-to-disk problems?
 
 A: Well, last messages on the screen are always useful. If something
 is broken, it is usually some kernel driver, therefore trying with as
diff --git a/MAINTAINERS b/MAINTAINERS
index 270e28c..9b788d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -546,13 +546,6 @@ W:	http://linuxtv.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
 S:	Maintained
 
-BUSLOGIC SCSI DRIVER
-P:	Leonard N. Zubkoff
-M:	Leonard N. Zubkoff <lnz@dandelion.com>
-L:	linux-scsi@vger.kernel.org
-W:	http://www.dandelion.com/Linux/
-S:	Maintained
-
 COMMON INTERNET FILE SYSTEM (CIFS)
 P:	Steve French
 M:	sfrench@samba.org
diff --git a/Makefile b/Makefile
index 599e744..fb497ea 100644
--- a/Makefile
+++ b/Makefile
@@ -251,7 +251,7 @@ export KBUILD_CHECKSRC KBUILD_SRC KBUILD
 # If it is set to "silent_", nothing wil be printed at all, since
 # the variable $(silent_cmd_cc_o_c) doesn't exist.
 #
-# A simple variant is to prefix commands with $(Q) - that's usefull
+# A simple variant is to prefix commands with $(Q) - that's useful
 # for commands that shall be hidden in non-verbose mode.
 #
 #	$(Q)ln $@ :<
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index bd900b7..92ff5dc 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -184,7 +184,7 @@ static void __init omap_perseus2_map_io(
 	omap_writel(0x00000088, OMAP730_FLASH_ACFG_0);
 
 	/*
-	 * Ethernet support trough the debug board
+	 * Ethernet support through the debug board
 	 * CS1 timings setup
 	 */
 	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
diff --git a/arch/i386/kernel/cpu/changelog b/arch/i386/kernel/cpu/changelog
deleted file mode 100644
index cef76b8..0000000
--- a/arch/i386/kernel/cpu/changelog
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- *  Enhanced CPU type detection by Mike Jagdis, Patrick St. Jean
- *  and Martin Mares, November 1997.
- *
- *  Force Cyrix 6x86(MX) and M II processors to report MTRR capability
- *  and Cyrix "coma bug" recognition by
- *  Zoltán Böszörményi <zboszor@mail.externet.hu> February 1999.
- * 
- *  Force Centaur C6 processors to report MTRR capability.
- *  Bart Hartgers <bart@etpmod.phys.tue.nl>, May 1999.
- *
- *  Intel Mobile Pentium II detection fix. Sean Gilley, June 1999.
- *
- *  IDT Winchip tweaks, misc clean ups.
- *  Dave Jones <davej@suse.de>, August 1999
- *
- *  Better detection of Centaur/IDT WinChip models.
- *  Bart Hartgers <bart@etpmod.phys.tue.nl>, August 1999.
- *
- *  Cleaned up cache-detection code
- *  Dave Jones <davej@suse.de>, October 1999
- *
- *  Added proper L2 cache detection for Coppermine
- *  Dragan Stancevic <visitor@valinux.com>, October 1999
- *
- *  Added the original array for capability flags but forgot to credit 
- *  myself :) (~1998) Fixed/cleaned up some cpu_model_info and other stuff
- *  Jauder Ho <jauderho@carumba.com>, January 2000
- *
- *  Detection for Celeron coppermine, identify_cpu() overhauled,
- *  and a few other clean ups.
- *  Dave Jones <davej@suse.de>, April 2000
- *
- *  Pentium III FXSR, SSE support
- *  General FPU state handling cleanups
- *  Gareth Hughes <gareth@valinux.com>, May 2000
- *
- *  Added proper Cascades CPU and L2 cache detection for Cascades
- *  and 8-way type cache happy bunch from Intel:^)
- *  Dragan Stancevic <visitor@valinux.com>, May 2000 
- *
- *  Forward port AMD Duron errata T13 from 2.2.17pre
- *  Dave Jones <davej@suse.de>, August 2000
- *
- *  Forward port lots of fixes/improvements from 2.2.18pre
- *  Cyrix III, Pentium IV support.
- *  Dave Jones <davej@suse.de>, October 2000
- *
- *  Massive cleanup of CPU detection and bug handling;
- *  Transmeta CPU detection,
- *  H. Peter Anvin <hpa@zytor.com>, November 2000
- *
- *  VIA C3 Support.
- *  Dave Jones <davej@suse.de>, March 2001
- *
- *  AMD Athlon/Duron/Thunderbird bluesmoke support.
- *  Dave Jones <davej@suse.de>, April 2001.
- *
- *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
- *  Dave Jones <davej@suse.de>, September, October 2001.
- *
- */
-
diff --git a/arch/i386/kernel/cpu/mtrr/changelog b/arch/i386/kernel/cpu/mtrr/changelog
deleted file mode 100644
index af13685..0000000
--- a/arch/i386/kernel/cpu/mtrr/changelog
+++ /dev/null
@@ -1,229 +0,0 @@
-    ChangeLog
-
-    Prehistory Martin Tischhäuser <martin@ikcbarka.fzk.de>
-	       Initial register-setting code (from proform-1.0).
-    19971216   Richard Gooch <rgooch@atnf.csiro.au>
-               Original version for /proc/mtrr interface, SMP-safe.
-  v1.0
-    19971217   Richard Gooch <rgooch@atnf.csiro.au>
-               Bug fix for ioctls()'s.
-	       Added sample code in Documentation/mtrr.txt
-  v1.1
-    19971218   Richard Gooch <rgooch@atnf.csiro.au>
-               Disallow overlapping regions.
-    19971219   Jens Maurer <jmaurer@menuett.rhein-main.de>
-               Register-setting fixups.
-  v1.2
-    19971222   Richard Gooch <rgooch@atnf.csiro.au>
-               Fixups for kernel 2.1.75.
-  v1.3
-    19971229   David Wragg <dpw@doc.ic.ac.uk>
-               Register-setting fixups and conformity with Intel conventions.
-    19971229   Richard Gooch <rgooch@atnf.csiro.au>
-               Cosmetic changes and wrote this ChangeLog ;-)
-    19980106   Richard Gooch <rgooch@atnf.csiro.au>
-               Fixups for kernel 2.1.78.
-  v1.4
-    19980119   David Wragg <dpw@doc.ic.ac.uk>
-               Included passive-release enable code (elsewhere in PCI setup).
-  v1.5
-    19980131   Richard Gooch <rgooch@atnf.csiro.au>
-               Replaced global kernel lock with private spinlock.
-  v1.6
-    19980201   Richard Gooch <rgooch@atnf.csiro.au>
-               Added wait for other CPUs to complete changes.
-  v1.7
-    19980202   Richard Gooch <rgooch@atnf.csiro.au>
-               Bug fix in definition of <set_mtrr> for UP.
-  v1.8
-    19980319   Richard Gooch <rgooch@atnf.csiro.au>
-               Fixups for kernel 2.1.90.
-    19980323   Richard Gooch <rgooch@atnf.csiro.au>
-               Move SMP BIOS fixup before secondary CPUs call <calibrate_delay>
-  v1.9
-    19980325   Richard Gooch <rgooch@atnf.csiro.au>
-               Fixed test for overlapping regions: confused by adjacent regions
-    19980326   Richard Gooch <rgooch@atnf.csiro.au>
-               Added wbinvd in <set_mtrr_prepare>.
-    19980401   Richard Gooch <rgooch@atnf.csiro.au>
-               Bug fix for non-SMP compilation.
-    19980418   David Wragg <dpw@doc.ic.ac.uk>
-               Fixed-MTRR synchronisation for SMP and use atomic operations
-	       instead of spinlocks.
-    19980418   Richard Gooch <rgooch@atnf.csiro.au>
-	       Differentiate different MTRR register classes for BIOS fixup.
-  v1.10
-    19980419   David Wragg <dpw@doc.ic.ac.uk>
-	       Bug fix in variable MTRR synchronisation.
-  v1.11
-    19980419   Richard Gooch <rgooch@atnf.csiro.au>
-	       Fixups for kernel 2.1.97.
-  v1.12
-    19980421   Richard Gooch <rgooch@atnf.csiro.au>
-	       Safer synchronisation across CPUs when changing MTRRs.
-  v1.13
-    19980423   Richard Gooch <rgooch@atnf.csiro.au>
-	       Bugfix for SMP systems without MTRR support.
-  v1.14
-    19980427   Richard Gooch <rgooch@atnf.csiro.au>
-	       Trap calls to <mtrr_add> and <mtrr_del> on non-MTRR machines.
-  v1.15
-    19980427   Richard Gooch <rgooch@atnf.csiro.au>
-	       Use atomic bitops for setting SMP change mask.
-  v1.16
-    19980428   Richard Gooch <rgooch@atnf.csiro.au>
-	       Removed spurious diagnostic message.
-  v1.17
-    19980429   Richard Gooch <rgooch@atnf.csiro.au>
-	       Moved register-setting macros into this file.
-	       Moved setup code from init/main.c to i386-specific areas.
-  v1.18
-    19980502   Richard Gooch <rgooch@atnf.csiro.au>
-	       Moved MTRR detection outside conditionals in <mtrr_init>.
-  v1.19
-    19980502   Richard Gooch <rgooch@atnf.csiro.au>
-	       Documentation improvement: mention Pentium II and AGP.
-  v1.20
-    19980521   Richard Gooch <rgooch@atnf.csiro.au>
-	       Only manipulate interrupt enable flag on local CPU.
-	       Allow enclosed uncachable regions.
-  v1.21
-    19980611   Richard Gooch <rgooch@atnf.csiro.au>
-	       Always define <main_lock>.
-  v1.22
-    19980901   Richard Gooch <rgooch@atnf.csiro.au>
-	       Removed module support in order to tidy up code.
-	       Added sanity check for <mtrr_add>/<mtrr_del> before <mtrr_init>.
-	       Created addition queue for prior to SMP commence.
-  v1.23
-    19980902   Richard Gooch <rgooch@atnf.csiro.au>
-	       Ported patch to kernel 2.1.120-pre3.
-  v1.24
-    19980910   Richard Gooch <rgooch@atnf.csiro.au>
-	       Removed sanity checks and addition queue: Linus prefers an OOPS.
-  v1.25
-    19981001   Richard Gooch <rgooch@atnf.csiro.au>
-	       Fixed harmless compiler warning in include/asm-i386/mtrr.h
-	       Fixed version numbering and history for v1.23 -> v1.24.
-  v1.26
-    19990118   Richard Gooch <rgooch@atnf.csiro.au>
-	       Added devfs support.
-  v1.27
-    19990123   Richard Gooch <rgooch@atnf.csiro.au>
-	       Changed locking to spin with reschedule.
-	       Made use of new <smp_call_function>.
-  v1.28
-    19990201   Zoltán Böszörményi <zboszor@mail.externet.hu>
-	       Extended the driver to be able to use Cyrix style ARRs.
-    19990204   Richard Gooch <rgooch@atnf.csiro.au>
-	       Restructured Cyrix support.
-  v1.29
-    19990204   Zoltán Böszörményi <zboszor@mail.externet.hu>
-	       Refined ARR support: enable MAPEN in set_mtrr_prepare()
-	       and disable MAPEN in set_mtrr_done().
-    19990205   Richard Gooch <rgooch@atnf.csiro.au>
-	       Minor cleanups.
-  v1.30
-    19990208   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Protect plain 6x86s (and other processors without the
-               Page Global Enable feature) against accessing CR4 in
-               set_mtrr_prepare() and set_mtrr_done().
-    19990210   Richard Gooch <rgooch@atnf.csiro.au>
-	       Turned <set_mtrr_up> and <get_mtrr> into function pointers.
-  v1.31
-    19990212   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Major rewrite of cyrix_arr_init(): do not touch ARRs,
-               leave them as the BIOS have set them up.
-               Enable usage of all 8 ARRs.
-               Avoid multiplications by 3 everywhere and other
-               code clean ups/speed ups.
-    19990213   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Set up other Cyrix processors identical to the boot cpu.
-               Since Cyrix don't support Intel APIC, this is l'art pour l'art.
-               Weigh ARRs by size:
-               If size <= 32M is given, set up ARR# we were given.
-               If size >  32M is given, set up ARR7 only if it is free,
-               fail otherwise.
-    19990214   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Also check for size >= 256K if we are to set up ARR7,
-               mtrr_add() returns the value it gets from set_mtrr()
-    19990218   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Remove Cyrix "coma bug" workaround from here.
-               Moved to linux/arch/i386/kernel/setup.c and
-               linux/include/asm-i386/bugs.h
-    19990228   Richard Gooch <rgooch@atnf.csiro.au>
-	       Added MTRRIOC_KILL_ENTRY ioctl(2)
-	       Trap for counter underflow in <mtrr_file_del>.
-	       Trap for 4 MiB aligned regions for PPro, stepping <= 7.
-    19990301   Richard Gooch <rgooch@atnf.csiro.au>
-	       Created <get_free_region> hook.
-    19990305   Richard Gooch <rgooch@atnf.csiro.au>
-	       Temporarily disable AMD support now MTRR capability flag is set.
-  v1.32
-    19990308   Zoltán Böszörményi <zboszor@mail.externet.hu>
-	       Adjust my changes (19990212-19990218) to Richard Gooch's
-	       latest changes. (19990228-19990305)
-  v1.33
-    19990309   Richard Gooch <rgooch@atnf.csiro.au>
-	       Fixed typo in <printk> message.
-    19990310   Richard Gooch <rgooch@atnf.csiro.au>
-	       Support K6-II/III based on Alan Cox's <alan@redhat.com> patches.
-  v1.34
-    19990511   Bart Hartgers <bart@etpmod.phys.tue.nl>
-	       Support Centaur C6 MCR's.
-    19990512   Richard Gooch <rgooch@atnf.csiro.au>
-	       Minor cleanups.
-  v1.35
-    19990707   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Check whether ARR3 is protected in cyrix_get_free_region()
-               and mtrr_del(). The code won't attempt to delete or change it
-               from now on if the BIOS protected ARR3. It silently skips ARR3
-               in cyrix_get_free_region() or returns with an error code from
-               mtrr_del().
-    19990711   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Reset some bits in the CCRs in cyrix_arr_init() to disable SMM
-               if ARR3 isn't protected. This is needed because if SMM is active
-               and ARR3 isn't protected then deleting and setting ARR3 again
-               may lock up the processor. With SMM entirely disabled, it does
-               not happen.
-    19990812   Zoltán Böszörményi <zboszor@mail.externet.hu>
-               Rearrange switch() statements so the driver accomodates to
-               the fact that the AMD Athlon handles its MTRRs the same way
-               as Intel does.
-    19990814   Zoltán Böszörményi <zboszor@mail.externet.hu>
-	       Double check for Intel in mtrr_add()'s big switch() because
-	       that revision check is only valid for Intel CPUs.
-    19990819   Alan Cox <alan@redhat.com>
-               Tested Zoltan's changes on a pre production Athlon - 100%
-               success.
-    19991008   Manfred Spraul <manfreds@colorfullife.com>
-    	       replaced spin_lock_reschedule() with a normal semaphore.
-  v1.36
-    20000221   Richard Gooch <rgooch@atnf.csiro.au>
-               Compile fix if procfs and devfs not enabled.
-	       Formatting changes.
-  v1.37
-    20001109   H. Peter Anvin <hpa@zytor.com>
-	       Use the new centralized CPU feature detects.
-
-  v1.38
-    20010309   Dave Jones <davej@suse.de>
-	       Add support for Cyrix III.
-
-  v1.39
-    20010312   Dave Jones <davej@suse.de>
-               Ugh, I broke AMD support.
-	       Reworked fix by Troels Walsted Hansen <troels@thule.no>
-
-  v1.40
-    20010327   Dave Jones <davej@suse.de>
-	       Adapted Cyrix III support to include VIA C3.
-
-  v2.0
-    20020306   Patrick Mochel <mochel@osdl.org>
-               Split mtrr.c -> mtrr/*.c
-               Converted to Linux Kernel Coding Style
-               Fixed several minor nits in form
-               Moved some SMP-only functions out, so they can be used
-                for power management in the future.
-               TODO: Fix user interface cruft.
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 977ee3a..34ab0da 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -972,7 +972,7 @@ static int __init early_init_dt_scan_cho
 #endif
 
 #ifdef CONFIG_PPC_RTAS
-	/* To help early debugging via the front panel, we retreive a minimal
+	/* To help early debugging via the front panel, we retrieve a minimal
 	 * set of RTAS infos now if available
 	 */
 	{
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 4283fa3..ae2e2a3 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -632,7 +632,7 @@ void rtas_stop_self(void)
 }
 
 /*
- * Call early during boot, before mem init or bootmem, to retreive the RTAS
+ * Call early during boot, before mem init or bootmem, to retrieve the RTAS
  * informations from the device-tree and allocate the RMO buffer for userland
  * accesses.
  */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 98e9f05..81567e9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -438,7 +438,7 @@ void __init setup_system(void)
 
 	/*
 	 * Fill the ppc64_caches & systemcfg structures with informations
-	 * retreived from the device-tree. Need to be called before
+	 * retrieved from the device-tree. Need to be called before
 	 * finish_device_tree() since the later requires some of the
 	 * informations filled up here to properly parse the interrupt
 	 * tree.
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5bb433c..149351a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -368,7 +368,7 @@ static unsigned long __init htab_get_tab
 	unsigned long mem_size, rnd_mem_size, pteg_count;
 
 	/* If hash size isn't already provided by the platform, we try to
-	 * retreive it from the device-tree. If it's not there neither, we
+	 * retrieve it from the device-tree. If it's not there neither, we
 	 * calculate it now based on the total RAM size
 	 */
 	if (ppc64_pft_size == 0)
diff --git a/arch/powerpc/platforms/powermac/cpufreq_64.c b/arch/powerpc/platforms/powermac/cpufreq_64.c
index a4b50c4..a415e8d 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -80,7 +80,7 @@ static struct freq_attr* g5_cpu_freqs_at
 };
 
 /* Power mode data is an array of the 32 bits PCR values to use for
- * the various frequencies, retreived from the device-tree
+ * the various frequencies, retrieved from the device-tree
  */
 static u32 *g5_pmode_data;
 static int g5_pmode_max;
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index cb6e38e..937d81f 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -201,7 +201,7 @@ again:
 	if ((signed long)(get_ccount() - next) > 0)
 		goto again;
 
-	/* Allow platform to do something usefull (Wdog). */
+	/* Allow platform to do something useful (Wdog). */
 
 	platform_heartbeat();
 
diff --git a/drivers/cdrom/cm206.c b/drivers/cdrom/cm206.c
index 01f0351..ce127f7 100644
--- a/drivers/cdrom/cm206.c
+++ b/drivers/cdrom/cm206.c
@@ -32,7 +32,7 @@ History:
  18 mrt 1995: 0.24 Working background read-ahead. (still problems)
  26 mrt 1995: 0.25 Multi-session ioctl added (kernel v1.2).
               Statistics implemented, though separate stats206.h.
-	      Accessible trough ioctl 0x1000 (just a number).
+	      Accessible through ioctl 0x1000 (just a number).
 	      Hard to choose between v1.2 development and 1.1.75.
 	      Bottom-half doesn't work with 1.2...
 	      0.25a: fixed... typo. Still problems...
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 8d0958c..4f50ee5 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -630,12 +630,12 @@ static int read_eeprom(int cpu, struct m
 	sprintf(nodename, "/u3@0,f8000000/i2c@f8001000/cpuid@a%d", cpu ? 2 : 0);
 	np = of_find_node_by_path(nodename);
 	if (np == NULL) {
-		printk(KERN_ERR "therm_pm72: Failed to retreive cpuid node from device-tree\n");
+		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid node from device-tree\n");
 		return -ENODEV;
 	}
 	data = (u8 *)get_property(np, "cpuid", &len);
 	if (data == NULL) {
-		printk(KERN_ERR "therm_pm72: Failed to retreive cpuid property from device-tree\n");
+		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid property from device-tree\n");
 		of_node_put(np);
 		return -ENODEV;
 	}
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 80ddf97..eb69a60 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -26,7 +26,7 @@
  *    (typically the drive fan)
  *  - the main control (first control) gets the target value scaled with
  *    the first pair of factors, and is then modified as below
- *  - the value of the target of the CPU Fan control loop is retreived,
+ *  - the value of the target of the CPU Fan control loop is retrieved,
  *    scaled with the second pair of factors, and the max of that and
  *    the scaled target is applied to the main control.
  *
diff --git a/drivers/media/radio/radio-sf16fmr2.c b/drivers/media/radio/radio-sf16fmr2.c
index 26632ce..099ffb3 100644
--- a/drivers/media/radio/radio-sf16fmr2.c
+++ b/drivers/media/radio/radio-sf16fmr2.c
@@ -48,7 +48,7 @@ static int io = 0x384;
 static int radio_nr = -1;
 
 /* hw precision is 12.5 kHz
- * It is only usefull to give freq in intervall of 200 (=0.0125Mhz),
+ * It is only useful to give freq in intervall of 200 (=0.0125Mhz),
  * other bits will be truncated
  */
 #define RSF16_ENCODE(x)	((x)/200+856)
diff --git a/drivers/message/i2o/README.ioctl b/drivers/message/i2o/README.ioctl
index 73dd084..65c0c47 100644
--- a/drivers/message/i2o/README.ioctl
+++ b/drivers/message/i2o/README.ioctl
@@ -185,7 +185,7 @@ VII. Getting Parameters
       ENOMEM      Kernel memory allocation error
 
    A return value of 0 does not mean that the value was actually
-   properly retreived.  The user should check the result list 
+   properly retrieved.  The user should check the result list 
    to determine the specific status of the transaction.
 
 VIII. Downloading Software
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
index e92c17f..55c7ed6 100644
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -276,7 +276,7 @@ static void hp100_RegisterDump(struct ne
  * Convert an address in a kernel buffer to a bus/phys/dma address.
  * This work *only* for memory fragments part of lp->page_vaddr,
  * because it was properly DMA allocated via pci_alloc_consistent(),
- * so we just need to "retreive" the original mapping to bus/phys/dma
+ * so we just need to "retrieve" the original mapping to bus/phys/dma
  * address - Jean II */
 static inline dma_addr_t virt_to_whatever(struct net_device *dev, u32 * ptr)
 {
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index 049c34b..593d8ad 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -1598,7 +1598,7 @@ do_ioctl(struct net_device *dev, struct 
     switch(cmd) {
       case SIOCGMIIPHY:		/* Get the address of the PHY in use. */
 	data[0] = 0;		/* we have only this address */
-	/* fall trough */
+	/* fall through */
       case SIOCGMIIREG:		/* Read the specified MII register. */
 	data[3] = mii_rd(ioaddr, data[0] & 0x1f, data[1] & 0x1f);
 	break;
diff --git a/drivers/net/sk98lin/skdim.c b/drivers/net/sk98lin/skdim.c
index 0fddf61..07c1b4c 100644
--- a/drivers/net/sk98lin/skdim.c
+++ b/drivers/net/sk98lin/skdim.c
@@ -180,7 +180,7 @@ SkDimModerate(SK_AC *pAC) {
                 /*
                 ** The number of interrupts per sec is the same as expected.
                 ** Evalulate the descriptor-ratio. If it has changed, a resize 
-                ** in the moderation timer might be usefull
+                ** in the moderation timer might be useful
                 */
                 if (M_DIMINFO.AutoSizing) {
                     ResizeDimTimerDuration(pAC);
diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index 197edd7..a5f2b1e 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -2851,7 +2851,7 @@ unsigned long	Flags;			/* for spin lock 
  * Description:
  *	This function is called if an ioctl is issued on the device.
  *	There are three subfunction for reading, writing and test-writing
- *	the private MIB data structure (usefull for SysKonnect-internal tools).
+ *	the private MIB data structure (useful for SysKonnect-internal tools).
  *
  * Returns:
  *	0, if everything is ok
diff --git a/drivers/net/sk98lin/skgepnmi.c b/drivers/net/sk98lin/skgepnmi.c
index 58e1a5b..a386172 100644
--- a/drivers/net/sk98lin/skgepnmi.c
+++ b/drivers/net/sk98lin/skgepnmi.c
@@ -611,7 +611,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
  * Description:
  *	Calls a general sub-function for all this stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successfull.
  *	If the instance -1 is passed, an array of values is supposed and
  *	all instances of the OID will be set.
  *
@@ -654,7 +654,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
  * Description:
  *	Calls a general sub-function for all this stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successfull.
  *	If the instance -1 is passed, an array of values is supposed and
  *	all instances of the OID will be set.
  *
@@ -870,7 +870,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
  * Description:
  *	Calls a general sub-function for all this set stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successfull.
  *	The sub-function runs through the IdTable, checks which OIDs are able
  *	to set, and calls the handler function of the OID to perform the
  *	preset. The return value of the function will also be stored in
@@ -6473,7 +6473,7 @@ unsigned int PhysPortIndex)	/* Physical 
  *
  * Description:
  *	The COMMON module only tells us if the mode is half or full duplex.
- *	But in the decade of auto sensing it is usefull for the user to
+ *	But in the decade of auto sensing it is useful for the user to
  *	know if the mode was negotiated or forced. Therefore we have a
  *	look to the mode, which was last used by the negotiation process.
  *
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 95bd07b..315be47 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -347,7 +347,7 @@ static void led_LCD_driver(unsigned char
    ** 
    ** led_get_net_activity()
    ** 
-   ** calculate if there was TX- or RX-troughput on the network interfaces
+   ** calculate if there was TX- or RX-throughput on the network interfaces
    ** (analog to dev_get_info() from net/core/dev.c)
    **   
  */
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ed1899d..be3fd9b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -11,14 +11,14 @@ config USB_EHCI_HCD
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
 	  If your USB host controller supports USB 2.0, you will likely want to
-	  configure this Host Controller Driver.  At this writing, the primary
-	  implementation of EHCI is a chip from NEC, widely available in add-on
-	  PCI cards, but implementations are in the works from other vendors
-	  including Intel and Philips.  Motherboard support is appearing.
+	  configure this Host Controller Driver.  At the time of this writing, 
+	  the primary implementation of EHCI is a chip from NEC, widely available
+	  in add-on PCI cards, but implementations are in the works from other 
+	  vendors including Intel and Philips.  Motherboard support is appearing.
 
 	  EHCI controllers are packaged with "companion" host controllers (OHCI
 	  or UHCI) to handle USB 1.1 devices connected to root hub ports.  Ports
-	  will connect to EHCI if it the device is high speed, otherwise they
+	  will connect to EHCI if the device is high speed, otherwise they
 	  connect to a companion controller.  If you configure EHCI, you should
 	  probably configure the OHCI (for NEC and some other vendors) USB Host
 	  Controller Driver or UHCI (for Via motherboards) Host Controller
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index af18355..4e9637e 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -357,7 +357,7 @@ static int cypress_serial_control (struc
 			} while (retval != 5 && retval != ENODEV);
 
 			if (retval != 5) {
-				err("%s - failed to retreive serial line settings - %d", __FUNCTION__, retval);
+				err("%s - failed to retrieve serial line settings - %d", __FUNCTION__, retval);
 				return retval;
 			} else {
 				spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 8bc8337..4dd6865 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -584,7 +584,7 @@ static struct usb_serial_driver *search_
 	const struct usb_device_id *id;
 	struct usb_serial_driver *t;
 
-	/* List trough know devices and see if the usb id matches */
+	/* Check if the usb id matches a known device */
 	list_for_each(p, &usb_serial_driver_list) {
 		t = list_entry(p, struct usb_serial_driver, driver_list);
 		id = usb_match_id(iface, t->id_table);
diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
index ea7c863..7f9838d 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -423,7 +423,7 @@ static int __devinit radeon_parse_monito
 /*
  * Probe display on both primary and secondary card's connector (if any)
  * by various available techniques (i2c, OF device tree, BIOS, ...) and
- * try to retreive EDID. The algorithm here comes from XFree's radeon
+ * try to retrieve EDID. The algorithm here comes from XFree's radeon
  * driver
  */
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index d0244c0..4ef5cd1 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_LOGO_M32R_CLUT224)		+= logo
 
 # How to generate logo's
 
-# Use logo-cfiles to retreive list of .c files to be built
+# Use logo-cfiles to retrieve list of .c files to be built
 logo-cfiles = $(notdir $(patsubst %.$(2), %.c, \
               $(wildcard $(srctree)/$(src)/*$(1).$(2))))
 
diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
index 9a1e00d..4baf61a 100644
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -3,7 +3,7 @@ menu "Dallas's 1-wire bus"
 config W1
 	tristate "Dallas's 1-wire support"
 	---help---
-	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
+	  Dallas's 1-wire bus is useful to connect slow 1-pin devices
 	  such as iButtons and thermal sensors.
 
 	  If you want W1 support, you should say Y here.
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d933ef1..a17b288 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -663,7 +663,7 @@ v9fs_vfs_rename(struct inode *old_dir, s
 }
 
 /**
- * v9fs_vfs_getattr - retreive file metadata
+ * v9fs_vfs_getattr - retrieve file metadata
  * @mnt - mount information
  * @dentry - file to get attributes on
  * @stat - metadata structure to populate
diff --git a/include/asm-powerpc/smu.h b/include/asm-powerpc/smu.h
index 134c2b5..82ce476 100644
--- a/include/asm-powerpc/smu.h
+++ b/include/asm-powerpc/smu.h
@@ -22,7 +22,7 @@
 /*
  * Partition info commands
  *
- * These commands are used to retreive the sdb-partition-XX datas from
+ * These commands are used to retrieve the sdb-partition-XX datas from
  * the SMU. The lenght is always 2. First byte is the subcommand code
  * and second byte is the partition ID.
  *
@@ -225,7 +225,7 @@
  *
  * SMU_CMD_MISC_ee_GET_DATABLOCK_REC is used, among others, to
  * transfer blocks of data from the SMU. So far, I've decrypted it's
- * usage to retreive partition data. In order to do that, you have to
+ * usage to retrieve partition data. In order to do that, you have to
  * break your transfer in "chunks" since that command cannot transfer
  * more than a chunk at a time. The chunk size used by OF is 0xe bytes,
  * but it seems that the darwin driver will let you do 0x1e bytes if
@@ -556,7 +556,7 @@ struct smu_user_cmd_hdr
 	__u32		cmdtype;
 #define SMU_CMDTYPE_SMU			0	/* SMU command */
 #define SMU_CMDTYPE_WANTS_EVENTS	1	/* switch fd to events mode */
-#define SMU_CMDTYPE_GET_PARTITION	2	/* retreive an sdb partition */
+#define SMU_CMDTYPE_GET_PARTITION	2	/* retrieve an sdb partition */
 
 	__u8		cmd;			/* SMU command byte */
 	__u8		pad[3];			/* padding */
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 4a6f50e..23fe746 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -66,7 +66,7 @@ struct elevator_type
 };
 
 /*
- * each queue has an elevator_queue assoicated with it
+ * each queue has an elevator_queue associated with it
  */
 struct elevator_queue
 {
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
index e7fa29e..77f3046 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -995,7 +995,7 @@ static int tcp_packet(struct ip_conntrac
 		        || (!test_bit(IPS_ASSURED_BIT, &conntrack->status)
 		            && conntrack->proto.tcp.last_index == TCP_ACK_SET))
 		    && ntohl(th->ack_seq) == conntrack->proto.tcp.last_end) {
-			/* RST sent to invalid SYN or ACK we had let trough
+			/* RST sent to invalid SYN or ACK we had let through
 			 * at a) and c) above:
 			 *
 			 * a) SYN was in window then
@@ -1006,7 +1006,7 @@ static int tcp_packet(struct ip_conntrac
 			 * segments we ignored. */
 			goto in_window;
 		}
-		/* Just fall trough */
+		/* Just fall through */
 	default:
 		/* Keep compilers happy. */
 		break;
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 6167137..9a1348a 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -988,7 +988,7 @@ static int tcp_packet(struct nf_conn *co
 		        || (!test_bit(IPS_ASSURED_BIT, &conntrack->status)
 		            && conntrack->proto.tcp.last_index == TCP_ACK_SET))
 		    && ntohl(th->ack_seq) == conntrack->proto.tcp.last_end) {
-			/* RST sent to invalid SYN or ACK we had let trough
+			/* RST sent to invalid SYN or ACK we had let through
 			 * at a) and c) above:
 			 *
 			 * a) SYN was in window then
@@ -999,7 +999,7 @@ static int tcp_packet(struct nf_conn *co
 			 * segments we ignored. */
 			goto in_window;
 		}
-		/* Just fall trough */
+		/* Just fall through */
 	default:
 		/* Keep compilers happy. */
 		break;
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 0c4f3a9..bf96a61 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -30,7 +30,7 @@
 #     - See include/linux/module.h for more details
 
 # Step 4 is solely used to allow module versioning in external modules,
-# where the CRC of each module is retreived from the Module.symers file.
+# where the CRC of each module is retrieved from the Module.symers file.
 
 .PHONY: _modpost
 _modpost: __modpost
diff --git a/scripts/mksysmap b/scripts/mksysmap
index a6430e0..4390fab 100644
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -1,7 +1,7 @@
 #!/bin/sh -x
 # Based on the vmlinux file create the System.map file
 # System.map is used by module-init tools and some debugging
-# tools to retreive the actual addresses of symbols in the kernel.
+# tools to retrieve the actual addresses of symbols in the kernel.
 #
 # Usage
 # mksysmap vmlinux System.map
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
index 09cb250..962e6d5 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
@@ -209,7 +209,7 @@ static int pdacf_pcm_prepare(struct snd_
 	case SNDRV_PCM_FORMAT_S24_3LE:
 	case SNDRV_PCM_FORMAT_S24_3BE:
 		chip->pcm_sample = 3;
-		/* fall trough */
+		/* fall through */
 	default: /* 24-bit */
 		aval = AK4117_DIF_24R;
 		chip->pcm_frame = 3;

