Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVEYU4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVEYU4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVEYU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:56:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:6620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261561AbVEYUuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:50:25 -0400
Date: Wed, 25 May 2005 13:49:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1
Message-Id: <20050525134933.5c22234a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/

- Added Oracle's clustering filesystem driver, via git-ocfs.

    OCFS2, a shared disk cluster file system.  See
    Documentation/filesystems/ocfs2.txt Additionally a users guide is
    available at:
    http://oss.oracle.com/projects/ocfs2-tools/dist/documentation/users_guide.txt

- New Xtensa architecture: Tensilica Xtensa CPU series.

- Added the Red Hat distributed lock manager for people to look at.

- Various new git trees.  The remaining holdouts are:

	bk-acpi.patch
	bk-drm.patch
	bk-drm-via.patch
	bk-input.patch
	bk-nfs.patch
	bk-watchdog.patch

- The CPU scheduler is probably busted on the less-common architectures. 
  For now, those architectures will need to emulate
  sched-remove-set_tsk_need_resched-from-init_idle-v2-ia64-fix.patch

- Added the s390 team's execute-in-place driver.  Not sure that I like all
  the code duplication in this though.

- Again, if there are patches in here which you think should be merged in
  2.6.12, please point them out to me.

- CPU scheduler udpates, kexec/kdump updates, i2o updates, v4l updates, etc.



Changes since 2.6.12-rc4-mm2:


