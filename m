Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVILJo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVILJo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVILJo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:44:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751270AbVILJoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:44:24 -0400
Date: Mon, 12 Sep 2005 02:43:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-mm3
Message-Id: <20050912024350.60e89eb1.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm3/

(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm3.gz)

- perfctr was dropped.  Mikael has ceased development and recommends that
  the focus be upon perfmon.  See
  http://sourceforge.net/mailarchive/forum.php?thread_id=8102899&forum_id=2237

- There are several performance tuning patches here which need careful
  attention and testing.  (Does anyone do performance testing any more?)

  - An update to the anticipatory scheduler to fix a performance problem
    where processes do a single read then exit, in the presence of competing
    I/O acticity.

  - The size of the page allocator per-cpu magazines has been increased

  - The page allocator has been changed to use higher-order allocations
    when batch-loading the per-cpu magazines.  This is intended to give
    improved cache colouring effects however it might have the downside of
    causing extra page allocator fragmentation.

  - The page allocator's per-cpu magazines have had their lower threshold
    set to zero.  And we can't remember why it ever had a lower threshold.

- Dropped all the virtualisation preparatory patches.  Will later pick these
  up from a git tree which chrisw is running.

- There are still quite a few patches here for 2.6.14 (30-50, perhaps).




Changes since 2.6.13-mm2:


 linus.patch
 git-cifs.patch
 git-drm.patch
 git-ia64.patch
 git-ia64-fixup.patch
 git-audit.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-nfs-oops-fix.patch
 git-ocfs2-prep.patch
 git-ocfs2.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch

 Subsystem trees

