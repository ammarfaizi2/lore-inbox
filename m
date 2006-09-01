Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWIAI6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWIAI6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIAI6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:58:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWIAI6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:58:23 -0400
Date: Fri, 1 Sep 2006 01:58:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc5-mm1
Message-Id: <20060901015818.42767813.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/


- CONFIG_BLOCK=n is bust due to
  writeback_congestion_end()/blk_congestion_end() snafu.  We'll fix it later.

- nfs automounts of subdirectories of exported directories are still
  broken.

- drivers/iio/iio_dummy.c causes a depmod failure.  It isn't supposed to
  be here - please ignore it.

- sparc32 doesn't build.




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

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.



Changes since 2.6.18-rc4-mm3:

 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-block.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-kbuild.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mtd.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-serial.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees.

-oops-on-boot-fix-for-ide.patch
-drivers-rtc-fix-rtc-s3cc.patch
-dm-fix-deadlock-under-high-i-o-load-in-raid1-setup.patch
-revert-input-wistron-fix-section-reference-mismatches.patch
-swsusp-fix-swap_type_of.patch
-rtc-s3cc-fix-time-setting-checks.patch
-tty-remove-bogus-call-to-cdev_del.patch
-fix-docs-for-fssuid_dumpable-6145.patch
-fix-for-recently-added-firewire-patch-that-breaks-things-on-ppc.patch
-lockdep-fix-blkdev_open-warning.patch
-lockdep-fix-blkdev_open-warning-fix.patch
-mtd-corruption-fix.patch
-x86-fix-dmi-detection-of-macbookpro-and-imac.patch
-for-2618-revert-drop-tasklist-lock-in-do_sched_setscheduler.patch
-cpufreq-acpi-cpufreq-ignore-failure-from-acpi_cpufreq_early_init_acpi.patch
-char-moxac-fix-endianess-and-multiple-card-issues.patch
-char-moxac-fix-endianess-and-multiple-card-issues-tidy.patch
-matroxfb-fix-jittery-display-on-non-ppc-systems.patch
-vcsa-attribute-bits-ioctlvt_gethifontmask.patch
-futex_find_get_task-remove-an-obscure-exit_zombie-check.patch
-mtd-nand-fix-ams-delta-after-core-conversion.patch
-fix-for-minix-crash.patch
-ext2-prevent-div-by-zero-on-corrupted-fs.patch
-spectrum_cs-fix-firmware-uploading-errors.patch
-ext3-filesystem-bogus-enospc-with-reservation-fix.patch
-ufs-write-to-hole-in-big-file.patch
-ufs-truncate-correction.patch
-remove-redundent-up-in-stop_machine.patch
-documentation-update-for-relay-interface.patch
-eventpollc-compile-fix.patch
-md-avoid-backward-event-updates-in-md-superblock-when-degraded.patch
-md-fix-recent-breakage-of-md-raid1-array-checking.patch
-cpuset-top_cpuset-tracks-hotplug-changes-to-cpu_online_map.patch
-manage-jbd-allocations-from-its-own-slabs.patch
-manage-jbd-allocations-from-its-own-slabs-tidy.patch
-register_one_node-compile-fix.patch
-cpuset-oom-panic-fix.patch
-sun-disk-label-fix-signed-int-usage-for-sector-count.patch
-sun-disk-label-fix-signed-int-usage-for-sector-count-fix.patch
-config_acpi_srat-numa-build-fix.patch
-lockdep-annotate-idescsi_pc_intr.patch
-lockdep-annotate-reiserfs.patch
-fix-up-lockdep-trace-in-fs-execc.patch
-proc-meminfo-dont-put-spaces-in-names.patch
-x86-numaq-kconfig-fix.patch
-cdrom-gdsc-fix-printk-format-warning.patch
-tty-layer-comment-the-locking-assumptions-and-functions.patch
-fix-tty-layer-dos-and-comment-relevant-code.patch
-drivers-media-video-bt866c-array-overflows.patch
-gregkh-i2c-i2c-tps65010-build-fixes.patch
-gregkh-i2c-hwmon-abituguru-timeout-fixes.patch
-ia64-panic-if-topology_init-kzalloc-fails.patch
-e1000-ring-buffers-resources-cleanup.patch
-e1000-irq-resources-cleanup.patch
-e1000-e1000_probe-resources-cleanup.patch
-ixgb-add-pci-error-recovery-callbacks.patch
-e100-disable-device-on-pci-error.patch
-powerpc-hugepage-bug-fix.patch
-gregkh-pci-pci-use-pcbios-as-last-fallback.patch
-gregkh-pci-pci-i386-mmconfig-don-t-forget-bus-number-when-setting-fallback_slots-bits.patch
-gregkh-pci-pci-fix-ich6-quirks.patch
-gregkh-pci-cpci-hotplug-fix-resource-assignment.patch
-gregkh-pci-pci-kerneldoc-correction-in-pci-driver.patch
-fix-gregkh-pci-pci-express-aer-implemetation-aer-core-and-aerdriver-on-powerpc.patch
-gregkh-pci-acpiphp-configure-_prt-v3-cleanup.patch
-scsi-target-printk-format-warnings.patch
-gregkh-usb-usb-cypress-bugfix.patch
-gregkh-usb-usb-pl2303-removed-support-for-oti-s-dku-5-clone-cable.patch
-gregkh-usb-unusual_devs-update-for-ucr-61s2b.patch
-usb-hub-driver-improve-use-of-ifdef-fix.patch
-fix-broken-dubious-driver-suspend-methods.patch
-pm-define-pm_event_prethaw.patch
-pm-pci-and-ide-handle-pm_event_prethaw.patch
-pm-video-drivers-and-pm_event_prethaw.patch
-pm-usb-hcds-use-pm_event_prethaw.patch
-pm-usb-hcds-use-pm_event_prethaw-fix.patch
-pm-issue-pm_event_prethaw.patch
-rtl8150_disconnect-needs-tasklet_kill.patch
-turn-usb_resume_both-into-static-inline.patch
-signedness-issue-in-drivers-usb-gadget-etherc.patch
-adutux-fix-printk-format-warnings.patch
-aircable-fix-printk-format-warnings.patch
-x86_64-mm-defconfig-update.patch
-x86_64-mm-rwlock-lock-prefix.patch
-x86_64-mm-i386-remove-const-rwlock.patch
-x86_64-mm-i386-unwind-termination.patch
-x86_64-mm-unwind-termination.patch
-x86_64-mm-unwinder-fallback.patch
-x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp.patch
-x86_64-mm-disable-mmconfig-e820-heuristic.patch
-x86_64-mm-recover-1mb.patch
-x86_64-mm-spin-irqs-enabled.patch
-x86_64-mm-remove-alternative-smp.patch
-x86_64-mm-i386-remove-alternative-smp.patch
-x86_64-mm-dmi-mmconfig-intel-sdv.patch
-hdaps-handle-errors-from-input_register_device.patch
-fix-possible-udf-deadlock-and-memory-corruption.patch
-ide-support-for-via-8237a-southbridge.patch

 Merged into mainline or a subsystem tree.
 
