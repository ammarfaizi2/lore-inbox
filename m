Return-Path: <linux-kernel-owner+w=401wt.eu-S1762660AbWLKI63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762660AbWLKI63 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762663AbWLKI63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:58:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60368 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762660AbWLKI6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:58:25 -0500
Date: Mon, 11 Dec 2006 00:58:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-mm1
Message-Id: <20061211005807.f220b81c.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

	http://userweb.kernel.org/~akpm/2.6.19-mm1/

Will appear later at

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/


- There's some new runtime debugging in kmap_atomic().  It catches one
  buglet in in ata_scsi_rbuf_get() - there may be others.  If it gets too
  noisy, please revert kmap_atomic-debugging.patch.

- The reiser4 build is broken by some VFS changes I made.

- New git tree git-ubi.patch (Artem Bityutskiy <dedekind@infradead.org>):

    It is a kind of LVM layer but for flash (MTD) devices which hides
    flash devices complexities like bad eraseblocks (on NANDs) and wear.  The
    documentation is available at the MTD web site:
    http://www.linux-mtd.infradead.org/doc/ubi.html
    http://www.linux-mtd.infradead.org/faq/ubi.html

- The x86_64 tree here is a few days old - the server is down.

- Brought back the write()-deadlock-fix-and-writev-speedup patches.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git tag v2.6.16-rc2-mm1
  git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

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

- When reporting bugs in this kernel via email, please also rewrite the
  email Subject: in some manner to reflect the nature of the bug.  Some
  developers filter by Subject: when looking for messages to read.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.




Changes since 2.6.19-rc6-mm2:


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-cpufreq.patch
 git-gfs2-nmw.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-jfs.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mmc.patch
 git-mmc-fixup.patch
 git-mtd.patch
 git-ubi.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-chelsio.patch
 git-pciseg.patch
 git-sh.patch
 git-block.patch
 git-sas.patch
 git-qla3xxx.patch
 git-gccbug.patch

 git trees.