-ip_conntrack_netbios_ns-build-fix.patch
-clear-task_struct-fs_excl-on-fork.patch
-i386-config_acpi_srat-typo-fix.patch
-ppc64-fix-oops-for-config_numa.patch
-ppc32-fix-kconfig-mismerge.patch
-agp-AGP-01-printk-levels.patch
-gregkh-driver-sysfs-write-ENOBUFS.patch
-gregkh-i2c-w1-fs9490-sync.patch
-gregkh-i2c-w1-01-hotplug.patch
-gregkh-i2c-w1-02-64bit.patch
-gregkh-i2c-w1-03.patch
-gregkh-i2c-w1-04.patch
-gregkh-i2c-w1-05.patch
-gregkh-i2c-w1-06.patch
-gregkh-i2c-w1-07.patch
-gregkh-i2c-w1-08.patch
-gregkh-i2c-w1-09.patch
-gregkh-i2c-w1-10-crc16.patch
-gregkh-i2c-w1-11.patch
-gregkh-i2c-w1-12.patch
-ignore-all-debugging-info-sections-in-scripts-reference_discardedpl.patch
-fix-split-include-dependency.patch
-txx9-serial-update.patch
-gregkh-pci-pci-rpaphp-01.patch
-gregkh-pci-pci-rpaphp-02.patch
-gregkh-pci-pci-rpaphp-03.patch
-gregkh-pci-pci-rpaphp-04.patch
-gregkh-pci-pci-rpaphp-05.patch
-gregkh-pci-pci-rpaphp-06.patch
-gregkh-pci-pci-driver-init-on-node.patch
-gregkh-pci-pci-move-pci-fixup-data-into-r-o-section.patch
-gregkh-pci-pci-remove-pretty-names.patch
-gregkh-pci-pci-remove-pretty-names-02.patch
-gregkh-pci-pci-cleanup-pci.h.patch
-gregkh-pci-pci-io_remap_pfn_range.patch
-gregkh-pci-pci-hotplug-use-bus_slot-number-for-name.patch
-gregkh-pci-pci-restore-bar-values.patch
-gregkh-pci-pci-make-sparc64-use-setup-res.patch
-gregkh-pci-pci-cleanup-return-values.patch
-gregkh-pci-pci-cleanup-return-values-fix.patch
-gregkh-pci-pci-remove-pci_find_device-from-parport_pc.patch
-gregkh-pci-pci-sgi-hotplug-fixes.patch
-gregkh-pci-pci-pci_intx.patch
-gregkh-pci-pci-pm-support-pm-cap-version-3.patch
-gregkh-pci-pci-pci_walk_bus.patch
-gregkh-pci-pci-fix-hotplug-vars.patch
-gregkh-pci-pci-must_check-attributes.patch
-pci-unhide-smbus-on-compaq-evo-n620c.patch
-git-scsi-iscsi-vs-git-net.patch
-git-net-vs-iscsi-fix.patch
-gregkh-usb-usb-cypress_m8-whitespace-fixes.patch
-gregkh-usb-usb-add-apple-touchpad-driver.patch
-gregkh-usb-usb-option-card-driver-coding-style-tweaks.patch
-gregkh-usb-usb-usbserial-remove-unneeded-casts.patch
-gregkh-usb-usb-gadget-centrialize-numbers.patch
-gregkh-usb-usb-keyspan_remote-endian-fix.patch
-gregkh-usb-usb-pl2303hx-fix.patch
-gregkh-usb-usb-ftdi_sio-userspecified-vid.patch
-gregkh-usb-usb-ftdi_sio-new-ids.patch
-gregkh-usb-usb-hid-blacklist-apple-bluetooth.patch
-gregkh-usb-usb-real-nodes-instead-of-usbfs.patch
-gregkh-usb-usb-real-nodes-instead-of-usbfs-fix.patch
-gregkh-usb-usb-storage-unusual-devs-mitsumi.patch
-gregkh-usb-usb-ub-01.patch
-gregkh-usb-usb-ub-02.patch
-gregkh-usb-usb-ub-03.patch
-gregkh-usb-usb-ub-04.patch
-gregkh-usb-usb-usblp-rate-limit-error-messages.patch
-gregkh-usb-usb-usbnet-gfp_flags-fix.patch
-gregkh-usb-usb-isp116x-hcd-01.patch
-gregkh-usb-usb-isp116x-hcd-02.patch
-gregkh-usb-usb-isp116x-hcd-03.patch
-gregkh-usb-usb-isp116x-hcd-04.patch
-gregkh-usb-usb-isp116x-hcd-05.patch
-gregkh-usb-usb-isp116x-hcd-06.patch
-gregkh-usb-usb-storage-01.patch
-gregkh-usb-usb-storage-02.patch
-gregkh-usb-usb-storage-03.patch
-gregkh-usb-usb-storage-04.patch
-gregkh-usb-usb-storage-05.patch
-gregkh-usb-usb-remove-URB_ASYNC_UNLINK.patch
-gregkh-usb-usb-serial-async-fixup.patch
-gregkh-usb-usb-fix-hp8200.patch
-gregkh-usb-usb-hub-code-motion.patch
-gregkh-usb-usb-hub-disconnect-children.patch
-gregkh-usb-usb-s3c24xx-port-numbering-fix.patch
-gregkh-usb-usb-ohci-ppc-soc-fix.patch
-gregkh-usb-usb-usb_lock_device_for_reset-timeout.patch
-gregkh-usb-usb-unbind-usb_generic-driver.patch
-gregkh-usb-usb-tweak-highspeed-calculations.patch
-gregkh-usb-usb-remove-annoying-message.patch
-gregkh-usb-usb-ohci-ppc-soc-include.patch
-gregkh-usb-usb-schedule-oss-usb-drivers-removal.patch
-gregkh-usb-usb-ldusb-64-bit-warnings.patch
-gregkh-usb-usb-usbnet-01.patch
-gregkh-usb-usb-usbnet-02.patch
-gregkh-usb-usb-usbnet-03.patch
-gregkh-usb-usb-usbnet-04.patch
-gregkh-usb-usb-usbnet-05.patch
-gregkh-usb-usb-usbnet-06.patch
-gregkh-usb-usb-usbnet-07.patch
-gregkh-usb-usb-usbnet-08.patch
-gregkh-usb-usb-usbnet-09.patch
-gregkh-usb-usb-ehci-01.patch
-gregkh-usb-usb-ehci-02.patch
-gregkh-usb-usb-usbmon-dma-areas.patch
-gregkh-usb-usb-yealink.patch
-gregkh-usb-usb-yealink-update.patch
-gregkh-usb-usb-storage-onetouch-cleanups.patch
-security-enable-atomic-inode-security-labeling.patch
-security-enable-atomic-inode-security-labeling-use-kstrdup.patch
-ext2-enable-atomic-inode-security-labeling.patch
-ext2-enable-atomic-inode-security-labeling-fix.patch
-ext3-enable-atomic-inode-security-labeling.patch
-ext3-enable-atomic-inode-security-labeling-fix.patch
-tmpfs-enable-atomic-inode-security.patch
-tmpfs-enable-atomic-inode-security-fix.patch
-remove-security_inode_post_create-mkdir-symlink-mknod.patch
-remove-the-inode_post_link-and-inode_post_rename-lsm-hooks.patch
-ppc32-make-perfmono-config_e500-specific.patch
-mips-add-tanbac-tb0287-support.patch
-i386-seccomp-fix-for-auditing-ptrace.patch
-x86_64dont-do-broadcast-ipis-when-hotplug-is-enabled-in-flat-mode.patch
-x86_64-dont-call-enforce_max_cpus-when-hotplug-is-enabled-2.patch
-alpha-process_reloc_for_got-confuses-r_offset-and-r_addend.patch
-scan-all-enabled-ports-on-ata_piix.patch
-pty_chars_in_buffer-oops-fix.patch
-convert-proc-devices-to-use-seq_file-interface.patch
-convert-proc-devices-to-use-seq_file-interface-tidy.patch
-ibm-hdaps-accelerometer-driver-with-probing.patch
-vga-text-console-and-stty-cols-rows.patch
-vga-text-console-and-stty-cols-rows-tidy.patch
-autofs-fix-busy-inodes-after-umount.patch
-fix-disassociate_ctty-vs-fork-race.patch
-prefetch-kernel-stacks-to-speed-up-context-switch.patch
-bfs-fix-endianness-signedness-add-trivial-bugfix.patch
-cs89x0-add-netpoll-support.patch
-change-io_cancel-return-code-for-no-cancel-case.patch
-kiocb-locking-to-serialise-retry-and-cancel-2.patch
-subcpusets-fix-for-cpusets-minor-problem.patch
-remove-unnecessary-handle_irq_event-prototypes.patch
-deadline-cleanup-question-mark-operator.patch
-synclinkc-compiler-optimisation-fix.patch
-synclinkc-add-clear-stats.patch
-synclinkc-add-loopback-to-async-mode.patch
-synclinkmpc-fix-double-mapping-of-signals.patch
-synclinkmpc-disable-burst-transfers.patch
-synclinkmpc-add-statistics-clear.patch
-synclinkmpc-fix-async-internal-loopback.patch
-fix-reboot-via-keyboard-controller-reset.patch
-dvb-email-address-update.patch
-dvb-remove-versionh-dependencies.patch
-dvb-avoid-building-empty-built-ino.patch
-dvb-core-glue-code-for-dmx_get_caps-and-dmx_set_source.patch
-dvb-core-dvb_demux-fix-continuity-counter-error-handling.patch
-dvb-core-dvb_demux-remove-unused-cruft.patch
-dvb-core-dvb_demux-remove-unsused-descramble-callbacks.patch
-dvb-core-dvb_demux-remove-more-unused-cruft.patch
-dvb-core-dvb_demux-use-init_list_head.patch
-dvb-core-dvb_demux-formatting-fixes.patch
-dvb-core-ci-timeout-fix.patch
-dvb-frontend-mt352-fix-signal-strength-reading.patch
-dvb-frontend-stv0299-pass-i2c-bus-to-pll-callback.patch
-dvb-frontend-s5h1420-fixes.patch
-dvb-frontend-stv0299-support-reading-both-ber-and-ucblocks.patch
-dvb-frontend-tda1004x-fix-snr-reading.patch
-dvb-frontend-ves1820-improve-tuning.patch
-dvb-frontend-cx24110-diseqc-fix.patch
-dvb-frontend-cx24110-another-diseqc-fix.patch
-dvb-frontend-cx24110-clean-up-timeout-handling.patch
-dvb-frontend-stv0297-qam128-tuning-improvement.patch
-dvb-frontend-or51132-remove-bogus-optimization-attempt.patch
-dvb-usb-add-twinhandtv-starbox-support.patch
-dvb-usb-dibusb-kworld-xpert-dvb-t-usb20-support.patch
-dvb-usb-removed-empty-module_init-exit-calls.patch
-dvb-usb-dtt200u-copy-frontend_ops-before-modifying.patch
-dvb-usb-dtt200u-add-proper-device-names.patch
-dvb-usb-core-change-dvb_usb_device_init-api.patch
-dvb-usb-digitv-support-for-nxt6000-demod.patch
-dvb-usb-white-space-cleanup.patch
-dvb-usb-cxusb-fixes-for-new-firmware.patch
-dvb-remove-noisy-debug-print.patch
-dvb-bt8xx-endianness-fix.patch
-dvb-bt8xx-cleanup.patch
-dvb-bt8xx-nebula-digitv-mt352-support.patch
-dvb-nebula-digitv-nxt6000-fix.patch
-dvb-dst-fix-symbol-rate-setting.patch
-dvb-dst-remove-unnecessary-code.patch
-dvb-dst-dprrintk-cleanup.patch
-dvb-dst-dprrintk-cleanup-gcc-29x-fix.patch
-dvb-dst-dprrintk-cleanup-gcc-295-fix.patch
-dvb-dst-identify-boards.patch
-dvb-dst-fix-dvb-c-tuning.patch
-dvb-dst-ci-doc-update.patch
-dvb-dst-updated-documentation.patch
-dvb-cinergyt2-remote-control-fixes.patch
-dvb-av7110-siemens-dvb-c-analog-video-input-support.patch
-dvb-budget-ci-add-support-for-tt-dvb-c-ci-card.patch
-dvb-budget-av-fixes-for-ci-interface.patch
-dvb-budget-av-enable-frontend-on-knc1-plus-cards.patch
-dvb-av7110-disable-superflous-firmware-handshake.patch
-dvb-av7110-conditionally-disable-workaround-for-broken-firmware.patch
-dvb-ttpci-av7110-rc5-remote-control-support.patch
-dvb-ttpci-add-pci-ids-for-old-siemens-tt-dvb-c-card.patch
-dvb-saa7146-i2c-vs-sysfs-fix.patch
-dvb-ttusb-budget-use-time_after_eq.patch
-pcmcia-reduce-dsc-stack-footprint.patch
-yenta-share-code-with-pci-core.patch
-pcmcia-cs-fix-possible-missed-wakeup.patch
-fix-pcmcia_request_irq-for-multifunction-card.patch
-pcmcia-yenta-avoid-pci-write-posting-problem.patch
-pcmcia-remove-unused-client_t.patch
-pcmcia-remove-unused-vpp1-vpp2-and-vcc.patch
-pcmcia-omap-cf-controller.patch
-pcmcia-more-ids-for-ide_cs.patch
-pcmcia-add-pcmcia-to-irq-information.patch
-spinlock-consolidation.patch
-mips-build-fix-for-spinlock-consolidation.patch
-spinlock-consolidation-ia64-fix.patch
-spinlock-consolidation-sparc64-fix.patch
-numa-aware-slab-allocator-v5.patch
-sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch
-sched-idlest-cpus_allowed-aware.patch
-sched-cleanups.patch
-sched-task_noninteractive.patch
-sched-fix-smt-scheduler-latency-bug.patch
-sched-less-newidle-locking.patch
-sched-less-locking.patch
-sched-ht-optimisation.patch
-sched-use-cached-variable-in-sys_sched_yield.patch
-sched-dont-kick-alb-in-the-presence-of-pinned-task.patch
-sched-allow-the-load-to-grow-upto-its-cpu_power.patch
-video_bt848-remove-not-required-part-of-the-help-text.patch
-v4l-common-part-updates-and-tuner-additions.patch
-v4l-common-part-updates-and-tuner-additions-gcc-29x-fix.patch
-v4l-bttv-updates-and-card-additions.patch
-v4l-bttv-updates-and-card-additions-fix.patch
-v4l-cx88-updates-and-card-additions.patch
-v4l-cx88-updates-and-card-additions-gcc-295-fix.patch
-v4l-saa7134-updates-and-board-additions.patch
-v4l-changes-the-prefix-of-msp34xx-and-error-while.patch
-v4l-syncs-tveeprom-tuners-list-with-the-list-from.patch
-v4l-correct-lg-ntsc-taln-mini-tuner-takeover.patch
-v4l-add-saa713x-card-65-kworld-v-stream-studio-tv-terminator.patch
-v4l-add-saa713x-card-66-yuan-tun-900-saa7135.patch
-v4l-cx88-dvb-incorrectly-reporting-fixed-and.patch
-v4l-normalize-whitespace-and-comments-in-tuner.patch
-v4l-change-lg-tdvs-h062f-from-ntsc-to-atsc.patch
-v4l-some-error-treatment-implemented-at-resume.patch
-v4l-the-microtune-4049fm5-uses-an-if-frequency-of.patch
-v4l-include-linux-configh-no-longer-needed.patch
-v4l-correct-the-amux-for-composite-and-s-video.patch
-v4l-print-warning-if-pal=-or-secam=-argument-is.patch
-v4l-added-some-missing-parameter-descriptions-at.patch
-v4l-makes-the-input-event-device-for-ir-matchable.patch
-v4l-include-saa6588-compiler-option-and-files.patch
-v4l-removed-kernel-version-dependency-from.patch
-v4l-tvaudio-cleanup-and-better-degug-messages.patch
-v4l-tvaudio-cleanup-and-better-degug-messages-gcc-29c-fix.patch
-v4l-tveeprom-improved-to-support-newer-hauppage-cards.patch
-v4l-tveeprom-improved-to-support-newer-hauppage-cards-gcc-29x-fix.patch
-files-fix-rcu-initializers.patch
-files-rcuref-apis.patch
-files-break-up-files-struct.patch
-files-sparc64-fix-2.patch
-files-files-struct-with-rcu.patch
-files-lock-free-fd-look-up.patch
-files-files-locking-doc.patch
-v9fs-documentation-makefiles-configuration.patch
-v9fs-documentation-makefiles-configuration-add-fd-based-transport-to-makefile-docs.patch
-v9fs-documentation-makefiles-configuration-fix-plan9port-example-in-v9fs.patch
-v9fs-vfs-file-dentry-and-directory-operations.patch
-v9fs-vfs-inode-operations.patch
-v9fs-vfs-inode-operations-adjust-follow_link-and-put_link-to.patch
-v9fs-vfs-superblock-operations-and-glue.patch
-v9fs-vfs-superblock-operations-and-glue-add-fd-based-transport-to-mount-options.patch
-v9fs-9p-protocol-implementation.patch
-v9fs-9p-protocol-implementation-use-standard-kernel-byteswapping.patch
-v9fs-9p-protocol-implementation-remove-sparse-bitwise-warnings.patch
-v9fs-transport-modules.patch
-v9fs-transport-modules-add-fd-based-transport-module.patch
-v9fs-transport-modules-fix-a-problem-with-named-pipe-transport.patch
-v9fs-transport-modules-cleanup-fd-transport.patch
-v9fs-support-to-force-umount.patch
-v9fs-debug-and-support-routines.patch
-v9fs-change-error-magic-numbers-to-defined-constants.patch
-v9fs-clean-up-vfs_inode-and-setattr-functions.patch
-v9fs-fix-support-for-special-files-devices-named-pipes-etc.patch
-v9fs-readlink-extended-mode-check.patch
-v9fs-fix-handling-of-malformed-9p-messages.patch
-fbdev-add-fbset-a-support.patch
-vesafb-add-blanking-support.patch
-fbdev-prevent-drivers-that-have-hardware-cursors-from-calling-software-cursor-code.patch
-fbdev-geode-updates.patch
-fbdev-geode-updates-fix.patch
-fbdev-resurrect-hooks-to-get-edid-from-firmware.patch
-fbdev-resurrect-hooks-to-get-edid-from-firmware-fix.patch
-savagefb-driver-updates.patch
-nvidiafb-fallback-to-firmware-edid.patch
-fbdev-fix-greater-than-1-bit-monochrome-color-handling.patch
-fbcon-saner-16-color-to-4-color-conversion.patch
-console-fix-buffer-copy-on-vc-resize.patch
-atyfb-remove-code-that-sets-sync-polarity-unconditionally.patch
-radeonfb_old-fix-broken-link.patch
-matroxfb-read-mga-pins-data-on-powerpc.patch
-sisfb-update.patch
-sisfb-update-resurrect-makefile.patch
-sisfb-update-makefile.patch
-better-error-handing-in-savagefb_probe.patch
-framebuffer-new-driver-for-cyberblade-i1-graphics.patch
-framebuffer-bit_putcs-optimization-for-8x.patch
-radeonfb-only-request-resources-we-need.patch
-fbdev-add-vesa-coordinated-video-timings-cvt-support.patch
-nvidiafb-use-cvt-to-get-mode-for-digital-displays.patch
-savagefb-make-mode_option-available-when-compiled-as.patch
-fbcon-stop-cursor-timer-if-console-is-inactive.patch
-nvidiafb-fixed-mirrored-characters-in-big-endian-machines.patch
-fbdev-initialize-var-structure-in-calc_mode_timings.patch
-pxafb-add-hsync-time-reporting-hook.patch
-fbcon-break-up-bit_putcs-into-its-component-functions.patch
-fbcon-break-up-bit_putcs-into-its-component-functions-fix.patch
-i810fb-add-i2c-ddc-support.patch
-i810fb-add-i2c-ddc-support-fix.patch
-i810fb-add-i2c-ddc-support-fix-fix.patch
-i810fb-add-i2c-ddc-support-Makefile-fix.patch
-i810fb-stop-lcd-displays-from-flickering.patch
-quiet-non-x86-option-rom-warnings.patch
-s3c2410fb-arm-s3c2410-framebuffer-driver.patch
-s3c2410fb-platform-support-for-arm-s3c2410-framebuffer.patch
-md-fix-minor-error-in-raid10-read-balancing-calculation.patch
-md-fail-io-request-to-md-that-require-a-barrier.patch
-# wait:
-md-fix-rh_dec-rh_inc-race-in-dm-raid1c.patch
-md-dont-allow-new-md-bitmap-file-to-be-set-if-one-already-exists.patch
-md-improve-handling-of-bitmap-initialisation.patch
-md-all-hot-add-and-hot-remove-of-md-intent-logging-bitmaps.patch
-md-support-write-mostly-device-in-raid1.patch
-md-add-write-behind-support-for-md-raid1.patch
-md-support-md-linear-array-with-components-greater-than-2-terabytes.patch
-md-raid1_quiesce-is-back-to-front-fix-it.patch
-md-make-sure-bitmap_daemon_work-actually-does-work.patch
-md-do-not-set-mddev-bitmap-until-bitmap-is-fully-initialised.patch
-md-allow-hot-adding-devices-to-arrays-with-non-persistant-superblocks.patch
-md-allow-md-to-load-a-superblock-with-feature-bit-1-set.patch
-md-fix-bitmap-read_sb_page-so-that-it-handles-errors-properly.patch
-md-remove-old-cruft-from-md_kh-header-file.patch
-md-limit-size-of-sb-read-written-to-appropriate-amount.patch
-md-add-write-intent-bitmap-support-to-raid5.patch
-md-write-intent-bitmap-support-for-raid6.patch
-md-use-kthread-infrastructure-in-md.patch
-md-ensure-bitmap_writeback_daemon-handles-shutdown-properly.patch
-md-tidy-up-daemon-stop-start-code-in-md-bitmapc.patch
-drivers-md-raid1c-make-a-function-static.patch
-md-choose-better-default-offset-for-bitmap.patch
-md-use-queue_hardsect_size-instead-of-block_size-for-md-superblock-size-calc.patch
-md-add-information-about-superblock-version-to-proc-mdstat.patch
-md-report-spare-drives-in-proc-mdstat.patch
-md-make-sure-the-new-sb_size-is-set-properly-device-added-without-pre-existing-superblock.patch
-md-really-get-sb_size-setting-right-in-all-cases.patch
-md-fix-raid10-assembly-when-too-many-devices-are-missing.patch
-md-fix-bug-when-raid10-rebuilds-without-enough-drives.patch
-update-documentation-docbook-kernel-hackingtmpl.patch
-documentation-how-to-apply-patches-for-various-trees.patch
-documentation-how-to-apply-patches-for-various-tree-fix.patch
-isa-dma-api-documentation.patch
-docs-fix-misinformation-about.patch
-update-kfree-vfree-and-vunmap-kerneldoc.patch
-docbook-fix-kernel-api-documentation-generation.patch
-kdump-documentation-update.patch
-vfs-update-documentation.patch
-documentation-sparse-snapshot-url.patch
-fuse-maintainers-kconfig-and-makefile-changes.patch
-fuse-core.patch
-fuse-device-functions.patch
-fuse-device-functions-document-mount-options.patch
-fuse-device-functions-document-mount-options-documentation-update.patch
-fuse-device-functions-request-counter-overflow-fix.patch
-fuse-device-functions-module-alias.patch
-fuse-read-only-operations.patch
-fuse-read-only-operations-follow_link-fix.patch
-fuse-read-write-operations.patch
-fuse-file-operations.patch
-fuse-mount-options.patch
-fuse-extended-attribute-operations.patch
-fuse-add-padding.patch
-fuse-readpages-operation.patch
-fuse-tighten-check-for-processes-allowed-access.patch
-fuse-stricter-mount-option-checking.patch
-fuse-direct-i-o.patch
-fuse-direct-i-o-cleanup.patch
-fuse-transfer-readdir-data-through-device.patch
-fuse-more-flexible-caching.patch
-fuse-dont-update-file-times.patch
-fuse-add-fsync-operation-for-directories.patch
-fuse-dont-allow-restarting-of-system-calls.patch
-timer-initialization-cleanup-define_timer.patch
-more-spin_lock_unlocked-define_spinlock-conversions.patch
-mm-filemapc-make-two-functions-static.patch
-mm-filemapc-make-sync_page_range_nolock-static.patch
-mm-filemapc-make-generic_file_direct_io-static.patch
-applicom-fix-error-handling.patch
-drivers-char-lcdc-misc_register-can-fail.patch
-hdpu_cpustate-misc_register-can-fail.patch
-sb16_csp-remove-home-grown-le_to_cpu-macros.patch
-sb16_csp-untypedef.patch
-mm-slab-fix-sparse-warnings.patch
-char-n_tty-fix-sparse-warnings-__nocast-type.patch
-kernel-acct-add-kerneldoc.patch
-ppc-c99-initializers-for-hw_interrupt_type-structures.patch
-sh-c99-initializers-for-hw_interrupt_type-structures.patch
-v850-c99-initializers-for-hw_interrupt_type-structures.patch
-sh64-c99-initializers-for-hw_interrupt_type-structures.patch
-add-kerneldoc-reference-to-codingstyle.patch
-mm-swap_state-fix-nocast-type-warnings.patch
-spelling-fixes-for-documentation.patch
-lib-radix-tree-fix-nocast-type-warnings.patch
-dmapool-fix-nocast-type-warnings.patch
-telephony-ixj-use-msleep-instead-of-schedule_timeout.patch
-i386-smpboot-use-msleep-instead-of-schedule_timeout.patch
-update-fsf-address-in-copying.patch
-fix-unusual-placement-of-inline-keyword-in-hpet.patch
-vfree-and-kfree-cleanup-in-drivers.patch
-merge-some-from-rustys-trivial-patches.patch
-include-asm-arm26-hardirqh-remove-define-irq_enter.patch
-remove-sound-oss-skeletonc.patch
-drivers-char-lpc-use-of-the-time_after-macro.patch
-spelling-and-whitespace-fixes-for-reporting-bugs.patch
-remove-invalid-comment-in-mm-page_allocc.patch
-lib-sortc-small-cleanups.patch
-janitor-ide-min-max-macros-in-ide-timingh.patch
-janitor-net-ppp-generic-list_for_each_entry.patch
-janitor-jffs-intrep-list_for_each_entry.patch
-janitor-fs-namespacec-list_for_each_entry.patch
-janitor-fs-dcachec-list_for_each.patch
-janitor-ide-tape-replace-schedule_timeout-with-msleep.patch
-janitor-block-umem-replace-printk-with-pr_debug.patch
-janitor-tulip-de4x5-list_for_each.patch
-janitor-sh-bigsur-io-minmax-removal.patch
-janitor-sh-hd64465-minmax-removal.patch
-janitor-block-xd-replace-schedule_timeout-with-msleep-msleep_interruptible.patch
-janitor-ide-ide-cs-replace-schedule_timeout-with-msleep.patch
-janitor-reiserfs-superc-vfree-checking-cleanups.patch
-include-asm-i386-extern-inline-static-inline.patch
-include-linux-blkdevh-extern-inline-static-inline.patch
-extern-inline-static-inline.patch
-include-linux-bioh-extern-inline-static-inline.patch
-remove-acpi-s4bios-support.patch
-fs-cramfs-uncompressc-should-include-linux-cramfs_fsh.patch
-i386-x86_64-make-get_cpu_vendor-static.patch
-schedule_timeout_uninterruptible.patch
-include-update-jiffies-musecs-conversion-functions.patch
-timeh-remove-ifdefs.patch
-fs-fix-up-schedule_timeout-usage.patch
-kernel-fix-up-schedule_timeout-usage.patch
-mm-fix-up-schedule_timeout-usage.patch
-alpha-fix-up-schedule_timeout-usage.patch
-i386-fix-up-schedule_timeout-usage.patch
-mips-fix-up-schedule_timeout-usage.patch
-drivers-block-fix-up-schedule_timeout-usage.patch
-drivers-cdrom-fix-up-schedule_timeout-usage.patch
-drivers-cdrom-fix-up-schedule_timeout-usage-fix.patch
-drivers-char-fix-up-schedule_timeout-usage.patch
-drivers-dlm-fix-up-schedule_timeout-usage.patch
-parport-fix-up-schedule_timeout-usage.patch
-parport-fix-up-schedule_timeout-usage-fix.patch
-telephony-fix-up-schedule_timeout-usage.patch
-drivers-usb-fix-up-schedule_timeout-usage-fix.patch

 Merged

