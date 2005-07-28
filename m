Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVG1KBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVG1KBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVG1KBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:01:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261374AbVG1J7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:59:43 -0400
Date: Thu, 28 Jul 2005 02:58:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3-mm3
Message-Id: <20050728025840.0596b9cb.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/

- Added the anonymous pagefault scalability enhancement patches.

  I remain fairly dubious about this - it seems a fairly specific and
  complex piece of work to speed up one extremely specific part of one type of
  computer's one type of workload.   Surely there's a better way :(

  The patches at present spit warnings or don't compile on lots of
  architectures.  x86, x86_64, ppc64 and ia64 are OK.

- There's a pretty large x86_64 update here which naughty maintainer wants
  in 2.6.13.  Extra testing, please.

- Dropped git-net.patch (davem's net devel tree).  I'm seeing weird TCP
  hangs.  I'm fairly sure they're present in mainline, but was unable to
  reproduce it without git-net.patch when I was actually trying.



Changes since 2.6.13-rc3-mm2:


 linus.patch
 git-acpi.patch
 git-cryptodev.patch
 git-drm.patch
 git-audit.patch
 git-input.patch
 git-kbuild.patch
 git-libata-adma-mwi.patch
 git-libata-chs-support.patch
 git-libata-passthru.patch
 git-libata-promise-sata-pata.patch
 git-netdev-chelsio.patch
 git-netdev-e100.patch
 git-netdev-smc91x-eeprom.patch
 git-netdev-ieee80211-wifi.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-block.patch
 git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch

 Subsystem trees

-i2c-mpc-restore-code-removed.patch
-really-__nocast-annotate-kmalloc_node.patch
-mips-fbdev-kconfig-fix.patch
-md-when-resizing-an-array-we-need-to-update-resync_max_sectors-as-well-as-size.patch
-uml-readd-missing-define-to-arch-um-makefile-i386.patch
-uml-add-dependency-to-arch-um-makefile-for-parallel-builds.patch
-uml-add-skas0-command-line-option.patch
-uml-update-module-interface.patch
-uml-fix-misdeclared-function.patch
-x86_64-fix-smp-boot-lockup-on-some-machines.patch
-try_to_freeze-call-fixes.patch
-add-missing-tvaudio-try_to_freeze.patch
-fix-missing-refrigerator-invocation-in-jffs2.patch
-as-ioched-tunable-encoding-fix.patch
-reiserfs-fix-deadlock-in-inode-creation-failure-path-w-default-acl.patch
-ext2-drop-quota-reference-before-releasing-inode.patch
-ext3-drop-quota-references-before-releasing-inode.patch
-pnp-build-fix.patch
-address-bug-using-smp_processor_id-in-preemptible.patch
-watchdog-add-missing-0x-in-alim1535_wdtc.patch
-itimer-fixes.patch
-add-pcibios_bus_to_resource-for-parisc.patch
-autofs4-fix-infamous-busy-inodes-after-umount-message.patch
-scsi_scan-check-return-code-from-scsi_sysfs_add_sdev.patch
-i4l-add-olitec-isdn-pci-card-in-hisax-gazel-driver.patch
-jsm-use-dynamic-major-number-allocation.patch
-jsm-warning-fixes.patch
-undo-mempolicy-shared-policy-rbtree-microoptimization.patch
-ub-fix-for-blank-cds.patch
-fix-xip-sparse-file-handling-in-ext2.patch
-check_user_page_readable-deadlock-fix.patch
-mpt-fusion-free-irq-in-suspend.patch
-eurotechwdt-build-fix.patch
-softdog-build-fix.patch
-x86_64-fsnotify-build-fix.patch
-fix-warning-in-powernow-k8c.patch
-speakup-build-fix.patch
-drm-via-fix-sparse-warnings.patch
-netfilter-build-fix.patch
-ipv6_netfilter_init-warning-fix.patch
-consolidate-config_watchdog_nowayout-handling.patch
-madvise-does-not-always-return-ebadf-on-non-file.patch
-remove-bogus-warning-in-page_allocc.patch
-ppc-ppc64-use-kconfighz.patch
-ppc32-update-defconfigs.patch
-ppc32-add-proper-prototype-for-cpm2_reset.patch
-ppc32-make-the-uarts-on-mpc824x-individual-platform-devices.patch
-ppc32-8xx-update-datatlbmiss-exception-comment.patch
-ppc-fix-compilation-error-with-config_pq2fads.patch
-ppc32-fix-typo-in-setup-of-2nd-pci-bus-on-85xx.patch
-ppc32-fix-building-of-prpmc750.patch
-ppc32-fix-building-of-radstone_ppc7d.patch
-ppc32-fix-dma_map_page-to-use-page_to_bus.patch
-ppc32-fix-440sp-mal-channels-count.patch
-ppc32-fix-building-of-tqm8260-board.patch
-ppc64-update-defconfigs.patch
-ppc64-hide-config_adb.patch
-ppc64-genrtc-build-fix.patch
-make-a-few-functions-static-in-pmac_setupc.patch
-ppc64-dynamically-allocate-segment-tables.patch
-ppc64-remove-another-fixed-address-constraint.patch
-mips-remove-obsolete-giu-driver-for-vr41xx.patch
-i386-add-missing-kconfig-help-text.patch
-m32r-add-missing-kconfig-help-text.patch
-cris-update-1-17-arch-split.patch
-cris-update-2-17-configuration-and-build.patch
-cris-update-3-17-console.patch
-cris-update-4-17-debug.patch
-cris-update-5-17-drivers.patch
-cris-update-6-17-i-o-and-dma-allocator.patch
-cris-update-7-17-irq.patch
-cris-update-8-17-misc-patches.patch
-cris-update-9-17-mm.patch
-cris-update-10-17-pci.patch
-cris-update-11-17-profiler.patch
-cris-update-12-17-serial-port-driver.patch # rmk said no
-cris-update-13-17-smp.patch
-cris-update-14-17-synchronous-serial-port-driver.patch
-cris-update-15-17-updates-for-2612.patch
-cris-update-17-17-new-subarchitecture-v32.patch
-cris-update-17-17-new-subarchitecture-v32-swapped-kmalloc-args.patch
-cris-ide-driver.patch
-v850-define-pfn_valid.patch
-v850-const-qualify-first-parameter-of-find_next_zero_bit.patch
-v850-add-defconfigs.patch
-v850-update-ioremap-return-type-and-add-ioread-iowrite-functions.patch
-v850-add-pte_file.patch
-v850-update-pci-support.patch
-v850-define-l1_cache_shift-and-l1_cache_shift_max.patch
-s390-spin-lock-retry.patch
-s390-find_next_zero_bit-fixes.patch
-s390-atomic64-inline-functions.patch
-s390-external-call-performance.patch
-s390-debug-data-for-ifcc-ccc.patch
-s390-resource-accessibility-event-handling.patch
-s390-fba-dasd-i-o-errors.patch
-s390-free-dasd-slab-cache.patch
-s390-channel-tape-fixes.patch
-s390-31-bit-memory-size-limit.patch
-s390-cpu-timer-reset-in-machine-check-handler.patch
-s390-use-__cpcmd-in-vmcp_write.patch
-fortuna-random-driver-fix.patch
-stale-posix-lock-handling.patch
-cciss-per-disk-queue.patch
-kernel-capabilityc-add-kerneldoc.patch
-kernel-cpusetc-add-kerneldoc-fix-typos.patch
-kernel-crash_dumpc-add-kerneldoc.patch
-tpm-support-for-infineon-tpm.patch
-ppc64-tpm_infineon-build-fix.patch
-mbcache-remove-unused-mb_cache_shrink-parameter.patch
-documentation-changes-document-the-required-udev-version.patch
-reiserfs-doesnt-use-mbcache.patch
-ia64-halt-hangup-fix.patch
-turn-many-if-undefined_string-into-ifdef-undefined_string.patch
-riva-wundef-fix.patch
-sys_get_thread_area-does-not-clear-the-returned-argument.patch
-serial_core-whitespace-fix.patch
-add-text-for-dealing-with-dot-releases-to-readme.patch
-ib-update-fmr-functions.patch
-ib-update-mad-client-api.patch
-ib-add-mad-helper-functions.patch
-ib-combine-some-mad-routines.patch
-ib-change-saving-of-users-send-wr_id-in-mad.patch
-ib-change-ib_mad_send_wr_private-struct.patch
-ib-fix-timeout-cancelled-mad-handling.patch
-ib-minor-cleanup-during-mad-startup-and-shutdown.patch
-ib-add-ib_coalesce_recv_mad-to-mad.patch
-ib-add-automatic-retries-to-mad-layer.patch
-ib-simplify-calling-of-list_del-in-mad.patch
-ib-eliminate-mad-cache-leak-associated-with-local.patch
-ib-add-ib_modify_mad-api-to-mad.patch
-ib-optimize-canceling-a-mad.patch
-ib-fix-a-couple-of-mad-code-paths.patch
-ib-add-ib_create_ah_from_wc-to-ib-verbs.patch
-ib-a-couple-of-ib-core-bug-fixes.patch
-ib-introduce-rmpp-apis.patch
-ib-add-rmpp-implementation.patch
-ib-add-service-record-support-to-sa-client.patch
-ib-add-the-header-file-for-kernel-cm-communications.patch
-ib-add-the-kernel-cm-implementation.patch
-ib-user-mad-abi-changes-to-support-rmpp.patch
-ib-implementation-for-rmpp-support-in-user-mad.patch
-ib-add-the-header-file-for-user-space-cm.patch
-ib-add-kernel-portion-of-user-cm-implementation.patch
-ib-add-kernel-portion-of-user-cm-implementation-fix.patch
-ib-hook-up-userspace-cm-to-the-make-system.patch
-ib-eliminate-sparse-warnings-in-sa-client.patch
-ib-add-core-locking-documentation-to-infiniband.patch
-dvico-fusion-dvb-t1-tuner-lg-z201-fix.patch
-drivers-media-video-tveepromc-possible-cleanups.patch
-video_saa7134-must-depend-on-sound.patch
-v4l-fix-regression-modprobe-bttv-freezes-the-computer.patch
-dvb-v4l-lgdt3302-isolate-tuner.patch
-dvb-v4l-rf-input-selection-fix.patch
-lgdt3302-warning-fix.patch
-dvb-v4l-cx88-cleanup.patch
-v4l-hybrid-dvb-fix-warnings-with-wundef.patch
-v4l-hybrid-dvb-move-defines-to-makefile.patch
-v4l-hybrid-dvb-rename-cflags-from-config_dvb_xxxx-back.patch
-v4l-fix-tuning-with-mxb-driver.patch
-dvb-rename-lgdt3302-frontend-module-to-lgdt330x.patch
-serial-mri-mri-pcids1-dual-port-serial-card.patch
-clean-up-the-old-digi-support-and-rescue-it.patch
-cpm_uart-use-dpram-for-early-console.patch
-fbmon-horizontal-frequency-rounding-fix.patch
-fbmem-use-unregister_chrdev-on-unload.patch
-radeonfb-clean-up-edid-sysfs-attribute.patch
-fbdev-colormap-fixes.patch
-dont-repaint-the-cursor-when-it-is-disabled.patch
-fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace.patch
-clean-up-inline-static-vs-static-inline.patch
-update-credits-entry-and-listings-in-source-files-for-jesper.patch

 Merged

+bio_clone-fix.patch

 Fix BIO cloning bug - might be the cause of data corruption on some MD
 setups.

+x86_64-always-ack-ipis-even-on-errors.patch
+x86_64-update-defconfig.patch
+x86_64-use-for_each_cpu_mask-for-clustered-ipi-flush.patch
+x86_64-i386-x86_64-remove-prototypes-for-not-existing.patch
+x86_64-move-cpu_present-possible_map-parsing-earlier.patch
+x86_64-minor-clean-up-to-cpu-setup-use-smp_processor_id-instead-of-custom-hack.patch
+x86_64-clarify-booting-processor-message.patch
+x86_64-some-cleanup-in-setup64c.patch
+x86_64-remove-unused-variable-in-delayc.patch
+x86_64-improve-config_gart_iommu-description-and-make-it-default-y.patch
+x86_64-some-updates-for-boot-optionstxt.patch
+x86_64-fix-some-comments-in-tlbflushh.patch
+x86_64-remove-obsolete-eat_key-prototype.patch
+x86_64-fix-some-typos-in-systemh-comments.patch
+x86_64-fix-incorrectly-defined-msr_k8_syscfg.patch
+x86_64-fix-overflow-in-numa-hash-function-setup.patch
+x86_64-print-a-boot-message-for-hotplug-memory-zones.patch
+x86_64-create-per-cpu-machine-check-sysfs-directories.patch
+x86_64-remove-ia32_-build-tools-in-makefile.patch
+x86_64-remove-the-broadcast-options-that-were-added-for.patch
+x86_64-support-more-than-8-cores-on-amd-systems.patch
+x86_64-icecream-has-no-way-of-detecting-assembler-level.patch
+x86_64-turn-bug-data-into-valid-instruction.patch
+x86_64-when-running-cpuid4-need-to-run-on-the-correct.patch
+x86_64-remove-unnecessary-include-in-faultc.patch
+x86_64-small-assembly-improvements.patch
+x86_64-switch-to-the-interrupt-stack-when-running-a.patch
+x86_64-fix-srat-handling-on-non-dual-core-systems.patch
+x86_64-fix-gcc-4-warning-in-sched_find_first_bit.patch
+x86_64-use-msleep-in-smpbootc.patch
+x86_64-remove-unused-variable-in-k8-busc.patch
+x86_64-fix-cpu_to_node-setup-for-sparse-apic_ids.patch

 x86_64 update

+cs89x0-collect-tx_bytes-statistics.patch

 net driver stats fix

+ppc32-inotify-syscalls.patch
+ppc64-inotify-syscalls.patch

 ppc32/ppc64 syscall table updates

+selinux-default-labeling-of-mls-field.patch

 SELinux multilevel security feature work

+pcdp-if-pcdp-contains-parity-information-use-it.patch

 pcdp driver fix

+qla2xxx-mark-dependency-on-fw_loader.patch

 qlogic Kconfig fix

+alpha-fix-statement-with-no-effect-warnings.patch

 Alpha warning fixes

+mm-ensure-proper-alignment-for-node_remap_start_pfn.patch

 memory management initialisation fix

-move-truncate_inode_pages-into-delete_inode.patch

 This is in git-ocfs2.patch

+mpt-fusion-free-irq-in-suspend.patch

 mpt-fusion power management fix

+gregkh-driver-stable_api_nonsense.txt-fixes.patch
+gregkh-driver-speakup-kconfig-fix.patch
+gregkh-driver-speakup-kconfig-fix-2.patch
+gregkh-driver-speakup-build-fix.patch

 Greg's driver core tree

+drivers-char-drm-drm_pcic-fix-warnings.patch

 Warning fixes

+gregkh-i2c-w1-netlink-callbacks.patch

 Greg's i2c tree

+git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch

 Fix incompatibility between git-net and Greg's i2c tree

+include-net-ieee80211h-must-include-linux-wirelessh.patch

 net build fix

+gregkh-pci-pci-restore-bar-values.patch

 Greg's PCI tree

-revert-gregkh-pci-pci-assign-unassigned-resources.patch

 Hopefully no longer needed

+mpt-fusion-dv-fixes.patch

 Try to fix some mpt-fusion domain validation problems (doesn't seem to work)

+gregkh-usb-usb-ftdi_sio-new-devices.patch
+gregkh-usb-usb-ftdi_sio-rts-dtr.patch
+gregkh-usb-usb-ftdi_sio-timeout-fix.patch
+gregkh-usb-usb-usbfs-dont-leak-data.patch
+gregkh-usb-usb-usbnet-remove-unused-vars.patch
+gregkh-usb-usb-dont-delete-unregistered-interfaces.patch
+gregkh-usb-usb-usbserial-remove-unneeded-casts.patch

 Greg's USB tree

-proc-pid-numa_maps-to-show-on-which-nodes-pages-reside-tidy.patch

 Folded into proc-pid-numa_maps-to-show-on-which-nodes-pages-reside.patch

+vm-add-capabilites-check-to-set_zone_reclaim.patch

 Make sys_set_zone_reclaim() privileged

+page-fault-patches-introduce-pte_xchg-and-pte_cmpxchg.patch
+page-fault-patches-introduce-pte_xchg-and-pte_cmpxchg-fix.patch
+page-fault-patches-optional-page_lock-acquisition-in.patch
+page-fault-patches-optional-page_lock-acquisition-in-tidy.patch
+page-fault-patches-no-pagetable-lock-in-do_anon_page.patch

 anonymous pagefault scalability enhancements.

-net-add-driver-for-the-nic-on-cell-blades-kconfig-fix.patch

 Folded into net-add-driver-for-the-nic-on-cell-blades.patch

-sk98lin-basic-suspend-resume-support-fix.patch

 Folded into sk98lin-basic-suspend-resume-support.patch

+ppc32-mark-boards-that-dont-build-as-broken.patch
+ppc32-add-440ep-support.patch
+ppc32-add-bamboo-platform.patch
+ppc32-add-bamboo-defconfig.patch
+ppc32-remove-board-support-for-adir.patch
+ppc32-remove-board-support-for-ash.patch
+ppc32-remove-board-support-for-beech.patch
+ppc32-remove-defconfig-for-cedar.patch
+ppc32-remove-board-support-for-k2.patch
+ppc32-remove-board-support-for-mcpn765.patch
+ppc32-remove-board-support-for-menf1.patch
+ppc32-remove-board-support-for-oak.patch
+ppc32-remove-board-support-for-rainier.patch
+ppc32-remove-board-support-for-redwood.patch
+ppc32-remove-board-support-for-sm850.patch
+ppc32-remove-board-support-for-spd823ts.patch
+ppc32-remove-board-support-for-ep405.patch
+ppc32-remove-board-support-for-pcore.patch

 ppc32 work

+ppc64-remove-nested-feature-sections.patch

 ppc64 cleanup

+ptrace-i386-fix-syscall-audit-interaction-with-singlestep.patch
+uml-support-ptrace-adds-the-host-sysemu-support-for-uml-and-general-usage.patch
+uml-support-reorganize-ptrace_sysemu-support.patch
+uml-support-add-ptrace_sysemu_singlestep-option-to-i386.patch
+sysemu-fix-sysaudit--singlestep-interaction.patch

 UML feature work

-areca-raid-linux-scsi-driver-fix.patch

 Folded into areca-raid-linux-scsi-driver.patch (will be dropped from next -mm)

-relayfs-cancel-work-on-close-reset.patch
-relayfs-add-private-data-to-channel-struct.patch
-relayfs-function-docfix.patch
-relayfs-add-relayfs-website-to-documentation.patch
-avoid-lookup_hash-usage-in-relayfs.patch

 Folded into relayfs.patch

-add-skip_hangcheck_timer.patch

 Dropped, but will come back.

-yealink-updates.patch
-yealink-updates-0701.patch

 Folded into new-driver-for-yealink-usb-p1k-phone.patch

+support-powering-sharp-zaurus-sl-5500-lcd-up-and-down.patch

 Make Pavel's Zausus happier

+radix_tag_get-differentiate-between-no-present-node-and-tag-unset-cases.patch
+radix_tag_get-differentiate-between-no-present-node-and-tag-unset-cases-fix.patch

 radix_tree_tag_get() API enhancement.

+aio-fix-races-in-callback-path.patch

 AIO race fix

+auxiliary-vector-cleanups.patch

 SHuffle the AT_* auxiliary vector defines around

+pnp-consolidate-kmalloc-wrappers.patch

 PNP cleanup

-fix-race-in-do_get_write_access-warning-fix.patch

 Folded into fix-race-in-do_get_write_access.patch

-kprobes-prevent-possible-race-conditions-generic-fixes.patch

 Folded into kprobes-prevent-possible-race-conditions-generic.patch

-kprobes-prevent-possible-race-conditions-ia64-changes-fixes.patch

 Folded into kprobes-prevent-possible-race-conditions-ia64-changes.patch

-connector-exit-notifier-fix.patch
-connector-exit-notifier-remove-the-union-declaration.patch
-connector-exit-notifier-fix-missing-dependencies-in.patch

 Folded into connector-exit-notifier.patch

-connector-add-a-fork-connector-use-after-free-fix.patch
-connector-add-a-fork-connector-remove-the-union-declaration-fork.patch
-connector-fork-notifier-fix-missing-dependencies-in.patch

 Folded into connector-add-a-fork-connector.patch

-jbd-split-checkpoint-lists-tweaks.patch

 Folded into jbd-split-checkpoint-lists.patch

-spinlock-consolidation-m32r-fix.patch
-spinlock-consolidation-up-spinlocks-gcc-29x-fix.patch
-page_uptodate-locking-scalability-fix.patch
-spinlock-consolidation-s390-fix.patch

 Folded into spinlock-consolidation.patch

-revert-fix-broken-kmalloc_node-in-rc1-rc2.patch
-numa-aware-slab-allocator-v5-fix.patch
-numa-slab-allocator-cleanups.patch

 Folded into numa-aware-slab-allocator-v5.patch

-iteraid-remove-ite_ioc_get_driver_version.patch

 Folded into iteraid.patch (will be dropped from next -mm)

-page-owner-tracking-leak-detector-tidy.patch

 Folded into page-owner-tracking-leak-detector.patch

-perfctr-handle-non-of-ppc32-platforms.patch
-perfctr-syscall-numbering-fixups.patch

 Folded into perfctr.patch

+split-general-cache-manager-from-cachefs-fs-fscache-cleanups.patch

 clean up split-general-cache-manager-from-cachefs.patch

-files-break-up-files-struct-warning-fix.patch

 Folded into files-break-up-files-struct.patch

-asfs-filesystem-driver-fixes.patch

 Folded into asfs-filesystem-driver.patch

-v9fs-documentation-makefiles-configuration-resend-take-2.patch

 Folded into v9fs-documentation-makefiles-configuration.patch

-v9fs-vfs-file-dentry-and-directory-operations-fix-fsf-postal-address-in-source-headers.patch
-v9fs-vfs-file-dentry-and-directory-operations-resend-take-2.patch

 Folded into v9fs-vfs-file-dentry-and-directory-operations.patch

-v9fs-vfs-inode-operations-fix-fsf-postal-address-in-source-headers.patch
-v9fs-vfs-inode-operations-resend-take-2.patch

 Folded into v9fs-vfs-inode-operations.patch

-v9fs-vfs-superblock-operations-and-glue-fix-fsf-postal-address-in-source-headers.patch
-v9fs-vfs-superblock-operations-and-glue-resend-take-2.patch
-v9fs-vfs-superblock-operations-and-glue-replace-v9fs_block_bits-with-fls.patch

 Folded into v9fs-vfs-superblock-operations-and-glue.patch

-v9fs-9p-protocol-implementation-fix-fsf-postal-address-in-source-headers.patch
-v9fs-9p-protocol-implementation-resend-take-2.patch

 Folded into v9fs-9p-protocol-implementation.patch

-v9fs-transport-modules-fix-fsf-postal-address-in-source-headers.patch
-v9fs-transport-modules-fix-timeout-segfault-corner-case.patch
-v9fs-transport-modules-resend-take-2.patch

 Folded into v9fs-transport-modules.patch

-v9fs-debug-and-support-routines-fix.patch
-v9fs-debug-and-support-routines-fix-fsf-postal-address-in-source-headers.patch
-v9fs-debug-and-support-routines-resend-take-2.patch

 Folded into v9fs-debug-and-support-routines.patch

-v9fs-clean-up-vfs_inode-and-setattr-functions-2.patch

 Folded into v9fs-clean-up-vfs_inode-and-setattr-functions.patch

+serial-add-mmio-support-to-8250_pnp.patch

 Add MMIO support to the UART driver

-device-mapper-fix-deadlocks-in-core-prep-fix.patch

 Folded into device-mapper-fix-deadlocks-in-core-prep.patch

-timer-initialization-cleanup-define_timer-pluto-fix.patch

 Folded into timer-initialization-cleanup-define_timer.patch



All 633 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/patch-list