+zvc-overstep-counters.patch
+zvc-scale-thresholds-depending-on-the-size-of-the-system.patch
+md-fix-issues-with-referencing-rdev-in-md-raid1.patch
+synclink_gt-fix-receive-tty-error-handling.patch
+fix-faulty-hpet-clocksource-usage-fix-for-bug-7062.patch
+task-delay-accounting-fixes.patch
+xtensa-ptrace-exit_zombie-fix.patch
+x86-increase-max_mp_busses-on-default-arch.patch
+exit-early-in-floppy_init-when-no-floppy-exists.patch
+sbc8360-module_param-permission-fixes.patch
+kerneldoc-for-handle_bad_irq.patch
+ipmi-fix-occasional-oops-on-module-unload.patch
+schedule-obsolete-oss-drivers-for-removal-2nd-round.patch
+md-work-around-mempool_alloc-bio_alloc_bioset-deadlocks.patch
+powerpc-more-via-pmu-backlight-fixes.patch
+powerpc-fix-powermac-irq-handling-bug.patch
+alsa-ac97-correct-some-mic-mixer-elements.patch
+sgiioc4-fixup-use-of-mmio-ops.patch
+fix-numa-interleaving-for-huge-pages.patch
+manage-jbd-its-own-slab-fix.patch
+backlight-last-round-of-fixes.patch

 2.6.18 queue.

+scsi-improve-endian-handling-in-lsi-fusion-firmware-mpt_downloadboot.patch

 MPT fusion fix

+allow-file-systems-to-manually-d_move-inside-of-rename.patch

 Infrastructure for OCFS.

+acpi-mwait-c-state-fixes.patch

 ACPI fix/feature

+git-block-hack.patch

 Make git-block pretend to compile.

