Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265674AbTGCJWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTGCJWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:22:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265674AbTGCJWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:22:09 -0400
Date: Thu, 3 Jul 2003 02:37:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.74-mm1
Message-Id: <20030703023714.55d13934.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm1/

. Mainly a resync with various things and people.  Plus a few fixlets.

. I dropped out a few patches which weren't really proving useful.

. Included Con's CPU scheduler changes.  Feedback on the effectiveness of
  this and the usual benchmarks would be interesting.

  Changes to the CPU scheduler tend to cause surprising and subtle problems
  in areas where you least expect it, and these do take a long time to
  materialise.  Alterations in there need to be made carefully and cautiously.
  We shall see...




Changes since 2.5.73-mm3:


 linus.patch

 Latest Linus tree

-move_vma-VM_LOCKED-fix.patch
-e100-use-after-free-fix.patch
-3-unmap-page-debugging.patch
-VM_RESERVED-check.patch
-numa-memory-reporting-fix-2.patch
-ramfs-use-generic_file_llseek.patch
-inode_change_ok-remove-lock_kernel.patch
-nommu-vmtruncate-no_lock_kernel.patch
-proc-lock_kernel-removal.patch
-fops-flush-no-lock_kernel.patch
-block_llseek-no-lock_kernel.patch
-TC35815-config-fix.patch
-CLONE_DETACHED-exit-fix.patch
-security_vm_enough_memory.patch
-rename-timer-A1.patch
-lost-tick-speedstep-fix-A1.patch
-lost-tick-corner-fix-A0.patch
-lowmem_page_address-cleanup.patch
-ext2_new_inode-race-fix.patch
-double-mmdrop-fix.patch
-cciss-hang-fix.patch
-journal_release_buffer-race-fix.patch

 Merged

-HZ-100.patch

 Go back to 1000 Hz

+misc8.patch

 Misc fixes

-irqreturn-snd-via-fix.patch
-config-PAGE_OFFSET.patch
-lru_cache_add-check.patch
-skip-apic-ids-on-boot.patch
-bio-debug-trap.patch
-sound-irq-hack.patch

 Dropped.

+linux-isp-2-fix-again.patch

 Fix non-modular feral driver

+xattr-cleanup.patch
+xattr-sharing.patch
+xattr-just-replace.patch
+xattr-fine-grained-locking-prep.patch
+xattr-fine-grained-locking.patch

 Finer-grained locking in the ext2 and ext3 extended attribute code.

-as-double-free-and-debug.patch
-as-fix-seek-estimation.patch
-as-fix-seeky-loads.patch

 Folded into as-iosched.patch

-blk-fair-batches-2.patch

 Folded into blk-fair-batches.patch

+nbd-docco-update.patch

 NBD documentation

+cpumask_t-1.patch

 Support up to 255 CPUs

-div64-cleanup.patch

 Waiting for an update

+apci-nmi-watchdog-fix.patch

 ACPI triggers the NMI watchdog during poweroff.   Fix.

+fnup-stats.patch

 Some debug stuff which wasn't supposed to be here.

+bootmem-fixes.patch

 Minor bootmem fixes

+jiffies-include-fixes.patch

 Build fix

+epoll-optimisations.patch

 eventpoll warmups

+o1-interactivity.patch

 Con's scheduler tweaks

+fix-user-leak.patch

 Fix a possible memory leak

+mtd-build-fix.patch

 Build fix





All 116 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

misc8.patch
  misc fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-pci-update.patch

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-fixes.patch
  x86_64 fixes

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

fb-image-depth-fix.patch
  fbdev image depth fix

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

buffer-debug.patch
  buffer.c debugging

ipcsem-speedup.patch
  ipc semaphore optimization

rcu-stats.patch
  RCU statistics reporting

mtrr-hang-fix.patch
  Fix mtrr-related hang

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

xattr-cleanup.patch
  xattr: cleanups

xattr-sharing.patch
  xattr: blockdev inode selection fix

xattr-just-replace.patch
  xattr: update-in-place optimisation

xattr-fine-grained-locking-prep.patch
  xattrr: preparation for fine-grained locking

xattr-fine-grained-locking.patch
  xattr: fine-grained locking

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler
  AS: pgbench improvement
  AS: discrete read fifo batches
  AS sync/async batches
  AS: hash removal fix
  AS jumbo patch (for SCSI and TCQ)
  AS: fix stupid thinko
  AS: no batch-antic-limit
  AS: autotune write batches
  AS: divide by zero fix
  AS: more HZ != 1000 fixes
  AS: update_write_batch tuning
  AS locking
  AS HZ fixes
  AS: fix a leak + more debugging
  AS: maybe repair performance drop of random read O_DIRECT
  AS: fix IBM's seek load

unplug-use-kblockd.patch
  Use kblockd for running request queues

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

blk-batching-cleanups.patch
  block batching cleanups

print-build-options-on-oops.patch
  print a few config options on oops

mmap-prefault.patch
  prefault of executable mmaps

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

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

aio-mm-refcounting-fix.patch
  fix /proc mm_struct refcounting bug

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

aio-dio-no-readahead.patch
  aio O_DIRECT no readahead

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

aio-take-task_lock.patch
  From: Suparna Bhattacharya <suparna@in.ibm.com>
  Subject: Re: 2.5.72-mm1 - Under heavy testing with AIO,.. vmstat seems to blow the kernel

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

truncate-pagefault-race-fix-fix.patch
  Make sure truncate fix has no race

sleepometer.patch
  sleep instrumentation

time-goes-backwards.patch
  demonstrate do_gettimeofday() going backwards

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

20-odirect_enable.patch

21-odirect_cruft.patch

22-read_proc.patch

23-write_proc.patch

24-commit_proc.patch

25-odirect.patch

nfs-O_DIRECT-always-enabled.patch
  Force CONFIG_NFS_DIRECTIO

seqcount-locking.patch
  i_size atomic access: infrastructure

i_size-atomic-access.patch
  i_size atomic access

aha152x-oops-fix.patch
  aha152X oops fixes

nbd-cleanups.patch
  NBD: cosmetic cleanups

nbd-enhanced-diagnostics.patch
  nbd: enhanced diagnostics support

nbd-remove-blksize-bits.patch
  nbd: remove unneeded blksize_bits field

nbd-kobject-oops-fix.patch
  nbd: initialise the embedded kobject

nbd-paranioa-cleanups.patch
  nbd: cleanup PARANOIA usage & code

nbd-locking-fixes.patch
  nbd: fix locking issues with ioctl UI

nbd-ioctl-compat.patch
  nbd: add compatibility with previous ioctl user interface

nbd-docco-update.patch
  NBD documentation update

cpumask_t-1.patch

acpismp-fix.patch
  ACPI_HT_ONLY acpismp=force

oomkill-if-free-swap.patch
  Don't skip oomkilling if there's free swap

exec_mmap-is-the-point-of-no-return.patch
  after exec_mmap(), exec cannot fail

apci-nmi-watchdog-fix.patch
  ACPI poweroff trigers the NMI watchdog

fnup-stats.patch

bootmem-fixes.patch
  bootmem.c cleanups

jiffies-include-fixes.patch
  jiffies include fixes

epoll-optimisations.patch
  epoll: microoptimisations

o1-interactivity.patch
  CPU scheduler interactivity patch

fix-user-leak.patch
  fix current->user->__count leak for processes

mtd-build-fix.patch
  MTD build fix for old gcc's



