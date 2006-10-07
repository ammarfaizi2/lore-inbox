Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422900AbWJGCxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422900AbWJGCxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423071AbWJGCxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:53:03 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:45828 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1422900AbWJGCxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:53:00 -0400
Date: Fri, 6 Oct 2006 22:52:11 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 19-rc1]  Fix typos in /Documentation : 'U-Z'
Message-Id: <20061006225211.1e88892d.kernel1@cyberdogtech.com>
In-Reply-To: <20061006190204.9ccacbeb.rdunlap@xenotime.net>
References: <20061006095031.7dfcbe53.kernel1@cyberdogtech.com>
	<20061006190204.9ccacbeb.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Fri, 06 Oct 2006 22:52:19 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Fri, 06 Oct 2006 22:52:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,
  Thanks for the feedback as always.  See below...

> > -iii.Ability to represent large i/os w/o unecessarily breaking them up (i.e
> > +iii.Ability to represent large i/os w/o unnecessarily breaking them up (i.e
> 
> I'd prefer to see "I/Os"  "without"   "i.e.".

This style is throughout this text.  It can be changed, but would be easier to do in
its own diff rather than changing the whole file here.  Left as-is.

> 
> > -       triggers an interrupt on the SPU. The  value  writting  to  the  signal
> > +       triggers an interrupt on the SPU.  The  value  writing  to  the  signal
> 
> I think that should be "written".
> 
> > -may result unpredictabe behavior.
> > +may result unpredictable behavior.
> 
>    may result in unpredictable behavior.
> 

Fixed and Fixed.  Updated version below.

-- 

diff -ru x/Documentation/accounting/taskstats.txt y/Documentation/accounting/taskstats.txt
--- x/Documentation/accounting/taskstats.txt	2006-10-06 22:40:11.000000000 -0400
+++ y/Documentation/accounting/taskstats.txt	2006-10-06 22:46:37.000000000 -0400
@@ -122,12 +122,12 @@
 
 However, maintaining per-process, in addition to per-task stats, within the
 kernel has space and time overheads. To address this, the taskstats code
-accumalates each exiting task's statistics into a process-wide data structure.
-When the last task of a process exits, the process level data accumalated also
+accumulates each exiting task's statistics into a process-wide data structure.
+When the last task of a process exits, the process level data accumulated also
 gets sent to userspace (along with the per-task data).
 
 When a user queries to get per-tgid data, the sum of all other live threads in
-the group is added up and added to the accumalated total for previously exited
+the group is added up and added to the accumulated total for previously exited
 threads of the same thread group.
 
 Extending taskstats
diff -ru x/Documentation/block/biodoc.txt y/Documentation/block/biodoc.txt
--- x/Documentation/block/biodoc.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/block/biodoc.txt	2006-10-06 22:46:37.000000000 -0400
@@ -391,7 +391,7 @@
 on to the generic block layer, only to be merged by the i/o scheduler
 when the underlying device was capable of handling the i/o in one shot.
 Also, using the buffer head as an i/o structure for i/os that didn't originate
-from the buffer cache unecessarily added to the weight of the descriptors
+from the buffer cache unnecessarily added to the weight of the descriptors
 which were generated for each such chunk.
 
 The following were some of the goals and expectations considered in the
@@ -403,14 +403,14 @@
     for raw i/o.
 ii. Ability to represent high-memory buffers (which do not have a virtual
     address mapping in kernel address space).
-iii.Ability to represent large i/os w/o unecessarily breaking them up (i.e
+iii.Ability to represent large i/os w/o unnecessarily breaking them up (i.e
     greater than PAGE_SIZE chunks in one shot)
 iv. At the same time, ability to retain independent identity of i/os from
     different sources or i/o units requiring individual completion (e.g. for
     latency reasons)
 v.  Ability to represent an i/o involving multiple physical memory segments
     (including non-page aligned page fragments, as specified via readv/writev)
-    without unecessarily breaking it up, if the underlying device is capable of
+    without unnecessarily breaking it up, if the underlying device is capable of
     handling it.
 vi. Preferably should be based on a memory descriptor structure that can be
     passed around different types of subsystems or layers, maybe even
diff -ru x/Documentation/DMA-API.txt y/Documentation/DMA-API.txt
--- x/Documentation/DMA-API.txt	2006-10-06 22:40:12.000000000 -0400
+++ y/Documentation/DMA-API.txt	2006-10-06 22:46:37.000000000 -0400
@@ -489,7 +489,7 @@
 flags can be or'd together and are
 
 DMA_MEMORY_MAP - request that the memory returned from
-dma_alloc_coherent() be directly writeable.
+dma_alloc_coherent() be directly writable.
 
 DMA_MEMORY_IO - request that the memory returned from
 dma_alloc_coherent() be addressable using read/write/memcpy_toio etc.
diff -ru x/Documentation/dvb/ci.txt y/Documentation/dvb/ci.txt
--- x/Documentation/dvb/ci.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/dvb/ci.txt	2006-10-06 22:46:37.000000000 -0400
@@ -71,7 +71,7 @@
 The disadvantage is that the driver/hardware has to manage the rest. For
 the application programmer it would be as simple as sending/receiving an
 array to/from the CI ioctls as defined in the Linux DVB API. No changes
-have been made in the API to accomodate this feature.
+have been made in the API to accommodate this feature.
 
 
 * Why the need for another CI interface ?
@@ -102,7 +102,7 @@
 implemented by most applications. Hence this area is revisited.
 
 This CI interface is quite different in the case that it tries to
-accomodate all other CI based devices, that fall into the other categories
+accommodate all other CI based devices, that fall into the other categories.
 
 This means that this CI interface handles the EN50221 style tags in the
 Application layer only and no session management is taken care of by the
diff -ru x/Documentation/eisa.txt y/Documentation/eisa.txt
--- x/Documentation/eisa.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/eisa.txt	2006-10-06 22:46:37.000000000 -0400
@@ -62,7 +62,7 @@
 bus_base_addr : slot 0 address on this bus
 slots	      : max slot number to probe
 force_probe   : Probe even when slot 0 is empty (no EISA mainboard)
-dma_mask      : Default DMA mask. Usualy the bridge device dma_mask.
+dma_mask      : Default DMA mask. Usually the bridge device dma_mask.
 bus_nr	      : unique bus id, set by eisa_root_register
 
 ** Driver :
diff -ru x/Documentation/filesystems/adfs.txt y/Documentation/filesystems/adfs.txt
--- x/Documentation/filesystems/adfs.txt	2006-10-06 22:40:14.000000000 -0400
+++ y/Documentation/filesystems/adfs.txt	2006-10-06 22:46:37.000000000 -0400
@@ -3,7 +3,7 @@
 
   uid=nnn	All files in the partition will be owned by
 		user id nnn.  Default 0 (root).
-  gid=nnn	All files in the partition willbe in group
+  gid=nnn	All files in the partition will be in group
 		nnn.  Default 0 (root).
   ownmask=nnn	The permission mask for ADFS 'owner' permissions
 		will be nnn.  Default 0700.
diff -ru x/Documentation/filesystems/configfs/configfs.txt y/Documentation/filesystems/configfs/configfs.txt
--- x/Documentation/filesystems/configfs/configfs.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/filesystems/configfs/configfs.txt	2006-10-06 22:46:37.000000000 -0400
@@ -209,7 +209,7 @@
 
 [struct config_group]
 
-A config_item cannot live in a vaccum.  The only way one can be created
+A config_item cannot live in a vacuum.  The only way one can be created
 is via mkdir(2) on a config_group.  This will trigger creation of a
 child item.
 
@@ -275,7 +275,7 @@
 
 [struct configfs_subsystem]
 
-A subsystem must register itself, ususally at module_init time.  This
+A subsystem must register itself, usually at module_init time.  This
 tells configfs to make the subsystem appear in the file tree.
 
 	struct configfs_subsystem {
diff -ru x/Documentation/filesystems/hpfs.txt y/Documentation/filesystems/hpfs.txt
--- x/Documentation/filesystems/hpfs.txt	2006-10-06 22:40:14.000000000 -0400
+++ y/Documentation/filesystems/hpfs.txt	2006-10-06 22:46:37.000000000 -0400
@@ -274,7 +274,7 @@
      Fixed race-condition in buffer code - it is in all filesystems in Linux;
         when reading device (cat /dev/hda) while creating files on it, files
         could be damaged
-2.02 Woraround for bug in breada in Linux. breada could cause accesses beyond
+2.02 Workaround for bug in breada in Linux. breada could cause accesses beyond
         end of partition
 2.03 Char, block devices and pipes are correctly created
      Fixed non-crashing race in unlink (Alexander Viro)
diff -ru x/Documentation/filesystems/ocfs2.txt y/Documentation/filesystems/ocfs2.txt
--- x/Documentation/filesystems/ocfs2.txt	2006-10-06 22:40:14.000000000 -0400
+++ y/Documentation/filesystems/ocfs2.txt	2006-10-06 22:46:37.000000000 -0400
@@ -30,7 +30,7 @@
 Features which OCFS2 does not support yet:
 	- sparse files
 	- extended attributes
-	- shared writeable mmap
+	- shared writable mmap
 	- loopback is supported, but data written will not
 	  be cluster coherent.
 	- quotas
diff -ru x/Documentation/filesystems/proc.txt y/Documentation/filesystems/proc.txt
--- x/Documentation/filesystems/proc.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/filesystems/proc.txt	2006-10-06 22:46:37.000000000 -0400
@@ -1220,9 +1220,9 @@
 you probably should increase the lower_zone_protection setting.
 
 The units of this tunable are fairly vague.  It is approximately equal
-to "megabytes".  So setting lower_zone_protection=100 will protect around 100
+to "megabytes," so setting lower_zone_protection=100 will protect around 100
 megabytes of the lowmem zone from user allocations.  It will also make
-those 100 megabytes unavaliable for use by applications and by
+those 100 megabytes unavailable for use by applications and by
 pagecache, so there is a cost.
 
 The effects of this tunable may be observed by monitoring
diff -ru x/Documentation/filesystems/spufs.txt y/Documentation/filesystems/spufs.txt
--- x/Documentation/filesystems/spufs.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/filesystems/spufs.txt	2006-10-06 22:49:42.000000000 -0400
@@ -210,7 +210,7 @@
    /signal2
        The two signal notification channels of an SPU.  These  are  read-write
        files  that  operate  on  a 32 bit word.  Writing to one of these files
-       triggers an interrupt on the SPU. The  value  writting  to  the  signal
+       triggers an interrupt on the SPU.  The  value  written  to  the  signal
        files can be read from the SPU through a channel read or from host user
        space through the file.  After the value has been read by the  SPU,  it
        is  reset  to zero.  The possible operations on an open signal1 or sig-
diff -ru x/Documentation/hrtimers.txt y/Documentation/hrtimers.txt
--- x/Documentation/hrtimers.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/hrtimers.txt	2006-10-06 22:46:37.000000000 -0400
@@ -30,7 +30,7 @@
   necessitate a more complex handling of high resolution timers, which
   in turn decreases robustness. Such a design still led to rather large
   timing inaccuracies. Cascading is a fundamental property of the timer
-  wheel concept, it cannot be 'designed out' without unevitably
+  wheel concept, it cannot be 'designed out' without inevitably
   degrading other portions of the timers.c code in an unacceptable way.
 
 - the implementation of the current posix-timer subsystem on top of
diff -ru x/Documentation/ide.txt y/Documentation/ide.txt
--- x/Documentation/ide.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/ide.txt	2006-10-06 22:46:37.000000000 -0400
@@ -390,5 +390,5 @@
 Wed Apr 17 22:52:44 CEST 2002 edited by Marcin Dalecki, the current
 maintainer.
 
-Wed Aug 20 22:31:29 CEST 2003 updated ide boot uptions to current ide.c
+Wed Aug 20 22:31:29 CEST 2003 updated ide boot options to current ide.c
 comments at 2.6.0-test4 time. Maciej Soltysiak <solt@dns.toxicfilms.tv>
diff -ru x/Documentation/input/atarikbd.txt y/Documentation/input/atarikbd.txt
--- x/Documentation/input/atarikbd.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/input/atarikbd.txt	2006-10-06 22:46:37.000000000 -0400
@@ -103,7 +103,7 @@
 
 5.1 Joystick Event Reporting
 
-In this mode, the ikbd generates a record whever the joystick position is
+In this mode, the ikbd generates a record whenever the joystick position is
 changed (i.e. for each opening or closing of a joystick switch or trigger).
 
 The joystick event record is two bytes of the form:
diff -ru x/Documentation/input/iforce-protocol.txt y/Documentation/input/iforce-protocol.txt
--- x/Documentation/input/iforce-protocol.txt	2006-10-06 22:40:12.000000000 -0400
+++ y/Documentation/input/iforce-protocol.txt	2006-10-06 22:46:37.000000000 -0400
@@ -23,9 +23,9 @@
 When using USB:
 OP DATA
 The 2B, LEN and CS fields have disappeared, probably because USB handles frames and
-data corruption is handled or unsignificant.
+data corruption is handled or insignificant.
 
-First, I describe effects that are sent by the device to the computer
+First, I describe effects that are sent by the device to the computer.
 
 ** Device input state
 This packet is used to indicate the state of each button and the value of each
diff -ru x/Documentation/ioctl/cdrom.txt y/Documentation/ioctl/cdrom.txt
--- x/Documentation/ioctl/cdrom.txt	2006-10-06 22:40:12.000000000 -0400
+++ y/Documentation/ioctl/cdrom.txt	2006-10-06 22:46:37.000000000 -0400
@@ -735,7 +735,7 @@
 	    Ok, this is where problems start.  The current interface for
 	    the CDROM_DISC_STATUS ioctl is flawed.  It makes the false
 	    assumption that CDs are all CDS_DATA_1 or all CDS_AUDIO, etc.
-	    Unfortunatly, while this is often the case, it is also
+	    Unfortunately, while this is often the case, it is also
 	    very common for CDs to have some tracks with data, and some
 	    tracks with audio.	Just because I feel like it, I declare
 	    the following to be the best way to cope.  If the CD has
diff -ru x/Documentation/laptop-mode.txt y/Documentation/laptop-mode.txt
--- x/Documentation/laptop-mode.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/laptop-mode.txt	2006-10-06 22:46:37.000000000 -0400
@@ -699,7 +699,7 @@
 Dax Kelson submitted this so that the ACPI acpid daemon will
 kick off the laptop_mode script and run hdparm. The part that
 automatically disables laptop mode when the battery is low was
-writen by Jan Topinski.
+written by Jan Topinski.
 
 -----------------/etc/acpi/events/ac_adapter BEGIN------------------------------
 event=ac_adapter
diff -ru x/Documentation/MSI-HOWTO.txt y/Documentation/MSI-HOWTO.txt
--- x/Documentation/MSI-HOWTO.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/MSI-HOWTO.txt	2006-10-06 22:50:04.000000000 -0400
@@ -219,7 +219,7 @@
 Note that the pre-assigned IOAPIC dev->irq is valid only if the device
 operates in PIN-IRQ assertion mode. In MSI-X mode, any attempt at
 using dev->irq by the device driver to request for interrupt service
-may result unpredictabe behavior.
+may result in unpredictable behavior.
 
 For each MSI-X vector granted, a device driver is responsible for calling
 other functions like request_irq(), enable_irq(), etc. to enable
diff -ru x/Documentation/networking/NAPI_HOWTO.txt y/Documentation/networking/NAPI_HOWTO.txt
--- x/Documentation/networking/NAPI_HOWTO.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/networking/NAPI_HOWTO.txt	2006-10-06 22:46:37.000000000 -0400
@@ -601,7 +601,7 @@
 	
 5) dev->close() and dev->suspend() issues
 ==========================================
-The driver writter neednt worry about this. The top net layer takes
+The driver writer needn't worry about this; the top net layer takes
 care of it.
 
 6) Adding new Stats to /proc 
@@ -622,9 +622,9 @@
 packets fast enough i.e send a pause only when you run out of rx buffers.
 Note FC in itself is a good solution but we have found it to not be
 much of a commodity feature (both in NICs and switches) and hence falls
-under the same category as using NIC based mitigation. Also experiments
-indicate that its much harder to resolve the resource allocation
-issue (aka lazy receiving that NAPI offers) and hence quantify its usefullness
+under the same category as using NIC based mitigation. Also, experiments
+indicate that it's much harder to resolve the resource allocation
+issue (aka lazy receiving that NAPI offers) and hence quantify its usefulness
 proved harder. In any case, FC works even better with NAPI but is not
 necessary.
 
diff -ru x/Documentation/networking/sk98lin.txt y/Documentation/networking/sk98lin.txt
--- x/Documentation/networking/sk98lin.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/networking/sk98lin.txt	2006-10-06 22:46:37.000000000 -0400
@@ -346,7 +346,7 @@
       depending on the load of the system. If the driver detects that the
       system load is too high, the driver tries to shield the system against 
       too much network load by enabling interrupt moderation. If - at a later
-      time - the CPU utilizaton decreases again (or if the network load is 
+      time - the CPU utilization decreases again (or if the network load is 
       negligible) the interrupt moderation will automatically be disabled.
 
 Interrupt moderation should be used when the driver has to handle one or more
diff -ru x/Documentation/networking/slicecom.txt y/Documentation/networking/slicecom.txt
--- x/Documentation/networking/slicecom.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/networking/slicecom.txt	2006-10-06 22:46:37.000000000 -0400
@@ -126,7 +126,7 @@
 
 Though the options below are to be set on a single interface, they apply to the
 whole board. The restriction, to use them on 'UP' interfaces, is because the 
-command sequence below could lead to unpredicable results.
+command sequence below could lead to unpredictable results.
 
 	# echo 0        >boardnum
 	# echo internal >clock_source
diff -ru x/Documentation/networking/wan-router.txt y/Documentation/networking/wan-router.txt
--- x/Documentation/networking/wan-router.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/networking/wan-router.txt	2006-10-06 22:46:37.000000000 -0400
@@ -412,7 +412,7 @@
 
 beta3-2.1.4 Jul 2000		o X25 M_BIT Problem fix.
 				o Added the Multi-Port PPP
-				  Updated utilites for the Multi-Port PPP.
+				  Updated utilities for the Multi-Port PPP.
 
 2.1.4	Aut 2000
 				o In X25API:
@@ -450,7 +450,7 @@
 
 
 				o Keyboard Led Monitor/Debugger
-					- A new utilty /usr/sbin/wpkbdmon uses keyboard leds
+					- A new utility /usr/sbin/wpkbdmon uses keyboard leds
 					  to convey operational statistic information of the 
 					  Sangoma WANPIPE cards.
 					NUM_LOCK    = Line State  (On=connected,    Off=disconnected)
diff -ru x/Documentation/pnp.txt y/Documentation/pnp.txt
--- x/Documentation/pnp.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/pnp.txt	2006-10-06 22:46:37.000000000 -0400
@@ -184,7 +184,7 @@
 Please note that the character 'X' can be used as a wild card in the function
 portion (last four characters).
 ex:
-	/* Unkown PnP modems */
+	/* Unknown PnP modems */
 	{	"PNPCXXX",		UNKNOWN_DEV	},
 
 Supported PnP card IDs can optionally be defined.
diff -ru x/Documentation/robust-futex-ABI.txt y/Documentation/robust-futex-ABI.txt
--- x/Documentation/robust-futex-ABI.txt	2006-10-06 22:40:17.000000000 -0400
+++ y/Documentation/robust-futex-ABI.txt	2006-10-06 22:46:37.000000000 -0400
@@ -170,7 +170,7 @@
  1) the 'head' pointer or an subsequent linked list pointer
     is not a valid address of a user space word
  2) the calculated location of the 'lock word' (address plus
-    'offset') is not the valud address of a 32 bit user space
+    'offset') is not the valid address of a 32 bit user space
     word
  3) if the list contains more than 1 million (subject to
     future kernel configuration changes) elements.
