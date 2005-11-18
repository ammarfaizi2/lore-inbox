Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVKRHrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVKRHrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVKRHrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:47:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43214 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932569AbVKRHrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:47:06 -0500
Date: Thu, 17 Nov 2005 23:46:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1-mm2
Message-Id: <20051117234645.4128c664.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm2/


- I'm releasing this so that Hugh's MM rework can get a spin.

  Anyone who had post-2.6.14 problems related to the VM_RESERVED changes
  (device drivers malfunctioning, obscure userspace hardware-poking
  applications stopped working, etc) please test.

  We'd especially like testing of the graphics DRM drivers across as many
  card types as poss.

- cifs is busted when built as a module.  Mysteriously.

- Added the parisc devel tree to the -mm lineup as git-parisc.patch (Kyle
  McMartin <kyle@mcmartin.ca>)

- Added the powerpc devel tree to the -mm lineup as git-powerpc.patch (Paul
  MacKerras).

- Dropped the powerpc devel tree again due to refusal to boot.  Next time
  for sure.

- The JSM driver is still busted.  Make sure that CONFIG_SERIAL_JSM=n

- The UML update here is reported to cause a compile failure.



Changes since 2.6.15-rc1-mm1:

 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-drm.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-sas.patch
 git-cryptodev.patch

 Subsystem trees.

-cifs-build-fix.patch
-gregkh-usb-usb-fix-dummy_hcd-breakage.patch
-gregkh-usb-usb-serial-history-not-old.patch
-gregkh-usb-add-new-wacom-devices-to-usb-hid-core-list.patch
-gregkh-usb-usb-wacom-tablet-driver-update.patch
-gregkh-usb-usb-fix-unused-variable-warning.patch
-gregkh-usb-usb-delete-bluetty-leftovers.patch
-gregkh-usb-usbfs_dir_inode_operations-cleanup.patch
-gregkh-usb-usb-usbdevfs_ioctl-from-32bit-fix.patch
-gregkh-usb-usb-storage-blacklist-entry-removal.patch
-gregkh-usb-usb-cp2101-new-id.patch
-gregkh-usb-usb-onetouch-doesn-t-suspend-yet.patch
-gregkh-usb-usb-pl2303-adds-new-ids.patch
-gregkh-usb-usb-pl2303-updates-pl2303_update_line_status.patch
-gregkh-usb-usb-adapt-microtek-driver-to-new-scsi-features.patch
-gregkh-usb-usb-storage-fix-detection-of-kodak-flash-readers-in-shuttle_usbat-driver.patch
-gregkh-usb-usb-fix-race-in-kaweth-disconnect.patch
-gregkh-usb-usb-devio-warning-fix.patch
-gregkh-usb-usb-maxtor-onetouch-button-support-for-older-drives.patch
-gregkh-usb-usb-ohci-lh7a404-platform-device-conversion-fixup.patch
 gregkh-usb-usb-libusual.patch
-gregkh-usb-usb-serial-anydata.patch
-ipw2200-disallow-direct-scanning-when-device-is-down.patch
-cifs-read-write-operation-fixes-and-cleanups.patch
-parisc-remove-drm-compat-ioctls-handlers.patch
-parisc-implement-compat_ioctl-for-pa_perf.patch

 Merged

+tpm-remove-pci-kconfig-dependency.patch

 TPM driver cleanup

+ppc64-need-hpage_shift-when-huge-pages-disabled.patch

 ppc64 build fix

+s390-fix-class_device_create-calls-in-3270-the-driver.patch

 s390 driver fix

+uml-eliminate-use-of-local-in-clone-stub.patch
+uml-eliminate-anonymous-union-and-clean-up-symlink-lossage.patch
+uml-properly-invoke-x86_64-system-calls.patch
+uml-eliminate-use-of-libc-page_size.patch

 UML update

