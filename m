Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUFCI5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUFCI5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUFCI5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:57:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:49115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261976AbUFCIyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:54:38 -0400
Date: Thu, 3 Jun 2004 01:53:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-mm2
Message-Id: <20040603015356.709813e9.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6.7-rc2-mm2/


- Huge update to the SiS framebuffer driver.  Please test.

- As soon as I merged Andrey's big dmi cleanup patches everyone started
  madly patching dmi_scan.c.  The subsequent reject storm forced me to drop
  them.

- Big devicemapper update - new feature work.

- Various fixes, some quite serious.


Changes since 2.6.7-rc2-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi.patch
 bk-usb.patch

 External trees.

-for-radeonfb-non-8bpp-clear-doesnt-use-palette.patch
-s2io-section-fix.patch
-ppc32-reorg-dma-api-add-coherent-alloc-in-irq.patch
-ppc64-iseries-default-config-update.patch
-ppc64-iseries-virtual-ethernet-minor-optimisation.patch
-ppc64-iseries-fix-virtual-ethernet-transmit-block.patch
-ppc64-add-eeh_add_device_early-late.patch
-ppc64-reset-iseries-progress-indicator-on-boot.patch
-ppc64-bolt-first-vmalloc-segment-into-slb.patch
-ppc64-slb-accounting-fix.patch
-ppc64-iseries-bolted-slb-fix.patch
-ppc64-fix-missing-relocs-add-linuxphandle-property.patch
-add-futex_cmp_requeue-futex-op.patch
-new-radeonfb-powerdown-doesnt-work.patch
-r8169-ethtool-set_settings.patch
-r8169-ethtool-get_settings-link.patch
-r8169-link-handling-and-phy-reset-rework.patch
-r8169-initial-link-setup-rework.patch
-add-support-for-isd-300-usb-controller.patch
-nuke-has_ip_copysum-for-net-drivers.patch
-make-proliant-8500-boot-with-26.patch
-prism54-add-new-private-ioctls.patch
-prism54-reset-card-on-tx_timeout.patch
-prism54-add-iwspy-support.patch
-prism54-add-support-for-avs-header-in.patch
-prism54-new-prism54-kernel-compatibility.patch
-prism54-fix-prism54org-bugs-74-75.patch
-prism54-fix-24-build.patch
-prism54-fix-prism54org-bugs-39-73.patch
-prism54-fix-prism54org-bug-77-strengthened-oid-transaction.patch
-prism54-dont-allow-mib-reads-while-unconfigured.patch
-prism54-touched-up-kernel-compatibility.patch
-prism54-start-using-likely-unlikely.patch
-prism54-fix-24-smp-build.patch
-prism54-fix-channel-stats-bump-to-12.patch
-mark-cache_names-__initdata.patch
-support-for-sc1100-in-linux-kernel.patch
-missing-pop-off-in-arch-i386-kernel-acpi-wakeups.patch
-mdc-message-during-quiet-boot.patch
-posix_mqueue-depends-on-net.patch
-security_selinux-depends-on-net.patch
-pnpbios-only-makes-sense-for-x86.patch
-agp-resume-fixups.patch
-document-checkstacks.patch
-add-watchdog-timer-to-iseries_veth-driver.patch
-vram-boot-option.patch
-s-tkill-tgkill-in--documentation.patch
-linux-timerh-needs-linux-stddefh.patch
-fix-mca-procfs-stub.patch
-fix-net-ixgb-ixgb_mainc-warning.patch
-fix-readahead-handling-in-knfsd.patch
-i386-bitops-memory-clobbers.patch
-sched-remove-noinline-workaround.patch
-checkstack-fixes.patch
-cpqarray-sa_sample_random.patch
-add-const-to-some-scheduling-functions.patch
-use-aio-workqueue-in-fs-aioc.patch
-correct-use_mm-unuse_mm-to-use-task_lock-to-protect-mm.patch
-cris-architecture-update.patch

 Merged

-nmi-trigger-switch-support-for-debugging.patch

 Dropped - was causing various build problems.

+hiddev-warning-fixes.patch

 Build fix