-fix-for-bttv-driver-v0915-for-leadtek-winfast-vc100-xp-capture-cards.patch
-serio-resume-fix.patch
-alps-printk-tidy.patch
-alps-resume-fix.patch
-serport-oops-fix.patch
-serio-id-attributes.patch
-fix-impossible-vmallocchunk.patch
-ide-proc-destroy-error.patch
-6300esb-tco-timer-support.patch
-uml-remove-elfh.patch
-uml-critical-change-memcpy-to-memmove.patch
-md-fix-splitting-of-md-linear-request-that-cross-a-device-boundary.patch
-md-set-the-unplug_fn-and-issue_flush_fn-for-md-devices-after-committed-to-creation.patch
-mm-fix-rss-counter-being-incremented-when-unmapping.patch
-mm-acct-accounting-fix.patch
-linux-kernel-elf-core-dump-privilege-elevation.patch
-x86_64-reduce-nmi-watchdog-stack-usage.patch
-x86_64-readd-missing-tests-in-entrys.patch
-x86_64-add-a-guard-page-at-the-end-of-the-47bit-address.patch
-x86_64-fix-defaults-for-physical-core-id-in.patch
-x86_64-increase-number-of-io-apics.patch
-x86_64-dont-look-up-struct-page-pointer-of-physical.patch
-x86_64-update-tsc-sync-algorithm.patch
-x86_64-remove-x86_apicid-field.patch
-x86_64-dont-print-the-internal-k8c-flag-in.patch
-x86_64-remove-unique-apic-io-apic-id-check.patch
-x86_64-add-pmtimer-support.patch
-x86_64-check-if-ptrace-rip-is-canonical.patch
-x86_64-fix-canonical-checking-for-segment-registers-in.patch
-x86_64-when-checking-vmalloc-mappings-dont-use.patch
-x86_64-fix-oem-hpet-check.patch
-x86_64-make-vsyscallc-compile-without-config_sysctl.patch
-x86_64-collected-nmi-watchdog-fixes.patch
-x86_64-collected-nmi-watchdog-fixes-warning-fix.patch
-x86_64-dont-assume-bsp-has-id-0-in-new-smp-bootup.patch
-x86_64-update-defconfig.patch
-mm-nommuc-try-to-fix-__vmalloc.patch
-drivers-input-keyboard-atkbdc-fix-off-by-one-errors.patch
-s390-dasd-set-online-failure.patch
-swapout-oops-fix.patch
-packet-driver-ioctl-fix.patch
-packet-driver-ioctl-fix-fix.patch
-crypto-fix-null-encryption-compression.patch
-cdrw-dvd-packet-writing-data-corruption-fix.patch
-spurious-interrupt-fix.patch
-libata-flush-comreset-set-and-clear.patch
-add-scsi-changer-driver.patch
-add-scsi-changer-driver-gregkh-driver-fix.patch
-block_read_full_page-get_block-error-fix.patch
-do_swap_page-can-map-random-data-if-swap-read-fails.patch
-wireless-3crwe154g72-kconfig-help-fix.patch
-smc91c92_cs-reduce-stack-usage-in-smc91c92_event.patch
-typo-in-tulip-driver.patch
-a-new-10gb-ethernet-driver-by-chelsio-communications.patch
-selinux-fix-avc_alloc_node-oom-with-no-policy-loaded.patch
-mips-add-resource-management-to-pmu.patch
-alpha-osf_sys-use-helper-functions-to-convert-between-tv-and-jiffies.patch
-sysfs-for-ipmi-for-new-mm-kernels.patch
-fix-pci-mmap-on-ppc-and-ppc64.patch
-pcmcia-ds-handle-any-error-code.patch
-kill-asm-ioctl32h.patch
-profilec-schedule-parsing-fix.patch
-ieee1394-feature-removal-notices.patch
-drivers-ieee1394-pcilynxc-remove-dead-options.patch
-drivers-ieee1394-ieee1394_transactionsc-possible-cleanups.patch
-ieee1394-remove-null-checks-prior-to-kfree-in-ieee1394-kfree-handles-null-pointers-fin.patch
-drivers-ieee1394-pcilynxc-use-the-dma_32bit_mask-constant.patch
-ieee1394-single-buffer-fixes-to-video1394.patch
-ieee1394-fix-cross_bound-check-for-null-iso-packets.patch
-ieee1394-fix-premature-expiry-of-async-packets.patch
-dvb-b2c2-flexcop-driver-refactoring-part-1-drop-old-b2c2-usb-stuff.patch
-dvb-b2c2-flexcop-driver-refactoring-part-2-add-modular-flexcop-driver.patch
-dvb-flexcop-fix-usb-transfer-handling.patch
-dvb-flexcop-add-acknowledgements.patch
-dvb-flexcop-fix-mac-address-reading.patch
-dvb-flexcop-fixed-interrupt-sharing.patch
-dvb-flexcop-use-hw-pid-filter.patch
-dvb-flexcop-fix-module-refcount-handling.patch
-dvb-flexcop-readme-update.patch
-dvb-flexcop-i2c-read-fixes.patch
-dvb-flexcop-diseqc-fix.patch
-dvb-support-for-tt-hauppauge-nexus-s-rev-23.patch
-dvb-saa7146-no-need-to-initialize-static-global-variables-to-0.patch
-dvb-dvb_frontend-fix-module-param.patch
-dvb-av7110-audio-out-fix.patch
-dvb-add-support-for-knc-1-cards.patch
-dvb-remove-unnecessary-casts-in-dvb-core.patch
-dvb-dvb_net-handle-ipv6-and-llc-snap.patch
-dvb-av7110-fix-video_set_display_format.patch
-dvb-av7110-fix-ntsc-pal-switching.patch
-dvb-av7110-fix-comment.patch
-dvb-av7110-fix-indentation.patch
-dvb-nxt6000-support-frontend-status-reads.patch
-dvb-tda1004x-formatting-cleanups.patch
-dvb-stv0299-fix-fe_dishnetwork_send_legacy_cmd.patch
-dvb-remove-unnecessary-casts-in-frontends.patch
-dvb-dib3000-add-null-pointer-check.patch
-dvb-ves1820-remove-unnecessary-msleep.patch
-dvb-mt352-embed-struct-mt352_config-in-mt352_state.patch
-dvb-tda1004x-dont-use-bitfields.patch
-dvb-tda1004x-allow-n_i2c-to-be-overridden-by-the-card-driver.patch
-dvb-tda10046-support-for-different-firmware-versions.patch
-dvb-dvb-pllh-prevent-multiple-inclusion.patch
-dvb-make-needlessly-global-code-static-or-drop-it.patch
-dvb-frontends-misc-minor-cleanups.patch
-dvb-modified-dvb_register_adapter-to-avoid-kmalloc-kfree.patch
-dvb-bt8xx-update-documentation.patch
-dvb-dst-reorganize-twinhan-dst-driver-to-support-ci.patch
-dvb-dst-add-support-for-twinhan-200103a.patch
-dvb-dst-fixed-tuning-problem.patch
-dvb-dst-fix-for-descrambling-failure.patch
-dvb-dst-misc-fixes.patch
-dvb-bt8xx-updated-documentation.patch
-dvb-dst-fix-a-bug-in-the-module-parameter.patch
-dvb-dst-fixed-ci-debug-output.patch
-dvb-bt8xx-whitespace-cleanup.patch
-dvb-budget-av-ci-fixes.patch
-fusion-kfree-cleanup.patch

 Merged

