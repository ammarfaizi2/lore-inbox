Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268159AbTAKWeP>; Sat, 11 Jan 2003 17:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268161AbTAKWeP>; Sat, 11 Jan 2003 17:34:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:50080 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268159AbTAKWeL> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 17:34:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.56-mm1
Date: Sat, 11 Jan 2003 14:43:08 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301111443.08527.akpm@digeo.com>
X-OriginalArrivalTime: 11 Jan 2003 22:42:52.0542 (UTC) FILETIME=[C68871E0:01C2B9C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.56/2.5.56-mm1/

Nothing much new here except for a fix for the ext3-related memory leak which
Con reported recently.


The main items which remain unmerged from the -mm patch series are now:

- red/black-tree based insertion and sorting for the I/O scheduler.

  Jens will be submitting this next week.  It's completely stable, and the
  patch includes the addition of the I/O scheduler tunables in
  /sys/block/hda/iosched/, which is fairly important.

- Code to automatically unplug request queues on the basis of their
  occupancy and a timeout.

  Jens will be reviewing this soon.

- dcache-RCU.

  This was recently updated to fix a rename race.  It's quite stable.  I'm
  not sure where we stand wrt merging it now.  Al seems to have disappeared.

- Ingo Oeser's user page walking rework.  This appears to be stable,
  although I'm not sure what testing it has had apart from a lot of direct-io
  testing.

- Quite a lot of misc stuff which I need to go through and either send or
  toss.


Changes since 2.5.55-mm1:


+linus.patch

 Latest from Linus

-inlines-net.patch
-deadline-fixups.patch
-i_shared_sem.patch
-cond_resched_lock-rework.patch
-untypedef-mmu_gather.patch
-touched_by_munmap-go-forwards.patch
-low-latency-page-unmapping.patch
-misc.patch
-smp-preempt-latency-fix.patch
-set_page_dirty_lock.patch
-inline-constant-small-copy_user.patch

 Merged

+deadline-fixes.patch

 Some deadline scheduler tweaks and fixes

+deadline-sysfs-fix.patch

 Fix up the deadline scheduler patches to track recent sysfs changes

+ext3-leak-fix.patch

 Fix the memory leak whcih Con reported

+hugetlbfs-read-write.patch

 Don't permit reading or writing of hugetlbfs files.



All 44 patches:

linus.patch
  cset-1.897-to-1.929.txt.gz

kgdb.patch

rcf.patch
  run-child-first after fork

devfs-fix.patch

cputimes_stat.patch
  Retore per-cpu time accounting, with a config option

rbtree-iosched.patch
  rbtree-based IO scheduler

deadline-fixes.patch
  deadsched cleanups/fixups

deadline-sysfs-fix.patch

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

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

ext3-leak-fix.patch
  fix ext3 memory leak

hugetlbfs-read-write.patch
  hugetlbfs: don't implement read/write file_ops

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




