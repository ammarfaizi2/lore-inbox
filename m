Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUFUAth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUFUAth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 20:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUFUAth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 20:49:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:46565 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265544AbUFUAr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 20:47:26 -0400
Date: Sun, 20 Jun 2004 17:46:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm1
Message-Id: <20040620174632.74e08e09.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/


- Added a new vm tunable: /proc/sys/vm/vfs-cache-pressure.

  This allows tuning of the kernel's preference for reclaiming VFS caches
  versus pagecache.

  vfs-cache-pressure=0: dentry and inode caches aren't reclaimed at all
  vfs-cache-pressure=100: default - current behaviour
  vfs-cache-pressure > 100: reclaim the VFS caches harder.

  It seems that large values of vfs-cache-pressure are needed to make much
  difference: 1000 or more.

- Under some circumstances the current page reclaim code can hold
  interrupts off for a long time.  That is fixed here.

- I went through and dropped a bunch of patches which don't seem to be very
  useful now - mainly debug stuff.

- Various driver updates and random fixes


Changes since 2.6.7-rc3-mm2:


 linus.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cpufreq.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-scsi.patch

 External trees.  bk-driver-core is in disgrace due to rejects against
 bk-scsi.

-mp_find_ioapic-must-not-be-__init.patch
-prism94-build-fix.patch
-mp_find_ioapic-oops-fix.patch
-85xx+e500.l26-20040608.patch
-ppc32-irqc-cpumask-fix.patch
-ppc64-fix-out_be64.patch
-non-readable-binaries.patch
-binfmt_misc-credentials.patch
-siimage-update.patch
-clean-up-asm-pgalloch-include.patch
-clean-up-asm-pgalloch-include-2.patch
-clean-up-asm-pgalloch-include-3.patch
-ppc64-uninline-__pte_free_tlb.patch
-fix-scancode-keycode-scancode-conversion-for-265.patch
-reiserfs-group-alloc-9.patch
-reiserfs-block-allocator-should-not-inherit-packing-locality.patch
-reiserfs-remove-debugging-warning-from-block-allocator.patch
-reiserfs-group-alloc-9-build-fix.patch
-reiserfs-search_reada-5.patch
-reiserfs-data-logging-support.patch
-idr-overflow-fixes.patch
-idr-remove-counter.patch
-idr-fixups.patch
-use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch
-rlim-add-rlimit-entry-for-controlling-queued-signals.patch
-rlim-add-sigpending-field-to-user_struct.patch
-rlim-pass-task_struct-in-send_signal.patch
-rlim-add-simple-get_uid-helper.patch
-rlim-enforce-rlimits-on-queued-signals.patch
-rlim-remove-unused-queued_signals-global-accounting.patch
-rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
-rlim-add-mq_bytes-to-user_struct.patch
-rlim-add-mq_attr_ok-helper.patch
-rlim-enforce-rlimits-for-posix-mqueue-allocation.patch
-rlim-adjust-default-mqueue-sizes.patch
-hpet-driver.patch
-hpet-driver-updates.patch
-fix-hpet-for-acpi-changes.patch
-hpet-kconfig-loop-fix.patch
-hpet-rtc-dependency-fix.patch
-hpet-free_irq-deadlock-fix.patch
-hpet-dont-use-new-major.patch
-kill-off-pc9800.patch
-more-pc9800-removal.patch
-pc9800-merge-std_resourcesc-back-into-setupc.patch
-ext3-retry-allocation-after-transaction-commit-v2.patch
-ext3-retry-allocation-after-transaction-commit-v2-jbd-api.patch
-pty-allocation-first-fit.patch
-dynpty-fix.patch
-2-3-small-tweaks-to-standard-resource-stuff.patch
-3-3-same-small-tweaks-x86_64-version.patch
-sis900-fix-phy-transceiver-detection.patch
-getgroups16-fix.patch
-check-return-status-of-register-calls-in-i82365.patch
-invalidate_inodes2-mark-pages-notuptodate.patch
-reiserfs-v3-logging-bug-for-blocksize-page-size.patch
-read-vs-truncate-race.patch
-cleanups-for-apic.patch
-remove-apic_lockup_debug.patch
-remove-io_apic_sync.patch
-ach1542-mca-build-fix.patch
-validate-pm-timer-rate-at-boot-time.patch
-fix-3c59xc-to-allow-3c905c-100bt-fd.patch
-first-cut-at-fixing-the-3c59x-power-mismanagment.patch
-kbuild-specify-default-target-during-configuration.patch
-bsd-accounting-format-rework.patch
-bsd-accounting-format-rework-update.patch
-iso9660-inodes-beyond-4gb.patch
-iso9660-inodes-beyond-4gb-fixes.patch
-iso9660-comment-cleanup.patch
-iso9660-inodes-anywhere-and-nfs.patch
-sisfb-update-1710.patch
-sisfb-update-1710-fixes.patch
-sisfb-build-fix.patch
-nfs-writepage-fix.patch
-3c59x-support-for-ati-radeon-9100-igp.patch
-1-5-device-mapper-dm-ioc.patch
-dm-cache-flushing-fix.patch
-2-5-device-mapper-kcopyd.patch
-dm-1-5-kcopyd-remove-superfluous-init_list_heads.patch
-dm-2-5-kcopyd-no-need-to-lock-pages.patch
-2-5-device-mapper-kcopyd-docs.patch
-3-5-device-mapper-snapshots.patch
-dm-3-5-fix-error-cleanup-in-dm_create_persistent.patch
-4-5-device-mapper-mirroring.patch
-5-5-device-mapper-dm-zero.patch
-dm-4-5-dm-zero-version.patch
-dm-zero-flushing-fix.patch
-dm-5-5-documentation.patch
-let-serial_8250_acpi-depend-on-acpi_pci-2.patch
-export-acpi_register_gsi.patch
-submission-of-via-velocitytm-series-adapter-driver.patch
-via-velocity-oops-fix.patch
-fb-accel-capabilities.patch
-fbcon-prefer-pan-when-available.patch
-rawdev-driver-2.patch
-msi-target-cpus-fix.patch
-x86_64-numa-build-fix.patch
-i386-uninline-bitops.patch
-apic-enumeration-fixes.patch
-apic-fix-kicking-of-non-present-cpus.patch
-apic-remove-marking-of-non-present-physids-in-phys_cpu_present_map.patch
-apic-make-mach_default-compile-again.patch
-use-numa-policy-api-for-boot-time-policy.patch
-266-memory-allocation-checks-in-eth1394_update.patch
-266-memory-allocation-checks-in-mtdblock_open.patch
-memory-allocation-checks-in-cs46xx_dsp_proc_register_scb_desc.patch
-dont-create-cpu-online-sysfs-file.patch
-checkstack-fixes.patch
-sys-getdents64-needs-compat-wrapper.patch
-remap_file_pages-speedup.patch
-wanxl-firmware-build-fix.patch
-cciss-ioctl32-update.patch
-fix-cdrom-mt-rainier-probe.patch
-blk-move-threshold-unplugging.patch
-fix-memory-leak-in-swsusp.patch
-pmdisk-memleak-fix.patch
-swsusp-remove-memsets.patch
-swsusp-remove-copy_pagedir.patch
-decrease-stack-usage-in-ncpfss-ioctl.patch
-staticalise-update_one_process.patch
-267-rc3-drivers-char-ipmi-ipmi_devintfc-user-kernel.patch
-267-rc3-drivers-scsi-megaraidc-user-kernel-pointer-bugs.patch
-ia64-discontic-fix.patch
-epoll-uses-rbtrees.patch
-larger-io-bitmap.patch
-permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-warning-fix.patch
-respect-edge-level-triggering-requested-in-acpi_register_gsi.patch
-ide-pci-hotplugging-fixes.patch
-ide-kill-some-useless-headers-for-pci-drivers.patch
-ide-ide-proc-fix-for-m68k.patch
-ide-kill-hw_regs_t-dma.patch
-ide-ide-pnp-update.patch
-ide-remove-alternate_state_diagram_multi_out-from-ide-taskfilec.patch
-ide-fix-ide-cd-to-not-retry-req_drive_taskfile-requests.patch
-ide-fix-req_drive_-requests-error-handling-in-ide-scsi.patch
-ide-cleanup-taskfile-pio-handlers-config_ide_taskfile_io=n.patch
-ide-tiny-task_mulout_intr-config_ide_taskfile_io=n-cleanup.patch
-ide-kill-task_map_rq.patch
-ide-check-no-of-sectors-for-in-out-commands-in-ide_diag_taskfile.patch
-revert-sched-improve-wakeup-affinity.patch
-shiftpgup-if-nr-of-scrolled-lines-is-4.patch
-istallion-printk-fix.patch
-pcwdc-patches.patch
-usb-tt-oops-fix.patch
-fix-x86-64-via-systems-with-iommu-debug.patch
-lower-priority-of-too-many-keys-msg-in-atkbdc.patch
-remove-irda-usage-of-isa_virt_to_bus.patch
-unregister-driver-if-probing-fails-in-sb_cardc.patch
-ignore-errors-from-tw_setfeature-in-3w-xxxxc.patch
-fake-inquiry-for-sony-clie-peg-tj25-in-unusual_devsh.patch
-fix-duplicate-environment-variables-passed-to-init.patch
-fix-handling-of--embedded-in-filenames-in-isofs.patch
-fix-isofs-ignoring-noexec-and-mode-mount-options.patch
-fix-thread_infoh-ignoring-__have_thread_functions.patch
-sparse-fix-to-mm-vmscanc.patch

 Merged