+linus.patch

 Linus latest

+v4l-bttv-i2c-oops-fix.patch
+ipmi-build-fix.patch
+x86_64-config_bug=n-fixes.patch
+ib-allow-null-sa_query-callbacks.patch
+ib-fix-potential-ib_umad-leak.patch
+ib-fix-endianness-of-path-record-mtu-field.patch
+make-sure-therm_adt746x-only-handles-known-hardware.patch
+therm_adt746x-show-correct-sensor-locations.patch

 Fixes for 2.6.12

+namei-fixes-01-19.patch
+namei-fixes-02-19.patch
+namei-fixes-03-19.patch
+namei-fixes-04-19.patch
+namei-fixes-05-19.patch
+namei-fixes-06-19.patch
+namei-fixes-07-19.patch
+namei-fixes-08-19.patch
+namei-fixes-09-19.patch
+namei-fixes-10-19.patch
+namei-fixes-11-19.patch
+namei-fixes-12-19.patch
+namei-fixes-13-19.patch
+namei-fixes-14-19.patch
+namei-fixes-15-19.patch
+namei-fixes-16-19.patch
+namei-fixes-17-19.patch
+namei-fixes-18-19.patch
+namei-fixes-19-19.patch

 VFS name handling fixes

+ipmi-and-acpi=offht-acpi-get-firmware-failurepatch.patch
+ipmi-and-acpi=offht-ipmi_si_intf-acpi-disabled.patch

 IPMI/ACPI fixes

-cpufreq-CPUFREQ-14-powernow-k8-dual-core-on2.6.12.patch
+cpufreq-CPUFREQ-14-powernow-k8-dualcore.patch
-cpufreq-CPUFREQ-20-powernow-k8-static-cpu_sharedcore_mask.patch
+cpufreq-CPUFREQ-21-ondemand-cleanups.patch
+cpufreq-CPUFREQ-22-ondemand-store-idle-ticks-for-all-cpus.patch
+cpufreq-CPUFREQ-23-ondemand-idle_tick-cleanup.patch
+cpufreq-CPUFREQ-24-ondemand-automatic-downscaling.patch
+cpufreq-CPUFREQ-25-ondemand-default-sampling-downfactor.patch
+cpufreq-CPUFREQ-26-longhaul-disable-mastering.patch
+cpufreq-CPUFREQ-27-longhaul-magic-port-frobbing.patch
+cpufreq-CPUFREQ-28-longhaul-transition-latency.patch
+cpufreq-CPUFREQ-29-longhaul-icky-evil-nasty-ide-dma-wait.patch
+cpufreq-CPUFREQ-30-speedstep-lib-typos.patch

 cpufreq updates

-bk-cryptodev.patch
+git-cryptodev.patch

 The cryptodev tree is now in git

