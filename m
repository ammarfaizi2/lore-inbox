Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTIIGtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTIIGtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:49:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:1455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263147AbTIIGsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:48:51 -0400
Date: Mon, 8 Sep 2003 23:50:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test5-mm1
Message-Id: <20030908235028.7dbd321b.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm1/


Small fixes, mainly.




Changes since 2.6.0-test4-mm6:


-sysfs-memleak-fix.patch
-large-dev_t-2nd-01.patch
-large-dev_t-2nd-02.patch
-large-dev_t-2nd-03.patch
-large-dev_t-2nd-04.patch
-large-dev_t-2nd-05.patch
-large-dev_t-2nd-06.patch
-large-dev_t-2nd-07.patch
-large-dev_t-2nd-08.patch
-large-dev_t-2nd-09.patch
-large-dev_t-2nd-10.patch
-large-dev_t-2nd-11.patch
-large-dev_t-2nd-12.patch
-large-dev_t-2nd-13.patch
-large-dev_t-2nd-14.patch
-large-dev_t-2nd-15.patch
-kobject-unlimited-name-lengths.patch
-kobject-unlimited-name-lengths-use-after-free-fix.patch
-remove-version_h.patch
-remove-__SMP__.patch
-make-init_mister-static.patch
-skfddi-copy_user-checks.patch
-ll_rw_blk-comment-corrections.patch
-sc520_wdt-ioremap-checking.patch
-paride-error-return-handling.patch
-init-exit-cleanups.patch
-qla1280-pci-alloc-free-checking.patch
-saa7134-core-ioremap-checking.patch
-acpi-pci-routing-fixes.patch

 Merged

+tg3-poll_controller.patch
+kgdb-eth-reattach.patch
+kgdb-skb_reserve-fix.patch

 kgdb-over-ethernet fixes

-fix-io-hangs.patch
-as-insert-here-fix.patch

 Obsoleted

+acpi-irq-fixes.patch

 Andrew de Quincey's ACPI changes

-cfq-3.patch
-cfq-3-fixes.patch
+cfq-4.patch

 Reworked CFQ IO scheduler

-thread-pgrp-fix-2.patch

 Obsoleted by group_leader-rework.patch

+group_leader-rework.patch

 Use the thread group leader's pgrp rather than the current thread's pgrp
 everywhere.

+timer_tsc-cyc2ns_scale-fix.patch

 ia32 timer fixlet

+ppp-oops-fix.patch

 Fix an oops in the PPP driver (with devfs)

+d_delete-d_lookup-race-fix.patch

 dentry race fix

+idle-using-monitor-mwait.patch
+idle-using-monitor-mwait-tweaks.patch

 Support for using the new ia32 monitor/mwait instructions in the idle loop.

+remap_file_pages-MAP_NONBLOCK-fix.patch
+install_page-use-after-unmap-fix.patch

 remap_file_pages() fixes

+agp-build-fix.patch

 Compile fix

+inflate-error-cleanup.patch

 Error message consistencies.

+slab-debug-additions.patch

 Slab debug enhancements, including: make sure that objects are aligned at
 the highest possible address within their page, so overruns are more likely
 to trigger the page unmapping debug feature.

+mwave-locking-fixes.patch

 mwave driver fixes

+summit-includes-fix.patch

 Build fix

+random-lock-contention.patch

 Fix lock contention in the new random driver locking on monster SMP.

+agp-warning-fix.patch

 Fix some warning

+ifdown-lockup-fix.patch

 Fix network device close hang

+fadvise-needs-asmlinkage.patch

 Missing asmlinkage

+ufs-build-fix.patch

 Purge C++isms

-put_task_struct-debug.patch

 This broke, but the bug was fixed anyway.

-sparc64-lockmeter-fix.patch
-sparc64-lockmeter-fix-2.patch

 Folded into lockmeter.patch

+4g4g-copy_mount_options-fix.patch
+4g4g-pagetable-accounting-fix.patch

 4G/4G fixes





All 173 patches:


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

kgdb-over-ethernet.patch
  kgdb-over-ethernet patch

kgdb-over-ethernet-fixes.patch
  kgdb-over-ethernet fixlets

kgdb-CONFIG_NET_POLL_CONTROLLER.patch
  kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers

kgdb-handle-stopped-NICs.patch
  kgdb: handle netif_stopped NICs

eepro100-poll-controller.patch

tlan-poll_controller.patch

tulip-poll_controller.patch

tg3-poll_controller.patch
  kgdb: tg3 poll_controller

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

kgdb-eth-reattach.patch

kgdb-skb_reserve-fix.patch
  kgdb-over-ethernet: skb_reserve() fix

acpi-irq-fixes.patch
  Next round of ACPI IRQ fixes (VIA ACPI fixed)

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

no-unit-at-a-time.patch
  Use -fno-unit-at-a-time if gcc supports it

