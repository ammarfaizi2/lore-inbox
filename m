Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWARIvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWARIvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWARIvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:51:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030197AbWARIvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:51:10 -0500
Date: Wed, 18 Jan 2006 00:50:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm1
Message-Id: <20060118005053.118f1abc.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/

- There are a lot of reiser3 features and fixes here.  Please test with
  caution, but please test.

- Due to various vendor and glibc release timings I'm aiming to get the *at
  functions (vfa-at-functions-core.patch) and the pselect/ppoll syscalls into
  2.6.16.  This is rather late in the piece and I'd ask interested parties to
  review and comment on those patches asap please.

  Ulrich would also like to get the unshare syscall into 2.6.16 but I don't
  recall having seen that code get a decent review and there's quite some
  potential for slipups in this area to cause very bad problems indeed.  So
  we're a bit stuck on that one.

- Before I die I'd like to get an x86 allmodconfig build with gcc-3.2.1
  which emits no warnings.  Once we have that we can worry about gcc-4 and
  other architectures.  Patches will be gratefully leapt upon.


Boilerplate:

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.




Changes since 2.6.15-mm4:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-ia64.patch
 git-infiniband.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-sym2.patch
 git-pcmcia.patch
 git-sas-jg.patch
 git-watchdog.patch

 git trees