-fix-create_write_pipe-error-check.patch
-ecryptfs-fix-crypto_alloc_blkcipher-error-check.patch
-make-drivers-acpi-baycdrive_bays-static.patch
-acpi-asus-s3-resume-fix.patch
-sound-soc-soc-dapmc-make-4-functions-static.patch
-gregkh-driver-driver-link-sysfs-timing.patch
-gregkh-driver-cleanup-virtual_device_parent.patch
-gregkh-driver-config_sysfs_deprecated.patch
-gregkh-driver-udev-compatible-hack.patch
-gregkh-driver-config_sysfs_deprecated-bus.patch
-gregkh-driver-config_sysfs_deprecated-device.patch
-gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
-gregkh-driver-config_sysfs_deprecated-class.patch
-gregkh-driver-vt-device.patch
-gregkh-driver-vc-device.patch
-gregkh-driver-misc-devices.patch
-gregkh-driver-tty-device.patch
-gregkh-driver-raw-device.patch
-gregkh-driver-i2c-dev-device.patch
-gregkh-driver-msr-device.patch
-gregkh-driver-cpuid-device.patch
-gregkh-driver-ppp-device.patch
-gregkh-driver-ppdev-device.patch
-gregkh-driver-mmc-device.patch
-gregkh-driver-firmware-device.patch
-gregkh-driver-fb-device.patch
-gregkh-driver-mem-devices.patch
-gregkh-driver-sound-device.patch
-gregkh-driver-network-device.patch
-gregkh-driver-acpi-change-acpi-to-use-dev_archdata-instead-of-firmware_data.patch
-gregkh-driver-cpu-topology-consider-sysfs_create_group-return-value.patch
-gregkh-driver-sysfs-sysfs_write_file-writes-zero-terminated-data.patch
-gregkh-driver-driver-core-introduce-device_find_child.patch
-gregkh-driver-driver-core-make-drivers-base-core.c-setup_parent-static.patch
-gregkh-driver-driver-core-introduce-device_move-move-a-device-to-a-new-parent.patch
-gregkh-driver-driver-core-use-klist_remove-in-device_move.patch
-gregkh-driver-driver-core-platform_driver_probe-can-save-codespace.patch
-gregkh-driver-documentation-driver-model-platform.txt-update-rewrite.patch
-gregkh-driver-modules-drivers.patch
-gregkh-driver-driver-core-fixes-sysfs_create_link-retval-checks-in-core.c.patch
-fix-gregkh-driver-sound-device.patch
-fix-gregkh-driver-sound-device-2.patch
-platform_driver_probe-can-save-codespace-save-codespace.patch
-git-dvb-budget-ci-fix.patch
-jdelvare-hwmon-hwmon-unchecked-return-status-fixes-abituguru.patch
-git-input-fixup.patch
-input-check-whether-serio-dirver-registration-is-completed.patch
-pa-risc-fix-bogus-warnings-from-modpost.patch
-kconfig-refactoring-for-better-menu-nesting.patch
-kbuild-fix-rr-is-now-default.patch
-pata_hpt366-more-enable-bits.patch
-pata-libata-suspend-resume-simple-cases.patch
-pata-libata-suspend-resume-simple-cases-fix.patch
-pata_cmd64x-suspend-resume.patch
-pata_cs5520-resume-support.patch
-pata_jmicron-fix-jmb368-support-add-suspend-resume.patch
-pata_cs5530-suspend-resume-support.patch
-pata_rz1000-force-readahead-off-on-resume.patch
-pata_ali-suspend-resume-support.patch
-pata_sil680-suspend-resume.patch
-sata_promise-updates.patch
-sata_nv-fix-atapi-in-adma-mode.patch
-pata_it821x-suspend-resume-support.patch
-pata_serverworks-suspend-resume.patch
-pata_via-suspend-resume-support.patch
-pata_amd-suspend-resume.patch
-hpt36x-suspend-resume-support.patch
-pata_hpt3x3-suspend-resume-support.patch
-pata-more-drivers-that-need-only-standard-suspend-and.patch
-pata_marvell-merge-mandriva-patches.patch
-via-pata-controller-xfer-fixes.patch
-via-pata-controller-xfer-fixes-fix.patch
-libata_resume_fix.patch
-ahci-ati-sb600-sata-support-for-various-modes.patch
-mtd-fix-printk-format-warning.patch
-mtd-replace-kmallocmemset-with-kzalloc.patch
-make-drivers-mtd-cmdlinepartcmtdpart_setup-static.patch
-spidernet-remove-eth_zlen-check-in-earlier-patch.patch
-spidernet-poor-network-performance.patch
-bonding-incorrect-bonding-state-reported-via-ioctl.patch
-declance-fix-pmax-and-pmad-support.patch
-tulip-dmfe-carrier-detection.patch
-tulip-dmfe-carrier-detection-fix.patch
-net-possible-cleanups.patch
-net-possible-cleanups-fix.patch
-net-possible-cleanups-fix-2.patch
-fix-sunrpc-wakeup-execute-race-condition.patch
-gregkh-pci-pci-multithread-not-broken.patch
-gregkh-pci-pci-make-some-msi-x-defines-generic.patch
-gregkh-pci-pci-save-restore-pci-x-state.patch
-gregkh-pci-pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks.patch
-gregkh-pci-pci-use-pci_generic_prep_mwi-on-ia64.patch
-gregkh-pci-pci-use-pci_generic_prep_mwi-on-sparc64.patch
-gregkh-pci-pci-replace-have_arch_pci_mwi-with-pci_disable_mwi.patch
-gregkh-pci-pci-delete-unused-extern-in-powermac-pci.c.patch
-gregkh-pci-altix-add-initial-acpi-io-support.patch
-gregkh-pci-altix-sn-acpi-hotplug-support.patch
-gregkh-pci-altix-initial-acpi-support-rom-shadowing.patch
-gregkh-pci-acpiphp-fix-use-of-list_for_each-macro.patch
-gregkh-pci-acpiphp-fix-missing-acpiphp_glue_exit.patch
-gregkh-pci-pci-clear-osc-support-flags-if-no-_osc-method.patch
-gregkh-pci-pci-fix-__pci_register_driver-error-handling.patch
-gregkh-pci-pci-block-on-access-to-temporarily-unavailable-pci-device.patch
-gregkh-pci-pci-i386-style-cleanups.patch
-gregkh-pci-pci-arch-i386-kernel-pci-dma.c-ioremap-balanced-with-iounmap.patch
-gregkh-pci-pci-enable-disable-device-is-nestable.patch
-gregkh-pci-pci-enable-disable-nestable-ports.patch
-gregkh-pci-pci-irq-irq-and-pci_ids-patch-for-intel-ich9.patch
-gregkh-pci-i2c-i801-smbus-patch-for-intel-ich9.patch
-gregkh-pci-pci-change-memory-allocation-for-acpiphp-slots.patch
-gregkh-pci-pci-rpaphp-change-device-tree-examination.patch
-gregkh-pci-pciehp-remove-unnecessary-free_irq.patch
-gregkh-pci-pciehp-remove-unnecessary-pci_disable_msi.patch
-gregkh-pci-pci-ibmphp_pci.c-fix-null-dereference.patch
-gregkh-pci-pci-make-arch-i386-pci-common.c-pci_bf_sort-static.patch
-pci-introduce-pci_find_present.patch
-pci-fix-multiple-problems-with-via-hardware.patch
-pci-fix-multiple-problems-with-via-hardware-warning-fix.patch
-fix-gregkh-pci-pci-enable-disable-device-is-nestable.patch
-s390-preparatory-cleanup-in-common-i-o-layer.patch
-s390-make-the-per-subchannel-lock-dynamic.patch
-s390-dynamic-subchannel-mapping-of-ccw-devices.patch
-aic94xx-dont-call-pci_map_sg-for-already-mapped-scatterlists.patch
-add-missing-libsas-include-to-fix-s390-compilation.patch
-gregkh-usb-usb-takes-31-devices-per-hub.patch
-gregkh-usb-usb-hub-root-hub-code-takes-more-than-15-devices.patch
-gregkh-usb-usb-hid-handle-stall-on-interrupt-endpoint.patch
-gregkh-usb-usb-core-don-t-match-interface-descriptors-for-vendor-specific-devices.patch
-gregkh-usb-usb-ohci-hcd-fix-compiler-warning.patch
-gregkh-usb-usb-ohci-disable-rhsc-inside-interrupt-handler.patch
-gregkh-usb-usb-kmemdup-cleanup-in-drivers-usb.patch
-gregkh-usb-usb-ohci-remove-stale-testing-code-from-root-hub-resume.patch
-gregkh-usb-aircable-use-usb-endpoint-functions.patch
-gregkh-usb-appledisplay-use-usb-endpoint-functions.patch
-gregkh-usb-cdc_ether-use-usb-endpoint-functions.patch
-gregkh-usb-cdc-use-usb-endpoint-functions.patch
-gregkh-usb-devices-use-usb-endpoint-functions.patch
-gregkh-usb-ftdi-use-usb-endpoint-functions.patch
-gregkh-usb-hid-use-usb-endpoint-functions.patch
-gregkh-usb-idmouse-use-usb-endpoint-functions.patch
-gregkh-usb-kobil_sct-use-usb-endpoint-functions.patch
-gregkh-usb-legousbtower-use-usb-endpoint-functions.patch
-gregkh-usb-onetouch-use-usb-endpoint-functions.patch
-gregkh-usb-phidgetkit-use-usb-endpoint-functions.patch
-gregkh-usb-phidgetmotorcontrol-use-usb-endpoint-functions.patch
-gregkh-usb-speedtch-use-usb-endpoint-functions.patch
-gregkh-usb-usbkbd-use-usb-endpoint-functions.patch
-gregkh-usb-usbmouse-use-usb-endpoint-functions.patch
-gregkh-usb-usbnet-use-usb-endpoint-functions.patch
-gregkh-usb-usbtest-use-usb-endpoint-functions.patch
-gregkh-usb-usb-use-usb-endpoint-functions.patch
-gregkh-usb-yealink-use-usb-endpoint-functions.patch
-gregkh-usb-usb-makes-usb_endpoint_-functions-inline.patch
-gregkh-usb-usb-autosuspend-code-consolidation.patch
-gregkh-usb-usb-expand-autosuspend-autoresume-api.patch
-gregkh-usb-usb-net1080-fix-typos.patch
-gregkh-usb-usb-move-private-hub-declarations-out-of-public-header-file.patch
-gregkh-usb-usb-gadget-ether.c-minor-manycast-tweaks.patch
-gregkh-usb-usb-resume_device-symbol-conflict.patch
-gregkh-usb-usb-make-drivers-usb-input-wacom_sys.c-wacom_sys_irq-static.patch
-gregkh-usb-usb-airprime-new-device-id.patch
-gregkh-usb-usb-serial-ti_usb-ti-ez430-development-tool-id.patch
-gregkh-usb-usb-pwc-if-loop-fix.patch
-gregkh-usb-usb-writing_usb_driver-free-urb-cleanup.patch
-gregkh-usb-usb-pcwd_usb-free-urb-cleanup.patch
-gregkh-usb-usb-iforce-usb-free-urb-cleanup.patch
-gregkh-usb-usb-usb-gigaset-free-kill-urb-cleanup.patch
-gregkh-usb-usb-cinergyt2-free-kill-urb-cleanup.patch
-gregkh-usb-usb-ttusb_dec-free-urb-cleanup.patch
-gregkh-usb-usb-pvrusb2-hdw-free-unlink-urb-cleanup.patch
-gregkh-usb-usb-pvrusb2-io-free-urb-cleanup.patch
-gregkh-usb-usb-pwc-if-free-urb-cleanup.patch
-gregkh-usb-usb-sn9c102_core-free-urb-cleanup.patch
-gregkh-usb-usb-quickcam_messenger-free-urb-cleanup.patch
-gregkh-usb-usb-zc0301_core-free-urb-cleanup.patch
-gregkh-usb-usb-irda-usb-free-urb-cleanup.patch
-gregkh-usb-usb-zd1201-free-urb-cleanup.patch
-gregkh-usb-usb-ati_remote-free-urb-cleanup.patch
-gregkh-usb-usb-ati_remote2-free-urb-cleanup.patch
-gregkh-usb-usb-hid-core-free-urb-cleanup.patch
-gregkh-usb-usb-usbkbd-free-urb-cleanup.patch
-gregkh-usb-usb-auerswald-free-kill-urb-cleanup-and-memleak-fix.patch
-gregkh-usb-usb-legousbtower-free-kill-urb-cleanup.patch
-gregkh-usb-usb-phidgetkit-free-urb-cleanup.patch
-gregkh-usb-usb-phidgetmotorcontrol-free-urb-cleanup.patch
-gregkh-usb-usb-ftdi_sio-kill-urb-cleanup.patch
-gregkh-usb-usb-catc-free-urb-cleanup.patch
-gregkh-usb-usb-io_edgeport-kill-urb-cleanup.patch
-gregkh-usb-usb-keyspan-free-urb-cleanup.patch
-gregkh-usb-usb-kobil_sct-kill-urb-cleanup.patch
-gregkh-usb-usb-mct_u232-free-urb-cleanup.patch
-gregkh-usb-usb-navman-kill-urb-cleanup.patch
-gregkh-usb-usb-usb-serial-free-urb-cleanup.patch
-gregkh-usb-usb-visor-kill-urb-cleanup.patch
-gregkh-usb-usb-usbmidi-kill-urb-cleanup.patch
-gregkh-usb-usb-usbmixer-free-kill-urb-cleanup.patch
-gregkh-usb-ohci-change-priority-level-of-resume-log-message.patch
-gregkh-usb-usb-fix-aircable.c-inconsequent-null-checking.patch
-gregkh-usb-usb-core-fix-compiler-warning-about-usb_autosuspend_work.patch
-gregkh-usb-usb-add-digitech-usb-storage-to-unusual_devs.h.patch
-gregkh-usb-usb-microtek-possible-memleak-fix.patch
-gregkh-usb-usb-net2280-don-t-send-unwanted-zero-length-packets.patch
-gregkh-usb-usb-ehci-hooks-for-high-speed-electrical-tests.patch
-gregkh-usb-usb-add-ehci_hcd.ignore_oc-parameter.patch
-gregkh-usb-usb-cypress_m8-init-error-path-fix.patch
-gregkh-usb-usb-make-drivers-usb-host-u132-hcd.c-u132_hcd_wait-static.patch
-gregkh-usb-usb-ftdi-elan.c-fixes-and-cleanups.patch
-gregkh-usb-usb-usbtouchscreen-add-support-for-dmc-tsc-10-25-devices.patch
-gregkh-usb-usb-pxa2xx_udc-recognizes-ixp425-rev-b0-chip.patch
-gregkh-usb-usb-lh7a40x_udc-remove-double-declaration.patch
-gregkh-usb-usb-make-drivers-usb-core-driver.c-usb_device_match-static.patch
-gregkh-usb-usb-idmouse-cleanup.patch
-gregkh-usb-usb-hid-core-canonical-defines-for-apple-usb-device-ids.patch
-gregkh-usb-usb-serial-replace-kmalloc-memset-with-kzalloc.patch
-gregkh-usb-usb-build-the-appledisplay-driver.patch
-gregkh-usb-usb-endianness-fix-for-asix.c.patch
-gregkh-usb-usb-pegasus-error-path-not-resetting-task-s-state.patch
-gregkh-usb-usb-added-dynamic-major-number-for-usb-endpoints.patch
-gregkh-usb-usb-multithread.patch
-gregkh-usb-ehci-fix-root-hub-and-port-suspend-resume-problems.patch
-gregkh-usb-usb-add-autosuspend-support-to-the-hub-driver.patch
-gregkh-usb-ohci-make-autostop-conditional-on-config_pm.patch
-gregkh-usb-usb-struct-usb_device-change-flag-to-bitflag.patch
-gregkh-usb-usb-hub-simplify-remote-wakeup-handling.patch
-gregkh-usb-usb-keep-count-of-unsuspended-children.patch
-gregkh-usb-usbcore-remove-unused-argument-in-autosuspend.patch
-usb-storage-unusual_devsh-entry-for-sony.patch
-usb-auerswald-replace-kmallocmemset-with-kzalloc.patch
-x86_64-mm-defconfig-update.patch
-x86_64-mm-i386-defconfig-update.patch
-x86_64-mm-copy-user-nocache.patch
-x86_64-mm-fix-buggy-mtrr-address-checks.patch
-x86_64-mm-dump-80cols.patch
-x86_64-mm-dump-remove-newlines.patch
-x86_64-mm-i386-mathemu-must-check.patch
-x86_64-mm-i386-remove-pointless-printk.patch
-x86_64-mm-spin-irqs-disabled.patch
-x86_64-mm-x86_64-rename-x86_feature_dtes-to-x86_feature_ds.patch
-x86_64-mm-add-x86_feature_pebs-and-detection.patch
-x86_64-mm-remove-duplicated-cpu_mask_to_apicid-in-x86_64-smp.h.patch
-x86_64-mm-i386-rename-x86_feature_dtes-to-x86_feature_ds.patch
-x86_64-mm-i386-add-x86_feature_pebs-and-detection.patch
-x86_64-mm-i386-math-emu-build-bug-on.patch
-x86_64-mm-i386-default-ldt.patch
-x86_64-mm-all-cpu-backtrace.patch
-x86_64-mm-espfix-cleanup.patch
-x86_64-mm-i386-sleazy-fpu.patch
-x86_64-mm-insert-local-and-io-apics-into-resource-map.patch
-x86_64-mm-i386-hpet-ioremap.patch
-x86_64-mm-i386-hpet-cs-iounmap.patch
-x86_64-mm-x86-64-add-intel-core-related-pmu-msrs.patch
-x86_64-mm-i386-add-intel-core-related-pmu-msrs.patch
-x86_64-mm-dump_trace-atomicity-fix.patch
-x86_64-mm-entry-cleanup.patch
-x86_64-mm-pda-asm-offset.patch
-x86_64-mm-pda-basics.patch
-x86_64-mm-pda-percpu-init.patch
-x86_64-mm-pda-gs-base.patch
-x86_64-mm-pda-interface.patch
-x86_64-mm-pda-vm86.patch
-x86_64-mm-pda-smp-processor-id.patch
-x86_64-mm-pda-current.patch
-x86_64-mm-pda-int-regs.patch
-x86_64-mm-no-nested-idle-loops.patch
-x86_64-mm-remove-pci_find.patch
-x86_64-mm-nmi-message.patch
-x86_64-mm-compat-siocsifhwbroadcast.patch
-x86_64-mm-i386-reloc-abssym.patch
-x86_64-mm-i386-reloc-cleanup-align.patch
-x86_64-mm-i386-reloc-pa-symbol.patch
-x86_64-mm-i386-reloc-cleanup-kernel-res.patch
-x86_64-mm-i386-reloc-physical-start.patch
-x86_64-mm-i386-reloc-kallsyms.patch
-x86_64-mm-i386-reloc-core.patch
-x86_64-mm-i386-reloc-warn.patch
-x86_64-mm-i386-reloc-bzimage.patch
-x86_64-mm-extend-bzimage-protocol-for-relocatable-protected-mode-kernel.patch
-x86_64-mm-mark-config_relocatable-experimental.patch
-x86_64-mm-desc-defs.patch
-x86_64-mm-strange-work_notifysig-code-since-2.6.16.patch
-x86_64-mm-cpa-clflush.patch
-x86_64-mm-i386-clflush-size.patch
-x86_64-mm-i386-cpa-clflush.patch
-x86_64-mm-amd-tsc-sync.patch
-x86_64-mm-clear-irq-vector.patch
-x86_64-mm-pka-cast.patch
-x86_64-mm-probe-kernel-address.patch
-x86_64-mm-i386-probe-kernel-address.patch
-x86_64-mm-try-multiple-timer-pins.patch
-x86_64-mm-sa_siginfo-was-forgotten.patch
-x86_64-mm-i386-create-e820.c-to-handle-standard-io-mem-resources.patch
-x86_64-mm-i386-create-e820.c-about-e820-map-sanitize-and-copy-function.patch
-x86_64-mm-i386-create-e820.c-to-handle-find_max_pfn-function.patch
-x86_64-mm-i386-create-e820.c-to-handle-memmap-table-walking.patch
-x86_64-mm-i386-create-e820.c-about-memap-boot-param-parse-and-print.patch
-x86_64-mm-calgary-shift.patch
-x86_64-mm-calgary-bios.patch
-x86_64-mm-calgary-bios-cleanup.patch
-x86_64-mm-calgary-not-default.patch
-x86_64-mm-make-x86_64-udelay-round-up-instead-of-down..patch
-x86_64-mm-comment-magic-constants-in-delay.h.patch
-x86_64-mm-i386-apic-irq-race.patch
-x86_64-mm-apic-irq-race.patch
-x86_64-mm-i386-iopl.patch
-x86_64-mm-csum-dont-inline.patch
-x86_64-mm-substitute-__va-lookup-with-pfn_to_kaddr.patch
-x86_64-mm-i386-double-includes.patch
-x86_64-mm-paravirt-core.patch
-x86_64-mm-paravirt-inline.patch
-x86_64-mm-cpu_detect-extraction.patch
-x86_64-mm-paravirt-startup.patch
-x86_64-mm-paravirt-no-bugs.patch
-x86_64-mm-paravirt-no-vdso.patch
-x86_64-mm-paravirt-no-powermgmt.patch
-x86_64-mm-paravirt-apic.patch
-x86_64-mm-paravirt-mmu.patch
-x86_64-mm-paravirt-bios.patch
-x86_64-mm-mmu-header-movement.patch
-x86_64-mm-fix-bad-mmu-names.patch
-x86_64-mm-fix-missing-pte-update.patch
-x86_64-mm-skip-timer-works.patch
-x86_64-mm-config-core2.patch
-x86_64-mm-i386-config-core2.patch
-x86_64-mm-vsyscall-perms.patch
-x86_64-mm-irq-rate-limit.patch
-x86_64-mm-clear_fixmap-should-not-use-set_pte.patch
-x86_64-mm-i386-nmi-watchdog-cpu-limit.patch
-x86_64-mm-earlyprintk-con-boot.patch
-x86_64-mm-remove-prototype-of-free_bootmem_generic.patch
-x86_64-mm-conditionalize-inclusion-of-some-mtrr-flavors.patch
-x86_64-mm-adjust-pmd_bad.patch
-x86_64-mm-fix-mtrr-code.patch
-x86_64-mm-alloc_gdt-static.patch
-x86_64-mm-fix-x86_64-mm-i386-reloc-kallsyms.patch
-x86_64-mm-convert-more-absolute-symbols-to-section-relative.patch
-x86_64-mm-add-write_pci_config_byte-to-direct-pci-access-routines.patch
-x86_64-mm-introduce-the-mechanism-of-disabling-cpu-hotplug-control.patch
-x86_64-mm-change-the-no_control-field-to-hotpluggable-in-the-struct-cpu.patch
-x86_64-mm-add-genapic_force.patch
-x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
-x86_64-mm-calling-efi_get_time-during-suspend.patch
-x86_64-mm-handle-a-negative-return-value.patch
-x86_64-mm-i386-irq-vector-static.patch
-x86_64-mm-x86-64-add-intel-bts-cpufeature-bit-and-detection-take-2.patch
-x86_64-mm-i386-add-intel-bts-cpufeature-bit-and-detection-take-2.patch
-x86_64-mm-i386-apic-early-param.patch
-x86_64-mm-apic-suspend-msrs.patch
-x86_64-mm-genericarch-up-compilation.patch
-x86_64-mm-backtrace-strict-check.patch
-x86_64-mm-vdso.patch
-x86_64-mm-i386-efi-memmap.patch
-x86_64-mm-i386-remove-duplicate-printk.patch
-x86_64-mm-remove-unused-apic-ver.patch
-x86_64-mm-msr-comment.patch
-x86_64-mm-add-sysctl-for-kstack_depth_to_print.patch
-x86_64-mm-clear-bss-early.patch
-x86_64-mm-remove-duplicate-arch_discontigmem_enable-option.patch
-x86_64-mm-172-kobject_init-on-resume-from-disk.patch
-x86_64-mm-i386-touch-watchdog-in-backtrace.patch
-x86_64-mm-remove-unused-acpi-madt.patch
-x86_64-mm-unify-rewrite-smp-tsc-sync-code.patch
-x86_64-mm-always-enable-regparm.patch
-x86_64-mm-rdtsc-sync-amd-single-core.patch
-revert-x86_64-mm-vdso.patch
-revert-x86_64-mm-earlyprintk-con-boot.patch
-post-x86_64-mm-i386-reloc-abssym.patch
-fix-x86_64-mm-patch-inline-replacements-for-section-warnings.patch
-genapic-optimize-fix-apic-mode-setup.patch
-mtrr-replace-kmallocmemset-with-kzalloc.patch
-i386-correct-documentation-for-bzimage-protocol-v205.patch
-fix-asm-constraints-in-i386-atomic_add_return.patch
-i386-msr-remove-unused-variable.patch
-arch-i386-kernel-remove-remaining-pc98-code.patch
-i386-replace-kmallocmemset-with-kzalloc.patch
-x86_64-fake-numa-provides-a-io-hole-size-in-a-given-address-range.patch
-x86_64-fake-numa-increase-the-node_shift.patch
-x86_64-fake-numa-fix-numa=fake.patch
-x86_64-fake-numa-extends-the-kernel-command-line-option-for-numa=fake.patch
-x86-64-change-the-size-for-interrupt-array-to-nr_vectors.patch
-altix-acpi-ssdt-pci-device-support.patch
-altix-add-acpi-ssdt-pci-device-support-hotplug.patch
-add-support-for-acpi_load_table-acpi_unload_table_id.patch
-memory-page-alloc-minor-cleanups.patch
-memory-page-alloc-minor-cleanups-fix.patch
-__unmap_hugepage_range-add-comment.patch
-get-rid-of-zone_table.patch
-get-rid-of-zone_table-fix-3.patch
-memory-page_alloc-zonelist-caching-speedup.patch
-memory-page_alloc-zonelist-caching-reorder-structure.patch
-oom-dont-kill-unkillable-children-or-siblings.patch
-oom-cleanup-messages.patch
-oom-less-memdie.patch
-mm-incorrect-vm_fault_oom-returns-from-drivers.patch
-grab-swap-token-reordered.patch
-new-scheme-to-preempt-swap-token.patch
-new-scheme-to-preempt-swap-token-tidy.patch
-mm-add-arch_alloc_page.patch
-balance_pdgat-cleanup.patch
-shared-page-table-for-hugetlb-page-v4.patch
-htlb-forget-rss-with-pt-sharing.patch
-slab-debug-and-arch_slab_minalign-dont-get-along.patch
-mm-slab-eliminate-lock_cpu_hotplug-from-slab.patch
-add-noaliencache-boot-option-to-disable-numa-alien-caches.patch
-mm-arch-do_page_fault-vs-in_atomic.patch
-mm-pagefault_disableenable.patch
-mm-pagefault_disableenable-s390-fix.patch
-mm-kummap_atomic-vs-in_atomic.patch
-fix-kunmap_atomics-use-of-kpte_clear_flush.patch
-allowing-user-processes-to-rise-their-oom_adj-value.patch
-mlock-cleanup.patch
-oom-can-panic-due-to-processes-stuck-in-__alloc_pages.patch
-always-print-out-the-header-line-in-proc-swaps.patch
-leak-tracking-for-kmalloc_node.patch
-leak-tracking-for-kmalloc_node-fix.patch
-add-numa-node-information-to-struct-device.patch
-add-numa-node-information-to-struct-device-tidy.patch
-node-aware-skb-allocation.patch
-node-aware-skb-allocation-fix-for-device-tree-changes.patch
-allow-null-pointers-in-percpu_free.patch
-enables-booting-a-numa-system-where-some-nodes-have-no.patch
-make-mm-thrashcglobal_faults-static.patch
-remove-bio_cachep-from-slabh.patch
-move-sighand_cachep-to-include-signalh.patch
-move-vm_area_cachep-to-include-mmh.patch
-move-files_cachep-to-include-fileh.patch
-move-filep_cachep-to-include-fileh.patch
-move-fs_cachep-to-linux-fs_structh.patch
-move-names_cachep-to-linux-fsh.patch
-remove-uses-of-kmem_cache_t-from-mm-and-include-linux-slabh.patch
-drain_node_page-drain-pages-in-batch-units.patch
-numa-node-ids-are-int-page_to_nid-and-zone_to_nid-should-return-int.patch
-silence-unused-pgdat-warning-from-alloc_bootmem_node-and-friends.patch
-reject-corrupt-swapfiles-earlier.patch
-mm-cleanup-indentation-on-switch-for-cpu-operations.patch
-mm-call-into-direct-reclaim-without-pf_memalloc-set.patch
-mm-cleanup-and-document-reclaim-recursion.patch
-radix-tree-rcu-lockless-readside.patch
-security-keys-user-kmemdup.patch
-selinux-fix-dentry_open-error-check.patch
-alpha-switch-to-pci_get-api.patch
-uswsusp-add-pmops-prepareenterfinish-support-aka-platform-mode.patch
-swsusp-use-partition-device-and-offset-to-identify-swap-areas.patch
-swsusp-rearrange-swap-handling-code.patch
-swsusp-use-block-device-offsets-to-identify-swap-locations-rev-2.patch
-swsusp-add-resume_offset-command-line-parameter-rev-2.patch
-swsusp-document-support-for-swap-files-rev-2.patch
-swsusp-add-ioctl-for-swap-files-support.patch
-swsusp-update-userland-interface-documentation.patch
-swsusp-improve-handling-of-highmem.patch
-swsusp-improve-handling-of-highmem-fix.patch
-swsusp-use-__gfp_wait.patch
-swsusp-fix-platform-mode.patch
-add-include-linux-freezerh-and-move-definitions-from.patch
-add-include-linux-freezerh-and-move-definitions-from-ueagle-fix.patch
-add-include-linux-freezerh-and-move-definitions-from-ucb1400_ts-fix.patch
-quieten-freezer-if-config_pm_debug.patch
-swsusp-cleanup-whitespace-in-freezer-output.patch
-swsusp-thaw-userspace-and-kernel-space-separately.patch
-swsusp-support-i386-systems-with-pae-or-without-pse.patch
-suspend-dont-change-cpus_allowed-for-task-initiating-the-suspend.patch
-swsusp-measure-memory-shrinking-time.patch
-suspend-to-disk-fails-if-gdb-is-suspended-with-a-traced-child.patch
-convert-pm_sem-to-a-mutex.patch
-convert-pm_sem-to-a-mutex-fix.patch
-swsusp-untangle-thaw_processes.patch
-swsusp-untangle-freeze_processes.patch
-swsusp-fix-coding-style-in-suspendc.patch
-swsusp-fix-labels.patch
-s2ram-debugging-documentation.patch
-support-for-freezeable-workqueues.patch
-use-freezeable-workqueues-in-xfs.patch
-cciss-version-change.patch
-cciss-reference-driver-support.patch
-cciss-increase-number-of-commands-on-controller.patch
-cciss-fix-pci-ssid-for-the-e500-controller.patch
-cciss-disable-dma-prefetch-on-p600.patch
-cciss-set-sector_size-to-2048-for-performance.patch
-cciss-set-sector_size-to-2048-for-performance-tidy.patch
-cciss-change-cciss_open-for-consistency.patch
-cciss-remove-unused-revalidate_allvol-function.patch
-cciss-add-support-for-1024-logical-volumes.patch
-cciss-cleanup-cciss_interrupt-mode.patch
-kbuild-dont-put-temp-files-in-the-source-tree.patch
-kbuild-dont-put-temp-files-in-the-source-tree-fix.patch
-fix-rescan_partitions-to-return-errors-properly.patch
-fix-check_partition-routines.patch
-serial-uartlite-driver.patch
-serial-uartlite-driver-fix.patch
-fix-serial-uartlite-after-global-pt_regs.patch
-serial-uartlite-support-multiple-devices.patch
-serial-uartlite-initialize-port-parameters-in-console_setup.patch
-ioremap-balanced-with-iounmap-for-drivers-char-rio-rio_linuxc.patch
-ioremap-balanced-with-iounmap-for-drivers-char-moxac.patch
-ioremap-balanced-with-iounmap-for-drivers-char-istallionc.patch
-sound-oss-btaudioc-ioremap-balanced-with-iounmap.patch
-lockdep-annotate-nfs-nfsd-in-kernel-sockets.patch
-lockdep-annotate-nfs-nfsd-in-kernel-sockets-tidy.patch
-honour-mnt_noexec-for-access.patch
-ext2-fsid-for-statvfs.patch
-ext3-fsid-for-statvfs.patch
-ext4-fsid-for-statvfs.patch
-kernel-proc-kallsyms-reports-lower-case.patch
-i2o-more-error-checking.patch
-pnp-handle-sysfs-errors.patch
-rtc-handle-sysfs-errors.patch
-sound-oss-emu10k1-handle-userspace-copy-errors.patch
-spi-improve-sysfs-compiler-complaint-handling.patch
-constify-inode-accessors.patch
-ide-complete-switch-to-pci_get.patch
-fuse-update-userspace-interface-to-version-78.patch
-fuse-minor-cleanup-in-fuse_dentry_revalidate.patch
-fuse-add-support-for-block-device-based-filesystems.patch
-fuse-add-blksize-option.patch
-fuse-add-bmap-support.patch
-fuse-add-destroy-operation.patch
-fuse-fix-compile-without-config_block.patch
-sysrq-x-show-blocked-tasks.patch
-#sysrq-t-broke-and-no-one-noticed.patch
-file-kill-unnecessary-timer-in-fdtable_defer.patch
-remove-double-cast-to-same-type.patch
-io-storage-documentation-update-to-as-ioschedtxt.patch
-export-pm_suspend-for-the-shared-apm-emulation.patch
-patch-to-fix-reiserfs-bad-path-release-panic-on-2619-rc1.patch
-via82cxxx-handle-error-condition-properly.patch
-lockdep-fix-ide-proc-interaction.patch
-pull-in-necessary-header-files-for-cdevh.patch
-cpuset-minor-code-refinements.patch
-remove-superfluous-lock_super-in-ext2-and-ext3-xattr-code.patch
-correct-bus_num-and-buffer-bug-in-spi-core.patch
-spi-set-kset-of-master-class-dev-explicitly.patch
-paride-rename-pi_register-and-pi_unregister.patch
-paride_register-shuffle-return-values.patch
-lockdep-internal-locking-fixes.patch
-lockdep-misc-fixes-in-lockdepc.patch
-binfmt_elf-randomize-pie-binaries.patch
-handle-ext3-directory-corruption-better.patch
-handle-ext4-directory-corruption-better.patch
-tifm-fix-null-ptr-and-style.patch
-function-v9fs_get_idpool-returns-int-not-u32-as-called-twice.patch
-disable-clone_child_cleartid-for-abnormal-exit.patch
-binfmt-fix-uaccess-handling.patch
-compat-fix-uaccess-handling.patch
-profile-fix-uaccess-handling.patch
-kconfig-printk_time-depends-on-printk.patch
-parport_pc-add-support-for-ox16pci952-parallel-port.patch
-probe_kernel_address-needs-to-do-set_fs.patch
-slab-use-probe_kernel_address.patch
-paride-return-proper-error-code.patch
-read_cache_pages-cleanup.patch
-taskstats_exit_alloc-optimize-simplify.patch
-taskstats-cleanup-do_exit-path.patch
-taskstats-cleanup-signal-stats-allocation.patch
-taskstats-factor-out-reply-assembling.patch
-taskstats-use-nla_reserve-for-reply-assembling.patch
-taskstats-cleanup-reply-assembling.patch
-cpuset-allow-a-larger-buffer-for-writes-to-cpuset-files.patch
-compile-time-check-re-world-writeable-module-params.patch
-lockdep-annotate-bcsp-driver.patch
-aio-use-prepare_to_wait.patch
-exar-quad-port-serial.patch
-exar-quad-port-serial-fix.patch
-fs-trivial-vsnprintf-conversion.patch
-hpfs-bring-hpfs_error-into-shape.patch
-hpfs-fix-printk-format-warnings.patch
-drivers-cdrom-trivial-vsnprintf-conversion.patch
-vfs-extra-check-inside-dentry_unhash.patch
-correct-misc_register-return-code-handling-in-several-drivers.patch
-more-list-debugging-context.patch
-get_options-to-allow-a-hypenated-range-for-isolcpus.patch
-vfs_getattr-remove-dead-code.patch
-ext3-uninline-large-functions.patch
-ext4-uninline-large-functions.patch
-uninline-module_put.patch
-i2lib-unused-variable-cleanup.patch
-make-initramfs-printk-a-warning-on-incorrect-cpio-type.patch
-corrupted-cramfs-filesystems-cause-kernel-oops.patch
-lockdep-print-current-locks-on-in_atomic-warnings.patch
-lockdep-name-some-old-style-locks.patch
-documentation-remount_fs-needs-lock_kernel.patch
-sleep-profiling.patch
-sleep-profiling-fixes.patch
-sleep-profiling-fix.patch
-ext4_ext_split-remove-dead-code.patch
-debug-workqueue-locking-sanity.patch
-debug-workqueue-locking-sanity-fix.patch
-hz-300hz-support.patch
-pcengines-wrap-led-support.patch
-pcengines-wrap-led-support-fix.patch
-driver-base-memoryc-remove-warnings-of.patch
-remove-kernel-syscalls.patch
-remove-kernel-syscalls-x86_64-fix.patch
-protect-ext2-ioctl-modifying-append_only-immutable-etc-with-i_mutex.patch
-remove-hash_highmem.patch
-retries-in-ext3_prepare_write-violate-ordering-requirements.patch
-ktime-fix-signed--unsigned-mismatch-in-ktime_to_ns.patch
-qconf-support-old-qt.patch
-remove-the-syslog-interface-when-printk-is-disabled.patch
-ver_linux-additions.patch
-initrd-remove-unused-false-condition-for.patch
-fix-the-size-limit-of-compat-space-msgsize.patch
-elf-always-define-elf_addr_t-in-linux-elfh.patch
-elf-include-terminating-zero-in-n_namesz.patch
-elf-fix-kcore-note-size-calculation.patch
-elf-fix-kcore-note-size-calculation-fix.patch
-reiserfs-add-missing-d-cache-flushing.patch
-reiserfs-add-missing-d-cache-flushing-tweak.patch
-the-scheduled-removal-of-some-oss-options.patch
-make-1-bit-bitfields-unsigned.patch
-hvcs-char-driver-janitoring-move-block-of-code.patch
-hvcs-char-driver-janitoring-rm-compiler-warnings.patch
-kprobes-enable-booster-on-the-preemptible-kernel.patch
-hotplug-cpu-clean-up-hotcpu_notifier-use.patch
-hotplug-cpu-clean-up-hotcpu_notifier-use-vs-gregkh-driver-cpu-topology-consider-sysfs_create_group-return-value.patch
-ext3-fix-reservation-extension.patch
-ext4-fix-reservation-extension.patch
-allow-hwrandom-core-to-be-a-module.patch
-make-mm-shmemcshmem_xattr_security_handler-static.patch
-remove-kernel-lockdepclockdep_internal.patch
-make-kernel-signalckill_proc_info-static.patch
-i2o-handle-__copy_from_user.patch
-i2o-fix-i2o_config-without-adaptec-extension.patch
-make-ecryptfs_version_str_map-static.patch
-make-fs-jbd-transactionc__journal_temp_unlink_buffer-static.patch
-make-fs-jbd2-transactionc__jbd2_journal_temp_unlink_buffer-static.patch
-fs-lockd-hostc-make-2-functions-static.patch
-make-fs-proc-basecproc_pid_instantiate-static.patch
-parport-section-mismatches-with-hotplug=n.patch
-agp-amd64-section-mismatches-with-hotplug=n.patch
-add-rtc-omap-driver.patch
-add-return-value-checking-of-get_user-in.patch
-add-return-value-checking-of-get_user-in-fix.patch
-ciss-require-same-scsi-module-support.patch
-export-toshiba-smm-support-for-neofb-module.patch
-kernel-doc-add-fusion-and-i2o-to-kernel-api-book.patch
-kernel-doc-fix-fusion-and-i2o-docs.patch
-kernel-api-book-remove-videodev-chapter.patch
-rcu-add-a-prefetch-in-rcu_do_batch.patch
-dont-insert-pipe-dentries-into-dentry_hashtable.patch
-dcache-avoid-rcu-for-never-hashed-dentries.patch
-net-dont-insert-socket-dentries-into-dentry_hashtable.patch
-kernel-core-replace-kmallocmemset-with-kzalloc.patch
-kernel-doc-stricter-function-pointer-recognition.patch
-fs-reorder-some-struct-inode-fields-to-speedup-i_size-manipulations.patch
-add-struct-dev-pointer-to-dma_is_consistent.patch
-handle-per-subsystem-mutexes-for-config_hotplug_cpu-not-set.patch
-handle-per-subsystem-mutexes-for-config_hotplug_cpu-not-set-tidy.patch
-dz-fixes-to-make-it-work.patch
-dz-fixes-to-make-it-work-fix.patch
-reiser-replace-kmallocmemset-with-kzalloc.patch
-futex-init-error-check.patch
-spi-check-platform_device_register_simple-error.patch
-synclink_gt-fix-init-error-handling.patch
-sysctl-string-length-calculated-is-wrong-if-it-contains-negative-numbers.patch
-sched-correct-output-of-show_state.patch
-reiserfs-do-not-add-save-links-for-o_direct-writes.patch
-io-accounting-core-statistics.patch
-clean-up-__set_page_dirty_nobuffers.patch
-io-accounting-write-accounting.patch
-io-accounting-write-cancel-accounting.patch
-io-accounting-read-accounting-2.patch
-io-accounting-read-accounting-nfs-fix.patch
-io-accounting-read-accounting-cifs-fix.patch
-io-accounting-direct-io.patch
-io-accounting-report-in-procfs.patch
-cleanup-taskstatsh.patch
-io-accounting-via-taskstats.patch
-getdelays-various-fixes.patch
-io-accounting-add-to-getdelays.patch
-ext4-if-expression-format.patch
-ext4-kmalloc-to-kzalloc.patch
-ext4-eliminate-inline-functions.patch
-tty-signal-tty-locking.patch
-tty-signal-tty-locking-3270-fix.patch
-do_task_stat-dont-take-tty_mutex.patch
-do_acct_process-dont-take-tty_mutex.patch
-trivial-make-set_special_pids-static.patch
-sys_unshare-remove-a-broken-clone_sighand-code.patch
-pktcdvd-reusability-of-procfs-functions.patch
-pktcdvd-make-procfs-interface-optional.patch
-pktcdvd-bio-write-congestion-using-blk_congestion_wait.patch
-pktcdvd-bio-write-congestion-using-blk_congestion_wait-fix.patch
-pktcdvd-add-sysfs-and-debugfs-interface.patch
-remove-the-old-bd_mutex-lockdep-annotation.patch
-new-bd_mutex-lockdep-annotation.patch
-remove-lock_key-approach-to-managing-nested-bd_mutex-locks.patch
-simplify-some-aspects-of-bd_mutex-nesting.patch
-use-mutex_lock_nested-for-bd_mutex-to-avoid-lockdep-warning.patch
-avoid-lockdep-warning-in-md.patch
-bdev-fix-bd_part_count-leak.patch
-generic-bug-implementation.patch
-generic-bug-implementation-handle-bug=n.patch
-generic-bug-implementation-include-linux-bugh-must-always-include-linux-moduleh.patch
-generic-bug-for-i386.patch
-generic-bug-for-x86-64.patch
-uml-add-generic-bug-support.patch
-use-generic-bug-for-ppc.patch
-bug-test-1.patch
-fix-generic-warn_on-message.patch
-bit-revese-library.patch
-crc32-replace-bitreverse-by-bitrev32.patch
-video-use-bitrev8.patch
-net-use-bitrev8-tidy.patch
-isdn-hisax-use-bitrev8.patch
-atm-ambassador-use-bitrev8.patch
-isdn-gigaset-use-bitrev8.patch
-drivers-mtd-nand-rtc_from4c-use-lib-bitrevc.patch
-drivers-mtd-nand-rtc_from4c-use-lib-bitrevc-tidy.patch
-fsstack-introduce-fsstack_copy_attrinode_.patch
-fsstack-introduce-fsstack_copy_attrinode_-tidy.patch
-fsstack-introduce-fsstack_copy_attrinode_-fs-stackc-should-include-linux-fs_stackh.patch
-ecryptfs-use-fsstacks-generic-copy-inode-attr.patch
-ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix.patch
-ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix-fix.patch
-struct-path-rename-reiserfss-struct-path.patch
-struct-path-rename-dms-struct-path.patch
-struct-path-move-struct-path-from-fs-nameic-into.patch
-struct-path-make-ecryptfs-a-user-of-struct-path.patch
-vfs-change-struct-file-to-use-struct-path.patch
-sysfs-change-uses-of-f_dentry.patch
-proc-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-ext2-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-ext3-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-ext4-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-fat-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
-isofs-change-uses-of-f_dentry.patch
-nfs-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
-nfsd-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-ntfs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-i386-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-x86_64-change-uses-of-f_dentry.patch
-kernel-change-uses-of-f_dentry.patch
-mm-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
-9p-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
-affs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-autofs-change-uses-of-f_dentry.patch
-autofs4-change-uses-of-f_dentry.patch
-configfs-change-uses-of-f_dentry.patch
-cifs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
-ecryptfs-change-uses-of-f_dentry.patch
-xfs-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
-struct-path-convert-adfs.patch
-struct-path-convert-afs.patch
-struct-path-convert-alpha.patch
-struct-path-convert-atm.patch
-struct-path-convert-befs.patch
-struct-path-convert-bfs.patch
-struct-path-convert-block.patch
-struct-path-convert-block_drivers.patch
-struct-path-convert-char-drivers.patch
-struct-path-convert-coda.patch
-struct-path-convert-cosa.patch
-struct-path-convert-cramfs.patch
-struct-path-convert-cris.patch
-struct-path-convert-drm.patch
-struct-path-convert-efs.patch
-struct-path-convert-freevxfs.patch
-struct-path-convert-frv.patch
-struct-path-convert-fuse.patch
-struct-path-convert-gfs2.patch
-struct-path-convert-hfs.patch
-struct-path-convert-hfsplus.patch
-struct-path-convert-hostfs.patch
-struct-path-convert-hpfs.patch
-struct-path-convert-hppfs.patch
-struct-path-convert-hugetlbfs.patch
-struct-path-convert-i2c-drivers.patch
-struct-path-convert-ia64.patch
-struct-path-convert-ieee1394.patch
-struct-path-convert-infiniband.patch
-struct-path-convert-ipc.patch
-struct-path-convert-ipmi.patch
-struct-path-convert-isapnp.patch
-struct-path-convert-isdn.patch
-struct-path-convert-ixj.patch
-struct-path-convert-jffs.patch
-struct-path-convert-jffs2.patch
-struct-path-convert-jfs.patch
-struct-path-convert-kernel.patch
-struct-path-convert-lockd.patch
-struct-path-convert-md.patch
-struct-path-convert-minix.patch
-struct-path-convert-mips.patch
-struct-path-convert-mm.patch
-struct-path-convert-nbd.patch
-struct-path-convert-ncpfs.patch
-struct-path-convert-net.patch
-struct-path-convert-netfilter.patch
-struct-path-convert-netlink.patch
-struct-path-convert-ocfs2.patch
-struct-path-convert-openpromfs.patch
-struct-path-convert-oprofile.patch
-struct-path-convert-parisc.patch
-struct-path-convert-pci.patch
-struct-path-convert-pcmcia.patch
-struct-path-convert-powerpc.patch
-struct-path-convert-ppc.patch
-struct-path-convert-qnx4.patch
-struct-path-convert-ramfs.patch
-struct-path-convert-reiserfs.patch
-struct-path-convert-romfs.patch
-struct-path-convert-s390-drivers.patch
-struct-path-convert-s390.patch
-struct-path-convert-sbus.patch
-struct-path-convert-scsi.patch
-struct-path-convert-selinux.patch
-struct-path-convert-sh.patch
-struct-path-convert-smbfs.patch
-struct-path-convert-sound.patch
-struct-path-convert-sparc.patch
-struct-path-convert-sparc64.patch
-struct-path-convert-sunrpc.patch
-struct-path-convert-sysv.patch
-struct-path-convert-udf.patch
-struct-path-convert-ufs.patch
-struct-path-convert-unix.patch
-struct-path-convert-usb.patch
-struct-path-convert-v4l.patch
-struct-path-convert-video.patch
-struct-path-convert-zorro.patch
-log2-implement-a-general-integer-log2-facility-in-the-kernel.patch
-log2-implement-a-general-integer-log2-facility-in-the-kernel-fix.patch
-log2-implement-a-general-integer-log2-facility-in-the-kernel-vs-git-cryptodev.patch
-log2-implement-a-general-integer-log2-facility-in-the-kernel-ppc-fix.patch
-log2-alter-roundup_pow_of_two-so-that-it-can-use-a-ilog2-on-a-constant.patch
-log2-alter-get_order-so-that-it-can-make-use-of-ilog2-on-a-constant.patch
-log2-provide-ilog2-fallbacks-for-powerpc.patch
-add-process_session-helper-routine.patch
-add-process_session-helper-routine-deprecate-old-field.patch
-add-process_session-helper-routine-deprecate-old-field-tidy.patch
-add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
-add-process_session-helper-routine-deprecate-old-field-fix-warnings-2.patch
-add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix.patch
-rename-struct-namespace-to-struct-mnt_namespace.patch
-add-an-identifier-to-nsproxy.patch
-rename-struct-pspace-to-struct-pid_namespace.patch
-add-pid_namespace-to-nsproxy.patch
-use-current-nsproxy-pid_ns.patch
-add-child-reaper-to-pid_namespace.patch
-sys_setpgid-eliminate-unnecessary-do_each_task_pidpidtype_pgid.patch
-session_of_pgrp-kill-unnecessary-do_each_task_pidpidtype_pgid.patch
-generic-ioremap_page_range-mips-conversion.patch
-generic-ioremap_page_range-parisc-conversion.patch
-generic-ioremap_page_range-s390-conversion.patch
-generic-ioremap_page_range-sh-conversion.patch
-generic-ioremap_page_range-sh64-conversion.patch
-mxser-correct-tty-driver-name.patch
-pci-mxser-pci-refcounts.patch
-mxser-make-an-experimental-clone.patch
-mxser-session-warning-fix.patch
-char-mxser_new-correct-include-file.patch
-char-mxser_new-upgrade-to-191.patch
-char-mxser_new-rework-to-allow-dynamic-structs.patch
-char-mxser_new-use-__devinit-macros.patch
-char-mxser_new-pci_request_region-for-pci-regions.patch
-char-mxser_new-check-request_region-retvals.patch
-char-mxser_new-kill-unneeded-memsets.patch
-char-mxser_new-revert-spin_lock-changes.patch
-char-mxser_new-remove-request-for-testers-line.patch
-char-mxser_new-debug-printk-dependent-on-debug.patch
-char-mxser_new-alter-license-terms.patch
-char-mxser_new-code-upside-down.patch
-char-mxser_new-cmspar-is-defined.patch
-char-remove-unneded-termbits-redefinitions-mxser_new.patch
-char-mxser_new-eliminate-tty-ldisc-deref.patch
-char-mxser_new-testbit-for-bit-testing.patch
-char-mxser_new-correct-fail-paths.patch
-char-mxser_new-dont-check-tty_unregister-retval.patch
-char-mxser_new-compress-isa-finding.patch
-char-mxser_new-register-tty-devices-on-the-fly.patch
-char-mxser_new-compact-structures-round2.patch
-char-mxser_new-reverse-if-else-paths-patch.patch
-char-mxser_new-comments-cleanup.patch
-char-mxser_new-correct-intr-handler-proto.patch
-char-mxser_new-delete-ttys-and-termios.patch
-char-mxser_new-pci-probing.patch
-char-mxser_new-clean-macros.patch
-maintainers-add-me-to-isicom-mxser.patch
-mxser_new-correct-tty-driver-name.patch
-char-stallion-use-pr_debug-macro.patch
-char-stallion-remove-unneeded-casts.patch
-char-stallion-kill-typedefs.patch
-char-stallion-move-init-deinit.patch
-char-stallion-uninline-functions.patch
-char-stallion-mark-functions-as-init.patch
-char-stallion-remove-many-prototypes.patch
-tty-preparatory-structures-for-termios-revamp.patch
-tty-preparatory-structures-for-termios-revamp-strip-fix.patch
-tty-switch-to-ktermios-and-new-framework.patch
-tty-switch-to-ktermios-and-new-framework-warning-fix.patch
-tty-switch-to-ktermios-and-new-framework-irda-fix.patch
-tty-switch-to-ktermios.patch
-tty-switch-to-ktermios-nozomi-fix.patch
-tty-switch-to-ktermios-bluetooth-fix.patch
-tty-switch-to-ktermios-sclp-fix.patch
-tty-switch-to-ktermios-3270-fix.patch
-tty-switch-to-ktermios-powerpc-fix.patch
-tty-switch-to-ktermios-uml-fix.patch
-tty-switch-to-ktermios-uml-fix-2.patch
-tty_ioctl-use-termios-for-the-old-structure-and-termios2.patch
-tty_ioctl-use-termios-for-the-old-structure-and-termios2-fix.patch
-tty_ioctl-use-termios-for-the-old-structure-and-termios2-update.patch
-termios-enable-new-style-termios-ioctls-on-x86-64.patch
-char-isicom-expand-function.patch
-char-isicom-rename-init-function.patch
-char-isicom-remove-isa-code.patch
-char-isicom-remove-unneeded-memset.patch
-char-isicom-move-to-tty_register_device.patch
-char-isicom-use-pci_request_region.patch
-char-isicom-check-kmalloc-retval.patch
-char-isicom-use-completion.patch
-char-isicom-simplify-timer.patch
-char-isicom-remove-cvs-stuff.patch
-char-isicom-fix-tty-index-check.patch
-char-sx-convert-to-pci-probing.patch
-char-sx-use-kcalloc.patch
-char-sx-mark-functions-as-devinit.patch
-char-sx-use-eisa-probing.patch
-char-sx-ifdef-isa-code.patch
-char-sx-lock-boards-struct.patch
-char-sx-remove-duplicite-code.patch
-char-sx-whitespace-cleanup.patch
-char-sx-simplify-timer-logic.patch
-char-sx-fix-return-in-module-init.patch
-char-sx-use-pci_iomap.patch
-char-sx-request-regions.patch
-char-stallion-convert-to-pci-probing.patch
-char-stallion-prints-cleanup.patch
-char-stallion-implement-fail-paths.patch
-char-stallion-correct-__init-macros.patch
-char-stallion-functions-cleanup.patch
-char-stallion-fix-fail-paths.patch
-char-stallion-brd-struct-locking.patch
-char-stallion-remove-syntactic-sugar.patch
-char-stallion-variables-cleanup.patch
-char-stallion-use-dynamic-dev.patch
-char-istallion-convert-to-pci-probing.patch
-char-istallion-remove-the-mess.patch
-char-istallion-eliminate-typedefs.patch
-char-istallion-variables-cleanup.patch
-char-istallion-ifdef-eisa-code.patch
-char-istallion-brdnr-locking.patch
-char-istallion-free-only-isa.patch
-char-istallion-correct-fail-paths.patch
-char-istallion-correct-fail-paths-fix.patch
-char-istallion-fix-enabling.patch
-char-istallion-move-init-and-exit-code.patch
-char-istallion-change-init-sequence.patch
-char-istallion-dynamic-tty-device.patch
-char-istallion-use-mod_timer.patch
-char-cyclades-save-indent-levels.patch
-char-cyclades-lindent-the-code.patch
-char-cyclades-cleanup.patch
-char-cyclades-fix-warnings.patch
-drivers-isdn-handcrafted-min-max-macro-removal.patch
-drivers-isdn-handcrafted-min-max-macro-removal-fix.patch
-isdn-fix-missing-unregister_capi_driver.patch
-isdn-avoid-a-potential-null-ptr-deref-in-ippp.patch
-drivers-isdn-trivial-vsnprintf-conversion.patch
-isdn-replace-kmallocmemset-with-kzalloc.patch
-i4l-remove-the-broken-hisax_amd7930-option.patch
-lockdep-annotate-nfsd4-recover-code.patch
-nfs2-calculate-w-a-bit-later-in-nfsaclsvc_encode_getaclres.patch
-nfs3-calculate-w-a-bit-later-in-nfs3svc_encode_getaclres.patch
-fault-injection-documentation-and-scripts.patch
-fault-injection-capabilities-infrastructure.patch
-fault-injection-capabilities-infrastructure-tidy.patch
-fault-injection-capabilities-infrastructure-tweaks.patch
-fault-injection-capability-for-kmalloc.patch
-fault-injection-capability-for-kmalloc-failslab-remove-__gfp_highmem-filtering.patch
-fault-injection-capability-for-alloc_pages.patch
-fault-injection-capability-for-disk-io.patch
-fault-injection-process-filtering-for-fault-injection-capabilities.patch
-fault-injection-stacktrace-filtering.patch
-fault-injection-stacktrace-filtering-reject-failure-if-any-caller-lies-within-specified-range.patch
-fault-injection-Kconfig-cleanup.patch
-fault-injection-stacktrace-filtering-kconfig-fix.patch
-fault-injection-Kconfig-cleanup-config_fault_injection-help-text.patch
-schedc-correct-comment-for-this_rq_lock-routine.patch
-sched-fix-migration-cost-estimator.patch
-sched-domain-move-sched-group-allocations-to-percpu-area.patch
-move_task_off_dead_cpu-should-be-called-with-disabled-ints.patch
-sched-domain-increase-the-smt-busy-rebalance-interval.patch
-sched-avoid-taking-rq-lock-in-wake_priority_sleeper.patch
-sched-remove-staggering-of-load-balancing.patch
-sched-disable-interrupts-for-locking-in-load_balance.patch
-sched-extract-load-calculation-from-rebalance_tick.patch
-sched-move-idle-status-calculation-into-rebalance_tick.patch
-sched-use-softirq-for-load-balancing.patch
-sched-call-tasklet-less-frequently.patch
-sched-add-option-to-serialize-load-balancing.patch
-sched-add-option-to-serialize-load-balancing-fix.patch
-sched-improve-migration-accuracy.patch
-sched-improve-migration-accuracy-tidy.patch
-sched-improve-migration-accuracy-fix.patch
-sched-decrease-number-of-load-balances.patch
-sched-optimize-activate_task-for-rt-task.patch
-kernel-schedc-whitespace-cleanups.patch
-kernel-schedc-whitespace-cleanups-more.patch
-sysctl-simplify-sysctl_uts_string.patch
-sysctl-implement-sysctl_uts_string.patch
-sysctl-simplify-ipc-ns-specific-sysctls.patch
-sysctl-fix-sys_sysctl-interface-of-ipc-sysctls.patch
-sysctl-fix-sys_sysctl-interface-of-ipc-sysctls-fix.patch
-ide-more-conversion-to-pci_get-apis.patch
-ioremap-balanced-with-iounmap-for-drivers-video-virgefb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-vesafb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-tridentfb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-tgafb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-stifb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-retz3fb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-pvr2fb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-platinumfb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-offb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-macfb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-hpfb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-fm2fb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-ffb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-cyberfb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-cirrusfb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-atyfb_base.patch
-ioremap-balanced-with-iounmap-for-drivers-video-atafb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-amifb.patch
-ioremap-balanced-with-iounmap-for-drivers-video-S3triofb.patch
-atyfb-rivafb-minor-fixes.patch
-igafb-switch-to-pci_get-api.patch
-video-sis-remove-unnecessary-variables-in-sis_ddc2delay.patch
-pmagb-b-fb-fix-a-default-clock.patch
-video-get-the-default-mode-from-the-right-database.patch
-s3c2410fb-add-support-for-stn-displays.patch
-fbcmapc-mark-structs-const-or.patch
-various-fbdev-files-mark-structs.patch
-various-fbdev-files-mark-structs-fix.patch
-constify-and-annotate-__read_mostly.patch
-annotate-some-variables-in-vesafb.patch
-constify-vga16fbc.patch
-au1100fb-fix-to-remove-flickering.patch
-mbxfb-fix-hscoeff3-register-address.patch
-mbxfb-add-more-registers-bits.patch
-mbxfb-add-more-registers-to-debugfs.patch
-mbxfb-add-yuv-video-overlay-support.patch
-mbxfb-document-the-new-ioctl.patch
-atyfb-remove-fixme.patch
-atyfb-fix-compiler-warnings.patch
-atyfb-fix-sparse-warnings.patch
-atyfb-fix-blanking-level.patch
-atyfb-remove-pointless-aty_init.patch
-atyfb-fix-__init-and-__devinit.patch
-atyfb-remove-aty_cmap_regs.patch
-atyfb-improve-atyfb_atari_probe.patch
-atyfb-improve-power-management.patch
-drivers-video-use-kmemdup.patch
-visws-sgivwfb-is-module-needs-exports.patch
-backlight-lcd-remove-dependenct-from-the-framebuffer-layer.patch
-backlight-lcd-remove-dependenct-from-the-framebuffer-layer-tidy.patch
-softcursorc-avoid-unaligned-accesses.patch
-dm-io-fix-bi_max_vecs.patch
-dm-tidy-core-formatting.patch
-dm-suspend-parameter-change.patch
-dm-map-and-endio-return-code-clarification.patch
-dm-map-and-endio-symbolic-return-codes.patch
-dm-ioctl-add-noflush-suspend.patch
-dm-suspend-add-noflush-pushback.patch
-dm-mpath-use-noflush-suspending.patch
-dm-snapshot-abstract-memory-release.patch
-dm-log-rename-complete_resync_work.patch
-dm-raid1-reset-sync_search-on-resume.patch
-make-drivers-md-dm-snapcksnapd-static.patch
-md-tidy-up-device-change-notification-when-an-md-array-is-stopped.patch
-md-define-raid5_mergeable_bvec.patch
-md-handle-bypassing-the-read-cache-assuming-nothing-fails.patch
-md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure.patch
-md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-fix.patch
-md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-misc-fixes-for-aligned-read-handling-including-raid6-read-corruption.patch
-md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-misc-fixes-for-error-handling-of-aligned-reads.patch
-md-enable-bypassing-cache-for-reads.patch
-md-fix-innocuous-bug-in-raid6-stripe_to_pdidx.patch
-md-conditionalize-some-code.patch
-dio-centralize-completion-in-dio_complete.patch
-dio-call-blk_run_address_space-once-per-op.patch
-dio-formalize-bio-counters-as-a-dio-reference-count.patch
-dio-remove-duplicate-bio-wait-code.patch
-dio-only-call-aio_complete-after-returning-eiocbqueued.patch
-dio-lock-refcount-operations.patch
-fdtable-delete-pointless-code-in-dup_fd.patch
-fdtable-make-fdarray-and-fdsets-equal-in-size.patch
-fdtable-remove-the-free_files-field.patch
-fdtable-implement-new-pagesize-based-fdtable-allocator.patch
-fdtable-implement-new-pagesize-based-fdtable-allocator-fix.patch
-fdtable-implement-new-pagesize-based-fdtable-allocator-bound-minimum-allocation-size.patch
-fdtable-implement-new-pagesize-based-fdtable-allocator-avoid-fdset-cacheline-ping-pong.patch
-round_jiffies-infrastructure.patch
-round_jiffies-infrastructure-fix.patch
-user-of-the-jiffies-rounding-patch-ata-subsystem.patch
-user-of-the-jiffies-rounding-code-jbd.patch
-user-of-the-jiffies-rounding-code-networking.patch
-user-of-the-jiffies-rounding-patch-slab.patch
-clocksource-add-usage-of-config_sysfs.patch
-clocksource-small-cleanup-2.patch
-clocksource-small-cleanup-2-fix.patch
-clocksource-small-acpi_pm-cleanup.patch
-kvm-userspace-interface.patch
-kvm-userspace-interface-make-enum-values-in-userspace-interface-explicit.patch
-kvm-intel-virtual-mode-extensions-definitions.patch
-kvm-kvm-data-structures.patch
-kvm-random-accessors-and-constants.patch
-kvm-virtualization-infrastructure.patch
-kvm-virtualization-infrastructure-kvm-fix-guest-cr4-corruption.patch
-kvm-virtualization-infrastructure-include-desch.patch
-kvm-virtualization-infrastructure-fix-segment-state-changes-across-processor-mode-switches.patch
-kvm-virtualization-infrastructure-fix-asm-constraints-for-segment-loads.patch
-kvm-virtualization-infrastructure-fix-mmu-reset-locking-when-setting-cr0.patch
-kvm-memory-slot-management.patch
-kvm-vcpu-creation-and-maintenance.patch
-kvm-vcpu-creation-and-maintenance-segment-access-cleanup.patch
-kvm-workaround-cr0cd-cache-disable-bit-leak-from-guest-to.patch
-kvm-vcpu-execution-loop.patch
-kvm-define-exit-handlers.patch
-kvm-define-exit-handlers-pass-fs-gs-segment-bases-to-x86-emulator.patch
-kvm-less-common-exit-handlers.patch
-kvm-less-common-exit-handlers-handle-rdmsrmsr_efer.patch
-kvm-mmu.patch
-kvm-x86-emulator.patch
-kvm-clarify-licensing.patch
-kvm-x86-emulator-fix-emulator-mov-cr-decoding.patch
-kvm-plumbing.patch
-kvm-dynamically-determine-which-msrs-to-load-and-save.patch
-kvm-fix-calculation-of-initial-value-of-rdx-register.patch
-kvm-avoid-using-vmx-instruction-directly.patch
-kvm-avoid-using-vmx-instruction-directly-fix-asm-constraints.patch
-kvm-expose-interrupt-bitmap.patch
-kvm-add-time-stamp-counter-msr-and-accessors.patch
-kvm-expose-msrs-to-userspace.patch
-kvm-expose-msrs-to-userspace-v2.patch
-kvm-create-kvm-intelko-module.patch
-kvm-make-dev-registration-happen-when-the-arch.patch
-kvm-make-hardware-detection-an-arch-operation.patch
-kvm-make-the-per-cpu-enable-disable-functions-arch.patch
-kvm-make-the-hardware-setup-operations-non-percpu.patch
-kvm-make-the-guest-debugger-an-arch-operation.patch
-kvm-make-msr-accessors-arch-operations.patch
-kvm-make-the-segment-accessors-arch-operations.patch
-kvm-cache-guest-cr4-in-vcpu-structure.patch
-kvm-cache-guest-cr0-in-vcpu-structure.patch
-kvm-add-get_segment_base-arch-accessor.patch
-kvm-add-idt-and-gdt-descriptor-accessors.patch
-kvm-make-syncing-the-register-file-to-the-vcpu.patch
-kvm-make-the-vcpu-execution-loop-an-arch-operation.patch
-kvm-move-the-vmx-exit-handlers-to-vmxc.patch
-kvm-make-vcpu_setup-an-arch-operation.patch
-kvm-make-__set_cr0-and-dependencies-arch-operations.patch
-kvm-make-__set_cr4-an-arch-operation.patch
-kvm-make-__set_efer-an-arch-operation.patch
-kvm-make-set_cr3-and-tlb-flushing-arch-operations.patch
-kvm-make-inject_page_fault-an-arch-operation.patch
-kvm-make-inject_gp-an-arch-operation.patch
-kvm-use-the-idt-and-gdt-accessors-in-realmode-emulation.patch
-kvm-use-the-general-purpose-register-accessors-rather.patch
-kvm-move-the-vmx-tsc-accessors-to-vmxc.patch
-kvm-access-rflags-through-an-arch-operation.patch
-kvm-move-the-vmx-segment-field-definitions-to-vmxc.patch
-kvm-add-an-arch-accessor-for-cs-d-b-and-l-bits.patch
-kvm-add-a-set_cr0_no_modeswitch-arch-accessor.patch
-kvm-make-vcpu_load-and-vcpu_put-arch-operations.patch
-kvm-make-vcpu-creation-and-destruction-arch-operations.patch
-kvm-move-vmcs-static-variables-to-vmxc.patch
-kvm-make-is_long_mode-an-arch-operation.patch
-kvm-use-the-tlb-flush-arch-operation-instead-of-an.patch
-kvm-remove-guest_cpl.patch
-kvm-move-vmcs-accessors-to-vmxc.patch
-kvm-move-vmx-helper-inlines-to-vmxc.patch
-kvm-remove-vmx-includes-from-arch-independent-code.patch
-kvm-build-fix.patch
-kvm-build-fix-2.patch

 Merged into mainline or a subsystem tree.