+bk-input-build-fix.patch

 Build fix

+kgdb-ia64-fixes.patch

 Fixes for the ia64 kgdb stub

+ramfs-o_sync-oops-fix.patch

 Fix oops due to O_SYNC writes to ramfs

+direct-io-invalidation-fix.patch

 Fix direct-io fs corruption

+mm-swapper_spacei_mmap_nonlinear.patch
+mm-follow_page-invalid-pte_page.patch
+mm-vma_adjust-adjust_next-wrap.patch
+mm-vma_adjust-insert-file-earlier.patch
+mm-get_user_pages-vs-try_to_unmap.patch
+mm-kill-missed-pte-warning.patch
+mm-flush-tlb-when-clearing-young.patch
+mm-pretest-pte_young-and-pte_dirty.patch

 memory management updatelets

+ppc32-add-indirect-dcr-access-pass-2.patch
+ppc64-kernel-makefile-options-for-as.patch
+ppc64-update-info-about-available-iseries_veth-interfaces.patch
+ppc64-gives-up-too-quickly-on-hotplugged-cpu.patch

 ppc updates

-logitech-keyboard-fix.patch

 Dropped, might be fixed by other means

-add-qsort-library-function.patch

 Dropped - the XFS part of this got lost.

+hpet-dont-use-new-major.patch

 Use a miscdevice for the HPET driver - don't require a new major.

-ppc64-fault-deadlock-fix.patch
-ia32-fault-deadlock-fix.patch
-ia32-fault-deadlock-fix-cleanup.patch
+ia32-fault-deadlock-fix-2.patch
+ppc64-fault-deadlock-fix-2.patch

 Reworked

+kernel-parameter-parsing-fix-fix.patch

 Keep on plugging at the kernel-parameter parsing code.

+3ware-9000-driver-update-for-267-rc2-mm2.patch

 Update the 3ware SATA raid driver

-dmi-simplify-dmi-matching-data.patch
-dmi-export-dmi-probe-function.patch
-dmi-codingstyle-and-whitespace-cleanups.patch
-dmi-port-sonypi-driver-to-new-dmi-probing.patch
-dmi-port-apm-bios-driver-to-new-dmi-probing.patch
-dmi-port-hp-pavilion-irq-routing-quirk-to-new-dmi-probing.patch
-dmi-port-piix4-i2c-driver-to-new-dmi-probing.patch
-dmi-port-pnp-bios-driver-to-new-dmi-probing.patch
-dmi-port-acpi-boot-code-to-new-dmi-probing.patch
-dmi-port-reboot-related-quirks-to-new-dmi-probing.patch
-dmi-port-powernow-k7-driver-to-new-dmi-probing.patch
-dmi-port-local-apic-quirks-to-new-dmi-probing.patch
-dmi-port-acpi-sleep-quirk-to-new-dmi-probing.patch
-dmi-port-i8042-quirk-to-new-dmi-probing.patch

 Dropped - these kept on breaking.

+bsd-acct-warning-fix.patch

 Fix warning in the BSD accounting patch

+iso9660-inodes-beyond-4gb-fixes.patch
+iso9660-comment-cleanup.patch

 Updates to iso9660-inodes-beyond-4gb.patch

+perfctr-disabled-build-fix.patch

 Build fix

+sisfb-update-1710.patch

 SiS framebuffer driver update

+nfs-writepage-fix.patch

 Fix oom lockups due to nfs writeback of mmapped data

+selinux-check-processed-security-context-length.patch

 SELinux fix

+floppy-fix.patch

 Fix /dev/fd1 handling

+balance-on-exec-fix.patch

 scheduler optimisation

+3c59x-support-for-ati-radeon-9100-igp.patch

 Add support for the 3c59x controller in an ATI Radeon card.

+fix-loop-device-cache-handling.patch

 Add a missing dcache flush.

+fix-possible-null-pointer-in-fs-ext3-superc.patch

 Error handling fix

+dm_remove_all32.patch

 Add missing DM ioctl conversion.