+fs-bioc-tweaks.patch

 bio.c cleanup.

+gregkh-driver-fix-broken-dubious-driver-suspend-methods.patch
+gregkh-driver-pm-define-pm_event_prethaw.patch
+gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch
+gregkh-driver-pm-video-drivers-and-pm_event_prethaw.patch
+gregkh-driver-pm-usb-hcds-use-pm_event_prethaw.patch
+gregkh-driver-pm-issue-pm_event_prethaw.patch
+gregkh-driver-iio.patch

 driver tree updates

+git-dvb-fixup.patch

 Fix rejects in git-dvb.patch

+gregkh-i2c-hwmon-atxp1-signed-unsigned-char-bug.patch
+gregkh-i2c-hwmon-hdaps-handle-errors-from-input-register-device.patch
+gregkh-i2c-hwmon-smsc47m1-fix-dev-message.patch
+gregkh-i2c-hwmon-it87-it8716f-support.patch
+gregkh-i2c-hwmon-it87-disabled-fans.patch
+gregkh-i2c-hwmon-it87-div-to-reg-overflow.patch
+gregkh-i2c-hwmon-it87-in8-no-limits.patch
+gregkh-i2c-hwmon-it87-set-fan-div.patch
+gregkh-i2c-hwmon-it87-it8718f-support.patch
+gregkh-i2c-hwmon-it87-sane-limit-defaults.patch
+gregkh-i2c-hwmon-it87-copyright-update.patch
+gregkh-i2c-hwmon-k8temp-new-driver.patch
+gregkh-i2c-hwmon-k8temp-autoload.patch
+gregkh-i2c-hwmon-abituguru-suspend-resume.patch

 I2C tree updates.

-ieee1394-sbp2-select-scsi-in-kconfig.patch
+ieee1394-sbp2-more-help-in-kconfig.patch

 Updated.

+amso1100-build-fix.patch

 Fix git-infiniband.patch

+drivers-input-misc-wistron_btnsc-fix-section-mismatch.patch

 Input driver section fix.

+8139cp-trim-ring_info.patch
+8139cp-remove-gratuitous-indirection.patch
+8139cp-ring_info-removal-for-the-receive-path.patch
+8139cp-sync-the-device-private-data-with-its-r8169-counterpart.patch
+8139cp-removal-of-useless-bug_on-check.patch
+8139cp-pci_get_drvdatapdev-can-not-be-null-in-suspend-handler.patch
+8139cp-use-pci_device-to-shorten-the-pci-device-table.patch

 net driver updates.

+dev_change_name-debug.patch
+bluetooth-small-cleanups.patch
+add-netpoll-netconsole-support-to-vlan-devices.patch

 net stuff.

-libsas-externs-not-needed.patch

 Dropped due to droppage of git-sas.patch.

+magic-sysrq-sak-does-nothing-on-serial-consoles.patch

 Fix SAK-on-serial.

+gregkh-pci-shpchp-must_check-fixes.patch
+gregkh-pci-pci-hotplug-must_check-fixes.patch
+gregkh-pci-pci-must_check-fixes.patch
+gregkh-pci-pci-multiprobe-sanitizer.patch
+gregkh-pci-pci-drivers-pci-hotplug-acpiphp_glue.c-make-a-function-static.patch
+gregkh-pci-pci-restore-pci-express-capability-registers-after-pm-event.patch

 PCI tree updates.

+git-scsi-misc-fixup.patch

 Fix rejects in git-scsi-misc.patch

+git-block-vs-git-sas.patch

 Fix build

