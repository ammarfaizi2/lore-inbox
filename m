Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270574AbTGTA15 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270576AbTGTA15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 20:27:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:38545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270574AbTGTA1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 20:27:46 -0400
Date: Sat, 19 Jul 2003 17:43:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test1-mm2
Message-Id: <20030719174350.7dd8ad59.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test1/2.6.0-test1-mm2/


Lots of little fixes and some more CPU scheduler experimentation from Con.




Changes since 2.6.0-test1-mm1:


 linus.patch

 Latest Linus tree

-CONFIG_LBD-other-archs.patch
-misc30.patch
-parport-warning-fix.patch
-ext3-xattr-fixes.patch
-ext3-xattr-credits-fixes.patch
-block_ioctl-fix.patch
-coredump-pass-regs.patch
-is_devfsd_or_child-lockup-fix.patch
-remove-task_cache.patch
-kmalloc-stacks.patch
-devfs-removable-media-fix.patch
-CDROM_SEND_PACKET-timeout-fix.patch
-getaffinity-return-val-fix.patch
-RLIMIT_NPROC-fixes.patch
-wpadded.patch
-uninline-put_namespace.patch
-qlogic-shift-fix.patch
-cryptoloop-config-fix.patch
-slab-wrong-cache-debug.patch
-settimeofday-fix.patch
-ppc-build-fix.patch
-unbreak-visws.patch
-vesafb-fix.patch
-acpi-20030714.patch
-watchdog-i810.patch
-aacraid-hang-fix.patch
-aha152x-oops-fix.patch
-magic-number-update.patch
-as-do_div-fix.patch

 Merged

+cpumask_t-gcc-workaround-46.patch
+cpumask-acpi-fix.patch

 NR_CPUS>BITS_PER_LONG fixes

+misc31.patch

 misc fixes

+3c59x-pm-fix.patch
+3c59x-eisa-fix.patch

 3c59x.c stuff

+dev_t-printing.patch

 Don't assume dev_t is an int

+slab-reclaim-accounting-fix.patch

 Account for freed slab pages in page recleim (we were unaccounting)

+timer-spin-fix.patch

 sound/core/timer.c locking fix

+ak4xxx-fix.patch

 sound/pci/ice1712/ak4xxx.c fix

+less-kswapd-throttling.patch

 Dont' throttle kswapd so much

+stack-leak-fix.patch

 nano security fix

+airo-fixes.patch

 airo_cs locking rework

+unlock_buffer-barrier.patch

 SMP race fix in unlock_buffer()

+feral-bounce-fix-2.patch

 Fix linux_isp highmem initialisation

-airo-schedule-fix.patch

 Dropped

+64-bit-dev_t-other-archs.patch

 Enable 64-bit dev_t on other architectures

+o6int.patch
+o6.1int.patch
+o7int.patch

 CPU scheduler interactivity tweaks

+ext3_getblk-race-fix.patch

 ext3 race fix

+ext3_write_super-speedup.patch

 ext3 speedup

+speedstep-ich-timing-fix.patch

 speedtep fix

+floppy-req-botched.patch

 floppy driver fix






All 108 patches:


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
  cpumask_t fix for s390
  fix cpumask_t for s390
  Fix cpumask changes for x86_64
  fix cpumask_t for sparc64

cpumask_t-gcc-workaround-46.patch
  cpumask_t: more gcc workarounds

cpumask-acpi-fix.patch
  cpumask_t: build fix

kgdb-cpumask_t.patch

misc31.patch
  misc fixes

selinux.patch

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

centrino-update.patch
  update to speedstep-centrino.c

ppa-fix.patch
  ppc fix

3c59x-pm-fix.patch
  3c59x suspend/resume fix

dev_t-printing.patch
  dev_t printing

3c59x-eisa-fix.patch
  non-MII 3c59x fix

slab-reclaim-accounting-fix.patch
  kwsapd can free too much memory

timer-spin-fix.patch
  ALSA locking fix

ak4xxx-fix.patch
  fix snd-ice1724 module OOPS

less-kswapd-throttling.patch

stack-leak-fix.patch
  info leak -- padded struct copied to user

airo-fixes.patch
  fixes for airo.c

unlock_buffer-barrier.patch
  unlock_buffer() needs a barrier

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

feral-bounce-fix.patch
  Feral driver - highmem issues

feral-bounce-fix-2.patch
  Feral driver bouncing fix

list_del-debug.patch
  list_del debug check

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

64-bit-dev_t-other-archs.patch
  enable 64-bit dev_t for other archs

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

kjournald-PF_SYNCWRITE.patch

o1-interactivity.patch
  CPU scheduler interactivity patch

o2int.patch
  O2int 0307041440 for 2.5.74-mm1

o3int.patch
  O3int interactivity for 2.5.74-mm2

o4int.patch
  O4int interactivity

o5int-2.patch
  O5int for interactivity

o6int.patch
  O6int for interactivity

o6.1int.patch
  O6.1int

o7int.patch
  O7int for interactivity

sched-balance-tuning.patch
  CPU scheduler balancing fix

highpmd.patch
  highpmd

synaptics-reset-fix.patch
  synaptics driver reset fix

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

ext3-elide-inode-block-reading.patch
  ext3: avoid reading empty inode blocks

ide-tcq-fix.patch
  IDE TCQ oops fix

ext3_getblk-race-fix.patch
  Fix race in ext3_getblk

ext3_write_super-speedup.patch
  ext3: don't start a commit in write_super()

speedstep-ich-timing-fix.patch
  speedstep-ich fixes

floppy-req-botched.patch
  "blk: request botched" error on floppy write