+x86-smp-export-smp_num_siblings-for-oprofile.patch
+tty-export-get_current_tty.patch
+ieee80211softmac-fix-errors-related-to-the-work_struct-changes.patch
+kvm-add-missing-include.patch
+kvm-put-kvm-in-a-new-virtualization-menu.patch
+kvm-clean-up-amd-svm-debug-registers-load-and-unload.patch
+kvm-replace-__x86_64__-with-config_x86_64.patch
+fix-more-workqueue-build-breakage-tps65010.patch
+another-build-fix-header-rearrangements-osk.patch
+uml-fix-net_kern-workqueue-abuse.patch
+isdn-gigaset-fix-possible-missing-wakeup.patch
+i2o_exec_exit-and-i2o_driver_exit-should-not-be-__exit.patch

 2.6.20 queue.

+revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
+revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
+generic_file_buffered_write-cleanup.patch
+mm-only-mm-debug-write-deadlocks.patch
+mm-fix-pagecache-write-deadlocks.patch
+mm-fix-pagecache-write-deadlocks-comment.patch
+mm-fix-pagecache-write-deadlocks-xip.patch
+mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
+mm-fix-pagecache-write-deadlocks-zerolength-fix.patch
+mm-fix-pagecache-write-deadlocks-stale-holes-fix.patch
+fs-prepare_write-fixes.patch
+fs-prepare_write-fixes-fuse-fix.patch
+fs-prepare_write-fixes-jffs-fix.patch
+fs-prepare_write-fixes-fat-fix.patch
+fs-fix-cont-vs-deadlock-patches.patch

 Bring back the ongoing pagecache deadlock fix work.