+ext3-jbd-needs-to-wait-for-locked-buffers.patch

 ext3 locking fix

+ppc64-build-fix.patch
+ppc64-eeh-warning-fix.patch

 PPC64 fixes

-pdflush-diag.patch
-pci_set_power_state-might-sleep.patch
-slab-leak-detector.patch
-local_bh_enable-warning-fix.patch
-cond_resched-might-sleep.patch
-poll-select-longer-timeouts.patch
-poll-select-range-check-fix.patch
-poll-select-handle-large-timeouts.patch
-add-a-slab-for-ethernet.patch
-shm-do_munmap-check.patch
-stack-overflow-test-fix.patch
-call-might_sleep-in-tasklet_kill.patch
-abs-cleanup.patch

 Dropped

-ext3-reservation-ifdef-cleanup-patch.patch
-ext3-reservation-max-window-size-check-patch.patch
-ext3-reservation-file-ioctl-fix.patch

 Folded into ext3_rsv_base.patch

-ext3-reservation-bad-inode-fix.patch
-ext3_reservation_discard_race_fix.patch

 Folded into ext3-lazy-discard-reservation-window-patch.patch

+larger-io-bitmap.patch

 Support for larger iopl() address ranges

-disk-barrier-core-tweaks.patch

 Folded into disk-barrier-core.patch