+unpaged-get_user_pages-vm_reserved.patch
+unpaged-private-write-vm_reserved.patch
+unpaged-sound-nopage-get_page.patch
+unpaged-unifdefed-pagecompound.patch
+unpaged-vm_unpaged.patch
+unpaged-vm_nonlinear-vm_reserved.patch
+unpaged-cow-on-vm_unpaged.patch
+unpaged-anon-in-vm_unpaged.patch
+unpaged-zero_page-in-vm_unpaged.patch
+unpaged-pg_reserved-bad_page.patch
+unpaged-copy_page_range-vma.patch

 VM_RESERVED fixes

+fix-error-handling-with-put_compat_statfs.patch

 compat handling fix

+fix-hugetlbfs_statfs-reporting-of-block-limits.patch

 Make hugetlbfs do statfs better

+git-libata-sata_mv-build-fix.patch

 Fix git-libata-all.patch

+backup-timer-for-uarts-that-lose-interrupts-take-3.patch

 Serial driver workaround for dodgy hardware.

+mm-remove-arch-independent-nodes_span_other_nodes.patch

 mm cleanup

+numa-policies-in-the-slab-allocator-v2.patch
+numa-policies-in-the-slab-allocator-v2-fix.patch

 Fix NUMA allocation via the slab allocator (still under discussion)

+mm-add-is_dma_zone-helper.patch
+mm-add-populated_zone-helper.patch

 mm cleanups

+swap-migration-v5-mpol_mf_move-interface-unpaged-fix.patch

 Fix swap-migration-v5-mpol_mf_move-interface.patch for Hugh's stuff.

+swapmig-config_migration-fixes.patch
+swapmig-add_to_swap-avoid-atomic-allocations.patch
+swapmig-drop-unused-pages-immediately.patch
+swapmig-extend-parameters-for-migrate_pages.patch

 Update the page-migration-via-swap feature.

+swsusp-remove-encryption.patch
+swsusp-introduce-the-swap-map-structure.patch
+swsusp-improve-freeing-of-memory.patch

 swsusp cleanups

+keys-permit-running-process-to-instantiate-keys-warning-fix.patch

 Fix keys-permit-running-process-to-instantiate-keys.patch

+sigaction-should-clear-all-signals-on-sig_ign-not-just-fix.patch

 Fix sigaction-should-clear-all-signals-on-sig_ign-not-just.patch

+optionally-skip-initramfs-check.patch

 Faster booting on embedded systems.

+docs-updated-some-code-docs.patch

 Documentation updates

+prefer-pkg-config-for-the-qt-check.patch

 Update `make pkg-config'.

-spufs-the-spu-file-system-base.patch
-spufs-make-all-exports-gpl-only.patch
-spufs-switchable-spu-contexts.patch
-kernel-side-context-switch-code-for-spufs.patch
-spufs-add-spu-side-context-switch-code.patch
-spufs-cooperative-scheduler-support.patch

 Dropped - these are in the git-powerpc tree which isn't here.

+kdump-i386-save-ss-esp-bug-fix.patch
+kdump-dynamic-per-cpu-allocation-of-memory-for-saving-cpu-registers.patch
+kdump-export-per-cpu-crash-notes-pointer-through-sysfs.patch
+kdump-save-registers-early-inline-functions.patch
+kdump-x86_64-add-memmmap-command-line-option.patch
+kdump-x86_64-add-elfcorehdr-command-line-option.patch
+kdump-x86_64-kexec-on-panic.patch
+kdump-x86_64-save-cpu-registers-upon-crash.patch
+kdump-read-previous-kernels-memory.patch
+kexec-increase-max-segment-limit.patch

 Kernel crashdumpiung update

-add-compat_ioctl-methods-to-dasd.patch
-add-compat_ioctl-methods-to-dasd-fix.patch

 Dropped - wrong.

+drivers-char-use-array_size-macro.patch

 Cleanup.


All 617 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm2/patch-list

