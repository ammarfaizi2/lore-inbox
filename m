Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTHYAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTHYAK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 20:10:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:33735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261365AbTHYAKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 20:10:40 -0400
Date: Sun, 24 Aug 2003 17:13:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test4-mm1
Message-Id: <20030824171318.4acf1182.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm1/


. Lots of random fixes.

. m68k, x86_64 and networking syncups.


Linus is away for the rest of this month so if you have stuff it is probably
best to wait until he returns or to send it to myself.




Changes since 2.6.0-test3-mm3:


 linus.patch

 Current Linus bk tree

-si_band-type-fix.patch
-ext3-block-allocation-cleanup.patch
-nfs-revert-backoff.patch
-signal-race-fix.patch
-vmscan-defer-writepage.patch
-local-apic-enable-fixes.patch
-awe-core.patch
-awe-use-gfp_flags.patch
-awe-fix-truncate-errors.patch
-ikconfig-enable.patch
-bd-claim-whole-disk.patch
-O_EXCL-claim-blockdevs.patch
-opl3sa2-lock-init-fix.patch
-dscc4-1.patch
-dscc4-2.patch
-dscc4-3.patch
-dscc4-4.patch
-dscc4-5.patch
-dscc4-6.patch
-dscc4-7.patch
-dscc4-8.patch
-aio-mm-leak-fix.patch
-selinux-avc_log_lock-fix.patch
-selinux-check-behaviour-fix.patch
-ymfpci-oops-fix.patch
-ymf_devs-lock.patch
-slab-drain_array-fix.patch
-loop-oops-fix.patch
-atp870u_detect-lockup-fix.patch
-copy_user-handle-kernel-fault.patch
-Locking-update.patch
-sysctl_h-needs-compiler_h.patch
-aio-mm-refcounting-fix.patch

 Merged

-x86_64-fixes.patch
+kgdb-x86_64-fixes.patch

 Renamed

+handle-unreadable-dot-config.patch

 build system fixes

+huge-net-update.patch

 Current davem tree

+x86_64-update-3.patch

 Current ak tree

+dac960-GAM-IOCTLs-cleanup.patch

 DAC960 rework

+thread-pgrp-fix-2.patch

 Temp fix for the setpgrp-vs-threading problem

+kj-maintainers.patch

 Add the kernel janitor project to ./MAINTAINERS

+ramdisk-cleanup.patch

 Random whitespace fiddling

+v4l-use-after-free-fix.patch

 v4l bugfix

+ikconfig-makefile-update.patch

 /proc/ikconfig build tweaks

+ftape-warning-fix.patch

 Fix a warning

+jffs-retval-fix.patch

 Fix return value types

+make-ACPI_SLEEP-select-SOFTWARE_SUSPEND.patch

 Config dependency

+3GB-personality.patch

 Create a 3GB exec personality to support buggy apps on x86_64 and, later
 ia32 with the 4G/4G split.

+zeromap_pmd_range-fix.patch

 pagetable initialisation fix

+no-async-write-errors-on-close.patch

 Don't try to report EIO and ENOSPC errors through close()

+sis190-fix.patch

 build/bug fix

+remove-add_wait_queue_cond.patch

 dead code

+spin_lock_irqrestore-fixes.patch

 typos

+pcmciamtd-fix.patch

 build fix

+zoran-memleak-fixes.patch
+zoran-rename-debug.patch
+zoran-release-callback.patch
+zoran-pci_disable_device.patch
+zoran-cleanups.patch
+zoran-cleanups-2.patch
+zoran-naming-fix.patch

 Zoran driver update

+airo-build-fix.patch

 Make airo build with CONFIG_PCI=n

+m68k-vmlinux_lds-move.patch
+mac-ide-fix.patch
+m68k-asm-sections-fix.patch
+m68k-asm-local.patch
+amiga-z2ram-fix.patch
+amiga-floppy-fix.patch
+atari-floppy-fix.patch
+m68k-switch_to-fix.patch

 m68k updates

+pcxx-warning-fix.patch

 Warning fix

+pcnet32-unregister_pci-fix.patch

 rmmod crash fix

