Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTKEGxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 01:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTKEGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 01:53:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:42682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262777AbTKEGwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 01:52:51 -0500
Date: Tue, 4 Nov 2003 22:55:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test9-mm2
Message-Id: <20031104225544.0773904f.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm2/


- Various random fixes.  Maybe about half of these are 2.6.0-worthy.

- Some improvements to the anticipatory IO scheduler and more readahead
  tweaks should help some of those database benchmarks.

  The anticipatory scheduler is still a bit behind the deadline scheduler
  in these random seeky loads - it most likely always will be.

- "A new driver for the ethernet interface of the NVIDIA nForce chipset,
  licensed under GPL."

  Testing of this would be appreciated.  Send any reports to linux-kernel
  or netdev@oss.sgi.com and Manfred will scoop them up, thanks.


- I shall be offline for a couple of days.




Changes since 2.6.0-test9-mm1:


 linus.patch

 Latest Linus tree

-might_sleep-suppression.patch

 Dropped - Linus fixed the vm86 might_sleep() warning for real.

+as-badness-warning-fix.patch
+as-request-poisoning.patch
+as-new-process-estimation.patch
+as-cooperative-thinktime.patch

 Anticipatory scheduler performance work.

+scale-nr_requests.patch

 Increase the initial disk request queue size if the disk is using deep Tag
 Command Queueing.

+local_bh_enable-warning-fix.patch

 Fiddle with the debug warnings in local_bh_enable()

+ohci-locking-fix.patch

 Partially address some USB locking problems.

+disable-ide-tcq.patch

 Disable IDE TCQ in config.  It's not working right yet.

+request-module-char-dev-fix.patch

 Fix autoloading of the loop driver module.

+loop-remove-blkdev-special-case.patch

 Loop driver rework: treat block-backed loop in an identical manner to
 file-backed loop.

+loop-highmem.patch
+loop-highmem-fixes.patch

 Switch the loop<->cryptolooop interface to use page/offset rather than
 kmap+virtaddr.

+via-quirk-fix.patch

 VIA oops fix

+cdc-acm-softirq-rx.patch

 USB locking fix

+forcedeth.patch

 nForce ethernet driver

+raid1-recovery-fix.patch

 Fix RAID1 recovery.

+journal_remove_journal_head-assertion-fix.patch

 Fix and ext3 assertion failure.

+x86_64-tss-limit-fix.patch

 x86_64 fix

+reiserfs-pinned-buffer-fix.patch

 reiserfs pinned buffer fix

+proc-pid-maps-output-fix.patch

 Fix /proc/pid/maps display for deleted files (needs work)

+atomic_dec-debug.patch

 "Verifies that all "atomic_dec_and_test()" users never see a negative value
 (which would be bad)."

+sis900-pm-support.patch

 Power management support for sis900 driver

+drm-agp-module-dependency-fix.patch

 Maybe fix DRM<->AGP module dependencies so things autoload nicely.

+8139too-locking-fix.patch

 Fiddle with 8139too locking.

+ia32-wp-test-cleanup.patch

 Simplify the ia32 WP bug detection code.

+hugetlb-needs-pse.patch

 Disable hugetlbfs if the CPU doesn't support large pages.

+powermate-payload-size-fix.patch

 Fix the powermate driver for newer devices.

+4g4g-KERNEL_DS-usercopy-fix.patch

 Fix for the 4G/4G split patch.

+readahead-simplification.patch

 Readahead performance fix.





All 192 patches

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-buff-too-big.patch
  kgdb buffer overflow fix

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

8139too-poll_controller.patch
  8139too poll controller

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

kgdb-eth-reattach.patch

kgdb-skb_reserve-fix.patch
  kgdb-over-ethernet: skb_reserve() fix

must-fix.patch

should-fix.patch

must-fix-update-01.patch
  must fix lists update

RD1-cdrom_ioctl-B6.patch

RD2-ioctl-B6.patch

RD2-ioctl-B6-fix.patch
  RD2-ioctl-B6 fixes

RD3-cdrom_open-B6.patch

RD4-open-B6.patch

RD5-cdrom_release-B6.patch

RD6-release-B6.patch

RD7-presto_journal_close-B6.patch

RD8-f_mapping-B6.patch

RD9-f_mapping2-B6.patch

RD10-i_sem-B6.patch

RD11-f_mapping3-B6.patch

RD12-generic_osync_inode-B6.patch

