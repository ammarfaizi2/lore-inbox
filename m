Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTJTJGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJTJGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:06:36 -0400
Received: from [65.172.181.6] ([65.172.181.6]:56217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262443AbTJTJGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:06:03 -0400
Date: Mon, 20 Oct 2003 02:05:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test8-mm1
Message-Id: <20031020020558.16d2a776.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8/2.6.0-test8-mm1


. Included a much updated fbdev patch.  Anyone who is using framebuffers,
  please test this.

. Quite a large number of stability fixes.



Changes since 2.6.0-test7-mm1:


-RD0-initrd-B6.patch
-sjcd-usercopy-checks.patch
-might_sleep-vs-jiffies-wrap.patch
-selinux-add-policyvers.patch
-mandocs-case-fix.patch
-swapon-handle-no-readpage.patch
-reiserfs-url-fixes.patch
-numaq-mpc-warning-fix.patch
-invalidate_inodes-speedup.patch
-invalidate_inodes-speedup-fixes.patch
-ide-piix-fallback-fix.patch
-ext3-i_disksize-locking-fix.patch
-applicom-fixes.patch
-acl-signedness-fix.patch
-saa7134-build-fix.patch
-ide-write-barrier-support.patch
-jbd-barrier-selection.patch

 Merged

-vma-split-truncate-race-fix.patch
-vma-split-truncate-race-fix-tweaks.patch
+vma-split-truncate-race-fix-2.patch

 Fix a race between vma_split() and truncation (rebased to Linus's tree)

+devfs-initrd-fix.patch

 Fix initrd when devfs is in use

-ppc64-semaphore-reimplementation.patch

 Dropped; it didn't solve the starvation problems anyway.

-ppc64-sym2-fix.patch

 No longer needed.

-cursor-flashing-fix.patch
-radeonfb-line_length-fix.patch

 Fixed in fbdev.patch

+fbdev-restore-pci-ids.patch

 Fix AGP compilation.

+limit_regions-syncup.patch

 Backport 2.4's ia32 "mem=" fix.

+ia32-efi-asm-warning-fix.patch
+ia32-efi-support-mem-equals-fix.patch
+efi-constant-sizing-fix.patch

 More fixes for the EFI patch.

+fix-sqrt.patch

 Fix int_sqrt().

 scale-min_free_kbytes.patch

 Fixed version.

+cdrom-allocation-try-harder.patch

 Avoid order-4 memory allocations failures when opening CDROM devices.

+atp870u-oops-fix.patch

 Fix an init-time oops in this driver.

+tmpfs-01-ENAMETOOLONG.patch
+tmpfs-02-gid-fix.patch
+tmpfs-03-swapoff-truncate-race.patch
+tmpfs-04-getpage-truncate-race.patch
+tmpfs-05-writepage-truncate-race.patch
+tmpfs-06-i_size_write.patch
+tmpfs-07-write-mark_page_accessed.patch

 tmpfs fixes.

+quota-locking-fix.patch

 Quota deadlock fix.

+export-system_running.patch
+might_sleep-early-bogons.patch

 Stomp all the early might_sleep() warnings.

+constant_test_bit-doesnt-like-zwanes-gcc.patch

 Workaround a gcc bug.

+slab-leak-detector.patch
+slab-leak-detector-tweaks.patch

 A slab debugging tool for finding memory leaks: do

	echo "slab-name 0 0 0" > /proc/slabinfo

 and the kernel will inspect each live object in that cache and will print
 out the code address from which the allocation was performed.

+digi_accelport-oops-fix.patch

 Fix an oops in this driver.

+microcode-build-fix.patch

 Microcode compile fix

+early-serial-registration-fix.patch

 Fix crashes with early printk console registration.

+mtd-warning-fixes.patch

 Fix a couple of warnings.

+early_serial_setup-range-check.patch

 Another early printk fix.

+elf-verify-interpreter-arch.patch

 Additional checks when loading ELF interpreters.

+journal_write_metadata_buffer-kfree-fix.patch

 Fix kfree of an incorrect address.

+jbd-leak-fix.patch

 Fix ext3 memory leak.

+kmem_freepages-BUG-fix.patch

 Fix a BUG which can strike in slab.

+register_cpu-fix.patch

 Dunno what this does really.  Someone want to send me a decent changelog
 for once?

+elv-select.patch

 Runtime selectable I/O schedulers.

+elv-init-cleanup.patch

 Elevator initialisation cleanups.

+bluetooth-no-procfs-fix.patch

 Fix bluetooth compile with CONFIG_PROCFS=n

+gcc-Os.patch

 Compile with -Os

+printk-handle-bad-pointers.patch

 Make printk kinder when passed nearly-NULL pointers.

+kcapi-build-fix.patch

 ISDN compile fix

+drm-module_init-retval-fix.patch

 Fix an error code.

+parport_pc-resource-release-fix.patch

 Fix an oopsable resource leak in parport_pc.

+3c527-smp-update.patch

 Update this driver, make it work on SMP.

+3c527-module-license.patch

 It is GPLed.

+no-mca-oops-fix.patch
+mca_find_unused_adapter-oops-fix.patch

 Fix a couple of oopses when running CONFIG_MCA kernels on non-MCA hardware.

+register_netdevice-retval-fix.patch

 Fix error code propagation.

+ext3-latency-fix.patch

 Improved scheduling latency in ext3.

+ipc-msg-race-fix.patch

 Fix oopsable race in SVSV IPC message tx/rx.

+iosched-oops-fixes.patch

 Fix use-uninitialised in the deadline and AS I/O schedulers.

+pcm_native-deadlock-fix.patch

 Fix a deadlock in the sound drivers.

+4g4g-wp-test-fix.patch

 Fix a crash when doing the early WP detect with the 4g/4g split enabled.

+O_DIRECT-race-fixes-rework-XFS-fix-fix.patch

 EXPORT_SYMBOL() fix.





All 178 patches:

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

vma-split-truncate-race-fix-2.patch
  fix split_vma vs. invalidate_mmap_range_list race

devfs-initrd-fix.patch
  Fix initrd with devfs enabled

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

sym-do-160.patch
  make the SYM driver do 160 MB/sec

input-use-after-free-checks.patch
  input layer debug checks

fbdev.patch
  framebbuffer driver update

fbdev-restore-pci-ids.patch

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

uml-update.patch
  Update UML to 2.6.0-test5

pdflush-diag.patch

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

futex-uninlinings.patch
  futex uninlining

zap_page_range-debug.patch
  zap_page_range() debug

acpi-thinkpad-fix.patch
  APCI fix for thinkpads

scsi-handle-zero-length-requests.patch
  scsi: handle zero-length requests

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

limit_regions-syncup.patch
  ia32 limit_regions update

dynamic-irq_vector-allocation.patch
  dynamic irq_vector allocation for ia32

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

support-zillions-of-scsi-disks.patch
  support many SCSI disks

SGI-IOC4-IDE-chipset-support.patch
  Add support for SGI's IOC4 chipset

sparc32-sched_clock.patch

unmap_vmas-warning-fix.patch
  Fix unmap_vmas() compile warning

pcibios_test_irq-fix.patch
  Fix pcibios test IRQ handler return

fixmap-in-proc-pid-maps.patch
  report user-readable fixmap area in /proc/PID/maps

ajdtimex-vs-gettimeofday.patch
  Time precision, adjtime(x) vs. gettimeofday

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

atp870u-oops-fix.patch
  atp870u oops fix

sym-2.1.18f.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

nosysfs.patch

tmpfs-01-ENAMETOOLONG.patch
  tmpfs 1/7 LTP ENAMETOOLONG

tmpfs-02-gid-fix.patch
  tmpfs 2/7 LTP S_ISGID dir

tmpfs-03-swapoff-truncate-race.patch
  tmpfs 3/7 swapoff/truncate race

tmpfs-04-getpage-truncate-race.patch
  tmpfs 4/7 getpage/truncate race

tmpfs-05-writepage-truncate-race.patch
  tmpfs 5/7 writepage/truncate race

tmpfs-06-i_size_write.patch
  tmpfs 6/7 write i_size_write

tmpfs-07-write-mark_page_accessed.patch
  tmpfs 7/7 write mark_page_accessed

quota-locking-fix.patch
  Quota locking fix

export-system_running.patch
  export system_running to other files

might_sleep-early-bogons.patch
  Kill early might_sleep warnings

constant_test_bit-doesnt-like-zwanes-gcc.patch
  gcc bug workaround for constant_test_bit()

slab-leak-detector.patch
  slab leak detector

slab-leak-detector-tweaks.patch

digi_accelport-oops-fix.patch
  digi_acceleport.c has bogus "address of" operator

microcode-build-fix.patch
  fix microcode.c for older gcc's

early-serial-registration-fix.patch
  serial console registration bugfix

mtd-warning-fixes.patch
  Fix mtd printk warnings

early_serial_setup-range-check.patch
  early_serial_setup array bounds check

elf-verify-interpreter-arch.patch
  fs/binfmt_elf.c:load_elf_binary() doesn't verify interpreter  arch

journal_write_metadata_buffer-kfree-fix.patch
  JBD kfree() fix

jbd-leak-fix.patch
  Fix JBD memory leak

kmem_freepages-BUG-fix.patch
  fix low-memory BUG in slab

register_cpu-fix.patch
  Subject: [PATCH] fix for register_cpu()

elv-select.patch
  disk scheduler selection

elv-init-cleanup.patch
  elv_init cleanup

bluetooth-no-procfs-fix.patch
  fix bluetooh broken compilation when PROC_FS=n.

gcc-Os.patch
  Use -Os for compilation

printk-handle-bad-pointers.patch
  make printk more robust with "null" pointers

kcapi-build-fix.patch
  kcapi.c CONFIG_MODULES=n build fix

drm-module_init-retval-fix.patch
  DRM modprobe retval fix

parport_pc-resource-release-fix.patch
  parport_pc not releasing all ioports

3c527-smp-update.patch
  SMP support on 3c527 net driver

3c527-module-license.patch
  Add 3c527 module license.

no-mca-oops-fix.patch
  Fix oops with CONFIG_MCA=y

mca_find_unused_adapter-oops-fix.patch
  Fix another CONFIG_MCA=y oops

register_netdevice-retval-fix.patch
  register_netdevice return val fix

ext3-latency-fix.patch
  ext3 scheduling latency fix

ipc-msg-race-fix.patch
  ipc msg race fix

iosched-oops-fixes.patch
  io scheduler oops fixes

pcm_native-deadlock-fix.patch
  pcm_native locking fix

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