-disk-barrier-ide-symbol-expoprt.patch
-disk-barrier-ide-warning-fix.patch

 Folded into disk-barrier-ide.patch

-reiserfs-v3-barrier-support-tweak.patch

 Folded into reiserfs-v3-barrier-support.patch

+singly-linked-rcu.patch
+rcu-no-arg.patch
+rcu-no-arg-fix.patch

 rcu_head shrinkage

-perfctr-disabled-build-fix.patch

 Folded into perfctr-core.patch

-perfctr-if-ifdef-cleanup.patch
-perfctr-dothan-support.patch

 Folded into perfctr-i386.patch

+nx-update.patch

 Update to nx-2.6.7-rc2-bk2-AF.patch

-irqaction-use-cpumask-voyager-fix.patch

 Folded into irqaction-use-cpumask.patch

-fix-and-reenable-msi-support-on-x86_64-fix.patch

 Folded into fix-and-reenable-msi-support-on-x86_64.patch

+permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-update.patch

 Allocate VFS hash tables from bootmem

+vmscan-shuffle-things-around.patch

 vmscan.c cleanup

+vmscan-scan-sanity.patch

 Remove the "try to keep the inactive list 1/3rd of the size of the active
 list" "logic".  Try to do something meaningful instead.

+vmscan-dont-reclaim-too-many-pages.patch

 Avoid possible excessive reclaim

