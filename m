Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270987AbUJVKZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbUJVKZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271013AbUJVKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:25:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:54211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270987AbUJVKWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:22:35 -0400
Date: Fri, 22 Oct 2004 03:20:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1
Message-Id: <20041022032039.730eb226.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/

- Lots of new patches.

- Status of as-yet-unmerged things:

  - sysfs backing store: after six months, still under discussion.

  - ext3 reservations code: it was ready to go, but then I got a bunch
    more patches.  Lots of testing is needed here to make 2.6.10.

  - ext3 resize code: ready to go, but it depends on the reservation code
    so I may end up swizzling the patch series.

  - kexec and crashdump: this all allegedly works, but I want to *see* it
    work first.

  - perfctr: mikpe is still working on this.

  - preempt-smp and all the associated low-latency fixes: I haven't really
    thought about it and haven't looked at the patches yet.  Hopefully 2.6.10
    material.

  - cachefs: probably 2.6.10 material, but I'd like to be convinced that
    we actually need this in the kernel.  Not many people use AFS (sorry) and
    it's a ton of new code.  Getting it working for NFS would be a winner.

  - cpusets: ready to go, but the current plan is to rework the actual
    pinning mechanism to use scheduler domains rather than cpus_allowed, then
    to look at wiring it up via the CKRM interface.  So I'm sitting on this.

  - reiser4: not sure, really.  The namespace extensions were disabled,
    although all the code for that is still present.  Linus's filesystem
    criterion used to be "once lots of people are using it, preferably when
    vendors are shipping it".  That's a bit of a chicken and egg thing though.
    Needs more discussion.

  - md updates: these are blocked by a minor bunfight over one of Neil's
    procfs innovations.  He's reworking the patches so we can defer that
    decision.



Changes since 2.6.9-rc4-mm1:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-driver-core.patch
 bk-drm-via.patch
 bk-ia64.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-kbuild.patch
 bk-netdev.patch
 bk-pci.patch
 bk-pnp.patch
 bk-usb.patch

 External trees (from this morning - bkbits.net is sick)