-gregkh-driver-driver-pm-diag-update.patch
-gregkh-driver-driver-remove-detach_state.patch
-gregkh-driver-attr_void.patch
+gregkh-driver-driver-model-documentation-update.patch
+gregkh-driver-libfs-add-simple-attribute-files.patch
+gregkh-driver-driver-fix-error-handling-in-bus_add_device.patch
+gregkh-driver-driver-device_attr-01.patch
+gregkh-driver-driver-device_attr-02.patch
+gregkh-driver-driver-device_attr-03.patch
+gregkh-driver-driver-device_attr-04.patch
+gregkh-driver-driver-device_attr-05.patch
+gregkh-driver-driver-device_attr-06.patch
+gregkh-driver-driver-device_attr-07.patch
+gregkh-driver-driver-device_attr-08.patch
+gregkh-driver-driver-device_attr-09.patch
+gregkh-driver-driver-device_attr-10.patch
+gregkh-driver-driver-device_attr-11.patch
+gregkh-driver-driver-device_attr-12.patch
+gregkh-driver-driver-device_attr-i2c-sysfs.h.patch
+gregkh-driver-driver-device_attr-i2c-adm1026.patch

 driver core tree updates

+ipmi-class_simple-fixes.patch

 Fix ipmi driver for driver core updates

-gregkh-i2c-w1-ds18xx_sensors.patch
-gregkh-i2c-w1-new_rom_family.patch
+gregkh-i2c-i2c-adm9240-cleanup.patch
+gregkh-i2c-i2c-jiffies.h.patch
+gregkh-i2c-i2c-macro-abuse-cleanup.patch
+gregkh-i2c-i2c-via686a-code-cleanup.patch
+gregkh-i2c-i2c-adm1021-remove_die_code.patch
+gregkh-i2c-i2c-Kconfig-corrections.patch
+gregkh-i2c-i2c-macro-abuse-cleanup-via686a.patch
+gregkh-i2c-i2c-driver-device_attr-fixup.patch
+gregkh-i2c-i2c-spelling-fixes-more-01.patch
+gregkh-i2c-i2c-spelling-fixes-more-02.patch
+gregkh-i2c-i2c-spelling-fixes-more-03.patch
+gregkh-i2c-i2c-spelling-fixes-more-04.patch
+gregkh-i2c-i2c-mpc-race-fix.patch
+gregkh-i2c-i2c-mailing-list-move.patch
+gregkh-i2c-w1-ds18xx_sensors.patch
+gregkh-i2c-w1-new_rom_family.patch
+gregkh-i2c-w1-cleanups.patch
+gregkh-i2c-w1-new-family-structure.patch
+gregkh-i2c-w1-build-fixups.patch
+gregkh-i2c-w1-remove-dup-family-id.patch

 i2c updates

-git-libata.patch

 Empty.

-bk-mtd.patch
+git-mtd.patch

 The MTD tree is now in git

+git-netdev-chelsio.patch
+git-netdev-ieee80211.patch
+git-netdev-wifi.patch

 More of Jeff's net device trees

+git-ocfs.patch

 Oracle cluster filesystem

-gregkh-pci-pci-hotplug-shpc-power-fix.patch
-gregkh-pci-pci-pciehp-downstream-port-fix.patch
-gregkh-pci-pci-cpci-update.patch
-gregkh-pci-pci-remove-pci_visit_dev.patch
-gregkh-pci-pci-modalias-sysfs.patch
-gregkh-pci-pci-modalias-hotplug.patch
+gregkh-pci-pci-fix-pci-mmap-on-ppc-and-ppc64.patch
+gregkh-pci-pci-driver-device_attr-fixup.patch

 PCI tree updates

+git-scsi-misc-build-fix.patch
+git-scsi-misc-sbp2-warning-fix.patch

 Fixes for git-scsi-misc.patch

+gregkh-usb-speedtch-prep.patch

 Makes Greg's USB tree apply

-gregkh-usb-usb-usbnet-fixes.patch
-gregkh-usb-usb-ehci-suspend-stop-timer.patch
-gregkh-usb-usb-modalias-sysfs.patch
-gregkh-usb-usb-cypress_m8-add-lt-20-support.patch
+gregkh-usb-usb-ftdi_sio-new-id.patch
+gregkh-usb-usb-serial-generic-init-fix.patch
+gregkh-usb-usb-fix-gadget-build-error.patch
+gregkh-usb-usb-driver-device_attr-fixup.patch
+gregkh-usb-usb-storage-trumpion.patch
+gregkh-usb-usb-modalias-shrink.patch

 USB tree updates