-implementation-of-acpi_video_get_next_level-tidy.patch

 Folded into implementation-of-acpi_video_get_next_level.patch

-video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-fix.patch

 Folded into video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch

+fbdev-update-after-backlight-argument-change.patch

 Fix fbdev for acpi changes.

+add-support-for-asus-a6va-m6v-w5f-v6v-laptops-in-asus-acpi.patch
+add-support-for-acpi_load_table-acpi_unload_table_id.patch
+altix-acpi-ssdt-pci-device-support.patch
+altix-add-acpi-ssdt-pci-device-support-hotplug.patch
+acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi.patch

 ACPI updates.

+sony_apci-resume-fix.patch

 Fix sony_apci-resume.patch

+git-alsa-fixup.patch

 Fix reject in git-alsa.patch

+alsa-workqueue-fixes.patch

 Fix alsa

+git-cpufreq-fixup.patch

 Fix rejects in git-cpufreq,patch

+ppc-cs4218_tdm-remove-extra-brace.patch

 ppc build fix

+gregkh-driver-uio.patch
+gregkh-driver-uio-dummy.patch
+gregkh-driver-driver-core-delete-virtual-directory-on-class_unregister.patch
+gregkh-driver-debugfs-inotify-create-mkdir-support.patch
+gregkh-driver-debugfs-coding-style-fixes.patch
+gregkh-driver-debugfs-file-directory-creation-error-handling.patch
+gregkh-driver-debugfs-more-file-directory-creation-error-handling.patch
+gregkh-driver-debugfs-file-directory-removal-fix.patch
+gregkh-driver-driver-core-platform_driver_probe-can-save-codespace-save-codespace.patch
+gregkh-driver-driver-core-make-platform_device_add_data-accept-a-const-pointer.patch
+gregkh-driver-driver-core-deprecate-pm_legacy-default-it-to-n.patch
+gregkh-driver-network-device.patch

 driver tree updates

