Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbWBNJm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbWBNJm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWBNJm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:42:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030337AbWBNJmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:42:55 -0500
Date: Tue, 14 Feb 2006 01:41:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc3-mm1
Message-Id: <20060214014157.59af972f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/

- Various fixes, updates and cleanups.  Nothing very exciting, unless you
  spend a lot of your time waiting for msync() to complete.

- Again, please cast an eye across this patch series for things which should
  go into 2.6.16.

  There are a number of patches staged at the head of the series which I've
  identified for 2.6.16, and I see a few more which need to be cherrypicked. 
  But sometimes I'm not in a position to gauge the desirability/seriousness of
  some fixes.   Because people forget to tell...




Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch this -mm trees using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

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


Changes since 2.6.16-rc2-mm1:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-pcmcia-bt3c_cs-fix.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-unshare-system-call-v5-system-call-registration-for-powerpc.patch
-unshare-system-call-v5-system-call-registration-for-x86_64.patch
-sched-modified-nice-support-for-smp-load-balancing.patch
-8250-serial-console-update-uart_8250_port-ier.patch
-alpha-pci-set-cache-line-size-for-cards-ignored.patch
-powerpc-fix-sound-driver-use-of-i2c.patch
-block-implement-elv_insert-and-use-it-fix-ordcolor-flipping-bug.patch
-git-netdev-all-s2io-fixes.patch
-s2io-c99-warning-fix.patch
-prism54-warning-fix.patch
-appletalk-warning-fix.patch
-serial-serial_txx9-driver-update.patch
-serial-add-new-pci-serial-card-support.patch
-add-execute_in_process_context-api.patch
-fix-wrong-context-bugs-in-scsi.patch
-x86_64-gart-dma-merge.patch
-x86-print-out-early-faults-via-early_printk.patch
-arch-x86_64-kernel-trapsc-ptrace_singlestep-oops.patch
-fix-cpucontrol-cache_chain_mutex-lock-inversion-bug.patch
-remove-isa-legacy-functions-drivers-net-arcnet.patch
-remove-isa-legacy-functions-drivers-net-hp100c.patch
-tipar-fixes.patch
-from-drivers-video-kconfig-remove-unused-bus_i2c-option.patch
-nvidiafb-add-support-for-geforce4-mx-4000.patch

 Merged

-uml-define-jmpbuf-access-constants.patch

 Dropped

+pktcdvd-dont-spam-the-kernel-log-when-nothing-is-wrong.patch
+pktcdvd-allow-non-writable-media-to-be-mounted.patch
+pktcdvd-dont-unlock-the-door-if-the-disc-is-in-use.patch
+pktcdvd-reduce-stack-usage.patch

 Packet-writing fixes

+compound-page-use-pagelru.patch
+compound-page-default-destructor.patch
+compound-page-no-access_process_vm-check.patch

 Core mm fixes

+tty-reference-count-fix.patch

 tty race fix

+jbd-revert-checkpoint-list-changes.patch

 Revert a JBD patch which affected OCFS2.

+nlm-fix-the-nlm_granted-callback-checks.patch

 NFS fix

+fix-x86-topology-export-in-sysfs-for-subarchitectures.patch

 CPU topology fix

+fix-null-pointer-dereference-in-isdn_tty_at_cout.patch

 ISDN oops fix

+kprobes-update-documentation-kprobestxt.patch

 Documentation

+madvise-madv_dontfork-madv_dofork.patch

 madvise extensions to support direct-io across forks.

+sched-revert-filter-affine-wakeups.patch

 Drop a scheduler patch which caused some regression.

+fix-a-typo-in-the-cpu_h8300h-dependencies.patch

 Kconfig fix.

-multiple-exports-of-strpbrk-fix.patch

 Folded into multiple-exports-of-strpbrk.patch

-lxdialog-sane-colours.patch

 Checked into my local tree.  The default colours drive me batty.

+git-acpi-up-fix.patch

 Fix git-acpi.patch on !SMP