+hwifs-oops-unregister-fix.patch

 ide unregistration oops fix

+proc-pid-maps-32-bit-fix.patch

 Make /proc/pid/maps output more palatable to apps which expect 32-bit
 addresses.

-kjournald-PF_SYNCWRITE.patch

 Dropped - it slows down rxt3.

+sched-balance-fix-2.6.0-test3-mm3-A0.patch

 CPU scheduler runqueue balancing fix

+o18int.patch
+o18.1int.patch

 Interactivity tweaks from Con

-blacklist-asus-L3800C-dmi.patch

 Dropped - the ACPI guys fixed it.






All 182 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-warning-fix.patch
  kgdbL warning fix

kgdb-build-fix.patch

kgdb-spinlock-fix.patch

kgdb-fix-debug-info.patch
  kgdb: CONFIG_DEBUG_INFO fix

kgdb-cpumask_t.patch

kgdb-x86_64-fixes.patch
  x86_64 fixes

handle-unreadable-dot-config.patch
  correctly handle unreadable .configs

huge-net-update.patch
  net update

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-local.patch
  ppc64: local.h implementation

ppc64-sched_clock.patch
  ppc64: sched_clock()

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-update-3.patch
  x86-64 update for test4

random-locking-fixes.patch
  random: SMP locking

random-accounting-and-sleeping-fixes.patch
  random: accounting and sleeping fixes

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

input-use-after-free-checks.patch
  input layer debug checks

deadline-requeue-workaround.patch
  deadline requeue workaround

fbdev.patch

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

disable-athlon-prefetch.patch

sis900-atomicity-fix.patch
  sis900 atomicity fix

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

yenta-20030817-1-zv.patch

yenta-20030817-2-override.patch

yenta-20030817-3-sockinit.patch

yenta-20030817-4-pm.patch

yenta-20030817-5-pm2.patch

yenta-20030817-6-init.patch

yenta-20030817-7-quirks.patch

proc-pid-setuid-ownership-fix.patch
  fix /proc/pid/fd ownership across setuid()

pid-revalidate-security-hook.patch
  Call security hook from pid*_revalidate

dac960-GAM-IOCTLs-cleanup.patch
  move DAC960 GAM IOCTLs into a new device

thread-pgrp-fix-2.patch
  Fix setpgid and threads

kj-maintainers.patch
  Add the kernel janitors to MAINTAINERS

ramdisk-cleanup.patch

v4l-use-after-free-fix.patch
  Fix bug in v4l core for 2.6.0-test3-bk

ikconfig-makefile-update.patch
  ikconfig - Makefile update

ftape-warning-fix.patch
  Fix ftape warning

jffs-retval-fix.patch
  jffs aops return type fix

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

rcu-grace-period.patch
  Monitor RCU grace period

intel8x0-cleanup.patch
  intel8x0 cleanups

make-ACPI_SLEEP-select-SOFTWARE_SUSPEND.patch
  Make ACPI_SLEEP select SOFTWARE_SUSPEND

3GB-personality.patch
  Add 3GB personality

zeromap_pmd_range-fix.patch
  zeromap_pmd_range bugfix

no-async-write-errors-on-close.patch
  don't report async write errors on close() after all

sis190-fix.patch
  sis190 synchronize_irq fix

remove-add_wait_queue_cond.patch
  remove add_wait_queue_cond()

spin_lock_irqrestore-fixes.patch
  spin_lock_irqrestore() typo fixes

pcmciamtd-fix.patch
  pcmciamtd.c: remove release timer

zoran-memleak-fixes.patch
  zoran: memleak fixes

zoran-rename-debug.patch
  zoran: debug->zr_debug

zoran-release-callback.patch
  zoran: add release callback

zoran-pci_disable_device.patch
  zoranL: add pci_disable_device() call

zoran-cleanups.patch
  zoran: cleanups

zoran-cleanups-2.patch
  zoran: more cleanups

zoran-naming-fix.patch
  zoran: correct name field breakage

airo-build-fix.patch
  airo CONFIG_PCI=n build fix

m68k-vmlinux_lds-move.patch
  move m68k vmlinux.lds files