+tty-switch-to-ktermios-nozomi-fix.patch

 Fix it.

+drm-handle-pci_enable_device-failure.patch

 DRM fixlet.

+saa7134-add-support-for-the-encore-enl-tv.patch
+drivers-media-video-cpia2-cpia2_usbc-free.patch
+fix-namespace-conflict-between-w9968cfc-on-mips.patch
+avoid-race-when-deregistering-the-ir-control-for-dvb-usb.patch

 DVB fixes

+jdelvare-i2c-i2c-i801-documentation-update.patch
+jdelvare-i2c-i2c-fix-broken-ds1337-initialization.patch
+jdelvare-i2c-i2c-versatile-new-arm-bus-driver.patch
+jdelvare-i2c-i2c-discard-del-bus-wrappers.patch
+jdelvare-i2c-i2c-i801-enable-PEC-on-ICH6.patch
+jdelvare-i2c-i2c-dev-fix-return-value-check.patch
+jdelvare-i2c-i2c-dev-merge-kfree.patch
+jdelvare-i2c-i2c-omap-prescaler-formula.patch

 i2c tree updates

+jdelvare-hwmon-hwmon-unchecked-return-status-fixes-abituguru.patch
+jdelvare-hwmon-hwmon-rudolf-marek-changed-email-address.patch
+jdelvare-hwmon-hwmon-w83793-new-driver.patch
+jdelvare-hwmon-hwmon-w83793-documentation.patch
+jdelvare-hwmon-hwmon-ams-new-driver.patch
+jdelvare-hwmon-hwmon-ams-maintainers.patch

 hwmon tree updates