+ide-dont-put-disks-in-standby-mode-on-halt-on-alpha.patch
+ide-fix-for-generic-ide-pci-module.patch
+ide-ide_pci_device_t-sanitization.patch
+ide-merge-amd74xxh-into-amd74xxc.patch
+ide-add-new-nforce-ide-sata-device-ids-to-amd74xxc.patch
+ide-use-generic-ide_init_hwif_ports-on-m68k.patch
+ide-use-asm-i386-ideh-as-asm-x86_64-ideh.patch
+ide-add-ide_arch_obsolete_defaults.patch
+ide-remove-useless-proc-ide-siimage-from-siimagec.patch
+ide-simplify-config_idedma_onlydisk-logic-a-bit.patch

 IDE update

+mm-oom_killc-trivial-cleanup.patch

 Remove duplicated assignment.

+use-const-in-timeh-unit-conversion-functions.patch
+fix-io_getevents-timer-expiry-setting.patch

 AIO fixes

+move-endif-to-correct-place.patch

 Fixlet in kernel/signal.c

+hugetlb-msync-fix.patch

 Fix msync() on hugetlb mappings

+nx-267-rc2-bk2-ae.patch
+nx-267-rc2-bk2-ae-warning-fix.patch

 ia32 no-execute support

+hugetlb-dtor-reinit.patch

 hugetlbpage fix

+mtd-jedec-probe-additions.patch

 Add JEDEC probe functions to MTD.

+use-kern_alert-more-for-oopses.patch

 Fix printk facility levels

+s390-1-4-core-s390.patch
+s390-2-4-common-i-o-layer.patch
+s390-3-4-block-device-driver.patch
+s390-4-4-network-device-driver.patch

 s390 update

+quota-fix-writing-of-quota-info.patch
+fix-for-old-quota-format.patch

 Quota fixes

+1-5-device-mapper-dm-ioc.patch
+dm-cache-flushing-fix.patch
+2-5-device-mapper-kcopyd.patch
+2-5-device-mapper-kcopyd-docs.patch
+3-5-device-mapper-snapshots.patch
+4-5-device-mapper-mirroring.patch
+5-5-device-mapper-dm-zero.patch
+dm-zero-flushing-fix.patch

 device mapper update

+let-serial_8250_acpi-depend-on-acpi_pci-2.patch

 config dependency fix

+export-acpi_register_gsi.patch

 Linkage fix

+kill-off-efi_dir-in-efih.patch

 Remove unneeded stuff

+update-elilo-loader-location-in-kconfig.patch

 Documentation update

+ext3_orphan_del-may-double-decrement-bh-b_count.patch

 Fix error-path double-brelse in ext3

+submission-of-via-velocitytm-series-adapter-driver.patch
+via-velocity-oops-fix.patch

 New VIA net driver

+use-c99-struct-initializer-in-hotcpu_notifier.patch

 Cleanup

+better-names-for-edd-legacy_-fields.patch

 use better identifiers

+use-decimal-instead-of-hex-for-edd-values.patch

 EDD driver cleanup

+eep-lost-24-change-for-buslogic-info.patch

 Documentation update

+fb-accel-capabilities.patch

 Use fbdev acceleration for fb consoles

+rawdev-driver.patch

 A driver which allows userspace to access the raw ps2 data stream.

+sys_io_setup-fix.patch

 AIO fix

+fix-sys-cpumap-for-352-nr_cpus.patch

 Fix sysfs output truncation for massive SMP machines.





All 301 patches:


linus.patch

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

hiddev-warning-fixes.patch
  hiddev warning fixes

bk-input-build-fix.patch
  bk-input-build-fix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb

kgdb-in-sched_functions.patch

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-in-sched_functions-x86_64.patch

kgdb-ia64-support.patch
  IA64 kgdb support

kgdb-ia64-fixes.patch
  ia64 kgdb repair and cleanup

ramfs-o_sync-oops-fix.patch
  ramfs o_sync oops fix

direct-io-invalidation-fix.patch
  direct-io invalidation fix

mp_find_ioapic-oops-fix.patch
  mp_find_ioapic cannot be __init

shrink_all_memory-fix.patch
  shrink_all_memory() fixes