-parport_pc-superio-chip-fixes.patch
-fix-oops-in-parkbd.patch
-psmouse-build-fix.patch
-atkbd-warning-fixes.patch
-via-agp-pci-build-fix.patch
-swsusp-progress-in-percent.patch
-acpi-proc-simplify-error-handling.patch
-i2c-bus-power-management-support.patch
-entry-s-cleanups.patch
-make-rlimit-settings-per-process-instead-of-per-thread.patch
-add-wcontinued-support-to-wait4-syscall.patch
-fix-ptrace_attach-race-with-real-parents-wait-calls-2.patch
-softirqs-fix-latency-of-softirq-processing.patch
-softirqs-fix-latency-of-softirq-processing-fix.patch
-add-missing-linux-syscallsh-includes.patch
-add-missing-linux-syscallsh-includes-fix.patch
-distinct-tgid-tid-cpu-usage.patch
-show-aggregate-per-process-counters-in-proc-pid-stat-2.patch
-exec-fix-posix-timers-leak-and-pending-signal-loss.patch
-__set_page_dirty_nobuffers-mappings.patch
-reiserfs-small-filesystem-fix.patch
-generic-irq-subsystem-core.patch
-prof-irq-mask-fixup.patch
-setup_irq-warning-fixes.patch
-generic-irq-subsystem-x86-port.patch
-uninline-ack_bad_irq.patch
-irq_mis_count-build-fix.patch
-generic-irq-subsystem-x64-port.patch
-generic-irq-subsystem-ppc-port.patch
-generic-irq-subsystem-ppc64-port.patch
-doc-remove-references-to-hardirqc.patch
-invalidate-page-race-fix.patch
-ppc32-xilinx-ml300-board-support.patch
-ppc32-use-gen550-for-ppc44x-progress-ppc-stub.patch
-ppc32-add-gen550h.patch
-ppc32-configure-ppc440gx-l2-cache-based-on-cpu-rev.patch
-ppc32-fix-cpu-voltage-change-delay.patch
-share-i386-x86_64-intel-cache-descriptors-table.patch
-fix-show_trace-in-irq-context-with-config_4kstacks.patch
-disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-2.patch
-drop-old-apic-workaround-on-x86-64.patch
-intialize-hpet-char-driver-on-x86-64.patch
-hpet-dependency-fix.patch
-use-tsc-on-smp-em64t-machines.patch
-add-notsc-option-to-x86-64.patch
-add-an-option-to-configure-oops-stack-dump-on-x86-64.patch
-fix-ioapic-on-nvidia-boards.patch
-x86-64-optimize-numa-lookup.patch
-x86_64-kconfig-split-config_numa_emu-and-config_k8_numa.patch
-swsusp-fix-x86-64-do-not-use-memory-in-copy-loop.patch
-swsusp-fix-process-start-times-after-resume.patch
-swsusp-add-comments-at-critical-places.patch
-swsusp-documentation-update.patch
-additional-documentation-for-power-management.patch
-s3-suspend-resume-with-noexec-2.patch
-m32r-ds1302-driver.patch
-m32r-new-cf-pcmcia-driver-for-m32r.patch
-m32r-update-include-asm-m32r-m32102h.patch
-m32r-ar-camera-driver.patch
-m32r-ar-camera-driver-build-fix.patch
-m32r-sio-driver.patch
-uml-dont-declare-cpu_online-fix-compilation-error.patch
-s390-7-12-zfcp-host-adapter.patch
-s390-8-12-qeth-layer-2-support.patch
-s390-9-12-z-vm-watchdog-timer.patch
-s390-10-12-z-vm-log-reader.patch
-s390-11-12-crypto-device-driver.patch
-s390-12-12-add-support-to-read-z-vm-monitor-records.patch
-reiserfs-cleanup-internal-use-of-bh-macros.patch
-reiserfs-cleanup-access-of-journal-cosmetic.patch
-reiserfs-add-i-o-error-handling-to-journal-operations.patch
-reiserfs-fix-several-missing-reiserfs_write_unlock-calls.patch
-i-o-error-handling-for-reiserfs-v3-fixes.patch
-xtime-value-may-become-incorrect.patch
-sched-trivial-sched-changes.patch
-sched-add-cpu_down_prepare-notifier.patch
-sched-integrate-cpu-hotplug-and-sched-domains.patch
-sched-arch_destroy_sched_domains-warning-fix.patch
-sched-sched-add-load-balance-flag.patch
-sched-sched-add-load-balance-flag-fix.patch
-sched-remove-disjoint-numa-domains-setup.patch
-sched-make-domain-setup-overridable.patch
-sched-make-domain-setup-overridable-rename.patch
-sched-make-domain-setup-overridable-fix.patch
-sched-ia64-add-disjoint-numa-domain-support.patch
-ia64-non-numa-build-fix.patch
-ia64-sched_domains-warning-fixes.patch
-sched-fix-domain-debug-for-isolcpus.patch
-sched-enable-sd_load_balance.patch
-sched-hotplug-add-a-cpu_down_failed-notifier.patch
-sched-use-cpu_down_failed-notifier.patch
-sched-fixes-for-ia64-domain-setup.patch
-sched-print-preempt-count.patch
-cpu-scheduler-fix-potential-error-in-runqueue-nr_uninterruptible-count.patch
-sched_domains-make-sd_node_init-per-arch-2.patch
-sched-remove-node_balance_rate-definitions.patch
-sched-fix-sched_smt-numa=fake=2-lockup.patch
-sched-fix-sched_smt-numa=fake=2-lockup-fix.patch
-dvdrw-support-for-267-bk13.patch
-packet-writing-credits.patch
-cdrw-packet-writing-support-for-267-bk13.patch
-packet-bio-init.patch
-dvd-rw-packet-writing-update.patch
-packet-writing-docco.patch
-control-pktcdvd-with-an-auxiliary-character-device.patch
-packet-private-data.patch
-simplified-request-size-handling-in-cdrw-packet-writing.patch
-fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
-packet-writing-reporting-fix.patch
-speed-up-the-cdrw-packet-writing-driver.patch
-packet-writing-avoid-bio-hackery.patch
-packet-open-comment.patch
-cdrom-buffer-size-fix.patch
-create-nodemask_t.patch
-reiserfs-rename-struct-key.patch
-add-some-key-management-specific-error-codes.patch
-keys-new-error-codes-for-alpha-mips-pa-risc-sparc-sparc64.patch
-implement-in-kernel-keys-keyring-management.patch
-return-a-different-error-if-unavailable-keytype-is-used.patch
-link-user-keyrings-together-correctly.patch
-make-key-management-code-use-new-the-error-codes.patch
-keys-permission-fix.patch
-#keys-keyring-management-keyfs-patch.patch
-#keyfs-build-fix.patch
-implement-in-kernel-keys-keyring-management-afs-workaround.patch
-support-supplementary-information-for-request-key.patch
-make-key-management-use-syscalls-not-prctls.patch
-move-syscall-declarations-from-linux-keyh-2.patch
-bits-to-make-the-key-management-api-more-usable.patch
-make-key-management-use-syscalls-not-prctls-build-fix.patch
-268-rc3-jffs2-unable-to-read-filesystems.patch
-kallsyms-data-size-reduction--lookup-speedup.patch
-tioccons-security.patch
-fix-process-start-times.patch
-fix-comment-in-include-linux-nodemaskh.patch
-move-waitqueue-functions-to-kernel-waitc.patch
-standardize-bit-waiting-data-type.patch
-provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
-consolidate-bit-waiting-code-patterns.patch
-eliminate-bh-waitqueue-hashtable.patch
-eliminate-bh-waitqueue-hashtable-fix.patch
-eliminate-inode-waitqueue-hashtable.patch
-move-wait-ops-contention-case-completely-out-of-line.patch
-reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
-wait_on_bit-must-loop.patch
-document-wake_up_bits-requirement-for-preceding-memory-barriers.patch
-jbd-wakeup-fix.patch
-md-add-interface-for-userspace-monitoring-of-events.patch
-unreachable-code-in-ext3_direct_io.patch
-switchable-and-modular-io-schedulers.patch
-return-einval-on-elevator_store-failure.patch
-switchable-and-modular-io-schedulers-fix.patch
-switchable-and-modular-io-schedulers-hack-fix.patch
-update-cfq-v2-scheduler-patch.patch
-cfq-v2-pin-cfq_data-from-io_context.patch
-convert-jiffies-msecs-for-io-schedulers.patch
-dont-export-blkdev_open-and-def_blk_ops.patch
-remove-dead-code-from-fs-mbcachec.patch
-remove-posix_acl_masq_nfs_mode.patch
-dont-export-shmem_file_setup.patch
-remove-pm_find-unexport-pm_send.patch
-remove-dead-code-and-exports-from-signalc.patch
-unexport-proc_sys_root.patch
-unexport-is_subdir-and-shrink_dcache_anon.patch
-unexport-devfs_mk_symlink.patch
-unexport-do_execve-do_select.patch
-unexport-exit_mm.patch
-unexport-files_lock-and-put_filp.patch
-unexport-f_delown.patch
-unexport-lookup_create.patch
-remove-wake_up_all_sync.patch
-remove-set_fs_root-set_fs_pwd.patch
-generic-acl-support-for-permission.patch
-generic-acl-support-for-permission-fix.patch
-cacheline-align-pagevec-structure.patch
-fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
-fbdev-fix-logo-drawing-failure-for-vga16fb.patch
-fbcon-fix-setup-boot-options-of-fbcon.patch
-fbdev-pass-struct-device-to-class_simple_device_add.patch
-fbdev-add-tile-blitting-support.patch
-fbdev-fix-scrolling-corruption.patch
-radeonfb-fix-warnings-about-uninitialized-variables.patch
-radeonfb-fix-warnings-about-uninitialized-variables-fix.patch
-fbdev-remove-i810fb-explicit-agp-initialization-hack.patch
-fbdev-add-iomem-annotations-to-fbmemc.patch
-fbdev-add-iomem-annotations-to-i810fb.patch
-fbdev-add-iomem-annotations-to-vga16fbc.patch
-vga-console-font-problems-on-26-kernel.patch
-fbcon-unimap-fix.patch
-edid_info-in-zero-page.patch
-fbdev-fix-framebuffer-memory-calculation-for-vesafb.patch
-fbdev-split-vesafb-option-vram-into-vtotal-and-vremap.patch
-remove-big-endian-mode-from-matroxfb.patch
-assorted-matroxfb-fixes.patch
-rework-radeonfb-blanking.patch
-fix-for-spurious-interrupts-on-e100-resume-2.patch
-atomic_inc_return-for-i386.patch
-atomic_inc_return-for-x86_64.patch
-atomic_inc_return-for-arm.patch
-atomic_inc_return-for-arm26.patch
-atomic_inc_return-for-sparc64.patch
-remove-dead-exports-from-fs-fat.patch
-fat-use-hlist_head-for-fat_inode_hashtable-1-6.patch
-fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
-fat-cache-lock-from-per-sb-to-per-inode-3-6.patch
-fat-the-inode-hash-from-per-module-to-per-sb-4-6.patch
-fat-fix-the-race-bitween-fat_free-and-fat_get_cluster.patch
-fat-remove-debug_pr-6-6.patch
-fat-merge-fix.patch
-fat-check-free_clusters-value.patch
-fat-removal-of-c_le_-macro.patch
-fat-remove-validity-check-of-fat-first-entry.patch
-no-exec-i386-and-x86_64-fixes.patch
-rewrite-alloc_pidmap.patch
-pidhashing-retain-older-vendor-copyright.patch
-pidhashing-lower-pid_max_limit-for-32-bit-machines.patch
-pidhashing-enforce-pid_max_limit-in-sysctls.patch
-allow-multiple-inputs-in-alternative_input.patch
-autofs4-allow-map-update-recognition.patch
-lighten-mmlist_lock.patch
-incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi.patch
-fix-task_mmuc-text-size-reporting.patch
-sparc32-add-atomic_sub_and_test.patch
-make-console_conditional_schedule-__sched-and-use-cond_resched.patch
-report-per-process-pagetable-usage.patch
-v4l-msp3400-cleanup.patch
-v4l-tuner-update.patch
-v4l-bttv-update.patch
-v4l-dvb-cx88-driver-update.patch
-v4l-dvb-cx88-driver-update-fix.patch
-DVB-update-saa7146.patch
-DVB-documentation-update.patch
-DVB-skystar2-dvb-bt8xx-update.patch
-DVB-dvb-core-update.patch
-DVB-frontend-conversion.patch
-DVB-frontend-conversion2.patch
-DVB-frontend-conversion3.patch
-DVB-frontend-conversion4.patch
-DVB-add-frontend-1-2.patch
-DVB-add-frontend-2-2.patch
-DVB-new-driver-dibusb.patch
-DVB-misc-driver-updates.patch
-DVB-frontend-updates.patch
-V4L-follow-changes-in-saa7146.patch
-a-simple-fifo-implementation.patch
-replace-hard-coded-modverdir-in-modpost.patch
-gen_init_cpio-uses-external-file-list.patch
-select-cpio_list-or-source-directory-for-initramfs-image.patch
-select-cpio_list-or-source-directory-for-initramfs-image-fix.patch
-remove-mod_inc_use_count-mod_dec_use_count.patch
-mark-inter_module_-deprecated.patch
-dont-include-linux-sysctlh-in-linux-securityh.patch
-cleanup-move-call-to-update_process_times.patch
-cleanup-remove-unused-definitions-from-timexh.patch
-cleanup-timeh-timesh-timexh-and-jiffiesh.patch
-fix-dcache-lookup.patch
-remove-d_bucket.patch
-remove-d_bucket-warning-fix.patch
-document-rcu-based-dcache-lookup.patch
-x86-64-i386-add-mce-tainting.patch
-x86-64-i386-add-mce-tainting-fix-2.patch
-taint-cleanup-mce.patch
-taint-fix-forced-rmmod.patch
-taint-on-bad_page.patch
-smbfs-do-not-honor-uid-gid-file_mode-and-dir_mode-supplied.patch
-simplify-last-lib-idrc-change.patch
-fix-typesh.patch
-xattr-consolidation-v3-generic-xattr-api.patch
-xattr-consolidation-v3-lsm.patch
-xattr-consolidation-v3-ext3.patch
-xattr-consolidation-v3-ext2.patch
-xattr-consolidation-v3-devpts.patch
-xattr-consolidation-v3-tmpfs.patch
-xattr-consolidation-v3-tmpfs-fix.patch
-xattr-reintroduce-sanity-checks-2.patch
-allow-all-filesystems-to-specify-fscreate-mount.patch
-512x-altix-timer-interrupt-livelock-fix-vs-269-rc2-mm2.patch
-sparc32-early-tick_ops.patch
-smc91x-revert-11923358-m32r-modify-drivers-net-smc91xc.patch
-smc91x-assorted-minor-cleanups.patch
-smc91x-set-the-mac-addr-from-the-smc_enable-function.patch
-smc91x-fold-smc_setmulticast-into-smc_set_multicast_list.patch
-smc91x-simplify-register-bank-usage.patch
-smc91x-move-tx-processing-out-of-irq-context-entirely.patch
-smc91x-use-a-work-queue-to-reconfigure-the-phy-from.patch
-smc91x-fix-possible-leak-of-the-skb-waiting-for-mem.patch
-smc91x-display-pertinent-register-values-from-the.patch
-smc91x-straighten-smp-locking.patch
-smc91x-cosmetics.patch
-m32r-trivial-fix-of-smc91xh.patch
-smc91x-fix-smp-lock-usage.patch
-smc91x-more-smp-locking-fixes.patch
-smc91x-fix-compilation-with-dma-on-pxa2xx.patch
-smc91x-receives-two-bytes-too-many.patch
-smc91x-release-on-chip-rx-packet-memory-asap.patch
-i2o-code-beautifying-and-cleanup.patch
-i2o-added-support-for-promise-controllers.patch
-i2o-new-functions-to-convert-messages-to-a-virtual-address.patch
-i2o-correct-error-code-if-bus-is-busy-in-i2o_scsi.patch
-i2o-message-conversion-fix-for-le32_to_cpu-parameters.patch
-janitor-cpqarray-remove-unused-include.patch
-janitor-remove-old-ifdefs-dmascc.patch
-janitor-remove-old-ifdefs-fasttimer.patch
-janitor-list_for_each-drivers-char-drm-radeon_memc.patch
-janitor-char-rio_linux-replace-schedule_timeout-with-msleep-msleep_interruptible.patch
-janitor-char-sis-agp-replace-schedule_timeout-with-msleep.patch
-janitor-char-fdc-io-replace-direct-assignment-with-set_current_state.patch
-janitor-char-ipmi_si_intf-add-set_current_state.patch
-janitor-char-sx-replace-direct-assignment-with-set_current_state.patch
-drivers-char-replace-schedule_timeout-with-msleep_interruptible.patch
-janitor-removing-check_region-from-drivers-char-espc.patch
-janitor-mark-__init-__exit-static-drivers-net-ppp_deflate.patch
-janitor-mark-__init-__exit-static-drivers-net-bsd_comp.patch
-janitor-fix-typo-arm-dma-arch-arm26-machine-dmac.patch
-kill-kernel_version-duplicate-in-videocodecc.patch
-video-radeon_base-replace-ms_to_hz-with-msecs_to_jiffies.patch
-video-radeonfb-remove-ms_to_hz.patch
-drivers-media-replace-schedule_timeout-with-msleep.patch
-drivers-message-replace-schedule_timeout-with-msleep_interruptible.patch
-drivers-md-replace-schedule_timeout-with-msleep_interruptible.patch
-drivers-ieee1394-replace-schedule_timeout-with-msleep_interruptible.patch
-janitor-replace-dprintk-with-pr_debug-in-drivers-scsi-tpam.patch
-janitor-isdn-icn-change-units-of-icn_boot_timeout1.patch
-drivers-isdn-replace-milliseconds-with-msecs_to_jiffies.patch
-__function__-string-concatenation-deprecated.patch
-janitor-replace-dprintk-with-pr_debug-in-microcodec.patch
-janitor-net-mac89x0-replace-schedule_timeout-with-msleep_interruptible.patch
-nfsd4-fix-nfsd-oopsed-when-encountering-a-conflict-with-a-local-lock.patch
-nfsd-separate-a-little-of-logic-from-fh_verify-into-new-function.patch
-nfsd4-dont-take-i_sem-around-call-to-getxattr.patch
-nfsd-make-sure-getxattr-inode-op-is-non-null-before-calling-it.patch
-nfsd4-reference-count-stateowners.patch
-nfsd4-take-a-reference-to-preserve-stateowner-through-xdr-replay-code.patch
-nfsd4-revert-awkward-extension-of-state-lock-over-xdr-for-replay-encoding.patch
-nfsd4-fix-race-in-xdr-encoding-of-lock_denied-response.patch
-nfsd-remove-incorrect-stateid-modification-in-nfsv4-open-upgrade.patch
-nfsd4-move-open-owner-checks-from-nfsd4_process_open2-into-new-function.patch
-nfsd4-set-open_result_locktype_posix-in-open.patch
-nfsd4-move-seqid-decrement-on-reclaim-to-separate-function.patch
-nfsd4-reorganize-if-in-nfsd4_process_open2-to-make-test-clearer.patch
-nfsd4-move-open_upgrade-code-into-a-separate-function.patch
-nfsd4-move-some-nfsd4_process_open2-code-to-nfs4_new_open.patch
-nfsd-clean-up-nfsd4_process_open2.patch
-nfsd4-fix-putrootfh-return.patch
-nfsd4-move-code-to-truncate-on-open-to-separate-function.patch
-capabilities-issue-in-firmware-loader.patch
-introduce-remap_pfn_range-to-replace-remap_page_range.patch
-convert-references-to-remap_page_range-under-arch-and-documentation-to-remap_pfn_range.patch
-convert-users-of-remap_page_range-under-drivers-and-net-to-use-remap_pfn_range.patch
-convert-users-of-remap_page_range-under-include-asm--to-use-remap_pfn_range.patch
-convert-users-of-remap_page_range-under-sound-to-use-remap_pfn_range.patch
-update-noapic-description.patch
-disk-stats-preempt-safety.patch
-conntrack-preempt-safety.patch
-conntrack-preempt-safety-fix.patch
-neigh_stat-preempt-fix-fix.patch
-document-dec-vsxxx-ab-digitizer-as-known-working.patch
-move-struct-k_itimer-out-of-linux-schedh.patch
-fix-bugs-in-selinux-mprotect-hook.patch
-bsd-secure-levels-lsm-add-time-hooks.patch
-bsd-secure-levels-lsm-add-time-hooks-fix.patch
-bsd-secure-levels-lsm-add-time-hooks-ppc64-fix.patch
-bsd-secure-levels-lsm-core.patch
-bsd-secure-levels-lsm-core-build-fix.patch
-bsd-secure-levels-lsm-documentation.patch
-register_chrdev_region-alloc_chrdev_region-const.patch
-display-committed-memory-limit-and-available-in-meminfo.patch
-display-committed-memory-limit-and-available-in-meminfo-fix.patch
-fix-meminfo-commitavail-to-allow-for-negative-values.patch
-add-documentation-for-new-commitlimit-and-commitavail-meminfo.patch
-posix-compliant-cpu-clocks.patch
-posix-compliant-cpu-clocks-warning-fix.patch
-posix-compliant-cpu-clocks-v6-mmtimer-provides-clock_sgi_cycle.patch
-detach_pid-restore-optimization.patch
-detach_pid-eliminate-one-find_pid-call.patch
-dont-include-linux-irqh-from-drivers.patch
-display-phys_proc_id-only-when-it-is-initialized.patch
-copy_thread-unneeded-child_tid-initialization.patch
-drivers-remove-unused-mod_decinc_use_count.patch
-m68k-mm-off-by-one.patch
-atari-acsi-dependencies.patch
-minmax-removal-arch-m68k-kernel-bios32c.patch
-m68k-dont-emit-empty-stack-program-header-in-vmlinux.patch
-amifb-update-pseudocolor-bitfield-lenghts.patch
-amiga-frame-buffer-kill-obsolete-dmi-resolver-code.patch
-null-vs-0-cleanups.patch
-amifb-use-new-amifboff-logic-to-enhance-audio-experience.patch
-firmware_class-avoid-double-free.patch
-remove-scsi-ioctl-from-udf-lowlevelc.patch
-nfsd-insecure-port-warning-shows-decimal-ipv4-address.patch
-mips-added-missing-definition-and-fixed-typo.patch
-hvc_console-fix-to-prevent-oops-and-late-hangup-and-write.patch
-edd-use-extended-read-command-add-config_edd_skip_mbr.patch
-edd-use-extended-read-command-add-config_edd_skip_mbr-fix.patch
-vm-thrashing-control-tuning.patch
-vm-thrashing-control-tuning-fix.patch
-vm-thrashing-control-tuning-docs.patch
-proc-txt-cleanup.patch
-warning-fix-in-drivers-macintosh-macio-adbc.patch
-idefloppy-suppress-media-not-present-errors.patch
-modules-put-srcversion-checksum-in-each-modinfo-section.patch
-add-missing-checks-of-__copy_to_user-return-value-in.patch
-shared-reed-solomon-ecc-library.patch
-ds_ioctl-usercopy-check.patch
-optimize-profile-path-slightly.patch
-psi240i-build-fix.patch
-vmalloc_to_page-preempt-cleanup.patch
-__init-poisoning-for-i386.patch
-dont-align-initmem-poisoning.patch
-sata_sil-mod15-quirk-with-seagate-st3120026as.patch
-alloc_percpu-fix-for-non-numa.patch
-use-container_of-for-rb_entry.patch
-remove-weird-pmd-cast.patch
-include-asm-bitopsh-include-linux-bitopsh.patch
-ps-shows-wrong-ppid.patch
-selinux-retain-ptracer-sid-across-fork.patch
-remove-redundant-and-from-swp_type.patch
-slab-reduce-fragmentation-due-to-kmem_cache_alloc_node.patch
-lockd-remove-hardcoded-maximum-nlm-cookie-length.patch
-md-convert-lu-to-llu-in-printk.patch
-lockd-remove-hardcoded-maximum-nlm-cookie-length-enhancements.patch

 Merged

