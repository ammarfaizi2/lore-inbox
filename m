Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSFDRwK>; Tue, 4 Jun 2002 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSFDRwJ>; Tue, 4 Jun 2002 13:52:09 -0400
Received: from pD9E23D09.dip.t-dialin.net ([217.226.61.9]:35754 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315293AbSFDRwI>; Tue, 4 Jun 2002 13:52:08 -0400
Date: Tue, 4 Jun 2002 11:52:03 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Linux-2.5.20-ct2
Message-ID: <Pine.LNX.4.44.0206041129490.31262-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several i2c stuff went in, and the latest IDE patch. Then again I have 
lots of small patches which I consider considerable.

I redid the patches from William Lee Irwin as he suggested. I keep playing 
with some different things, but nothing to talk about yet.

The whole patch is available at
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct2/linux-2.5.20-ct2.patch.bz2>

The full ChangeLog is available at
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct2/ChangeLog-2.5.20-ct2.bz2>

The single patches are available at
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct2/single-patches/>

Summary of changes from v2.5.20 to v2.5.20-ct2
==============================================

<ac9410@bellsouth.net>:
  o The following patch adds a check if CONFIG_SYSCTL is configured before allowing CONFIG_I2C_PROC configuration.
  o The attached patch updates printk messages, adds proc to read smbus block data, add check if we are in kernel 2.4 or greater, then use lock/unlock_kernel instead of MOD_DEC_USE_COUNT, adds I2C versioning.
  o The attached patch cleans up printk's for the i2c devices

<andersen@codepoet.org>:
  o As an aside, Nautilus (1.0.4) does stuff every 2 seconds (checking is there a CD inserted) that causes the disk LED to flash.

<dank@kegel.com>:
  o Trivial: must be __KERNEL__ for byteorder/generic.h

<rweight@us.ibm.com>:
  o Scalable CPU bitmasks
  o Scalable phys_cpu_present_map

<tyketto@wizard.com>:
  o fix ATI Rage 128/Radeon framebuffer oops

<willy@debian.org>:
  o Remove SERIAL_IO_CSG

<wli@holomorphy.com>:
  o remove mixture of non-atomic operations with page->flags which requires atomic operations to access (revisited)
  o repetitive reinitialization of active_list and inactive_list in free_area_init_core()
  o complete comment regarding inner workings of buddy system (revisited)
  o duplicate declaration of rq in sched_init()
  o forget_pte() revisited
  o remove antiquated comment from page_alloc.c
  o convert page_alloc.c bugchecks to BUG_ON()
  o remove MARK_USED() macros
  o remove memlist_* macros from page_alloc.c
  o correct inaccurate comment regarding zone_table's usage

<zwane@linux.realnet.co.sz>:
  o bluesmoke merge

Adam J. Richter <adam@yggdrasil.com>:
  o Trivial patch: linux-2.5.20/Rules.make cleanup

alexander.riesen@synopsis.com <Alexander.Riesen@synopsis.com>:
  o typo in quotas config

Andreas Dilger <adilger@clusterfs.com>:
  o Re: another -pre

Andrew Morton <akpm@zip.com.au>:
  o PCI device matching fix (revisited)

Anton Blanchard <anton@samba.org>:
  o Fix for recent swap changes on 64 bit archs
  o Use page_to_pfn in BIO code
  o Fix oops during PCI scan on Alpha

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o more copy_{to,from}_user fixes

Brad Hards <bhards@bigpond.net.au>:
  o General options - begone

cr@darav.de <cr@daRav.de>:
  o agppart SiS 745 Patch - did it wrong before

James Simmons <jsimmons@transvirtual.com>:
  o Fbdev updates and fixes

Jens Axboe <axboe@suse.de>:
  o Unplugging fix

Keith Owens <kaos@ocs.com.au>:
  o kbuild-2.5 (slightly older version, new core seems inoperable)
  o fix kbuild-2.5 database system bug

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Fix non-modular Bluetooth compilation
  o Bluetooth PCMCIA drivers update

Martin Dalecki <dalecki@evision-ventures.com>:
  o airo wireless -  "I can't get no, compilation..."
  o 2.5.20 IDE 83
  o 2.5.20 IDE 84

Pavel Machek <pavel@ucw.cz>:
  o Cleanup swsusp in 2.5.20
  o Fix suspend-to-RAM in 2.5.20
  o Re: Fix suspend-to-RAM in 2.5.20

Randy Hron <rwhron@earthlink.net>:
  o remove space in cache names

Russell King <rmk@arm.linux.org.uk>:
  o fix 2.5.20 ramdisk (revisited)

Rusty Russell <rusty@rustcorp.com.au>:
  o TRIVIAL: TAGS creation should go into arch dirs

Thunder from the hill <patch@hawkeye.luckynet.adm>:
  o Remove the special handling for hidden files in fs/isofs/namei.c and fs/isofs/dir.c
  o Make mount_block_root() wait up to 60 seconds before panic() in case we don't find root fs.

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