+fbdev-kconfig-fix.patch

 fbdev fix

+set-ibm-thinkpad-extras-to-default-n-in-kconfig.patch
+dont-set-dcdbas-driver-to-default-m.patch
+pnpacpi-only-parse-device-that-have-crs-method.patch
+pnpacpi-clean-blacklist.patch

 acpi fixes

+atiixp_modem-printk-fixes.patch

 Fix some printks

-gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch
-gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix.patch

 Dropped

+gregkh-driver-firmware_documenation.patch
+gregkh-driver-aoe-01.patch
+gregkh-driver-aoe-02.patch

 Greg's driver tree

+gregkh-i2c-hdaps.patch
+gregkh-i2c-i2c-nforce-drop-define.patch
+gregkh-i2c-hwmon-w83627hf.patch
+gregkh-i2c-hwmon-smsc47m1.patch
+gregkh-i2c-hwmon-force_addr-fix.patch

 Greg's i2c tree

+i2c-keywest-warning-fix.patch

 warning fix

+git-ia64-fixup.patch

 Fix reject in  git-ia64.patch

-sata_sisc-introducing-device-id-0x182.patch

 Dropped

+netlink-connector.patch

 The netlink connector again (wrong version thereof)

+git-ocfs2-prep.patch

 Make git-ocfs2.patch apply.

