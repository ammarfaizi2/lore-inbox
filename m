Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275058AbTHGFfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275076AbTHGFfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:35:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:44473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275058AbTHGFfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:35:25 -0400
Date: Wed, 6 Aug 2003 22:37:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test2-mm5
Message-Id: <20030806223716.26af3255.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/


Lots of different things.  Mainly trying to get this tree stabilised again;
there has been some breakage lately.




Changes since 2.6.0-test2-mm4:


-execve-fixes.patch
-ppc64-sections.patch
-ppc64-prom-compile-fix.patch
-spurious-SIGCHLD-fix.patch

 Merged

+vmlinux-generation-fix.patch

 Shuffle vmlinux.lds.S around to get dependencies right.

+remove-PF_READAHEAD.patch

 Remove PF_READAHEAD: it's not doing anything now, and it leads to bogus IO
 errors when we reenter the page allocator with it set.


+cpumask_t-random-fixes.patch
+next_cpu-fix.patch
+cpumask-ppc-fixes.patch
+flush_cpumask-atomicity-fix.patch

 NR_CPUS > BITS_PER_LONG fixes

-ppc64-64-bit-mknod-fix.patch
-ppc64-64-bit-ustat-fix.patch

 Dropped - fixed differently.

+mknod64-64-bit-fix.patch

 Fix mknod for some 64-bit architectures

+ppc-sched_clock.patch

 Implement sched_clock() for ppc: needed for the CPU scheduler updates

+o12.3.patch
+o13int.patch
+o13.1int.patch

 Interactivity patches

-remove-const-initdata.patch

 No longer needed.  Fixes are in -linus

+4g4g-wli-fixes.patch

 Various fixes for the 4G/4G patch

+4g4g-remove-touch_all_pages.patch

 Remove (buggy on discontigmem) debug stuff

+ppc-fixes.patch

 Small ppc fix

+reiserfs-remount-locking-fix.patch

 Put the bkl back in remount code

+as-no-trinary-states.patch

 Anticipatory scheduler tidyup.

+export-lookup_create.patch

 hwgfs and intermezzo need it

+free_all_bootmem_core-fix.patch

 bootmem fix for ia64

+x86_64-nmi-watchog-doc-update.patch

 documentation update

+do_setitimer-cleanup.patch

 Move the declaration(s) from .c into a shared header

+devfs-pty-slave-fix.patch

 devfs fix

+nbd-race-fix.patch

 NBD race fix

+itimer-rounding-and-resolution-fix.patch

 interval timer fixes

+ext3-aborted-journal-fix.patch

 ext3 oops fix.

+create-struct-irq_desc.patch

 typedef pain relief

+rt-tasks-special-vm-treatment.patch
+rt-tasks-special-vm-treatment-2.patch

 Give RT tasks special treatment in the VFS and VM

+slab-debug-updates.patch

 Slab debugging improvements

+matroxfb-updates.patch

 fb driver update

+k7-mce-fix.patch

 Should fix the MCE exceptions on Athlons

+xfs-uptodate-page-fix.patch

 XFS fix

+standalone-elevator-noop.patch

 rationalise elevator_noop

+large-TCQ-fix.patch

 Scale the rquest queues appropriately for TCQ

+init_page_private.patch

 Initialise page->private to zero.






All 172 patches:


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

kgdb-sysrq-g-fix.patch
  kgdb sysrq-g fix

kgdb-serial-fix.patch
  kgdb serial port fix

kgdb-warning-fix.patch
  kgdbL warning fix

vmlinux-generation-fix.patch
  Fix vmlinux.lds.s generation

ax8817x-build-fix.patch
  ax8817x.c build fix for older gcc's

remove-PF_READAHEAD.patch
  remove PF_READAHEAD

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

cpumask_t-random-fixes.patch
  cpumask_t fixes

next_cpu-fix.patch
  cpumask: next_cpu fix

cpumask-ppc-fixes.patch

flush_cpumask-atomicity-fix.patch
  flush_cpumask atomicity fix

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

ppc64-sched_clock.patch
  ppc64: sched_clock()

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

ppc-sched_clock.patch

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

4g4g-wli-fixes.patch
  4g/4g: fixes from Bill

4g4g-fpu-fix.patch
  4g4g: fpu emulation fix

4g4g-show_registers-fix.patch
  4g4g: show_registers() fix

4g4g-pin_page-atomicity-fix.patch
  4g/4g usercopy atomicity fix

4g4g-remove-touch_all_pages.patch

ppc-fixes.patch
  make mm4 compile on ppc

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

reiserfs-remount-locking-fix.patch
  reiserfs: fix locking in reiserfs_remount

mremap-atomicity-fix.patch
  move_one_page() atomicity fix

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

as-no-trinary-states.patch
  AS: no trinary states

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

export-lookup_create.patch
  export lookup_create()

free_all_bootmem_core-fix.patch
  fix free_all_bootmem_core for virtual memmap

x86_64-nmi-watchog-doc-update.patch
  NMI watchdog documentation for x86-64

do_setitimer-cleanup.patch
  Add do_setitimer prototype to linux/time.h

devfs-pty-slave-fix.patch
  create pty slaves in devfs

nbd-race-fix.patch
  NBD driver: remove send/receive race for request

itimer-rounding-and-resolution-fix.patch
  itimer resolution and rounding fixes

ext3-aborted-journal-fix.patch
  ext3: handle aborted journals in do_get_write_access()

create-struct-irq_desc.patch
  declare struct irq_desc

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

slab-debug-updates.patch
  slab debugging updates

mtrr-hang-fix.patch
  Fix mtrr-related hang

matroxfb-updates.patch
  matroxfb updates

k7-mce-fix.patch
  athlon MCE fix

xfs-uptodate-page-fix.patch
  fix buffer layer error at fs/buffer.c:2800 when unlinking XFS files

standalone-elevator-noop.patch
  standalone elevator noop

large-TCQ-fix.patch
  large TCQ fix

init_page_private.patch
  initialise page->private

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