+acpi_os_acquire_object-gfp_kernel-called-with-irqs.patch

 swsusp is optimistic about interrupt disabling.

+acpi-ia64-wake-on-lan-fix.patch

 Fix WoL on ia64

+git-blktrace-fixup.patch

 Fix reject due to git-blktrace.patch

+gregkh-driver-clean-up-module.c-symbol-searching-logic.patch
+gregkh-driver-export_symbol_gpl_future.patch
+gregkh-driver-export_symbol_gpl_future-rcu.patch
+gregkh-driver-export_symbol_gpl_future-usb.patch

 Driver tree updates.

-spi-add-bus-methods-instead-of-drivers-ones.patch
-spi-add-bus-methods-instead-of-drivers-ones-fixes.patch

 Dropped.

+firmware-fix-bug-in-fw_realloc_buffer.patch

 Firmware loader fix.

+pxa2xx-ssp-spi-driver.patch

 New SPI driver.

-hdaps-convert-to-the-new-platform-device-interface.patch

 Dropped, was oopsy.

+kbuild-add-fverbose-asm-to-i386-makefile.patch

 Make the output of `make foo/bar.s' more interesting.

-sata-acpi-build-fix.patch
-sata-acpi-build-update-makefile-kconfig.patch

 Folded into sata-acpi-build.patch

-sata-acpi-objects-support-libata-acpimore-debugging.patch
-sata-acpi-objects-support-save-free-the-correct-acpi-object.patch

 Folded into sata-acpi-objects-support.patch

+natsemi-napi-conversion.patch
+natsemi-rx-lockup-fix.patch
+sky2-fix-a-hang-on-yukon-ec-0xb6-rev-1.patch
+sky2-speed-setting-fix.patch
+sky2-use-mutex.patch
+drivers-net-ns83820c-add-paramter-to-disable-auto.patch
+drivers-net-ns83820c-add-paramter-to-disable-auto-tidy.patch
+ipw2200-restrict-wep-fix.patch

 netdev fixes

-sky2-fix-hang-on-yukon-ec-0xb6-rev-1.patch

 Dropped - the new version doesn't work.

+netfilter-fix-cid-offset-bug-in-pptp-nat-helper.patch

 Netfilter fix.

+powerpc-dont-allow-old-rtc-to-be-selected.patch

 powerpc Kconfig fix

+gregkh-pci-msi-vector-targeting-abstractions.patch
+gregkh-pci-altix-msi-support.patch
+gregkh-pci-pci-fix-msi-build-breakage-in-x86_64.patch
+gregkh-pci-pci-clean-up-msi.c-a-bit.patch

 PCI tree updates.

+pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch

 PCI quirk.

+git-pcmcia-bt3c_cs-fix.patch

 Fix git-pcmcia.patch

-ib-dont-doublefree-pages-from-scatterlist.patch
-ipr-dont-doublefree-pages-from-scatterlist.patch
-osst-dont-doublefree-pages-from-scatterlist.patch

 Dropped, unneeded.

+drivers-scsi-gdthc-make-__gdth_execute-static.patch
+drivers-scsi-qla2xxx-make-some-functions-static.patch
+scsi-cd-varirec-gigarec-and-powerrec-as-user.patch

 SCSI cleanups.

+gregkh-usb-usb-fix-up-the-usb-early-handoff-logic-for-ehci.patch

 USB tree update.

+x86_64-defconfig-update.patch
+x86_64-i386-pci-ordering.patch
+x86_64-remove-dead-do_softirq_thunk.patch
+x86_64-make-touch_nmi_watchdog-not-touch-impossible-cpus-private-data.patch
+x86_64-fix-user_ptrs_per_pgd.patch
+x86_64-argument-check.patch
+x86_64-fix-string.patch
+x86_64-agp-ali-m1695.patch
+x86_64-disable-randmaps.patch
+x86_64-traps-whitespace.patch
+x86_64-bad-iret-sti.patch

 x86_64 tree updates.

-mm-never-clearpagelru-released-pages-tidy.patch

 Folded into mm-never-clearpagelru-released-pages.patch

-mm-split-highorder-pages-fix.patch

 Folded into mm-split-highorder-pages.patch

-slab-extract-setup_cpu_cache-tidy.patch
-slab-extract-setup_cpu_cache-tidy-tidy2.patch

 Folded into slab-extract-setup_cpu_cache.patch

+mm-kill-kmem_cache_t-usage.patch
+slab-fix-kernel-doc-warnings.patch

 Slab cleanups.

+terminate-process-that-fails-on-a-constrained-allocation-v3.patch

 NUMA oom-killer tweak.

+vmscan-scan_control-cleanup.patch
+vmscan-use-unsigned-longs.patch
+vmscan-return-nr_reclaimed.patch
+vmscan-rename-functions.patch
+zone_reclaim-additional-comments-and-cleanup.patch

 Various clanups to the VM scanning code.

-acx1xx-wireless-driver-usb-is-bust.patch
-acx1xx-allow-modular-build.patch
-acx1xx-wireless-driver-spy_offset-went-away.patch
-acx-update.patch
-acx-update-2.patch
-drivers-net-wireless-tiacx-add-missing-include-linux-vmallocha.patch
-tiacx-usb_driver-build-fix.patch
-acx-should-select-not-depend-on-fw_loader.patch
-acx-driver-update.patch
-update-mm-acx-driver-to-version-0331.patch

 Folded into acx1xx-wireless-driver.patch

-bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-fix.patch

 Folded into bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm.patch

+macintosh-cleanup-the-use-of-i2c-headers.patch

 Cleanup.

-i386-multi-column-stack-backtraces-update.patch

 Folded into i386-multi-column-stack-backtraces.patch

-x86-smp-alternatives-tidy.patch
-x86-smp-alternatives-fix.patch
-x86-smp-alternatives-fix-2.patch
-x86-smp-alternatives-fix-3.patch
-x86-smp-alternatives-tidy-2.patch

 Folded into x86-smp-alternatives.patch

-i386-add-a-temporary-to-make-put_user-more-type-safe-fix.patch

 Folded into i386-add-a-temporary-to-make-put_user-more-type-safe.patch

+x86-document-sysenter-path.patch

 Commentary.

+x86-gitignore-some-autogenerated-files-for-i386.patch

 .gitignores.

-swsusp-low-level-interface-rev-2-fix.patch

 Folded into swsusp-low-level-interface-rev-2.patch

+swsusp-documentation-updates-update.patch

 Folded into swsusp-documentation-updates.patch

-suspend-to-ram-allow-video-options-to-be-set-at-runtime-fix.patch

 Folded into suspend-to-ram-allow-video-options-to-be-set-at-runtime.patch

-swsusp-userland-interface-update.patch

 Folded into swsusp-userland-interface.patch

-suspend-update-documentation.patch

 Folded into swsusp-freeze-user-space-processes-first.patch

+dasd-cleanup-dasd_ioctl.patch
+dasd-cleanup-dasd_ioctl-fix.patch
+dasd-add-per-disciple-ioctl-method.patch
+dasd-merge-dasd_cmd-into-dasd_mod.patch
+dasd-backout-dasd_eer-module.patch
+dasd-kill-dynamic-ioctl-registration.patch

 s390 dasd ioctl cleanups.

-shrinks-sizeoffiles_struct-and-better-layout-tidy.patch

 Folded into shrinks-sizeoffiles_struct-and-better-layout.patch

-avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage-tidy.patch

 Folded into avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage.patch

-cleanup-cdrom_ioctl-fix.patch

 Folded into cleanup-cdrom_ioctl.patch

-kernel-cpusetc-mutex-conversion-fix.patch
-kernel-cpusetc-mutex-conversion-fix-fix.patch

 Folded into kernel-cpusetc-mutex-conversion.patch

+sem2mutex-ipc-idsem-fix.patch

 Fix sem2mutex-ipc-idsem.patch.

-sem2mutex-udf-fix.patch

 Folded into sem2mutex-udf.patch

-make-bug-messages-more-consistent-update.patch

 Folded into make-bug-messages-more-consistent.patch

-i386-instead-of-poisoning-init-zone-change-protection-fix.patch

 Folded into i386-instead-of-poisoning-init-zone-change-protection.patch

-avoid-use-of-spinlock-for-percpu_counter.patch

 Dropped - other patches want that spinlock.

-tvec_bases-too-large-for-per-cpu-data-fix.patch

 Folded into tvec_bases-too-large-for-per-cpu-data.patch

+cpusets-only-wakeup-kswapd-for-zones-in-the-current-cpuset.patch
+cpuset-cleanup-not-not-operators.patch
+cpuset-use-combined-atomic_inc_return-calls.patch

 cpuset work.

-cpuset-memory-spread-basic-implementation-fix.patch

 Folded into cpuset-memory-spread-basic-implementation.patch

-cpuset-memory-spread-slab-cache-optimizations-tidy.patch

 Folded into cpuset-memory-spread-slab-cache-optimizations.patch

+percpu_counter_sum.patch
+fast-ext3_statfs.patch

 Speed up ext3 statfs()

+fw-abstract-type-size-specification-for-assembly.patch

 Assembly language helpers.

+config_unwind_info.patch
+filemap_fdata_write-api-fix-end-parameter.patch
+fadvise-async-write-commands.patch

 New fadvise() features for partial-file writeout and wait.

+early_printk-cleanup-trailiing-whitespace.patch
+sb_set_blocksize-cleanup.patch

 Cleanup.

+shmdt-check-address-aligment.patch

 shm fix.

+input-98kbd-io-and-98spkr-removal-really.patch
+block-floppy98-removal-really.patch
+sound-remove-pc98-specific-opl3_hw_opl3_pc98.patch

 pc98 removal.

+net-remove-config_net_cbus-conditional-for-ns8390.patch
+trivial-cleanup-to-proc_check_chroot.patch

 Cleanups.

+hotplug_cpu-avoid-hitting-too-many-cachelines-in-recalc_bh_state.patch

 Small optimisation.

+balance_dirty_pages_ratelimited-take-nr_pages-arg.patch
+set_page_dirty-return-value-fixes.patch
+msync-perform-dirty-page-levelling.patch
+msync-ms_sync-dont-hold-mmap_sem-while-syncing.patch
+msync-fix-return-value.patch
+fsync-extract-internal-code.patch
+msync-use-do_fsync.patch

 Various optimisations to the msync() code.

+altix-more-ioc3-cleanups.patch

 Altix driver cleanup.

+secure-digital-host-controller-id-and-regs.patch
+mmc-secure-digital-host-controller-interface-driver.patch

 SD driver update

+updated-documentation-nfsroottxt.patch

 Documentation.

+console_setup-depends-wrongly-on-config_printk.patch

 console fix.

+3c59x-use-mii_check_media.patch
+3c59x-use-mii_check_media-tidy.patch
+3c59x-decrease-polling-intervall.patch
+3c59x-carriercheck-for-forced-media.patch
+3c59x-use-ethtool_op_get_link.patch
+3c59x-remove-per-driver-versioning.patch
+3c59x-minor-cleanups.patch
+3c59x-documentation-update.patch

 3c59x updates.

+fork-allow-init-to-become-a-session-leader.patch
+wait_for_helper-trivial-style-cleanup.patch

 More core-kernel process management fixes and cleanups.

-mempool-add-page-allocator-fix.patch
-mempool-add-page-allocator-fix-2.patch

 Folded into mempool-add-page-allocator.patch

-mempool-add-kmalloc-allocator-fix.patch

 Folded into mempool-add-kzalloc-allocator.patch

-mempool-add-mempool_create_slab_pool-fix.patch
-mempool-add-mempool_create_slab_pool-update.patch

 Folded into mempool-add-mempool_create_slab_pool.patch

-autofs4-expire-mounts-that-hold-no-extra-references-only-fix.patch

 Folded into autofs4-expire-mounts-that-hold-no-extra-references-only.patch

-led-add-led-class-tidy.patch
-led-add-led-class-tidy-fix.patch
-led-add-led-class-fix2.patch

 Folded into led-add-led-class.patch

-led-add-led-trigger-support-tidy.patch
-led-trigger-support-fixes.patch

 Folded into led-add-led-trigger-support.patch

-led-add-led-timer-trigger-tidy.patch
-led-add-led-timer-trigger-fix.patch
-led-add-led-timer-trigger-fix-2.patch

 Folded into led-add-led-timer-trigger.patch

-led-add-sharp-charger-status-led-trigger-tidy.patch

 Folded into led-add-sharp-charger-status-led-trigger.patch

-led-add-led-device-support-for-the-zaurus-corgi-and-tidy.patch

 Folded into led-add-led-device-support-for-the-zaurus-corgi-and.patch

-led-add-led-device-support-for-locomo-devices-tidy.patch

 Folded into led-add-led-device-support-for-locomo-devices.patch

-led-add-led-device-support-for-ixp4xx-devices-tidy.patch
-led-add-led-device-support-for-ixp4xx-devices-license-change.patch

 Folded into led-add-led-device-support-for-ixp4xx-devices.patch

-led-add-device-support-for-tosa-tidy.patch

 Folded into led-add-device-support-for-tosa.patch

-led-add-nand-mtd-activity-led-trigger-tidy.patch

 Folded into led-add-nand-mtd-activity-led-trigger.patch

-led-add-ide-disk-activity-led-trigger-tidy.patch
-led-add-ide-disk-activity-led-trigger-fix.patch
-led-add-ide-disk-activity-led-trigger-fix-2.patch
-led-add-ide-disk-activity-led-trigger-fix-3.patch

 Folded into led-add-ide-disk-activity-led-trigger.patch

-ext3-get-blocks-maping-multiple-blocks-at-a-once-ext3_getblk-fix.patch

 Folded into ext3-get-blocks-maping-multiple-blocks-at-a-once.patch

-ext3-get-blocks-multiple-block-allocation-cleanup.patch

 Folded into ext3-get-blocks-multiple-block-allocation.patch

-ext3-get-blocks-adjust-accounting-info-in-build-fix.patch

 Folded into ext3-get-blocks-adjust-accounting-info-in.patch

-time-reduced-ntp-rework-part-2-fix.patch
-time-reduced-ntp-rework-part-2-fix-2.patch

 Folded into time-reduced-ntp-rework-part-2.patch

-time-clocksource-infrastructure-fix-clocksource_lock-deadlock.patch
-time-clocksource-infrastructure-fix-clocksource_lock-deadlock-crs.patch

 Folded into time-clocksource-infrastructure.patch

-time-generic-timekeeping-infrastructure-fix.patch
-time-generic-timekeeping-infrastructure-fix-crs.patch

 Folded into time-generic-timekeeping-infrastructure.patch

-time-i386-conversion-part-2-rework-tsc-support-c2-fix.patch

 Folded into time-i386-conversion-part-2-rework-tsc-support.patch

+time-i386-conversion-part-2-rework-tsc-support-section-fix.patch

 Fix +time-i386-conversion-part-2-rework-tsc-support-section.patch

+time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change-x86_64-fix.patch

 Fix time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch

-time-i386-clocksource-drivers-fix.patch
-time-i386-clocksource-drivers-fix-crs.patch

 Folded into time-i386-clocksource-drivers.patch

-x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad-crs.patch

 Folded into x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad.patch

-kretprobe-kretprobe-booster-fixes.patch

 Folded into kretprobe-kretprobe-booster.patch

-dlm-communication-fix-lowcomms-race.patch

 Folded into dlm-communication.patch

-dlm-recovery-make-code-static.patch

 Folded into dlm-recovery.patch

-dlm-build-fix.patch
-dlm-build-fix-2.patch

 Folded into dlm-build.patch

-dlm-use-configfs-fix.patch
-dlm-use-configfs-fix-2.patch

 Folded into dlm-use-configfs.patch

+isdn4linux-siemens-gigaset-drivers-kconfigs-and-makefiles.patch
+isdn4linux-siemens-gigaset-drivers-common-module.patch
+isdn4linux-siemens-gigaset-drivers-event-layer.patch
+isdn4linux-siemens-gigaset-drivers-isdn4linux-interface.patch
+isdn4linux-siemens-gigaset-drivers-tty-interface.patch
+isdn4linux-siemens-gigaset-drivers-procfs-interface.patch
+isdn4linux-siemens-gigaset-drivers-direct-usb-connection.patch
+isdn4linux-siemens-gigaset-drivers-isochronous-data-handler.patch
+isdn4linux-siemens-gigaset-drivers-m105-usb-dect-adapter.patch

 New ISDN driver.

+sched-restore-smpnice.patch

 Bring back recently-reverted-in-Linus's-tree CPU scheduler patch.

+sched-modified-nice-support-for-smp-load-balancing.patch

 Maybe make it better.

-sched-alter_uninterruptible_sleep_interactivity-fix.patch

 Folded into sched-alter_uninterruptible_sleep_interactivity.patch

-sched-new-sched-domain-for-representing-multi-core-fix.patch
-sched-new-sched-domain-for-representing-multi-core-default-y.patch

 Folded into sched-new-sched-domain-for-representing-multi-core.patch

+reiser4-big-update-rename-print_address.patch

 Folded into reiser4-big-update-bug-fix-for-readpage-fix.patch

-vgacon-add-support-for-soft-scrollback-fix.patch

 Folded into vgacon-add-support-for-soft-scrollback.patch

-nvidiafb-add-suspend-and-resume-hooks-tidy.patch
-nvidiafb-add-suspend-and-resume-hooks-fix.patch

 Folded into nvidiafb-add-suspend-and-resume-hooks.patch

+fbdev-framebuffer-driver-for-geode-gx-update.patch

 Folded into fbdev-framebuffer-driver-for-geode-gx.patch

+neofb-avoid-resetting-display-config-on-unblank.patch
+matroxfb-simply-return-what-i2c_add_driver-does.patch
+matrox-maven-memory-allocation-and-other-cleanups.patch
+radeonfb-resume-support-for-samsung-p35-laptops.patch

 fbdev updates.

+dm-make-sure-queue_flag_cluster-is-set-properly.patch

 Device mapper fix.

-mark-f_ops-const-in-the-inode-gadgetfs-fix.patch
-mark-f_ops-const-in-the-inode-spufs-fix.patch
-mark-f_ops-const-in-the-inode-ppc-htab-fix.patch

 Folded into mark-f_ops-const-in-the-inode.patch

-documentation-ioctl-messtxt-add-260-more-ioctls.patch
-documentation-ioctl-messtxt-start-annotating-i-o.patch
-documentation-ioctl-messtxt-fill-more-holes-in-b-p-range.patch
-documentation-ioctl-messtxt-document-85-more-ioctls.patch
-documentation-ioctl-messtxt-update.patch

 Folded into documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch

-post-halloween-doc-update-1.patch
-post-halloween-doc-update-2.patch
-post-halloween-doc-update-3.patch
-fbdev-update-framebuffer-feature-list.patch
-fbdev-video_setup-warning-fix.patch

 Folded into post-halloween-doc.patch

-page-owner-tracking-leak-detector-fix.patch

 Folded into page-owner-tracking-leak-detector.patch

-slab-cache-shrinker-statistics-fix.patch

 Folded into slab-cache-shrinker-statistics.patch

-debug-shared-irqs-fix.patch
-debug-shared-irqs-fix-2.patch

 Folded into debug-shared-irqs.patch

-remove-checkconfigpl.patch

 Dropped, wrong.



All 831 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/patch-list


