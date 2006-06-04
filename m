Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751247AbWFDGUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWFDGUR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 02:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFDGUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 02:20:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751247AbWFDGUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 02:20:14 -0400
Date: Sat, 3 Jun 2006 23:20:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm3
Message-Id: <20060603232004.68c4e1e3.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/

- Lots of PCI and USB updates

- The various lock validator, stack backtracing and IRQ management problems
  are converging, but we're not quite there yet.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it is not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.




Changes since 2.6.17-rc5-mm2:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-cpufreq-fixup.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-intelfb.patch
 git-klibc.patch
 git-hdrcleanup.patch
 git-hdrinstall.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-cryptodev.patch

 git trees

-drivers-usb-core-devioc-dereference-userspace-pointer.patch
-nbd-endian-annotations.patch
-cifs-build-fix.patch
-git-cifs-kconfig-fix.patch
-cifs-do-not-overwrite-aops-elements.patch
-scx200_acb-use-pci-i-o-resource-when-appropriate-fix.patch
-git-mtd-cs553x_nand-build-fix.patch
-pmf_register_irq_client-gives-sleep-with-locks-held-warning.patch
-64-bit-resources-arch-powerpc-changes-update.patch
-fix-pciehp-compile-issue-when-config_acpi-is-not.patch
-gregkh-pci-pci-64-bit-resources-drivers-others-changes-amba-fix.patch
-i386-export-memory-more-than-4g-through-proc-iomem.patch
-pci-pci-64-bit-resources-arch-changes-update.patch
-improve-pci-config-space-writeback.patch
-reverse-pci-config-space-restore-order.patch
-pci-add-pci_assign_resource_fixed-allow-fixed-address.patch
-add-a-enable-sysfs-attribute-to-the-pci-devices-to-allow.patch
-fix-recovery-path-from-errors-during-pcie_init.patch
-move-various-pci-ids-to-header-file.patch
-kconfigurable-resources-core-changes.patch
-kconfigurable-resources-core-changes-i386-fix.patch
-kconfigurable-resources-core-changes-fix.patch
-kconfigurable-resources-driver-pci-changes.patch
-kconfigurable-resources-driver-others-changes.patch
-kconfigurable-resources-arch-dependent-changes-arch-a-i.patch
-kconfigurable-resources-arch-dependent-changes-arch-a-i-fix.patch
-kconfigurable-resources-arch-dependent-changes-arch-j-p.patch
-kconfigurable-resources-arch-dependent-changes-arch-q-z.patch
-typesh-sector_t-and-blkcnt_t-arent-for-userspace.patch
-allow-msi-to-work-on-kexec-kernel.patch
-pci-disable-msi-mode-in-pci_disable_device.patch
-pci-dont-move-ioapics-below-pci-bridge.patch
-git-scsi-rc-fixes.patch
-scsi-properly-count-the-number-of-pages-in-scsi_req_map_sg-fix.patch
-revert-gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch
-gregkh-usb-usb-serial-mos7720-powerpc-wrokaround.patch
-usb-add-sierra-wireless-mc5720-id-to-airprimec.patch
-usb-negative-index-in-drivers-usb-host-isp116x-hcdc.patch
-xfs-sparc32-build-fix.patch
-add-pci_cap_id_vndr.patch

 Merged into mainline or a subsystem tree

+alpha-smp-irq-routing-fix.patch
+fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path.patch
+fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path-fix.patch
+pmf_register_irq_client-gives-sleep-with-locks-held-warning.patch
+implement-get--set-tso-for-forcedeth-driver.patch
+fix-hpet-operation-on-32-bit-nvidia-platforms.patch
+fix-hpet-operation-on-32-bit-nvidia-platforms-build-fix.patch
+fix-hpet-operation-on-64-bit-nvidia-platforms.patch
+maintainers-add-entries-for-bnx2-and-tg3.patch
+sbp2-fix-check-of-return-value-of.patch
+sata_sil24-sii3124-sata-driver-endian-problem.patch
+m48t86-ia64-build-fix.patch
+m68k-get_user-build-fix.patch
+uml-add-asm-irqflagsh.patch
+uml-fix-wall_to_monotonic-initialization.patch
+uml-fix-a-typo-in-do_uml_initcalls.patch
+uml-__user-annotation-in-arch_prctl.patch
+uml-more-__user-annotations.patch
+uml-add-ffreestanding-to-cflags.patch

 2.6.17 queue