+make-lm70_remove-a-__devexit-function.patch

 hwmon fix.

+ia64-enable-config_debug_spinlock_sleep.patch

 Help ia64 developers find bugs.

+git-libata-all-fixup.patch

 Fix rejects in git-libata-all.patch

+sata_nv-add-suspend-resume-support.patch
+pata_it8213-add-new-driver-for-the-it8213-card.patch
+libata-simulate-report-luns-for-atapi-devices.patch
+user-of-the-jiffies-rounding-patch-ata-subsystem.patch
+libata-fix-oops-with-sparsemem.patch

 ata/pata updates.

+mips-dbg_io-stray-brackets-fix.patch

 mips fix

+git-mmc-fixup.patch

 Fix rejects in git-mmc.patch

+git-mmc-tifm_sd-warning-fix.patch
+mmc-fix-prev-state-2-=-task_running-problem-on-sd-mmc-card-removal.patch

 MMC fixes

+git-mtd-build-fix.patch

 MTD fix

+ubi-versus-add-include-linux-freezerh-and-move-definitions-from.patch

 Fix UBI tree

-git-netdev-all-fixup.patch
-libphy-dont-do-that.patch

 Unneeded

+spidernet-dma-coalescing.patch
+spidernet-add-net_ratelimit-to-suppress-long-output.patch
+spidernet-rx-locking.patch
+spidernet-refactor-rx-refill.patch
+spidernet-rx-skb-mem-leak.patch
+spidernet-another-skb-mem-leak.patch
+spidernet-cleanup-return-codes.patch
+spidernet-rx-refill.patch
+spidernet-merge-error-branches.patch
+spidernet-remove-unused-variable.patch
+spidernet-rx-chain-tail.patch
+spidernet-turn-rx-irq-back-on.patch
+spidernet-memory-barrier.patch
+spidernet-avoid-possible-rx-chain-corruption.patch
+spidernet-rx-debugging-printout.patch
+spidernet-rework-rx-linked-list.patch
+driver-for-silan-sc92031-netdev.patch
+driver-for-silan-sc92031-netdev-fixes.patch
+driver-for-silan-sc92031-netdev-include-fix.patch

 netdev things.

