Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTKMH0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 02:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTKMH0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 02:26:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:4253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbTKMHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 02:25:41 -0500
Date: Wed, 12 Nov 2003 23:30:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test9-mm3
Message-Id: <20031112233002.436f5d0c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.6.0-test9-mm3.gz

  kernel.org is being slow.  Will appear at:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/

- Various new fixes; generally uncritical ones.

- Significant changes to the AIO and direct-io code.  This needs beating
  on; hopefully we're now close to a solution to the fairly complex problems
  in there.

- Several ext2 and ext3 allocator fixes.  These need serious testing on big
  SMP.

- Anyone who has patches in here which they think should go into 2.6.0,
  please retest them in -mm3 and let me know, thanks.



 linus.patch

 Latest Linus tree

-as-badness-warning-fix.patch
-3c509-mca-fix.patch
-ext2-allocation-fix.patch
-ohci-locking-fix.patch
-disable-ide-tcq.patch
-via-quirk-fix.patch
-raid1-recovery-fix.patch
-journal_remove_journal_head-assertion-fix.patch
-x86_64-tss-limit-fix.patch
-keyboard-repeat-rate-setting-fix.patch
-aio-refcounting-fix.patch

 Merged

-RD16-rest-B6.patch

 Al said to drop this.

+cramfs-use-pagecache.patch

 cramfs fixes

-ia32-MSI-support-tweaks.patch

 Folded into ia32-MSI-support.patch

+ia32-MSI-support-x86_64-fixes.patch

 x86_64 build fix

-ia32-efi-asm-warning-fix.patch
-ia32-efi-support-mem-equals-fix.patch
-CONFIG_ACPI_EFI-defaults-off.patch
-ia32-efi-support-warning-fixes.patch
-ia32-efi-support-tidy.patch
-ia32-efi-other-arch-fix.patch
-efi-constant-sizing-fix.patch
-ia32-efi-config-option.patch
-ia32-efi-config-option-tweaks.patch
-ia32-efi-config-help-update.patch
-ia64-CONFIG_EFI-update.patch

 Folded into ia32-efi-support.patch

+ia64-ia32-missing-compat-syscalls.patch
+compat-layer-fixes.patch

 32-bit compat layer fixes

+compat-ioctl-for-i2c.patch

 compat layer for i2c (old version)

+loop-bio-handling-fix.patch

 Loop driver fixlet

-gcc-Os-if-embedded-better-help.patch

 Folded into gcc-Os-if-embedded.patch

+as-request-poisoning-fix.patch
+as-fix-all-known-bugs.patch

 Anticipatory scheduler fixes.

+more-than-256-cpus.patch

 cpumask fixes for huge SMP

+acpi-pm-timer.patch
+acpi-pm-timer-fixes.patch

 Yet another timer source for ia32

+ZONE_SHIFT-from-NODES_SHIFT.patch

 Memory zone arith fixup

+ext2_new_inode-fixes.patch
+ext2_new_inode-fixes-tweaks.patch
+remove-ext2_reverve_inode.patch

 ext2 fixes

+memmove-speedup.patch

 Make memmove() faster.

+percpu-counter-linkage-fix.patch

 Fix the build for when ext2 and ext3 are modular

+ide-scsi-warnings.patch

 Print warnings when someone tries to use ide-scsi for a cdrom

+pipe-readv-writev.patch

 pipe readv() and writev() correctness fix and speedup

+ext3_new_inode-scan-fix.patch

 ext3 inode allocator fix

+lockless-semop.patch

 sysv semaphore SMP speedup

+percpu_counter-use-alloc_percpu.patch

 Fix the percpu counters for huge SMP.

+i450nx-scanning-fix.patch

 PCI bridge fix for i450nx chipset machines

+serio-pm-fix.patch

 Fix psmouse PM resume

+find_busiest_queue-commentary.patch

 CPU scheduler comments

+ext2-block-allocator-fixes.patch

 More ext2 allocator fixes.

+SOUND_CMPCI-config-typo-fix.patch

 Sound driver config fix

+atkbd-24-compatibility.patch

 Make AT keyboard userspace interface compatible with 2.4's.

+init_h-needs-compiler_h.patch
+init_h-needs-compiler_h-fix.patch

 Compile fix

+cpu_sibling_map-fix.patch

 cpu_sibling_map is broken on summit.

+tulip-hash-fix.patch

 Fix multicast hash generation for some tulips

+context-switch-accounting-fix.patch

 Fix CPU scheduler beancounting with CONFIG_PREEMPT.

+access-vfs_permission-fix.patch

 Fix access()

+eicon-linkage-fix.patch

 ISDM build fix

+kobject-docco-additions.patch

 Documentation additions.

-O_DIRECT-race-fixes-rework-XFS-fix.patch
-O_DIRECT-race-fixes-rework-XFS-fix-fix.patch

 Folded into O_DIRECT-race-fixes-rollup.patch

