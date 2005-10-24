Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVJXItX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJXItX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 04:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVJXItX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 04:49:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750794AbVJXItV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 04:49:21 -0400
Date: Mon, 24 Oct 2005 01:48:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5-mm1
Message-Id: <20051024014838.0dd491bb.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/

- At great personal cost I managed to coax most of the USB devel tree into
  compiling and booting.  We're hoping that the changes in here will improve
  USB-related power management (suspend and resume).  Please cc
  linux-usb-devel@lists.sourceforge.net on any bug reports (or use bugzilla).

- Added git-blktrace.patch to the -mm lineup: Jens's block-layer tracing
  infrastructure.   It appears to be undocumented...

- Added git-block.patch to the -mm lineup: Jens's block tree
  (drivers/block/*.c, basically).

- Added git-mips.patch to the -mm lineup: Ralf's MIPS development tree.

- Lots more core MM changes from Hugh: mainly to address page_table_lock SMP
  scalability issuse.  All this code is in place now (I think), so performance
  testing time is here.

- Demand-paging for hugetlb pages.   Needs very careful testing.

- Added Thomas's ktimer patch.

- A number of tty drivers still won't compile.



Changes since 2.6.14-rc4-mm1:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-blktrace.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ia64.patch
 git-audit.patch
 git-jfs.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-scsi-misc.patch
 git-sas.patch
 git-cryptodev.patch

 Subsystem trees

-list-add-missing-rcu_dereference-on-first-element.patch
-ip6_tables-build-fix.patch
-svgatextmode-fix.patch
-fix-vpx3220-offset-issue-in-secam.patch
-fix-black-white-only-svideo-input-in-vpx3220.patch
-revert-orinoco-information-leakage-due-to-incorrect-padding.patch
-better-fixup-for-the-orinoco-driver.patch
-libata-build-fix.patch
-e1000_intr-build-fix.patch
-git-netedv-all-s2io-build-fix.patch
-git-netdev-all-e1000-fix.patch
-guarantee-dma-area-for-alloc_bootmem_low.patch
-mm-hugetlb-truncation-fixes.patch
-switch-sibyte-profiling-driver-to-compat_ioctl.patch
-switch-sibyte-profiling-driver-to-compat_ioctl-fix.patch
-fix-exit_itimers-vs-posix_timer_event-ab-ba-deadlock.patch
-shpchp-use-the-pci-core-for-hotplug-resource-management.patch
-shpchp-remove-redundant-display-of-pci-device-resources.patch
-shpchp-reduce-dependence-on-acpi.patch
-shpchp-detect-shpc-capability-before-doing-a-lot-of-work.patch
-shpchp-dont-save-pci-config-for-hotplug-slots-devices.patch
-shpchp-remove-redundant-data-structures.patch
-shpchp-miscellaneous-cleanups.patch
-shpchp-reduce-debug-message-verbosity.patch
-shpchp-fix-oops-at-driver-unload.patch
-au1100fb-use-preprocessor-instruction-for-error.patch
-cpufreq-kmalloc-memset-kzalloc-conversion.patch
-hwmon-kmalloc-memset-kzalloc-conversion.patch
-i2c-kmalloc-memset-kzalloc-conversion.patch
-kfree-cleanup-documentation.patch

 Merged

+alpha-atomic-dependency-fix.patch

 Alpha build fix

+git-acpi-build-fix-3.patch

 Fix git-acpi.patch

+agp-performance-fixes.patch
+agp-updates-owner-field-of-struct-pci_driver.patch

 AGP things

+nm256-reset-workaround-for-latitude-csx.patch

 Sound driver fix

+gregkh-driver-class-device.h-documentation.patch
+gregkh-driver-input-register-class_device-sooner.patch
+gregkh-driver-input-input_dev_class-export.patch
+gregkh-driver-input-class_device-move.patch
+gregkh-driver-input_oops_fix.patch
+gregkh-driver-input-remove-input_class.patch
+gregkh-driver-input-rename-input_dev_class.patch
+gregkh-driver-input_backward_compatible_symlink.patch
+gregkh-driver-input-remove-custom-hotplug.patch
+gregkh-driver-drivers-base-fix-sparse-warnings.patch
+gregkh-driver-driver-core-big-kfree-null-check-cleanup-documentation.patch

 Driver tree updates

+gregkh-i2c-i2c-owner-field-01-struct-pci-driver.patch
+gregkh-i2c-i2c-owner-field-02-struct-device-driver.patch
+gregkh-i2c-i2c-owner-field-03-i2c-keywest.patch
+gregkh-i2c-i2c-owner-field-04-i2c-core.patch
+gregkh-i2c-i2c-owner-field-05-i2c-isa.patch
+gregkh-i2c-hwmon-smsc47b397-new-id.patch
+gregkh-i2c-hwmon-missing-driver-class.patch
+gregkh-i2c-i2c-x1205.patch
+gregkh-i2c-kzalloc-01-i2c-ixp.patch
+gregkh-i2c-kzalloc-02-hwmon.patch
+gregkh-i2c-kzalloc-03-i2c-other.patch
+gregkh-i2c-kzalloc-04-drop-useless-casts.patch
+gregkh-i2c-kzalloc-05-i2c-amd756-s4882.patch
+gregkh-i2c-kzalloc-06-i2c-documentation-update.patch

 I2C tree updates

+input-evdev-allow-querying-ev_sw-from-compat_ioctl.patch
+input-add-logitech-mx3100-to-logips2ppc.patch

 Input tree updates

+git-netdev-all-ieee80211_tx-fix.patch
+git-netdev-all-ieee80211_get_payload-warning-fix.patch
+git-netdev-all-b44-build-fix.patch

 Fixes for git-netdev-all.patch

+ntfs-printk-warning-fixes.patch

 Warning fixes

+serial-remove-unneeded-code-from-serial_corec.patch

 Serial driver cleanup

+gregkh-pci-shpc-01-shpc-use-pci-core.patch
+gregkh-pci-shpc-02-remove-redundant-res-display.patch
+gregkh-pci-shpc-03-reduce-acpi-dependence.patch
+gregkh-pci-shpc-04-probe-bail-early.patch
+gregkh-pci-shpc-05-dont-save-pci-configs.patch
+gregkh-pci-shpc-06-remove-redundant-data-structures.patch
+gregkh-pci-shpc-07--misc-cleanup.patch
+gregkh-pci-shpc-08-reduce-dbg-verbosity.patch
+gregkh-pci-shpc-09-remove-sysfs-files-on-unload.patch
+gregkh-pci-pci-fix-edac-drivers-for-radisys-82600-borkage.patch
+gregkh-pci-pci-fixup-pci-driver-shutdown.patch
+gregkh-pci-pci-convert-megaraid-to-use-pci_driver-shutdown-method.patch
+gregkh-pci-acpiphp-allocate-resources-for-adapters-with-bridges.patch

 PCI tree updates

+scsi-remove-dead-code-from-src.patch
+scsi_error-thread-exits-in-task_interruptible-state.patch
+scsi-disk-report-size-without-overflow.patch

 scsi fixes

+gregkh-usb-usb-pm-01.patch
+gregkh-usb-usb-pm-02.patch
+gregkh-usb-usb-pm-03.patch
+gregkh-usb-usb-pm-04.patch
+gregkh-usb-usb-pm-05.patch
+gregkh-usb-usb-pm-06.patch
+gregkh-usb-usb-pm-07.patch
+gregkh-usb-usb-pm-08.patch
+gregkh-usb-usb-pm-10.patch
+gregkh-usb-usb-pm-11.patch
+gregkh-usb-usb-pm-12.patch
+gregkh-usb-usb-pm-13.patch
+gregkh-usb-usb-rename-hcd-hub_suspend-to-hcd-bus_suspend.patch
+gregkh-usb-uhci-improve-handling-of-iso-tds.patch
+gregkh-usb-usb-storage-another-unusual_devs-entry.patch
+gregkh-usb-usb-buffer-overflow-patch-for-yealink-driver.patch
+gregkh-usb-usb-doc-fix-kernel-doc-warning.patch
+gregkh-usb-omap_udc-dma-off-by-one-fix.patch
+gregkh-usb-fix-hcd-state-assignments-in-uhci-hcd.patch
+gregkh-usb-add-usb-transceiver-set_suspend-method.patch
+gregkh-usb-usb-s3c2410-ohci-add-driver-owner-field.patch
+gregkh-usb-usb-gadget-drivers-add-.owner-initialisation.patch
+gregkh-usb-usb-add-owner-initialisation-to-host-drivers.patch
+gregkh-usb-missing-transfer_flags-setting-in-usbtest.patch
+gregkh-usb-usb-remove-devio-global.patch
+gregkh-usb-usb-notify-devices-and-busses.patch
+gregkh-usb-usb-use-notifier-devio.patch
+gregkh-usb-usb-use-notifier-inode.patch
+gregkh-usb-usb-use-notifier-usbmon.patch
+gregkh-usb-usb-patch-for-usbdevfs_ioctl-from-32-bit-programs.patch
+gregkh-usb-usb-remove-bluetty.patch
+gregkh-usb-usb-serial-driver-cleanup-01.patch
+gregkh-usb-usb-serial-driver-cleanup-02.patch
+gregkh-usb-usb-serial-driver-cleanup-03.patch
+gregkh-usb-usb-serial-driver-cleanup-04.patch
+gregkh-usb-usb-serial-driver-cleanup-05.patch

 USB tree updates (gregkh-usb-usb-pm-09.patch breaks one of my machines)

+gregkh-usb-usb-rename-hcd-hub_suspend-to-hcd-bus_suspend-fix.patch
+gregkh-usb-usb-rename-hcd-hub_suspend-to-hcd-bus_suspend-config_pm-fix.patch
+gregkh-usb-usb-serial-driver-cleanup-01-fixes.patch
+gregkh-usb-usb-serial-driver-cleanup-04-fixes.patch
+gregkh-usb-usb-serial-driver-cleanup-04-keyspan-fixes.patch
+gregkh-usb-usb-patch-for-usbdevfs_ioctl-from-32-bit-programs-fix.patch
+gregkh-usb-usb-pm-04-fix.patch
+gregkh-usb-usb-pm-03-fix.patch
+export-usb_suspend_device.patch

 All the fixes I had to do, dammit.

+x86_64-intel-multi-core.patch
+x86_64-intel-cache.patch

 x86_64 tree updates

+clean-crypto-sha1c-up-a-bit.patch

 crypto cleanup

+touchkit-ps-2-touchscreen-driver.patch
+touchkit-ps-2-touchscreen-driver-fixes.patch

 New touchscreen driver

+mm-rss-=-file_rss-anon_rss-warning-fix.patch

 Fix mm-rss-=-file_rss-anon_rss.patch

+core-remove-pagereserved-fix.patch

 Fix core-remove-pagereserved.patch

+mm-i386-sh-sh64-ready-for-split-ptlock.patch
+mm-arm-ready-for-split-ptlock.patch
+mm-parisc-pte-atomicity.patch
+mm-cris-v32-mmu_context_lock.patch
+mm-uml-pte-atomicity.patch
+mm-uml-kill-unused.patch
+mm-split-page-table-lock.patch
+mm-split-page-table-lock-fixes.patch
+mm-split-page-table-lock-fixes-2.patch
+mm-split-page-table-lock-fixes-3.patch
+mm-fix-rss-and-mmlist-locking.patch
+mm-update-comments-to-pte-lock.patch

 More core MM rework from Hugh.

+hugetlb-demand-fault-handler.patch
+hugetlb-overcommit-accounting-check.patch
+hugetlb-overcommit-accounting-check-fix.patch

 Demand-paging for hugetlb pages

+mm-swap-prefetch-magnify.patch

 Swap prefetching tuning

+mm-wider-use-of-for_each_cpu.patch
+mm-filemapcfilemap_populate-move-export.patch

 mm cleanups

+net-wider-use-of-for_each_cpu.patch
+netlink-remove-dead-code-in-af_netlinkc.patch
+ipv4-remove-dead-code-from-ip_outputc.patch
+fix-behavior-of-ip6_route_input-for-link-local-address.patch

 Net fixes

+3c59x-dont-enable-scatter-gather-w-o-checksum.patch

 3Com net driver fix

+revert-orinoco-information-leakage-due-to-incorrect-padding.patch
+better-fixup-for-the-orinoco-driver.patch

 Orinoco driver tweaks

+e1000-fixes-e1000_suspend-warning-when-config_pm-is-not.patch

 Warning fix

+acx-update-2.patch

 Update to the acx1xx wireless driver in -mm.

+selinux-remove-unecessary-size_t-checks-in-selinuxfs.patch

 Cleanup

+ppc32-85xx-phy-platform-update.patch
+ppc32-ppc_sys-fixes-for-8xx-and-82xx.patch

 ppc32 updates

+various-powerpc-32bit-ppc64-build-fixes.patch
+ppc64-reenable-make-install-with-defconfig.patch
+ppc64-change-name-of-target-file-during-make-install.patch
+ppc64-remove-duplicate-local-variable-in-set_preferred_console.patch

 ppc64 updates

+i386-move-apic-init-in-init_irqs-fix.patch

 Fix i386-move-apic-init-in-init_irqs.patch

+x86-inline-spin_unlock-if-not-config_debug_spinlock-and-not-config_preempt.patch
+x86-inline-spin_unlock_irq-if-not-config_debug_spinlock-and-not-config_preempt.patch
+allow-users-to-force-a-panic-on-nmi.patch

 x86 tweaks

+wistron-laptop-button-driver.patch
+wistron-laptop-button-driver-x86_64-fix.patch

 Little laptop button driver

+x86_64-two-timer-entries-in-sys.patch

 Fix duplicated sysfs entry on x86_64

+sharp-sl-5500-touchscreen-support.patch
+support-pcmcia-slot-on-sharp-sl-5500.patch

 Sharp SL driver work

+swsusp-reduce-the-use-of-global-variables.patch
+swsusp-remove-unneccessary-includes.patch
+swsusp-cleanups.patch
+swsusp-get-rid-of-unnecessary-wrapper-function.patch
+swsusp-two-simplifications.patch

 swsusp stuff

+get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks-tda9887-fix.patch

 Fix get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks.patch

+cpuset-remove-depth-counted-locking-hack.patch
+cpuset-dual-semaphore-locking-overhaul.patch
+cpuset-simple-rename.patch
+cpuset-confine-pdflush-to-its-cpuset.patch

 cpusets updates

+keys-get-rid-of-warning-in-kmodc-if-keys-disabled.patch

 key management warning fix

+setkeys-needs-root.patch

 The setkeys command now requires elevated caps

+extable-remove-needless-declaration.patch

 Cleanup

+modules-fix-sparse-warning-for-every-module_parm.patch

 sparse fixes

+compat-fcntl-fixes.patch

 Fix compat_fcntl()

+fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set.patch

 Fix dcache accounting
+test-for-sb_getblk-return-value.patch
+test-for-sb_getblk-return-value-fixes.patch

 Check for sb_getblk() errors.

+fix-vgacon-blanking.patch

 Fix blanking on the VGA console

+ktimers-kt2.patch
+ktimers-kt2-gcc-295-fix.patch
+ktimers-kt2-sparc64-fix.patch

 Kernel timer infrastructure

+epca-updates-owner-field-of-struct-pci_driver.patch
+synclink-adapters-updates-owner-field-of-struct-pci_driver.patch
+watchdog-update-owner-field-of-struct-pci_driver.patch

 sysfs friendliness for a few drivers

+include-linux-kernelhbuild_bug_on-fix-a-comment.patch

 Comment fix

+fs-attrc-remove-bug.patch

 Removed redundant check

+rcu-torture-testing-kernel-module.patch

 In-kernel testbed for the RCU core

+propogate-gfp_t-changes-further.patch

 Warning fixes

+ib-add-idr_destroy-calls-on-module-unload.patch

 Infiniband microleak fix

+posix-cpu-timers-fix-overrun-reporting.patch

 Fix posix CPU timers

-edac-drivers-for-radisys-82600-gregkh-borkage.patch

 Dropped

+edac-core-edac-support-code-fixes-2.patch
+edac-core-edac-support-code-fixes-3.patch
+edac-clean-up-atomic-stuff.patch

 EDAC driver updates

+hpet-allow-hpet-fixed_mem32-resource-type.patch
+hpet-use-hpet-physical-addresses-for-dup.patch
+hpet-hpet-driver-cleanups.patch

 HPET updates

+remove-duplicate-code-in-signalc.patch

 Cleanup

+ipmi-use-refcount-in-message-handler.patch
+ipmi-various-si-cleanup.patch
+ipmi-watchdog-parms-in-sysfs.patch
+ipmi-poweroff-cleanups.patch
+ipmi-more-dell-fixes.patch
+ipmi-si-start-transaction-hook.patch
+ipmi-bt-restart-reset-fixes.patch
+ipmi-kcs-error0-delay.patch
+ipmi-add-timer-thread.patch

 IPMI updates

+udf-fix-issues-reported-by-coverity-in-inodec.patch
+udf-fix-issues-reported-by-coverity-in-nameic.patch
+ipmi-fix-issues-reported-by-coverity-in-ipmi_msghandlerc.patch
+kernel-modulec-removed-dead-code.patch

 Fix a few things from the Coverity checker

+dvb-usb-urb-printk-fix.patch

 Warning fix

-deprecate-openfoo-3.patch

 Dropped (it got a reject and I'm not really convinced about it)

+reiser4-page-private-fixes.patch

 Update reiser4 for mm changes.

+serial-new-hp-diva-console-port.patch

 Serial driver update

+rocketpoint-1520-fails-clock-stabilization-fix.patch

 Fix rocketpoint-1520-fails-clock-stabilization.patch

+ide-explain-the-pci-bus-test.patch

 Comment update

+nvidiafb-fix-mode-setting-ppc-support-fix.patch

 Fix nvidiafb-fix-mode-setting-ppc-support.patch

+fbcon-fbdev-move-softcursor-out-of-fbdev-to-fbcon.patch
+fbcon-consolidate-redundant-code.patch
+fbcon-use-helper-function-when-filling-out-var-structure.patch
+fbcon-initialize-new-driver-when-old-driver-is-released.patch
+fbdev-remove-software-clipping-from-drawing.patch
+vesafb-fix-color-palette-handling.patch
+atyfb-get-initial-mode-timings-from-lcd-bios.patch
+savagefb-convert-from-vga-io-access-to-mmio-access.patch
+pm2fb-manual-configuration-of-timings-for-elsa-winner.patch
+fbdev-workaround-for-buggy-edid-blocks.patch
+nvidiafb-fix-empty-macro.patch
+fbdev-fix-the-fb_find_nearest_mode-function.patch
+s3c2410fb-initialise-device_driver-owner.patch
+vesafb-disable-mtrr-as-the-default.patch
+i810fb-cleanup-i2c-code.patch
+console-fix-compile-error.patch
+fbcon-add-rl-roman-large-font.patch

 fbdev updates

+doc-hpettxt-change-to-80-columns.patch
+more-kernel-doc-cleanups-additions.patch

 kerneldoc updates

+serial-disable-jsm-in-ppc64-defconfig.patch

 Disable one currently-broken tty driver in defconfig

+isicom-pci-probing-added-fix.patch

 Fix isicom-pci-probing-added.patch



All 1059 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/patch-list