RD13-bd_acquire-B6.patch

RD14-generic_write_checks-B6.patch

RD15-I_BDEV-B6.patch

RD16-rest-B6.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup

invalidate_inodes-speedup-fixes-2.patch
  more invalidate_inodes speedup fixes

serio-01-renaming.patch
  serio: rename serio_[un]register_slave_port to __serio_[un]register_port

serio-02-race-fix.patch
  serio: possible race between port removal and kseriod

serio-03-blacklist.patch
  Add black list to handler<->device matching

serio-04-synaptics-cleanup.patch
  Synaptics: code cleanup

serio-05-reconnect-facility.patch
  serio: reconnect facility

serio-06-synaptics-use-reconnect.patch
  Synaptics: use serio_reconnect

acpi_off-fix.patch
  fix acpi=off

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

input-use-after-free-checks.patch
  input layer debug checks

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

futex-uninlinings.patch
  futex uninlining

zap_page_range-debug.patch
  zap_page_range() debug

call_usermodehelper-retval-fix-3.patch
  Make call_usermodehelper report exit status

asus-L5-fix.patch
  Asus L5 framebuffer fix

jffs-use-daemonize.patch

tulip-NAPI-support.patch
  tulip NAPI support

tulip-napi-disable.patch
  tulip NAPI: disable poll in close

get_user_pages-handle-VM_IO.patch

ia32-MSI-support.patch
  Updated ia32 MSI Patches

ia32-MSI-support-tweaks.patch

ia32-efi-support.patch
  EFI support for ia32

ia32-efi-asm-warning-fix.patch
  efi warning fix

ia32-efi-support-mem-equals-fix.patch

CONFIG_ACPI_EFI-defaults-off.patch

ia32-efi-support-warning-fixes.patch

ia32-efi-support-tidy.patch

ia32-efi-other-arch-fix.patch
  fix EFI for ppc64, ia64

efi-constant-sizing-fix.patch
  efi: warning fixes

ia32-efi-config-option.patch
  ia32 EFI: Add CONFIG_EFI

ia32-efi-config-option-tweaks.patch

ia32-efi-config-help-update.patch
  efi: Update Kconfig help

ia64-CONFIG_EFI-update.patch
  efi update patch (ia64)

support-zillions-of-scsi-disks.patch
  support many SCSI disks

SGI-IOC4-IDE-chipset-support.patch
  Add support for SGI's IOC4 chipset

sparc32-sched_clock.patch

pcibios_test_irq-fix.patch
  Fix pcibios test IRQ handler return

fixmap-in-proc-pid-maps.patch
  report user-readable fixmap area in /proc/PID/maps

i82365-sysfs-ordering-fix.patch
  Fix init_i82365 sysfs ordering oops

pci_set_power_state-might-sleep.patch

compat_ioctl-cleanup.patch
  cleanup of compat_ioctl functions

fix-sqrt.patch
  sqrt() fixes

scale-min_free_kbytes.patch
  scale the initial value of min_free_kbytes

cdrom-allocation-try-harder.patch
  Use __GFP_REPEAT for cdrom buffer

sym-2.1.18f.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

nosysfs.patch

constant_test_bit-doesnt-like-zwanes-gcc.patch
  gcc bug workaround for constant_test_bit()

slab-leak-detector.patch
  slab leak detector

early-serial-registration-fix.patch
  serial console registration bugfix

3c527-smp-update.patch
  SMP support on 3c527 net driver

3c527-race-fix.patch

ext3-latency-fix.patch
  ext3 scheduling latency fix

videobuf_waiton-race-fix.patch

firmware-kernel_thread-on-demand.patch
  Remove workqueue usage from request_firmware_async()

loop-autoloading-fix.patch
  Fix loop module auto loading

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

cmpci-set_fs-fix.patch
  cmpci.c: remove pointless set_fs()

dentry-bloat-fix-2.patch
  Fix dcache and icache bloat with deep directories

nls-config-fixes.patch
  NSL config fixes

proc_pid_lookup-vs-exit-race-fix.patch
  Fix proc_pid_lookup vs exit race