-arch-pci_find_device-remove-sparc64-kernel-ebusc-fix.patch

 Folded into arch-pci_find_device-remove-sparc64-kernel-ebusc.patch

+pci-block-config-access-during-bist-fix-43.patch
+pci-block-config-access-during-bist-resend.patch

 Fix pci-block-config-access-during-bist.patch

+fix-buffer-overrun-in-rpadlpar_sysfsc.patch

 driver sysfs fix

+megaraid-mode_sense-fix.patch

 Megaraid fix

+scsi-sas-makefile-and-kconfig.patch
+sas_class-include-files-in-include-scsi-sas.patch
+sas-class-core-files.patch
+aic94xx-the-aic94xx-sas-lldd.patch

 Serial Attached SCSI driver and infrastructure.  Doesn't compile under
 gcc-2.95.x, will probably drop this after it's had a couple of -mm testing
 cycles.

+apple-usb-touchpad-driver-2.patch

 This is back again

+x86_64-gcc4-unzip-warnings.patch
+x86_64-cfi.patch
+x86_64-suspend-include.patch
+x86_64-msr-merge.patch
+x86_64-oops-irq.patch
+x86_64-init-rsp.patch
+x86_64-remove-vxtime-hz.patch
+x86_64-nmi-vector.patch
+x86_64-cmpxchg-constraints.patch
+x86_64-nmi-newline.patch
+x86_64-i387-sig.patch
+x86_64-include-irq.patch
+x86_64-allow-framepointer.patch
+x86_64-dmi-warning.patch
+x86_64-smaller-bug.patch
+x86_64-srat-early-cutoff.patch
+x86_64-srat-cleanup.patch
+x86_64-srat-conflict.patch
+x86_64-local-add-fix.patch

 x86_64 updates