+kevent-add-new-uevent.patch

 Required for acpi-dock-driver.patch

-acpi-dock-driver-v3.patch
-acpi-dock-driver-v4.patch
-acpi-dock-driver-interface-fixups.patch

 Folded into acpi-dock-driver.patch

-acpiphp-use-new-dock-driver-fix.patch
-acpiphp-use-new-dock-driver-v2.patch

 Folded into acpiphp-use-new-dock-driver.patch

-acpi-atlas-acpi-driver-v2-tidy.patch

 Folded into acpi-atlas-acpi-driver.patch

+acpi-atlas-acpi-driver-fix.patch

 Fix acpi-atlas-acpi-driver.patch

+ieee1394-video1394-be-quiet.patch
+ieee1394-ohci1394c-function-calls-without.patch
+ieee1394-sbp2-make-tsb42aa9-workaround-specific.patch
+ieee1394-semaphore-to-mutex-conversion.patch
+ieee1394-raw1394-fix-whitespace-after-x86_64.patch
+ieee1394-ieee1394-ohci1394-cycletoolong.patch
+ieee1394-ieee1394-support-for-slow-links-or-slow.patch
+ieee1394-ieee1394-save-ram-by-using-a-single.patch
+ieee1394-sbp2-remove-manipulation-of-inquiry.patch
+ieee1394-sbp2-log-number-of-supported-concurrent.patch
+ieee1394-ieee1394-extend-lowlevel-api-for.patch
+ieee1394-ohci1394-set-address-range-properties.patch
+ieee1394-ohci1394-make-phys_dma-parameter.patch
+ieee1394-sbp2-sbp2-remove-ohci1394-specific.patch
+ieee1394-sbp2-fix-s800-transfers-if-phys_dma-is.patch
+ieee1394-update-feature-removal-of-obsolete.patch
+ieee1394-sbp2-provide-helptext-for.patch
+ieee1394-sbp2-kconfig-fix.patch
+ieee1394-sbp2-use-__attribute__packed-for.patch
+ieee1394-sbp2-fix-deregistration-of-status-fifo-address-space.patch
+ieee1394-add-preprocessor-constant-for-invalid-csr.patch
+eth1394-endian-fixes.patch

 ieee1394 updates

-ieee1394_core-switch-to-kthread-api-fix.patch

 Folded into ieee1394_core-switch-to-kthread-api.patch

-input-fix-oops-on-mk712-load.patch

 Dropped

-via-pmu-add-input-device-tidy.patch

 Folded into via-pmu-add-input-device.patch

-input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick-update.patch

 Folded into input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick.patch

-input-logitech-trackman-trackball-support.patch

 Dropped (I think)

-input-new-force-feedback-interface-fix.patch

 Folded into input-new-force-feedback-interface.patch

+kconfig-integrate-split-config-into-silentoldconfig-fix.patch

 Folded into kconfig-integrate-split-config-into-silentoldconfig.patch

+kbuild-obj-dirs-is-calculated-incorrectly-if-hostprogs-y-is-defined.patch
+fix-make-rpm-for-powerpc.patch

 kbuild fixes

+revert-sata_sil24-sii3124-sata-driver-endian-problem.patch

 Revert earlier patch so that git-libata-all applies OK.

+libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma-fix.patch

 Fix libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma.patch

+prevent-au1xmmcc-breakage-on-non-au1200-alchemy.patch

 mmc driver fix

+myri10ge-alpha-build-fix.patch

 Fix git-netdev-all.patch

