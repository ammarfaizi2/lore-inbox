Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTFEI7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTFEI7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:59:13 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:28838 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264531AbTFEI7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:59:00 -0400
Date: Thu, 5 Jun 2003 02:12:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm5
Message-Id: <20030605021231.2b3ebc59.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 09:12:31.0234 (UTC) FILETIME=[97DF5E20:01C32B42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm5/

. Hopefully fixed a JBD race which can cause every-second-day assertion
  failures in journal_dirty_metadata().

. The AIO infrastructure has been extended to cover O_SYNC writes.




Changes since 2.5.70-mm4:


 linus.patch

 Latest -bk

-aio-random-cleanups.patch
-time-interpolator-cleanup.patch
-cadetradio-badcopy.patch
-cmpci-userptr.patch
-zr36120-userptr.patch
-truncate-vs-msync-fix.patch
-pnpbios-oops-leak-fix.patch
-bw-qcam-fix.patch
-devfs_remove-fix.patch
-generic_file_write-fix-2.patch
-reiserfs-parser-fix-remount.patch
-reiserfs-small-blocksize.patch
-raid-fixes.patch
-neilb-raid1-double-free-fix.patch
-hugetlbfs-mount-options.patch
-raid5-use-right-dev-fix.patch
-deadline-hash-removal-fix.patch
-thread-info-in-task_struct.patch
-journal_create-deadlock-fix.patch

 Merged

+mem_driver_cleanup.patch

 drivers/char/mem.c cleanups and fixes

+remove-get_current_user.patch

 get_current_user() has no users.

+de_thread-BUG-fix.patch

 Remove a triggerable BUG

+hweight64-warning-fix.patch

 Fix all those gcc-3.3 warnings.

+as-stupid.patch
+as-no-batch-antic-limit.patch

 Anticipatory scheduler fixes & tweaks.

+dac960-negotiation-fix.patch

 DAC960 fix

-reinstate-task-freeing-hack-for-ia64.patch

 Dropped, unneeded.

-event-log-put_task_struct.patch

 Dropped - it didn't actually print anything when the bug triggered anyway.

-ext3-orlov-approx-counter-fix.patch
-ext3-concurrent-block-allocation-fix-1.patch
-ext3-concurrent-block-inode-allocation-fix.patch
-jbd-300-remove-lock_kernel-journal_c.patch
-jbd-310-remove-lock_kernel-transaction_c.patch
-jbd-400-remove-lock_journal-checkpoint_c.patch
-jbd-410-remove-lock_journal-commit_c.patch
-jbd-420-remove-lock_journal-journal_c.patch
-jbd-430-remove-lock_journal-transaction_c.patch
-jbd-440-remove-lock_journal.patch
+jbd-300-remove-lock_kernel.patch
+jbd-400-remove-lock_journal.patch

 Various things rolled into other things.

+jbd-620-commit-vs-start-race-fix.patch

 Fix race between start_transaction() and kjournald.

+aio-09-o_sync.patch

 AIO treatment for O_SYNC writes.





All 157 patches


linus.patch

kconfig-dont-scrog--my-config.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

kmalloc_percpu-interface-change.patch
  kmalloc_percpu: interface change.

kmalloc_percpu-interface-change-warning-fix.patch
  nail a warning

DEFINE_PERCPU-in-modules.patch
  per-cpu support inside modules (minimal)

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-fixup.patch
  ppc64 fixup

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

common-ioctl32.patch
  From: Pavel Machek <pavel@suse.cz>
  Subject: Re: must-fix list, v5

ioctl32-cleanup-sparc64.patch
  ioctl32 cleanup: sparc64

ioctl32-cleanup-x86_64.patch
  ioctl32 cleanup: sparc64

lru_cache_add-check.patch
  lru_cache_add debug check

eat-keys-on-panic.patch
  Eat keys on panic

force_successful_syscall_return.patch
  force_successful_syscall_return

mem_driver_cleanup.patch
  driver/char/mem.c cleanup

proc-stat-btime-fix.patch
  fix wobbly /proc/stat:btime

eventpoll-use-after-free-fix.patch
  eventpoll: fix possible use-after-free

console-blanking-fix.patch
  Console blanking fix

console-privacy.patch
  Console privacy for braille users

fix-tty-driver-mess.patch
  Fix tty devfs mess

misc3.patch
  misc fixes

fb-image-depth-fix.patch
  fbdev image depth fix

buffer-debug.patch
  buffer.c debugging

cs423x-fixes.patch
  cs423x fixes

remove-get_current_user.patch
  remove get_current_user()

de_thread-BUG-fix.patch
  remove triggerable BUG() from de_thread

statfs64.patch
  Add system calls statfs64 and fstatfs64

statfs64-fix.patch

statfs-overflow-fix.patch
  statfs64: handle overflows

statfs64-leftovers.patch
  statfs64: remaining filesystems

sched_best_cpu-fix-01.patch
  Fix Bug 619: Processes Scheduled on CPU-less nodes (1/3)

sched_best_cpu-fix-02.patch
  Processes Scheduled on CPU-less nodes (2/3)

sched_best_cpu-fix-03.patch
  Fix Bug 619: Processes Scheduled on CPU-less nodes (3/3)

hweight64-warning-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

linux-isp.patch

isp-update-1.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-proc-read-write.patch
  AS: pgbench improvement

as-discrete-read-fifo-batches.patch
  AS: discrete read fifo batches

as-sync-async.patch
  AS sync/async batches

as-hash-removal-fix.patch
  AS: hash removal fix

as-jumbo-patch-for-scsi.patch
  AS jumbo patch (for SCSI and TCQ)

as-stupid.patch
  AS: fix stupid thinko

as-no-batch-antic-limit.patch
  AS: no batch-antic-limit

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2
  CFQ: update to rq-dyn API

cfq-hash-removal-fix.patch
  CFQ: hash removal fix

cfq-list_del-fix.patch
  CFQ: empty the queuelist

per-queue-nr_requests.patch
  per queue nr_requests

blk-invert-watermarks.patch
  blk_congestion_wait threshold cleanup

blk-fair-batches.patch
  blk-fair-batches

blk-as-hint.patch
  blk-as-hint

get_request_wait-oom-fix.patch
  handle OOM in get_request_wait().

unmap-page-debugging-2.patch
  debug patch: unmap unused kernel pages

unmap-page-debugging-2-fix.patch

slab-poisoning-fix.patch
  slab poisoning fix

print-build-options-on-oops.patch
  print a few config options on oops

mmap-prefault.patch
  prefault of executable mmaps

dac960-negotiation-fix.patch
  DAC960 fix for fibre channel transfer rate

bio-debug-trap.patch
  BIO debugging patch

sound-irq-hack.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ext3-no-bkl.patch

journal_get_write_access-speedup.patch
  JBD: journal_get_write_access() speedup

ext3-concurrent-block-inode-allocation.patch
  ext3: concurrent block/inode allocation
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-hashed.patch
  ext3: scalable counters and locks
  fix ext3 inode allocator race

jbd-010-b_committed_data-race-fix.patch
  JBD: fix race over access to b_committed_data

jbd-020-locking-schema.patch
  JBD: plan JBD locking schema

jbd-030-remove-splice_lock.patch
  JBD: remove jh_splice_lock

jbd-040-journal_add_journal_head-locking.patch
  JBD: fine-grain journal_add_journal_head locking

jbd-045-rename-journal_unlock_journal_head.patch
  JBD: rename journal_unlock_journal_head to journal_put_journal_head

jbd-050-b_frozen_data-locking.patch
  JBD: Finish protection of journal_head.b_frozen_data

jbd-060-b_committed_data-locking.patch
  JBD: implement b_committed_data locking

jbd-070-b_transaction-locking.patch
  JBD: implement b_transaction locking rules

jbd-080-b_next_transaction-locking.patch
  JBD: Implement b_next_transaction locking rules

jbd-090-b_tnext-locking.patch
  JBD: b_tnext locking

jbd-100-remove-journal_datalist_lock.patch
  JBD: remove journal_datalist_lock

jbd-110-t_nr_buffers-locking.patch
  JBD: t_nr_buffers locking

jbd-120-t_updates-locking.patch
  JBD: t_updates locking

jbd-130-t_outstanding_credits-locking.patch
  JBD: implement t_outstanding_credits locking

jbd-140-t_jcb-locking.patch
  JBD: implement t_jcb locking

jbd-150-j_barrier_count-locking.patch
  JBD: implement j_barrier_count locking

jbd-160-j_running_transaction-locking.patch
  JBD: implement j_running_transaction locking

jbd-170-j_committing_transaction-locking.patch
  JBD: implement j_committing_transaction locking

jbd-180-j_checkpoint_transactions.patch
  JBD: implement j_checkpoint_transactions locking

jbd-190-j_head-locking.patch
  JBD: implement journal->j_head locking

jbd-200-j_tail-locking.patch
  JBD: implement journal->j_tail locking

jbd-210-j_free-locking.patch
  JBD: implement journal->j_free locking

jbd-220-j_commit_sequence-locking.patch
  JBD: implement journal->j_commit_sequence locking

jbd-230-j_commit_request-locking.patch
  JBD: implement j_commit_request locking

jbd-240-dual-revoke-tables.patch
  JBD: implement dual revoke tables.

jbd-250-remove-sleep_on.patch
  JBD: remove remaining sleep_on()s

jbd-300-remove-lock_kernel.patch
  JBD: remove lock_kernel()

jbd-400-remove-lock_journal.patch
  JBD: remove lock_journal()

jbd-510-h_credits-fix.patch
  JBD: journal_release_buffer: handle credits fix

jbd-520-journal_unmap_buffer-race.patch
  JBD: journal_unmap_buffer race fix

jbd-530-walk_page_buffers-race-fix.patch
  ext3: ext3_writepage race fix

jbd-540-journal_try_to_free_buffers-race-fix.patch
  JBD: buffer freeing non-race comment

jbd-550-locking-checks.patch
  JBD: add some locking assertions

jbd-570-transaction-state-locking.patch
  JBD: additional transaction shutdown locking

jbd-580-log_start_commit-race-fix.patch
  JBD: fix log_start_commit race

jbd-590-do_get_write_access-speedup.patch
  JBD: do_get_write_access() speedup

ext3-010-fix-journalled-data.patch
  ext3: fix data=journal mode

ext3-035-journal_try_to_free_buffers-race-fix.patch

ext3-040-recursive-ext3_write_inode-check.patch
  ext3: add a dump_stack()

ext3-050-ioctl-transaction-leak.patch
  ext3: fix error-path handle leak

ext3-070-xattr-clone-leak-fix.patch
  Fix leak in ext3_acl_chmod()

ext3-080-remove-block-inode-count-message.patch
  ext3: remove mount-time diagnostic messages

jbd-600-journal_dirty_metadata-speedup.patch
  JBD: journal_dirty_metadata() speedup

jbd-610-journal_dirty_metadata-diags.patch
  JBD: journal_dirty_metadata diagnostics

jbd-620-commit-vs-start-race-fix.patch
  JBD: fix race between journal_commit_transaction and start_this_handle

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

aio-01-retry.patch
  AIO: Core retry infrastructure

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-05-fs_write-fix.patch

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

aio-poll.patch
  aio_poll
  aio-poll: don't put extern decls in .c!

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

aio-09-o_sync.patch
  aio O_SYNC

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

syncppp-locking-fix.patch
  syncppp locking fix

s390-dirty-bit-cleaning.patch
  dirty bit clearing on s390.

min_free_kbytes.patch
  /proc/sys/vm/min_free_kbytes

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution



