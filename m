Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbTGIFU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 01:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265672AbTGIFU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 01:20:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265662AbTGIFUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 01:20:49 -0400
Date: Tue, 8 Jul 2003 22:35:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.74-mm3
Message-Id: <20030708223548.791247f5.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm3/


. More CPU scheduler tweaks from Con

. All the rest is new bugfixes.  Twenty three in fact.




Changes since 2.5.74-mm2:


 linus.patch

 Latest bitkeeper tree

-netstat-oops-fix.patch
-task_cpu-cleanup.patch
-misc9.patch
-breadahead-tweaks.patch
-xattr-cleanup.patch
-xattr-sharing.patch
-xattr-just-replace.patch
-xattr-fine-grained-locking-prep.patch
-xattr-fine-grained-locking.patch
-ipconfig-display-boot-server.patch
-quota-autoloading.patch
-bsd-accounting-speedup.patch
-add_timer-fix.patch

 Merged

-cpumask_t-1.patch
-gcc-bug-workaround.patch
-sparse-apic-fix.patch
-nuke-cpumask_arith.patch
-p4-clockmod-cpumask-fix.patch

 Folded into cpumask_t-1.patch

+cpumask_t-s390-fix.patch
+kgdb-cpumask_t.patch
+cpumask_t-x86_64-fix.patch
+sparc64-cpumask_t-fix.patch

 cpumask_t fixes

+div64-fix.patch

 Fix the consolidated div64() code

+compat_sys_sched_getaffinity-return-fix.patch

 return value fix.

+reiserfs-dirty-memory-fix.patch

 Fix VFS lockup with reiserfs.

+reiserfs-64-bit-fix.patch

 Make reiserfs work on 64-bit machines

+kmap-removal-1.patch

 kmap->kmap_atomic

+kallsyms-defaults-to-on.patch

 make CONFIG_KALLSYMS harder to turn off

+misc29.patch

 misc fixes

-mmap-prefault.patch

 Dropped - readaround rework made it ineffective

+knfsd-umask-fix.patch

 Fix kNFSd file creation modes

+aio-fork-fix.patch
+aio_complete-barrier-fix.patch

 AIO bugfixes

+aio-O_SYNC-fix.patch
+aio-readahead-rework.patch

 More AIO work.

-sleepometer.patch
-time-goes-backwards.patch

 Dropped - I wasn't using it.

-nbd-locking-fixes.patch
-nbd-ioctl-compat.patch
+nbd-remove-open-release.patch
+nbd-use-set_blocksize.patch

 NBD work.

+ext3_sync_fs-fix.patch

 ext3 correctness fix

-fnup-stats.patch

 debug stuff.  Dropped.

+o3int.patch

 More CPU scheduler interactivity work.

+oom-kiler-fixes.patch

 ry not to kill kernel threads

+synaptics-reset-fix.patch

 Synaptics fix

+yenta_socket-init-fix.patch

 Cardbus initialisation ordering fix

+devfs-oops-fix.patch
+devfs-deadlock-fix.patch

 devfs fixes

+ext3-block-allocation-cleanup.patch

 Untangle the block allocator

+epoll-multiple-fds.patch

 eventpoll fix.






All 113 patches:


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

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

div64-fix.patch
  Fix do_div() for all architectures

compat_sys_sched_getaffinity-return-fix.patch
  fix return of compat_sys_sched_getaffinity

reiserfs-dirty-memory-fix.patch
  reiserfs dirty memory accounting fix

reiserfs-64-bit-fix.patch
  fix reiserfs for 64bit arches

seqcount-locking.patch
  i_size atomic access: infrastructure

i_size-atomic-access.patch
  i_size atomic access

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

kmap-removal-1.patch
  replace some kmap()s with kmap_atomic()

kallsyms-defaults-to-on.patch
  make CONFIG_KALLSYMS default to "on"

misc29.patch
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

knfsd-umask-fix.patch
  Set umask correctly for nfsd kernel threads

aio-fork-fix.patch
  Bug fix in AIO initialization

aio_complete-barrier-fix.patch
  Fix race condition between aio_complete and aio_read_evt

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

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

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

nbd-docco-update.patch
  NBD documentation update

nbd-remove-open-release.patch
  nbd: remove unneeded nbd_open/nbd_release and refcnt

nbd-use-set_blocksize.patch
  nbd: make nbd and block layer agree about device and block sizes

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

ext3_sync_fs-fix.patch
  sync_fs() fix

kjournald-PF_SYNCWRITE.patch

o1-interactivity.patch
  CPU scheduler interactivity patch

o2int.patch
  O2int 0307041440 for 2.5.74-mm1

o3int.patch
  O3int interactivity for 2.5.74-mm2

highpmd.patch
  highpmd

oom-kiler-fixes.patch
  oom killer fixes

synaptics-reset-fix.patch
  synaptics driver reset fix

yenta_socket-init-fix.patch
  yenta-socket initialisation fix

devfs-oops-fix.patch
  devfs oops fix

devfs-deadlock-fix.patch
  devfs deadlock fix

ext3-block-allocation-cleanup.patch

epoll-multiple-fds.patch
  epoll-per-fd fix ...



