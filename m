Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTJEIbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 04:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJEIbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 04:31:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:49605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263019AbTJEIbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 04:31:36 -0400
Date: Sun, 5 Oct 2003 01:33:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test6-mm4
Message-Id: <20031005013326.3c103538.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm4/

This is a small stabilisation update against -mm3 to fix various bits of
brokenness which people have inflicted upon me.  To make it all build, boot
and run on ia32, ia64 and ppc64.




Changes since 2.6.0-test6-mm3:


 linus.patch

 latest Linus tree

-skb-leak-fix.patch

 Merged

-utime-on-immutable-file-fix-cleanup.patch

 Dropped: the current code is OK.

-readonly-bind-mounts.patch

 This got broken.

+compat-ioctl-consolidation-job-control-update.patch

 Update compat-ioctl-consolidation.patch for move-job-control-fields.patch

+move-job-control-fields-ia64-fix.patch

 Fix ia64 for move-job-control-fields.patch

+ia32-efi-other-arch-fix.patch

 Fix ia32-efi-support.patch for non-ia32 builds

+sparc32-sched_clock.patch

 Simple sched_clock() implementation for sparc32

+unmap_vmas-warning-fix.patch

 Warning fixlet

+athlon-prefetch-handling.patch
+athlon-prefetch-handling-fix.patch

 Latest athlon prefetch workaround.




All 155 patches:


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

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

kgdb-eth-reattach.patch

kgdb-skb_reserve-fix.patch
  kgdb-over-ethernet: skb_reserve() fix

must-fix.patch

should-fix.patch

RD0-initrd-B6.patch

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

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-sym2-fix.patch
  ppc64 sym2 fix

sym-do-160.patch
  make the SYM driver do 160 MB/sec

input-use-after-free-checks.patch
  input layer debug checks

fbdev.patch
  framebbuffer driver update

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

radeonfb-line_length-fix.patch
  From: Peter Chubb <peter@chubb.wattle.id.au>
  Subject: Radeon framebuffer problems i 2.6.0-test6

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

uml-update.patch
  Update UML to 2.6.0-test5

selectable-logbuf-size.patch
  boot-time selectable log buffer size

8139too-edimax.patch

pdflush-diag.patch

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

futex_refs_and_lock_fix.patch
  futex locking fix

futex-locking-fix-fix.patch
  fix to futex locking fix

futex-uninlinings.patch
  futex uninlining

node-enumeration-cleanup-01.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [1/5]

node-enumeration-cleanup-02.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [2/5]

node-enumeration-cleanup-03.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [3/5]

node-enumeration-cleanup-04.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [4/5]

node-enumeration-cleanup-05.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [5/5]

node-enumeration-cleanup-fix-01.patch
  node enumeration fixes

zap_page_range-debug.patch
  zap_page_range() debug

acpi-thinkpad-fix.patch
  APCI fix for thinkpads

compat-ioctl-consolidation.patch
  compat ioctl consolidation

compat-ioctl-consolidation-job-control-update.patch

alsa-gameport-fix.patch
  ALSA pci Kconfig fix

scsi-handle-zero-length-requests.patch
  scsi: handle zero-length requests

sizeof-in-ioctl-fix.patch
  incorrect use of sizeof() in aty128fb

call_usermodehelper-retval-fix-3.patch
  Make call_usermodehelper report exit status

asus-L5-fix.patch
  Asus L5 framebuffer fix

ax25-timer-cleanup.patch
  X25 timer cleanup

jffs-use-daemonize.patch

calc_vm_trans-commentary.patch
  document the macro for translating PROT_ to VM_ bits

tulip-NAPI-support.patch
  tulip NAPI support

tulip-napi-disable.patch
  tulip NAPI: disable poll in close

io-refcount-debugging.patch
  io context refcounting debugging

proc-sys-auxv.patch
  /proc/sys/auxv

kernel-doc-fixes.patch
  kernel documentation fixes

kill-CONFIG_EISA_ALWAYS.patch
  EISA_bus cleanup

ext3-concurrent-alloc-locking-fix.patch

dscc4-fixes.patch
  dscc4 driver fixes

cpufreq-sysfs-oops-fix.patch
  cpufreq sysfs oops fix

move-job-control-fields.patch
  move job control fields from task_struct to signal_struct

move-job-control-fields-ia64-fix.patch

get_user_pages-handle-VM_IO.patch

ia32-MSI-support.patch
  Updated ia32 MSI Patches

ia32-MSI-support-tweaks.patch

ia32-efi-support.patch
  EFI support for ia32

CONFIG_ACPI_EFI-defaults-off.patch

ia32-efi-support-warning-fixes.patch

ia32-efi-support-tidy.patch

ia32-efi-other-arch-fix.patch
  fix EFI for ppc64, ia64

support-zillions-of-scsi-disks.patch
  support many SCSI disks

dynamic-irq_vector-allocation.patch
  dynamic irq_vector allocation for ia32

SGI-IOC4-IDE-chipset-support.patch
  Add support for SGI's IOC4 chipset

do_no_page-pte_chain_leak-fix.patch
  fix pte_chain leak in do_no_page

vma-split-truncate-race-fix.patch
  fix split_vma vs. invalidate_mmap_range_list race

vma-split-truncate-race-fix-tweaks.patch

sparc32-sched_clock.patch

unmap_vmas-warning-fix.patch
  Fix unmap_vmas() compile warning

keyboard-repeat-rate-setting-fix.patch
  keyboard repeat rate setting fix

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

athlon-prefetch-handling.patch
  Athlon prefetch patch for 2.6.0test6mm2

athlon-prefetch-handling-fix.patch

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

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL
  AIO: flush workqueues before destroying ioctx'es
  AIO: hold the context lock across unuse_mm
  task task_lock in use_mm()

aio-refcounting-fix.patch
  aio ref count in io_submit_one

aio-retry-elevated-refcount.patch
  aio: extra ref count during retry

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



