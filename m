Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVCAJcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVCAJcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVCAJci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:32:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:9600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261838AbVCAJ2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:28:21 -0500
Date: Tue, 1 Mar 2005 01:27:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5-mm1
Message-Id: <20050301012741.1d791cd2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/


- Lots of tuning/balancing changes in the CPU scheduler.  Mainly targetted
  at larger SMT/SMP/NUMA machines.  It's going to be hard to work out whether
  these are a net benefit.

- A pcmcia update which obsoletes cardmgr (although cardmgr still works) and
  makes pcmcia work more like regular hotpluggable devices.  See the
  changelong in pcmcia-dont-send-eject-request-events-to-userspace.patch for
  details.

- A new reiser4 code drop.

- A new rev of the NFS ACL code.

- I seem to be getting a lot of patches which don't compile if you breathe
  on the .config file, let alone if you try them on another architecture.  It
  would be nice to receive less such patches, please.




Changes since 2.6.11-rc4-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-serial.patch
 bk-usb.patch
 bk-watchdog.patch

 Latest versions of various subsystem trees.

-ppc64-fix-compilation-for-maple-board.patch
-alps-do-not-activate-on-unsupported-models.patch
-device-mapper-dm-raid1-deadlock-fix.patch
-fix-ip_rt_gc_min_interval_ms-procfs-sysctl.patch
-cpufreq-core-reduce-warning-messages.patch
-tpm-build-fix.patch
-bk-driver-core-infiniband-build-fix.patch
-ide-fix-masked_irq-arg-handling-for-ide_do_request.patch
-ohci1394-dma_pool_destroy-while-in_atomic-irqs_disabled.patch
-tone-down-pci=routeirq-message.patch
-compat-ioctl-for-submiting-urb.patch
-compat-ioctl-for-submiting-urb-fix.patch
-ppc32-report-chip-version-in-proc-cpuinfo-for-85xx-boards.patch
-ppc32-fix-formatting-of-cds-common-platform-file.patch
-agpgart-allow-multiple-backends-to-be-initialized.patch
-agpgart-allow-multiple-backends-to-be-initialized-fix.patch
-agpgart-add-agp_find_bridge-function.patch
-agpgart-allow-drivers-to-allocate-memory-local-to.patch
-drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
-fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
-agpgart-add-bridge-parameter-to-driver-functions.patch
-fix-futex-mmap_sem-deadlock.patch
-mtrr-some-cleanups.patch
-fix-u32-vs-pm_message_t-confusion-in-firewire.patch
-fix-u32-vs-pm_message_t-in-network-device-drivers.patch

 Merged

+ia64-audit-build-fix.patch

 ia64 compile fix

+selinux-leak-in-error-path.patch
+selinux-null-dereference-in-error-path.patch

 SELinux fixlets

+genhd-null-check-fix.patch

 Avoid possible oops

+setup_per_zone_lowmem_reserve-oops-fix.patch

 Avoid div-by-zero

+dv1394-ioctl-retval-fix.patch

 Fix 1394 ioctl breakage

+macserial-build-fix.patch

 macserial sanity fix.

+fix-audit-inode-filter.patch

 Fix the auditing code.

+prism54-not-releasing-region.patch

 Missed release_region()

+fix-panic-in-26-with-bounced-bio-and-dm.patch

 BIO bouncing fix

+partitions-msdosc.patch

 partition handling fix

+acpi-video-pointer-size-fix.patch

 ACPI fix

+sound-priv_data-offsetting-fix.patch
+include-linux-soundcardh-endianness-fix.patch

 Couple of sound fixes

-changes-to-the-i2c-driver-to-support-a-non-blocking-interface.patch
-minor-ipmi-enhancements.patch
-modify-the-i801-i2c-driver-to-use-the-non-blocking-interface.patch
-add-the-ipmi-smbus-driver.patch
-add-the-ipmi-smbus-driver-fix.patch
-add-the-ipmi-smbus-driver-fix-fix.patch
-fix-for-the-ipmi-smb-driver.patch
-ipmi-documentation-updates.patch

 The IPMI patches keep on changing.  I gave up and dropped it all.

+bk-i2c-saa7146-build-fix.patch

 Compile fix

+preliminary-w83627ehf-hardware-monitoring-driver.patch

 i2c-based hardware monitoring driver

+ide_init_disk-fix.patch

 Fix IDE device enumeration

-twidjoy-build-fix.patch

 Dropped - was fixed by other means.

-pcmcia-bridge-resource-management-fix.patch

 Dropped.

+mips-fixed-confliction-types-for.patch
+mips-fixed-kernel-code-resource.patch
+e100-resource-warning-fix.patch
+8139cp-resource-warning-fixes.patch
+8139too-resource-warning-fixes.patch
+u64-is-not-long-long.patch

 Fix a subset of various brokennesses in bk-pci.patch.

+usb-hcd-u64-warning-fix.patch

 u64's CANNOT be printk'ed with %ll, dammit.

+sysfs-signedness-problem.patch

 sysfs fixlet

-swapspace-layout-improvements-fix.patch

 Folded into swapspace-layout-improvements.patch

-stop-using-base-argument-in-__free_pages_bulk-tidy.patch

 Folded into stop-using-base-argument-in-__free_pages_bulk.patch

+copy_pte_range-latency-fix.patch

 scheduling latency fix

+ia64-specific-dev-mem-handlers.patch
+ia64-specific-dev-mem-handlers-fixes.patch

 Hack around in the /dev/mem driver to avoid arch-specific cache coherency
 problems.

+readahead-unneeded-prev_page-assignments.patch
+readahead-cleanup-get_next_ra_size.patch
+readahead-factor-out-duplicated-code.patch
+readahead-cleanup-blockable_page_cache_readahead.patch

 readahead simplifications

+allow-vma-merging-with-mlock-et-al.patch

 VMA merging

-move-accounting-function-calls-out-of-critical-vm-code-pathspatch-fix.patch

 Folded into move-accounting-function-calls-out-of-critical-vm-code-pathspatch.patch

-invalidate-range-of-pages-after-direct-io-write-fix.patch
-invalidate-range-of-pages-after-direct-io-write-fix-fix.patch

 Folded into invalidate-range-of-pages-after-direct-io-write.patch

+drivers-net-wan-z85230c-interrupt-handling-fix.patch

 Fix interrupt handler in this WAN driver

+fix-driver-name-in-dl2k-as-returned-by-ethtool_gdrvinfo.patch

 ethtool interface fix

+fix-buggy-ieee80211_crypt_-selects.patch

 Kconfig fix

+ppc32-incorrect-define-in-include-asm-ppc-cpm2h.patch
+ppc32-bogus-definition-of-__cmpxchg_u32.patch
+ppc32-fix-whitespace-for-85xx-cds-common-platform.patch
+ppc32-move-from-using-define-svr_-to-cur_ppc_sys_spec-name.patch
+ppc32-mv64360_pic-non-zero-irq-base.patch
+ppc32-add-gpio-irq-definitions-for-mv64x60-parts.patch

 ppc32 udpates

+ppc64-implement-a-vdso-and-use-it-for-signal-trampoline-gas-workaround.patch

 Bang on ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch to
 avoid toolchain problems.

+ppc64-generic-hotplug-cpu-support-fix.patch

 Fix runtime warning in ppc64-generic-hotplug-cpu-support.patch

+ppc64-fix-thinko-in-prom_initc.patch
+ppc64-fix-zimage-wrapper-incorrect-size-to-flush_cache.patch

 ppc64 fixes

-ppc64-reloc_hide.patch

 I finally updated my ppc64 toolchain

+determine-scx200-cb-address-at-run-time.patch

 SCx200 address probing

+iounmap-isa-special-case.patch

 Make iounmap() understand ioremap() special-cases.

+support-for-geode-cpus.patch

 GEODE support

+make-highmem_start-access-only-valid-addresses-i386.patch
+i386-c99-initializers-for-hw_interrupt_type-structures.patch
+x86-memset-the-i386-numa-pgdats-in-arch-code.patch
+x86-do-not-unnecessarily-memset-the-pgdats.patch
+x86-abstract-discontigmem-setup.patch
+x86-abstract-discontigmem-setup-fix.patch
+x86-abstract-discontigmem-setup-ppc64-fix.patch
+x86-allow-srat-to-parse-empty-nodes.patch
+x86-srat-cleanup-make-calculations-and-indenting-level-more-sane.patch
+remove-dead-cyrix-centaur-mtrr-init-code.patch

 Variosu x86-specific updates

-swsusp-do-not-use-higher-order-memory-allocations-on-suspend-fix.patch
-swsusp-do-not-use-higher-order-memory-allocations-on-suspend-fix-fix.patch

 Folded into swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch

+update-suspend-to-ram-vs-video-documentation.patch

 swsusp docco

-merge-vt_struct-into-vc_data-fix.patch

 Folded into merge-vt_struct-into-vc_data.patch

-jbd-fix-against-journal-overflow-tidies.patch

 Folded into jbd-fix-against-journal-overflow.patch

-fix-kallsyms-insmod-rmmod-race-fix.patch
-fix-kallsyms-insmod-rmmod-race-fix-fix.patch

 Folded into fix-kallsyms-insmod-rmmod-race.patch

-touch_softlockup_watchdog.patch
-fix-softlockup-warning-in-swsuspend-resume.patch

 Folded into detect-soft-lockups.patch

-add-struct-request-end_io-callback-fix.patch

 Folded into add-struct-request-end_io-callback.patch