calibrate_tsc-consolidation.patch
  calibrate_tsc() fix and consolidation

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-build-fixes.patch
  Fix ppc64 breakage

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-local.patch
  ppc64: local.h implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

input-use-after-free-checks.patch
  input layer debug checks

fbdev.patch
  framebbuffer driver update

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

group_leader-rework.patch
  Fix setpgid and threads
  use group_leader->pgrp (was Re: setpgid and threads)

ramdisk-cleanup.patch

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

intel8x0-cleanup.patch
  intel8x0 cleanups

claim-serio-early.patch
  Serio: claim serio early

mark-devfs-obsolete.patch
  mark devfs obsolete

VT8231-router-detection.patch
  VT8231 IRQ router detection

block-devfs-conversions.patch
  Initialise devfs_name in various block drivers

timer_tsc-cyc2ns_scale-fix.patch
  monolitic_clock, timer_{tsc,hpet} and CPUFREQ

test4-pm1.patch
  power management update

ide-pm-oops-fix.patch
  IDE power management oops fix

swsusp-fpu-fix.patch
  swsusp fpu management fix

ricoh-mask-fix.patch
  pcmcia: ricoh.h mask fix
  EDEC
  From: KOMURO <komujun@nifty.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
  
  RL5C4XX_16BIT_MEM_0 was wrong.

dac960-devfs_name-fix.patch
  dac960 devfs_name initialisation fix

dac960-warning-fixes.patch
  compiler warning fixes for DAC960 on alpha

ikconfig-gzipped-2.patch
  Move ikconfig to /proc/config.gz
  ikconfig cleanup

flush-invalidate-fixes.patch
  memory writeback/invalidation fixes

flush-invalidate-fixes-warning-fix.patch

ide_floppy-maybe-fix.patch
  might fix ide_floppy

reiserfs-direct-io.patch
  resierfs direct-IO support

pdflush-diag.patch

joydev-exclusions.patch
  joydev is too eager claiming input devices

might_sleep-diags.patch

imm-fix-fix.patch
  Fix imm.c again

selinux-option-config-option.patch
  make selinux enable param config option, enabled by default

sound-remove-duplicate-includes.patch
  sound: remove duplicate includes

kernel-remove-duplicate-includes.patch
  remove duplicate includes in kernel/

utime-on-immutable-file-fix.patch
  disallow utime{s}() on immutable or append-only files

add-daniele-to-credits.patch
  add Daniele to CREDITS

NR_CPUS-overflow-fix.patch
  Handle NR_CPUS overflow

ppp-oops-fix.patch
  ppp oops fix

d_delete-d_lookup-race-fix.patch
  d_delete-d_lookup race fix

idle-using-monitor-mwait.patch
  idle using PNI monitor/mwait

idle-using-monitor-mwait-tweaks.patch

remap_file_pages-MAP_NONBLOCK-fix.patch
  remap file pages MAP_NONBLOCK fix

install_page-use-after-unmap-fix.patch
  install_page pte use-after-unmap fix

agp-build-fix.patch
  AGPGART_MINOR needs <linux/agpgart.h>

really-use-english-date-in-version-string.patch
  really use english date in version string

inflate-error-cleanup.patch
  tidy up lib/inflate.c error messages

slab-debug-additions.patch
  Move slab objects to the end of the real allocation

mwave-locking-fixes.patch
  mwave locking fixes

summit-includes-fix.patch
  fix Summit srat.h includes

random-lock-contention.patch
  Redue random driver lock contention

agp-warning-fix.patch
  AGP warning fix

ifdown-lockup-fix.patch

fadvise-needs-asmlinkage.patch

ufs-build-fix.patch
  fs/ufs/namei.c build fix

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

psmouse_ipms2-option.patch
  Force mouse detection as imps/2 (and fix my KVM switch)

i8042-history.patch
  debug: i8042 history dumping

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

sched-CAN_MIGRATE_TASK-fix.patch
  CAN_MIGRATE fix

sched-balance-fix-2.6.0-test3-mm3-A0.patch
  sched-balance-fix-2.6.0-test3-mm3-A0

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

ppc-sched_clock.patch

ppc64-sched_clock.patch
  ppc64: sched_clock()

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

sched-cpu-migration-fix.patch
  sched: task migration fix

o19int.patch
  O19int

o20int.patch
  O20int

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix

4g4g-cyclone-timer-fix.patch

4g4g-copy_mount_options-fix.patch
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c

4g4g-pagetable-accounting-fix.patch
  4g/4g pagetable accounting fix

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
  task task_lock in use_mm()

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes

aio-O_SYNC-fix-missing-bit.patch
  aio-O_SYNC-fix bits got lost

O_SYNC-speedup-nolock-fix.patch

aio-writev-nsegs-fix.patch
  aio: writev nr_segs fix

aio-remove-lseek-triggerable-BUG_ONs.patch

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup

aio-osync-fix-2.patch
  More AIO O_SYNC related fixes