diff -ru x/Documentation/s390/Debugging390.txt y/Documentation/s390/Debugging390.txt
--- x/Documentation/s390/Debugging390.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/s390/Debugging390.txt	2006-10-06 22:46:37.000000000 -0400
@@ -846,9 +846,9 @@
 instead if the code isn't compiled -g, as it is much faster:
 objdump --disassemble-all --syms vmlinux > vmlinux.lst  
 
-As hard drive space is valuble most of us use the following approach.
+As hard drive space is valuable, most of us use the following approach.
 1) Look at the emitted psw on the console to find the crash address in the kernel.
-2) Look at the file System.map ( in the linux directory ) produced when building 
+2) Look at the file System.map (in the linux directory) produced when building 
 the kernel to find the closest address less than the current PSW to find the
 offending function.
 3) use grep or similar to search the source tree looking for the source file
diff -ru x/Documentation/scsi/ibmmca.txt y/Documentation/scsi/ibmmca.txt
--- x/Documentation/scsi/ibmmca.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/scsi/ibmmca.txt	2006-10-06 22:46:37.000000000 -0400
@@ -461,7 +461,7 @@
       This needs the RD-Bit to be disabled on IM_OTHER_SCSI_CMD_CMD which 
       allows data to be written from the system to the device. It is a
       necessary step to be allowed to set blocksize of SCSI-tape-drives and 
