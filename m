Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTFQI00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbTFQI0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:26:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:18418 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264643AbTFQI0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:26:13 -0400
Date: Tue, 17 Jun 2003 01:40:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.72-mm1
Message-Id: <20030617014044.0446b19e.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2003 08:40:07.0101 (UTC) FILETIME=[0E0936D0:01C334AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm1/


. A fairly large batch of changes in the block request allocation,
  batching and throttling code.  To address worst-case latency, improve
  throughput in benchmarky loads, etc.

. The memory debugging patch which unmaps pages and large slab objects
  from the kernel virtual address space is back.




Changes since 2.5.71-mm1:


-yenta-unload-oops-fix.patch
-rpc-depopulate-fix.patch

 Merged

+ppc64-fixes-2.patch

 PPC64 touchups from Anton

+pcmcia-detect-fix.patch

 CardSevices fix

+1-kmem-cache-destroy.patch

 Tidy up slab error message handling.

+2-slab-poison-fix.patch

 Corectly poison uninitialised memory with 0x5a5a5a5a

+3-unmap-page-debugging.patch

 New version of Manfred's unmap-unused-kernel-pages debug patch

+sysv-semundo-fixes.patch

 sysv IPC fixes

+raw-devfs-support.patch

 devfs support for /dev/raw/*

+misc5.patch

 Misc fixes

+scroll-distance-fix.patch

 Support console scrolling of more then +127/-128 rows

+generic-io-contexts.patch
+blk-request-batching.patch
+get_io_context-fix.patch
+blk-allocation-commentary.patch
+blk-batching-throttle-fix.patch

 Block request batching fairness and efficiency.

+io_submit_one-EINVAL-fix.patch

 AIO error handling fix.

-aio-poll.patch

 Dropped: apparently incorrect and obviously not being tested.

+lock_buffer_wq-fix.patch

 buffer locking BUG fix

+unuse_mm-locked.patch

 Might fix some problems with the new AIO patches.

+time-goes-backwards.patch

 Demonstrate that do_gettimeofday() tends to leap backwards 45 seconds.

+keventd-thread-cleanup.patch

 kmod fixes

+skip-apic-ids-on-boot.patch

 Ability to disable specific APICs

+AT_SECURE-auxv-entry.patch

 Security stuff






All 176 patches:


mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

HZ-100.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-fixes-2.patch
  Maek ppc64 compile

ppc64-bat-initialisation-fix.patch
  ppc64: BAT initialisation fix

ppc64-pci-update.patch

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-fixes.patch
  x86_64 fixes

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

pcmcia-detect-fix.patch
  pcmcia detection fix

lru_cache_add-check.patch
  lru_cache_add debug check

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

fb-image-depth-fix.patch
  fbdev image depth fix

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

buffer-debug.patch
  buffer.c debugging

show_stack-cleanup.patch
  show_stack() portability and cleanup patch

ppc64-show_stack.patch

e100-use-after-free-fix.patch

statfs64-3.patch
  Add system calls statfs64 and fstatfs64

statfs64-3-fixes-1.patch

1-kmem-cache-destroy.patch
  kmem_cache_destroy(): use slab_error()

2-slab-poison-fix.patch
  slab poisoning fix

3-unmap-page-debugging.patch
  page unmappng debug patch

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

sysv-semundo-fixes.patch
  sysv semundo

raw-devfs-support.patch
  raw.c devfs support

ide_setting_sem-fix.patch

hugetlbfs-size-inodes-mount-option.patch
  hugetlbfs: specify size & inodes at mount

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

misc5.patch
  misc fixes

scroll-distance-fix.patch
  Premit big console scrolls

linux-isp.patch

isp-update-1.patch

isp-remove-pci_detect.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

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

as-autotune-write-batches.patch
  AS: autotune write batches

as-div-by-zero-fix.patch
  AS: divide by zero fix

as-more-HZ.patch
  AS: more HZ != 1000 fixes

as-even-more-write-batch-tuning.patch
  AS: update_write_batch tuning

as-locking.patch
  AS locking

as-HZ.patch
  AS HZ fixes

as-double-free-and-debug.patch
  AS: fix a leak + more debugging

as-fix-seek-estimation.patch
  AS: maybe repair performance drop of random read O_DIRECT

as-fix-seeky-loads.patch
  AS: fix IBM's seek load

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

blk-as-hint.patch
  blk-as-hint

get_request_wait-oom-fix.patch
  handle OOM in get_request_wait().

blk-fair-batches.patch
  blk-fair-batches

blk-fair-batches-2.patch
  blk fair batches #2

generic-io-contexts.patch
  generic io contexts

blk-request-batching.patch
  block request batching

get_io_context-fix.patch
  get_io_context fixes

blk-allocation-commentary.patch
  block allocation comments

blk-batching-throttle-fix.patch
  blk batch requests fix

print-build-options-on-oops.patch
  print a few config options on oops

mmap-prefault.patch
  prefault of executable mmaps

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
  ext3: move lock_kernel() down into the JBD layer.

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

ext3-090-journalled-writepage-vs-truncate-fix.patch
  ext3: fix data=journal for small blocksize

jbd-630-remove-j_commit_timer_active.patch
  JBD: remove j_commit_timer_active

jbd-650-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

jbd-660-log_do_checkpoint-fix.patch
  JBD: log_do_checkpoint() locking fixes

jbd-670-log_start_commit-locking-fix.patch
  JBD: fix locking around log_start_commit()

jbd-680-log_wait_for_space-fix.patch
  JBD: hold onto j_state_lock after log_wait_for_space().

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

aio-01-retry.patch
  AIO: Core retry infrastructure

io_submit_one-EINVAL-fix.patch
  Fix aio process hang on EINVAL

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

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

aio-09-o_sync.patch
  aio O_SYNC

aio-10-BUG-fix.patch
  AIO: fix a BUG

aio-11-workqueue-flush.patch
  AIO: flush workqueues before destroying ioctx'es

aio-12-readahead.patch
  AIO: readahead fixes

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

syncppp-locking-fix.patch
  syncppp locking fix

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

remove-swapper_inode.patch
  remove swapper_inode

sync-write-more-pages.patch
  dirty inode writeback fix

workqueue-reorg-fix.patch
  workqueue.c subtle fix and core extraction

task_struct-use-after-free-fix.patch
  proc_pid_lookup use-after-free fix

sleepometer.patch
  sleep instrumentation

time-goes-backwards.patch
  demonstrate do_gettimeofday() going backwards

keventd-thread-cleanup.patch
  Fix kmod return value

skip-apic-ids-on-boot.patch
  skip apicids on boot

AT_SECURE-auxv-entry.patch
  AT_SECURE auxv entry