+vfs-shrinkage-tuning.patch

 Add /proc/sys/vm/vfs-cache-pressure

+ppp_syncttyc-receive-write_wakeup-fix.patch

 PPP fix

+ide-stack-reduction.patch
+ide-stack-reduction-cleanup.patch

 IDE stack reduction

+airo-broke.patch

 airo.c fix

+jfs-build-fix.patch

 JFS compile fix

+hid-tmff-fix-again.patch

 Fix USB breakage

+swapoff-activate-pages.patch

 Move pages to the active list during swapoff

+add-ovcamchip-driver.patch

 Add a new driver of OmniVision OV6xx0 and OV7xx0 image sensors

+dnotify-remove-dn_lock.patch

 dnotify SMp scalability improvement

+uninline-machine_specific_memory_setup.patch

 Fix sparse warnings

+dont-writeback-fd-bdev-inodes.patch

 Address a umount-vs-writeback oops

+add-wait_event_interruptible_exclusive-macro.patch

 Add wait_event_interruptible_exclusive()

+fancy-wakeups-in-wait-h.patch

 Switch all the wait.h macros over to prepare_to_wait/finish_wait

+iommu-max-segment-size.patch

 Tweak the BIO layer to understand device iommu limitations

+input-psmouse-resync-for-kvm-users.patch
+input-psmouse-state-locking.patch
+input-serio-connect-disconnect-mandatory.patch
+input-serio-renames-1.patch
+input-serio-renames-1-fix.patch
+input-serio-renames-2.patch
+input-serio-dynamic-allocation.patch
+input-serio-dynamic-allocation-fix.patch
+input-serio-dynamic-allocation-fix-2.patch
+input-serio-dynamic-allocation-fix-3.patch
+input-serio-no-recursion.patch
+input-serio-sysfs-integration.patch
+input-serio-allow-rebinding.patch
+input-serio-manual-bind.patch
+input-serio_raw-driver.patch

 input driver updates

+v4l-v4l2-api-updates.patch
+v4l-update-video-buf-for-per-frame-input-switching.patch
+v4l-video-buf-magic-numbers.patch
+v4l-video-buf-fixes.patch
+v4l-msp3400-cleanup.patch
+v4l-ir-common-update.patch
+v4l-tuner-tda9887-updates.patch
+v4l-bttv-driver-update.patch
+v4l-ir-input-driver-update.patch
+saa7134-update.patch
+v4l-cx88-driver-update.patch
+v4l-radio-zoltrix-fix.patch

 video-for-linux updates

+fix-isdn-to-not-assume-memio-return-values.patch

 ISDN cleanup

+sys_ioctl-export.patch

 export sys_ioctl() to modules (for compat handlers)

+buddy-reordering.patch

 Diddle the page allocator to make DMA segment merging more successful

+mprotect-propagate-anon_vma.patch

 mprotect fix

+sparsify-quotactl.patch

 Add __user annotations

+fix-possible-stack-corruption-during-reiserfs_file_write.patch

 reiserfs fix

+numa-api-updates.patch

 NUMA API fixes

+isp16-check_region-removal.patch

 Remove some check_region() warnings

+deadline-docco.patch

 Document the deadline I/O scheduler and its tunables.

+move-as-docco.patch

 Move the anticipatory scheduler documentation into Documentation/block

+credits-update.patch

 Update ./CREDITS

+hwcache-align-kmalloc-caches.patch

 slab.c tweaks

+reduce-function-inlining-in-slabc.patch

 slab.c uninlinings

+nls-support-for-ascii.patch

 Add a new NLS for ascii

