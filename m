Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTARIK3>; Sat, 18 Jan 2003 03:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbTARIK2>; Sat, 18 Jan 2003 03:10:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:9354 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263760AbTARIKJ>;
	Sat, 18 Jan 2003 03:10:09 -0500
Date: Sat, 18 Jan 2003 00:20:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm2
Message-Id: <20030118002027.2be733c7.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 08:19:02.0514 (UTC) FILETIME=[42520D20:01C2BECA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm2/

- Added Andi's lockless current_kernel_time() patch again.  It'll break
  non-ia32 builds.  But it appears that we should push ahead and get this
  implemented across the other architectures.

- Updated oprofile patches from John.

- Adam's devfs rework is back in.  We only had two testers last time, (out
  of maybe 150 downloads) which is fairly disappointing.

  So if you use devfs, _please_ test this change and send either success or
  failure reports (not to me though).

  Adam said:

   If you want devfsd functionality (well, at least the "REGISTER" and
   "LOOKUP" events), you can get my user level program devfs_helper, which is
   a reduced functionality replacement program for devfsd from the following
   URL.

	ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper-0.2.tar.gz




Changes since 2.5.59-mm1:


+lockless-current_kernel_time.patch

 Reinstated.

-mixer-bounds-check.patch

 This didn't look right.

+kirq-up-fix.patch

 Fix the kirq build for non-SMP

-op4-fix.patch

 Not needed with the updated oprofile patch

+oprofile_cpu-as-string.patch

 oprofile work from John.

+remove-will_become_orphaned_pgrp.patch

 Cleanup

+MAX_IO_APICS-ifdef.patch

 NUMA fix

+dac960-error-retry.patch

 DAC960 robustness enhancements

+put_user-warning-fix.patch

 ARM build fix

+vmlinux-fix.patch

 Should fix the modprobe oopses with RH8.0 toolchains

+smalldevfs.patch

 devfs rework

+sound-firmware-load-fix.patch

 Build fix for OSS sound card firmware loading.

+exit_mmap-fix2.patch

 Fix exec of 32-bit apps from 64-bit apps on PPC64/ia64/sparc64, perhaps.



All 43 patches:

kgdb.patch

devfs-fix.patch

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

fadvise.patch
  implement posix_fadvise64()

ext3-scheduling-storm.patch
  ext3: fix scheduling storm and lockups

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

scheduler-tunables.patch
  scheduler tunables

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

kirq.patch

kirq-up-fix.patch
  Subject: Re: 2.5.59-mm1

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

prune-icache-stats.patch
  add stats for page reclaim via inode freeing

vma-file-merge.patch

mmap-whitespace.patch

read_cache_pages-cleanup.patch
  cleanup in read_cache_pages()

remove-GFP_HIGHIO.patch
  remove __GFP_HIGHIO

quota-lockfix.patch
  quota locking fix

quota-offsem.patch
  quota semaphore fix

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-11_pgd_ctor-update.patch
  pgd_ctor update

stack-overflow-fix.patch
  stack overflow checking fix

Richard_Henderson_for_President.patch
  Subject: [PATCH] Richard Henderson for President!

parenthesise-pgd_index.patch
  Subject: i386 pgd_index() doesn't parenthesize its arg

macro-double-eval-fix.patch
  Subject: Re: i386 pgd_index() doesn't parenthesize its arg

mmzone-parens.patch
  asm-i386/mmzone.h macro paren/eval fixes

blkdev-fixes.patch
  blkdev.h fixes

remove-will_become_orphaned_pgrp.patch
  remove will_become_orphaned_pgrp()

MAX_IO_APICS-ifdef.patch
  MAX_IO_APICS #ifdef'd wrongly

dac960-error-retry.patch
  Subject: [PATCH] linux2.5.56 patch to DAC960 driver for error retry

put_user-warning-fix.patch
  Subject: Re: Linux 2.5.59

vmlinux-fix.patch
  vmlinux fix

smalldevfs.patch
  smalldevfs

sound-firmware-load-fix.patch
  soundcore.c referenced non-existent errno variable

exit_mmap-fix2.patch
  exit_mmap fix for 64bit->32bit execs


