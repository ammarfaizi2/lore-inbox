Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbSLLI4T>; Thu, 12 Dec 2002 03:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbSLLI4T>; Thu, 12 Dec 2002 03:56:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:41201 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267443AbSLLI4P>;
	Thu, 12 Dec 2002 03:56:15 -0500
Message-ID: <3DF850F6.B65F35AF@digeo.com>
Date: Thu, 12 Dec 2002 01:03:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.51-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 09:03:56.0587 (UTC) FILETIME=[66D437B0:01C2A1BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.51/2.5.51-mm2/

  -> 2.5.51-mm2-shpte.gz    For Dave
  -> 2.5.51-mm2.gz          Full series

Numerous fixes, and dcache_rcu has been resurrected.



Additions since 2.5.51-mm1:

+PF_MEMALLOC-no-recur.patch

 Fix a potential recursion problem in the page allocator

+mempool-atomic-check.patch

 A little cleanup

+page-allocator-off-by-one.patch

 A little bugfix

+remove-PF_NOWARN.patch

 Remove current->flags:PF_NOWARN, use __GFP_NOWARN

+scheduler-tunables.patch

 rml's scheduler tweakables.  See Documentation/filesystems/proc.txt

+cacheline-aligned-pte_chains.patch

 Ensure that pte_chains are cacheline aligned

+ext2-sync-dir-fix.patch

 ext2 buglet

+mmap-rounding-fix.patch

 mmap corner case

+blocking-kswapd.patch

 Make kswapd block against request queues.  Fixes some search complexity
 problems.

+dcache_rcu-2.patch
+dcache_rcu-3.patch

 RCU for dcache locking.



All 67 patches:

kgdb.patch

PF_MEMALLOC-no-recur.patch
  Avoid recursion in the page allocator

dio-return-partial-result.patch

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

deferred-bio-dirtying.patch
  bio dirtying infrastructure

aio-direct-io.patch
  AIO support for raw/O_DIRECT

aio-dio-debug.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

cputimes_stat.patch
  Retore per-cpu time accounting, with a config option

deprecate-bdflush.patch
  deprecate use of bdflush()

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

bcrl-printk.patch

read_zero-speedup.patch
  speed up read_zero() for !CONFIG_MMU

nommu-rmap-locking.patch
  Fix rmap locking for CONFIG_SWAP=n

semtimedop.patch
  semtimedop - semop() with a timeout

writeback-handle-memory-backed.patch
  skip memory-backed filesystems in writeback

2-remove-fail_writepage.patch
  Remove fail_writepage, redux

wli-show_free_areas.patch
  show_free_areas extensions

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadsched-fix.patch
  deadline scheduler fix

quota-smp-locks.patch
  Subject: [PATCH] Quota SMP locks

shpte-ng.patch
  pagetable sharing for ia32

shpte-nonlinear.patch
  shpte: support nonlinear mappings and clean up clear_share_range()

shpte-always-on.patch
  Force CONFIG_SHAREPTE=y for ia32

pmd-allocation-fix.patch
  make sure all PMDs are allocated under PAE mode

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

radix-tree-overflow-fix.patch
  handle overflows in radix_tree_gang_lookup()

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

sync_fs.patch
  Add a sync_fs super_block operation

ext3_sync_fs.patch
  implement ext3_sync_fs

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

filldir-checks.patch
  copy_user checks in filldir()

vmstats-fixes.patch
  vm accounting fixes and addition

hugetlb-fixes.patch
  hugetlb fixes

writeback-interaction-fix.patch
  fs-writeback rework.

scalable-zone-protection.patch
  Add /proc/sys/vm/lower_zone_protection

page-wait-table-min-size.patch
  Set a minimum hash table size for wait_on_page()

ext3-transaction-reserved-blocks.patch
  Reserve an additional transaction block in ext3_dirty_inode

remove-PF_SYNC.patch

dont-inherit-mlockall.patch
  Don't inherit mm->def_flags across forks

bootmem-alloc-alignment.patch
  bootmem allocator merging fix

ext23_free_blocks-check.patch
  ext2/ext3_free_blocks() extra check

blkdev-rlimit.patch
  don't allpy file size rlimits to blockdevs

readahead-pinned-memory.patch
  limit pinned memory due to readahead

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

remove-vmscan-check.patch
  remove a vm debug check

max_sane_readahead.patch

default-super-ops.patch
  provide a default super_block_operations

mempool-atomic-check.patch
  tidier atomic check in mempool_alloc()

page-allocator-off-by-one.patch
  Fix off-by-one in the page allocator

remove-PF_NOWARN.patch
  Remove PF_NOWARN

scheduler-tunables.patch
  scheduler tunables

cacheline-aligned-pte_chains.patch
  pad pte_chains out to a cacheline

ext2-sync-dir-fix.patch
  ext2 synchronous mount fix

mmap-rounding-fix.patch
  Fix mmap rounding error

blocking-kswapd.patch
  Alloc kswapd to block on disk queues

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-scsi.patch

page-walk-api-update.patch
  pagewalk API update