+x86_64-dma32-srat-fix.patch

 Fix it.

+vm-kswapd-cleanup-use-pgdat.patch

 VM cleanup

+mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch
+mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk-fix.patch
+mm-page_alloc-increase-size-of-per-cpu-pages.patch
+mm-set-per-cpu-pages-lower-threshold-to-zero.patch

 Page allocator tuning

+mm-move_pte-to-remap-zero_page.patch

 mm cleanup

+fix-mpol_f_verify.patch
+convert-mempolicies-to-nodemask_t.patch
+remove-near-all-bugs-in-mm-mempolicyc.patch

 NUMA memory allocator fixes

+memory-hotplug-i386-addition-functions-highmem-fix.patch

 Fix memory-hotplug-i386-addition-functions-warning-fix.patch

+3c59xc-cleanup-mdio_read-routines.patch
+3c59x-avoid-blindly-reading-link-status-twice.patch
+s2io-warning-fixes.patch
+pcnet32-set-min-ring-size-to-4.patch

 Net driver updates

+acx-update.patch

 Updates to the TI ACX1xx wireless network driver

+ppc32-discard-exittext-and-exitdata-sections.patch
+ppc32-remove-use-of-asm-segmenth.patch

 ppc32 updates

+i386-kill-off-config_pc.patch
+x86-cmpxchg-improvements.patch
+i386-dont-miss-pending-signals-returning-to-user-mode-after-signal-processing.patch

 x86 updates