+dio-aio-fixes.patch
+dio-aio-fixes-fixes.patch

 AIO/direct-io fixes

+promise-sata-id.patch

 Additional STAT PCI ID.




All 201 patches


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

cramfs-use-pagecache.patch
  cramfs: use pagecache better

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

ia32-MSI-support-x86_64-fixes.patch

ia32-efi-support.patch
  EFI support for ia32
  efi warning fix
  fix EFI for ppc64, ia64
  efi: warning fixes
  ia32 EFI: Add CONFIG_EFI
  efi: Update Kconfig help
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

ia64-ia32-missing-compat-syscalls.patch
  From: Arun Sharma <arun.sharma@intel.com>
  Subject: Missing compat syscalls in ia64

compat-layer-fixes.patch
  Minor bug fixes to the compat layer

compat-ioctl-for-i2c.patch
  compat_ioctl for i2c

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

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-highmem-fixes.patch

loop-bio-handling-fix.patch
  loop: BIO handling fix

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

aic7xxx-sleep-in-spinlock-fix.patch

vm86-sysenter-fix.patch
  Fix sysenter disabling in vm86 mode

gettimeofday-resolution-fix.patch
  gettimeofday resolution fix

refill_counter-overflow-fix.patch
  vmscan: reset refill_counter after refilling the inactive list

verbose-timesource.patch
  be verbose about the time source

as-regression-fix.patch
  Fix IO scheduler regression

as-request-poisoning.patch
  AS: request poisoning

as-request-poisoning-fix.patch
  AS: request poisining fix

as-fix-all-known-bugs.patch
  AS fixes

as-new-process-estimation.patch
  AS: new process estimation

as-cooperative-thinktime.patch
  AS: thinktime improvement

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

cdc-acm-softirq-rx.patch
  cdc-acm: move rx processing to softirq

forcedeth.patch
  forcedeth: nForce ethernet driver

reiserfs-pinned-buffer-fix.patch
  reiserfs pinned buffer fix

proc-pid-maps-output-fix.patch
  Restore /proc/pid/maps formatting

atomic_dec-debug.patch
  atomic_dec debug

sis900-pm-support.patch
  Add PM support to sis900 network driver

8139too-locking-fix.patch
  8139too locking fix

ia32-wp-test-cleanup.patch
  ia32 WP test cleanup

hugetlb-needs-pse.patch
  ia32: hugetlb needs pse

powermate-payload-size-fix.patch
  Griffin Powermate fix

more-than-256-cpus.patch
  Fix for more than 256 CPUs

acpi-pm-timer.patch
  ACPI PM Timer

acpi-pm-timer-fixes.patch
  ACPI PM-Timer fixes

ZONE_SHIFT-from-NODES_SHIFT.patch
  Use NODES_SHIFT to calculate ZONE_SHIFT

ext2_new_inode-fixes.patch
  Fix bugs in ext2_new_inode()

ext2_new_inode-fixes-tweaks.patch
  ext2_new_inode: more tweaking

remove-ext2_reverve_inode.patch

memmove-speedup.patch
  optimize ia32 memmove

percpu-counter-linkage-fix.patch
  fix percpu_counter_mod linkage problem

ide-scsi-warnings.patch
  ide-scsi: warn when used for cdroms

pipe-readv-writev.patch
  Fix writev atomicity on pipe/fifo

ext3_new_inode-scan-fix.patch
  ext3_new_inode fixlet

lockless-semop.patch
  lockless semop

percpu_counter-use-alloc_percpu.patch
  use alloc_percpu in percpu_counters

i450nx-scanning-fix.patch
  i450nx PCI scanning fix

serio-pm-fix.patch
  psmouse pm resume fix

find_busiest_queue-commentary.patch
  find_busiest_queue() commentary fix

ext2-block-allocator-fixes.patch
  ext2 block allocator fixes

SOUND_CMPCI-config-typo-fix.patch
  fix SOUND_CMPCI Configure help entry

atkbd-24-compatibility.patch
  Fixes for keyboard 2.4 compatibility

init_h-needs-compiler_h.patch
  init.h needs to include compiler.h

init_h-needs-compiler_h-fix.patch
  compile fix for older gcc's

cpu_sibling_map-fix.patch
  cpu_sibling_map fix

tulip-hash-fix.patch
  tulip filter hash fix

context-switch-accounting-fix.patch
  Fix context switch accounting

access-vfs_permission-fix.patch
  Subject: Re: [PATCH] fix access() / vfs_permission() bug

eicon-linkage-fix.patch
  eicon/ and hardware/eicon/ drivers using the same symbols

kobject-docco-additions.patch
  Improve documentation for kobjects

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
  O_DIRECT XFS fix

dio-aio-fixes.patch
  direct-io AIO fixes

dio-aio-fixes-fixes.patch
  dio-aio fix fix

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

promise-sata-id.patch
  add Promise 20376 PCI ID



