Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275464AbTHJDjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 23:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275465AbTHJDjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 23:39:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:51150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275464AbTHJDji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 23:39:38 -0400
Date: Sat, 9 Aug 2003 20:39:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test3-mm1
Message-Id: <20030809203943.3b925a0e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1


. Manfred might have fixed the long-standing task_struct use-after-free
  bug which happens occasionally on preemptible kernels.

. This kernel immediately triplefaults when compiled with gcc-2.95.3 and
  CONFIG_KGDB.  It is due to compiling with "-ggdb" or "-gdwarf-2".  When
  compiled with "-g" it works OK, but gdb screws that up.

  Moral: use a later gcc if you're a kgdb user.

. Lots of fixes for random things, as usual.  Keep 'em coming.




Changes since 2.6.0-test2-mm5:


 linus.patch

 Latest from Linus

-ax8817x-build-fix.patch
-remove-PF_READAHEAD.patch
-floppy-smp-fixes.patch
-dm-1-module-param.patch
-dm-2-blk.patch
-dm-3-use-hex.patch
-dm-4-64-bit-ioctls.patch
-dm-5-missing-include.patch
-dm-6-sector_div.patch
-dm-7-rename-resume.patch
-reiserfs-savelinks-endianness-fix.patch
-reiserfs-enospc-fix.patch
-reiserfs-link-unlink-race-fix.patch
-reiserfs-remount-locking-fix.patch
-mremap-atomicity-fix.patch
-ide-cd-oops-fix.patch
-usercopy-might_sleep-checks.patch
-panic-nmi-watchdog-fix.patch
-ide-capacity-fixes.patch
-export-lookup_create.patch
-free_all_bootmem_core-fix.patch
-x86_64-nmi-watchog-doc-update.patch
-do_setitimer-cleanup.patch
-itimer-rounding-and-resolution-fix.patch
-ext3-aborted-journal-fix.patch
-create-struct-irq_desc.patch
-mtrr-hang-fix.patch
-matroxfb-updates.patch
-k7-mce-fix.patch
-init_page_private.patch

 Merged

-kgdb-remove-cpu_callout_map.patch
-kgdb-use-ggdb.patch
-kgdb-ga-docco-fixes.patch
-kgdb-sysrq-g-fix.patch
-kgdb-serial-fix.patch

 Folded into kgdb-ga.patch (new release from George Anzinger)

+kgdb-build-fix.patch
+kgdb-spinlock-fix.patch

 kgbd touchups.

-cpumask-mips-fix.patch
-cpumask-arith-fix.patch
-cpumask-physid-fix.patch
-cpumask_t-up-build-fix.patch
-cpumask_t-random-fixes.patch
-next_cpu-fix.patch
-cpumask-ppc-fixes.patch
-flush_cpumask-atomicity-fix.patch

 Folded into cpumask_t-1.patch

+fadvise-fix.patch

 POSIX_FADV_DONTNEED wasn't invalidating the right parts of the file.

