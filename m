Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbUJZBoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUJZBoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUJZBnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:43:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8918 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261868AbUJZBVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:21:46 -0400
Date: Tue, 26 Oct 2004 00:45:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] add a bunch of missing files to Documentation/00-INDEX 
Message-ID: <Pine.LNX.4.61.0410260038180.3633@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Below you'll find a patch that adds a bunch of entries to 
Documentation/00-INDEX that are currently missing (and removes the 
entry for one file that no longer exist).

Patch has already been OK'ed by Paul G.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc1-bk3-orig/Documentation/00-INDEX linux-2.6.10-rc1-bk3/Documentation/00-INDEX
--- linux-2.6.10-rc1-bk3-orig/Documentation/00-INDEX	2004-10-18 23:53:43.000000000 +0200
+++ linux-2.6.10-rc1-bk3/Documentation/00-INDEX	2004-10-26 00:36:58.000000000 +0200
@@ -20,6 +20,8 @@
 	- list of changes that break older software packages.
 CodingStyle
 	- how the boss likes the C code in the kernel to look.
+DMA-API.txt
+	- DMA API, pci_ API & extensions for non-consistent memory machines.
 DMA-mapping.txt
 	- info for PCI drivers using DMA portably across all platforms.
 DocBook/
@@ -30,8 +32,12 @@
 	- info on Linux Intelligent Platform Management Interface (IPMI) Driver.
 IRQ-affinity.txt
 	- how to select which CPU(s) handle which interrupt events on SMP.
+ManagementStyle
+	- how to (attempt to) manage kernel hackers.
 MSI-HOWTO.txt
 	- the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
+RCU/
+	- directory with info on RCU (read-copy update).
 README.DAC960
 	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux.
 README.moxa
@@ -46,8 +52,6 @@
 	- how to change your VGA cursor from a blinking underscore.
 arm/
 	- directory with info about Linux on the ARM architecture.
-as-iosched.txt
-	- info on anticipatory IO scheduler.
 basic_profiling.txt
 	- basic instructions for those who wants to profile Linux kernel.
 binfmt_misc.txt
@@ -60,16 +64,22 @@
 	- info, major/minor #'s for Compaq's SMART Array Controllers.
 cdrom/
 	- directory with information on the CD-ROM drivers that Linux has.
+cli-sti-removal.txt
+	- cli()/sti() removal guide.
 computone.txt
 	- info on Computone Intelliport II/Plus Multiport Serial Driver.
 cpqarray.txt
 	- info on using Compaq's SMART2 Intelligent Disk Array Controllers.
-cpufreq/
+cpu-freq/
 	- info on CPU frequency and voltage scaling.
 cris/
 	- directory with info about Linux on CRIS architecture.
+crypto/
+	- directory with info on the Crypto API.
 debugging-modules.txt
 	- some notes on debugging modules after Linux 2.6.3.
+device-mapper/
+	- directory with info on Device Mapper.
 devices.txt
 	- plain ASCII listing of all the nodes in /dev/ with major minor #'s.
 digiboard.txt
@@ -92,6 +102,8 @@
 	- directory with info on the frame buffer graphics abstraction layer.
 filesystems/
 	- directory with info on the various filesystems that Linux supports.
+firmware_class/
+	- request_firmware() hotplug interface info.
 floppy.txt
 	- notes and driver options for the floppy disk driver.
 ftape.txt
@@ -100,10 +112,14 @@
 	- info on using the Hayes ESP serial driver.
 highuid.txt
 	- notes on the change from 16 bit to 32 bit user/group IDs.
+hpet.txt
+	- High Precision Event Timer Driver for Linux.
 hw_random.txt
 	- info on Linux support for random number generator in i8xx chipsets.
 i2c/
 	- directory with info about the I2C bus/protocol (2 wire, kHz speed).
+i2o/
+	- directory with info about the Linux I2O subsystem.
 i386/
 	- directory with info about Linux on Intel 32 bit architecture.
 ia64/
@@ -114,6 +130,8 @@
 	- how to use the RAM disk as an initial/temporary root filesystem.
 input/
 	- info on Linux input device support.
+io_ordering.txt
+	- info on ordering I/O writes to memory-mapped addresses.
 ioctl-number.txt
 	- how to implement and register device/driver ioctl calls.
 iostats.txt
@@ -134,6 +152,8 @@
 	- summary listing of command line / boot prompt args for the kernel.
 kobject.txt
 	- info of the kobject infrastructure of the Linux kernel.
+laptop-mode.txt
+	- How to conserve battery power using laptop-mode.
 ldm.txt
 	- a brief description of LDM (Windows Dynamic Disks).
 locks.txt
@@ -160,6 +180,8 @@
 	- script to make /dev entries for SMART controllers (see cciss.txt).
 mkdev.ida
 	- script to make /dev entries for Intelligent Disk Array Controllers.
+mono.txt
+	- how to execute Mono-based .NET binaries with the help of BINFMT_MISC.
 moxa-smartio
 	- info on installing/using Moxa multiport serial driver.
 mtrr.txt
@@ -172,6 +194,8 @@
 	- short guide on setting up a diskless box with NFS root filesystem.
 nmi_watchdog.txt
 	- info on NMI watchdog for SMP systems.
+numastat.txt
+	- info on how to read Numa policy hit/miss statistics in sysfs.
 oops-tracing.txt
 	- how to decode those nasty internal kernel error dump messages.
 paride.txt
@@ -199,17 +223,25 @@
 riscom8.txt
 	- notes on using the RISCom/8 multi-port serial driver.
 rocket.txt
-	- info on installing/using the Comtrol RocketPort multiport serial driver.
+	- info on the Comtrol RocketPort multiport serial driver.
 rpc-cache.txt
 	- introduction to the caching mechanisms in the sunrpc layer.
 rtc.txt
 	- notes on how to use the Real Time Clock (aka CMOS clock) driver.
 s390/
 	- directory with info on using Linux on the IBM S390.
+sched-coding.txt
+	- reference for various scheduler-related methods in the O(1) scheduler.
 sched-design.txt
 	- goals, design and implementation of the Linux O(1) scheduler.
+sched-domains.txt
+	- information on scheduling domains.
+sched-stats.txt
+	- information on schedstats (Linux Scheduler Statistics).
 scsi/
 	- directory with info on Linux scsi support.
+serial/
+	- directory with info on the low level serial API.
 serial-console.txt
 	- how to set up Linux with a serial line console as the default.
 sgi-visws.txt
@@ -242,14 +274,24 @@
 	- info on the magic SysRq key.
 telephony/
 	- directory with info on telephony (e.g. voice over IP) support.
+time_interpolators.txt
+	- info on time interpolators.
+tipar.txt
+	- information about Parallel link cable for Texas Instruments handhelds.
+tty.txt
+	- guide to the locking policies of the tty layer.
 unicode.txt
 	- info on the Unicode character/font mapping used in Linux.
+uml/
+	- directory with infomation about User Mode Linux.
 usb/
 	- directory with info regarding the Universal Serial Bus.
 video4linux/
 	- directory with info regarding video/TV/radio cards and linux.
 vm/
 	- directory with info on the Linux vm code.
+voyager.txt
+	- guide to running Linux on the Voyager architecture.
 watchdog/
 	- how to auto-reboot Linux if it has "fallen and can't get up". ;-)
 x86_64/


