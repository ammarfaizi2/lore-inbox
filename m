Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSIMG55>; Fri, 13 Sep 2002 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSIMG55>; Fri, 13 Sep 2002 02:57:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:30931 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317066AbSIMG5z>;
	Fri, 13 Sep 2002 02:57:55 -0400
Message-ID: <3D819132.C7171BD9@digeo.com>
Date: Fri, 13 Sep 2002 00:18:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: 2.5.34-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 07:02:39.0484 (UTC) FILETIME=[8C28EBC0:01C25AF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm3/

+reversemaps-leak.patch
 
 Correct the /proc/meminfo:ReverseMaps accounting (Hugh)

+proc_vmstat.patch

 Take all the VM accounting out of kernel_stat, put it in the per-cpu
 VM accounting, publish it in the new /proc/vmstat


Rik, I didn't include the iowait patch because we don't seem to have
a tarball of procps which supports it - the various diffs you have at
http://surriel.com/procps/ appear to be in an intermediate state wrt
cygnus CVS.

The code is in experimental/iowait.patch.  Could we have a snapshot
tarball of the support utilities please?


The faster wakeup code seems to have shaved 50% off the wakeup cost
in Badari's profiles, but negligible bottom line benefit.  Still
poking at that one.



linus.patch
  cset-1.568.19.4-to-1.661.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

readv-writev.patch
  O_DIRECT support for readv/writev

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

lpp.patch
  ia32 huge tlb pages

lpp-update.patch
  hugetlbpage fixes

reversemaps-leak.patch
  Fix reverse map accounting leak

sharedmem.patch
  Add /proc/meminfo:Mapped - tha amount of memory which is mapped into pagetables

ext3-sb.patch
  u.ext3_sb -> generic_sbp

oom-fix.patch
  Fix an OOM condition on big highmem machines

tlb-cleanup.patch
  Clean up the tlb gather code

dump-stack.patch
  arch-neutral dump_stack() function

wli-cleanup.patch
  random cleanups

madvise-move.patch
  move mdavise implementation into mm/madvise.c

split-vma.patch
  VMA splitting patch

mmap-fixes.patch
  mmap.c cleanup and lock ranking fixes

buffer-ops-move.patch
  Move submit_bh() and ll_rw_block() into fs/buffer.c

slab-stats.patch
  Display total slab memory in /proc/meminfo

writeback-control.patch
  Cleanup and extension of the writeback paths

free_area_init-cleanup.patch
  free_area_init() code cleanup

alloc_pages-cleanup.patch
  alloc_pages cleanup and optimisation

statm_pgd_range-sucks.patch
  Remove the pagetable walk from /proc/stat

remove-sync_thresh.patch
  Remove /proc/sys/vm/dirty_sync_thresh

pf_nowarn.patch
  Fix up the handling of PF_NOWARN

jeremy.patch
  Spel Jermy's naim wright

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

wake-speedup.patch
  Faster wakeup code

sync-helper.patch
  Speed up sys_sync() against multiple spindles

slabasap.patch
  Early and smarter shrinking of slabs

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

buddyinfo.patch
  Add /proc/buddyinfo - stats on the free pages pool

free_area.patch
  Remove struct free_area_struct and free_area_t, use `struct free_area'

radix_tree_gang_lookup.patch
  radix tree gang lookup

truncate_inode_pages.patch
  truncate/invalidate_inode_pages rewrite

proc_vmstat.patch
  Move the vm accounting out of /proc/stat