+mips-remove-old-junk.patch
+ds1286-cleanups.patch
+cobalt-lcd-driver-update.patch
+add-m48t35-rtc-driver.patch

 mips things

+farsync-warning-fix.patch

 Fix a warning

+sparc64-bug-needs-compiler-h.patch

 sparc64 warning fix

+jfs-warning-fix.patch

 JFS warning fix

+velocity-warning-fixes.patch
+velocity-warning-fixes-2.patch
+velocity-warning-fixes-3.patch
+velocity-warning-fixes-4.patch

 Various warning fixes for via-velocity.c

+abs-fix.patch

 Provide a single implementation of abs() in kernel.h, kill various provate
 implementations.

+lindent-rwsem.patch

 Feed rwsem code through Lindent

+tdfxb-warning-fix.patch

 Fix a warning

+ide-taskfilec-fixups-cleanups.patch
+ide-end-request-fix-for-config_ide_taskfile_io=y-pio-handlers.patch
+ide-pio-in-drive-busy-fix-config_ide_taskfile_io=y.patch
+ide-check-drive-mult_count-in-flagged_taskfile.patch
+ide-last-irq-fix-for-task_mulout_intr-config_ide_taskfile_io=n.patch
+ide-remove-dtf-debugging-printks-from-ide-taskfilec.patch
+ide-add-task_multi_sectors-to-ide-taskfilec.patch
+ide-split-task_sectors-and-task_multi_sectors.patch
+ide-dont-clear-rq-errors-for-req_drive_taskfile-requests.patch
+ide-use-task_buffer_sectors-in-ide-taskfilec.patch
+ide-pio-out-setup-fixes-config_ide_taskfile_io=n.patch

 IDE update

+idrh-path.patch

 Fix a comment

+wanxl-firmware-build-fix.patch

 Fix allmodconfig build

+avoid-rebuild-of-ikcfg-when-using-o=.patch
+kbuild-add-deb-pkg-target.patch

 kbuild updates

+x86_64-double-clock-speed-fix.patch

 Revert the ACPI change which makes Opteron timekeeping run too fast

+sysfs-overflow-debug.patch

 Add debug traps for sysfs show() handlers which overrun theor buffer.

+fix-smbfs-readdir-oops.patch
+remove-smbfs-server-rcls-err.patch

 smbfs fixes and cleanups

+kallsyms-exclude.patch
+kallsyms-verify.patch

 Fix a few awkward kallsyms problems.





All 226 patches:


linus.patch

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

opti92x-ad1848-locking-fix.patch
  opti92x-ad1848.c locking fix

ext3-jbd-needs-to-wait-for-locked-buffers.patch
  jbd needs to wait for locked buffers

bk-agpgart.patch

bk-alsa.patch

bk-cpufreq.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pcmcia.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

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
  Fix stack overflow test for non-8k stacks

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup

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

ppc64-build-fix.patch
  ppc64 CONFIG_ALTIVEC=n build fix

ppc64-eeh-warning-fix.patch
  ppc64: eeh.h warning-fix

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

schedstats.patch
  sched: scheduler statistics

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

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
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

larger-io-bitmap.patch
  larger IO bitmaps

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

ftruncate-vs-block_write_full_page.patch
  ftruncate vs block_write_full_page race fix

ia32-fault-deadlock-fix-2.patch
  ia32: fix deadlocks when oopsing while mmap_sem is held

ppc64-fault-deadlock-fix-2.patch
  ppc64: fix deadlocks when oopsing while mmap_sem is held

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
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE
  disk-barrier-ide-symbol-expoprt
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
  reiserfs-v3-barrier-support-tweak

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

ext3-barrier-support.patch
  ext3 barrier support

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

ide-print-failed-opcode.patch
  ide: print failed opcode on IO errors

add-bh_eopnotsupp-for-testing.patch
  add BH_Eopnotsupp for testing async barrier failures

handle-async-barrier-failures.patch
  Handle async barrier failures

x86-stack-dump-fixes.patch
  x86 stack dump fixes