-convert-proc-devices-to-use-seq_file-interface.patch
-altix-ioc3-serial-support.patch
-sched-add-sched_batch-policy.patch
-unlinline-a-bunch-of-other-functions.patch
-uml-fix-symbol-for-mktime.patch
-fix-for-config_numa-without-config_swap.patch
-sem2mutex-drivers-char-agp.patch
-amd64-agp-suspend-support.patch
-ati-agp-suspend-resume-support.patch
-sem2mutex-sound.patch
-sem2mutex-sound-pci.patch
-sem2mutex-sound-2.patch
-git-alsa-duplicate-ac97_quirks-entry-in-intel8x0c.patch
-alsa-cs5536-id-for-cs5535audio.patch
-sound-remove-bkl-from-sound-core-infoc.patch
-ali5451-add-pci_device-and-defines-in-snd_ali_ids.patch
-sem2mutex-drivers-cpufreq.patch
-gregkh-driver-input-MODALIAS-02.patch
-gregkh-driver-add-bus_type-probe-remove-shutdown-methods.patch
-gregkh-driver-add-pci_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-ecard_bus_type-probe-remove-shutdown-methods.patch
-gregkh-driver-add-sa1111-bus_type-probe-remove-methods.patch
-gregkh-driver-add-locomo-bus_type-probe-remove-methods.patch
-gregkh-driver-add-logic-module-bus_type-probe-remove-methods.patch
-gregkh-driver-add-tiocx-bus_type-probe-remove-methods.patch
-gregkh-driver-add-parisc_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-ocp_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-sh_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-of_platform_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-vio_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-dio_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-i2c_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-gameport-bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-serio-bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-macio_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-mcp-bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-mmc_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-pcmcia_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-pnp_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-ccwgroup_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-superhyway_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-usb_serial_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-zorro_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-rio_bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-pseudo-lld-bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-ide_bus_type-probe-and-remove-methods.patch
-gregkh-driver-remove-usb-gadget-generic-driver-methods.patch
-gregkh-driver-add-bttv-sub-bus_type-probe-and-remove-methods.patch
-gregkh-driver-add-css-ccw-_bus_type-probe-remove-shutdown-methods.patch
-gregkh-driver-platform-device-del-typo-fix.patch
-gregkh-driver-device_shutdown-can-loop-if-the-driver-frees-itself.patch
-gregkh-driver-driver-model-convert-driver-model-to-mutexes.patch
-gregkh-driver-spi-simple-spi-framework.patch
-gregkh-driver-spi-ads7846-driver.patch
-gregkh-driver-spi-mtd-dataflash-driver.patch
-gregkh-driver-spi-add-spi_driver-to-spi-framework.patch
-gregkh-driver-spi-core-tweaks-bugfix.patch
-gregkh-driver-spi-ads7836-uses-spi_driver.patch
-gregkh-driver-spi-add-spi_bitbang-driver.patch
-gregkh-driver-spi-m25-series-spi-flash.patch
-gregkh-driver-spi-use-linked-lists-rather-than-an-array.patch
-gregkh-driver-spi-misc-fixes.patch
-gregkh-driver-spi-remove-fastcall-crap.patch
-gregkh-driver-spi-add-spi_butterfly-driver.patch
-spi-set-kset-of-master-class-dev-explicitly.patch
-kobject-dont-oops-on-null-kobjectname.patch
-serial8250-convert-to-the-new-platform-device-interface.patch
-git-dvb-callbacks-fix.patch
-sem2mutex-drivers-media.patch
-sem2mutex-clean-up-arch-ia64-hp-sim-simserialc.patch
-pre-udma-eide-pio-mode-selection.patch
-libata-debugging-support.patch
-no-longer-mark-mtd_obsolete_chips-as-broken.patch
-drivers-net-s2ioc-make-code-static.patch
-drivers-net-arcnet-possible-cleanups.patch
-cassini-printk-fix.patch
-net-fix-prio-qdisc-bands-init.patch
-gregkh-pci-pci-error-recovery-symbios-scsi-device-driver.patch
-gregkh-pci-pci-error-recovery-ixgb-network-device-driver.patch
-gregkh-pci-pci-error-recovery-ipr-scsi-device-driver.patch
-gregkh-pci-pci-error-recovery-e1000-network-device-driver.patch
-gregkh-pci-pci-error-recovery-e100-network-device-driver.patch
-gregkh-pci-drivers-net-replace-pci_module_init-with-pci_register_driver.patch
-gregkh-pci-drivers-scsi-replace-pci_module_init-with-pci_register_driver.patch
-gregkh-pci-pci-schedule-removal-of-pci_module_init.patch
-sem2mutex-pci-hotplug.patch
-git-scsi-misc-buslogic-fix.patch
-sem2mutex-drivers-scsi-scsi_transport_spi.patch
-sem2mutex-drivers-scsi-32-9xxx.patch
-w1-u64-is-not-long-long.patch
-watchdog-winsystems-epx-c3-sbc.patch
-watchdog-winsystems-epx-c3-sbc-tidy.patch
-x86_64-defconfig-update.patch
-x86_64-powernow-init.patch
-x86_64-add-__meminit-for-memory-hotplug.patch
-x86_64-config-unwind-info.patch
-x86_64-lapic-resume-uses-correct-base-address.patch
-x86_64-config-unwind-info-ppc64-fix.patch
-add-tmpfs-options-for-memory-placement-policies.patch
-powerpc-add-support-for-the-mpc83xx-watchdog.patch
-powerpc-add-support-for-the-mpc83xx-watchdog-tidies.patch
-i386-put-hotplug_cpu-under-processor-type-not-bus-options.patch
-i386-fix-stack-dump-loglevel.patch
-i386-fix-stack-dump-loglevel-fixes.patch
-i386-remove-gcc-version-check-for-config_regparm.patch
-s390-des-crypto-code-cleanup.patch
-s390-des-crypto-code-speedup.patch
-s390-aes-crypto-code-fixes.patch
-s390-sha256-crypto-code-fix.patch
-s390-show_task-oops.patch
-s390-show_task-oops-fix.patch
-s390-sigcontexth-vs-__user.patch
-s390-fix-cpcmd-calls-on-up.patch
-s390-spinlock-fixes.patch
-s390-add-dummy-pm_power_off.patch
-s390-fix-blk_queue_ordered-call-in-dasdc.patch
-s390-cputime-misaccounting.patch
-s390-chps-array-too-short.patch
-s390-email-address-change.patch
-s390-fix-blk_queue_ordered-call-in-dasdc-fixup.patch
-piix-ide-pata-patch-for-intel-ich8m.patch
-hda_intel-patch-for-intel-ich8.patch
-ata_piix-ide-mode-sata-patch-for-intel-ich8.patch
-ahci-ahci-mode-sata-patch-for-intel-ich8.patch
-partitions-read-rio-karma-partition-table.patch
-cpuset-oom-lock-fix.patch
-kernel-kernel-cpuc-to-mutexes.patch
-ext2-remove-d_splice_alias-null-check-from-ext2_lookup.patch
-ext3-remove-d_splice_alias-null-check-from-ext3_lookup.patch
-isofs-remove-d_splice_alias-null-check-from-isofs_lookup.patch
-reiserfs-remove-d_splice_alias-null-check-from-reiserfs_lookup.patch
-quota-make-useless-quota-error-message-informative.patch
-abandon-gcc-295x-mainc-tidy.patch
-ncpfs-remove-kmalloc-wrapper.patch
-smbfs-remove-kmalloc-wrapper.patch
-reiserfs-remove-kmalloc-wrapper.patch
-reiserfs-use-__gfp_nofail-instead-of-yield-and-retry-loop.patch
-add-sys-fs.patch
-fuse-fuse_copy_finish-order-fix.patch
-fuse-fix-request_end.patch
-fuse-handle-error-init-reply.patch
-fuse-uninline-some-functions.patch
-fuse-miscellaneous-cleanup.patch
-fuse-introduce-unified-request-state.patch
-fuse-introduce-list-for-requests-under-i-o.patch
-fuse-extend-semantics-of-connected-flag.patch
-fuse-make-fuse-connection-a-kobject.patch
-fuse-add-number-of-waiting-requests-attribute.patch
-fuse-add-connection-aborting.patch
-fuse-add-asynchronous-request-support.patch
-fuse-move-init-handling-to-inodec.patch
-fuse-read-request-initialization.patch
-fuse-use-asynchronous-read-requests-for-readpages.patch
-fuse-update-documentation-for-sysfs.patch
-3c59x-improve-usage-of-netif_carrier_onoff.patch
-dell_rbu-fix-bug-5854.patch
-cs89x0-credit-dmitry-pervushin.patch
-cs89x0-use-elif-instead-of-else-if-endif.patch
-cs89x0-use-u16-for-device-register-data.patch
-cs89x0-add-ixdp2351-support.patch
-remove-unused-tmp_buf_sems.patch
-nlm-kernel-parameters-update.patch
-update-kernel-parameterstxt-iosched-to-spell-out-anticipatory.patch
-neofb-take-existing-display-configuration-as-default.patch
-gx1fb-try-to-play-nicer-with-various-bioses.patch
-fbdev-sanitize-fb_ioctl-prototype.patch
-fbdev-sanitize-fb_mmap-prototype-fix.patch
-fbdev-sanitize-fb_mmap-prototype.patch
-fbdev-update-maintainers-list.patch
-make-__always_inline-actually-force-always-inlining.patch
-enable-unit-at-a-time-optimisations-for-gcc4.patch
-mark-several-functions-__always_inline.patch
-mark-several-functions-__always_inline-fix.patch
-mark-some-key-vfs-functions-as-__always_inline.patch
-pktcdvd-un-inline-some-functions.patch
-make-inline-no-longer-mandatory-for-gcc-4x.patch
-drivers-net-sk98lin-possible-cleanups.patch
-build-kernel-intermodulec-only-when-required.patch
-drivers-net-use-time_after-and-friends.patch
-drivers-net-wireless-hostap-hostap_mainc-shouldnt-include-c-files.patch

 Merged