mm-swapper_spacei_mmap_nonlinear.patch
  mm: swapper_space.i_mmap_nonlinear

mm-follow_page-invalid-pte_page.patch
  mm: follow_page invalid pte_page

mm-vma_adjust-adjust_next-wrap.patch
  mm: vma_adjust adjust_next wrap

mm-vma_adjust-insert-file-earlier.patch
  mm: vma_adjust insert file earlier

mm-get_user_pages-vs-try_to_unmap.patch
  mm: get_user_pages vs. try_to_unmap

mm-kill-missed-pte-warning.patch
  mm: kill missed pte warning

mm-flush-tlb-when-clearing-young.patch
  mm: flush TLB when clearing young

mm-pretest-pte_young-and-pte_dirty.patch
  mm: pretest pte_young and pte_dirty

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

radix_tree_tag_set-atomic.patch
  Make radix_tree_tag_set/clear atomic wrt the tag

radix_tree_tag_set-only-needs-read_lock.patch
  radix_tree_tag_set only needs read_lock()

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

mustfix-lists.patch
  mustfix lists

ppc32-add-indirect-dcr-access-pass-2.patch
  ppc32: add "indirect" DCR access, pass 2

ppc64-kernel-makefile-options-for-as.patch
  ppc64: kernel Makefile options for $(AS)

ppc64-update-info-about-available-iseries_veth-interfaces.patch
  ppc64: update info about available iseries_veth interfaces

ppc64-gives-up-too-quickly-on-hotplugged-cpu.patch
  ppc64 gives up too quickly on hotplugged cpu

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

schedstats.patch
  sched: scheduler statistics

cond_resched-might-sleep.patch
  cond_resched() might sleep

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-reservation-ifdef-cleanup-patch.patch
  ext3 reservation ifdef cleanup patch

ext3-reservation-max-window-size-check-patch.patch
  ext3 reservation max window size check patch

ext3-reservation-file-ioctl-fix.patch
  ext3 reservation file ioctl fix

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard

ext3-reservation-bad-inode-fix.patch
  ext3 reservations: bad_inode fix

ext3_reservation_discard_race_fix.patch
  ext3 reservation discard race fix

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

reiserfs-group-alloc-9.patch
  reiserfs: block allocator optimizations

reiserfs-block-allocator-should-not-inherit-packing-locality.patch
  reiserfs: block allocator should not inherit "packing locality 1"

reiserfs-remove-debugging-warning-from-block-allocator.patch
  reiserfs: remove debugging warning from block allocator

reiserfs-group-alloc-9-build-fix.patch
  reiserfs-group-alloc-9 build fix

reiserfs-search_reada-5.patch
  reiserfs: btree readahead

reiserfs-data-logging-support.patch
  reiserfs data logging support

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

idr-overflow-fixes.patch
  Fixes for idr code

idr-remove-counter.patch
  idr: remove counter bits from id's

idr-fixups.patch
  IDR fixups

use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch
  use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api

rlim-add-rlimit-entry-for-controlling-queued-signals.patch
  RLIM: add rlimit entry for controlling queued signals

rlim-add-sigpending-field-to-user_struct.patch
  RLIM: add sigpending field to user_struct

rlim-pass-task_struct-in-send_signal.patch
  RLIM: pass task_struct in send_signal()

rlim-add-simple-get_uid-helper.patch
  RLIM: add simple get_uid() helper

rlim-enforce-rlimits-on-queued-signals.patch
  RLIM: enforce rlimits on queued signals

rlim-remove-unused-queued_signals-global-accounting.patch
  RLIM: remove unused queued_signals global accounting

rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
  RLIM: add rlimit entry for POSIX mqueue allocation

rlim-add-mq_bytes-to-user_struct.patch
  RLIM: add mq_bytes to user_struct

rlim-add-mq_attr_ok-helper.patch
  RLIM: add mq_attr_ok() helper

rlim-enforce-rlimits-for-posix-mqueue-allocation.patch
  RLIM: enforce rlimits for POSIX mqueue allocation

rlim-adjust-default-mqueue-sizes.patch
  RLIM: adjust default mqueue sizes

