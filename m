Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbTHDI33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 04:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTHDI32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 04:29:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:9653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270065AbTHDI3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 04:29:17 -0400
Date: Mon, 4 Aug 2003 01:30:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test2-mm4
Message-Id: <20030804013036.16d9fa3a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm4/


. A bunch of fixes for the 4G/4G split patch

. 64-bit dev_t fixes

. Fixes for the NR_CPUS > BITS_PER_LONG patch

. Added Con's reworked interactivity changes.





Changes since 2.6.0-test2-mm3:


 linus.patch

 Linus's current tree

-bridge-notification-fix.patch

 Merged

+kgdb-sysrq-g-fix.patch
+kgdb-serial-fix.patch
+kgdb-warning-fix.patch

 Various kgdb fixes

+ax8817x-build-fix.patch

 Fix compilation of this driver for gcc-2.9x

-cpumask_t-gcc-workaround-46.patch
-cpumask_t-gcc-workaround-47.patch
-cpumask-acpi-fix.patch
-x86_64-cpumask_t-fix.patch

 Folded into cpumask_t-1.patch

+cpumask-mips-fix.patch
+cpumask-arith-fix.patch
+cpumask-physid-fix.patch
+cpumask_t-up-build-fix.patch

 Various cpumask_t fixes.  Mainly: just make cpumask_t a bare unsigned long
 for NR_CPUS<=BITS_PER_LONG.  Generates better code on SPARC CPUs.

+ppc64-64-bit-mknod-fix.patch

 Maybe fix PPC64's mknod for the dev_t rework.

+ustat64.patch

 Implement ustat64().  For 64-bit dev_t.

+ppc64-64-bit-ustat-fix.patch

 Fix PPC64 ustat() for the sys_ustat() changes.

+sched-no-tsc-on-numa.patch

 NUMA doesn't synchronise the TSCs

+o12.2int.patch

 CPU scheduler interactivity things.

+4g4g-do_page_fault-cleanup.patch
+4g4g-pmd-fix.patch
+4g4g-fpu-fix.patch
+4g4g-show_registers-fix.patch
+4g4g-pin_page-atomicity-fix.patch

 Various things for the 4G/4G split patch

-awe-core-fixes.patch

 Folded into awe-core.patch

-awe-use-gfp_flags-fixes.patch

 Folded into awe-use-gfp_flags.patch

+awe-use-gfp_flags-braino.patch

 Fix silly bug.

-awe-fix-truncate-errors-fixes.patch

 Folded into awe-fix-truncate-errors.patch

+random-locking-fixes.patch
+random-accounting-and-sleeping-fixes.patch

 Add locking to the random driver

+panic-nmi-watchdog-fix.patch

 Don't trigger the NMI watchdog during panics.

+ide-capacity-fixes.patch

 sector_t conversion for huge IDE disks

+do_div-comment.patch

 Comment the do_div() API.





All 146 patches:


linus.patch
  cset-20030803_2013.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-remove-cpu_callout_map.patch
  kgdb: remove cpu_callout_map decls

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

kgdb-sysrq-g-fix.patch
  kgdb sysrq-g fix

kgdb-serial-fix.patch
  kgdb serial port fix

kgdb-warning-fix.patch
  kgdbL warning fix

execve-fixes.patch
  fix 64-bit architectures for the binprm change

ax8817x-build-fix.patch
  ax8817x.c build fix for older gcc's

cpumask_t-1.patch
  cpumask_t: allow more than BITS_PER_LONG CPUs
  cpumask_t fix for s390
  fix cpumask_t for s390
  Fix cpumask changes for x86_64
  fix cpumask_t for sparc64
  cpumask_t: more gcc workarounds
  cpumask_t gcc bug workarounds
  cpumask_t: build fix

cpumask-mips-fix.patch
  cpumask: IPS fixups

cpumask-arith-fix.patch
  cpumask: avoid using structs for NR_CPUS<BITS_PER_LONG

cpumask-physid-fix.patch
  cpumask: physid fixes

cpumask_t-up-build-fix.patch
  cpumask_t uniproc build fix

kgdb-cpumask_t.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-local.patch
  ppc64: local.h implementation

ppc64-sections.patch
  ppc64: implement sections.h

ppc64-sched_clock.patch
  ppc64: sched_clock()

ppc64-prom-compile-fix.patch
  ppc64: prom.c compile fix

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

rcu-grace-period.patch
  Monitor RCU grace period