-i386-transparent-paravirtualization-sub-arch-move-msr-accessors-into-the-sub-arch-layer.patch
-i386-transparent-paravirtualization-sub-arch-move-privileged-processor-operations-to-the-subarch-layer.patch
-i386-transparent-paravirtualization-sub-arch-move-sensitive-system-definitions-into-the-sub-arch-layer.patch
-i386-transparent-paravirtualization-sub-arch-move-tlb-flush-definitions-to-the-sub-architecture-level.patch
-i386-transparent-paravirtualization-sub-arch-move-descriptor-table-management-into-the-sub-arch-layer.patch
-i386-transparent-paravirtualization-sub-arch-move-sensitive-i-o-instructions-into-the-sub-arch-layer.patch
-i386-transparent-paravirtualization-sub-arch-create-accessors-that-allow-the-i386-kernel-to-run-at.patch
-i386-transparent-paravirtualization-sub-arch-create-mmu-2-3-level-accessors-in-the-sub-arch-layer.patch
-i386--make-write-ldt-return-error-code.patch
-i386--remove-ugly-tls-code.patch
-i386--remove-unnecessary-tls-init.patch
-i386--clean-up-asm-and-volatile-keywords-in-desc.patch
-i386--use-early-clobber-to-eliminate-rotate-in-desc.patch
-i386--add-some-segment-convenience-functions.patch
-i386--add-some-descriptor-convenience-functions.patch
-i386--add-a-per-cpu-gdt-accessor.patch
-i386--typecheck-and-optimize-base-and-limit-accessors.patch
-i386--typecheck-and-optimize-base-and-limit-accessors-fix.patch
-i386--typecheck-and-optimize-base-and-limit-accessors-fix-tidy.patch
-i386--move-descriptor-accessors-into-desc-h.patch
-i386--eliminate-yet-another-redundant-accessor.patch
-i386--move-context-switch-inline.patch
-i386--introduce-hypervisor-ldt-hooks.patch
-i386--introduce-hypervisor-lazy-pinning-hooks.patch
-i386-virtualization-fix-uml-build.patch
-i386-virtualization-remove-some-dead-debugging-code.patch
-i386-virtualization-make-ldt-a-desc-struct.patch
-i386-virtualization-ldt-kprobes-bugfix.patch
-i386-virtualization-make-generic-set-wrprotect-a-macro.patch
-i386-virtualization-attempt-to-clean-up-pgtable-code-motion.patch
-i386-fix-desc-empty.patch

 Dropped.  I'll be picking these up via the git-virt tree (Chris Wright)
 soon.  Right now the tree doesn't come out right due to git-related woes.