-      the tape-speed, whithout confusing the SCSI-Subsystem.
+      the tape-speed, without confusing the SCSI-Subsystem.
    2) The recognition of a tape is included in the check_devices routine.
       This is done by checking for TYPE_TAPE, that is already defined in
       the kernel-scsi-environment. The markup of a tape is done in the 
diff -ru x/Documentation/scsi/ncr53c8xx.txt y/Documentation/scsi/ncr53c8xx.txt
--- x/Documentation/scsi/ncr53c8xx.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/scsi/ncr53c8xx.txt	2006-10-06 22:46:37.000000000 -0400
@@ -115,7 +115,7 @@
 
           ftp://ftp.symbios.com/
 
-Usefull SCSI tools written by Eric Youngdale are available at tsx-11:
+Useful SCSI tools written by Eric Youngdale are available at tsx-11:
 
           ftp://tsx-11.mit.edu/pub/linux/ALPHA/scsi/scsiinfo-X.Y.tar.gz
           ftp://tsx-11.mit.edu/pub/linux/ALPHA/scsi/scsidev-X.Y.tar.gz
diff -ru x/Documentation/sound/alsa/Audigy-mixer.txt y/Documentation/sound/alsa/Audigy-mixer.txt
--- x/Documentation/sound/alsa/Audigy-mixer.txt	2006-10-06 22:40:13.000000000 -0400
+++ y/Documentation/sound/alsa/Audigy-mixer.txt	2006-10-06 22:46:37.000000000 -0400
@@ -6,7 +6,7 @@
 
 The EMU10K2 chips have a DSP part which can be programmed to support 
 various ways of sample processing, which is described here.