gcc-Os-if-embedded.patch
  Add `gcc -Os' config option

gcc-Os-if-embedded-better-help.patch

aic7xxx-sleep-in-spinlock-fix.patch

ia64-ia32-missing-compat-syscalls.patch
  From: Arun Sharma <arun.sharma@intel.com>
  Subject: Missing compat syscalls in ia64

vm86-sysenter-fix.patch
  Fix sysenter disabling in vm86 mode

gettimeofday-resolution-fix.patch
  gettimeofday resolution fix

refill_counter-overflow-fix.patch
  vmscan: reset refill_counter after refilling the inactive list

verbose-timesource.patch
  be verbose about the time source

as-badness-warning-fix.patch
  AS: handle non-block requests

as-regression-fix.patch
  Fix IO scheduler regression

as-request-poisoning.patch
  AS: request poisoning

as-new-process-estimation.patch
  AS: new process estimation

as-cooperative-thinktime.patch
  AS: thinktime improvement

scale-nr_requests.patch
  scale nr_requests with TCQ depth

3c509-mca-fix.patch
  3c509 MCA compile fix

truncate_inode_pages-check.patch

ext2-allocation-fix.patch
  ext2 block allocation race fix

local_bh_enable-warning-fix.patch

ohci-locking-fix.patch

disable-ide-tcq.patch
  Disable IDE Tagged Command Queueing

request-module-char-dev-fix.patch
  MODULE_ALIAS patch for ALSA

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-highmem-fixes.patch

via-quirk-fix.patch
  Fix oops in quirk_via_bridge

cdc-acm-softirq-rx.patch
  cdc-acm: move rx processing to softirq

forcedeth.patch
  forcedeth: nForce ethernet driver

raid1-recovery-fix.patch
  Fix RAID1 recovery

journal_remove_journal_head-assertion-fix.patch
  JBD: fix assertion failure

x86_64-tss-limit-fix.patch
  Fix TSS limit on x86-64

reiserfs-pinned-buffer-fix.patch
  reiserfs pinned buffer fix

proc-pid-maps-output-fix.patch
  Restore /proc/pid/maps formatting

atomic_dec-debug.patch
  atomic_dec debug

sis900-pm-support.patch
  Add PM support to sis900 network driver

drm-agp-module-dependency-fix.patch
  DRM/AGP module dependency fix

8139too-locking-fix.patch
  8139too locking fix

ia32-wp-test-cleanup.patch
  ia32 WP test cleanup

hugetlb-needs-pse.patch
  ia32: hugetlb needs pse

powermate-payload-size-fix.patch
  Griffin Powermate fix

keyboard-repeat-rate-setting-fix.patch
  keyboard repeat rate setting fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

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
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix

4g4g-athlon-prefetch-handling-fix.patch

4g4g-wp-test-fix.patch
  Fix 4G/4G and WP test lockup

4g4g-KERNEL_DS-usercopy-fix.patch
  4G/4G KERNEL_DS usercopy again

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework

O_DIRECT-race-fixes-rework-XFS-fix.patch
  O_DIRECT XFS fix

O_DIRECT-race-fixes-rework-XFS-fix-fix.patch

readahead-multiple-fixes.patch
  readahead: multipole performance fixes

readahead-simplification.patch
  readahead simplification

aio-sysctl-parms.patch
  aio sysctl parms

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL
  AIO: flush workqueues before destroying ioctx'es
  AIO: hold the context lock across unuse_mm
  task task_lock in use_mm()

4g4g-aio-hang-fix.patch
  Fix AIO and 4G-4G hang

aio-refcounting-fix.patch
  aio ref count in io_submit_one

aio-retry-elevated-refcount.patch
  aio: extra ref count during retry

aio-splice-runlist.patch
  Splice AIO runlist for fairer handling of multiple io contexts

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait
  lock_buffer_wq fix

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

O_SYNC-speedup-2-f_mapping-fixes.patch

aio-09-o_sync.patch
  aio O_SYNC
  AIO: fix a BUG
  Unify o_sync changes for aio and regular writes
  aio-O_SYNC-fix bits got lost
  aio: writev nr_segs fix
  More AIO O_SYNC related fixes

aio-09-o_sync-f_mapping-fixes.patch

gang_lookup_next.patch
  Change the page gang lookup API

aio-gang_lookup-fix.patch
  AIO gang lookup fixes

aio-O_SYNC-short-write-fix.patch
  Fix for O_SYNC short writes

aio-12-readahead.patch
  AIO: readahead fixes
  aio O_DIRECT no readahead
  Unified page range readahead for aio and regular reads

aio-12-readahead-f_mapping-fix.patch

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