+forcedeth-config-ring-sizes.patch
+forcedeth-config-flow-control.patch
+forcedeth-config-phy.patch
+forcedeth-config-wol.patch
+forcedeth-config-csum.patch
+forcedeth-config-statistics.patch
+forcedeth-config-diagnostics.patch
+forcedeth-config-module-parameters.patch
+forcedeth-config-version.patch
+forcedeth-new-device-ids.patch
+forcedeth-typecast-cleanup.patch

 forcedeth updates

+lock-validator-netlinkc-netlink_table_grab-fix.patch

 netlink locking fix

+recent-match-fix-sleeping-function-called-from-invalid-context.patch
+recent-match-missing-refcnt-initialization.patch

 netfilter fixes

-fix-for-serial-uart-lockup.patch

 Dropped.

+gregkh-pci-pci-add-pci_cap_id_vndr.patch
+gregkh-pci-pci-fix-pciehp-compile-issue-when-config_acpi-is-not-enabled.patch
+gregkh-pci-pci-64-bit-resource-fixup-pci-resource-dbg-code-to-handle-size-change.patch
+gregkh-pci-pci-64-bit-resource-fix-amba-build-warning.patch
+gregkh-pci-pci-64-bit-resources-fix-pnp-sysfs-interface.patch
+gregkh-pci-pci-64-bit-resources-arch-powerpc-changes-update.patch
+gregkh-pci-kconfigurable-resources-core-changes.patch
+gregkh-pci-kconfigurable-resources-driver-pci-changes.patch
+gregkh-pci-kconfigurable-resources-driver-others-changes.patch
+gregkh-pci-kconfigurable-resources-arch-dependent-changes.patch
+gregkh-pci-kconfigurable-resources-arch-dependent-changes-arch.patch
+gregkh-pci-kconfigurable-resources-arch-dependent-changes-arch-q-z.patch
+gregkh-pci-i386-export-memory-more-than-4g-through-proc-iomem.patch
+gregkh-pci-pci-error-handling-on-pci-device-resume.patch
+gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
+gregkh-pci-pciehp-dont-call-pci_enable_dev.patch
+gregkh-pci-pci-improve-pci-config-space-writeback.patch
+gregkh-pci-pci-reverse-pci-config-space-restore-order.patch
+gregkh-pci-pci-add-pci_assign_resource_fixed-allow-fixed-address-assignments.patch
+gregkh-pci-pci-add-a-enable-sysfs-attribute-to-the-pci-devices-to-allow-userspace-to-enable-devices-without-doing-foul-direct-access.patch
+gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch
+gregkh-pci-pci-acpi-rename-the-functions-to-avoid-multiple-instances.patch
+gregkh-pci-acpi_pcihp-fix-programming-_hpp-values.patch
+gregkh-pci-acpi_pcihp-remove-improper-error-message-about-oshp.patch
+gregkh-pci-acpi_pcihp-add-support-for-_hpx.patch
+gregkh-pci-pciehp-fix-programming-hotplug-parameters.patch
+gregkh-pci-shpc-cleanup-shpc-register-access.patch
+gregkh-pci-shpc-cleanup-shpc-logical-slot-register-access.patch
+gregkh-pci-shpc-cleanup-shpc-logical-slot-register-bits-access.patch
+gregkh-pci-shpc-fix-shpc-logical-slot-register-bits-access.patch
+gregkh-pci-shpc-fix-shpc-contoller-serr-int-register-bits-access.patch
+gregkh-pci-shpchp-mask-global-serr-and-intr-at-controller-release-time.patch
+gregkh-pci-shpchp-create-shpchpd-at-controller-probe-time.patch
+gregkh-pci-pci-i386-x86_84-disable-pci-resource-decode-on-device-disable.patch
+gregkh-pci-sgi-hotplug-incorrect-power-status.patch
+gregkh-pci-pci-bus-parity-status-broken-hardware-attribute-edac-foundation.patch
+gregkh-pci-pci-hotplug-fix-recovery-path-from-errors-during-pcie_init.patch
+gregkh-pci-pciehp-replace-pci_find_slot-with-pci_get_slot.patch
+gregkh-pci-pciehp-add-missing-pci_dev_put.patch
+gregkh-pci-pciehp-implement-get_address-callback.patch
+gregkh-pci-shpchp-remove-unnecessary-hpc_ctlr_handle-check.patch
+gregkh-pci-shpchp-cleanup-interrupt-handler.patch
+gregkh-pci-shpchp-cleanup-shpc-commands.patch
+gregkh-pci-shpchp-cleanup-interrupt-polling-timer.patch
+gregkh-pci-shpchp-remove-unused-hpc_evelnt_lock.patch
+gregkh-pci-shpchp-cleanup-improper-info-messages.patch
+gregkh-pci-pci-move-various-pci-ids-to-header-file.patch
+gregkh-pci-pci-amd-8131-msi-quirk-called-too-late-bus_flags-not-inherited.patch
+gregkh-pci-pci-allow-msi-to-work-on-kexec-kernel.patch
+gregkh-pci-pci-disable-msi-mode-in-pci_disable_device.patch
+gregkh-pci-pci-hotplug-fake-null-pointer-dereferences-in-ibm-hot-plug-controller-driver.patch
+gregkh-pci-pci-cleanup-unused-variable-about-msi-driver.patch
+gregkh-pci-pci-don-t-move-ioapics-below-pci-bridge.patch
+gregkh-pci-pci-remove-unneeded-msi-code.patch
+gregkh-pci-pci-clean-up-pci-documentation-to-be-more-specific.patch
+gregkh-pci-pci-fix-race-with-pci_walk_bus-and-pci_destroy_dev.patch
+gregkh-pci-pci-test-that-drivers-properly-call-pci_set_master.patch

 PCI tree updates

