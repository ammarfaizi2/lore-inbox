Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269843AbTGKJPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269844AbTGKJPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:15:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26560 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269843AbTGKJPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:15:11 -0400
Date: Fri, 11 Jul 2003 02:29:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.75-mm1
Message-Id: <20030711022952.21c98720.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.75/2.5.75-mm1/

. Mainly a resync.

. More CPU scheduler changes for people to test.

. The -mm kernel is under 100 patches.  First time in a long time.




Changes since 2.5.73-mm3:


 linus.patch

 Latest Linus diff

-div64-fix.patch
-compat_sys_sched_getaffinity-return-fix.patch
-reiserfs-dirty-memory-fix.patch
-reiserfs-64-bit-fix.patch
-seqcount-locking.patch
-i_size-atomic-access.patch
-kmap-removal-1.patch
-kallsyms-defaults-to-on.patch
-misc29.patch
-knfsd-umask-fix.patch
-aio-fork-fix.patch
-aio_complete-barrier-fix.patch
-vfsmount_lock.patch
-sched-hot-balancing-fix.patch
-nbd-cleanups.patch
-nbd-enhanced-diagnostics.patch
-nbd-remove-blksize-bits.patch
-nbd-kobject-oops-fix.patch
-nbd-paranioa-cleanups.patch
-nbd-docco-update.patch
-nbd-remove-open-release.patch
-nbd-use-set_blocksize.patch
-oomkill-if-free-swap.patch
-jbd-commit-tricks.patch
-jbd-dont-account-blocks-twice.patch
-ext3_sync_fs-fix.patch
-oom-kiler-fixes.patch
-yenta_socket-init-fix.patch
-devfs-oops-fix.patch
-devfs-deadlock-fix.patch
-epoll-multiple-fds.patch

 Merged

+cpumask-apm-fix-2.patch
+cpumask_t-gcc-workaround-2.patch

 cpumask_t fixes

-ppc64-pci-update.patch
+ppc64-bar-0-fix.patch

 Updated

+ia64-percpu-revert.patch

 Fix per-cpu stuff for ia64

+misc30.patch

 misc fies

+o4int.patch
+sched-balance-tuning.patch

 CPU scheduler tweaks

+nfs-revert-backoff.patch

 Revert NFS backoff changes

+div64-fix-fix-fix.patch

 do_div() fix

+x86_64-critical-fixes.patch

 x86_64 fixes

+magic-number-update.patch

 Documentation update

+ide-tcq-fix.patch

 Fix IDE TCQ






All 93 patches


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

cpumask_t-1.patch
  cpumask_t: allow more than BITS_PER_LONG CPUs

cpumask_t-s390-fix.patch
  cpumask_t fix for s390

kgdb-cpumask_t.patch

cpumask_t-x86_64-fix.patch
  Fix cpumask changes for x86_64

sparc64-cpumask_t-fix.patch
  fix cpumask_t for sparc64

cpumask-apm-fix-2.patch

cpumask_t-gcc-workaround-2.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

ia64-percpu-revert.patch
  revert percpu changes

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

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

misc30.patch
  misc fixes

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

print-build-options-on-oops.patch
  print a few config options on oops

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

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

truncate-pagefault-race-fix-fix.patch
  Make sure truncate fix has no race

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

aha152x-oops-fix.patch
  aha152X oops fixes

acpismp-fix.patch
  ACPI_HT_ONLY acpismp=force

apci-nmi-watchdog-fix.patch
  ACPI poweroff trigers the NMI watchdog

kjournald-PF_SYNCWRITE.patch

o1-interactivity.patch
  CPU scheduler interactivity patch

o2int.patch
  O2int 0307041440 for 2.5.74-mm1

o3int.patch
  O3int interactivity for 2.5.74-mm2

o4int.patch
  O4int interactivity

sched-balance-tuning.patch
  CPU scheduler balancing fix

highpmd.patch
  highpmd

synaptics-reset-fix.patch
  synaptics driver reset fix

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

div64-fix-fix-fix.patch
  fix do_div()

x86_64-critical-fixes.patch
  Fix x86-64 bugs

magic-number-update.patch
  Update Documentation/magic-numbers.txt

ide-tcq-fix.patch
  IDE TCQ oops fix