+gregkh-usb-samsung-unusual-floppy.patch
+gregkh-usb-hid-core.c-adds-all-gtco-calcomp-digitizers-and-interwrite-school-products-to-blacklist.patch
+gregkh-usb-usb-gadget-g_ether-spinlock-recursion-fix.patch
+gregkh-usb-uhci-don-t-stop-at-an-iso-error.patch
+gregkh-usb-usb-storage-remove-the-finecam3-unusual_devs-entry.patch
+gregkh-usb-usb-storage-unusual_devs.h-for-sony-ericsson-m600i.patch
+gregkh-usb-usb-rtl8150_disconnect-needs-tasklet_kill.patch
+gregkh-usb-usb-support-for-elecom-ld-usb20-in-pegasus.patch
+gregkh-usb-uhci-hcd-fix-list-access-bug.patch
+gregkh-usb-usb-doc-patch-1.patch
+gregkh-usb-usb-doc-patch-2.patch
+gregkh-usb-usb-must_check-fixes.patch
+gregkh-usb-usb-deal-with-broken-config-descriptors.patch
+gregkh-usb-wusb-hub-recognizes-wusb-ports.patch
+gregkh-usb-wusb-handle-wusb-device-ep0-speed-settings.patch
+gregkh-usb-wusb-pretty-print-new-devices.patch
+gregkh-usb-usb-core-use-const-where-possible.patch
+gregkh-usb-usb-fix-signedness-issue-in-drivers-usb-gadget-ether.c.patch
+gregkh-usb-usb-fix-typo-in-drivers-usb-gadget-kconfig.patch
+gregkh-usb-usb-storage-fix-for-ufi-lun-detection.patch
+gregkh-usb-usbcore-help-drivers-to-change-device-configs.patch
+gregkh-usb-usb-turn-usb_resume_both-into-static-inline.patch
+gregkh-usb-usb-usb-hub-driver-improve-use-of-ifdef-fix.patch
+gregkh-usb-cypress_m8-use-appropriate-urb-polling-interval.patch
+gregkh-usb-cypress_m8-use-usb_fill_int_urb-where-appropriate.patch
+gregkh-usb-cypress_m8-improve-control-endpoint-error-handling.patch
+gregkh-usb-cypress_m8-implement-graceful-failure-handling.patch
+gregkh-usb-aircable-fix-printk-format-warnings.patch
+gregkh-usb-adutux-fix-printk-format-warnings.patch
+gregkh-usb-usb-add-playstation-2-trance-vibrator-driver.patch

 USB tree updates.

+x86_64-mm-proxy-pda.patch
+x86_64-mm-fix-the-edd-code-misparsing-the-command-line.patch
+x86_64-mm-remove-most-of-the-special-cases-for-the-debug-ist-stack.patch
+x86_64-mm-kexec-dont-overwrite-pgd.patch
+x86_64-mm-i386-kexec-dont-overwrite-pgd.patch
+x86_64-mm-i386-early-exception.patch
+x86_64-mm-trace-kernel-text-address.patch
+x86_64-mm-document-tree.patch
+x86_64-mm-rwlock-cleanup-fix.patch
+x86_64-mm-remove-e820-fallback-fix.patch

 x86_64 tree updates.

-fstack-protector-feature-annotate-the-pda-offsets.patch
-fstack-protector-feature-add-the-kconfig-option.patch
-fstack-protector-feature-add-the-canary-field-to-the.patch
-fstack-protector-feature-add-the-__stack_chk_fail.patch
-fstack-protector-feature-enable-the-compiler-flags.patch

 Collateral damaged by x86-64 tree udpates.

+unwinder-warning-fixes.patch

 Fix warnings in x86_64 tree.

+have-ia64-use-add_active_range-and-free_area_init_nodes-fix.patch

 Fix have-ia64-use-add_active_range-and-free_area_init_nodes.patch

+zone-reclaim-with-slab-avoid-unecessary-off-node-allocations.patch
+oom-kill-update-comments-to-reflect-current-code.patch

 MM updates.

+selinux-enable-configuration-of-max-policy-version-improve-security_selinux_policydb_version_max_value-help-texts.patch

 Fix selinux-enable-configuration-of-max-policy-version.patch

-selinux-2-3-change-isec-semaphore-to-a-mutex-vs-git-net.patch

 Fix selinux-2-3-change-isec-semaphore-to-a-mutex.patch

+nommu-check-that-access_process_vm-has-a-valid-target.patch
+nommu-set-bdi-capabilities-for-dev-mem-and-dev-kmem.patch
+nommu-set-bdi-capabilities-for-dev-mem-and-dev-kmem-tidy.patch
+nommu-use-find_vma-rather-than-reimplementing-a-vma-search.patch
+check-if-start-address-is-in-vma-region-in-nommu-function-get_user_pages.patch
+nommu-permit-ptrace-to-ignore-non-prot_write-vmas-in-nommu-mode.patch
+nommu-implement-proc-pid-maps-for-nommu.patch
+nommu-order-the-per-mm_struct-vma-list.patch
+nommu-make-mremap-partially-work-for-nommu-kernels.patch
+nommu-add-docs-about-shared-memory.patch

 nommu stuff.

-i386-early-fault-handler.patch

 Dropped due to merge of similar patch.

+x86-use-asm-offsets-for-offsets-into-struct-pt_regs.patch

 x86 cleanup.