+x86_64-fix-mce-exception-stack-for-boot-cpu.patch

 x86_64 hotfix

+scsi_transport_spi-build-fix.patch

 scsi build fix

+synclink_gt-fix-size-of-register-value-storage.patch

 serial driver fix

+sem2mutex-acpi-acpi_link_lock.patch

 Fix sem2mutex-drivers-acpi.patch

+git-alsa-fixup.patch

 Fix rejects due to git-alsa.patch

+dsp_spos_scb_lib-assignment-fix.patch

 Fix alsa driver assert.

+block-request_queue-ordcolor-must-not-be-flipped-on-softbarrier.patch
+block-implement-elv_insert-and-use-it-fix-ordcolor-flipping-bug.patch

 Block fixes.

+gregkh-driver-kobject_add-must-have-valid-name.patch
+gregkh-driver-kobject-don-t-oops-on-null-kobject.name.patch
+gregkh-driver-fix-compiler-warning-in-driver-core-for-config_hotplug-n.patch
+gregkh-driver-put_device-might_sleep.patch
+gregkh-driver-fix-up-the-sysfs-pollable-patch.patch

 Driver tree updates

+revert-gregkh-driver-put_device-might_sleep.patch

 Revert excessively noisy warning

+gregkh-i2c-w1-u64-is-not-long-long.patch

 i2c tree update

+sem2mutex-i2c-2.patch
+sem2mutex-serial-port_write_mutex.patch
+sem2mutex-serial-port_write_mutex-fix.patch
+sem2mutex-jffs.patch
+sem2mutex-ntfs.patch
+sem2mutex-netfilter-x_tablec.patch
+sem2mutex-autofs4-wq_sem.patch
+sem2mutex-infiniband-2.patch
+sem2mutex-nfs-idmapc.patch
+convert-the-semaphores-in-the-sisusb-driver-to-mutexes.patch
+sem2mutex-drivers-macintosh-windfarm_corec.patch
+sem2mutex-jfs.patch
+sem2mutex-hpfs.patch
+convert-ext3s-truncate_sem-to-a-mutex.patch
+sem2mutex-ncpfs.patch
+sem2mutex-udf.patch
+sem2mutex-udf-fix.patch
+fat_lock-is-used-as-a-mutex-convert-it-to-using-the-new-mutex.patch
+sem2mutex-ioc4c.patch

 Mutex conversions