+revert-sys_setaltroot.patch

 Remove sys_setaltroot() again - it's probably going away.

+revert-ppc-fix-build-with-o=output_dir.patch

 Revert ppc kbuild patch

+mem-remap_page_range-fix.patch

 Use remap_pfn_range() in mem.c

+pa-risc-io_remap_page_range-fix.patch

 PARISC bogon.

+prevent-partial-acpi-setup-when-using-acpi=off.patch

 ACPI fix

+nm256-module_parm_array-fix.patch

 Sound driver build fix

+psmouse-build-fix.patch
+atkbd-warning-fix.patch

 Input layer fixes

+e1000-module_param-fix.patch
+r8169-module_param-fix.patch

 Net driver build fixes

+mm-help-zone-padding.patch

 Fiddle with struct zone layout

+arcnet-fixes.patch

 Big arcnet driver update

+accept-should-return-enfile-if-it-runs-out-of-inodes.patch

 accept() return value fix

+checkstack-add-x86_64-arch-support.patch

 Support x86_64 with `make checkstack'

+fix-send_sigurg-mediation.patch
+lsm-remove-net-related-includes-from-securityh.patch
+lsm-rename-security_scaffolding_startup-to-security_init.patch
+lsm-rename-security_scaffolding_startup-to-security_init-fix.patch
+lsm-reduce-noise-during-security_register.patch
+lsm-lindent-security-securityc.patch

 LSM updates

+ppc32-fix-building-for-motorola-sandpoint-with-o=.patch
+ppc-disable-irq-probe-on-ppc.patch
+ppc-fix-build-of-irqc-with-config_tau_int.patch

 ppc32 updates

+ppc64-dont-build-virtual-io-drivers-for-powermac.patch
+ppc64-trivial-sparse-cleanups.patch
+ppc64-xmon-sparse-cleanups.patch
+ppc64-provide-notifier-list-for-eeh-slot-isolations.patch
+ppc64-remove-__ioremap_explicit-error-message.patch
+ppc64-fix-boot-on-some-non-lpar-pseries.patch
+ppc64-fix-typo-in-zimage-boot-wrapper.patch
+ppc64-update-g5-thermal-control-driver.patch

 ppc64 updates

-x86-64-clustered-apic-support-fix.patch
-x86-64-clustered-apic-support-fix-fix.patch
-x86-64-clustered-apic-support-fix-fix-fix.patch

 Folded into x86-64-clustered-apic-support.patch

+acpi-thermal-fix-confusing-define.patch

 ACPi cleanup

+power-diskc-small-fixups.patch

 suspend fixes

+fix-deadlocks-on-dpm_sem.patch

 resume deadlock fix

+kgdb-x86_64-fix.patch

 kgdb/x86_64 build fix

+ext3_reservation_window_fix_fix.patch
+ext3-reservation-remove-stale-window-fix.patch
+ext3-reservation-allow-turn-off-for-specifed-file.patch
+ext3-reservation-skip-allocation-in-a-full-group.patch

 ext3 reservation code updates

+perfctr-remap_page_range-fix.patch

 Update perfctr for remap_pfn_range()

-ext3-online-resize-fix-error-codes.patch
-ext3-online-resize-printk-debug-level.patch
-ext3-online-resize-fix-bh-leak.patch
-ext3-online-resize-use-is_rdonly.patch
-ext3-online-resize-lock-newly-created-buffers.patch
-ext3-online-resize-remove-on-stack-bogus-inode.patch
-ext3-online-resize-smp-locking-for-group-metadata.patch
-ext3-online-resize-remove-s_debts.patch
-ext3-online-resize-remove-on-stack-special-resize-inode.patch
-ext3-online-resize-make-group-add-asynchronous.patch
-ext3-online-resize-fix-comments.patch

 Folded into ext3-online-resize-patch.patch

+sched-small-load-balance-fix.patch
+sched-improved-load_balance-tolerance-for-pinned-tasks.patch
+schedstat-fix-schedule-statistics.patch

 CPU scheduler fixes

-sched-pty-fix-scheduling-latencies-in-ptyc.patch

 Dropped - the underlying code no longer appears to need it.

+cpu_down-warning-fix.patch

 Fix a runtime worning

-pcmcia-implement-driver-model-support.patch
-pcmcia-update-network-drivers.patch
-pcmcia-update-wireless-drivers.patch
-pcmcia-add-hotplug-support.patch

 Dropped: these broke and Adam is redoing them

+i386-cpu-hotplug-updated-for-mm.patch

 i386 CPU hotplug is back.

+provide-a-filesystem-specific-syncable-page-bit-fix-2.patch

 Build fix

+kexec-ifdef-cleanup.patch
+kexec-loading-kernel-from-non-default-offset.patch
+kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch

 kexec updates

+crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
+crashdump-cleanups-to-the-kexec-based-crashdump-code.patch

 crashdump-via-kexec updates

+3c59x-remove-eeprom_reset-for-3c905b.patch
+3c59x-support-more-ethtool_ops.patch

 3c59x fixups

-serial-mpsc-driver.patch

 Dropped - this is being redone.

+md-make-read-retry-use-a-new-bio-in-raid1-and-raid10.patch
+md-discard-calc_sb_csum_common-in-favour-of-csum_fold.patch
+md-dont-hold-lock-on-md-devices-while-waiting-for-them-to-finish-resync.patch
+md-fix-typos-in-md-and-raid10.patch
+md-fixes-to-make-version-1-superblocks-work-in-md-driver.patch

 RAID update

+fix-for-spurious-interrupts-on-e100-resume-2.patch

 Another hack at the e100 PM resume problem.

+avoid-warning-on-conntrack_stat_inc-in-death_by_timeout.patch

 preemption atomicity warning fix

+ds_ioctl-usercopy-check.patch

 uaccess check

+no-buddy-bitmap-patch-revist-for-ia64-fix.patch

 buddy bitmap removal fix

+aic7xxx-remove-warnings.patch

 SCSI driver warnings

+ext2-discard-preallocation-in-last-iput.patch

 ext2 preallocation fix

+use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch

 Code consolidation

+add-simple_alloc_dentry-to-libfs.patch

 Code refactoring

+weak-symbols-in-modules-and-versioned-symbols.patch

 Modules fix

+cpiac-rmmod-deadlock-fix.patch

 Fix this video driver

+change-pagevec-counters-back-to-unsigned-long-and-cacheline-align.patch

 Fiddle with the pagevec layout

+solaris-ufs-fix.patch

 UFS solaris compatibility fix

+1-1-device-mapper-dm-crypt-tidy-ups.patch
+1-2-device-mapper-dm-crypt-generator-extension.patch
+2-2-device-mapper-dm-crypt-new-iv-mode-essiv.patch
+1-2-device-mapper-trivial-stray-semi-colon.patch
+2-2-device-mapper-trivial-duplicate-kfree-in-error-path.patch

 Device mapper update

+dio-handle-eof.patch

 Fix direct-io EOF handling.

+add-appletalk-32bit-ioctl-emulation.patch

 ioctl emulation update

+update-credits-entry-of-werner-almesberger.patch

 CREDITS update

+fbdev-reduce-pixmap-memory-allocation-size.patch
+fbdev-remove-inter_module_get-put-from-i810fb.patch
+fbdev-various-mach64-changes.patch
+fbdev-various-mach64-changes-sparc64-fix.patch
+fbdev-clean-up-of-fbcon-fbdev-cursor-interface.patch
+fbdev-clean-up-softcursor-implementation.patch
+fbdev-clean-up-i810fb-cursor-implementation.patch
+fbdev-cleanup-rivafb-cursor-implementation.patch
+fbdev-clean-up-mach64-cursor-implementation.patch

 fbdev updates

+irda-fix-lmp_lsap_inuse.patch
+irda-fix-nsc-ircc-dongle_id-input.patch
+irda-irnet-char-dev-alias.patch
+irda-ias-safety-comments.patch
+irda-adaptive-discovery-query-timer.patch
+irda-ircomm-ias-object-fix.patch
+irda-via-ircc-driver-speed-fixes.patch
+irda-debug-module-param.patch
+irda-stir-driver-usb-reset-fix.patch
+irda-stir-driver-suspend-fix.patch
+irda-stir-netdev-and-messages-cleanups.patch

 IRDA updates

+acct-report-single-record-for-multithreaded-process.patch

 Process accounting fix

+fix-preempt_active-definition.patch

 Fix PREEMPT_ACTIVE definition

+builtin-module-parameters-in-sysfs-too.patch
+module_parm-must-die-make-it-warn-first.patch
+fix-for-module_parm-obsolete.patch
+Remove-MODULE_PARM-from-i386-defconfig.patch
+remove-module_parm-from-arch-i386.patch

 Modules stuff.

+fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch

 Block layer fix

+__init-dependencies-ignore-__param.patch

 init section fix

+add-dac-check-for-setxattrsecurityselinux.patch

 SELinux fix

+fix-compile-of-drivers-i2c-busses-i2c-s3c2410c.patch
+remove-inclusion-of-linux-irqh-from-pci-quirksc.patch
+move-quirk_intel_irqbalance.patch

 Various build fixes

+mmtimer-sparse-fixes.patch

 sparse warning fixes

+hfs-update-key-after-rename.patch
+hfs-relax-dirty-check.patch
+hfs-manage-correct-block-count.patch
+hfs-read-correct-dir-time.patch
+hfs-write-back-resource-info-directly.patch
+hfs-export-type-creator-via-xattr.patch

 HFS update

+posix-layer-clock-driver-api-fix.patch

 posix clock api fix

+fix-pxa270-compile-errors-missing-include.patch

 build fix

+vm-unreclaimable-debug.patch

 Emit more debug info on OOM.

+use-generic_file_open-in-udf.patch

 Code consolidation

+fix-suspend-resume-support-in-via-rhine2.patch

 Fix this net driver

+idr_remove-safety.patch

 Additional sanity checks in the IDR code.

+serial-send_break-duration-fix.patch

 Serial driver fix

+make-__sigqueue_alloc-a-general-helper.patch

 posix timer code tweaks

+i-o-space-write-barrier.patch
+use-mmiowb-in-qla1280c.patch
+use-mmiowb-in-tg3c.patch

 New version of the I/O space write barrier patch

+boot-parameters-quoting-of-environment-variables-revisited.patch

 Fix parsing of kernel boot parameters

+ia64-get_fs-build-fix.patch

 ia64 build fix



number of patches in -mm: 428
number of changesets in external trees: 475
number of patches in -mm only: 415
total patches: 890



All 428 patches:


linus.patch

revert-sys_setaltroot.patch
  revert- sys_setaltroot

revert-ppc-fix-build-with-o=output_dir.patch
  revert-ppc-fix-build-with-o=output_dir

mem-remap_page_range-fix.patch
  mem.c remap_page_range fix

pa-risc-io_remap_page_range-fix.patch
  vm: PA-RISC io_remap_page_range() fix

bk-acpi.patch

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

prevent-partial-acpi-setup-when-using-acpi=off.patch
  Prevent partial ACPI setup when using acpi=off

bk-alsa.patch

nm256-module_parm_array-fix.patch
  nm256-module_parm_array-fix

bk-cifs.patch

bk-driver-core.patch

bk-drm-via.patch

bk-ia64.patch

bk-input.patch

bk-dtor-input.patch

psmouse-build-fix.patch
  psmouse build fix

atkbd-warning-fix.patch
  atkbd warning fix

bk-kbuild.patch

bk-netdev.patch

e1000-module_param-fix.patch
  e1000-module_param-fix

ne2k-pci-pci-build-fix.patch
  ne2k-pci pci build fix

r8169-module_param-fix.patch
  r8169-module_param-fix

bk-pci.patch

bk-pnp.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

sysfs-backing-store-prepare-file_operations.patch
  sysfs backing store - prepare sysfs_file_operations helpers

sysfs-backing-store-prepare-file_operations-fix.patch
  fix oops with firmware loading

sysfs-backing-store-add-sysfs_dirent.patch
  sysfs backing store - add sysfs_direct structure

sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
  sysfs backing store: use sysfs_dirent based tree in file removal

sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
  sysfs backing store: use sysfs_dirent based tree in dir file operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries/inodes for leaf entries

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

mm-help-zone-padding.patch
  mm: help zone padding

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

accept-should-return-enfile-if-it-runs-out-of-inodes.patch
  accept should return ENFILE if it runs out of inodes

checkstack-add-x86_64-arch-support.patch
  checkstack: add x86_64 arch. support

fix-send_sigurg-mediation.patch
  lsm: fix send_sigurg mediation

lsm-remove-net-related-includes-from-securityh.patch
  lsm: remove net related includes from security.h

lsm-rename-security_scaffolding_startup-to-security_init.patch
  lsm: rename security_scaffolding_startup to security_init

lsm-rename-security_scaffolding_startup-to-security_init-fix.patch
  lsm-rename-security_scaffolding_startup-to-security_init-fix

lsm-reduce-noise-during-security_register.patch
  lsm: reduce noise during security_register

lsm-lindent-security-securityc.patch
  lsm: Lindent security/security.c

ppc32-fix-building-for-motorola-sandpoint-with-o=.patch
  ppc32: Fix building for Motorola Sandpoint with O=

ppc-disable-irq-probe-on-ppc.patch
  ppc: Disable IRQ probe on ppc

ppc-fix-build-of-irqc-with-config_tau_int.patch
  ppc: Fix build of irq.c with CONFIG_TAU_INT

ppc64-dont-build-virtual-io-drivers-for-powermac.patch
  ppc64: don't build virtual IO drivers for PowerMac

ppc64-trivial-sparse-cleanups.patch
  ppc64: trivial sparse cleanups

ppc64-xmon-sparse-cleanups.patch
  ppc64: xmon sparse cleanups

ppc64-provide-notifier-list-for-eeh-slot-isolations.patch
  ppc64: provide notifier list for EEH slot isolations

ppc64-remove-__ioremap_explicit-error-message.patch
  ppc64: remove __ioremap_explicit() error message

ppc64-fix-boot-on-some-non-lpar-pseries.patch
  ppc64: Fix boot on some non-LPAR pSeries

ppc64-fix-typo-in-zimage-boot-wrapper.patch
  ppc64: Fix typo in zImage boot wrapper

ppc64-update-g5-thermal-control-driver.patch
  ppc64: Update G5 thermal control driver

ppc64-reloc_hide.patch

x86-64-clustered-apic-support.patch
  x86-64 clustered APIC support
  x86-64-clustered-apic-support fix
  x86-64-clustered-apic-support-fix fix
  x86-64-clustered-apic-support fix

acpi-thermal-fix-confusing-define.patch
  acpi-thermal: fix confusing define

power-diskc-small-fixups.patch
  power/disk.c: small fixups

fix-deadlocks-on-dpm_sem.patch
  Fix deadlocks on dpm_sem

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-x86_64-fix.patch
  kgdb-x86_64-fix

kprobes-exception-notifier-fix-kgdb-x86_64.patch
  kprobes exception notifier fix

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

ext3-reservations-spelling-fixes.patch
  ext3 reservations: Spelling fixes

ext3-reservations-renumber-the-ext3-reservations-ioctls.patch
  ext3 reservations: Renumber the ext3 reservations ioctls

ext3-reservations-remove-unneeded-declaration.patch
  ext3 reservations: Remove unneeded declaration.

ext3-reservations-turn-ext3-per-sb-reservations-list-into-an-rbtree.patch
  ext3 reservations: Turn ext3 per-sb reservations list into an rbtree.

ext3-reservations-split-the-reserve_window-struct-into-two.patch
  ext3 reservations: Split the "reserve_window" struct into two

ext3-reservations-smp-protect-the-reservation-during-allocation.patch
  ext3 reservations: SMP-protect the reservation during allocation

ext3-rsv-use-before-initialise-fix.patch
  ext3 reservations: use before initialised fix

ext3-reservations-window-allocation-fix.patch
  ext3 reservations window allocation fix

ext3-reservation-window-size-increase-incorrectly-fix.patch
  ext3 reservation window size increase incorrectly fix

ext3_reservation_window_fix_fix.patch
  ext3 reservation window fix fix

ext3-reservation-remove-stale-window-fix.patch
  ext3 reservation: remove stale window fix

ext3-reservation-allow-turn-off-for-specifed-file.patch
  ext3 reservation: allow turn off for specifed file

ext3-reservation-skip-allocation-in-a-full-group.patch
  ext3 reservation: skip allocation in a "full" group

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support
  perfctr x86_tests build fix
  perfctr x86 init bug
  perfctr: K8 fix for internal benchmarking code
  perfctr x86 update

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups
  perfctr ppc32 buglet fix

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup
  perfctr SMP hang fix

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

ext3-online-resize-patch.patch
  ext3: online resizing

sched-small-load-balance-fix.patch
  sched: small load balance fix

sched-improved-load_balance-tolerance-for-pinned-tasks.patch
  sched: improved load_balance() tolerance for pinned tasks

schedstat-fix-schedule-statistics.patch
  schedstat: fix schedule() statistics

preempt-smp.patch
  improve preemption on SMP

preempt-smp-_raw_read_trylock-bias-fix.patch
  preempt-smp _raw_read_trylock bias fix

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent-fix.patch
  sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent fix

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-copy_page_range.patch
  sched: mm: fix scheduling latencies in copy_page_range()

fix-config_debug_highmem-assert-in-copy_page_range.patch
  fix CONFIG_DEBUG_HIGHMEM assert in copy_page_range()

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

idle-thread-preemption-fix.patch
  idle thread preemption fix

oprofile-smp_processor_id-fixes.patch
  oprofile smp_processor_id() fixes

fix-smp_processor_id-warning-in-numa_node_id.patch
  Fix smp_processor_id() warning in numa_node_id()

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

enable-preempt_bkl-on-smp-too.patch
  enable PREEMPT_BKL on SMP too

sched-add-debug_smp_processor_id.patch
  sched: add DEBUG_SMP_PROCESSOR_ID

preempt-debugging.patch
  preempt debugging

clean-up-preempt-debugging.patch
  clean up preempt-debugging

cpu_down-warning-fix.patch
  cpu_down() warning fix

vmtrunc-truncate_count-not-atomic.patch
  vmtrunc: truncate_count not atomic

vmtrunc-restore-unmap_vmas-zap_bytes.patch
  vmtrunc: restore unmap_vmas zap_bytes

vmtrunc-unmap_mapping_range_tree.patch
  vmtrunc: unmap_mapping_range_tree

vmtrunc-unmap_mapping-dropping-i_mmap_lock.patch
  vmtrunc: unmap_mapping dropping i_mmap_lock

vmtrunc-vm_truncate_count-race-caution.patch
  vmtrunc: vm_truncate_count race caution

vmtrunc-bug-if-page_mapped.patch
  vmtrunc: bug if page_mapped

vmtrunc-restart_addr-in-truncate_count.patch
  vmtrunc: restart_addr in truncate_count

ext3_bread-cleanup.patch
  ext3_bread() cleanup

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

propagate-pci_enable_device-errors.patch
  propagate pci_enable_device() errors

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-ifdef-cleanup.patch
  kexec ifdef cleanup

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-loading-kernel-from-non-default-offset.patch
  kexec: loading kernel from non-default offset

kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
  kexec: nabling co-existence of normal kexec kernel and  panic kernel

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-kmap-build-fix.patch
  crashdump kmap build fix

crashdump-register-snapshotting-before-kexec-boot.patch
  crashdump: register snapshotting before kexec boot

crashdump-elf-format-dump-file-access.patch
  crashdump: ELF format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear/raw format dump file access

crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
  crashdump: minor bug fixes to kexec crashdump code

crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
  crashdump: cleanups to the kexec based crashdump code

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

stop-reiser4-from-turning-itself-on-by-default.patch
  Stop reiser4 from turning itself on by default

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-cond_resched-build-fix.patch
  reiser4: cond_resched() build fix

reiser4-debug-build-fix.patch
  reiser4-debug-build-fix

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

reiser4-generic_acl-fix.patch
  reiser4: generic_acl fix

reiser4-plugin_set_done-memleak-fix.patch
  reiser4 plugin_set_done-memleak-fix.patch

reiser4-init-max_atom_flusers.patch
  reiser4 init-max_atom_flusers.patch

reiser4-parse-options-reduce-stack-usage.patch
  reiser4 parse-options-reduce-stack-usage.patch

reiser4-sparce64-warning-fix.patch
  reiser4 sparc64-warning-fix.patch

reiser4-hardirq-build-fix.patch
  resiser4: hardirq.h build fix

reiser4-x86_64-warning-fix.patch
  reiser4 x86_64-warning-fix.patch

reiser4-fix-mount-option-parsing.patch
  reiser4 fix-mount-option-parsing.patch

reiser4-parse-option-cleanup.patch
  reiser4 parse-option-cleanup.patch

reiser4-comment-fix.patch
  reiser4 comment-fix.patch

reiser4-fill_super-improve-warning.patch
  reiser4 fill_super-improve-warning.patch

reiser4-disable-pseudo.patch
  reiser4 disable-pseudo.patch

reiser4-disable-repacker.patch
  reiser4 disable-repacker.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

floppy-acpi-enumeration-update.patch
  floppy ACPI enumeration update

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

3c59x-use-netdev_priv.patch
  3c59x: use netdev_priv

3c59x-make-use-of-generic_mii_ioctl.patch
  3c59x: Make use of generic_mii_ioctl

3c59x-vortex-select-mii.patch
  3c59x: VORTEX select MII

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

serial-8250-receive-lockup-fix.patch
  serial: 8250 receive lockup fix

new-serial-flow-control.patch
  new serial flow control

vm-pageout-throttling.patch
  vm: pageout throttling

fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
  Fix race in sysfs_read_file() and sysfs_write_file()

possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch
  Possible race in sysfs_read_file() and sysfs_write_file()

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

md-remove-md_flush_all.patch
  md: remove md_flush_all

md-make-retry_list-non-global-in-raid1-and-multipath.patch
  md: make retry_list non-global in raid1 and multipath

md-rationalise-issue_flush-function-in-md-personalities.patch
  md: rationalise issue_flush function in md personalities

md-rationalise-unplug-functions-in-md.patch
  md: rationalise unplug functions in md

md-make-sure-md-always-uses-rdev_dec_pending-properly.patch
  md: make sure md always uses rdev_dec_pending properly

md-fix-two-little-bugs-in-raid10.patch
  md: fix two little bugs in raid10

md-modify-locking-when-accessing-subdevices-in-md.patch
  md: modify locking when accessing subdevices in md

md-make-read-retry-use-a-new-bio-in-raid1-and-raid10.patch
  md: make read retry use a new bio in raid1 and raid10

md-discard-calc_sb_csum_common-in-favour-of-csum_fold.patch
  md: discard calc_sb_csum_common in favour of csum_fold

md-dont-hold-lock-on-md-devices-while-waiting-for-them-to-finish-resync.patch
  md: don't hold lock on md devices while waiting for them to finish resync.

md-fix-typos-in-md-and-raid10.patch
  md: fix typos in md and raid10

md-fixes-to-make-version-1-superblocks-work-in-md-driver.patch
  md: fixes to make version-1 superblocks work in md driver

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

add-hook-for-pci-resource-deallocation-2.patch
  add hook for PCI resource deallocation

ia64-alignment-error-stack-dump.patch
  ia64-alignment-error-stack-dump

changed-pci_find_device-to-pci_get_device.patch
  Changed pci_find_device to pci_get_device

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

rmmod-ohci1394-hangs.patch
  rmmod ohci1394 hangs

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

avoid-warning-on-conntrack_stat_inc-in-death_by_timeout.patch
  Avoid warning on CONNTRACK_STAT_INC in death_by_timeout()

neigh_stat-preempt-fix.patch
  neigh_stat preempt fix

avoid-problems-with-kobject_set_name-and-name-with-%.patch
  Avoid problems with kobject_set_name and name with %

megaraid-random-loss-of-luns.patch
  Add megaraid PCI IDs

acpi-better-encapsulate-eisa_set_level_irq.patch
  acpi: better encapsulate eisa_set_level_irq()

deinline-large-function-in-blowfishc.patch
  deinline large function in blowfish.c

small-sha256-cleanup.patch
  small sha256 cleanup

small-sha512-cleanup.patch
  small sha512 cleanup

reduce-sha512_transform-stack-usage-speedup.patch
  reduce sha512_transform() stack usage, speedup

aes-586-asm-formatting-changes.patch
  aes-586-asm: formatting changes

aes-586-asm-small-optimizations.patch
  aes-586-asm: small optimizations

add-new-sysfs-attribute-carrier-for-net-devices.patch
  Add new sysfs attribute 'carrier' for net devices.

drivers-atm-ambassador.c-do_pci_device-printk-warning-fix.patch
  drivers/atm/ambassador.c::do_pci_device printk warning fix

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

ipvs-deadlock-fix.patch
  ipvs deadlock fix

kobject_uevent-warning-fix.patch
  kobject_uevent warning fix

kobject_hotplug-no-hotplug_ops.patch
  kobject_hotplug: permit no hotplug_ops

remove-cpu_run_sbin_hotplug.patch
  remove cpu_run_sbin_hotplug()

ds_ioctl-usercopy-check.patch
  ds_ioctl.c usercopy check

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

vmscan-total_scanned-fix.patch
  vmscan: total_scanned fix

revert-vm-no-wild-kswapd.patch
  revert-vm-no-wild-kswapd

balance_pgdat-cleanup.patch
  balance_pgdat-cleanup

no-wild-kswapd-2.patch
  no-wild-kswapd-2

no-wild-kswapd-kswapd-continue.patch
  no-wild-kswapd-kswapd-continue

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

aic7xxx-remove-warnings.patch
  aic7xxx remove warnings

ext2-discard-preallocation-in-last-iput.patch
  ext2: discard preallocation in last iput

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

add-simple_alloc_dentry-to-libfs.patch
  Add simple_alloc_dentry to libfs

weak-symbols-in-modules-and-versioned-symbols.patch
  Weak symbols in modules and versioned symbols

cpiac-rmmod-deadlock-fix.patch
  cpia.c rmmod deadlock fix

change-pagevec-counters-back-to-unsigned-long-and-cacheline-align.patch
  Change pagevec counters back to unsigned long and cacheline align

solaris-ufs-fix.patch
  UFS: solaris compatibility fix

1-1-device-mapper-dm-crypt-tidy-ups.patch
  device-mapper: dm-crypt tidy-ups

1-2-device-mapper-dm-crypt-generator-extension.patch
  device-mapper: dm-crypt generator extension

2-2-device-mapper-dm-crypt-new-iv-mode-essiv.patch
  device-mapper: dm-crypt: new IV mode ESSIV

1-2-device-mapper-trivial-stray-semi-colon.patch
  device-mapper trivial: stray semi-colon

2-2-device-mapper-trivial-duplicate-kfree-in-error-path.patch
  device-mapper trivial: duplicate kfree in error path

dio-handle-eof.patch
  direct-IO: handle EOF

add-appletalk-32bit-ioctl-emulation.patch
  Add appletalk 32bit ioctl emulation

update-credits-entry-of-werner-almesberger.patch
  update CREDITS entry of Werner Almesberger

fbdev-reduce-pixmap-memory-allocation-size.patch
  fbdev: Reduce pixmap memory allocation size

fbdev-remove-inter_module_get-put-from-i810fb.patch
  fbdev: Remove inter_module_get/put from i810fb

fbdev-various-mach64-changes.patch
  fbdev: Various mach64 changes

fbdev-various-mach64-changes-sparc64-fix.patch
  fbdev-various-mach64-changes sparc64 fix

fbdev-clean-up-of-fbcon-fbdev-cursor-interface.patch
  fbdev: Clean up of fbcon/fbdev cursor interface

fbdev-clean-up-softcursor-implementation.patch
  fbdev: Clean up softcursor implementation

fbdev-clean-up-i810fb-cursor-implementation.patch
  fbdev: Clean up i810fb cursor implementation

fbdev-cleanup-rivafb-cursor-implementation.patch
  fbdev: Cleanup rivafb cursor implementation

fbdev-clean-up-mach64-cursor-implementation.patch
  fbdev: Clean up mach64 cursor implementation

irda-fix-lmp_lsap_inuse.patch
  IRDA: Fix lmp_lsap_inuse()

irda-fix-nsc-ircc-dongle_id-input.patch
  IRDA: Fix nsc-ircc dongle_id input

irda-irnet-char-dev-alias.patch
  IRDA: IrNET char dev alias

irda-ias-safety-comments.patch
  IRDA: IAS safety comments

irda-adaptive-discovery-query-timer.patch
  IRDA: Adaptive discovery query timer

irda-ircomm-ias-object-fix.patch
  IRDA: IrCOMM IAS object fix

irda-via-ircc-driver-speed-fixes.patch
  IRDA: via-ircc driver speed fixes

irda-debug-module-param.patch
  IRDA: Debug module param

irda-stir-driver-usb-reset-fix.patch
  IRDA: Stir driver usb reset fix

irda-stir-driver-suspend-fix.patch
  IRDA: Stir driver suspend fix

irda-stir-netdev-and-messages-cleanups.patch
  IRDA: Stir netdev and messages cleanups

acct-report-single-record-for-multithreaded-process.patch
  acct: report single record for multithreaded process

fix-preempt_active-definition.patch
  Fix PREEMPT_ACTIVE definition

builtin-module-parameters-in-sysfs-too.patch
  Builtin Module Parameters in sysfs too

module_parm-must-die-make-it-warn-first.patch
  MODULE_PARM must die: make it warn first.

fix-for-module_parm-obsolete.patch
  Fix for MODULE_PARM obsolete

Remove-MODULE_PARM-from-i386-defconfig.patch
  Remove MODULE_PARM from i386 defconfig.

remove-module_parm-from-arch-i386.patch
  Remove MODULE_PARM from arch/i386

fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch
  fix bad segment coalescing in blk_recalc_rq_segments()

__init-dependencies-ignore-__param.patch
  __init dependencies: ignore __param

add-dac-check-for-setxattrsecurityselinux.patch
  Add DAC check for setxattr(security.selinux)

fix-compile-of-drivers-i2c-busses-i2c-s3c2410c.patch
  Fix compile of drivers/i2c/busses/i2c-s3c2410.c

remove-inclusion-of-linux-irqh-from-pci-quirksc.patch
  Remove inclusion of <linux/irq.h> from pci/quirks.c

move-quirk_intel_irqbalance.patch
  move quirk_intel_irqbalance()

mmtimer-sparse-fixes.patch
  mmtimer sparse fixes

hfs-update-key-after-rename.patch
  hfs: update key after rename

hfs-relax-dirty-check.patch
  hfs: relax dirty check

hfs-manage-correct-block-count.patch
  hfs: manage correct block count

hfs-read-correct-dir-time.patch
  hfs: read correct dir time

hfs-write-back-resource-info-directly.patch
  hfs: write back resource info directly

hfs-export-type-creator-via-xattr.patch
  hfs: export type/creator via xattr

posix-layer-clock-driver-api-fix.patch
  Posix layer <-> clock driver API fix

fix-pxa270-compile-errors-missing-include.patch
  fix PXA270 compile errors (missing #include)

vm-unreclaimable-debug.patch
  vm: unreclaimable pages debugginf

use-generic_file_open-in-udf.patch
  use generic_file_open in udf

fix-suspend-resume-support-in-via-rhine2.patch
  Fix suspend/resume support in via-rhine2

idr_remove-safety.patch
  idr_remove safety checking

serial-send_break-duration-fix.patch
  serial send_break duration fix

make-__sigqueue_alloc-a-general-helper.patch
  make __sigqueue_alloc() a general helper

i-o-space-write-barrier.patch
  I/O space write barrier

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

use-mmiowb-in-tg3c.patch
  use mmiowb in tg3.c

boot-parameters-quoting-of-environment-variables-revisited.patch
  boot parameters: quoting of environment variables revisited

ia64-get_fs-build-fix.patch
  ia64 get_fs build fix



