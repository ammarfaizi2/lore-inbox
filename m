Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTFKITV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 04:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTFKITV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 04:19:21 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39853 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264219AbTFKIS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 04:18:57 -0400
Date: Wed, 11 Jun 2003 01:33:25 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm8
Message-Id: <20030611013325.355a6184.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 08:32:38.0802 (UTC) FILETIME=[0459B720:01C32FF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/

. lots of new fixes

. Anticipatory scheduler patch should fix the recently-noticed slowdown
  with seeky O_DIRECT read loads.

. ext3 locking work will hopefully fix the assertion failure in
  journal_commit_transaction() which two people have reported.





Changes since 2.5.70-mm7:


-isapnp-warning-fix.patch

 Merged

-mem_driver_cleanup.patch
+mem-driver-cleanup-2.patch

 new version

+loop-01-use-highmem.patch
+loop-02-privatise-bio_copy.patch
+loop-03-rename-bio-things.patch
+loop-04-copy-bio-not-data.patch
+loop-05-remove-unused-IV.patch
+loop-06-remove-LO_FLAGS_BH_REMAP.patch
+loop-07-remove-blk_queue_bounce.patch
+loop-08-copy_bio-use-highmem.patch
+loop-09-dont-lose-PF_MEMDIE.patch

 Loop fixes

+fix-numa-meminfo.patch

 Fix /proc/meminfo on x440

+tmpfs-01-shmem_file_write-EFAULT.patch
+tmpfs-02-swapoff-truncate-race-refix.patch
+tmpfs-03-little-bits.patch

 tmpfs fixes

+pci-init-ordering-fix.patch

 Maybe fix PCI initialisation ordering problems.

+early-printk-x86.patch

 super-early printk over the serial port

+resource-seqfile-cleanup.patch

 Code consolidation

+ds-01-arcnet-oops-fix.patch
+ds-02-x25-facilities-parse-fix.patch
+ds-05-eicon-usercopy-fix.patch
+ds-06-intermezzo-usercopy-fix.patch
+ds-07-mdc800-usercopy-fix.patch
+ds-08-mpu401-usercopy-fix.patch
+ds-09-vicam-usercopy-fix.patch
+ds-11-emu10k1-memleak-fix.patch
+ds-12-rio-memleak-fix.patch
+ds-13-i810-leak-fix.patch

 usercopy and memleak fixes

-statfs64.patch
-statfs64-x86_64-fixes.patch
-ppc64-statfs-fix.patch
-xfs-statfs-warning-fix.patch

 Dropped - Peter is redoing this

-odd-numa-fixes.patch

 Sent back to Anton - needs consolidation with other work.

+tioclinux-symbolic-names.patch

 Use names, not numbers for the tioclinux ioctl.

+isp-remove-pci_detect.patch

 Fix linux-isp for PCI API changes

+as-fix-seeky-loads.patch

 Fix anticipatory scheduler regression with seeky reading loads

-unmap-page-debugging-2-fix.patch

 Folded into unmap-page-debugging-2.patch

-jbd-640-ordered-truncate-fix.patch
+jbd-650-truncate-ordered-pages.patch

 oops, this was the wrong patch

+jbd-660-log_do_checkpoint-fix.patch
+jbd-670-log_start_commit-locking-fix.patch

 ext3 locking fixes

+aio-11-workqueue-flush.patch

 Might fix a race in the experimental AIO code

+char-dev-init-call-fix.patch

 Fix initialisation ordering problems.





All 192 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

HZ-100.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bat-initialisation-fix.patch
  ppc64: BAT initialisation fix

ppc64-fixup.patch
  ppc64 fixup

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-knr-to-ansi.patch
  K&R style to ANSI style conversions in arch/ppc64/boot/zlib.c

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-fixes.patch
  x86_64 fixes

remove-DRM-ioctls.patch
  Remove DRM ioctls for common compat ioctl code

rtc-32-bit-fix.patch
  Fix rtc driver for 32bit and 64bit

rtc-busywait-fix.patch
  fix possible busywait in rtc_read()

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

lru_cache_add-check.patch
  lru_cache_add debug check

discontig-empty-node-fix.patch
  fix discontig with 0-sized nodes

mem-driver-cleanup-2.patch
  drivers/char/mem.c cleanup

TARGET_CPUS-cleanup-fix.patch
  fix TARGET_CPUS inconsistency

compaq-drivers-MAINTAINERS.patch
  update MAINTAINERS for Compaq drivers

fixed-size-kmalloc-speedup.patch
  optimize fixed-sized kmalloc calls

rebalance_tick-fix.patch
  fix scheduler bug not passing idle

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

time-fixes-cleanup-1.patch
  Some clean up of the time code.

time-fixes-cleanup-2.patch
  More time clean up stuff

loop-01-use-highmem.patch
  loop 1/9 file use highmem

loop-02-privatise-bio_copy.patch
  loop 2/9 make bio_copy private to loop

loop-03-rename-bio-things.patch
  loop 3/9 loop bio renaming

loop-04-copy-bio-not-data.patch
  loop 4/9 copy bio not data

loop-05-remove-unused-IV.patch
  loop 5/9 remove an IV

loop-06-remove-LO_FLAGS_BH_REMAP.patch
  loop 6/9 remove LO_FLAGS_BH_REMAP

loop-07-remove-blk_queue_bounce.patch
  loop 7/9 remove blk_queue_bounce

loop-08-copy_bio-use-highmem.patch
  loop 8/9 copy_bio use highmem

loop-09-dont-lose-PF_MEMDIE.patch
  loop 9/9 don't lose PF_MEMDIE

fix-numa-meminfo.patch
  fix numa meminfo

tmpfs-01-shmem_file_write-EFAULT.patch
  tmpfs 1/3 shmem_file_write EFAULT

tmpfs-02-swapoff-truncate-race-refix.patch
  tmpfs 2/3 swapoff-truncate race

tmpfs-03-little-bits.patch
  tmpfs 3/3 misc fixes

pci-init-ordering-fix.patch
  randomly mangle x86 PCI init ordering

early-printk-x86.patch
  early printk for x86

fb-image-depth-fix.patch
  fbdev image depth fix

resource-seqfile-cleanup.patch
  cleanup seqfile usage in resource.c

ds-01-arcnet-oops-fix.patch
  arcnet oops fix

ds-02-x25-facilities-parse-fix.patch
  x25 facilities parsing fix

ds-05-eicon-usercopy-fix.patch
  eicon usercopy fix

ds-06-intermezzo-usercopy-fix.patch
  intermezzo usercopy fix

ds-07-mdc800-usercopy-fix.patch
  mdc800 usercopy fix

ds-08-mpu401-usercopy-fix.patch
  mpu401 usercopy fix

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

ds-11-emu10k1-memleak-fix.patch
  emu10k1 memleak fix

ds-12-rio-memleak-fix.patch
  rio memleak fix

ds-13-i810-leak-fix.patch
  fix resource leak in i810 driver

serial-core-oops-fix.patch
  fix oops in driver/serial/core.c

buffer-debug.patch
  buffer.c debugging

show_stack-cleanup.patch
  show_stack() portability and cleanup patch

ppc64-show_stack.patch

trond-3.patch
  trond debug patch #3

nfs-to-localhost-lockup-fix.patch
  fix hangs with nfs to localhost

devfs_mk_dir-fix.patch
  devfs_mk_dir() fix

tioclinux-symbolic-names.patch
  tioclinux() numbers in <linux/tiocl.h>

cpqarray-stack-reduction.patch
  Subject: [PATCH] cpqarray.c fix stack usage

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

linux-isp.patch

isp-update-1.patch

isp-remove-pci_detect.patch

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

as-autotune-write-batches.patch
  AS: autotune write batches

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

blk-fair-batches.patch
  blk-fair-batches

blk-as-hint.patch
  blk-as-hint

get_request_wait-oom-fix.patch
  handle OOM in get_request_wait().

blk-fair-batches-2.patch
  blk fair batches #2

unmap-page-debugging-2.patch
  debug patch: unmap unused kernel pages

slab-poisoning-fix.patch
  slab poisoning fix

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

aio-10-BUG-fix.patch
  AIO: fix a BUG

aio-11-workqueue-flush.patch
  AIO: flush workqueues before destroying ioctx'es

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

syncppp-locking-fix.patch
  syncppp locking fix

s390-dirty-bit-cleaning.patch
  dirty bit clearing on s390.

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

char-dev-init-call-fix.patch
  chardev initcall sequence fix