+drivers-scsi-arcmsr-arcmsrc-cleanups.patch

 Tweak the areca driver

-seccomp-tidy.patch

 Folded into seccomp.patch

-add-nobh_writepage-support-tidy.patch
-add-nobh_writepage-support-fix.patch

 Folded into add-nobh_writepage-support.patch

+reiserfs-return-eio-instead-of-calling-bug-when-rename.patch

 reiserfs fixlet

+keys-doc-update-on-locking.patch

 key infrastructure documentation update

+detangle-audith-from-fsh.patch

 header file rationalisation

+ext3_new_inode-failure-handling-missing-check.patch

 Add ext3 error check.

+loglevel-boot-option.patch

 Add `loglevel=N' boot option

+cross-compile-scripts-lxdialog-on-aix.patch

 Fix for AIX cross-compilation

-sort-fix.patch
-sort-export.patch
-sort-build-fix.patch

 Folded into lib-sort-heapsort-implementation-of-sort.patch

+inotify-locking-fix.patch

 inotify fix

-random-pt4-replace-sha-with-faster-version-fix.patch
-random-pt4-replace-sha-with-faster-version-fix-fix.patch
-random-pt4-replace-sha-with-faster-version-fix-fix-fix.patch

 Folded into random-pt4-replace-sha-with-faster-version.patch

-speedup-proc-pid-maps-fix.patch
-speedup-proc-pid-maps-fix-fix.patch
-speedup-proc-pid-maps-fix-fix-fix.patch
-fix-loss-of-records-on-size-4096-in-proc-pid-maps.patch
-speedup-proc-pid-maps-fix-fix-fix-fix.patch

 Folded into speedup-proc-pid-maps.patch

-posix-timers-cpu-clock-support-for-posix-timers-fix2.patch
+posix-timers-cpu-clock-support-for-posix-timers-fix3.patch
+make-itimer_prof-itimer_virtual-per-process-fix.patch

 Fiddle with the posix cpu timer patches in -mm.

+override-rlimit_sigpending-for-non-rt-signals.patch
+show-rlimit_sigpending-usage-in-proc-pid-status.patch
+set-rlimit_sigpending-limit-based-on-rlimit_nproc.patch

 Variosu fixes and robustness enhamcements for the signal code.

+pcmcia-dont-send-eject-request-events-to-userspace.patch
+pcmcia-hotplug-event-for-pcmcia-devices.patch
+pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
+pcmcia-device-and-driver-matching.patch
+pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
+pcmcia-match-for-fake-cis.patch
+pcmcia-export-cis-in-sysfs.patch
+pcmcia-cis-overrid-via-sysfs.patch
+pcmcia-match-anonymous-cards.patch
+pcmcia-allow-function-id-based-match.patch
+pcmcia-file2alias.patch
+pcmcia-request-cis-via-firmware-interface.patch
+pcmcia-cleanups.patch
+pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch

 Make the pcmcia code more hotpluggy - obsoletes cardctl/cardmgr, although
 the latter will still work.

+pcmcia-id_table-for-serial_cs.patch
+pcmcia-id_table-for-3c574_cs.patch
+pcmcia-id_table-for-3c589_cs.patch
+pcmcia-id_table-for-aha152x.patch
+pcmcia-id_table-for-airo_cs.patch
+pcmcia-id_table-for-axnet_cs.patch
+pcmcia-id_table-for-fdomain_stub.patch
+pcmcia-id_table-for-fmvj18x_cs.patch
+pcmcia-id_table-for-ibmtr_cs.patch
+pcmcia-id_table-for-netwave_cs.patch
+pcmcia-id_table-for-nmclan_cs.patch
+pcmcia-id_table-for-teles_cs.patch
+pcmcia-id_table-for-ray_cs.patch
+pcmcia-id_table-for-wavelan_cs.patch
+pcmcia-id_table-for-sym53c500_csc.patch
+pcmcia-id_table-for-qlogic_stubc.patch
+pcmcia-id_table-for-smc91c92_csc.patch
+pcmcia-id_table-for-orinoco_cs.patch
+pcmcia-id_table-for-xirc2ps_csc.patch
+pcmcia-id_table-for-ide_csc.patch
+pcmcia-id_table-for-parport_csc.patch
+pcmcia-id_table-for-pcnet_csc.patch
+pcmcia-id_table-for-pcmciamtdc.patch
+pcmcia-id_table-for-vxpocketc.patch
+pcmcia-id_table-for-atmel_csc.patch
+pcmcia-id_table-for-atmel_csc-fix.patch
+pcmcia-id_table-for-avma1_csc.patch
+pcmcia-id_table-for-avm_csc.patch
+pcmcia-id_table-for-bluecard_csc.patch
+pcmcia-id_table-for-bt3c_csc.patch
+pcmcia-id_table-for-btuart_csc.patch
+pcmcia-id_table-for-com20020_csc.patch
+pcmcia-id_table-for-dtl1_csc.patch
+pcmcia-id_table-for-elsa_csc.patch
+pcmcia-id_table-for-ixj_pcmciac.patch
+pcmcia-id_table-for-nsp_csc.patch
+pcmcia-id_table-for-sedlbauer_csc.patch
+pcmcia-id_table-for-wl3501_csc.patch
+pcmcia-id_table-for-pdaudiocfc.patch

 Lots of module device tables for pcmcia hardware

+nfsacl-acl-kconfig-cleanup.patch
-nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix.patch
-nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix2.patch
-nfsv4-deamon-always-supports-acls.patch
-lib-sort-replace-qsort-in-nfs-acl-code.patch
-nfsacl-infrastructure-and-server-side-of-nfsacl-fix.patch
+nfsacl-nfs-mknod-cleanup.patch
+nfsacl-nfs-mkdir-cleanup.patch
-nfsacl-client-side-of-nfsacl-fix.patch
+nfsacl-kconfig-hack.patch
+nfsacl-client-side-of-nfsacl-build-fix.patch
-nfsacl-acl-umask-handling-workaround-in-nfs-client-fix.patch
-nfs-acl-build-fix-posix-acl-config-tidy.patch
-nfsacl-return-enosys-for-rpc-programs-that-are-unavailable-fix.patch

 New set of NFS ACL patches

-kgdb-documentation-fix.patch

 Folded into kgdb-ga.patch

-dev-mem-restriction-patch.patch
-dev-mem-restriction-patch-allow-reads.patch

 These got in the way of other things and may be a bit risky from a
 back-compat POV anyway.

+sched-timestamp-fixes.patch
+sched-timestamp-fixes-fix.patch
+sched-improve-pinned-task-handling.patch
+sched-improve-pinned-task-handling-fix.patch
+sched-rework-schedstats.patch
+sched-find_busiest_group-fixlets.patch
+sched-find_busiest_group-cleanup.patch
+sched-no-aggressive-idle-balancing.patch
+sched-better-active-balancing-heuristic.patch
+sched-generalised-cpu-load-averaging.patch
+sched-less-affine-wakups.patch
+sched-remove-aggressive-idle-balancing.patch
+sched-sched-domains-aware-balance-on-fork.patch
+sched-schedstats-additions-for-sched-balance-fork.patch
+sched-basic-tuning.patch
+random-ia64-sched-domains-values.patch

 Lots of CPU scheduler updates.

-allow-modular-ide-pnp.patch

 Dropped.

-ppc64-fix-cpu-hotplug.patch

 Folded into i386-cpu-hotplug-updated-for-mm.patch

+x86-crashkernel-fix.patch

 Fix x86-crashkernel.patch

+kexec-ppc-fix-noret_type.patch

 Fix kexec-ppc-support.patch

+kdump-export-crash-notes-section-address-through.patch
+kdump-export-crash-notes-section-address-through-build-fix.patch
+kdump-export-crash-notes-section-address-through-x86_64-fix.patch

 Export the notes section to kdump

-reiser4-radix-tree-tag.patch
+reiser4-perthread_pages_alloc-cleanup.patch
-reiser4-recover-read-performance.patch
-reiser4-export-find_get_pages_tag.patch
-reiser4-add-missing-context.patch

 reiser4 update

+intelfbdrv-resource-warning-fixes.patch

 Fix more 64-bit-resource printk warnings

-fbdev-generic-drawing-function-cleanups-fix.patch

 Folded into fbdev-generic-drawing-function-cleanups.patch

+radeonfb-disable-agp-on-suspend.patch
+aty128fb-disable-agp-on-suspend.patch
+ppc32-uninorth-agp-suspend-support.patch

 fbdev/agp power management updates

+md-printk-fix.patch

 You cannot printk a u64 with %ll, dammit.

+device-mapper-multipath-hardware-handler-fix.patch

 Fix device-mapper-multipath-hardware-handler.patch

-fuse-device-functions-fix-race-in-interrupted-request.patch
-fuse-device-functions-fix.patch
-fuse-fix-llseek-on-device.patch
-fuse-make-two-functions-static.patch
-fuse-fix-variable-with-confusing-name.patch
-fuse-read-write-operations-fix.patch
-fuse-dont-check-against-zero-fsuid.patch
-fuse-remove-mount_max-and-user_allow_other-module-parameters.patch

 Folded into other FUSE patches

-i386-x86_64-apicc-make-two-functions-static.patch
-i386-cyrixc-make-a-function-static.patch
-i386-cpuidc-make-two-functions-static.patch
-i386-efic-make-some-code-static.patch
-i386-mpparsec-make-mp_processor_info-static.patch
-i386-x86_64-msrc-make-two-functions-static.patch
-hpet-make-some-code-static.patch
-26-patch-i386-trapsc-make-a-function-static.patch
-i386-semaphorec-make-4-functions-static.patch
-i386-setupc-make-4-variables-static.patch
-kernel-acctc-make-a-function-static.patch
-kernel-auditc-make-some-functions-static.patch
-kernel-capabilityc-make-a-spinlock-static.patch
-mm-thrashc-make-a-variable-static.patch
-lib-kernel_lockc-make-kernel_sem-static.patch
-drivers-block-umemc-make-two-functions-static.patch
-drivers-block-xdc-make-a-variable-static.patch
-kernel-forkc-make-mm_cachep-static.patch
-kernel-forkc-make-mm_cachep-static-fix.patch
-mm-shmemc-make-a-struct-static.patch
-cirrusfbc-make-some-code-static.patch
-matroxfb_basec-make-some-code-static.patch
-matroxfb_basec-make-some-code-static-fix.patch
-asiliantfbc-make-some-code-static.patch
-security-seclvlc-make-some-code-static.patch
-drivers-block-elevatorc-make-two-functions-static.patch
-drivers-block-rdc-make-two-variables-static.patch
-loopc-make-two-functions-static.patch
-fs-lockd-clntprocc-make-2-functions-static.patch
-kernel-resourcec-make-resource_op-static.patch
-kernel-power-mainc-make-pm_states-static.patch
-kernel-sysc-make-some-code-static.patch
-scsi-ipsc-make-some-code-static.patch
-scsi-psi240ic-make-4-functions-static.patch
-scsi-src-make-a-struct-static.patch
-drivers-video-i810-make-some-code-static.patch
-floppyc-make-some-code-static.patch
-drivers-block-nbdc-make-3-functions-static.patch
-kernel-timerc-make-two-variables-static.patch
-fs-hpfs-make-some-code-static.patch
-i386-x86_64-processc-make-hlt_counter-static.patch
-i386-mach-default-topologyc-make-cpu_devices-static.patch
-savagefbc-make-some-code-static.patch
-fs-ncpfs-ncplib_kernelc-make-a-function-static.patch
-fs-nfs-make-some-code-static.patch
-i386-x86_64-i8259c-make-mask_and_ack_8259a-static.patch
-scsi-sym53c416c-make-a-function-static.patch
-scsi-ultrastorc-make-a-variable-static.patch
-kernel-intermodulec-make-inter_module_get-static.patch
-sstfbc-make-some-code-static.patch
-scsi-53c700c-make-ncr_700_intr-static.patch
-scsi-dpt_i2oc-make-some-code-static.patch
-i386-io_apicc-make-two-variables-static.patch
-i386-x86_64-mpparsec-make-some-code-static.patch
-i386-quirksc-make-a-function-static.patch
-cfq-ioschedc-make-some-code-static.patch
-deadline-ioschedc-make-a-struct-static.patch
+make-various-things-static.patch

 Roll all these into one patch

+fs-proc-kcorec-make-a-function-static.patch
+fs-qnx4-make-some-code-static.patch
+drivers-char-isicomc-make-a-struct-static.patch
+drivers-char-watchdog-make-some-code-static.patch
+drivers-char-synclinkmpc-make-3-functions-static.patch
+drivers-scsi-chc-make-a-struct-static.patch

 Little cleanups

-pty-oops-fix.patch

 This was fixed by other means

+mark-blk_dev_ps2-as-broken.patch
+vsprintfc-cleanups.patch
+i386-scx200c-misc-cleanups.patch
+unexport-mmu_cr4_features.patch
+drivers-char-mxserc-cleanups.patch
+drivers-char-mwave-smapic-small-cleanups.patch
+drivers-char-specialixc-misc-cleanups.patch
+drivers-char-sysrqc-remove-the-unused-sysrq_power_off.patch
+small-partitions-msdos-cleanups.patch
+drivers-char-vt-cleanups.patch
+removes-unused-label-from-drivers-isdn-hisax-hisax_fcpcipnpc.patch

 Little code tweaks.




number of patches in -mm: 728
number of changesets in external trees: 924
number of patches in -mm only: 704
total patches: 1628




All 728 patches:


linus.patch

ia64-audit-build-fix.patch
  ia64 audit build fix

selinux-leak-in-error-path.patch
  SELinux: Leak in error path

selinux-null-dereference-in-error-path.patch
  SELinux: null dereference in error path

genhd-null-check-fix.patch
  genhd: NULL checking fix

setup_per_zone_lowmem_reserve-oops-fix.patch
  setup_per_zone_lowmem_reserve() oops fix

dv1394-ioctl-retval-fix.patch
  dv1394 ioctl fix

macserial-build-fix.patch
  macserial build fix

fix-audit-inode-filter.patch
  fix audit inode filter

prism54-not-releasing-region.patch
  prism54 not releasing region

fix-panic-in-26-with-bounced-bio-and-dm.patch
  Fix panic in 2.6 with bounced bio and dm

partitions-msdosc.patch
  partitions/msdos.c fix

ppc32-64-bit-resource-fix.patch
  ppc32: 64 bit resource fix

nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
  SGI 921857: find broken with nohide on NFSv3

nfsd--exportfs-reduce-stack-usage.patch
  nfsd: exportfs: reduce stack usage

nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
  nfsd: svcrpc: add a per-flavor set_client method

nfsd--svcrpc-rename-pg_authenticate.patch
  nfsd: svcrpc: rename pg_authenticate

nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
  nfsd: svcrpc: move export table checks to a per-program pg_add_client method

nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
  nfsd: nfs4: use new pg_set_client method to simplify nfs4 callback authentication

nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
  nfsd: lockd: don't try to match callback requests against export table

nfsd--nfsd-remove-pg_authenticate-field.patch
  nfsd: nfsd: remove pg_authenticate field

nfsd--global-static-cleanups-for-nfsd.patch
  nfsd: global/static cleanups for nfsd

nfsd--change-nfsd-reply-cache-to-use-listh-lists.patch
  nfsd: change nfsd reply cache to use list.h lists

nfsd-discard-cache_hashed-flag-keeping-information-in-refcount-instead.patch
  nfsd: discard CACHE_HASHED flag, keeping information in refcount instead.

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

ia64-acpi-build-fix.patch
  ia64 acpi build fix

bk-acpi.patch

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

panasonic-acpi-driver.patch
  Panasonic ACPI driver

pcc_acpi-build-fix.patch
  pcc_acpi build fix

acpi-sleep-while-atomic-during-s3-resume-from-ram.patch
  acpi: sleep-while-atomic during S3 resume from ram

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

fix-an-issue-in-acpi-processor-and-container-drivers-related-with-kobject_hotplug.patch
  Fix an issue in ACPI processor and container drivers related  with kobject_hotplug()

acpi-fix-containers-notify-handler-to-handle-proper-cases-properly.patch
  acpi: fix container's notify handler to handle proper cases properly

acpi_power_off-bug-fix.patch
  acpi_power_off bug fix

new-sony_acpi-driver.patch
  new sony_acpi driver

acpi-fix-a-if-statement-in-setup_sys_fs_device_files.patch
  acpi: fix a if-statement in setup_sys_fs_device_files()

bk-agpgart.patch

bk-alsa.patch

sound-priv_data-offsetting-fix.patch
  sound: priv_data offsetting fix

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

bk-arm.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm-via.patch

bk-i2c.patch

bk-i2c-saa7146-build-fix.patch
  bk-i2c saa7146 build fix

preliminary-w83627ehf-hardware-monitoring-driver.patch
  Preliminary w83627ehf hardware monitoring driver

bk-ide-dev.patch

ide_init_disk-fix.patch
  ide_init_disk-fix

bk-ieee1394.patch

sbp2-fix-hang-on-unload.patch
  sbp2: fix hang on unload

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-kbuild.patch

bk-kconfig.patch

ppc-cpufreq-kconfig-fix.patch
  ppc32: cpufreq kconfig fix

bk-netdev.patch

sis900-oops-fix.patch
  sis900 kernel oops fix

bk-ntfs.patch

bk-pci.patch

mips-fixed-confliction-types-for.patch
  mips: fixed confliction types for pcibios_align_resource

mips-fixed-kernel-code-resource.patch
  mips: fixed kernel code resource initialization errors

e100-resource-warning-fix.patch
  e100 resource warning fix

8139cp-resource-warning-fixes.patch
  8139cp resource warning fixes

8139too-resource-warning-fixes.patch
  8139too resource warning fixes

u64-is-not-long-long.patch
  u64 is not long long

bk-scsi.patch

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

bk-serial.patch

bk-usb.patch

usb-hcd-u64-warning-fix.patch
  usb hcd u64 warning fix

bk-watchdog.patch

6300esb-watchdog-driver.patch
  6300ESB watchdog driver

mm.patch
  add -mmN to EXTRAVERSION

sysfs-signedness-problem.patch
  sysfs: Signedness problem

fix-help-for-acpi_container.patch
  Fix help for ACPI_CONTAINER

vm-pageout-throttling.patch
  vm: pageout throttling

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

swapspace-layout-improvements.patch
  swapspace-layout-improvements
  /proc/swaps negative Used

simpler-topdown-mmap-layout-allocator.patch
  simpler topdown mmap layout allocator

vmscan-reclaim-swap_cluster_max-pages-in-a-single-pass.patch
  vmscan: reclaim SWAP_CLUSTER_MAX pages in a single pass

stop-using-base-argument-in-__free_pages_bulk.patch
  stop using "base" argument in __free_pages_bulk()

mempool-protect-buffer-overflow-in-mempool_resize.patch
  mempool: protect buffer overflow in mempool_resize

fix-mincore-cornercases-overflow-caused-by-large-len.patch
  Fix mincore cornercases: overflow caused by large "len"

copy_pte_range-latency-fix.patch
  copy_pte_range latency fix

ia64-specific-dev-mem-handlers.patch
  ia64 specific /dev/mem handlers

ia64-specific-dev-mem-handlers-fixes.patch
  ia64-specific-dev-mem-handlers fixes

readahead-unneeded-prev_page-assignments.patch
  readahead: unneeded prev_page assignments

readahead-cleanup-get_next_ra_size.patch
  readahead: cleanup get_next_ra_size()

readahead-factor-out-duplicated-code.patch
  readahead: factor out duplicated code

readahead-cleanup-blockable_page_cache_readahead.patch
  readahead: cleanup blockable_page_cache_readahead()

allow-vma-merging-with-mlock-et-al.patch
  allow vma merging with mlock et. al.

randomisation-global-sysctl.patch
  Randomisation: global sysctl

randomisation-global-sysctl-fix.patch
  randomisation-global-sysctl-fix

randomisation-infrastructure.patch
  Randomisation: infrastructure

fix-compilation-of-uml-after-the-stack-randomization-patches.patch
  Fix compilation of UML after the stack-randomization patches

randomisation-add-pf_randomize.patch
  Randomisation: add PF_RANDOMIZE

randomisation-stack-randomisation.patch
  Randomisation: stack randomisation

randomisation-mmap-randomisation.patch
  Randomisation: mmap randomisation

randomisation-enable-by-default.patch
  Randomisation: enable by default

randomisation-addr_no_randomize-personality.patch
  Randomisation: add ADDR_NO_RANDOMIZE personality

randomisation-top-of-stack-randomization.patch
  Randomisation: top-of-stack randomization

move-accounting-function-calls-out-of-critical-vm-code-pathspatch.patch
  Move accounting function calls out of critical vm code paths

invalidate-range-of-pages-after-direct-io-write.patch
  invalidate range of pages after direct IO write

write-and-wait-on-range-before-direct-io-read.patch
  write and wait on range before direct io read

only-unmap-what-intersects-a-direct_io-op.patch
  only unmap what intersects a direct_IO op

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

drivers-net-wan-z85230c-interrupt-handling-fix.patch
  drivers/net/wan/z85230.c interrupt handling fix

fix-driver-name-in-dl2k-as-returned-by-ethtool_gdrvinfo.patch
  fix driver name in dl2k as returned by ETHTOOL_GDRVINFO

fix-buggy-ieee80211_crypt_-selects.patch
  fix buggy IEEE80211_CRYPT_* selects

ppc-ppc64-abstract-cpu_feature-checks.patch
  PPC/PPC64: Abstract cpu_feature checks.

ppc32-dont-create-tmp_gas_check.patch
  ppc32: Don't create .tmp_gas_check

ppc32-fix-mv64x60-register-relocation-bug-in-bootwrapper.patch
  ppc32: fix mv64x60 register relocation bug in bootwrapper

ppc32-update-arch-ppc-configs-pmac_defconfig.patch
  ppc32: update arch/ppc/configs/pmac_defconfig

ppc32-artesyn-katana-platform-update.patch
  ppc32: Artesyn Katana platform update

ppc32-artesyn-katana-enet-update.patch
  ppc32: Artesyn Katana enet update

ppc32-move-irq_descstatus-irq_level-bit-setup-to-xilinx_picc.patch
  ppc32: move irq_desc[].status, IRQ_LEVEL bit setup to xilinx_pic.c

ppc32-lindentify-ppc4xx-pic-driver.patch
  ppc32: Lindentify PPC4xx PIC driver

ppc32-ppc4xx-pic-ack-parent-uic-in-disable_irq.patch
  ppc32: PPC4xx PIC: ack parent UIC in disable_irq

ppc32-incorrect-define-in-include-asm-ppc-cpm2h.patch
  ppc32: incorrect #define in include/asm-ppc/cpm2.h

ppc32-bogus-definition-of-__cmpxchg_u32.patch
  ppc32: Bogus definition of __cmpxchg_u32()

ppc32-fix-whitespace-for-85xx-cds-common-platform.patch
  ppc32: fix whitespace for 85xx CDS common platform

ppc32-move-from-using-define-svr_-to-cur_ppc_sys_spec-name.patch
  ppc32: Move from using #define SVR_ to cur_ppc_sys_spec name for 85xx platform

ppc32-mv64360_pic-non-zero-irq-base.patch
  ppc32: mv64360_pic non-zero irq base

ppc32-add-gpio-irq-definitions-for-mv64x60-parts.patch
  ppc32: Add GPIO/IRQ definitions for mv64x60 parts

ppc64-remove-unneeded-includes-from-pseries_nvramc.patch
  remove unneeded includes from pSeries_nvram.c

ppc64-collect-and-export-low-level-cpu-usage-statistics.patch
  ppc64: collect and export low-level cpu usage statistics

ppc64-move-systemcfg-out-of-heads.patch
  ppc64: Move systemcfg out of head.S

ppc64-defconfig-updates.patch
  ppc64: defconfig updates

ppc64-distribute-export_symbols.patch
  ppc64: distribute EXPORT_SYMBOLs

ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch
  ppc64: Implement a vDSO and use it for signal trampoline

ppc64-implement-a-vdso-and-use-it-for-signal-trampoline-gas-workaround.patch
  ppc64-implement-a-vdso-and-use-it-for-signal-trampoline gas workaround

ppc64-generic-hotplug-cpu-support.patch
  ppc64: generic hotplug cpu support

ppc64-generic-hotplug-cpu-support-fix.patch
  ppc64-generic-hotplug-cpu-support-fix

ppc64-disable-hmt-for-rs64-cpus.patch
  ppc64: disable HMT for RS64 cpus

use-vmlinux-during-make-install-on-ppc64.patch
  ppc64: use vmlinux during make install on ppc64

ppc64-functions-to-reserve-performance-monitor-hardware.patch
  ppc64: functions to reserve performance monitor hardware

ppc64-fix-thinko-in-prom_initc.patch
  ppc64: Fix thinko in prom_init.c

ppc64-fix-zimage-wrapper-incorrect-size-to-flush_cache.patch
  ppc64: Fix zImage wrapper incorrect size to flush_cache()

mips-add-tanbac-tb0219-base-board-driver.patch
  mips: add TANBAC TB0219 base board driver

allow-hot-add-enabled-i386-numa-box-to-boot.patch
  Allow hot-add enabled i386 NUMA box to boot

refactor-i386-memory-setup.patch
  x86: refactor memory setup

consolidate-set_max_mapnr_init-implementations.patch
  x86: consolidate set_max_mapnr_init() implementations

remove-free_all_bootmem-define.patch
  x86: remove-free_all_bootmem() #define

out-of-line-x86-put_user-implementation.patch
  out-of-line x86 "put_user()" implementation

fix-iounmap-and-a-pageattr-memleak-x86-and-x86-64.patch
  fix iounmap and a pageattr memleak (x86 and x86-64)

determine-scx200-cb-address-at-run-time.patch
  Determine SCx200 CB address at run-time

x86_64-dump-stack-in-early-exception.patch
  x86_64-dump-stack-in-early-exception

iounmap-isa-special-case.patch
  x86: iounmap() isa special case

support-for-geode-cpus.patch
  Support for GEODE CPUs

make-highmem_start-access-only-valid-addresses-i386.patch
  make highmem_start access only valid addresses (i386)

i386-c99-initializers-for-hw_interrupt_type-structures.patch
  i386: C99 initializers for hw_interrupt_type structures

x86-memset-the-i386-numa-pgdats-in-arch-code.patch
  x86: memset the i386 numa pgdats in arch code

x86-do-not-unnecessarily-memset-the-pgdats.patch
  x86: do not unnecessarily memset the pgdats

x86-abstract-discontigmem-setup.patch
  x86: abstract discontigmem setup

x86-abstract-discontigmem-setup-fix.patch
  x86: abstract discontigmem setup fix

x86-abstract-discontigmem-setup-ppc64-fix.patch
  x86-abstract-discontigmem-setup ppc64 fix

x86-allow-srat-to-parse-empty-nodes.patch
  x86: allow SRAT to parse empty nodes

x86-srat-cleanup-make-calculations-and-indenting-level-more-sane.patch
  x86: SRAT cleanup: make calculations and indenting level more sane

remove-dead-cyrix-centaur-mtrr-init-code.patch
  remove dead cyrix/centaur mtrr init code

x86_64-hugetlb-fix.patch
  x86_64: hugetlb fix

xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
  Xen VMM #4: add ptep_establish_new to make va available

xen-vmm-4-return-code-for-arch_free_page.patch
  Xen VMM #4: return code for arch_free_page

xen-vmm-4-return-code-for-arch_free_page-fix.patch
  Get rid of arch_free_page() warning

xen-vmm-4-runtime-disable-of-vt-console.patch
  Xen VMM #4: runtime disable of VT console

xen-vmm-4-has_arch_dev_mem.patch
  Xen VMM #4: HAS_ARCH_DEV_MEM

xen-vmm-4-split-free_irq-into-teardown_irq.patch
  Xen VMM #4: split free_irq into teardown_irq

altix-ignore-input-during-early-boot.patch
  Altix: Ignore input during early boot

altix-ioc4-serial-driver-support.patch
  Altix: ioc4 serial driver support

swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch
  swsusp: do not use higher order memory allocations on suspend

update-suspend-to-ram-vs-video-documentation.patch
  Update suspend-to-RAM vs. video documentation

m32r-use-generic-bugh.patch
  m32r: use generic bug.h

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

fix-partial-sysrq-setting.patch
  Fix partial sysrq setting

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

irqpoll.patch
  irqpoll

poll-mini-optimisations.patch
  poll: mini optimisations

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cleanup-vc-array-access.patch
  cleanup vc array access

remove-console_macrosh.patch
  remove console_macros.h

merge-vt_struct-into-vc_data.patch
  merge vt_struct into vc_data

jbd-journal-overflow-fix-2.patch
  jbd: journal overflow fix #2

jbd-fix-against-journal-overflow.patch
  JBD: reduce stack and number of journal descriptors

jbd-log-space-management-optimization.patch
  JBD: log space management optimization

factor-out-phase-6-of-journal_commit_transaction.patch
  Factor out phase 6 of journal_commit_transaction

ext3-cleanup-1.patch
  ext3 cleanup 1

ext3-free-block-accounting-fix.patch
  ext3: free block accounting fix

ext3_test_root-speedup.patch
  ext3_test_root() speedup

i4l-new-hfc_usb-driver-version.patch
  i4l: new hfc_usb driver version

i4l-hfc-4s-and-hfc-8s-driver.patch
  i4l: HFC-4S and HFC-8S driver

fix-race-between-the-nmi-code-and-the-cmos-clock.patch
  Fix race between the NMI code and the CMOS clock

cant-unmount-bad-inode.patch
  Can't unmount bad inode

iounmap-debugging.patch
  iounmap debugging

oss-support-for-ac97-low-power-codecs.patch
  OSS Support for AC97 low power codecs

fix-kallsyms-insmod-rmmod-race.patch
  Fix kallsyms/insmod/rmmod race

d_drop-should-use-per-dentry-lock.patch
  d_drop should use per dentry lock

detect-soft-lockups.patch
  detect soft lockups

serialize-access-to-ide-devices.patch
  serialize access to ide devices

add-struct-request-end_io-callback.patch
  Add struct request end_io callback

rework-core-barrier-support.patch
  rework core barrier support

scsi_io_completion-sense-copy.patch
  scsi_io_completion sense copy

blk_execute_rq-oops-on-fast-completion.patch
  blk_execute_rq() oops on fast completion

annotate-proc-pid-maps-with--markers.patch
  annotate /proc/<PID>/maps with [heap]/[stack]/[vdso] markers

serial-add-nec-vr4100-series-serial-support.patch
  serial: add NEC VR4100 series serial support

serial-add-the-output-interface-control-to.patch
  serial: add the output interface control to VR41xx SIU driver

sys_setpriority-euid-semantics-fix.patch
  sys_setpriority() euid semantics fix

add-tcsbrkp-to-compat_ioctlh.patch
  add TCSBRKP to compat_ioctl.h

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

areca-raid-linux-scsi-driver-fix.patch
  areca-raid-linux-scsi-driver-fix

drivers-scsi-arcmsr-arcmsrc-cleanups.patch
  drivers/scsi/arcmsr/arcmsr.c cleanups

minor-conceptual-fix-for-proc-kcore-header-size.patch
  minor conceptual fix for /proc/kcore header size

add-compiler-gcc4h.patch
  add compiler-gcc4.h

rt-lsm.patch
  RT-LSM

convert-proc-driver-rtc-to-seq_file.patch
  convert /proc/driver/rtc to seq_file.

drivers-char-lpc-race-fix.patch
  drivers/char/lp.c race fix

clean-up-and-unify-asm-resourceh-files.patch
  clean up and unify asm-*/resource.h files

add-local-bio-pool-support-and-modify-dm.patch
  add local bio pool support and modify dm

add-local-bio-pool-support-and-modify-dm-uninline-zero_fill_bio.patch
  uninline-zero_fill_bio

add-local-bio-pool-support-and-modify-dm-use-global-bio-set-pool.patch
  add-local-bio-pool-support-and-modify-dm: use global bio set pool

fix-ufs-quota.patch
  Implement quota reading and writing functions for UFS.

run-softirqs-on-proper-processor-on-offline.patch
  Run softirqs on proper processor on offline

aops-based-loop-io.patch
  a_ops-based loop I/O

tty-output-lossage-fix.patch
  tty output lossage fix

add-timing-information-to-printk-messages.patch
  add timing information to printk messages

seccomp.patch
  seccomp: secure computing support

minor-bttv-driver-update.patch
  minor bttv driver update

tv-tuner-module-update.patch
  tv tuner module update.

remove-mount-option-parsing-from-procfs.patch
  remove mount option parsing from procfs

credits-update.patch
  CREDITS Update

bksend-example-script-fix.patch
  bksend example script fix

export-kallsyms_lookup_name.patch
  export kallsyms_lookup_name()

add-nobh_writepage-support.patch
  Add nobh_writepage() support

fix-1-wire-dallas-in-bigendian-machines.patch
  Fix 1-Wire Dallas in bigendian machines

reiserfs-return-eio-instead-of-calling-bug-when-rename.patch
  reiserfs: return -EIO instead of calling BUG() when rename goes wrong

keys-doc-update-on-locking.patch
  Keys: Doc update on locking

detangle-audith-from-fsh.patch
  detangle audit.h from fs.h

ext3_new_inode-failure-handling-missing-check.patch
  ext3_new_inode() failure handling missing check

loglevel-boot-option.patch
  loglevel boot option

cross-compile-scripts-lxdialog-on-aix.patch
  cross-compile scripts/lxdialog/ on AIX

base-small-introduce-the-config_base_small-flag.patch
  base-small: introduce the CONFIG_BASE_SMALL flag

base-small-shrink-chrdevs-hash.patch
  base-small: shrink chrdevs hash

base-small-shrink-pid-tables.patch
  base-small: shrink PID tables

base-small-shrink-uid-hash.patch
  base-small: shrink UID hash

base-small-shrink-futex-queues.patch
  base-small: shrink futex queues

base-small-shrink-timer-hashes.patch
  base-small: shrink timer hashes

base-small-shrink-console-buffer.patch
  base-small: shrink console buffer

lib-sort-heapsort-implementation-of-sort.patch
  lib/sort: Heapsort implementation of sort()
  Fix up bustedness in menuconfig

lib-sort-turn-off-self-test.patch
  lib/sort: turn off self-test

lib-sort-replace-qsort-in-xfs.patch
  lib/sort: Replace qsort in XFS

lib-sort-replace-insertion-sort-in-exception-tables.patch
  lib/sort: Replace insertion sort in exception tables

lib-sort-replace-insertion-sort-in-ia64-exception-tables.patch
  lib/sort: Replace insertion sort in IA64 exception tables

lib-sort-use-generic-sort-on-x86_64.patch
  lib/sort: Use generic sort on x86_64

inotify.patch
  inotify

inotify-locking-fix.patch
  inotify locking fix

random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
  random: cleanup waitqueue logic, fix missed wakeup

random-pt2-kill-pool-clearing.patch
  random: kill pool clearing

random-pt2-combine-legacy-ioctls.patch
  random: combine legacy ioctls

random-pt2-re-init-all-pools-on-zero.patch
  random: re-init all pools on zero

random-pt2-simplify-initialization.patch
  random: simplify initialization

random-pt2-kill-memsets-of-static-data.patch
  random: kill memsets of static data

random-pt2-kill-dead-extract_state-struct.patch
  random: kill dead extract_state struct

random-pt2-kill-22-compat-waitqueue-defs.patch
  random: kill 2.2 compat waitqueue defs

random-pt2-kill-redundant-rotate_left-definitions.patch
  random: kill redundant rotate_left definitions

random-pt2-kill-redundant-rotate_left-definitions-fix.patch
  rol32 thinko

random-pt2-kill-misnamed-log2.patch
  random: kill misnamed log2

random-pt3-more-meaningful-pool-names.patch
  random: More meaningful pool names

random-pt3-static-allocation-of-pools.patch
  random: Static allocation of pools

random-pt3-static-sysctl-bits.patch
  random: Static sysctl bits

random-pt3-catastrophic-reseed-checks.patch
  random: Catastrophic reseed checks

random-pt3-entropy-reservation-accounting.patch
  random: Entropy reservation accounting

random-pt3-reservation-flag-in-pool-struct.patch
  random: Reservation flag in pool struct

random-pt3-reseed-pointer-in-pool-struct.patch
  random: Reseed pointer in pool struct

random-pt3-break-up-extract_user.patch
  random: Break up extract_user

random-pt3-remove-dead-md5-copy.patch
  random: Remove dead MD5 copy

random-pt3-simplify-hash-folding.patch
  random: Simplify hash folding

random-pt3-clean-up-hash-buffering.patch
  random: Clean up hash buffering

random-pt3-remove-entropy-batching.patch
  random: Remove entropy batching

random-pt4-create-new-rol32-ror32-bitops.patch
  random: Create new rol32/ror32 bitops

random-pt4-use-them-throughout-the-tree.patch
  random: Use them throughout the tree

random-pt4-kill-the-sha-variants.patch
  random: Kill the SHA variants

random-pt4-cleanup-sha-interface.patch
  random: Cleanup SHA interface

random-pt4-move-sha-code-to-lib.patch
  random: Move SHA code to lib/

random-pt4-replace-sha-with-faster-version.patch
  random: Replace SHA with faster version

random-pt4-update-cryptolib-to-use-sha-fro-lib.patch
  random: Update cryptolib to use SHA fro lib

random-pt4-move-halfmd4-to-lib.patch
  random: Move halfmd4 to lib

random-pt4-kill-duplicate-halfmd4-in-ext3-htree.patch
  random: Kill duplicate halfmd4 in ext3 htree

random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix.patch
  random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix

random-pt4-simplify-and-shrink-syncookie-code.patch
  random: Simplify and shrink syncookie code

random-pt4-move-syncookies-to-net.patch
  random: Move syncookies to net/

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch
  posix-timers: tidy up clock interfaces and consolidate dispatch logic

posix-timers-high-resolution-cpu-clocks-for-posix-clock_-syscalls.patch
  posix-timers: high-resolution CPU clocks for POSIX clock_* syscalls

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic-cleanup.patch
  posix-timers: tidy up clock interfaces and  consolidate dispatch logic cleanup

posix-timers-fix-posix-timers-signals-lock-order.patch
  posix-timers: fix posix-timers signals lock order

posix-timers-cpu-clock-support-for-posix-timers.patch
  posix-timers: CPU clock support for POSIX timers

posix-timers-cpu-clock-support-for-posix-timers-fix.patch
  posix-timers: CPU clock support for POSIX timers (fix)

posix-timers-cpu-clock-support-for-posix-timers-fix3.patch
  fix posix-timer initialization

panic-in-check_process_timers.patch
  PANIC in check_process_timers()

make-itimer_real-per-process.patch
  make ITIMER_REAL per-process

make-itimer_prof-itimer_virtual-per-process.patch
  make ITIMER_PROF, ITIMER_VIRTUAL per-process

make-itimer_prof-itimer_virtual-per-process-fix.patch
  process-wide itimer typo fixes

make-rlimit_cpu-sigxcpu-per-process.patch
  make RLIMIT_CPU/SIGXCPU per-process

override-rlimit_sigpending-for-non-rt-signals.patch
  override RLIMIT_SIGPENDING for non-RT signals

show-rlimit_sigpending-usage-in-proc-pid-status.patch
  show RLIMIT_SIGPENDING usage in /proc/PID/status

set-rlimit_sigpending-limit-based-on-rlimit_nproc.patch
  set RLIMIT_SIGPENDING limit based on RLIMIT_NPROC

pcmcia-update-vrc4171_card.patch
  pcmcia: update vrc4171_card

pcmcia-yenta_socket-ti4150-support.patch
  pcmcia: yenta_socket - ti4150 support

pcmcia-pd6729-convert-to-pci_register_driver.patch
  pcmcia: pd6729 - convert to pci_register_driver()

pcmcia-rsrc_nonstatic-sysfs-output.patch
  pcmcia: rsrc_nonstatic: sysfs output

pcmcia-rsrc_nonstatic-sysfs-input.patch
  pcmcia: rsrc_nonstatic: sysfs input

pcmcia-mark-resource-setup-as-done.patch
  pcmcia: mark resource setup as done

pcmcia-pcmcia_device_probe.patch
  pcmcia: pcmcia_device_probe

pcmcia-pcmcia_device_remove.patch
  pcmcia: pcmcia_device_remove

pcmcia-pcmcia_device_add.patch
  pcmcia: pcmcia_device_add

pcmcia-use-bus_rescan_devices.patch
  pcmcia: use bus_rescan_devices

pcmcia-add-pcmcia-devices-autonomously.patch
  pcmcia: add pcmcia devices autonomously

pcmcia-determine-some-useful-information-about-devices.patch
  pcmcia: determine some useful information about devices

pcmcia-per-device-sysfs-output.patch
  pcmcia: per-device sysfs output

pcmcia-dont-send-eject-request-events-to-userspace.patch
  pcmcia: don't send eject request events to userspace

pcmcia-hotplug-event-for-pcmcia-devices.patch
  pcmcia: hotplug event for PCMCIA devices

pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
  pcmcia: hotplug event for PCMCIA socket devices

pcmcia-device-and-driver-matching.patch
  pcmcia: device and driver matching

pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
  pcmcia: check for invalid crc32 hashes in id_tables

pcmcia-match-for-fake-cis.patch
  pcmcia: match for fake CIS

pcmcia-export-cis-in-sysfs.patch
  pcmcia: export CIS in sysfs

pcmcia-cis-overrid-via-sysfs.patch
  pcmcia: CIS overrid via sysfs

pcmcia-match-anonymous-cards.patch
  pcmcia: match "anonymous" cards

pcmcia-allow-function-id-based-match.patch
  pcmcia: allow function-ID based match

pcmcia-file2alias.patch
  pcmcia: file2alias

pcmcia-request-cis-via-firmware-interface.patch
  pcmcia: request CIS via firmware interface

pcmcia-cleanups.patch
  pcmcia: cleanups

pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch
  pcmcia: rescan bus always upon echoing into setup_done

pcmcia-id_table-for-serial_cs.patch
  pcmcia: id_table for serial_cs

pcmcia-id_table-for-3c574_cs.patch
  pcmcia: id_table for 3c574_cs

pcmcia-id_table-for-3c589_cs.patch
  pcmcia: id_table for 3c589_cs

pcmcia-id_table-for-aha152x.patch
  pcmcia: id_table for aha152x

pcmcia-id_table-for-airo_cs.patch
  pcmcia: id_table for airo_cs

pcmcia-id_table-for-axnet_cs.patch
  pcmcia: id_table for axnet_cs

pcmcia-id_table-for-fdomain_stub.patch
  pcmcia: id_table for fdomain_stub

pcmcia-id_table-for-fmvj18x_cs.patch
  pcmcia: id_table for fmvj18x_cs

pcmcia-id_table-for-ibmtr_cs.patch
  pcmcia: id_table for ibmtr_cs

pcmcia-id_table-for-netwave_cs.patch
  pcmcia: id_table for netwave_cs

pcmcia-id_table-for-nmclan_cs.patch
  pcmcia: id_table for nmclan_cs

pcmcia-id_table-for-teles_cs.patch
  pcmcia: id_table for teles_cs

pcmcia-id_table-for-ray_cs.patch
  pcmcia: id_table for ray_cs

pcmcia-id_table-for-wavelan_cs.patch
  pcmcia: id_table for wavelan_cs

pcmcia-id_table-for-sym53c500_csc.patch
  pcmcia: id_table for sym53c500_cs.c

pcmcia-id_table-for-qlogic_stubc.patch
  pcmcia: id_table for qlogic_stub.c

pcmcia-id_table-for-smc91c92_csc.patch
  pcmcia: id_table for smc91c92_cs.c

pcmcia-id_table-for-orinoco_cs.patch
  pcmcia: id_table for orinoco_cs

pcmcia-id_table-for-xirc2ps_csc.patch
  pcmcia: id_table for xirc2ps_cs.c

pcmcia-id_table-for-ide_csc.patch
  pcmcia: id_table for ide_cs.c

pcmcia-id_table-for-parport_csc.patch
  pcmcia: id_table for parport_cs.c

pcmcia-id_table-for-pcnet_csc.patch
  pcmcia: id_table for pcnet_cs.c

pcmcia-id_table-for-pcmciamtdc.patch
  pcmcia: id_table for pcmciamtd.c

pcmcia-id_table-for-vxpocketc.patch
  pcmcia: id_table for vxpocket.c

pcmcia-id_table-for-atmel_csc.patch
  pcmcia: id_table for atmel_cs.c

pcmcia-id_table-for-atmel_csc-fix.patch
  pcmcia-id_table-for-atmel_csc fix

pcmcia-id_table-for-avma1_csc.patch
  pcmcia: id_table for avma1_cs.c

pcmcia-id_table-for-avm_csc.patch
  pcmcia: id_table for avm_cs.c

pcmcia-id_table-for-bluecard_csc.patch
  pcmcia: id_table for bluecard_cs.c

pcmcia-id_table-for-bt3c_csc.patch
  pcmcia: id_table for bt3c_cs.c

pcmcia-id_table-for-btuart_csc.patch
  pcmcia: id_table for btuart_cs.c

pcmcia-id_table-for-com20020_csc.patch
  pcmcia: id_table for com20020_cs.c

pcmcia-id_table-for-dtl1_csc.patch
  pcmcia: id_table for dtl1_cs.c

pcmcia-id_table-for-elsa_csc.patch
  pcmcia: id_table for elsa_cs.c

pcmcia-id_table-for-ixj_pcmciac.patch
  pcmcia: id_table for ixj_pcmcia.c

pcmcia-id_table-for-nsp_csc.patch
  pcmcia: id_table for nsp_cs.c

pcmcia-id_table-for-sedlbauer_csc.patch
  pcmcia: id_table for sedlbauer_cs.c

pcmcia-id_table-for-wl3501_csc.patch
  pcmcia: id_table for wl3501_cs.c

pcmcia-id_table-for-pdaudiocfc.patch
  pcmcia: id_table for pdaudiocf.c

nfs-fix_vfsflock.patch
  VFS: Fix structure initialization in locks_remove_flock()

nfs-flock.patch
  NFS: Add emulation of BSD flock() in terms of POSIX locks on the server

nfsacl-acl-kconfig-cleanup.patch
  nfsacl: acl kconfig cleanup

nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
  nfsacl: Return -ENOSYS for RPC programs that are unavailable

nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
  nfsacl: Add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd

nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
  nfsacl: Allow multiple programs to listen on the same port

nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
  nfsacl: Allow multiple programs to share the same transport

nfsacl-lazy-rpc-receive-buffer-allocation.patch
  nfsacl: Lazy RPC receive buffer allocation

nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
  nfsacl: Encode and decode arbitrary XDR arrays

nfsacl-add-noacl-nfs-mount-option.patch
  nfsacl: Add noacl nfs mount option

nfsacl-infrastructure-and-server-side-of-nfsacl.patch
  nfsacl: /16] Infrastructure and server side of nfsacl

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: Solaris nfsacl workaround

nfsacl-nfs-mknod-cleanup.patch
  nfsacl: nfs mknod cleanup

nfsacl-nfs-mkdir-cleanup.patch
  nfsacl: nfs mkdir cleanup

nfsacl-client-side-of-nfsacl.patch
  nfsacl: Client side of nfsacl

nfsacl-kconfig-hack.patch
  nfsacl kconfig hack

nfsacl-client-side-of-nfsacl-build-fix.patch
  nfsacl-client-side-of-nfsacl-build fix

nfsacl-acl-umask-handling-workaround-in-nfs-client.patch
  nfsacl: ACL umask handling workaround in nfs client

nfsacl-cache-acls-on-the-nfs-client-side.patch
  nfsacl: Cache acls on the nfs client side

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
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix
  kgdb-ga-fixes
  kgdb: kill off highmem_start_page
  kgdb documentation fix

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

make-page_owner-handle-non-contiguous-page-ranges.patch
  make page_owner handle non-contiguous page ranges

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

perfctr-i386.patch
  perfctr: i386

perfctr-x86-core-updates.patch
  perfctr x86 core updates

perfctr-x86-driver-updates.patch
  perfctr x86 driver updates

perfctr-x86-driver-cleanup.patch
  perfctr: x86 driver cleanup

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86-update-2.patch
  perfctr x86 update 2

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-x86_64-core-updates.patch
  perfctr x86_64 core updates

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-driver-update.patch
  perfctr: ppc32 driver update

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-ppc32-update-2.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-virtual-updates.patch
  perfctr virtual updates

perfctr-virtual-cleanup.patch
  perfctr: virtual cleanup

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-virtual-update.patch
  perfctr virtual update

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

perfctr-2710-api-update-1-4-common.patch
  perfctr-2.7.10 API update 1/4: common

perfctr-2710-api-update-2-4-i386.patch
  perfctr-2.7.10 API update 2/4: i386

perfctr-2710-api-update-3-4-x86_64.patch
  perfctr-2.7.10 API update 3/4: x86_64

perfctr-2710-api-update-4-4-ppc32.patch
  perfctr-2.7.10 API update 4/4: ppc32

sched-timestamp-fixes.patch
  sched: timestamp fixes

sched-timestamp-fixes-fix.patch
  timestamp fixes fix

sched-improve-pinned-task-handling.patch
  sched: improve pinned task handling

sched-improve-pinned-task-handling-fix.patch
  sched-improve-pinned-task-handling fix

sched-rework-schedstats.patch
  sched: rework schedstats

sched-find_busiest_group-fixlets.patch
  sched: find_busiest_group fixlets

sched-find_busiest_group-cleanup.patch
  sched: find_busiest_group cleanup

sched-no-aggressive-idle-balancing.patch
  sched: no aggressive idle balancing

sched-better-active-balancing-heuristic.patch
  sched: better active balancing heuristic

sched-generalised-cpu-load-averaging.patch
  sched: generalised CPU load averaging

sched-less-affine-wakups.patch
  sched: less affine wakups

sched-remove-aggressive-idle-balancing.patch
  sched: remove aggressive idle balancing

sched-sched-domains-aware-balance-on-fork.patch
  sched: sched-domains aware balance-on-fork

sched-schedstats-additions-for-sched-balance-fork.patch
  sched: schedstats additions for sched-balance-fork

sched-basic-tuning.patch
  sched: basic tuning

random-ia64-sched-domains-values.patch
  random ia64 sched-domains values

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm
  ppc64: fix hotplug cpu

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
  numa-policies-for-file-mappings-mpol_mf_move for cachefs

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

add-page-becoming-writable-notification-fix.patch
  do_wp_page_mk_pte_writable() fix

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

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

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

kexec-kexec-generic-kexec-use-unsigned-bitfield.patch
  kexec: use unsigned bitfield

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86-crashkernel-fix.patch
  kexec: fix for broken kexec on panic

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

kexec-ppc-fix-noret_type.patch
  kexec: ppc: fix NORET_TYPE

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-fixes.patch
  crashdump-routines-for-copying-dump-pages-fixes

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

crashdump-linear-raw-format-dump-file-access-coding-style.patch
  crashdump-linear-raw-format-dump-file-access-coding-style

kdump-export-crash-notes-section-address-through.patch
  Kdump: Export crash notes section address through sysfs

kdump-export-crash-notes-section-address-through-build-fix.patch
  kdump-export-crash-notes-section-address-through build fix

kdump-export-crash-notes-section-address-through-x86_64-fix.patch
  kdump-export-crash-notes-section-address-through x86_64 fix

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-move-cpusets-above-embedded.patch
  move CPUSETS above EMBEDDED

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

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

lib-sort-replace-open-coded-opids2-bubblesort-in-cpusets.patch
  lib/sort: Replace open-coded O(pids**2) bubblesort in cpusets

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

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-perthread_pages_alloc-cleanup.patch
  perthread_pages_alloc cleanup

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

au1x00_uart-deadlock-fix.patch
  au1x00_uart deadlock fix

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

radeonfb-fix-spurious-error-return-in-fbio_radeon_set_mirror.patch
  radeonfb: Fix spurious error return in FBIO_RADEON_SET_MIRROR

w100fb-make-blanking-function-interrupt-safe.patch
  w100fb: Make blanking function interrupt safe

kyrofb-copy__user-return-value-checks-added-to-kyro-fb.patch
  kyrofb: copy_*_user return value checks added to kyro fb

skeletonfb-documentation-fixes.patch
  skeletonfb: Documentation fixes

intelfb-add-partial-support-915g-chipset.patch
  intelfb: Add partial support 915G chipset

intelfbdrv-resource-warning-fixes.patch
  intelfbdrv resource warning fixes

sisfb_compat_ioctl-warning-fix.patch
  fbdev compat_ioctl warning fix

sis-warning-fix.patch
  sis warning fix

tridentfbc-make-some-code-static.patch
  tridentfb.c: make some code static

tridentfb-warning-fix.patch
  tridentfb warning fix

intelfb-vesa_modes-require-config_fb_modehelpers.patch
  intelfb: vesa_modes require CONFIG_FB_MODEHELPERS

fbdev-make-fb_find_mode-return-failure-if-modular.patch
  fbdev: Make fb_find_mode() return failure if modular

fbdev-logo-code-fixes.patch
  fbdev: Logo code fixes

fbdev-kbuild-cleanups.patch
  fbdev: Kbuild cleanups

geodefb-add-geode-framebuffer-driver.patch
  geodefb: Add Geode framebuffer driver

nvidiafb-add-update-framebuffer-driver-for-nvidia-chipsets.patch
  nvidiafb: Add update framebuffer driver for nVidia chipsets

fbdev-generic-drawing-function-cleanups.patch
  fbdev: Generic drawing function cleanups

radeonfb-disable-agp-on-suspend.patch
  radeonfb: Disable AGP on suspend

aty128fb-disable-agp-on-suspend.patch
  aty128fb: Disable AGP on suspend

ppc32-uninorth-agp-suspend-support.patch
  ppc32: uninorth-agp suspend support

md-fix-multipath-assembly-bug.patch
  md: fix multipath assembly bug

md-raid-kconfig-cleanups-remove-experimental-tag-from-raid-6.patch
  md: RAID Kconfig cleanups, remove experimental tag from RAID-6

md-remove-possible-oops-in-md-raid1.patch
  md: remove possible oops in md/raid1

md-make-raid5-and-raid6-robust-against-failure-during-recovery.patch
  md: make raid5 and raid6 robust against failure during recovery.

md-remove-kludgy-level-check-from-mdc.patch
  md: remove kludgy level check from md.c

md-merge-md_enter_safemode-into-md_check_recovery.patch
  md: merge md_enter_safemode into md_check_recovery

md-improve-locking-on-safemode-and-move-superblock-writes.patch
  md: improve locking on 'safemode' and move superblock writes

md-improve-the-interface-to-sync_request.patch
  md: improve the interface to sync_request

md-optimised-resync-using-bitmap-based-intent-logging.patch
  md: optimised resync using Bitmap based intent logging

md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging fix

md-raid1-support-for-bitmap-intent-logging.patch
  md: raid1 support for bitmap intent logging

md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
  md: optimise reconstruction when re-adding a recently failed drive.

md-printk-fix.patch
  md printk fix

device-mapper-store-name-directly-against-device.patch
  device-mapper: Store name directly against device

device-mapper-record-restore-bio-state.patch
  device-mapper: Record & restore bio state.

device-mapper-export-map_info.patch
  device-mapper: Export map_info

device-mapper-multipath.patch
  device-mapper: multipath

device-mapper-multipath-round-robin-path-selector.patch
  device-mapper: multipath round-robin path selector.

device-mapper-multipath-hardware-handler.patch
  device-mapper: multipath hardware handler

device-mapper-multipath-hardware-handler-fix.patch
  device-mapper-multipath-hardware-handler fix

device-mapper-multipath-hardware-handler-for-emc.patch
  device-mapper: multipath hardware handler for EMC

device-mapper-tag-multipath-exports-gpl.patch
  device-mapper: tag multipath exports GPL

device-mapper-some-code-formatting-cleanups.patch
  device-mapper: Some code/formatting cleanups

device-mapper-some-multipath-fn-renames.patch
  device-mapper: Some multipath fn renames

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

update-documentation-filesystems-locking.patch
  Update Documentation/filesystems/Locking

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  Subject: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  Subject: [PATCH 2/11] FUSE - core

fuse-device-functions.patch
  Subject: [PATCH 3/11] FUSE - device functions
  fuse: fix race in interrupted request

fuse-read-only-operations.patch
  Subject: [PATCH 4/11] FUSE - read-only operations

fuse-read-write-operations.patch
  Subject: [PATCH 5/11] FUSE - read-write operations

fuse-file-operations.patch
  Subject: [PATCH 6/11] FUSE - file operations

fuse-mount-options.patch
  Subject: [PATCH 7/11] FUSE - mount options

fuse-extended-attribute-operations.patch
  Subject: [PATCH 8/11] FUSE - extended attribute operations

fuse-readpages-operation.patch
  Subject: [PATCH 9/11] FUSE - readpages operation

fuse-nfs-export.patch
  Subject: [PATCH 10/11] FUSE - NFS export

fuse-direct-i-o.patch
  Subject: [PATCH 11/11] FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

make-various-things-static.patch
  Make lots of things static

fs-proc-kcorec-make-a-function-static.patch
  fs/proc/kcore.c: make a function static

fs-qnx4-make-some-code-static.patch
  fs/qnx4/: make some code static

drivers-char-isicomc-make-a-struct-static.patch
  drivers/char/isicom.c: make a struct static

drivers-char-watchdog-make-some-code-static.patch
  drivers/char/watchdog/: make some code static

drivers-char-synclinkmpc-make-3-functions-static.patch
  drivers/char/synclinkmp.c: make 3 functions static

drivers-scsi-chc-make-a-struct-static.patch
  drivers/scsi/ch.c: make a struct static

update-email-address-of-andrea-arcangeli.patch
  update email address of Andrea Arcangeli

compile-error-blackbird_load_firmware.patch
  blackbird_load_firmware compile fix

i386-cpu-commonc-some-cleanups.patch
  i386 cpu/common.c: some cleanups

i386-x86_64-io_apicc-misc-cleanups.patch
  i386/x86_64 io_apic.c: misc cleanups

3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
  3w-abcd.h: TW_Device_Extension: remove an unused field

kill-aux_device_present.patch
  kill aux_device_present

mostly-i386-mm-cleanup.patch
  (mostly i386) mm cleanup

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

update-email-address-of-philip-blundell.patch
  Update email address of Philip Blundell

saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
  saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's

fix-placement-of-static-inline-in-nfsdh.patch
  fix placement of static inline in nfsd.h

mm-page-writebackc-remove-an-unused-function.patch
  mm/page-writeback.c: remove an unused function

misc-isapnp-cleanups.patch
  misc ISAPNP cleanups

some-pnp-cleanups.patch
  some PNP cleanups

if-0-cx88_risc_disasm.patch
  #if 0 cx88_risc_disasm

make-loglevels-in-init-mainc-a-little-more-sane.patch
  Make loglevels in init/main.c a little more sane.

isicom-use-null-for-pointer.patch
  sparse: use NULL for pointer

remove-bouncing-email-address-of-hennus-bergman.patch
  remove bouncing email address of Hennus Bergman

i386-apic-kconfig-cleanups.patch
  i386 APIC Kconfig cleanups

remove-bouncing-email-address-of-thomas-hood.patch
  remove bouncing email address of Thomas Hood

fs-adfs-dir_fc-remove-an-unused-function.patch
  fs/adfs/dir_f.c: remove an unused function

drivers-char-moxac-if-0-an-unused-function.patch
  drivers/char/moxa.c: #if 0 an unused function

oss-sb_cardc-no-need-to-include-mcah.patch
  OSS sb_card.c: no need to include mca.h

ioschedc-use-proper-documentation-path.patch
  *-iosched.c: Use proper documentation path

small-drivers-video-kyro-cleanups.patch
  small drivers/video/kyro/ cleanups

drivers-block-cpqarrayc-small-cleanups.patch
  drivers/block/cpqarray.c: small cleanups

pcxx-remove-obsolete-driver.patch
  pcxx: Remove obsolete driver

warning-fix-in-drivers-cdrom-mcdc.patch
  warning fix in drivers/cdrom/mcd.c

wavefront-reduce-stack-usage.patch
  wavefront: reduce stack usage

mm-page-writebackc-remove-an-unused-function-2.patch
  mm/page-writeback.c: remove an unused function #2

generic_serialh-kill-incorrect-gs_debug-reference.patch
  generic_serial.h: kill incorrect gs_debug reference

remove-the-unused-oss-maestro_tablesh.patch
  remove the unused OSS maestro_tables.h

fs-hfs-misc-cleanups.patch
  fs/hfs/: misc cleanups

fs-hfsplus-misc-cleanups.patch
  fs/hfsplus/: misc cleanups

i386-math-emu-misc-cleanups.patch
  i386/math-emu/: misc cleanups

non-pc-parport-config-change.patch
  non-PC parport config change

prism54-misc-cleanups.patch
  prism54: misc cleanups

scsi-qlogicfcc-some-cleanups.patch
  SCSI qlogicfc.c: some cleanups

scsi-qlogicispc-some-cleanups.patch
  SCSI qlogicisp.c: some cleanups

hpet-setup-comment-fix.patch
  hpet setup comment fix

kill-iphase5526.patch
  kill IPHASE5526

i386-x86_64-acpi-sleepc-kill-unused-acpi_save_state_disk.patch
  i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk

smpbootc-cleanups.patch
  smp{,boot}.c cleanups

i386-kernel-i387c-misc-cleanups.patch
  i386/kernel/i387.c: misc cleanups

mxserc-remove-unused-variable.patch
  mxser.c: remove unused variable

update-panic-comment.patch
  Update panic() comment

pm3fb-remove-kernel-22-code.patch
  pm3fb: remove kernel 2.2 code

drivers-block-paride-cleanups.patch
  drivers/block/paride/ cleanups (fwd)

remove-obsolete-linux-resourceh-inclusion-from-asm-generic-siginfoh.patch
  remove obsolete linux/resource.h inclusion from asm-generic/siginfo.h

fix-pm_message_t-in-generic-code.patch
  Fix pm_message_t in generic code

fix-u32-vs-pm_message_t-in-usb.patch
  Fix u32 vs. pm_message_t in USB

fix-u32-vs-pm_message_t-confusion-in-oss.patch
  Fix u32 vs. pm_message_t confusion in OSS

fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
  Fix u32 vs. pm_message_t confusion in PCMCIA

fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
  Fix u32 vs. pm_message_t confusion in framebuffers

fix-u32-vs-pm_message_t-confusion-in-mmc.patch
  Fix u32 vs. pm_message_t confusion in MMC

fix-u32-vs-pm_message_t-confusion-in-serials.patch
  Fix u32 vs. pm_message_t confusion in serials

fix-u32-vs-pm_message_t-in-macintosh.patch
  Fix u32 vs. pm_message_t in macintosh

fix-u32-vs-pm_message_t-confusion-in-agp.patch
  Fix u32 vs. pm_message_t confusion in AGP

fs-jffs-misc-cleanups.patch
  fs/jffs/: misc cleanups

fs-jffs2-misc-cleanups.patch
  fs/jffs2/: misc cleanups

drivers-block-cciss-misc-cleanups.patch
  drivers/block/cciss*: misc cleanups

remove-unused-get_resource_list-declaration.patch
  Remove unused get_resource_list() declaration

typo-in-include-linux-compilerh.patch
  typo in include/linux/compiler.h

mark-blk_dev_ps2-as-broken.patch
  mark BLK_DEV_PS2 as BROKEN

vsprintfc-cleanups.patch
  vsprintf.c cleanups

i386-scx200c-misc-cleanups.patch
  i386 scx200.c: misc cleanups

unexport-mmu_cr4_features.patch
  unexport mmu_cr4_features

drivers-char-mxserc-cleanups.patch
  drivers/char/mxser.c cleanups

drivers-char-mwave-smapic-small-cleanups.patch
  drivers/char/mwave/smapi.c: small cleanups

drivers-char-specialixc-misc-cleanups.patch
  drivers/char/specialix.c: misc cleanups

drivers-char-sysrqc-remove-the-unused-sysrq_power_off.patch
  drivers/char/sysrq.c: remove the unused sysrq_power_off

small-partitions-msdos-cleanups.patch
  small partitions/msdos cleanups

drivers-char-vt-cleanups.patch
  drivers/char/vt*: cleanups

removes-unused-label-from-drivers-isdn-hisax-hisax_fcpcipnpc.patch
  Removes unused label from /drivers/isdn/hisax/hisax_fcpcipnp.c