call-might_sleep-in-tasklet_kill.patch
  Call might_sleep() in tasklet_kill

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

abs-cleanup.patch
  abs() cleanup

add-i386-readq.patch
  add i386 readq()/writeq()

hpet-driver.patch
  HPET driver

hpet-dont-use-new-major.patch
  hpet: don't require a new major

hpet-driver-updates.patch
  HPET driver updates

hpet-driver-updates-move-readq.patch
  hpet-driver-updates-move-readq

hpet-kconfig-loop-fix.patch
  HPET: Fix Kconfig dependency loop

hpet-rtc-dependency-fix.patch
  HPET RTC dependency fix

hpet-free_irq-deadlock-fix.patch
  hpet-free_irq-deadlock-fix

kill-off-pc9800.patch
  Remove PC9800 support

more-pc9800-removal.patch
  more PC9800 removal

pc9800-merge-std_resourcesc-back-into-setupc.patch
  pc9800: merge std_resources.c back into setup.c

ftruncate-vs-block_write_full_page.patch
  ftruncate-vs-block_write_full_page

ext3-retry-allocation-after-transaction-commit-v2.patch
  Ext3: Retry allocation after transaction commit (v2)

ext3-retry-allocation-after-transaction-commit-v2-jbd-api.patch
  ext3-retry-allocation-after-transaction-commit-v2: implement JBD API

sysfs-leaves-mount.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-dir.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-file.patch
  sysfs backing store: sysfs_create() changes

sysfs-leaves-bin.patch
  sysfs backing store: bin attribute changes

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups and misc routines

pty-allocation-first-fit.patch
  Use first-fit for pty allocation

dynpty-fix.patch
  dynamic pty allocation fixes

sync_inodes_sb-debug.patch
  sync_inodes_sb-debug

vmscan-handle-synchronous-writepage.patch
  vmscan: handle synchronous writepage()

vmscan-handle-synchronous-writepage-fix.patch
  vmscan-handle-synchronous-writepage-fix

ramdisk-buffer-uptodate-fix.patch
  ramdisk: buffer_uptodate fix

2-3-small-tweaks-to-standard-resource-stuff.patch
  small tweaks to standard resource stuff

3-3-same-small-tweaks-x86_64-version.patch
  same small resource tweaks, x86_64 version

sis900-fix-phy-transceiver-detection.patch
  sis900: Fix PHY transceiver detection

getgroups16-fix.patch
  getgroups16() fix

ia32-fault-deadlock-fix-2.patch
  ia32: fix deadlocks when oopsing while mmap_sem is held

ppc64-fault-deadlock-fix-2.patch
  ppc64: fix deadlocks when oopsing while mmap_sem is held

ext3-htree-rename-fix.patch
  ext3: htree rename fix

advansys-basic-highmem-dma-support.patch
  advansys: add basic highmem/DMA support

SL0-core-RC6-bk5.patch
  symlinks: infrastructure

SL1-ext2-RC6-bk5.patch
  symlinks: ext2 conversion

SL2-trivial-RC6-bk5.patch
  symlinks: trivial cases

SL3-page-RC6-bk5.patch
  symlinks: reuse new helpers

SL4-smb-RC6-bk5.patch
  symlinks: smbfs

SL5-xfs-RC6-bk5.patch
  symlinks: XFS

SL6-shm-RC6-bk5.patch
  symlinks: tmpfs

SL7-befs-RC6-bk5.patch
  symlinks: befs

SL8-jffs2-RC6-bk5.patch
  symlinks: jffs2

ipr-ppc64-depends.patch
  Make ipr.c require ppc

disk-barrier-core.patch
  disk barriers: core

disk-barrier-core-tweaks.patch
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE

disk-barrier-ide-symbol-expoprt.patch
  disk-barrier-ide-symbol-expoprt

disk-barrier-ide-warning-fix.patch
  disk-barrier ide warning fix

barrier-update.patch
  barrier update

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support

reiserfs-v3-barrier-support-tweak.patch
  reiserfs-v3-barrier-support-tweak

