Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTGPFlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 01:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270143AbTGPFlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 01:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:41173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270142AbTGPFkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 01:40:53 -0400
Date: Tue, 15 Jul 2003 22:56:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test1-mm1
Message-Id: <20030715225608.0d3bff77.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test1/2.6.0-test1-mm1/

. Lots of bugfixes.

. A big one-liner from Mark Haverkamp fixes some hanges which were being
  seen with the aacraid driver and may fix the problem which people have seen
  on other SCSI drivers: everything getting stuck in io_schedule() under load.

. Another interactivity patch from Con.  Feedback is needed on this
  please - we cannot make much progress on this fairly subjective work
  without lots of people telling us how it is working for them.




Changes since 2.5.75-mm1:

 linus.patch

 Latest Linus tree

-acpismp-fix.patch
-apci-nmi-watchdog-fix.patch
-div64-fix-fix-fix.patch
-x86_64-critical-fixes.patch

 Merged

-cpumask_t-s390-fix.patch
-cpumask_t-x86_64-fix.patch
-sparc64-cpumask_t-fix.patch
-cpumask-apm-fix-2.patch
-cpumask_t-gcc-workaround-2.patch

 Folded into  cpumask_t-1.patch

+selinux.patch

 SELinux

+CONFIG_LBD-other-archs.patch

 Let non-ia32 architectures enabled large block devices (64-bit sector_t)

+parport-warning-fix.patch

 Fix compile warning

+ext3-xattr-fixes.patch
+ext3-xattr-credits-fixes.patch

 Extended attributes fixes

+block_ioctl-fix.patch

 ioctl return val fix

+coredump-pass-regs.patch

 Changes for sparc32 core dumping

+is_devfsd_or_child-lockup-fix.patch

 devfs deadlock fix

+remove-task_cache.patch

 Remove unused task_cache

+kmalloc-stacks.patch

 Allocate ia32 kernel stacks with kmalloc()

+devfs-removable-media-fix.patch

 devfs reinitialisation fix

+CDROM_SEND_PACKET-timeout-fix.patch

 Timeout fix (HZ and USER_HZ differ)

+getaffinity-return-val-fix.patch

 compat layer return val fix

+RLIMIT_NPROC-fixes.patch

 Fix RLIMIT_NPROC behaviour

+wpadded.patch

 Use `-Wpadded'

+centrino-update.patch

 cpufreq update for centrini

+uninline-put_namespace.patch

 debloat

+qlogic-shift-fix.patch

 Fix gqlogic DMA mask handling

+cryptoloop-config-fix.patch

 cryptoloop needs crypto

+slab-wrong-cache-debug.patch

 Additional debug stuff to help chase some problem which Manfred is working

+ppa-fix.patch

 Get the parallel-port adapter driver closer to working

+settimeofday-fix.patch

 Fix settimeofday() for sparc64 and others

+ppc-build-fix.patch

 Make ppc build

+unbreak-visws.patch

 visws fix

+vesafb-fix.patch

 vesafb update

+acpi-20030714.patch

 Latest ACPI drop

+watchdog-i810.patch

 Intel watchdog driver update

+aacraid-hang-fix.patch

 scsi mid-layer fix

+feral-bounce-fix.patch

 Feral qlogic driver bounces too often

+o5int-2.patch

 Another CU scheduler tweak

+ext3-elide-inode-block-reading.patch

 Avoid reading empty inode blocks

+as-do_div-fix.patch

 Avoid arith overflows in the anticipatory scheduler






All 116 patches:


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

kgdb-cpumask_t.patch

selinux.patch

CONFIG_LBD-other-archs.patch
  Allow LBD on architectures that support it

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

parport-warning-fix.patch
  parport_pc.c compile warning

ext3-xattr-fixes.patch
  ext3 extended attribute fixes

ext3-xattr-credits-fixes.patch
  Ext3 xattr credits fix for quotas

block_ioctl-fix.patch
  ioctl(BLKBSZSET) fix and cleanup

coredump-pass-regs.patch
  pass regs into dump_fpu() in elf coredump

is_devfsd_or_child-lockup-fix.patch
  is_devfsd_or_child() deadlock fix

remove-task_cache.patch
  remove task_cache entirely

kmalloc-stacks.patch
  use kmalloc for ia32 stacks

devfs-removable-media-fix.patch
  fix removable partitioned media with devfs

CDROM_SEND_PACKET-timeout-fix.patch
  Fix incorrect timeout in CDROM_SEND_PACKET ioctl

getaffinity-return-val-fix.patch
  fix return of compat_sys_sched_getaffinity

RLIMIT_NPROC-fixes.patch
  Fix two bugs with process limits (RLIMIT_NPROC)

wpadded.patch
  Add -Wpadded

centrino-update.patch
  update to speedstep-centrino.c

uninline-put_namespace.patch
  unline most of put_namespace()

qlogic-shift-fix.patch
  fix corruption in qla1280

cryptoloop-config-fix.patch
  CONFIG_BLK_DEV_CRYPTOLOOP needs CONFIG_CRYPTO

slab-wrong-cache-debug.patch
  slab: print stuff when the wrong cache is used

ppa-fix.patch
  ppc fix

settimeofday-fix.patch
  settimeofday() fixes

ppc-build-fix.patch
  ppc build fix

unbreak-visws.patch
  visws: fix PCI breakage

vesafb-fix.patch
  vesafb fix

acpi-20030714.patch

watchdog-i810.patch
  watchdog: i810-tco support

aacraid-hang-fix.patch
  Fix AS i/o hang with aacraid driver

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

feral-bounce-fix.patch
  Feral driver - highmem issues

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

magic-number-update.patch
  Update Documentation/magic-numbers.txt

ide-tcq-fix.patch
  IDE TCQ oops fix

as-do_div-fix.patch
  fix as-iosched do_div()