-auth_gss-unregister-gss_domain-when-unloading-module-fix.patch

 Folded into auth_gss-unregister-gss_domain-when-unloading-module.patch

-serial-handle-pci_enable_device-failure-upon-resume.patch

 Dropped

+fix-pnx8550-serial-breakage.patch
+pnx8550-uart-driver.patch

 Serial updates

+gregkh-pci-pci-use-sys-bus-pci-drivers-driver-new_id-first.patch
+gregkh-pci-pci-add-class-codes-for-wireless-rf-controllers.patch
+gregkh-pci-pci-quirks-remove-redundant-check.patch
+gregkh-pci-rpaphp-compiler-warning-cleanup.patch
+gregkh-pci-pci-pcieport-driver-remove-invalid-warning-message.patch
+gregkh-pci-pci-introduce-pci_find_present.patch
+gregkh-pci-pci-create-__pci_bus_find_cap_start-from-__pci_bus_find_cap.patch
+gregkh-pci-pci-add-pci_find_ht_capability-for-finding-hypertransport-capabilities.patch
+gregkh-pci-pci-use-pci_find_ht_capability-in-drivers-pci-htirq.c.patch
+gregkh-pci-pci-add-defines-for-hypertransport-msi-fields.patch
+gregkh-pci-pci-use-pci_find_ht_capability-in-drivers-pci-quirks.c.patch
+gregkh-pci-pci-only-check-the-ht-capability-bits-in-mpic.c.patch
+gregkh-pci-pci-fix-multiple-problems-with-via-hardware.patch
+gregkh-pci-pci-be-a-bit-defensive-in-quirk_nvidia_ck804-so-we-don-t-risk-dereferencing-a-null-pdev.patch
+gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch

 PCI tree updates

+dont-export-device-ids-to-userspace.patch
+via-sb600-sata-quirk.patch
+pci-legacy-resource-fix.patch
+pci-legacy-resource-fix-tidy.patch

 PCI updates

-scsi-in2000-scsi_cmnd-convertion-tidy.patch

 Folded into scsi-in2000-scsi_cmnd-convertion.patch

+scsi-sic7xxx-stray-bracket-fix.patch
+scsi-53c7xx-brackets-fix.patch
+fix-sense-key-medium-error-processing-and-retry.patch
+sym53c8xx_2-claims-cpqarray-device.patch
+aic79xx-wrong-max-memory-at-driver-init.patch
+drivers-scsi-wd33c93c-cleanups.patch
+scsi-cover-up-bugs-fix-up-compiler-warnings-in-megaraid-driver.patch
+scsi-cover-up-bugs-fix-up-compiler-warnings-in-megaraid-driver-fix.patch
+kbuild-make-fusion-mpt-selectable-from-device-drivers.patch

 SCSI updates

-git-sas-fixup.patch

 Unneeded

+git-qla3xxx-fixup.patch

 Fix rejects in git-qla3xxx.patch

+gregkh-usb-usb-fix-oops-in-phidgetservo.patch
+gregkh-usb-usb-transvibrator-disconnect-race.patch
+gregkh-usb-usb-airprime-add-device-id-for-dell-wireless-5500-hsdpa-card.patch
+gregkh-usb-usb-ftdi_sio-machx-product-id-added.patch
+gregkh-usb-usb-removing-ifdefed-code-from-gl620a.patch
+gregkh-usb-usb-serial-eliminate-bogus-ioctl-code.patch
+gregkh-usb-usb-mutexification-of-usblp.patch
+gregkh-usb-add-baltech-reader-id-to-cp2101-driver.patch
+gregkh-usb-usb-prevent-the-funsoft-serial-device-from-entering-raw-mode.patch
+gregkh-usb-usb-fix-ohci.h-over-use-warnings.patch
+gregkh-usb-usb-rtl8150-new-device-id.patch
+gregkh-usb-usb-storage-ignore-the-virtual-cd-drive-of-the-huawei-e220-usb-modem.patch
+gregkh-usb-usb-gsm-driver-added-vendorid-and-productid-for-huawei-e220-usb-modem.patch
+gregkh-usb-usb-fix-wacom-intuos3-4x6-bugs.patch
+gregkh-usb-usb-auerswald-replace-kmalloc-memset-with-kzalloc.patch
+gregkh-usb-usb-nokia-e70-is-an-unusual-device.patch
+gregkh-usb-uhci-module-parameter-to-ignore-overcurrent-changes.patch
+gregkh-usb-usb-gadget-driver-unbind-is-optional-section-fixes-misc.patch
+gregkh-usb-usb-maintainers-update-ehci-and-ohci.patch
+gregkh-usb-usb-ohci-whitespace-comment-fixups.patch
+gregkh-usb-usb-ohci-at91-warning-fix.patch
+gregkh-usb-usb-ohci-handles-hardware-faults-during-root-port-resets.patch
+gregkh-usb-usb-ohci-support-for-pnx8550.patch
+gregkh-usb-usb-at91-udc-support-at91sam926x-addresses.patch
+gregkh-usb-usb-at91_udc-misc-fixes.patch
+gregkh-usb-usb-u132-hcd-ftdi-elan-add-support-for-option-gt-3g-quad-card.patch
+gregkh-usb-usb-at91_udc-allow-drivers-that-support-high-speed.patch
+gregkh-usb-usb-at91_udc-cleanup-variables-after-failure-in-usb_gadget_register_driver.patch
+gregkh-usb-usb-at91_udc-additional-checks.patch
+gregkh-usb-ehci-eliminate-fstn-leaks-on-ehci-shutdown.patch
+gregkh-usb-ehci-correct-harmless-bracketing-and-whitespace-errors.patch

 USB tree updates