mtrr-hang-fix.patch
  Fix mtrr-related hang

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

ppa-fix.patch
  ppc fix

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

ppc64-64-bit-mknod-fix.patch
  PPC64 mknod fix

ustat64.patch
  ustat64

ppc64-64-bit-ustat-fix.patch
  PPC64 ustat fix

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

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

sched-warning-fix.patch

sched-balance-tuning.patch
  CPU scheduler balancing fix

sched-no-tsc-on-numa.patch
  Subject: Re: Fw: Re: 2.6.0-test2-mm3

o12.2int.patch
  O12.2int for interactivity

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

floppy-smp-fixes.patch
  floppy smp fixes

1000HZ-time-accuracy-fix.patch
  missing #if for 1000 HZ

signal-race-fix.patch
  signal handling race condition causing reboot hangs

vmscan-defer-writepage.patch
  vmscan: give dirty referenced pages another pass around the LRU

blacklist-asus-L3800C-dmi.patch
  add ASUS l3800P to DMI black list

nforce2-acpi-fixes.patch
  ACPI patch which fixes all my IRQ problems on nforce2

nforce2-acpi-fixes-fix.patch

remove-const-initdata.patch
  __initdata cant be marked const

timer-race-fixes.patch
  timer race fixes

local-apic-enable-fixes.patch
  Local APIC enable fixes

p00001_synaptics-restore-on-close.patch

p00002_psmouse-reset-timeout.patch

p00003_synaptics-multi-button.patch

p00004_synaptics-optional.patch

p00005_synaptics-pass-through.patch

p00006_psmouse-suspend-resume.patch

p00007_synaptics-old-proto.patch

synaptics-mode-set.patch
  Synaptics mode setting

keyboard-resend-fix.patch
  keyboard resend fix

kobject-paranoia-checks.patch
  Driver core and kobject paranoia checks

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch

4g4g-do_page_fault-cleanup.patch
  4G/4G: remove debug code

4g4g-cleanups.patch

kgdb-4g4g-fix-2.patch

4g4g-config-fix.patch

4g4g-pmd-fix.patch
  4g4g: pmd fix

4g4g-fpu-fix.patch
  4g4g: fpu emulation fix

4g4g-show_registers-fix.patch
  4g4g: show_registers() fix

4g4g-pin_page-atomicity-fix.patch
  4g/4g usercopy atomicity fix

dm-1-module-param.patch
  dm: don't use MODULE_PARM

dm-2-blk.patch
  dm: remove blk.h include

dm-3-use-hex.patch
  dm: decimal device num sscanf

dm-4-64-bit-ioctls.patch
  dm: 64 bit ioctl fixes

dm-5-missing-include.patch
  dm: missing #include

dm-6-sector_div.patch
  dm: use sector_div()

dm-7-rename-resume.patch
  dm: resume() name clash

reiserfs-savelinks-endianness-fix.patch
  reiserfs: fix savelinks on bigendian arches

reiserfs-enospc-fix.patch
  reiserfs: fix problem when fs is out of space

reiserfs-link-unlink-race-fix.patch
  reiserfs: fix races between link and unlink on same file

mremap-atomicity-fix.patch
  move_one_page() atomicity fix

spurious-SIGCHLD-fix.patch
  spurious SIGCHLD from dying thread group leader

aic7xxx_old-oops-fix.patch

ide-cd-oops-fix.patch
  ide-cd error handling oops fix

xfs-use-after-free-fix.patch
  XFS use-after-free fix

awe-core.patch
  async write errors: report truncate and io errors on async writes
  async write errors core: fixes

awe-use-gfp_flags.patch
  async write errors: use flags in address space
  async write errors: mapping->flags fixes

awe-use-gfp_flags-braino.patch

awe-fix-truncate-errors.patch
  async write errors: fix spurious fs truncate errors
  async write errors: truncate handling fixes

as-remove-hash-valid-stuff.patch
  AS: remove hash valid stuff

usercopy-might_sleep-checks.patch
  might_sleep() checks for usercopy functions

random-locking-fixes.patch
  random: SMP locking

random-accounting-and-sleeping-fixes.patch
  random: accounting and sleeping fixes

panic-nmi-watchdog-fix.patch
  Don't trigger NMI watchdog for panic delay

ide-capacity-fixes.patch
  ide capacity accounting and reporting fixes

do_div-comment.patch
  add i386 do_div API comment

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