-x86-64-ptrace-ia32-bp-fix.patch

 Dropped. Makes 32-bit apps crash.

-pselect-ppoll-system-calls.patch

 Dropped - needs work

+free-initrd-mem-adjustment.patch
+free-initrd-mem-adjustment-fix.patch

 Boot-time fix

+fix-sys_poll-large-timeout-handling.patch

 Fix poll() timeout thresholding

+make-build_bug_on-fail-at-compile-time.patch

 Make BUILD_BUG_ON() fail at compile time

+set_current_state-commentary.patch

 Add comments to set_current_state()

+schedule_timeout_interruptible-speedup.patch

 Speed up schedule_timeout_[un]interruptible()

+remove-unnecessary-check_region-references-in-comments.patch

 check_region() cleanup

+use-add_taint-for-setting-tainted-bit-flags.patch

 cleanup

+reiserfs_file_write-should-mark-inodes-dirty.patch

 reiserfs3 fix

+as-cooperating-processes.patch
+as-cooperating-processes-cant-spel.patch
+as-tidy.patch

 ANticipatory scheduler work

+cciss-new-controller-pci-subsystem-ids.patch
+cciss-busy_initializing-flag.patch
+cciss-new-disk-register-deregister-routines.patch
+cciss-direct-lookup-for-command-completions.patch
+cciss-bug-fix-in-cciss_remove_one.patch
+cciss-fix-for-dma-brokeness.patch
+cciss-one-button-disaster-recovery-support.patch
+cciss-scsi-tape-info-for-proc.patch

 CCISS update

