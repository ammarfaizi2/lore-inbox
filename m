Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTAIEgj>; Wed, 8 Jan 2003 23:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAIEgj>; Wed, 8 Jan 2003 23:36:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:32710 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261593AbTAIEgf>;
	Wed, 8 Jan 2003 23:36:35 -0500
Message-ID: <3E1CFE53.F7A0A487@digeo.com>
Date: Wed, 08 Jan 2003 20:45:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.55-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2003 04:45:11.0197 (UTC) FILETIME=[E48AB4D0:01C2B799]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.55/2.5.55-mm1/


. Lots of various random fixes (I generally don't changelog these - the diffs
  just quietly change)

. Chris's reiserfs multipage direct-to-bio reads patch is back again.

. oprofile for Pentium 4's

. I've dropped Adam's micro-devfs patch in here too.  Reports from people who
  use devfs would be appreciated.  Success reports, as well as bugs.



Changes since 2.5.54-mm3:


-log_buf_size.patch
-nfsd-fix.patch
-dio-return-partial-result.patch
-aio-direct-io-infrastructure.patch
-deferred-bio-dirtying.patch
-aio-direct-io.patch
-aio-dio-debug.patch
-dio-reduce-context-switch-rate.patch
-dio-always-kmalloc.patch
-misc.patch
-3c920.patch
-copy_page_range-cleanup.patch
-pte_chain_alloc-fix.patch
-page_add_rmap-rework.patch
-rat-preload.patch
-use-rat-preallocation.patch
-mempool_resize-fix.patch
-slab-redzone-cleanup.patch
-shrink-kmap-space.patch
-route-cache-kmalloc-per-cpu.patch
-wli-12_pidhash_size.patch

 Merged

+deadline-fixups.patch

 Some IO scheduler adjustments

+touched_by_munmap-go-forwards.patch

 Support for low-latency pagetable zapping

+misc.patch

 Misc fixes

+ext3-ino_t-cleanup.patch

 ext3 cleanup

+reiserfs-readpages.patch

 back again.  Multipage direct-to-BIO reads for reiserfs

+inline-constant-small-copy_user.patch

 Inline constant 1, 2 and 4-bytes copy_*_user's for ia32

+oprofile-p4.patch
+op4-fix.patch

 oprofile support for pentium 4

-wli-01_numaq_io.patch

 Lots of rejects

+smalldevfs.patch

 Adam's cut-down devfs



All 51 patches:

linus.patch
  cset-1.838.136.15-to-1.930.txt.gz

kgdb.patch

rcf.patch
  run-child-first after fork

devfs-fix.patch

cputimes_stat.patch
  Retore per-cpu time accounting, with a config option

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadline-fixups.patch
  deadsched cleanups/fixups

i_shared_sem.patch
  turn i_shared_lock into a semaphore

cond_resched_lock-rework.patch
  simplify and generalise cond_resched_lock

untypedef-mmu_gather.patch
  replace `typedef mmu_gather_t' with `struct mmu_gather'

touched_by_munmap-go-forwards.patch
  Don't reverse the VMA list in touched_by_munmap()

low-latency-page-unmapping.patch
  low-latency pagetable teardown

misc.patch
  misc fixes

smp-preempt-latency-fix.patch
  Fix an SMP+preempt latency problem

ext3-ino_t-cleanup.patch
  Subject: [PATCH] 2.5 ext3 ino_t removal

smaller-head-arrays.patch

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

reiserfs-readpages.patch
  reiserfs v3 readpages support

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

scheduler-tunables.patch
  scheduler tunables

set_page_dirty_lock.patch
  fix set_page_dirty vs truncate&free races

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

inline-constant-small-copy_user.patch
  inline 1,2 and 4-byte copy_*_user operations

oprofile-p4.patch

op4-fix.patch

wli-02_do_sak.patch
  (undescribed patch)

wli-03_proc_super.patch
  (undescribed patch)

wli-06_uml_get_task.patch
  (undescribed patch)

wli-07_numaq_mem_map.patch
  (undescribed patch)

wli-08_numaq_pgdat.patch
  (undescribed patch)

wli-09_has_stopped_jobs.patch
  (undescribed patch)

wli-10_inode_wait.patch
  (undescribed patch)

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-11_pgd_ctor-update.patch
  pgd_ctor update

wli-13_rmap_nrpte.patch
  (undescribed patch)

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-api-2.5.53-mm2-update.patch
  pagewalk API update

page-walk-scsi.patch

page-walk-scsi-2.5.53-mm2.patch
  pagewalk scsi update

smalldevfs.patch
  smalldevfs