ext3-barrier-support.patch
  ext3 barrier support

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

jbd-barrier-fallback-on-failure-fix.patch

x86-stack-dump-fixes.patch
  x86 stack dump fixes

check-return-status-of-register-calls-in-i82365.patch
  Check return status of register calls in i82365

invalidate_inodes2-mark-pages-notuptodate.patch
  invalidate_inodes2(): mark pages not uptodate

reduce-tlb-flushing-during-process-migration.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-oops-fix.patch
  reduce-tlb-flushing-during-process-migration oops fix

kernel-parameter-parsing-fix.patch
  Kernel parameter parsing fix

kernel-parameter-parsing-fix-fix.patch
  kernel-parameter-parsing-fix fix

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c
  arch/i386/boot/compressed/misc.c warning fixes

reiserfs-v3-logging-bug-for-blocksize-page-size.patch
  reiserfs v3 logging bug for blocksize < page size

partition-table-validity-checking.patch
  partition table validity checking

read-vs-truncate-race.patch
  Fix read() vs truncate race

tulip-driver-deadlocks-on-device-removal.patch
  Fix tulip deadlocks on device removal

rcu-lock-update-add-per-cpu-batch-counter.patch
  rcu lock update: Add per-cpu batch counter

rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
  rcu lock update: Use a sequence lock for starting batches

rcu-lock-update-code-move-cleanup.patch
  rcu lock update: Code move & cleanup

3ware-9000-sata-raid-1.patch
  3ware 9000 SATA-RAID driver v2.26.00.009 (1)

3ware-9000-sata-raid-2.patch
  3ware 9000 SATA-RAID driver v2.26.00.009 (2)

3ware-9000-driver-update-for-267-rc2-mm2.patch
  3ware 9000 driver update

pcm_native-stack-reduction.patch
  pcm_native.c stack reduction

cleanups-for-apic.patch
  io_apic.c code consolidation

remove-apic_lockup_debug.patch
  x86: remove APIC_LOCKUP_DEBUG

remove-io_apic_sync.patch
  x86: remove io_apic_sync

vmscan-GFP_NOFS-try-harder.patch
  vmscan-GFP_NOFS-try-harder

ach1542-mca-build-fix.patch
  ahc1542 !CONFIG_MCA build fix

validate-pm-timer-rate-at-boot-time.patch
  Validate PM-Timer rate at boot time

knfsd-1-of-11-fix-nfs3-dentry-encoding.patch
  kNFSd: Fix nfs3 dentry encoding

knfsd-2-of-11-nfsd_exp_remove_null_checkpatch.patch
  kNFSd: exp_find(): remove null pointer check

knfsd-3-of-11-nfsd_acceptable_typopatch.patch
  kNFSd: nfsd_acceptable() typo fix

knfsd-4-of-11-nfsd_xdr_name_encodingpatch.patch
  kNFSd: nfsd4 xdr name encoding improvements

knfsd-5-of-11-gss_svc_module_refpatch.patch
  kNFSd: gss_svc locking and refcounting fixes

knfsd-5-of-11-gss_svc_module_refpatch-fix.patch
  knfsd-5-of-11-gss_svc_module_refpatch-fix

knfsd-5-of-11-gss_svc_module_refpatch-fix2.patch
  gss_svc_module_ref typo fix

knfsd-6-of-11-nfsd_gss_rsc_lookup_freepatch.patch
  kNFSd: rsc_lookup simplification

knfsd-7-of-11-nfsd-releaselkownerpatch.patch
  kNFSd: nfsd4_release_lockowner() oops fix

knfsd-8-of-11-nfsd-getattr-fixpatch.patch
  kNFSd: nfsd getattr fix

knfsd-9-of-11-nfsd-setclientid-fixpatch.patch
  kNFSd: nfsd4 setclientid fix

knfsd-10-of-11-nfsd-create-fixpatch.patch
  kNFSd: nfsd4 file creation fix

knfsd-11-of-11-exporting_doc_typospatch.patch
  kNFSd: documentation typo fixes

md-1-of-8-rationalise-device-selection-in-md-multipath.patch
  md: rationalise device selection in md/multipath.

