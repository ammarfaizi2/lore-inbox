Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319445AbSILGJH>; Thu, 12 Sep 2002 02:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319446AbSILGJH>; Thu, 12 Sep 2002 02:09:07 -0400
Received: from packet.digeo.com ([12.110.80.53]:4018 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319445AbSILGJF>;
	Thu, 12 Sep 2002 02:09:05 -0400
Message-ID: <3D803434.F2A58357@digeo.com>
Date: Wed, 11 Sep 2002 23:29:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.34-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 06:13:47.0079 (UTC) FILETIME=[8DE5AD70:01C25A23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm2/

-throttling-fix.patch
-sleeping-release_page.patch
-dirty-state-accounting.patch
-discontig-cleanup-1.patch
-discontig-cleanup-2.patch
-writeback-thresholds.patch
-buffer-strip.patch
-rmap-speedup.patch
-wli-highpte.patch

 Merged

-lpp2.patch

 Folded into lpp.patch - hugetlb fixes

+lpp-update.patch

 More hugetlb fixes from Rohit.

+pf_nowarn.patch

 Prevent some `page allocation failure' warnings which aren't supposed
 to come out.

+jeremy.patch

 Spel Jermy's naim wright

-segq.patch

 SEGQ had an interaction with the dirty memory management.  This interaction
 was the source of Badari's IO bandwidth regression.  Removed until I have
 time to poke at it.

+wake-speedup.patch

 Badari's pagecache writeout is back up to 270 megs/sec.  The CPUs are pegged
 and the hottest functions are 

  5348 __wake_up                                111.4167
  6954 unlock_page                               72.4375
187676 generic_file_write_nolock                 71.9617
  9577 __scsi_end_request                        54.4148

 I cannot reproduce these profiles with mortal numbers of hard disks, but
 the wakeup code can be sped up heaps.

 The patch implements a new wait/wakeup mechanism which removes wait_queues
 from wait_queue_head's within __wake_up(), rather than within the woken
 process.

+buddyinfo.patch

 /proc/buddyinfo - stats on free page fragmentation.

+free_area.patch

 Nail another gratuitous typedef

+radix_tree_gang_lookup.patch

 Multipage pagecache scan and lookup.

+truncate_inode_pages.patch

 Redo the truncate/invalidate code to use gang lookups.





linus.patch
  cset-1.568.17.13-to-1.648.txt.gz

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