mac-ide-fix.patch
  Fix Mac IDE

m68k-asm-sections-fix.patch
  m68k asm/sections.h

m68k-asm-local.patch
  m68k asm/local.h

amiga-z2ram-fix.patch
  Amiga z2ram

amiga-floppy-fix.patch
  Amiga floppy

atari-floppy-fix.patch
  Atari floppy

m68k-switch_to-fix.patch
  M68k switch_to fix

pcxx-warning-fix.patch
  drivers/char/pcxx.c warning fix

pcnet32-unregister_pci-fix.patch
  pcnet32 needs unregister_pci

hwifs-oops-unregister-fix.patch
  Fix ide unregister vs. driver model

p00001_synaptics-restore-on-close.patch

p00002_psmouse-reset-timeout.patch

p00003_synaptics-multi-button.patch

p00004_synaptics-optional.patch

p00005_synaptics-pass-through.patch

p00006_psmouse-suspend-resume.patch

p00007_synaptics-old-proto.patch

synaptics-mode-set.patch
  Synaptics mode setting

syn-multi-btn-fix.patch
  synaptics multibutton fix

keyboard-resend-fix.patch
  keyboard resend fix

proc-pid-maps-32-bit-fix.patch
  Do 32bit addresses in /proc/self/maps if possible

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

mknod64-64-bit-fix.patch
  dev_t: fix mknod for 64-bit archs

ustat64.patch
  ustat64

ppc-64-bit-stat.patch
  fix ppc stat.h for 64-bit dev_t

64-bit-dev_t-init_rd-fixes.patch
  initrd fixes for 64-bit dev_t

arch-dev_t-stat-fixes.patch
  Fix all asm-*/stat.h dev_t instances

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

sparc64-lockmeter-fix.patch

sparc64-lockmeter-fix-2.patch
  Fix lockmeter on sparc64

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

sched-balance-fix-2.6.0-test3-mm3-A0.patch
  sched-balance-fix-2.6.0-test3-mm3-A0

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

ppc-sched_clock.patch

sparc64_sched_clock.patch

x86_64-sched_clock.patch
  Add sched_clock for x86-64

sched-warning-fix.patch

sched-balance-tuning.patch
  CPU scheduler balancing fix

sched-no-tsc-on-numa.patch
  Subject: Re: Fw: Re: 2.6.0-test2-mm3

o12.2int.patch
  O12.2int for interactivity

o12.3.patch
  O12.3 for interactivity

o13int.patch
  O13int for interactivity

o13.1int.patch
  O13.1int

o14int.patch
  O14int

o14int-div-fix.patch
  o14int 64-bit-divide fix

o14.1int.patch
  O14.1int

o15int.patch
  O15int for interactivity

o16int.patch
  From: Con Kolivas <kernel@kolivas.org>
  Subject: [PATCH] O16int for interactivity

o16.1int.patch
  O16.1int for interactivity

o16.2int.patch
  O16.2int

o16.3int.patch
  O16.3int

o18int.patch
  O18int

o18.1int.patch
  O18.1int

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch

4g4g-vmlinux-update-got-lost.patch

4g4g-do_page_fault-cleanup.patch
  4G/4G: remove debug code

4g4g-cleanups.patch

kgdb-4g4g-fix-2.patch

4g4g-config-fix.patch

4g4g-pmd-fix.patch
  4g4g: pmd fix

4g4g-wli-fixes.patch
  4g/4g: fixes from Bill

4g4g-fpu-fix.patch
  4g4g: fpu emulation fix

4g4g-show_registers-fix.patch
  4g4g: show_registers() fix

4g4g-pin_page-atomicity-fix.patch
  4g/4g usercopy atomicity fix

4g4g-remove-touch_all_pages.patch

4g4g-debug-flags-fix.patch
  4g4g: debug flags fix

4g4g-TI_task-fix.patch
  4g4g: Fix wrong asm-offsets entry

cyclone-fixmap-fix.patch
  cyclone time fixmap fix

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

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

O_SYNC-speedup-nolock-fix.patch

aio-remove-lseek-triggerable-BUG_ONs.patch

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