md-2-of-8-make-sure-md_check_recovery-will-remove-a-faulty-device-when-nr_pending-hits-0.patch
  md: make sure md_check_recovery will remove a faulty device when ->nr_pending hits 0

md-3-of-8-allow-an-md-personality-to-refuse-a-hot-remove-request.patch
  md: allow an md personality to refuse a hot-remove request.

md-4-of-8-make-sure-the-size-of-a-raid5-6-array-is-a-multiple-of-the-chunk-size.patch
  md: make sure the size of a raid5/6 array is a multiple of the chunk size.

md-5-of-8-handle-hot-add-for-arrays-with-non-persistent-superblocks.patch
  md: handle hot-add for arrays with non-persistent superblocks

md-6-of-8-abort-the-resync-of-raid1-there-is-only-one-device.patch
  md: abort the resync of raid1 there is only one device.

md-7-of-8-allow-md-arrays-to-be-resized-if-devices-are-large-enough.patch
  md: allow md arrays to be resized if devices are large enough.

md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives.patch
  md: support reshaping raid1 arrays - adding or removing drives.

md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives-fix.patch
  md 8-of-8 fix

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

fix-3c59xc-to-allow-3c905c-100bt-fd.patch
  fix 3c59x.c to allow 3c905c 100bT-FD

tty_io-hangup-locking.patch
  tty_io.c hangup locking

vmscanc-move-writepage-invocation-into-its-own-function.patch
  vmscan.c: move ->writepage invocation into its own function

vmscanc-struct-scan_control.patch
  vmscan.c: struct scan_control

first-cut-at-fixing-the-3c59x-power-mismanagment.patch
  First cut at fixing the 3c59x power mismanagment

kbuild-specify-default-target-during-configuration.patch
  kbuild: Specify default target during configuration

runtime-selection-of-config_paride_epatc8.patch
  runtime selection of CONFIG_PARIDE_EPATC8

bsd-accounting-format-rework.patch
  BSD accounting format rework

bsd-acct-warning-fix.patch
  bsd-acct-warning-fix

iso9660-inodes-beyond-4gb.patch
  iso9660: fix handling of inodes beyond 4GB

iso9660-inodes-beyond-4gb-fixes.patch
  iso9660-inodes-beyond-4gb-fixes

iso9660-comment-cleanup.patch
  iso9660: comment cleanup

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core

perfctr-disabled-build-fix.patch
  CONFIG_PERFCTR=n build fix

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters

perfctr-misc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

