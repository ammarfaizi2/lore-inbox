Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTE0H3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 03:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTE0H3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 03:29:53 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:53643 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262742AbTE0H3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 03:29:42 -0400
Date: Tue, 27 May 2003 00:42:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm1
Message-Id: <20030527004255.5e32297b.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 07:42:55.0143 (UTC) FILETIME=[95C13B70:01C32423]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.70-mm1.gz

  Will appear soon at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm1/

. A number of fixes against the ext3 work which Alex and I have been doing.
  This code is stable now.  I'm using it on my main SMP desktop machine.

  These are major changes to a major filesystem.  I would ask that
  interested parties now subject these patches to stresstesting and to
  performance testing.  The performance gains on SMP will be significant.

. I dropped the kexec patches.  Mainly because the sheer extent of the -mm
  diffs is getting in the way of other work, and the kexec patches
  significantly altered the arch/i386 code where other things are happening.




Changes since 2.5.69-mm9:


 linus.patch

 Latest post-2.5.70 BK

+sysenter-nmi-fix-2.patch

 Fix an NMI rce in the sysenter code

-irqreturn-drivers-net.patch
-ppc64-aio-32bit-emulation.patch
-ppc64-scruffiness.patch
-ppc64-xics-irq-fix.patch
-ppc64-addnote-warning-fix.patch
-ppc64-fp-warning-fix.patch
-ppc64-do_signal32-fix.patch
-ppc64-xics-warning-fix.patch
-ppc64-prom-warning-fix.patch
-ppc64-compat-build-fix.patch
-ppc64-ioctl32-warning-fix-2.patch
-ppc64-setup-warning-fix.patch
-ppc64-traps-warning-fixes.patch
-ppc64-lpar-warning-fixes.patch
-tty_io-warning-fix.patch
-siocdevprivate_ioctl-warning-fix.patch
-aic-errno-removal.patch
-aic-non-i386-build-fix.patch
-aic7xxx-fixes.patch
-mpparse-warning-fix.patch
-dcache_lock-vs-tasklist_lock-take-3.patch
-apm-set_cpus_allowed-fix.patch
-reiserfs-inode-attribute-support.patch
-make-KOBJ_NAME-match-BUS_ID_SIZE.patch
-xirc2ps_cs-irqreturn-fix.patch
-readdir-return-value-fix.patch
-inode-unhashing-fix-2.patch
-as-dont-clear-last_merge.patch
-cfq-dont-clear-last_merge.patch
-cfq-iosched-dyn.patch
-slab-reclaimable-accounting.patch
-slab-reclaimable-accounting-fs.patch
-security-process-attribute-api.patch
-proc-pid-attr-fix.patch
-proc-pid-security-labels.patch
-CONFIG_FUTEX.patch
-CONFIG_EPOLL.patch
-devpts-xattr-handler.patch
-overcommit-root-margin.patch
-rpc-ifdef-fix.patch
-notify_count-for-de_thread.patch
-extend-check_valid_hugepage_range.patch
-misc2.patch
-io_stats-documentation.patch
-voyager-do_fork-fix.patch
-cpia-fp-removal.patch
-rd-separate-queues.patch
-mystery-subarch-fix.patch
-ewrk3-memleak-fix.patch
-initrd-memleak-fix.patch
-pnp-memory-leaks.patch
-per-cpu-mmu_gathers.patch
-srat-warning-fix.patch
-ACPI-constant-overflow-fixes.patch
-tulip-warning-fix.patch
-install_page-flushing.patch
-netdev-deadlock-fix.patch

 Merged

+i2o-leak-comment.patch

 Explain why a memleak is deliberate.

+raid5-use-right-dev-fix.patch

 Fix raid5 buglet.

+unlink-speedup-speedup.patch

 Avoid an inode_lock taking in unlink.

-time-interpolation-infrastructure-fix.patch

 Folded into time-interpolation-infrastructure.patch

+slab-scribble-negative.patch

 Use a value for slab poisoning which doesn't magically unlock all poisoned
 ia32 spinlocks.

+remove-fcntl-check.patch

 Cleanups, maybe a bugfix.

+jbd-510-h_credits-fix.patch
+jbd-520-journal_unmap_buffer-race.patch
+jbd-530-walk_page_buffers-race-fix.patch
+jbd-540-journal_try_to_free_buffers-race-fix.patch
+jbd-550-locking-checks.patch
+jbd-560-transaction-leak-fix.patch
+jbd-570-transaction-state-locking.patch

 ext3/JBD fixes

-reboot_on_bsp.patch
-kexec-revert-NORET_TYPE.patch
-apic_shutdown.patch
-i8259-shutdown.patch
-hwfixes-x86kexec.patch
-kexec-warning-fixes-2.patch

 Dropped.

+aio-05-fs_write-fix.patch

 Build fix.

-aio-poll-cleanup.patch

 Folded into aio-poll.patch

+64-bit-pci_alloc_consistent.patch

 Support 64-bit address allocations from pci_alloc_consistent().

+svcsock-use-after-free-fix.patch

 kNFSd bugfix

+sched-hot-balancing-fix.patch

 CPU scheduler optimisation.





All 130 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

sysenter-nmi-fix-2.patch
  fix bad pointer access in nmi

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kmalloc_percpu-interface-change.patch
  kmalloc_percpu: interface change.