+usb-option-card-driver.patch

 New USB driver

+zd1201-build-fix.patch

 Bring back this USB-vs-netdev fix

+ppc64-sparsemem-memory-model-fix-2.patch
+remove-direct-ref-to-contig_page_data-for-x86-64.patch
+add-x86-64-kconfig-options-for-sparsemem.patch
+reorganize-x86-64-numa-and-discontigmem-config-options.patch
+add-x86-64-specific-support-for-sparsemem.patch
+add-x86-64-specific-support-for-sparsemem-tidy.patch

 More sparsemem updates

+avoiding-mmap-fragmentation-fix.patch
+avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes.patch
+avoiding-mmap-fragmentation-fix-2.patch
+mmap-topdown-fix-for-large-stack-limit-large-allocation.patch
+mm-remove-pg_highmem.patch
+mm-remove-pg_highmem-tidy.patch
+vm-try_to_free_pages-unused-argument.patch

 Various MM fixes

+ppp_mppe-add-ppp-mppe-encryption-module-kconfig-fix.patch

 Fix ppp_mppe-add-ppp-mppe-encryption-module.patch

+use-pci_set_dma_mask-instead-of-direct-assignment-of-dma-mask.patch
+cs89x0c-support-for-philips-pnx0105-network-adapter.patch
+cs89x0c-support-for-philips-pnx0105-network-adapter-tidy.patch

 Net driver fixes

+ppc32-fix-some-minor-issues-related-to-fsl-book-e-kgdb.patch
+ppc32-fix-alsa-powermac-driver-on-old-machines.patch
+ppc32-add-via-ide-support-to-mpc8555-cds-platform.patch
+ppc32-support-for-82xx-pqii-on-chip-pci-bridge.patch

 ppc32 updates

+ppc64-quieten-rtas-printks.patch

 ppc64 fix

-x86-port-lockless-mce-preparation.patch
-x86-port-lockless-mce-implementation.patch
-x86-port-lockless-mce-implementation-fix.patch
-x86-port-lockless-mce-implementation-fix-2.patch

 Dropped

+m32r-build-fix-for-asm-m32r-topologyh.patch

 m32r fix

+ppc64-pcibus_to_node-fix.patch
+fix-pcibus_to_node-for-x86_64.patch

 Fixes for pcibus_to_node patch in -mm

+i386-selectable-frequency-of-the-timer-interrupt.patch
+ia64-selectable-timer-interrupt-frequency.patch
+i386-collect-host-bridge-resources.patch
+x86-avoid-wasting-irqs-for-pci-devices.patch
+via-82c586b-irq-routing-fix.patch
+x86-include-asm-uaccessh-in-asm-checksumh.patch
+x86-remove-i386_ksymsc-almost.patch

 x86 updates

+x86_64-avoid-wasting-irqs.patch
+x86_64-collect-host-bridge-resources.patch

 x86_64 updates

+ioc4-core-driver-rewrite.patch
+ioc4-config-split.patch
+ioc4-pci-bus-speed-detection.patch

 IOC driver rewrite

-suspend-resume-smp-support-fix-3.patch

 Dropped

-iounmap-debugging.patch

 This broke - dropped

+turn-soft-lock-off-when-panicking.patch

 Quash the softlockup detector after a panic

-rt-lsm.patch

 Dropped

+cfq-cfq-elevator_insert_back-fix.patch
+cfq-cfq_io_context-leak-fix.patch
+cfq-remove-serveral-unused-fields-from-cfq-data-structures.patch

 CFQ fixes

+timers-introduce-try_to_del_timer_sync.patch
+posix-timers-use-try_to_del_timer_sync.patch

 posx timers cleanups