reduce-tlb-flushing-during-process-migration.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-oops-fix.patch
  reduce-tlb-flushing-during-process-migration oops fix

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c
  arch/i386/boot/compressed/misc.c warning fixes

rcu-lock-update-add-per-cpu-batch-counter.patch
  rcu lock update: Add per-cpu batch counter

rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
  rcu lock update: Use a sequence lock for starting batches

rcu-lock-update-code-move-cleanup.patch
  rcu lock update: Code move & cleanup

singly-linked-rcu.patch
  reduce rcu_head size - core

rcu-no-arg.patch
  rcu: avoid passing an argument to the callback function

rcu-no-arg-fix.patch
  reduce rcu_head size fix

pcm_native-stack-reduction.patch
  pcm_native.c stack reduction

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-cpus_complement-fix.patch
  perfctr-cpus_complement-fix

perfctr-cpumask-cleanup.patch
  perfctr cpumask cleanup

perfctr-misc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

nx-2.6.7-rc2-bk2-AF.patch
  NX (No eXecute) support for x86

nx-update.patch
  nx update

cpumask-1-10-cpu_present_map-real-even-on-non-smp.patch
  cpumask 1/10 cpu_present_map real even on non-smp

cpumask-2-10-bitmap-cleanup-preparation-for-cpumask.patch
  cpumask 2/10 bitmap cleanup preparation for cpumask  overhaul

cpumask-3-10-bitmap-inlining-and-optimizations.patch
  cpumask 3/10 bitmap inlining and optimizations

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based.patch
  cpumask 5/10 rewrite cpumask.h - single bitmap based  implementation

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based-cpu_mask_none-fix.patch
  CPU_MASK_NONE fix

s390-fix-cpu_online-redefined-warnings.patch
  s390: fix "cpu_online" redefined warnings

cpumask-6-10-remove-26-no-longer-used-cpumaskh-files.patch
  cpumask 6/10 remove 26 no longer used cpumask*.h files

cpumask-7-10-remove-obsolete-cpumask-macro-uses-i386-arch.patch
  cpumask 7/10 remove obsolete cpumask macro uses - i386 arch

cpumask-8-10-remove-obsolete-cpumask-macro-uses-other.patch
  cpumask 8/10 remove obsolete cpumask macro uses - other  archs

x86_64-cpu_online-fix.patch
  x86_64-cpu_online-fix

ppc64-cpu_online-fix.patch
  ppc64: cpu_online fix

cpumask-9-10-remove-no-longer-used-obsolete-macro-emulation.patch
  cpumask 9/10 Remove no longer used obsolete macro emulation

cpumask-10-10-optimize-various-uses-of-new-cpumasks.patch
  cpumask 10/10 optimize various uses of new cpumasks

cpumask-11-10-comment-spacing-tweaks.patch
  cpumask: comment, spacing tweaks

cleanup-cpumask_t-temporaries.patch
  clean up cpumask_t temporaries

alpha-cpumask-fix.patch
  alpha: cpumask fixups

irqaction-use-cpumask.patch
  make irqaction use a cpu mask
  Fix irqaction-use-cpumask.patch for voyager

fix-and-reenable-msi-support-on-x86_64.patch
  Fix and Reenable MSI Support on x86_64
  Fix and Reenable MSI Support on x86_64 fix

export-dmi-check-functions.patch
  export DMI check functions

hp-pavilion-use-dmi-api.patch
  use new DMI API for HP Pavilion

pcmcia-enable-read-prefetch-on-o2micro-bridges-to-fix-hdsp.patch
  pcmcia: enable read prefetch on o2micro bridges to fix HDSP

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

permit-inode-dentry-hash-tables-to-be-allocated-max_order-size.patch
  Permit inode & dentry hash tables to be allocated > MAX_ORDER size
  permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-warning-fix

permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-update.patch
  Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size [try #3]

improved-psx-support-in-input-joystick-gameconc.patch
  improved PSX support in input/joystick/gamecon.c

o_noatime-support.patch
  O_NOATIME support

vmscan-shuffle-things-around.patch
  vmscan.c: shuffle things around

vmscan-scan-sanity.patch
  vmscan.c scan rate fixes

vmscan-dont-reclaim-too-many-pages.patch
  vmscan.c: dont reclaim too many pages

vfs-shrinkage-tuning.patch
  vm: vfs shrinkage tuning

ppp_syncttyc-receive-write_wakeup-fix.patch
  ppp_synctty.c receive/write_wakeup fix

ide-stack-reduction.patch
  IDE stack reduction

ide-stack-reduction-cleanup.patch
  ide-stack-reduction-cleanup

airo-broke.patch
  airo.c broke

jfs-build-fix.patch
  jfs build fix

hid-tmff-fix-again.patch
  hid-tmff fix again

swapoff-activate-pages.patch
  swapoff-activate-pages

add-ovcamchip-driver.patch
  Add ovcamchip driver

dnotify-remove-dn_lock.patch
  dnotify.c: use inode->i_lock in place of dn_lock

uninline-machine_specific_memory_setup.patch
  Uninline machine_specific_memory_setup()

dont-writeback-fd-bdev-inodes.patch
  dont-writeback-fd-bdev-inodes

add-wait_event_interruptible_exclusive-macro.patch
  add wait_event_interruptible_exclusive() macro

fancy-wakeups-in-wait-h.patch
  Use fancy wakeups in wait.h

iommu-max-segment-size.patch
  iommu max segment size

input-psmouse-resync-for-kvm-users.patch
  input: psmouse resync for KVM users

input-psmouse-state-locking.patch
  input: psmouse state locking

input-serio-connect-disconnect-mandatory.patch
  input: serio connect/disconnect mandatory

input-serio-renames-1.patch
  input: serio renames 1

input-serio-renames-1-fix.patch
  input-serio-renames-1-fix

input-serio-renames-2.patch
  input: serio renames 2

input-serio-dynamic-allocation.patch
  input: serio dynamic allocation

input-serio-dynamic-allocation-fix.patch
  input-serio-dynamic-allocation-fix

input-serio-dynamic-allocation-fix-2.patch
  input-serio-dynamic-allocation-fix-2

input-serio-dynamic-allocation-fix-3.patch
  input-serio-dynamic-allocation-fix-3

input-serio-no-recursion.patch
  input: serio no recursion

input-serio-sysfs-integration.patch
  input: serio sysfs integration

input-serio-allow-rebinding.patch
  input: serio allow rebinding

input-serio-manual-bind.patch
  input: serio manual bind

input-serio_raw-driver.patch
  input: serio_raw driver

v4l-v4l2-api-updates.patch
  v4l: v4l2 API updates

v4l-update-video-buf-for-per-frame-input-switching.patch
  v4l: update video-buf for per-frame input switching.

v4l-video-buf-magic-numbers.patch
  v4l: video-buf magic numbers

v4l-video-buf-fixes.patch
  v4l: video-buf fixes.

v4l-msp3400-cleanup.patch
  v4l: msp3400 cleanup.

v4l-ir-common-update.patch
  v4l: ir-common update

v4l-tuner-tda9887-updates.patch
  v4l: tuner + tda9887 updates

v4l-bttv-driver-update.patch
  v4l: bttv driver update

v4l-ir-input-driver-update.patch
  v4l: IR input driver update.

saa7134-update.patch
  saa7134 driver update

v4l-cx88-driver-update.patch
  v4l: cx88 driver update

v4l-radio-zoltrix-fix.patch
  v4l: radio-zoltrix fix.

fix-isdn-to-not-assume-memio-return-values.patch
  fix isdn to not assume mem*io return values

sys_ioctl-export.patch
  export sys_ioctl to modules

buddy-reordering.patch
  tweak the buddy allocator for better I/O merging

mprotect-propagate-anon_vma.patch
  mprotect propagate anon_vma

sparsify-quotactl.patch
  sparse annotation for sys_quotactl()

fix-possible-stack-corruption-during-reiserfs_file_write.patch
  fix possible stack corruption during reiserfs_file_write

numa-api-updates.patch
  NUMA API updates

isp16-check_region-removal.patch
  isp16 check_region() removal

deadline-docco.patch
  deadline I/O scheduler documentation

move-as-docco.patch
  move-as-docco

credits-update.patch
  CREDITS update

hwcache-align-kmalloc-caches.patch
  hwcache align kmalloc caches

reduce-function-inlining-in-slabc.patch
  reduce function inlining in slab.c

nls-support-for-ascii.patch
  NLS support for ASCII

mips-remove-old-junk.patch
  mips: remove old junk

ds1286-cleanups.patch
  DS1286 cleanups

cobalt-lcd-driver-update.patch
  Cobalt LCD Driver update

add-m48t35-rtc-driver.patch
  Add M48T35 RTC driver

farsync-warning-fix.patch
  farsync.c warning fix

sparc64-bug-needs-compiler-h.patch
  sparc64: bug.h needs compiler.h

jfs-warning-fix.patch
  jfs warning fix

velocity-warning-fixes.patch
  velocity warning fixes

velocity-warning-fixes-2.patch
  via-velocity: more warning fixes

velocity-warning-fixes-3.patch
  via-velocity.c: even more warning fixes

velocity-warning-fixes-4.patch
  via-velocity warning fix 4

abs-fix.patch
  abs() fixes

lindent-rwsem.patch
  lindent rwsem

tdfxb-warning-fix.patch
  Fix warning in tdfxfb.c

ide-taskfilec-fixups-cleanups.patch
  ide: remove redundant hwgroup->handler checks from ide-taskfile.c

ide-end-request-fix-for-config_ide_taskfile_io=y-pio-handlers.patch
  ide: end request fix for CONFIG_IDE_TASKFILE_IO=y PIO handlers

ide-pio-in-drive-busy-fix-config_ide_taskfile_io=y.patch
  ide: PIO-in drive busy fix (CONFIG_IDE_TASKFILE_IO=y)

ide-check-drive-mult_count-in-flagged_taskfile.patch
  ide: check drive->mult_count in flagged_taskfile()

ide-last-irq-fix-for-task_mulout_intr-config_ide_taskfile_io=n.patch
  ide: last IRQ fix for task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n)

