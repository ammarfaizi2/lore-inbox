Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJUIMi>; Mon, 21 Oct 2002 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSJUIMi>; Mon, 21 Oct 2002 04:12:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:12164 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261281AbSJUIMd>;
	Mon, 21 Oct 2002 04:12:33 -0400
Message-ID: <3DB3B858.C7CD5DA1@digeo.com>
Date: Mon, 21 Oct 2002 01:18:32 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.44-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 08:18:32.0588 (UTC) FILETIME=[71B7F4C0:01C278DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm2/

. Some more work on the per-cpu memory arenas

. Added a bunch of fixes to various things courtesy of davem

. Merged up a later version of the EA+ACL code

. Lots of little fixes everywhere.

. Fixed a shared pagetable SMP deadlock


Since 2.5.44-mm1:


+scsi-reboot-fix.patch

 Make /sbin/reboot work

+misc.patch

 Comment fix

-per-cpu-01-core.patch

 Moved to the end of the per-cpu series, so the kernel continues to
 work OK at each step.

+cpuup-notifiers.patch

 Enhanced CPU hotplug notificationa, broken out of per-cpu-01-core.patch

+per-cpu-01-core.patch

 Enables the per-cpu allocation (rather than just allocating a single
 NR_CPUS blob)

+export-per-cpu-symbol.patch

 EXPORT_PER_CPU_SYMBOL[_GPL]

+task-unmapped-base-fix.patch

 Fix compilation of remap_file_pages() for sparc64 and others.

-page_reserved-accounting.patch
-use-page_reserved_accounting.patch

 Dropped (loadshedding)

-net-loopback.patch

 Re-enable TSO or testing.

-spin-lock-check.patch

 More loadshedding

+hugetlb-page-count.patch

 Little hugetlb bugfix

-hugetlbfs-update.patch

 Folded into hugetlbfs.patch

-htlb-shm-update.patch

 Folded into hugetlb-shm.patch

-xattr-01-metablock-cache.patch
-xattr-02-ext3.patch
-xattr-03-ext2.patch
-fix-xattr.patch
-posix-acl-01-core.patch
-posix-acl-02-umask.patch
-posix-acl-03-user-api.patch
-posix-acl-04-ext3.patch
-acl-ext3-fix-tree.patch
-acl-ext3-inode.patch
-posix-acl-05-ext2.patch
-mm1-incr1.patch
-mm1-incr2.patch
-acl-xattr-on.patch
-ext23-mount-options.patch

 Out

+pipe-speedup.patch

 Use prepare_to_wait/finish_wait for pipe wakeups.

+ext23-acl-xattr-01.patch
+ext23-acl-xattr-02.patch
+ext23-acl-xattr-03.patch
+ext23-acl-xattr-04.patch
+ext23-acl-xattr-05.patch
+ext23-acl-xattr-06.patch
+ext23-acl-xattr-07.patch
+ext23-acl-xattr-08.patch
+ext23-acl-xattr-09.patch
+ext23-acl-xattr-10.patch
+ext23-acl-xattr-11.patch
+ext2-mount-fix.patch
+acl-xattr-on.patch

 In



All patches:

ide-warnings.patch
  Fix some IDE compile warnings

dmi-warning.patch
  fix a compile warning in dmi_scan.c

scsi-reboot-fix.patch

kgdb.patch

misc.patch
  misc fixes

ramfs-aops.patch
  Move ramfs address_space ops into libfs

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

pipe-fix.patch
  use correct wakeups in fs/pipe.c

dio-submit-fix.patch
  rework direct-io for bio_add_page

file_ra_state_init.patch
  Add a function to initialise file readahead state

less-unlikelies.patch
  reduced buslocked traffic in the page allocator

running-iowait.patch
  expose nr_running and nr_iowait task counts in /proc

intel-user-copy-taka.patch
  Faster copy_*_user for Intel ia32 CPUs

uaccess-uninline.patch

ingo-oom-kill.patch
  oom-killer changes for threaded apps

unbloat-pid.patch
  Reduce RAM use in kernel/pid.c

per-cpu-ratelimits.patch

for-each-cpu.patch
  for_each_possible_cpu and for_each_online_cpu macros

per-cpu-warning.patch
  Fix per-cpu compile warnings on UP

cpuup-notifiers.patch
  extended cpu hotplug notifiers

per-cpu-02-rcu.patch
  cpu_possible rcu per_cpu data

per-cpu-03-timer.patch
  cpu_possible timer percpu data

per-cpu-04-tasklet.patch
  cpu_possible tasklet percpu data

per-cpu-05-bh.patch
  cpu_possible bh_accounting

per-cpu-01-core.patch
  only allocate per-cpu memory for present CPUs

export-per-cpu-symbol.patch
  create EXPORT_PER_CPU_SYMBOL

per-cpu-page_state.patch

add_timer_on.patch
  add_timer_on(): function to start a timer on a particular CPU

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

slab-timer.patch

slab-use-sem.patch

slab-cleanup.patch
  Slab cleanup

slab-per-cpu.patch
  Use CPU notifiers in slab

ingo-mmap-speedup.patch
  Ingo's mmap speedup

task-unmapped-base-fix.patch
  Don't take TASK_UNMAPPED_BAE at compile time

mm-inlines.patch
  remove some inlines from mm/*

o_streaming.patch
  O_STREAMING support

shmem_getpage-unlock_page.patch
  tmpfs 1/9 shmem_getpage unlock_page

shmem_getpage-beyond-eof.patch
  tmpfs 2/9 shmem_getpage beyond eof

shmem_getpage-reading-holes.patch
  tmpfs 3/9 shmem_getpage reading holes

shmem-fs-cleanup.patch
  tmpfs 4/9 shmem fs cleanup

shmem_file_sendfile.patch
  tmpfs 5/9 shmem_file_sendfile

shmem_file_write-update.patch
  tmpfs 6/9 shmem_file_write update

shmem_getpage-flush_dcache.patch
  tmpfs 7/9 shmem_getpage flush_dcache

loopable-tmpfs.patch
  tmpfs 8/9 loopable tmpfs

event-II.patch
  f_version/i_version cleanups

event-ext2.patch
  f_version/i_version cleanups: ext2

mod_timer-race.patch

blkdev-o_direct-short-read.patch
  Fix O_DIRECT blockdev reads at end-of-device

orlov-allocator.patch

blk-queue-bounce.patch
  inline blk_queue_bounce

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

htlb-update.patch
  hugetlb fixes and cleanups

hugetlb-page-count.patch
  fix hugetlb thinko

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

truncate-bkl.patch
  don't take the BKL in inode_setattr

akpm-deadline.patch
  deadline scheduler tweaks

pipe-speedup.patch
  user faster wakeups in the pipe code

dcache_rcu.patch
  Use RCU for dcache

mpopulate.patch
  remap_file_pages

shmem_populate.patch
  tmpfs 9/9 Ingo's shmem_populate

ext23-acl-xattr-01.patch

ext23-acl-xattr-02.patch

ext23-acl-xattr-03.patch

ext23-acl-xattr-04.patch

ext23-acl-xattr-05.patch

ext23-acl-xattr-06.patch

ext23-acl-xattr-07.patch

ext23-acl-xattr-08.patch

ext23-acl-xattr-09.patch

ext23-acl-xattr-10.patch

ext23-acl-xattr-11.patch

ext2-mount-fix.patch

acl-xattr-on.patch
  turn on posix acls and extended attributes

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

wli-show_free_areas.patch
  show_free_areas extensions

shpte-ng.patch