+fadvise64-64.patch

 A 32-bit `len' arg to fadvise() is unsuitable.  Create a new syscall which
 takes a 64-bit length.

-ia64-percpu-revert.patch

 This wasn't needed any more

-ds-09-vicam-usercopy-fix.patch

 Alan said this wasn't right.

+x440-fixes.patch

 Various simplifications

+ppc-64-bit-stat.patch
+64-bit-dev_t-init_rd-fixes.patch

 64-bit dev_t fixes

+o14int.patch
+o14int-div-fix.patch
+o14.1int.patch

 CPU scheduler stuff from Con.

-nforce2-acpi-fixes-fix.patch

 Folded into nforce2-acpi-fixes.patch

+4g4g-vmlinux-update-got-lost.patch

 Restore a lost chunk.

-xfs-use-after-free-fix.patch

 This patch isn't right and wasn't supposed to be in test2-mm5.

-as-no-trinary-states.patch

 This is broken.

-devfs-pty-slave-fix.patch

 Wrong.  Mount /dev/pts atthe right time.

-slab-debug-updates.patch

 For some reason this patch is causing hangs when starting init with the
 4g/4g split enabled.  Drop it out for now.

-large-TCQ-fix.patch

 nacked by Jens.

+pipe-rofs-fix.patch

 Fix the "write to a fifo alters a read-only fs" bug.  (Haven't tested it
 yet)

+reiserfs-bogus-kunmap-removal.patch

 Remove bogus kunmap on a rare path.

+reiserfs-xattr-fix.patch

 Unprivileged users must not alter immutable attributes.

+p4-thermal-interrupt-fix.patch

 P4 thermal interrupt vector isn't getting set on SMP.

+nbd-race-fixes.patch

 NBD fixes

+disable-raid5-readahead.patch

 Work around RAID5 data loss problems

+pnp_get_info-oops-fix.patch

 Fix oopses reading /proc/net/pnp

+cciss-warning-fix.patch
+vt_ioctl-warning-fixes.patch

 Compile warning fixes

+task-refcounting-fix.patch

 Might fix the task_struct use-after-free bug.

+zap_other_threads-fix.patch

 Fix group leader attach/detach code.

+probe-udf-after-reiserfs.patch

 Change rootfs autodetection to try reiserfs before UDF

+nfsd-timestamp-fix.patch

 Fix NFS timestamp problems

+input-use-after-free-checks.patch

 Debug checks

+ide-scsi-queue-conversion-fix.patch

 ide-scsi probable-oops fix.

+bluetooth-deref-fix.patch

 Make bluetooth work.

+ikconfig-enable.patch

 Config option to enable /proc/ikconfig

+export-video_proc_entry.patch

 Symbol export for USB media devices

+trident-spin_unlock-fix.patch

 Sound card SMP deadlock fix

+handle-old-dev_t-format.patch

 Might fix the boot problems wherein "root=0302" isn't getting parsed.

+firmware-loader-needs-hotplug.patch

 Missing config dependency.

+aio-readahead-speedup.patch

 Make streaming AIO do readahead nicely.






All 153 patches:


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

vmlinux-generation-fix.patch
  Fix vmlinux.lds.s generation

cpumask_t-1.patch
  cpumask_t: allow more than BITS_PER_LONG CPUs
  cpumask_t fix for s390
  fix cpumask_t for s390
  Fix cpumask changes for x86_64
  fix cpumask_t for sparc64
  cpumask_t: more gcc workarounds
  cpumask_t gcc bug workarounds
  cpumask_t: build fix
  cpumask: IPS fixups
  cpumask: avoid using structs for NR_CPUS<BITS_PER_LONG
  cpumask: physid fixes
  cpumask_t uniproc build fix
  cpumask_t fixes
  cpumask: next_cpu fix
  flush_cpumask atomicity fix

kgdb-cpumask_t.patch

fadvise-fix.patch
  fadvise(POSIX_FADV_DONTNEED) fix

fadvise64-64.patch
  sys_fadvise64_64

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

x86_64-fixes.patch
  x86_64 fixes

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

rcu-grace-period.patch
  Monitor RCU grace period

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

ppa-fix.patch
  ppc fix

x440-fixes.patch
  From: Matthew Dobson <colpatch@us.ibm.com>
  Subject: [patch] 16-way x440 breakage

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

o14int.patch
  O14int

o14int-div-fix.patch
  o14int 64-bit-divide fix

o14.1int.patch
  O14.1int

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

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

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

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

random-locking-fixes.patch
  random: SMP locking

random-accounting-and-sleeping-fixes.patch
  random: accounting and sleeping fixes

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

xfs-uptodate-page-fix.patch
  fix buffer layer error at fs/buffer.c:2800 when unlinking XFS files

standalone-elevator-noop.patch
  standalone elevator noop

pipe-rofs-fix.patch
  pipe.c: don't write to readonly filesystems

reiserfs-bogus-kunmap-removal.patch
  reiserfs: remove unneeded kunmap

reiserfs-xattr-fix.patch
  reiserfs: Fix handling of some extended inode attributes

p4-thermal-interrupt-fix.patch
  Setup P4 thermal interrupt vector on UP

nbd-race-fixes.patch
  nbd: fix send/receive/shutdown/disconnect races

disable-raid5-readahead.patch
  raid5: disable readahead

pnp_get_info-oops-fix.patch
  /proc/net/pnp oops fix

cciss-warning-fix.patch
  cciss warning fix

vt_ioctl-warning-fixes.patch
  vt_ioctl warning fixes

task-refcounting-fix.patch
  fix task struct refcount bug

zap_other_threads-fix.patch
  zap_other_threads() detaches thread group leader

probe-udf-after-reiserfs.patch
  probe UDF after reiserfs

nfsd-timestamp-fix.patch
  Fix protocol bugs with NFS and nanoseconds

input-use-after-free-checks.patch
  input layer debug checks

ide-scsi-queue-conversion-fix.patch
  fix ide-scsi for ide_drive_t->queue change

bluetooth-deref-fix.patch
  BUG fix for drivers/bluetooth/hci_usb.c

ikconfig-enable.patch
  enable the ikconfig stuff in config

export-video_proc_entry.patch
  export video_proc_entry()to modules

trident-spin_unlock-fix.patch
  fix trident.c missing unlock

handle-old-dev_t-format.patch
  handle old-style "root=" arguments

firmware-loader-needs-hotplug.patch
  firmware loader requires hotplug

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

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