+make-it-possible-to-disable-serial-console-suspend.patch
+pm-add-pm_trace-switch.patch
+pm-add-pm_trace-switch-doc.patch
+pm-add-sys-power-documentation-to-documentation-abi.patch
+device_suspend-resume-may-sleep.patch

 suspend/power-management updates.

-sysctl-scream-if-someone-uses-sys_sysctl.patch
+sysctl-allow-proc-sys-without-sys_sysctl-fix.patch

 Updated.

+fix-ext3-mounts-at-16t-fix.patch

 Fix fix-ext3-mounts-at-16t.patch

+fix-ext2-mounts-at-16t-fix.patch

 Fix fix-ext2-mounts-at-16t.patch

+more-ext3-16t-overflow-fixes-fix.patch

 Fix more-ext3-16t-overflow-fixes.patch

+select_bad_process-kill-a-bogus-pf_dead-task_dead-check.patch
+select_bad_process-cleanup-releasing-check.patch
+oom_kill_task-cleanup-mm-checks.patch
+cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map.patch
+cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map-fix.patch
+cpuset-hotunplug-cpus-and-mems-in-all-cpusets.patch
+remove-sound-oss-copying.patch
+fs-partitions-conversion-to-generic-boolean.patch
+loop-forward-port-resource-leak-checks-from-solar.patch
+maximum-latency-tracking-infrastructure.patch
+maximum-latency-tracking-infrastructure-tidy.patch
+maximum-latency-tracking-alsa-support.patch
+add-to-maintainers-file.patch
+lib-rwsemc-un-inline-rwsem_down_failed_common.patch
+add-section-on-function-return-values-to-codingstyle.patch
+fs-nameic-replace-multiple-current-fs-by-shortcut-variable.patch
+fs-nameic-replace-multiple-current-fs-by-shortcut-variable-tidy.patch
+superh-maintainership-change.patch
+mem-driver-fix-conditional-on-isa-i-o-support.patch
+remove-static-variable-mm-page-writebackctotal_pages.patch
+call-mm-page-writebackcset_ratelimit-when-new-pages.patch
+call-mm-page-writebackcset_ratelimit-when-new-pages-tidy.patch
+valid_swaphandles-fix.patch
+mention-documenation-abi-requirements-in-documentation-submitchecklist.patch
+rate-limiting-for-the-ldisc-open-failure-messages.patch
+lib-ts_fsmc-constify-structs.patch
+submittingpatches-cleanups.patch
+ibm-acpi-documentation-delete-irrelevant-how-to-compile-external-module.patch
+network-block-device-is-mostly-known-as-nbd.patch
+superh-list-is-moderated.patch
+sys-modules-patch-allow-full-length-section-names.patch
+uninitialized-variable-in-drivers-net-wan-syncpppc.patch

 Misc.

+kill-wall_jiffies-fix.patch
+mips-moved-to-generic_time.patch

 Fix kill-wall_jiffies.patch

+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-cachefiles_write_page-shouldnt-indicate-error-twice.patch
+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-handle-enospc-on-create-mkdir-better.patch
+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-inode-count-maintenance.patch

 Fix fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch

+knfsd-hide-use-of-lockds-h_monitored-flag.patch
+knfsd-consolidate-common-code-for-statd-lockd-notification.patch
+knfsd-when-looking-up-a-lockd-host-pass-hostname-length.patch
+knfsd-lockd-introduce-nsm_handle.patch
+knfsd-misc-minor-fixes-indentation-changes.patch
+knfsd-lockd-make-nlm_host_rebooted-use-the-nsm_handle.patch
+knfsd-lockd-make-the-nsm-upcalls-use-the-nsm_handle.patch
+knfsd-lockd-make-the-hash-chains-use-a-hlist_node.patch
+knfsd-lockd-change-list-of-blocked-list-to-list_node.patch
+knfsd-change-nlm_file-to-use-a-hlist.patch
+knfsd-lockd-make-nlm_traverse_-more-flexible.patch
+knfsd-lockd-add-nlm_destroy_host.patch
+knfsd-simplify-nlmsvc_invalidate_all.patch
+knfsd-lockd-optionally-use-hostnames-for-identifying-peers.patch
+knfsd-make-nlmclnt_next_cookie-smp-safe.patch
+knfsd-match-granted_res-replies-using-cookies.patch
+knfsd-export-nsm_local_state-to-user-space-via-sysctl.patch
+knfsd-lockd-fix-use-of-h_nextrebind.patch
+knfsd-register-all-rpc-programs-with-portmapper-by-default.patch

 nfsd updates.

+ecryptfs-remove-lock-propagation.patch

 ecryptfs fix.

-namespaces-add-nsproxy-avr32-fix.patch

 Dropped, wrong.

+ipc-namespace-fix.patch

 Fix refcountng in namespace patches.

+introduce-kernel_execve.patch
+rename-the-provided-execve-functions-to-kernel_execve.patch
+provide-kernel_execve-on-all-architectures.patch
+provide-kernel_execve-on-all-architectures-fix.patch
+provide-kernel_execve-on-all-architectures-mips-fix.patch
+remove-the-use-of-_syscallx-macros-in-uml.patch
+sh64-remove-the-use-of-kernel-syscalls.patch
+remove-remaining-errno-and-__kernel_syscalls__-references.patch

 kernel syscalls cleanup

+reiser4-decribe-new-atom-locking-and-nested-atom-locks-to-lock-validator.patch
+reiser4-use-generic-file-read.patch
+reiser4-simplify-reading-of-partially-converted-files.patch
+reiser4-use-page_offset.patch
+reiser4-use-reiser4_gfp_mask_get-in-reiser4-inode-allocation.patch
+reiser4-re-add-page_count-check-to-reiser4_releasepage.patch
+reiser4-restore-fibmap-ioctl-support-for-packed-files.patch

 reiser4 updates.

-asus-mv-ide-device-ids.patch

 Dropped.

+ide-hpa-resume-fix.patch

 IDE fix.

+md-define-backing_dev_infocongested_fn-for-raid0-and-linear.patch
+md-define-congested_fn-for-raid1-raid10-and-multipath.patch
+md-add-a-congested_fn-function-for-raid5-6.patch
+md-make-messages-about-resync-recovery-etc-more-specific.patch

 RAID updates.

+srcu-3-rcu-variant-permitting-read-side-blocking-comments.patch
+rcu-refactor-srcu_torture_deferred_free-to-work-for.patch
+rcu-add-rcu_sync-torture-type-to-rcutorture.patch
+rcu-add-rcu_bh_sync-torture-type-to-rcutorture.patch
+rcu-add-sched-torture-type-to-rcutorture.patch

 RCU updates.

-fs-kconfig-split-ext2.patch
-fs-kconfig-split-ext3.patch
-fs-kconfig-split-jbd.patch
-fs-kconfig-split-reiserfs.patch
-fs-kconfig-split-jfs.patch
-fs-kconfig-split-ocfs2.patch
-fs-kconfig-split-minix.patch
-fs-kconfig-split-romfs.patch
-fs-kconfig-split-autofs.patch
-fs-kconfig-split-autofs4.patch
-fs-kconfig-split-fuse.patch
-fs-kconfig-split-isofs.patch
-fs-kconfig-split-udf.patch
-fs-kconfig-split-fat.patch
-fs-kconfig-split-msdos.patch
-fs-kconfig-split-vfat.patch
-fs-kconfig-split-ntfs.patch
-fs-kconfig-split-proc.patch
-fs-kconfig-split-sysfs.patch
-fs-kconfig-split-hugetlbfs.patch
-fs-kconfig-split-ramfs.patch
-fs-kconfig-split-configfs.patch
-fs-kconfig-split-adfs.patch
-fs-kconfig-split-affs.patch
-fs-kconfig-split-ecryptfs.patch
-fs-kconfig-split-hfs.patch
-fs-kconfig-split-hfsplus.patch
-fs-kconfig-split-befs.patch
-fs-kconfig-split-bfs.patch
-fs-kconfig-split-efs.patch
-fs-kconfig-split-jffs.patch
-fs-kconfig-split-jffs2.patch
-fs-kconfig-split-cramfs.patch
-fs-kconfig-split-freevxfs.patch
-fs-kconfig-split-hpfs.patch
-fs-kconfig-split-qnx4.patch
-fs-kconfig-split-sysv.patch
-fs-kconfig-split-ufs.patch
-fs-kconfig-split-smbfs.patch
-fs-kconfig-split-cifs.patch
-fs-kconfig-split-ncpfs.patch
-fs-kconfig-split-coda.patch
-fs-kconfig-split-afs.patch
-fs-kconfig-split-9p.patch

 The CONFIG_BLOCK changes wrecked these.



All 1713 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/patch-list