+pate_opti-build-fix.patch

 Fix git-libata-all build

+sata-acpi-build-update-makefile-kconfig.patch
+sata-acpi-objects-support-libata-acpimore-debugging.patch
+sata-acpi-objects-support-save-free-the-correct-acpi-object.patch

 Updates to the sata/acpi code in -mm.

+git-netdev-all-revert-e1000-changes.patch

 Revert e1000 changes frmo Jeff's tree - they busted the driver on my emt64
 box.

+ipw2100_match_buf-warning-fix.patch

 ipw2100 warning

-tulip-remove-duplicate-pci-ids.patch

 Dropped

+RT_CACHE_STAT_INC-warning-fix.patch

 Fix net might_sleep() warning

-sem2mutex-sungem-zoran-cassini-ipw2x00.patch
+sem2mutex-sungem.patch
+sem2mutex-zoran.patch
+sem2mutex-cassini.patch
+sem2mutex-ipw2x00.patch

 Patch was split up.

+gregkh-pci-pci-schedule-removal-of-pci_module_init.patch
+gregkh-pci-pci-pci_ids-remove-duplicates-gathered-during-merge-period.patch
+gregkh-pci-pci-hotplug-pci-panic-on-dlpar-add.patch
+gregkh-pci-pci-hotplug-shpchp-amd-pogo-errata-fix.patch
+gregkh-pci-pci-msi-vector-targeting-abstractions.patch
+gregkh-pci-pci-clean-up-msi.c-a-bit.patch
+gregkh-pci-x86-pci-domain-support-the-meat.patch
+gregkh-pci-pci-return-max-reserved-busnr.patch
+gregkh-pci-pci-hotplug-acpiphp-handle-dock-bridges.patch
+gregkh-pci-pci-really-fix-parent-s-subordinate-busnr.patch
+gregkh-pci-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
+gregkh-pci-pci-hotplug-convert-semaphores-to-mutex.patch

 PCI tree updates

+gregkh-pci-pci-msi-vector-targeting-abstractions-fix.patch

 Fix a patch in it.

+revert-gregkh-pci-x86-pci-domain-support-the-meat.patch

 Revert a broken patch from it.

+areca-raid-driver-arcmsr-update3-for-mm4.patch

 ARECA raid driver cleanups

-gregkh-usb-usb-iomega-umini-is-unusual.patch

 Dropped

+gregkh-usb-usb-remove-linux_version_code-macro-usage.patch
+gregkh-usb-usb-sn9c10x-driver-updates.patch

 USB tree updates

+auerswald-support-more-tk-devices.patch
+libusual-fix-warning-on-64bit-boxes.patch

 USB updates

+mm-dirty_exceeded-speedup.patch
+mm-dirty_exceeded-speedup-fix.patch

 Fix cacheline pingponging of a variable

+mm-migration-page-refcounting-fix.patch
+mm-migration-page-refcounting-fix-warning-fix.patch
+mm-migration-page-refcounting-fix-warning-fix-2.patch
+mm-migration-page-refcounting-fix-2.patch
+simplify-migrate_page_add.patch

 Fix up and clean up page migration code.

+slab-distinguish-between-object-and-buffer-size.patch
+slab-minor-cleanup-to-kmem_cache_alloc_node.patch
+slab-have-index_of-bug-at-compile-time.patch
+slab-cache_estimate-cleanup.patch
+slab-extract-slab_destroy_objs.patch
+slab-extract-slab_putget_obj.patch
+slab-reduce-inlining.patch
+slab-extract-virt_to_cacheslab.patch
+slab-rename-ac_data-to-cpu_cache_get.patch
+slab-replace-kmem_cache_t-with-struct-kmem_cache.patch

 slab cleanups

+bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm.patch

 Updates to the BSD secure levels code.

+i386-multi-column-stack-backtraces.patch

 Optionally compact the x86 stack traces

+mm-kernel-power-move-externs-to-header-files.patch
+swsusp-userland-interface.patch
+swsusp-userland-interface-fix.patch

 swsusp feature work.