kmalloc_percpu-interface-change-warning-fix.patch
  nail a warning

DEFINE_PERCPU-in-modules.patch
  per-cpu support inside modules (minimal)

slab-magazine-layer.patch
  magazine layer for slab

slabinfo-rework.patch
  new statistics for slab

aio-random-cleanups.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

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

buffer-debug.patch
  buffer.c debugging

irq_balance-fix-2.patch
  irq balance logic fix

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

i2o-leak-comment.patch
  i2o memleak comment

raid5-use-right-dev-fix.patch
  raid5 fix

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

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2
  CFQ: update to rq-dyn API

per-queue-nr_requests.patch
  per queue nr_requests

unmap-page-debugging.patch
  unmap unused pages for debugging

CONFIG_DEBUG_PAGEALLOC-extras.patch
  From: Manfred Spraul <manfred@colorfullife.com>
  Subject: DEBUG_PAGEALLOC

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

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

unlink-speedup-speedup.patch
  speedp the unlink speedup

time-interpolation-infrastructure.patch
  improved core support for time-interpolation
  make timer interpolation patch compile

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

reinstate-task-freeing-hack-for-ia64.patch
  reinstate lame task_struct (non)-refcounting hack/fix

slab-scribble-negative.patch
  Make the slab poisoning values negative

remove-fcntl-check.patch
  Remove unneeded fcntl check

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3

jbd-010-b_committed_data-race-fix.patch
  Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd

jbd-020-locking-schema.patch
  plan JBD locking schema

jbd-030-remove-splice_lock.patch
  remove jh_splice_lock

jbd-040-journal_add_journal_head-locking.patch
  fine-grain journal_add_journal_head locking

jbd-045-rename-journal_unlock_journal_head.patch
  rename journal_unlock_journal_head to journal_put_journal_head

jbd-050-b_frozen_data-locking.patch
  Finish protection of journal_head.b_frozen_data

jbd-060-b_committed_data-locking.patch

jbd-070-b_transaction-locking.patch
  implement b_transaction locking rules

jbd-080-b_next_transaction-locking.patch
  Implement b_next_transaction locking rules

jbd-090-b_tnext-locking.patch
  b_tnext locking

jbd-100-remove-journal_datalist_lock.patch
  remove journal_datalist_lock

jbd-110-t_nr_buffers-locking.patch
  t_nr_buffers locking

jbd-120-t_updates-locking.patch
  t_updates locking

jbd-130-t_outstanding_credits-locking.patch
  implement t_outstanding_credits locking

jbd-140-t_jcb-locking.patch
  implement t_jcb locking

jbd-150-j_barrier_count-locking.patch
  implement j_barrier_count locking

jbd-160-j_running_transaction-locking.patch
  implement j_running_transaction locking

jbd-170-j_committing_transaction-locking.patch
  implement j_committing_transaction locking

jbd-180-j_checkpoint_transactions.patch
  implement j_checkpoint_transactions locking

jbd-190-j_head-locking.patch
  implement journal->j_head locking

jbd-200-j_tail-locking.patch
  implement journal->j_tail locking

jbd-210-j_free-locking.patch
  implement journal->j_free locking

jbd-220-j_commit_sequence-locking.patch
  implement journal->j_commit_sequence locking

jbd-230-j_commit_request-locking.patch
  implement j_commit_request locking

jbd-240-dual-revoke-tables.patch
  implement dual revoke tables.

jbd-250-remove-sleep_on.patch
  remove remaining sleep_on()s

jbd-300-remove-lock_kernel-journal_c.patch
  remove lock_kernel() calls from journal.c

jbd-310-remove-lock_kernel-transaction_c.patch
  remove lock_kernel calls from transaction.c

jbd-400-remove-lock_journal-checkpoint_c.patch
  remove lock_journal calls from checkpoint.c

jbd-410-remove-lock_journal-commit_c.patch
  remove lock_journal() from commit.c

jbd-420-remove-lock_journal-journal_c.patch
  remove lock_journal() calls from journal.c

jbd-430-remove-lock_journal-transaction_c.patch
  remove lock_journal() calls from transaction.c

jbd-440-remove-lock_journal.patch
  remove lock_journal()

jbd-510-h_credits-fix.patch
  journal_release_buffer: handle credits fix

jbd-520-journal_unmap_buffer-race.patch
  journal_unmap_buffer race fix

jbd-530-walk_page_buffers-race-fix.patch
  ext3_writepage race fix

jbd-540-journal_try_to_free_buffers-race-fix.patch
  buffer freeing non-race comment

jbd-550-locking-checks.patch
  add some locking assertions

jbd-560-transaction-leak-fix.patch
  transaction leak and race fix

jbd-570-transaction-state-locking.patch
  additional transaction shutdown locking

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

unregister_netdev-cleanup.patch

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

64-bit-pci_alloc_consistent.patch
  support 64 bit pci_alloc_consistent

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

lockfree-lookup_mnt.patch
  lockfree lookup_mnt

proc-kcore-rework.patch
  /proc/kcore fixes

syncppp-locking-fix.patch
  syncppp locking fix

s390-dirty-bit-cleaning.patch
  dirty bit clearing on s390.

min_free_kbytes.patch
  /proc/sys/vm/min_free_kbytes

svcsock-use-after-free-fix.patch
  svsock use-after-free fix

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution



