Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbTGEUKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbTGEUKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:10:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266466AbTGEUJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:09:56 -0400
Date: Sat, 5 Jul 2003 13:25:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.74-mm2
Message-Id: <20030705132528.542ac65e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm2/

. Various fixes for the cpumask_t (NR_CPUS > BITS_PER_LONG) patch.

. Framebuffer update

. Another CPU scheduler tweak from Con.

. Various bug fixes




Changes since 2.5.74-mm1:


 linus.patch

 Latest Linus bitkeeper tree

-misc8.patch
-ipcsem-speedup.patch
-resurrect-batch_requests.patch
-kblockd.patch
-cfq-infrastructure.patch
-elevator-completion-api.patch
-as-iosched.patch
-unplug-use-kblockd.patch
-per-queue-nr_requests.patch
-blk-invert-watermarks.patch
-blk-as-hint.patch
-get_request_wait-oom-fix.patch
-blk-fair-batches.patch
-generic-io-contexts.patch
-blk-request-batching.patch
-get_io_context-fix.patch
-blk-allocation-commentary.patch
-blk-batching-throttle-fix.patch
-blk-batching-cleanups.patch
-exec_mmap-is-the-point-of-no-return.patch
-bootmem-fixes.patch
-jiffies-include-fixes.patch
-epoll-optimisations.patch
-fix-user-leak.patch
-mtd-build-fix.patch

 Merged

+kgdb-remove-cpu_callout_map.patch

 kgdb cleanup (prevents it from being broken by the cpumask_t patch)

+netstat-oops-fix.patch

 Fix `netstat -a' oops

+task_cpu-cleanup.patch

 Don't open-code task_cpu()

-fb-image-depth-fix.patch

 fbdev-2 covers this

+fbdev-2.patch

 fbdev update from James

+misc9.patch

 misc fixes

+breadahead-tweaks.patch

 Minor tweaks

+gcc-bug-workaround.patch
+sparse-apic-fix.patch
+nuke-cpumask_arith.patch
+p4-clockmod-cpumask-fix.patch

 Touchups against the cpumask_t patch.

+jbd-commit-tricks.patch
+jbd-dont-account-blocks-twice.patch

 ext3/jbd speedups

+kjournald-PF_SYNCWRITE.patch

 Tell the anticipatory scheduler that kjournald does synchronous writes.

+o2int.patch

 CPU scheduler update from Con

+highpmd.patch

 Configurably put pmd's in highmem.

+ipconfig-display-boot-server.patch

 Display the boot server's IP address in /proc/net/pnp

+quota-autoloading.patch

 Module autoloading for quota code

+bsd-accounting-speedup.patch

 Reduced lock contention in BSD accounting code

+add_timer-fix.patch

 Handle >48-day-long timers on 64-bit machines.





All 109 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-remove-cpu_callout_map.patch
  kgdb: remove cpu_callout_map decls

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-pci-update.patch

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

netstat-oops-fix.patch
  netstat oops fix

task_cpu-cleanup.patch
  use task_cpu() not ->thread_info->cpu in sched.c

x86_64-fixes.patch
  x86_64 fixes

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

fbdev-2.patch

buffer-debug.patch
  buffer.c debugging

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

misc9.patch
  misc fixes

breadahead-tweaks.patch
  breadahead() tweaks

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

gcc-bug-workaround.patch
  bitmap.h gcc bug workaround

sparse-apic-fix.patch
  Fix for sparse APIC IDs

nuke-cpumask_arith.patch
  remove cpumask_arith.h

p4-clockmod-cpumask-fix.patch
  p4-clockmod: cpumask_t fix

acpismp-fix.patch
  ACPI_HT_ONLY acpismp=force

oomkill-if-free-swap.patch
  Don't skip oomkilling if there's free swap

apci-nmi-watchdog-fix.patch
  ACPI poweroff trigers the NMI watchdog

jbd-commit-tricks.patch
  JBD: checkpointing optimisations

jbd-dont-account-blocks-twice.patch
  JBD: transaction buffer accounting fix

kjournald-PF_SYNCWRITE.patch

fnup-stats.patch

o1-interactivity.patch
  CPU scheduler interactivity patch

o2int.patch
  O2int 0307041440 for 2.5.74-mm1

highpmd.patch
  highpmd

ipconfig-display-boot-server.patch
  display bootserver in /proc/net/pnp

quota-autoloading.patch
  Module autoloading for quota

bsd-accounting-speedup.patch
  BAS accounting speedup

add_timer-fix.patch
  add_timer() fix