+uml-add-__raw_writel-definition.patch
+uml-move-ldt-creation.patch
+uml-move-libc-dependent-utility-procedures.patch
+uml-move-libc-dependent-time-code.patch
+uml-change-interface-to-boot_timer_handler.patch
+uml-move-headers-to-arch-um-include.patch
+uml-move-libc-dependent-skas-memory-mapping-code.patch
+uml-move-libc-dependent-skas-process-handling.patch
+uml-eliminate-some-globals.patch
+uml-implement-soft-interrupts.patch
+uml-use-setjmp-longjmp-instead-of-sigsetjmp-siglongjmp.patch
+uml-tt-mode-softint-fixes.patch
+uml-remove-leftover-from-patch-revertal.patch
+uml-make-daemon-transport-behave-properly.patch
+uml-networking-clear-transport-specific-structure.patch
+uml-fix-spinlock-recursion-and-sleep-inside-spinlock-in-error-path.patch
+uml-sigio-code-reduce-spinlock-hold-time.patch
+uml-avoid-malloc-to-sleep-in-atomic-sections.patch
+uml-arch-kconfig-menu-cleanups.patch
+uml-allow-again-to-move-backing-file-and-to-override-saved-location.patch
+uml-ubd-code-fix-a-bit-of-whitespace.patch

 UML updates

+cleanup-cdrom_ioctl-fix.patch

 Fix a patch in -mm.

+elevator=as-back-compatibility.patch

 Kerel boot commandline back-compatibility

+3c59x-collision-statistic-fix.patch

 3c59x featurette

+snsc-kmalloc2kzalloc.patch
+sigprocmask-kill-unneeded-temp-var.patch

 Cleanup

+v9fs-add-readpage-support.patch

 v9fs feature

+fs-ufs-filec-drop-insane-header-dependencies.patch

 cleanup

+fix-sched_setscheduler-semantics.patch

 Fix sched_setscheduler

+sxc-warning-fixes.patch

 Fix warnings

+sbc-epx-does-not-check-claim-i-o-ports-it-uses-2nd-edition.patch

 Fix watchdog driver

+add-missing-syscall-declarations.patch

 Add syscalls.h entries

+fix-parisc-build-flush_tlb_all_local.patch

 parisc fix

+extract-inode_inc_count-inode_dec_count.patch
+minix-switch-to-inode_inc_link_count-inode_dec_link_count.patch
+sysv-switch-to-inode_inc_link_count-inode_dec_link_count.patch
+ext2-switch-to-inode_inc_link_count-inode_dec_link_count.patch
+ufs-switch-to-inode_inc_link_count-inode_dec_link_count.patch

 cleanups

+hfs-cleanup-hfsplus-prints.patch
+hfs-cleanup-hfs-prints.patch
+hfs-add-hfsx-support.patch
+hfs-set-correct-ctime.patch
+hfs-set-correct-create-date-for-links.patch
+hfs-set-type-creator-for-symlinks.patch

 HFS updates

+reiserfs-remove-kmalloc-wrapper.patch
+reiserfs-use-__gfp_nofail-instead-of-yield-and-retry-loop.patch
+reiserfs-missing-kmalloc-failure-check.patch
+reiserfs-remove-reiserfs_permission_locked.patch
+reiserfs-use-generic_permission.patch
+reiserfs-fix-race-between-invalidatepage-checks-and-data=ordered-writeback.patch
+reiserfs-zero-b_private-when-allocating-buffer-heads.patch
+reiserfs-hang-and-performance-fix-for-data=journal-mode.patch
+reiserfs-write_ordered_buffers-should-not-oops-on-dirty-non-uptodate-bh.patch
+reiserfs-fix-journal-accounting-in-journal_transaction_should_end.patch
+reiserfs-check-for-files-2gb-on-35x-disks.patch
+reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
+reiserfs-clean-up-bitmap-block-buffer-head-references.patch
+reiserfs-move-bitmap-loading-to-bitmapc.patch
+reiserfs-on-demand-bitmap-loading.patch
+reiserfs-on-demand-bitmap-loading-fix.patch
+reiserfs-on-demand-bitmap-loading-warning-fix.patch

 reiser3 updates

+time-delay-clocksource-selection-until-later-in-boot.patch

 Fix time patches in -mm.

+exportfs-add-find_acceptable_alias-helper.patch

 nfsd fix

+sched-alter_uninterruptible_sleep_interactivity-fix.patch

 Fix sched-alter_uninterruptible_sleep_interactivity.patch

+sched-modified-nice-support-for-smp-load-balancing-fix.patch
+sched-modified-nice-support-for-smp-load-balancing-fix-fix.patch

 Fix performance regressions due to
 sched-modified-nice-support-for-smp-load-balancing.patch

+video-hp680-backlight-driver.patch

 New backlight driver

+uml-add-tif_restore_sigmask-support.patch
+uml-use-generic-sys_rt_sigsuspend.patch

 Teach UML to use new signal infrastructure in -mm.

+mark-f_ops-const-in-the-inode-spufs-fix.patch

 Fix spufs for mark-f_ops-const-in-the-inode.patch

+replace-0xff-with-correct-dma_xbit_mask.patch

 Cleanups



All 703 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/patch-list