-(This acticle does not deal with the overall functionality of the 
+(This article does not deal with the overall functionality of the 
 EMU10K2 chips. See the manuals section for further details.)
 
 The ALSA driver programs this portion of chip by default code
diff -ru x/Documentation/sound/alsa/SB-Live-mixer.txt y/Documentation/sound/alsa/SB-Live-mixer.txt
--- x/Documentation/sound/alsa/SB-Live-mixer.txt	2006-10-06 22:40:13.000000000 -0400
+++ y/Documentation/sound/alsa/SB-Live-mixer.txt	2006-10-06 22:46:37.000000000 -0400
@@ -5,7 +5,7 @@
 
 The EMU10K1 chips have a DSP part which can be programmed to support
 various ways of sample processing, which is described here.
-(This acticle does not deal with the overall functionality of the 
+(This article does not deal with the overall functionality of the 
 EMU10K1 chips. See the manuals section for further details.)
 
 The ALSA driver programs this portion of chip by default code
diff -ru x/Documentation/uml/UserModeLinux-HOWTO.txt y/Documentation/uml/UserModeLinux-HOWTO.txt
--- x/Documentation/uml/UserModeLinux-HOWTO.txt	2006-10-06 22:43:36.000000000 -0400
+++ y/Documentation/uml/UserModeLinux-HOWTO.txt	2006-10-06 22:46:37.000000000 -0400
@@ -1477,7 +1477,7 @@
 
 
 
-  Making it world-writeable looks bad, but it seems not to be
+  Making it world-writable looks bad, but it seems not to be
   exploitable as a security hole.  However, it does allow anyone to cre-
   ate useless tap devices (useless because they can't configure them),
   which is a DOS attack.  A somewhat more secure alternative would to be


