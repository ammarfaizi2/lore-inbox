Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbTG1GWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270980AbTG1GWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:22:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:13957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270971AbTG1GV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:21:57 -0400
Date: Sun, 27 Jul 2003 23:37:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test2-mm1
Message-Id: <20030727233716.56fb68d2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm1/

- More CPU scheduler tweaks.

- Some changes to the VM which are designed to further reduce the amount of
  writeout which happens off the tail of the page LRU.

  Some small benefits have been observed in the usual benchmarks.  Needs
  careful testing.

- Various other fixes from various people.





Changes since 2.6.0-test1-mm2:


-airo-fixes.patch
-ide-tcq-fix.patch
-speedstep-ich-timing-fix.patch

 Merged

+cpumask_t-gcc-workaround-47.patch

 More NR_CPUS > BITS_PER_LONG fixes

-fbdev-2.patch

 Lots of rejects against Linus changes.  Dropped for now.

+rootdisk-parsing-fix.patch

 Fix "root=/dev/hda1" kernel boot option

+o8int.patch
+o9int.patch
+o10int.patch

 CPU scheduler work.

-highpmd.patch

 Dropped - too big.

-floppy-req-botched.patch

 Dropped: wrong.

+alloc_bootmem_low_pages-ordering-fix.patch

 bootmem fix for ia64

+floppy-smp-fixes.patch

 Floppy driver SMP fixes

+1000HZ-time-accuracy-fix.patch

 More accurate timekeeping

+sis-drm-fix.patch

 SiS DRM driver fix

+signal-race-fix.patch

 Signal handling race fix

+soundcard-devfs-fix.patch

 Fix sound drivers with devfs

+6pack-hz-fix.patch

 Fix the 6pack driver for HZ != 100

+devfs_lookup-revert-and-refix.patch

 devfs fix fix

+write-mark_page_accessed.patch

 Activate pages on the second pagecache write()

+zone-pressure.patch
+reclaim-mapped-pressure.patch

 More accurate page unmapping in page reclaim

+vmscan-defer-writepage.patch

 Give dirty pages another go around the inactive list before writing them
 out.

+blacklist-asus-L3800C-dmi.patch

 ASUS DMi fix

+force-CONFIG_INPUT.patch

 Hopefully make migration from 2.4 easier.

+ipt_helper-build-fix.patch

 netfilter build fix

+sb16-ioports-fix.patch

 Soundblaster leaks resources

+nforce2-acpi-fixes.patch

 ACPI fixes for nForce.

+select-xoffed-tty-fix.patch

 Correctly handle select() against xoffed tty's

+conntrack-build-fix.patch

 Another netfilter build fix

+arcnet-typo-fix.patch

 arcnet fix

+ext3-commit-assertion-fix.patch

 ext3 data=journal BUGfix





All 127 patches:


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

cpumask_t-gcc-workaround-47.patch
  cpumask_t gcc bug workarounds

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

rootdisk-parsing-fix.patch
  fix "unable to mount root fs"

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

o8int.patch
  O8int for interactivity

o9int.patch
  O9int for interactivity

o10int.patch
  O10int for interactivity

sched-balance-tuning.patch
  CPU scheduler balancing fix

synaptics-reset-fix.patch
  synaptics driver reset fix

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

ext3-elide-inode-block-reading.patch
  ext3: avoid reading empty inode blocks

ext3_getblk-race-fix.patch
  Fix race in ext3_getblk

ext3_write_super-speedup.patch
  ext3: don't start a commit in write_super()

alloc_bootmem_low_pages-ordering-fix.patch
  fix alloc_bootmem_low_pages

floppy-smp-fixes.patch
  floppy smp fixes

1000HZ-time-accuracy-fix.patch
  missing #if for 1000 HZ

sis-drm-fix.patch
  SiS RM fix

signal-race-fix.patch
  signal handling race condition causing reboot hangs

soundcard-devfs-fix.patch
  soundcard.c devfs fix

6pack-hz-fix.patch
  6PACK asumes HZ=100

devfs_lookup-revert-and-refix.patch
  devfs_lookup stack corruption fix rework

write-mark_page_accessed.patch
  use mark_page_accessed() in the write() path

zone-pressure.patch
  vmscan: decaying average of zone pressure

reclaim-mapped-pressure.patch
  vmscan: use zone_pressure for page unmapping decisions

vmscan-defer-writepage.patch
  vmscan: give dirty referenced pages another pass around the LRU

blacklist-asus-L3800C-dmi.patch
  add ASUS l3800P to DMI black list

force-CONFIG_INPUT.patch
  Force CONFIG_INPUT if CONFIG_VT set

ipt_helper-build-fix.patch
  Fix ipt_helper compilation

sb16-ioports-fix.patch
  Fix /proc/ioports with sb16

nforce2-acpi-fixes.patch
  ACPI patch which fixes all my IRQ problems on nforce2

select-xoffed-tty-fix.patch
  fix select() with an xoffed tty

conntrack-build-fix.patch
  fix ip_conntrack_core.h compile error

arcnet-typo-fix.patch
  typo in drivers/net/arcnet/com20020-isa.c

ext3-commit-assertion-fix.patch
  ext3: fix commit assertion failure



