Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSGTTSi>; Sat, 20 Jul 2002 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSGTTSh>; Sat, 20 Jul 2002 15:18:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47122 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317063AbSGTTSg>; Sat, 20 Jul 2002 15:18:36 -0400
Date: Sat, 20 Jul 2002 12:22:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.27
Message-ID: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's out there now, again there may well have been patches I missed, I
concentrated on the fundamental ones (ie starting LSM merge, and most
noticeably probably merging Rik's rmap patch through Andrew Morton along
with other work by Andrew).

AGP split up and cleaned up, IDE patches 99-100 and 4GB FAT32 support.

And the inevitable USB updates, of course.

		Linus

----

Summary of changes from v2.5.26 to v2.5.27
============================================

<lists@mdiehl.de>:
  o USB: patch to make USB_ZERO_PACKET work in ohci-hcd.c

<mark@alpha.dyndns.org>:
  o USB: ov511 1.61 for 2.5.25

<stuartm@connecttech.com>:
  o USB: usbserial.c fixup

Andrew Morton <akpm@zip.com.au>:
  o minimal rmap
  o leave truncate's orphaned pages on the LRU
  o avoid allocating pte_chains for unshared pages
  o VM instrumentation
  o O_DIRECT open check
  o restore CHECK_EMERGENCY_SYNC.  Again
  o inline generic_writepages()
  o alloc_pages cleanup
  o direct_io mopup
  o remove add_to_page_cache_unique()
  o writeback scalability improvements
  o readahead optimisations

David Brownell <david-b@pacbell.net>:
  o USB: usbnet queuing

Greg Kroah-Hartman <greg@kroah.com>:
  o agpgart: Split agpgart code into separate files
  o agpgart: fix syntax error in the i8x0 file
  o agpgart: renamed the agp files to make more sense
  o agpgart: added agp prefix to the debug printk
  o LSM: move the struct msg_msg and struct msg_queue definitions out
    of the msg.c file to the msg.h file
  o LSM: move struct shmid_kernel out of ipc/shm.c to
    include/linux/shm.h
  o agpgart: added "-agp" to the .c files that are for specific
    hardware types, based on mailing list comments
  o USB: removed the usb-ohci driver, as it is no longer being used
  o LSM: change BUS_ISA to CTL_BUS_ISA to prevent namespace collision
    with the input subsystem
  o LSM: Add all of the new security/* files for basic task control
  o LSM:  Enable the security framework.  This includes basic task
    control hooks
  o LSM: for now, always set CONFIG_SECURITY_CAPABILITIES to y

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o Add 4G-1 file support to FAT32

Linus Torvalds <torvalds@home.transmeta.com>:
  o Remove "tristate" for CONFIG_SECURITY_CAPABILITIES, make it
    unconditional for now.

Martin Dalecki <dalecki@evision-ventures.com>:
  o 2.5.26 IDE 99
  o IDE 100

Neil Brown <neilb@cse.unsw.edu.au>:
  o MD - Remove bdput calls from raid personalities
  o MD - Remove dead consistancy checking code from multipath
  o MD - Get multipath to use mempool
  o MD - 27 - Remove state field from multipath mp_bh structure
  o MD - Embed bio in mp_bh rather than separate allocation
  o MD - Don't "analyze_sb" when creating new array
  o MD - Use symbolic names for multipath (-4) and linear (-1)
  o MD - Get rid of find_rdev_all
  o MD - Rdev list cleanups
  o MD - Pass the correct bdev to md_error
  o MD - Move md_update_sb calls
  o MD - Set desc_nr more sanely
  o MD - Remove concept of 'spare' drive for multipath
  o MD - Improve handling of spares in md
  o MD - Add raid_disk field to rdev
  o MD - Add in_sync flag to each rdev
  o MD - Add "degraded" field to md device
  o MD - when writing superblock, generate from mddev/rdev info
  o MD - Don't maintain disc status in superblock
  o MD - Remove old_dev field
  o MD - nr_disks is gone from multipath/raid1
  o MD - Remove number and raid_disk from personality arrays
  o MD - Move persistent from superblock to mddev
  o MD - Remove dependance on superblock
  o MD - Remove the sb from the mddev
  o MD - Change partition_name calls to bdev_partition_name were
    possible
  o MD - Get rid of dev in rdev and use bdev exclusively

Oliver Neukum <oliver@neukum.name>:
  o USB: lots of locking and other SMP race fixes

Rusty Russell <rusty@rustcorp.com.au>:
  o drivers/usb/* designated initializer rework

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS locking bug
  o Fix typo in net/sunrpc/xprt.c


