Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263301AbTDCIq3>; Thu, 3 Apr 2003 03:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTDCIq3>; Thu, 3 Apr 2003 03:46:29 -0500
Received: from [12.47.58.55] ([12.47.58.55]:19777 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263301AbTDCIqR>;
	Thu, 3 Apr 2003 03:46:17 -0500
Date: Thu, 3 Apr 2003 00:58:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.66-mm3
Message-Id: <20030403005817.69a29d7b.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 08:57:38.0695 (UTC) FILETIME=[13DA7970:01C2F9BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.66-mm3.gz

  Will also appear sometime at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/

. The CPU scheduler starvation fix which was supposed to be in 2.5.66-mm2
  actually wasn't included.  This time it's here for real.

. Just lots of little fixes.  This is mainly a resync for various people
  who are working on things.  




Changes since 2.5.66-mm2:


-cdrom-stack-usage.patch
-module_load_notification.patch
-remove-kdev_name.patch
-kill-TIOCTTYGSTRUCT.patch
-sony-apm-fix.patch
-PCI-aliases-fix.patch
-acpi-build-fix.patch

 Merged

+wait_on_buffer-debug-fix.patch

 Fix a bogus warning

+tty-shutdown-race-fix.patch

 Fix a tty close timer race

+icmp_stats-indexing-fix.patch

 Fix memory corruption in net stats

+kgdb-ga-warning-fix.patch

 Fix a warning in the kgdb stub

-as-queue_notready-cleanup.patch

 Drop this for the while.  It hurts performance.

+as-locking-fix.patch

 Fix a race which causes a BUG

+objrmap-sort-vma-list.patch

 Maybe speed up objrmap-based page reclaim

+stale-inode-fix.patch

 Fix ext2 errors with knfsd and IO errors.

+sched-interactivity-backboost-revert.patch

 Really revert the CPU scheduler backboost patch

+panic-on-oops.patch

 /proc/sys/kernel/panic_on_oops: make the kernel panic (and hence reboot)
 after an oops.

+posix-timer-hang-fix.patch

 Some posix timer fix.

+warning-fixes-1.patch

 Random compile warnings

+bio_kmap-fix.patch

 Various BIO + highmem fixes

+file-limit-checking-cleanup.patch

 generic_file_write() cleanup

+tmpfs-1-use-generic_write_checks.patch
+tmpfs-2-remove-shmem_readpage.patch
+tmpfs-3-user-generic_file_llseek.patch
+tmpfs-4-use-mark_page_accessed.patch
+tmpfs-4-use-cond_resched.patch
+tmpfs-6-percentile-sizing.patch

 tmpfs work

+smp_call_function-barrier.patch

 Fix Zwane's 3-way

+adaptec-del_timer_sync.patch

 Fix timer race in aic7xxx

+aggregated-disk-stats.patch

 Create /proc/diskstats - this brings stats aggregagtion back into the
 kernel so userspace monitoring tools do not need to open 10000 sysfs files
 per second.

-jbd-handle-journal-io-errors-fix.patch

 Folded into jbd-handle-journal-io-errors.patch




All 112 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

wait_on_buffer-debug-fix.patch
  fix wait_on_buffer() debug code

tty-shutdown-race-fix.patch
  fix tty shutdown race

icmp_stats-indexing-fix.patch
  net: severe bug in icmp stats

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-warning-fix.patch
  -mm traps.c warning

ppa-null-pointer-fix.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

kblockd.patch
  Create `kblockd' workqueue

as-iosched.patch
  anticipatory I/O scheduler

as-np-reads-1.patch
  AS: read-vs-read fixes

as-np-reads-2.patch
  AS: more read-vs-read fixes

as-predict-data-direction.patch
  as: predict direction of next IO

as-remove-frontmerge.patch
  AS: remove frontmerge tunable

as-misc-cleanups.patch
  AS: misc cleanups

as-minor-tweaks.patch
  AS: tuning and tweaks

as-remove-stats.patch
  AS: remove statistics

as-locking-fix.patch
  AS: Fix minor race

as-disable-thinktime.patch

cfq-2.patch
  CFQ scheduler, #2

unplug-use-kblockd.patch
  Use kblockd for running request queues

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

objrmap-2.5.62-5.patch
  object-based rmap

hugh-04-page_convert_anon-ENOMEM.patch
  swap 04/13 page_convert_anon -ENOMEM

hugh-05-page_convert_anon-unlocking.patch
  swap 05/13 page_convert_anon unlocking

hugh-06-wrap-below-vm_start.patch
  swap 06/13 wrap below vm_start

hugh-07-objrmap-page_table_lock.patch
  swap 07/13 objrmap page_table_lock

hugh-08-rmap-comments.patch
  swap 08/13 rmap comments

hugh-11-fix-unuse_pmd-fixme.patch
  swap 11/13 fix unuse_pmd fixme

tmpfs-blk_congestion_wait-fix.patch
  tmpfs blk_congestion_wait fix

page_convert_anon-locking-fix.patch
  page_convert_anon locking fix

objrmap-sort-vma-list.patch
  objrmap: optimise per-mapping vma searches

stale-inode-fix.patch
  handle bad inodes in put_inode

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

sched-interactivity-backboost-revert.patch
  revert CPU scheduler backboost heuristic

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

task_prio-fix.patch
  simple task_prio() fix

panic-on-oops.patch
  Allow panics and reboots at oops time.

posix-timer-hang-fix.patch
  posix_timer hang fix

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

htree-nfs-fix-2.patch
  htree nfs fix

monotonic-clock-hangcheck.patch
  monotonic clock source for hangcheck timer

put_task_struct-debug.patch

warning-fixes-1.patch
  Fix some compile warnings

bio_kmap-fix.patch
  bio kmapping changes

file-limit-checking-cleanup.patch
  Subject: [PATCH] filemap ffffffffull

tmpfs-1-use-generic_write_checks.patch
  tmpfs 1/6 use generic_write_checks

tmpfs-2-remove-shmem_readpage.patch
  tmpfs 2/6 remove shmem_readpage

tmpfs-3-user-generic_file_llseek.patch
  tmpfs: use generic_file_llseek

tmpfs-4-use-mark_page_accessed.patch
  tmpfs: use mark_page_accessed

tmpfs-4-use-cond_resched.patch
  tmpfs: use cond_resched

tmpfs-6-percentile-sizing.patch
  tmpfs: percentile sizing of tmpfs

percpu_counter.patch
  percpu_counters: approximate but scalabel counters

blockgroup_lock.patch
  blockgroup_lock: hashed spinlocks for ext2 and ext3 blockgroup locking

ext2-no-lock_super-ng.patch

ext2-ialloc-no-lock_super-ng.patch

stat_t-larger-dev_t.patch
  struct stat - support larger dev_t

dev_t-32-bit.patch
  [for playing only] change type of dev_t

dev_t-remove-B_FREE.patch
  dev_t: eliminate B_FREE

sg-dev_t-fix.patch
  32-bit dev_t fix for sg

misc.patch
  misc fixes

smp_call_function-barrier.patch
  smp_call_function needs mb()

adaptec-del_timer_sync.patch
  aic7xxx timer deletion fix

init-sections-in-kallsyms.patch
  Put all functions in kallsyms

3c59x-980-support.patch
  Additional 3c980 device support

aggregated-disk-stats.patch
  Aggregated disk statistics

fadvise-flush-data.patch
  sync dirty pages in fadvise(FADV_DONTNEED)

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

console-scrollback.patch
  add vt console scrollback ioctl

usb-disconnect-crash-fix.patch
  Subject: Re: [linux-usb-devel] timer hang with current 2.5 BK

devfs-rescan_partitions-fix.patch
  Fix devfs' partition handling

umsdos-fixes.patch
  umsdos fixes

exp_parent-locking-fix.patch
  exp_parent locking fixes

real_lookup-race-fix.patch
  real_lookup race fix

remove-dparent_lock.patch
  remove dparent_lock

conntrack-use-after-free-fix.patch
  fix use-after-free in ip_conntrack

jbd_expect.patch
  Add less-severe assert-failure form for ext3.

jbd-assert-io-failure-fix.patch
  Fix jbd assert failure on IO error.

ext3_mark_inode_dirty-speedup.patch
  ext3_mark_inode_dirty() speedup

ext3_mark_inode_dirty-less-calls.patch
  ext3_commit_write speedup

ext3-handle-cache.patch
  ext3: create a slab cache for transaction handles

jbd-handle-journal-io-errors.patch
  ext3 journal commit I/O error fix

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3