+revert-gregkh-pci-pci-test-that-drivers-properly-call-pci_set_master.patch
+gregkh-pci-kconfigurable-resources-arch-dependent-changes-arm-fix.patch
+gregkh-pci-pci-64-bit-resources-core-changes-mips-fix.patch

 Unbreak it.

-bogus-disk-geometry-on-large-disks-warning-fix.patch

 Folded into bogus-disk-geometry-on-large-disks.patch

-areca-raid-linux-scsi-driver-update6-for-2617-rc1-mm3.patch
-areca-raid-linux-scsi-driver-update6-for-2617-rc1-mm3-externs-go-in-headers.patch

 Folded into areca-raid-linux-scsi-driver.patch

+git-scsi-target-fixup.patch

 Fix reject in git-scsi-target.patch.

+gregkh-usb-usb-whiteheat-fix-firmware-spurious-errors.patch
+gregkh-usb-usb-add-sierra-wireless-mc5720-id-to-airprime.c.patch
+gregkh-usb-usb-negative-index-in-drivers-usb-host-isp116x-hcd.c.patch
+gregkh-usb-usb-cdc_ether-recognize-olympus-r1000.patch
+gregkh-usb-usbcore-port-reset-for-composite-devices.patch
+gregkh-usb-usb-hub-use-usb_reset_composite_device.patch
+gregkh-usb-usb-storage-use-usb_reset_composite_device.patch
+gregkh-usb-usbhid-use-usb_reset_composite_device.patch
+gregkh-usb-usbcore-recovery-from-set-configuration-failure.patch
+gregkh-usb-usb-drivers-usb-core-devio.c-dereferences-a-userspace-pointer.patch
+gregkh-usb-usb-new-devices-for-the-option-driver.patch

 USB tree updates

+x86_64-mm-acpi-blacklist-xw9300.patch
+x86_64-mm-apic-support-for-extended-apic-interrupt.patch
+x86_64-mm-mce_amd-relocate-sysfs-files.patch
+x86_64-mm-mce_amd-support-for-family-0x10-processors.patch
+x86_64-mm-mce_amd-cleanup.patch
+x86_64-mm-miscellaneous-mm-initc-fixes.patch

 x86_64 tree updates

+fall-back-to-old-style-call-trace-if-no-unwinding.patch
+allow-unwinder-to-build-without-module-support.patch

 Fix it.