+kprobes-function-return-probes-fix-5.patch
+move-kprobe-arming-into-arch-specific-code.patch
+kprobes-moves-lock-unlock-to-non-arch-kprobe_flush_task.patch
+kprobes-ia64-kdebug-die-notification.patch
+kprobes-ia64-kdebug-die-notification-fix.patch
+kprobes-ia64-arch-specific-handling-of-kprobes.patch
+kprobes-ia64-arch-specific-handling-of-kprobes-fix.patch
+kprobes-ia64-architecture-specific-support.patch
+kprobes-ia64-support-kprobe-on-branch-call-instructions.patch
+kprobes-temporary-disarming-of-reentrant-probe.patch
+kprobes-temporary-disarming-of-reentrant-probe-for-i386.patch
+kprobes-temporary-disarming-of-reentrant-probe-for-x86_64.patch
+kprobes-temporary-disarming-of-reentrant-probe-for-ppc64.patch
+kprobes-temporary-disarming-of-reentrant-probe-for-sparc64.patch

 Much kprobes work

+remove-eventpoll-macro-obfuscation.patch

 epoll cleanup

+optimize-sys_times-for-a-single-thread-process.patch
+optimize-sys_times-for-a-single-thread-process-update.patch
+optimize-sys_times-for-a-single-thread-process-update-2.patch

 sys_times() hack^wspeedup

+turn-off-sibling-call-optimization-w-frame-pointers.patch

 Improve debuggability

+add-skip_hangcheck_timer.patch

 Add a way of whutting up the hangcheck timer

+ipcsem-remove-superflous-decrease-variable-from-sys_semtimedop.patch

 IPC cleanup

+reiserfs-add-checking-of-journal_begin-return-value.patch
+quota-improve-credits-estimates.patch
+quota-ext3-improve-quota-credit-estimates.patch
+quota-reiserfs-improve-quota-credit-estimates.patch

 quota fixes

+namespacec-fix-bind-mount-from-foreign-namespace.patch
+namespacec-fix-mnt_namespace-clearing.patch
+namespacec-fix-race-in-mark_mounts_for_expiry.patch
+namespacec-cleanup-in-mark_mounts_for_expiry.patch
+namespacec-split-mark_mounts_for_expiry.patch
+namespacec-fix-expiring-of-detached-mount.patch

 namespace.c fixes

+xtensa-tensilica-xtensa-cpu-arch-maintainer-record.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-1.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-2.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-3.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-4.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-5.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-6.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-7.patch
+xtensa-architecture-support-for-tensilica-xtensa-part-8.patch

 New architecture

+make-reiserfs-bug-on-too-big-transaction.patch

 reiserfs sanity check

+ipmi-doc-updates-for-ipmi.patch
+ipmi-ipmi-timer-shutdown-cleanup.patch
+ipmi-add-ipmi-power-cycle-capability.patch
+ipmi-use-completions-not-semaphores-in-the-ipmi-powerdown-code.patch
+ipmi-add-32-bit-ioctl-translations-for-64-bit-platforms.patch

 IPMI driver updates

+tpm-replace-odd-LPC-init-function.patch

 TPM driver update

+dlm-core-locking.patch
+dlm-lockspaces-callbacks-directory.patch
+dlm-communication.patch
+dlm-recovery.patch
+dlm-configuration.patch
+dlm-device-interface.patch
+dlm-device-interface-fix.patch
+dlm-debug-fs.patch
+dlm-build.patch

 RH distrubuted lock manager

+connector-netlink-id-fix.patch
+connector-remove-socket-number-parameter.patch
+fork-connector-send-status-to-userspace.patch

 Connector driver updates

+inotify-44-update-2.patch

 inotify fixes