ide-remove-dtf-debugging-printks-from-ide-taskfilec.patch
  ide: remove DTF() debugging printks from ide-taskfile.c

ide-add-task_multi_sectors-to-ide-taskfilec.patch
  ide: add task_multi_sectors() to ide-taskfile.c

ide-split-task_sectors-and-task_multi_sectors.patch
  ide: split task_sectors() and task_multi_sectors()

ide-dont-clear-rq-errors-for-req_drive_taskfile-requests.patch
  ide: don't clear rq->errors for REQ_DRIVE_TASKFILE requests

ide-use-task_buffer_sectors-in-ide-taskfilec.patch
  ide: use task_buffer[_multi]_sectors() in ide-taskfile.c

ide-pio-out-setup-fixes-config_ide_taskfile_io=n.patch
  ide: PIO-out setup fixes (CONFIG_IDE_TASKFILE_IO=n)

idrh-path.patch
  idr.h path

wanxl-firmware-build-fix.patch
  wanxl firware build fix

avoid-rebuild-of-ikcfg-when-using-o=.patch
  Avoid rebuild of IKCFG when using O=

kbuild-add-deb-pkg-target.patch
  kbuild: add deb-pkg target

x86_64-double-clock-speed-fix.patch
  Fix rthe x86_64 clock-runs-too-fast thing

sysfs-overflow-debug.patch
  sysfs-overflow-debug

fix-smbfs-readdir-oops.patch
  Fix smbfs readdir oops

remove-smbfs-server-rcls-err.patch
  Remove smbfs server->rcls/err

kallsyms-exclude.patch
  kallsyms: exclude kallsyms-generated symbols

kallsyms-verify.patch
  kallsyms: verify that System.map is stable



