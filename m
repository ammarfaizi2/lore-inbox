Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSJJFey>; Thu, 10 Oct 2002 01:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbSJJFey>; Thu, 10 Oct 2002 01:34:54 -0400
Received: from packet.digeo.com ([12.110.80.53]:60577 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262046AbSJJFeY>;
	Thu, 10 Oct 2002 01:34:24 -0400
Message-ID: <3DA512B1.63287C02@digeo.com>
Date: Wed, 09 Oct 2002 22:40:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.41-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 05:40:01.0855 (UTC) FILETIME=[7A5604F0:01C2701F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.41/2.5.41-mm2/

. The per-cpu pages patches continue to disgrace themselves.  Improvements
  in some microbenchmarks range from moderate (2%) to stunning (60%) but
  we're seeing a consistent few-percent regression in tests which perform
  networking to localhost.  Heads continue to be scratched.  This is
  irritating because that code is supposed to be the foundation for a page
  reservation API which fixes the radix-tree and pte_chain allocation failure
  problems.

  Ingo's original per-cpu-pages patch was said to be mainly beneficial for
  web-serving type things, but no specweb testing has been possible for a
  week or two due to oopses in the timer code.

. David McCracken's shared pagetable implementation is included - it is
  configurable on or off under the "Processor type and features" menu.

. The swappiness control code seems to be working well.



-lbd1.patch
-lbd2.patch
-lbd3.patch
-lbd4.patch
-lbd5.patch
-lbd6.patch
-get_bios_geometry.patch
-64-bit-sector_t.patch
-alloc_pages_node-cleanup.patch
-discontig-no-contig_page_data.patch
-discontig-setup-fix.patch
-remove-get_free_page.patch
-ext3-dxdir.patch
-free_area_init-cleanup.patch
-per-node-mem_map.patch
-wli-libfs.patch

 Merged

+ext3-yield.patch

 Remove a sched_yield() from ext3 which causes fsync() to enormously
 suck when the machine is under CPU load.

+guruhugh.patch

 Fix a use-after-free bug in the mremap code.

+pte-highmem-warning.patch

 Fix an "illegal sleep" warning in the mremap code

+raid0-fix.patch

 Peter Chubb's "make raid0 work again" patch.

+ramfs-prepare-write-speedup.patch

 Some fiddling with the fs/libfs address_space ops implementation.

+readv-writev-check-fix.patch

 Make readv/writev return zero for zero segments

+shpte.patch

 Shared pagetables for ia32

+slab-split-10-list_for_each_fix.patch

 Fix a slab bug

+timer-tricks.patch

 Tries to fix the timer problems, but doesn't.









linus.patch
  cset-1.573.96.12-to-1.746.txt.gz

timer-tricks.patch

guruhugh.patch
  Fix use-after-free bug in move_page_tables

pte-highmem-warning.patch
  Fix an atomicity warning with pte-highmem

raw-use-o_direct.patch
  Fix the raw driver

remove-radix_tree_reserve.patch
  remove radix_tree_reserve()

ext3-yield.patch
  Speed up ext3 fsyncs

readv-writev-check-fix.patch
  readv/writev: return zero for zero segments

misc.patch
  misc

swsusp-feature.patch
  add shrink_all_memory() for swsusp

large-queue-throttle.patch
  Improve writer throttling for small machines

exit-page-referenced.patch
  Propagate pte referenced bit into pagecache during unmap

swappiness.patch
  swappiness control

mapped-start-active.patch
  start anonymous pages on the active list

rename-dirty_async_ratio.patch
  rename dirty_async_ratio to dirty_ratio

auto-dirty-memory.patch
  adaptive dirty-memory thresholding

batched-slab-asap.patch
  batched slab shrinking and shrinker callback API

dio-fine-alignment.patch
  Allow O_DIRECT to use 512-byte alignment

orlov-allocator.patch

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

ramfs-aops.patch
  Move ramfs address_space ops into libfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

akpm-deadline.patch
  deadline scheduler tweaks

intel-user-copy.patch
  Faster copt_*_user for Intel ia32 CPUs

raid0-fix.patch
  RAID0 fix

rmqueue_bulk.patch
  bulk page allocator

free_pages_bulk.patch
  Bulk page freeing function

hot_cold_pages.patch
  Hot/Cold pages and zone->lock amortisation

readahead-cold-pages.patch
  Use cache-cold pages for pagecache reads.

pagevec-hot-cold-hint.patch
  hot/cold hints for truncate and page reclaim

page-reservation.patch
  Page reservation API

slab-split-01-rename.patch
  slab cleanup: rename static functions

slab-split-02-SMP.patch
  slab: enable the cpu arrays on uniprocessor

slab-split-03-tail.patch
  slab: reduced internal fragmentation

slab-split-04-drain.patch
  slab: take the spinlock in the drain function.

slab-split-05-name.patch
  slab: remove spaces from /proc identifiers

slab-split-06-mand-cpuarray.patch
  slab: cleanups and speedups

slab-split-07-inline.patch
  slab: uninline poisoning checks

slab-split-08-reap.patch
  slab: reap timers

cpucache_init-fix.patch
  cpucache_init fix

slab-split-10-list_for_each_fix.patch
  slab: for a list walking bug

shpte.patch

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