+i2o-bugfixes-and-compability-enhancements.patch
+i2o-first-code-cleanup-of-spare-warnings-and-unused.patch
+i2o-new-sysfs-attributes-and-adaptec-specific-block.patch
+i2o-new-sysfs-attributes-and-adaptec-specific-block-fix.patch
+i2o-adaptec-specific-sg_io-access-firmware-access-through.patch
+i2o-second-code-cleanup-of-sparse-warnings-and-unneeded.patch
+i2o-lindent-run-and-replacement-of-printk-through-osm.patch
+i2o-limit-max-sector-workaround-for-promise-controllers.patch

 i2o driver updates

+drop-obsolete-dibusb-driver.patch
+add-generalized-dvb-usb-driver.patch
+dvb-usb-fix-init-error-checking.patch
+dvb_frontend-use-time_after.patch
+flexcop-add-bcm3510-atsc-frontend-support-for-air2pc-card.patch
+flexcop-add-bcm3510-atsc-frontend-support-for-air2pc-card-fix.patch

 DVB updates

+pcmcia-add-a-few-more-ids-for-pcnet_cs.patch

 More pcmcia device IDs

+pcmcia-move-pcmcia-ioctl-to-a-separate-file-fix.patch

 Fix pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch

+pcmcia-properly-handle-all-errors-of-register_chrdev.patch

 pcmcia error handling fix

-numa-aware-slab-allocator-v3.patch
-numa-aware-slab-allocator-v2-tidy.patch
-numa-aware-slab-allocator-v3-cleanup.patch
-ppc64-numa-nodes-hack.patch

 Dropped

+perfctr-ppc64-wraparound-fixes.patch
+perfctr-x86-update-with-k8-multicore-fixes-take-2.patch

 perfctr fixes

+sched-micro-optimize-task-requeueing-in-schedule.patch
+dynamic-sched-domains-sched-changes.patch
+dynamic-sched-domains-sched-changes-fix.patch
+dynamic-sched-domains-cpuset-changes.patch
+dynamic-sched-domains-ia64-changes.patch
+sched-implement-nice-support-across-physical-cpus-on-smp.patch
+sched-change_prio_bias_only_if_queued.patch
+sched-account_rt_tasks_in_prio_bias.patch
+consolidate-preempt-options-into-kernel-kconfigpreempt.patch
+sched-remove-set_tsk_need_resched-from-init_idle-v2.patch
+sched-remove-set_tsk_need_resched-from-init_idle-v2-ia64-fix.patch
+sched-voluntary-kernel-preemption.patch

 CPU scheduler updates

+bttv-support-for-adlink-rtv24-capture-card.patch
+bttv-support-for-adlink-rtv24-capture-card-tidy.patch
+bttv-support-for-adlink-rtv24-capture-card-more-tidy.patch
+v4l-saa7134-ntsc-vbi-fix.patch
+v4l-pal-m-chroma-subcarrier-frequency-fix.patch

 v4l updates

+kexec-kexec-on-panic-fix-with-nmi-watchdog-enabled.patch
+kdump-documentation-update-to-add-gdb-macros.patch
+kdump-use-real-pt_regs-from-exception.patch
+kdump-use-real-pt_regs-from-exception-fix.patch
+kdump-use-real-pt_regs-from-exception-fix-fix.patch
+kdump-save-trap-information-for-later-analysis.patch

 keec/kdump updates and fixes

+reiser4-mm-remove-pg_highmem-fix.patch

 Fix reiser4 for the PG_highmem removal

+vga-to-fbcon-fix.patch

 vgacon fix

+docbook-update-comments.patch

 kerneldoc fixlets

+fuse-dont-allow-restarting-of-system-calls.patch

 FUSE update

+xip-bdev-execute-in-place-3rd-version.patch
+xip-fs-mm-execute-in-place-3rd-version.patch
+xip-fs-mm-execute-in-place-3rd-version-fix.patch
+xip-ext2-execute-in-place-3rd-version.patch
+xip-ext2-execute-in-place-3rd-version-fixes.patch
+xip-madvice-fadvice-execute-in-place-3rd-version.patch
+xip-description.patch

 Execute-in-place driver



number of patches in -mm: 1270
number of changesets in external trees: 155
number of patches in -mm only: 1264
total patches: 1419



All 1270 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/patch-list