+mm-slabc-fix-early-init-assumption.patch

 slab fix

+tiacx-ia64-fix.patch

 wireless driver fix

+selinux-add-hooks-for-key-subsystem.patch

 Wire the key management subsystem into selinux.

+powerpc-vdso-updates.patch

 powerpc update

+remove-empty-node-at-boot-time.patch

 NUMA fixlet.

+jbd-fix-bug-in-journal_commit_transaction-fix.patch

 Fix jbd-fix-bug-in-journal_commit_transaction.patch

+ufs-easy-debug.patch
+ufs-little-directory-lookup-optimization.patch
+ufs-i_blocks-wrong-count.patch
+ufs-unlock_super-without-lock.patch
+ufs-zero-metadata.patch
+ufs-printk-warning-fixes.patch

 More UFS fixes

-inotify-kernel-api.patch
-inotify-kernel-api-fix.patch
+inotify-split-kernel-api-from-userspace-support.patch
+inotify-add-names-inode-to-event-handler.patch
+inotify-add-interfaces-to-kernel-api.patch
+inotify-allow-watch-removal-from-event-handler.patch
+inotify-update-kernel-documentation.patch

 Updated inotify patch series

+lock-validator-introduce-warn_on_oncecond-speedup.patch

 Fix lock-validator-introduce-warn_on_oncecond.patch

+add-max6902-rtc-support-update.patch

 Fix add-max6902-rtc-support.patch

+nbd-endian-annotations.patch
+epoll-use-unlocked-wqueue-operations.patch

 misc updates

+per-task-delay-accounting-taskstats-interface-fix-2.patch

 Fix per-task-delay-accounting-taskstats-interface-fix-1.patch

+sched-fix-smt-nice-lock-contention-and-optimization.patch
+sched-fix-smt-nice-lock-contention-and-optimization-tidy.patch

 CPu scheduler scability improvements.

+namespaces-utsname-sysctl-hack-cleanup-2-fix.patch

 Fix namespaces-utsname-sysctl-hack-cleanup-2.patch

+reiser4-hardirq-include-fix.patch

 Fix reiser4.patch

+skeletonfb-remove-duplicate-module-init-exit-license-lines.patch
+neofb-fix-unblank-logic-interfering-with-lid-toggled-backlight.patch

 fbdev updates

+statistics-infrastructure-prerequisite-timestamp-fix.patch

 Fix statistics-infrastructure-prerequisite-timestamp.patch

+genirq-msi-fixes-2.patch

 Fix genirq-core.patch

+genirq-add-irq-chip-support-fix.patch

 Fix genirq-add-irq-chip-support.patch

+genirq-add-chip-eoi-fastack-fasteoi-fix.patch

 Fix genirq-add-chip-eoi-fastack-fasteoi.patch

+lock-validator-floppyc-irq-release-fix-fix.patch

 Fix lock-validator-floppyc-irq-release-fix.patch

+lock-validator-locking-api-self-tests-self-test-fix.patch

 Fix lock-validator-locking-api-self-tests.patch

+lock-validator-beautify-x86_64-stacktraces-fix-2.patch
+lock-validator-beautify-x86_64-stacktraces-fix-3.patch
+lock-validator-beautify-x86_64-stacktraces-fix-4.patch

 Fix lock-validator-beautify-x86_64-stacktraces.patch some more.

+lock-validator-x86_64-irqflags-trace-entrys-fix.patch

 Fix lock-validator-irqtrace-cleanup-include-asm-x86_64-irqflagsh.patch

+lock-validator-core-early_boot_irqs_-build-fix.patch
+lock-validator-core-fix-compiler-warning.patch

 Fix lock-validator-core.patch

+lock-validator-special-locking-serio.patch
+lockdep-add-i_mutex-ordering-annotations-to-the-sunrpc.patch
+lockdep-add-parent-child-annotations-to-usbfs.patch

 lockdep workarounds

+i386-remove-multi-entry-backtraces.patch

 More work on x86 backtraces.


All 1492 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/patch-list