+parport-constification-fix.patch

 Fix parport-constification.patch

+fix-bogus-bug_on-in-pktcdvd.patch
+pktcdvd-documentation-update.patch
+pktcdvd-more-accurate-i-o-accounting.patch
+use-kcalloc-and-kzalloc-in-pktcdvd.patch
+pktcdvd-bug_on-cleanups.patch

 Packet driver updates

-ipmi-convert-driver-over-to-use-refcounts.patch

 Dropped - needs work

+sharpsl-add-an-input-keyboard-driver-for-zaurus.patch

 Zaurus update

-rapidio-support-net-driver-fixes.patch

 Folded into rapidio-support-net-driver.patch

+drivers-dlm-fix-up-schedule_timeout-usage.patch

 dlm cleanup

+nfsd4-printk-reduction.patch
+nfsd4-move-replay_owner.patch
+nfsd4-fix-open-seqid-incrementing-in-lock.patch
+nfsd4-fix-setclientid-unlock-of-unlocked-state-lock.patch
+code-cleanups-in-calbacks-in-svcsock.patch

 NFS server updates

-debug-preempt-tracing.patch
-debug-preempt-tracing-fix.patch
-debug-preempt-tracing-fix-2.patch
-debug-preempt-tracing-fix-3.patch

 Dropped - it breaks ppc64.   Still working out why this started happening.

-ingo-nfs-stuff-fix.patch

 Folded into ingo-nfs-stuff.patch

-make-kmalloc-fail-for-swapped-size--gfp-flags-fix.patch
-make-kmalloc-fail-for-swapped-size--gfp-flags-aic-fix.patch
-s390-fix-invalid-kmalloc-flags.patch
-fix-invalid-kmalloc-flags-gfp_dma-alone.patch

 Folded into make-kmalloc-fail-for-swapped-size--gfp-flags.patch

+page-owner-tracking-leak-detector-fix.patch

 Fix page-owner-tracking-leak-detector.patch

-perfctr.patch
-fix-pm_message_t-stuff-in-mm-tree-perfctr.patch

 Dropped

-sched-add-cacheflush-asm.patch
-scheduler-cache-hot-autodetect.patch

 Dropped again - breaks NUMAQ

+v4l-experimental-sliced-vbi-api-support.patch
+v4l-fixup-on-cx88_dvb-for-dvico-hdtv5-gold.patch

 v4l updates

+sis5513-support-sis-965l.patch
+ide-fix-null-request-pointer-for-taskfile-ioctl.patch

 IDE fixes

+minor-fbcon_scroll-adjustment.patch
+fbcon-constify-font-data.patch
+matroxfb-adjustments.patch

 fbdev updates

+doc-update-oops-tracingtxt-tainted-flags.patch
+tell-people-not-to-use-pm_register.patch
+documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch
+documentation-ioctl-messtxt-add-260-more-ioctls.patch

 Documentation updates

+drivers-net-wan-replace-custom-macro-with-isdigit-isxdigit.patch

 cleanup

-net-fix-up-schedule_timeout-usage-fix.patch
-net-fix-up-schedule_timeout-usage-fix-2.patch

 Folded into net-fix-up-schedule_timeout-usage.patch

+arch-i386-replace-custom-macro-with-isdigit.patch
+drivers-video-replace-custom-macro-with-isdigit.patch
+jbd-remove-duplicated-debug-print.patch
+feature-removal-of-io_remap_page_range.patch

 Little fixes

+tty-layer-buffering-revamp-s390-fixes.patch
+moxa-intellio.patch
+tty-layer-buffering-revamp-speakup-fix.patch
+tty-layer-buffering-revamp-mkiss-update-re-introduced-defunct-receive_room-function.patch
+clean-up-computone-remaining-cli-use.patch

 tty fixes




All 473 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm3/patch-list