+usb_rtl8150-must-select-mii.patch
+usb-serial-add-support-for-novatel-s720-u720-cdma-ev-do.patch
+bluetooth-add-support-for-another-kensington-dongle.patch
+fix-gregkh-usb-usb-ehci-hcd-add-shadow-budget-code.patch

 USB updates

+watchdog-omap_wdt-build-fix.patch

 watchdog driver fix

+zd1211rw-call-ieee80211_rx-in-tasklet.patch
+ieee80211softmac-fix-mutex_lock-at-exit-of-ieee80211_softmac_get_genie.patch

 wireless fixes

-pre-x86_64-mm-i386-reloc-abssym.patch

 Unneeded

+x86_64-mm-i386-add-idle-notifier.patch

 x86 tree update

+revert-i386-fix-the-verify_quirk_intel_irqbalance.patch
+revert-x86_64-mm-add-genapic_force.patch
+revert-x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
+convert-i386-pda-code-to-use-%fs.patch
+convert-i386-pda-code-to-use-%fs-fixes.patch
+x86_64-i386-kernel-mode-faults-pollute-current-thead.patch
+genapic-optimize-fix-apic-mode-setup-2.patch
+genapic-always-use-physical-delivery-mode-on-8-cpus.patch
+genapic-remove-es7000-workaround.patch
+genapic-remove-clustered-apic-mode.patch
+genapic-default-to-physical-mode-on-hotplug-cpu-kernels.patch
+x86_64-do-not-enable-the-nmi-watchdog-by-default.patch
+x86_64-make-the-numa-hash-function-nodemap-allocation.patch
+x86_64-make-the-numa-hash-function-nodemap-allocation-fix.patch
+x86_64-make-the-numa-hash-function-nodemap-allocation-fix-2.patch
+i386-io_apic-fix-a-typo-in-an-irq-handler-name.patch
+pci-mmconfig-share-whats-shareable.patch
+pci-mmconfig-only-call-unreachable_devices-when-type-1-is-available.patch
+pci-mmconfig-only-map-whats-necessary.patch
+pci-mmconfig-detect-and-support-the-e7520-and-the-945g-gz-p-pl.patch
+pci-mmconfig-reserve-resources-but-only-when-were-sure-about-them.patch

 x86 updates

+xfs-remove-useless-wmb-memory-barrier.patch

 XFS tweak

+virtual-memmap-on-sparsemem-v3-map-and-unmap.patch
+virtual-memmap-on-sparsemem-v3-map-and-unmap-fix.patch
+virtual-memmap-on-sparsemem-v3-map-and-unmap-fix-2.patch
+virtual-memmap-on-sparsemem-v3-map-and-unmap-fix-3.patch
+virtual-memmap-on-sparsemem-v3-generic-virtual.patch
+virtual-memmap-on-sparsemem-v3-generic-virtual-fix.patch
+virtual-memmap-on-sparsemem-v3-static-virtual.patch
+virtual-memmap-on-sparsemem-v3-static-virtual-update.patch
+virtual-memmap-on-sparsemem-v3-ia64-support.patch
+virtual-memmap-on-sparsemem-v3-ia64-support-update.patch
+cleanup-slab-headers--api-to-allow-easy-addition-of-new-slab.patch
+more-slabh-cleanups.patch
+cpuset-rework-cpuset_zone_allowed-api.patch

 MM updates

+slab-use-a-multiply-instead-of-a-divide-in-obj_to_index.patch
+slab-use-a-multiply-instead-of-a-divide-in-obj_to_index-tweaks.patch

 slab speedup

-acx1xx-wireless-driver.patch

 The workqueue changes broke this.

+file-capabilities-dont-do-file-caps-if-mnt_nosuid.patch
+file-capabilities-honor-secure_noroot.patch

 Fix implement-file-posix-capabilities.patch

+pm-fix-freezing-of-stopped-tasks.patch
+pm-fix-smp-races-in-the-freezer.patch

 swsusp updates

+drivers-add-lcd-support-workqueue-fixups.patch

 Fix LCD driver for workqueue changes

+doc-atomic_add_unless-doesnt-imply-mb-on-failure.patch
+touch_atime-cleanup.patch
+relative-atime.patch
+ocfs2-relative-atime-support.patch
+ocfs2-relative-atime-support-tweaks.patch
+ecryptfs-public-key-transport-mechanism.patch
+ecryptfs-public-key-packet-management.patch
+ecryptfs-public-key-packet-management-slab-fix.patch
+optimize-o_direct-on-block-device-v3.patch
+optimize-o_direct-on-block-device-v3-tweak.patch
+# add-retain_initrd-boot-option.patch: unpopular (Vivek)
+add-retain_initrd-boot-option.patch
+add-retain_initrd-boot-option-tweak.patch
+debug-add-sysrq_always_enabled-boot-option.patch
+lockdep-filter-off-by-default.patch
+lockdep-improve-verbose-messages.patch
+lockdep-improve-lockdep_reset.patch
+lockdep-clean-up-very_verbose-define.patch
+lockdep-use-chain-hash-on-config_debug_lockdep-too.patch
+lockdep-print-irq-trace-info-on-asserts.patch
+lockdep-fix-possible-races-while-disabling-lock-debugging.patch
+lockdep-fix-possible-races-while-disabling-lock-debugging-fix.patch
+# use-activate_mm-in-fs-aiocuse_mm.patch: maybe
+use-activate_mm-in-fs-aiocuse_mm.patch
+fix-numerous-kcalloc-calls-convert-to-kzalloc.patch
+tty-remove-useless-memory-barrier.patch
+config_computone-should-depend-on-isaeisapci.patch
+appldata_mem-dependes-on-vm-counters.patch
+uml-problems-with-linux-ioh.patch
+missing-includes-in-hilkbd.patch
+hci-endianness-annotations.patch
+lockd-endianness-annotations-rebased.patch
+rtc-fix-error-case.patch
+rtc-driver-init-adjustment.patch
+tty_ioc-balance-tty_ldisc_ref.patch

 Misc updates

+workstruct-implement-generic-up-cmpxchg-where-an-arch-doesnt-support-it.patch
+workqueue-dont-hold-workqueue_mutex-in-flush_scheduled_work.patch

 workqueue things.

+move-page-writeback-acounting-out-of-macros.patch
+per-backing_dev-dirty-and-writeback-page-accounting.patch

 Some stuff I'm (slowly) working on to address write() latency.

+ext2-balloc-fix-_with_rsv-freeze.patch
+ext2-balloc-reset-windowsz-when-full.patch
+ext2-balloc-fix-off-by-one-against-rsv_end.patch
+ext2-balloc-fix-off-by-one-against-grp_goal.patch
+ext2-balloc-say-rb_entry-not-list_entry.patch
+ext2-balloc-use-io_error-label.patch

 Fix ext2 reservations code.

+let-warn_on-output-the-condition.patch

 Print the expression when WARN_ON() triggers (I'm not sure this has a
 sufficient utility-to-bloat ratio).

+knfsd-nfsd4-remove-a-dprink-from-nfsd4_lock.patch
+knfsd-svcrpc-fix-gss-krb5i-memory-leak.patch
+knfsd-nfsd4-clarify-units-of-compound_slack_space.patch
+knfsd-nfsd-make-exp_rootfh-handle-exp_parent-errors.patch
+knfsd-nfsd-simplify-exp_pseudoroot.patch
+knfsd-nfsd4-handling-more-nfsd_cross_mnt-errors-in-nfsd4-readdir.patch
+knfsd-nfsd-dont-drop-silently-on-upcall-deferral.patch
+knfsd-svcrpc-remove-another-silent-drop-from-deferral-code.patch
+knfsd-nfsd4-pass-saved-and-current-fh-together-into-nfsd4-operations.patch
+knfsd-nfsd4-remove-spurious-replay_owner-check.patch
+knfsd-nfsd4-move-replay_owner-to-cstate.patch
+knfsd-nfsd4-dont-inline-nfsd4-compound-op-functions.patch
+knfsd-nfsd4-make-verify-and-nverify-wrappers.patch
+knfsd-nfsd4-reorganize-compound-ops.patch
+knfsd-nfsd4-simplify-migration-op-check.patch
+knfsd-nfsd4-simplify-filehandle-check.patch
+knfsd-dont-ignore-kstrdup-failure-in-rpc-caches.patch
+knfsd-fix-up-some-bit-rot-in-exp_export.patch

 NFSD updates

+sched2-sched-domain-sysctl-use-ctl_unnumbered.patch

 Fix sched2-sched-domain-sysctl.patch

+mm-implement-swap-prefetching-use-ctl_unnumbered.patch

 Fix mm-implement-swap-prefetching.patch

+readahead-sysctl-parameters-use-ctl_unnumbered.patch
+readahead-sysctl-parameters-fix.patch
+readahead-nfsd-case-fix-uninitialized-ra_min-ra_max.patch

 Fix readahead patches in -mm.

+reiser4-use-generic-file-read-fix-readpages-unix-file.patch
+reiser4-format-subversion-numbers-heir-set-and-file-conversion-fix-readpages-cryptcompress.patch
+reiser4-use-null-for-pointers.patch
+reiser4-kmem_cache_t-removal.patch

 reiser4 updates.

+pdc202xx_new-remove-useless-code.patch
+pdc202xx_-remove-check_in_drive_lists-abomination.patch

 IDE updates

+proper-backlight-selection-for-fbdev-drivers.patch

 fbdev Kconfig fixes

+md-close-a-race-between-destroying-and-recreating-an-md-device.patch
+md-allow-mddevs-to-live-a-bit-longer-to-avoid-a-loop-with-udev.patch

 RAID updates

-gtod-exponential-update_wall_time.patch

 Dropped

+hrtimers-clean-up-locking-fix.patch
+updated-add-a-framework-to-manage-clock-event-devices-next_event-calculation-fix.patch
+updated-add-a-framework-to-manage-clock-event-devices-pit-broadcasting-fix.patch
+updated-high-res-timers-core-high-res-timers-do-itimer-rearming-in-process-context.patch
+high-res-timers-utilize-tsc-clocksource-again.patch
+high-res-timers-utilize-tsc-clocksource-again-fix.patch
+updated-dynticks-core-code-fix-resume-bug.patch

 Fix the dynticks+hrtimers patches in -mm.

-kevent-v23-description.patch
-kevent-v23-core-files.patch
-kevent_user_wait-retval-fix.patch
-kevent-v23-poll-select-notifications.patch
-kevent-v23-socket-notifications.patch
-kevent-v23-socket-notifications-fix-again.patch
-kevent-v23-timer-notifications.patch
-kevent-timer-notifications-fix.patch

 Old, dropped.

+slim-main-include-fix.patch

 SLIM fix

+getting-rid-of-all-casts-of-kalloc-calls.patch

 Nuke zillions of unneeded typecasts.

+profile-likely-unlikely-macros_remove-likely-profiling-int-cast.patch

 Fix likely() profiling.

+vdso-print-fatal-signals-use-ctl_unnumbered.patch

 Fix vdso-print-fatal-signals.patch

+lockdep-show-held-locks-when-showing-a-stackdump-fix-2.patch

 Fix lockdep-show-held-locks-when-showing-a-stackdump.patch

+kmap_atomic-debugging.patch

 atomic_kmap() debugging.



All 742 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/patch-list