reference_init.patch
  Add reference_init.pl to `make buildcheck' target

sisfb-update-1710.patch
  sisfb update 1.7.10

nfs-writepage-fix.patch
  Fix nfs writepage behaviour

selinux-check-processed-security-context-length.patch
  selinux: check processed security context length

floppy-fix.patch
  floppy minor number fix

balance-on-exec-fix.patch
  sched: balance-on-exec fix

3c59x-support-for-ati-radeon-9100-igp.patch
  3c59x: support for ATI Radeon 9100 IGP

fix-loop-device-cache-handling.patch
  Fix loop device cache handling

fix-possible-null-pointer-in-fs-ext3-superc.patch
  fix possible NULL pointer in fs/ext3/super.c.

dm_remove_all32.patch
  dm: add DM_REMOVE_ALL_32 compat ioctl

ide-dont-put-disks-in-standby-mode-on-halt-on-alpha.patch
  ide: don't put disks in standby mode on halt on Alpha

ide-fix-for-generic-ide-pci-module.patch
  ide: fix for generic IDE PCI module

ide-ide_pci_device_t-sanitization.patch
  ide: ide_pci_device_t sanitization

ide-merge-amd74xxh-into-amd74xxc.patch
  ide: merge amd74xx.h into amd74xx.c

ide-add-new-nforce-ide-sata-device-ids-to-amd74xxc.patch
  ide: add new nForce IDE/SATA device IDs to amd74xx.c

ide-use-generic-ide_init_hwif_ports-on-m68k.patch
  ide: use generic ide_init_hwif_ports() on m68k

ide-use-asm-i386-ideh-as-asm-x86_64-ideh.patch
  ide: use <asm-i386/ide.h> as <asm-x86_64/ide.h>

ide-add-ide_arch_obsolete_defaults.patch
  ide: add IDE_ARCH_OBSOLETE_DEFAULTS

ide-remove-useless-proc-ide-siimage-from-siimagec.patch
  ide: remove useless /proc/ide/siimage from siimage.c

ide-simplify-config_idedma_onlydisk-logic-a-bit.patch
  ide: simplify CONFIG_IDEDMA_ONLYDISK logic a bit

mm-oom_killc-trivial-cleanup.patch
  mm/oom_kill.c trivial cleanup

use-const-in-timeh-unit-conversion-functions.patch
  use const in time.h unit conversion functions

fix-io_getevents-timer-expiry-setting.patch
  aio: fix io_getevents() timer expiry setting

move-endif-to-correct-place.patch
  move #endif to correct place

hugetlb-msync-fix.patch
  hugetlbpage msync() fix

direct-io-hole-fix.patch
  direct-io hole fix

nx-267-rc2-bk2-ae.patch
  NX (No eXecute) support for x86

nx-267-rc2-bk2-ae-warning-fix.patch
  nx-267-rc2-bk2-ae-warning-fix

hugetlb-dtor-reinit.patch
  hugetlbpage: reinitialise compound page destructor

mtd-jedec-probe-additions.patch
  MTD: add st m50fw0* to jedec_probe.c

use-kern_alert-more-for-oopses.patch
  Use KERN_ALERT more for oopses

s390-1-4-core-s390.patch
  s390: core

s390-2-4-common-i-o-layer.patch
  s390: common i/o layer

s390-3-4-block-device-driver.patch
  s390: block device driver

s390-4-4-network-device-driver.patch
  s390: network device driver

quota-fix-writing-of-quota-info.patch
  quota: fix writing of quota info

fix-for-old-quota-format.patch
  quota: fix for old quota format

1-5-device-mapper-dm-ioc.patch
  dm-io: device-mapper i/o library for kcopyd

dm-cache-flushing-fix.patch
  dm: cache flushing fix

2-5-device-mapper-kcopyd.patch
  Device-mapper: kcopyd

2-5-device-mapper-kcopyd-docs.patch
  kcopyd commentary

3-5-device-mapper-snapshots.patch
  Device-mapper: snapshots

4-5-device-mapper-mirroring.patch
  Device-mapper: mirroring

5-5-device-mapper-dm-zero.patch
  Device-mapper: dm-zero

dm-zero-flushing-fix.patch
  Device-mapper: dm-zero flushing fix

let-serial_8250_acpi-depend-on-acpi_pci-2.patch
  let SERIAL_8250_ACPI depend on ACPI_PCI

export-acpi_register_gsi.patch
  export acpi_register_gsi()

kill-off-efi_dir-in-efih.patch
  kill off efi_dir in efi.h

update-elilo-loader-location-in-kconfig.patch
  update elilo loader location in Kconfig

ext3_orphan_del-may-double-decrement-bh-b_count.patch
  ext3_orphan_del may double-decrement bh->b_count

submission-of-via-velocitytm-series-adapter-driver.patch
  Via "velocity(tm)" series adapter driver

via-velocity-oops-fix.patch
  via-velocity oops fix

use-c99-struct-initializer-in-hotcpu_notifier.patch
  use c99 struct initializer in hotcpu_notifier

better-names-for-edd-legacy_-fields.patch
  Better names for EDD legacy_* fields

use-decimal-instead-of-hex-for-edd-values.patch
  Use decimal instead of hex for EDD values

eep-lost-24-change-for-buslogic-info.patch
  Lost 2.4 change for BusLogic info

fb-accel-capabilities.patch
  fb accel capabilities

rawdev-driver.patch
  input: raw access to serio ports (1/2)

sys_io_setup-fix.patch
  bug in sys_io_setup

fix-sys-cpumap-for-352-nr_cpus.patch
  fix sysfs node cpumap for large NR_CPUS



