Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932244AbWFDU40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWFDU40 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWFDU40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:56:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbWFDU4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:56:25 -0400
Date: Sun, 4 Jun 2006 13:50:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 -mm merge plans
Message-Id: <20060604135011.decdc7c9.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's time to take a look at the -mm queue for 2.6.18.

There is an unusually large amount of difficult material here.  If you were
bcc'ed, please take the time to think about what we should do.

I have an Asia trip June 10-17 which will probably be during the 2.6.18
merge window.  It'll take some time to get all this material sorted out in
a decent fashion so I might end up having to ask Linus to delay -rc1 by a
week or so.  We'll see.


When replying to this email pleeeeeeze rewrite the Subject: to something
appropriate so we do not all go mad.  Thanks.




The list:

git-hdrcleanup.patch
git-hdrinstall.patch

 This is Dave Woodhouse's work cleaning up the kernel headers and adding a
 `make headerinstall' target which automates the exporting of kernel
 headers as a userspace-usable package.

 All I can say about this is that it doesn't appear to break anything and
 is ready to merge from that point of view.  It's not an area in which I
 have much interest or knowledge.

 That being said, it's relatively costly to carry such extensive patches
 in -mm for long periods, so I'd ask Linus and the distro people to work
 out what we want to do here promptly, please.

git-klibc.patch

 Similar.  This all appears to work sufficiently well for a 2.6.18 merge. 
 But it's been so long since klibc was a hot topic that I've forgotten who
 wanted it, and what for.

 Can whoever has an interest in this work please pipe up and let's get our
 direction sorted out quickly.

fix-hpet-operation-on-32-bit-nvidia-platforms.patch
fix-hpet-operation-on-32-bit-nvidia-platforms-build-fix.patch
fix-hpet-operation-on-64-bit-nvidia-platforms.patch

 These are bugfixes and are a marginal call for 2.6.17.  But they're
 playing in fragile areas, they're quite new and I fixed a bug in here just
 a couple of hours ago.  So I'll hold these off until 2.6.18-rc1 and will
 tag them for a 2.6.17.x backport.

acpi-update-asus_acpi-driver-registration-fix.patch
acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces.patch
catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device.patch
catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory.patch
kevent-add-new-uevent.patch
acpi-dock-driver.patch
acpiphp-use-new-dock-driver.patch
acpiphp-prevent-duplicate-slot-numbers-when-no-_sun.patch
asus_acpi-w3000-support.patch
acpi-atlas-acpi-driver.patch
acpi-atlas-acpi-driver-fix.patch
remove-acpi_os_create_lock-acpi_os_delete_lock.patch
asus_acpi-invert-read-of-wled-proc-file-to-show-correct.patch
2.6-sony_acpi4.patch
acpi-remove-__init-__exit-from-sony-add-remove-methods.patch
sony_apci-resume.patch
git-agpgart.patch
uninorth-agp-warning-fixes.patch
alpha-agp-warning-fix.patch
git-alsa.patch
fix-drivers-mfd-ucb1x00-corec-irq-probing-bug.patch
kauditd_thread-warning-fix.patch
blk_start_queue-must-be-called-with-irq-disabled-add-warning.patch
blktrace_apih-endian-annotations.patch
powernow-k8-crash-workaround.patch
dprintk-adjustments-to-cpufreq-nforce2.patch
dprintk-adjustments-to-cpufreq-speedstep-centrino.patch
cpufreq-dprintk-adjustments.patch
create-sys-hypervisor-when-needed.patch
trivial-videodev2h-patch.patch
scx200_acb-use-pci-i-o-resource-when-appropriate.patch
i2c-pca954x-i2c-mux-driver.patch
i2c-mpc-fix-up-error-handling.patch
opencores-i2c-bus-driver.patch
i2c-pca954x-fix-initial-access-to-first-mux-switch-port.patch
ieee1394-video1394-be-quiet.patch
ieee1394-ohci1394c-function-calls-without.patch
ieee1394-sbp2-make-tsb42aa9-workaround-specific.patch
ieee1394-semaphore-to-mutex-conversion.patch
ieee1394-raw1394-fix-whitespace-after-x86_64.patch
ieee1394-ieee1394-ohci1394-cycletoolong.patch
ieee1394-ieee1394-support-for-slow-links-or-slow.patch
ieee1394-ieee1394-save-ram-by-using-a-single.patch
ieee1394-sbp2-remove-manipulation-of-inquiry.patch
ieee1394-sbp2-log-number-of-supported-concurrent.patch
ieee1394-ieee1394-extend-lowlevel-api-for.patch
ieee1394-ohci1394-set-address-range-properties.patch
ieee1394-ohci1394-make-phys_dma-parameter.patch
ieee1394-sbp2-sbp2-remove-ohci1394-specific.patch
ieee1394-sbp2-fix-s800-transfers-if-phys_dma-is.patch
ieee1394-update-feature-removal-of-obsolete.patch
ieee1394-sbp2-provide-helptext-for.patch
ieee1394-sbp2-kconfig-fix.patch
ieee1394-sbp2-use-__attribute__packed-for.patch
ieee1394-speed-up-of-dma_region_sync_for_cpu.patch
ieee1394-sbp2-fix-deregistration-of-status-fifo-address-space.patch
ieee1394-add-preprocessor-constant-for-invalid-csr.patch
fix-broken-suspend-resume-in-ohci1394-was-acpi-suspend.patch
ieee1394_core-switch-to-kthread-api.patch
eth1394-endian-fixes.patch
input-keyboard_tasklet-dont-touch-leds-of-already-grabed-device.patch
remove-silly-messages-from-input-layer.patch
via-pmu-add-input-device.patch
input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick.patch
mm-constify-drivers-char-keyboardc.patch
input-move-fixp-arithh-to-drivers-input.patch
input-fix-accuracy-of-fixp-arithh.patch
input-new-force-feedback-interface.patch
input-adapt-hid-force-feedback-drivers-for-the-new-interface.patch
input-adapt-uinput-for-the-new-force-feedback-interface.patch
input-adapt-iforce-driver-for-the-new-force-feedback-interface.patch
input-force-feedback-driver-for-pid-devices.patch
input-force-feedback-driver-for-zeroplus-devices.patch
input-update-documentation-of-force-feedback.patch
input-drop-the-remains-of-the-old-ff-interface.patch
input-drop-the-old-pid-driver.patch
input-use-enospc-instead-of-enomem-in-iforce-when-device-full.patch
add-dependency-on-kernelrelease-to-the-package-targets.patch
kconfig-improve-config-load-save-output.patch
kconfig-fix-config-dependencies.patch
kconfig-remove-symbol_yesmodno.patch
kconfig-allow-multiple-default-values-per-symbol.patch
kconfig-allow-loading-multiple-configurations.patch
kconfig-integrate-split-config-into-silentoldconfig.patch
kconfig-integrate-split-config-into-silentoldconfig-fix.patch
kconfig-move-kernelrelease.patch
kconfig-add-symbol-option-config-syntax.patch
kconfig-add-defconfig_list-module-option.patch
kconfig-add-search-option-for-xconfig.patch
kconfig-finer-customization-via-popup-menus.patch
kconfig-create-links-in-info-window.patch
kconfig-jump-to-linked-menu-prompt.patch
kconfig-warn-about-leading-whitespace-for-menu-prompts.patch
kconfig-remove-leading-whitespace-in-menu-prompts.patch
config-exit-if-no-beginning-filename.patch
make-kernelrelease-speedup.patch
kconfig-kconfig_overwriteconfig.patch
sane-menuconfig-colours.patch
kbuild-export-type-enhancement-to-modpostc.patch
kbuild-export-type-enhancement-to-modpostc-fix.patch
kbuild-prevent-building-modules-that-wont-load.patch
kbuild-export-symbol-usage-report-generator.patch
kbuild-obj-dirs-is-calculated-incorrectly-if-hostprogs-y-is-defined.patch
fix-make-rpm-for-powerpc.patch
revert-sata_sil24-sii3124-sata-driver-endian-problem.patch
libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma.patch
libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma-fix.patch
libata-reduce-timeouts.patch
libata-debug.patch
2.6.17-rc4-mm1-ich8-fix.patch
for_each_possible_cpu-mips.patch
sdhci-truncated-pointer-fix.patch
prevent-au1xmmcc-breakage-on-non-au1200-alchemy.patch
myri10ge-alpha-build-fix.patch
smc911x-Kconfig-fix.patch
tulip-natsemi-dp83840a-phy-fix.patch
natsemi-add-support-for-using-mii-port-with-no-phy.patch
pci-error-recovery-e1000-network-device-driver.patch
pci-error-recovery-e100-network-device-driver.patch
e1000-prevent-statistics-from-getting-garbled-during-reset.patch
e100-disable-interrupts-at-boot.patch
drivers-char-hw_randomc-remove-asserts.patch
forcedeth-config-ring-sizes.patch
forcedeth-config-flow-control.patch
forcedeth-config-phy.patch
forcedeth-config-wol.patch
forcedeth-config-csum.patch
forcedeth-config-statistics.patch
forcedeth-config-diagnostics.patch
forcedeth-config-module-parameters.patch
forcedeth-config-version.patch
forcedeth-new-device-ids.patch
forcedeth-typecast-cleanup.patch
add-a-pci-vendor-id-definition-for-aculab.patch
natsemi-add-quirks-for-aculab-e1-t1-pmxc-cpci-carrier-cards.patch
tulip-fix-for-64-bit-mips.patch
drivers-net-ns83820c-add-paramter-to-disable-auto.patch
fix-phy-id-for-lxt971a-lxt972a.patch
clean-up-initcall-warning-for-netconsole.patch
remove-dead-entry-in-net-wan-kconfig.patch
eliminate-unused-proc-sys-net-ethernet.patch
ppp_async-hang-fix.patch
selinux-add-security-class-for-appletalk-sockets.patch
neighbourc-pneigh_get_next-skips-published-entry.patch
secmark-add-new-flask-definitions-to-selinux.patch
secmark-add-selinux-exports.patch
secmark-add-secmark-support-to-core-networking.patch
secmark-add-xtables-secmark-target.patch
secmark-add-secmark-support-to-conntrack.patch
secmark-add-connsecmark-xtables-target.patch
secmark-add-new-packet-controls-to-selinux.patch
irda-missing-allocation-result-check-in-irlap_change_speed.patch
pppoe-missing-result-check-in-__pppoe_xmit.patch
lock-validator-netlinkc-netlink_table_grab-fix.patch
recent-match-fix-sleeping-function-called-from-invalid-context.patch
recent-match-missing-refcnt-initialization.patch
client-side-nfsacl-caching-fix.patch
nfs-really-return-status-from-decode_recall_args.patch
powerpc-kbuild-warning-fix.patch
serial-fix-uart_bug_txen-test.patch
revert-gregkh-pci-pci-test-that-drivers-properly-call-pci_set_master.patch
gregkh-pci-kconfigurable-resources-arch-dependent-changes-arm-fix.patch
gregkh-pci-pci-64-bit-resources-core-changes-mips-fix.patch
fix-pciehp-driver-on-non-acpi-systems.patch
gregkh-pci-acpiphp-configure-_prt-v3-cleanup.patch
kconfigurable-resources-mtd-fixes.patch
drivers-scsi-fix-proc_scsi_write-to-return-length-on.patch
drivers-scsi-sdc-fix-uninitialized-variable-in-handling-medium-errors.patch
drivers-scsi-aic7xxx-possible-cleanups.patch
drivers-scsi-small-cleanups.patch
drivers-scsi-megaraidc-add-a-dummy-mega_create_proc_entry-for-proc_fs=y.patch
drivers-scsi-qla2xxx-make-some-functions-static.patch
drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_done_with_status-static.patch
small-whitespace-cleanup-for-qlogic-driver.patch
remove-drivers-scsi-constantscscsi_print_req_sense.patch
drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_match_scb-static.patch
aic7xxx-deinline-large-functions-save-80k-of-text.patch
aic7xxx-s-__inline-inline.patch
drivers-scsi-aic7xxx-possible-cleanups-2.patch
scsi-remove-documentation-scsi-cpqfctxt.patch
mpt-fusion-driver-initialization-failure-fix.patch
drivers-scsi-use-array_size-macro.patch
lpfc-sparse-null-warnings.patch
mpt_interrupt-should-return-irq_none-when.patch
aic7-cleanup-module_parm_desc-strings.patch
random-remove-redundant-sa_sample_random-from-ninjascsi.patch
megaraid-gcc-41-warning-fix.patch
buslogic-gcc-41-warning-fixes.patch
add-scsi_add_host-failure-handling-for-nsp32.patch
qla1280-fix-section-mismatch-warnings.patch
bogus-disk-geometry-on-large-disks.patch
megaraid_sas-switch-fw_outstanding-to-an-atomic_t.patch
megaraid_sas-add-support-for-zcr-controller.patch
megaraid_sas-add-support-for-zcr-controller-fix.patch
gdth-add-execute-firmware-command-abstraction.patch
drivers-scsi-gdthc-make-__gdth_execute-static.patch
areca-raid-linux-scsi-driver.patch
scsi-clean-up-warnings-in-advansys-driver.patch
git-scsi-target-warning-fix.patch
touchkit-ps-2-touchscreen-driver.patch
fix-sco-on-some-bluetooth-adapters-2.patch
fall-back-to-old-style-call-trace-if-no-unwinding.patch
allow-unwinder-to-build-without-module-support.patch
x86_64-mm-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
add-abilty-to-enable-disable-nmi-watchdog-from-procfs.patch
x86_64-unexport-ia32_sys_call_table.patch
x86_64-msi-apic-build-fix.patch
x86_64-dont-warn-for-overflow-in-nommu-case-when-dma_mask-is-32bit-fix.patch
lock-validator-lockdep-small-xfs-init_rwsem-cleanup.patch

  That's over 200 patches which need to be handled by subsystem
  maintainers.  I continue to have some difficulty getting this material
  processed.

  I'll try to make Thursdays be my unload-stuff-on-maintainers day. 
  Hopefully the boredom of seeing the same patches over and over will
  motivate some merging, nacking and fixing.

  I'm going to start sending the Areca driver to James, too.  The vendor
  has worked hard and the hardware is becoming more important - let's help
  them get it in.

  I'll henceforth include the highpoint rocketraid controller driver
  (hptiop-highpoint-rocketraid-3xxx-controller-driver.patch) as well.

s390_hypfs-filesystem.patch

 Will merge

mm-vm_bug_on.patch
mm-thrash-detect-process-thrashing-against-itself.patch
zone-init-check-and-report-unaligned-zone-boundaries.patch
x86-align-highmem-zone-boundaries-with-numa.patch
zone-allow-unaligned-zone-boundaries.patch
zone-allow-unaligned-zone-boundaries-x86-add-zone-alignment-qualifier.patch
page-migration-make-do_swap_page-redo-the-fault.patch
slab-extract-cache_free_alien-from-__cache_free.patch
pg_uncached-is-ia64-only.patch
slab-page-mapping-cleanup.patch
migration-remove-unnecessary-pageswapcache-checks.patch
wait_table-and-zonelist-initializing-for-memory-hotadd-change-name-of-wait_table_size.patch
wait_table-and-zonelist-initializing-for-memory-hotadd-change-to-meminit-for-build_zonelist.patch
wait_table-and-zonelist-initializing-for-memory-hotaddadd-return-code-for-init_current_empty_zone.patch
wait_table-and-zonelist-initializing-for-memory-hotadd-wait_table-initialization.patch
wait_table-and-zonelist-initializing-for-memory-hotadd-update-zonelists.patch
squash-duplicate-page_to_pfn-and-pfn_to_page.patch
support-for-panic-at-oom.patch
mm-fix-typos-in-comments-in-mm-oom_killc.patch
reserve-space-for-swap-label.patch
tightening-hugetlb-strict-accounting.patch
slab-cleanup-kmem_getpages.patch
slab-stop-using-list_for_each.patch
swsusp-rework-memory-shrinker-rev-2.patch
unify-pxm_to_node-and-node_to_pxm.patch
pgdat-allocation-for-new-node-add-specify-node-id.patch
pgdat-allocation-for-new-node-add-get-node-id-by-acpi.patch
pgdat-allocation-for-new-node-add-generic-alloc-node_data.patch
pgdat-allocation-for-new-node-add-refresh-node_data.patch
pgdat-allocation-for-new-node-add-export-kswapd-start-func.patch
pgdat-allocation-for-new-node-add-call-pgdat-allocation.patch
register-hot-added-memory-to-iomem-resource.patch
catch-valid-mem-range-at-onlining-memory.patch
fix-compile-error-undefined-reference-for-sparc64.patch
register-sysfs-file-for-hotpluged-new-node.patch
pgdat-allocation-and-update-for-ia64-of-memory-hotplughold-pgdat-address-at-system-running.patch
pgdat-allocation-and-update-for-ia64-of-memory-hotplug-update-pgdat-address-array.patch
pgdat-allocation-and-update-for-ia64-of-memory-hotplugallocate-pgdat-and-per-node-data.patch
mm-introduce-remap_vmalloc_range.patch
change-gen_pool-allocator-to-not-touch-managed-memory.patch
radix-tree-direct-data.patch
radix-tree-small.patch
likely-cleanup-remove-unlikely-in-sys_mprotect.patch
slab-redzone-double-free-detection.patch
buglet-in-radix_tree_tag_set.patch
writeback-fix-range-handling.patch
page-migration-cleanup-rename-ignrefs-to-migration.patch
page-migration-cleanup-group-functions.patch
page-migration-cleanup-remove-useless-definitions.patch
page-migration-cleanup-drop-nr_refs-in-remove_references.patch
page-migration-cleanup-extract-try_to_unmap-from-migration-functions.patch
page-migration-cleanup-pass-mapping-to-migration-functions.patch
page-migration-cleanup-move-fallback-handling-into-special-function.patch
swapless-pm-add-r-w-migration-entries.patch
swapless-pm-add-r-w-migration-entries-fix-2.patch
swapless-page-migration-rip-out-swap-based-logic.patch
swapless-page-migration-modify-core-logic.patch
more-page-migration-do-not-inc-dec-rss-counters.patch
more-page-migration-use-migration-entries-for-file-pages.patch
page-migration-update-documentation.patch
aop_truncated_page-victims-in-read_pages-belong-in-the-lru.patch
flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch
slab-verify-pointers-before-free.patch
sparsemem-record-nid-during-memory-present.patch
mm-cleanup-swap-unused-warning.patch
node-hotplug-register-cpu-remove-node-struct.patch
node-hotplug-register-cpu-remove-node-struct-alpha-fix.patch
add-page_mkwrite-vm_operations-method.patch
mm-remove-vm_locked-before-remap_pfn_range-and-drop-vm_shm.patch
swapoff-atomic_inc_not_zero-on-mm_users.patch
remove-unused-o_flags-from-do_shmat.patch
fix-update_mmu_cache-in-fremapc.patch
fix-update_mmu_cache-in-fremapc-fix.patch
mm-slabc-fix-early-init-assumption.patch

  Memory management.  Will merge.

page-migration-simplify-migrate_pages.patch
page-migration-simplify-migrate_pages-tweaks.patch
page-migration-handle-freeing-of-pages-in-migrate_pages.patch
page-migration-use-allocator-function-for-migrate_pages.patch
page-migration-support-moving-of-individual-pages.patch
page-migration-detailed-status-for-moving-of-individual-pages.patch
page-migration-support-moving-of-individual-pages-fixes.patch
page-migration-support-moving-of-individual-pages-x86_64-support.patch
page-migration-support-moving-of-individual-pages-x86-support.patch
page-migration-support-moving-of-individual-pages-x86-support-fix.patch
page-migration-support-a-vma-migration-function.patch
allow-migration-of-mlocked-pages.patch

  Post-2.6.18.

acx1xx-wireless-driver.patch
fix-tiacx-on-alpha.patch
tiacx-fix-attribute-packed-warnings.patch
tiacx-pci-build-fix.patch
tiacx-ia64-fix.patch

  It is about time we did something with this large and presumably useful
  wireless driver.

lsm-add-task_setioprio-hook.patch
selinux-add-hooks-for-key-subsystem.patch
au1550-1200-add-missing-psc-defines-make-oss-driver-use.patch

  Will merge.

x86-cache-pollution-aware-__copy_from_user_ll.patch
x86-cpu_init-avoid-gfp_kernel-allocation-while-atomic.patch
arch-i386-kernel-apicc-make-modern_apic-static.patch
i386-apmc-optimization.patch
x86-dont-trigger-full-rebuild-via-config_mtrr.patch
fix-x86-microcode-driver-handling-of-multiple-matching.patch
i386-break-out-of-recursion-in-stackframe-walk.patch
dont-trigger-full-rebuild-via-config_x86_mce.patch
x86-increase-interrupt-vector-range.patch
x86-call-eisa_set_level_irq-in-pcibios_lookup_irq.patch
x86-kernel-irq-balancer-fix.patch
x86-kernel-irq-balancer-fix-tidy.patch
i386-let-usermode-execute-the-enter.patch
fix-broken-vm86-interrupt-signal-handling.patch
x86-re-enable-generic-numa.patch
x86-make-using_apic_timer-__read_mostly.patch
x86-cyrix-code-config_pci-fix--add-__initdata.patch
x86-constify-some-parts-of-arch-i386-kernel-cpu.patch
x86-make-i387-mxcsr_feature_mask-__read_mostly.patch
x86-make-acpi-errata-__read_mostly.patch
x86-constify-arch-i386-pci-irqc.patch
x86-use-proper-defines-for-i8259a-i-o.patch
i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86.patch
i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
i386-fix-get_segment_eip-with-vm86.patch
i386-dont-try-kprobes-for-v8086-mode.patch

 x86 queue.  Will mostly merge.  I have a note here that Zach Amsden had
 issues with x86-cpu_init-avoid-gfp_kernel-allocation-while-atomic.patch?

 x86-cache-pollution-aware-__copy_from_user_ll.patch has been in -mm for a
 very long time - it's never been clear that it's a net gain.  Will
 merge-and-see-what-happens I guess.

support-physical-cpu-hotplug-for-x86_64.patch

 I think this got nacked.  Will resend, see what happens.

vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-tidy.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-arch_vma_name-fix.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2.patch

 Will merge.

powerpc-vdso-updates.patch

 Will send to Paul.

remove-duplicate-symbol-exports-on-alpha.patch
alpha-generic-hweight-build-fix.patch

 Will merge.

remove-empty-node-at-boot-time.patch

 Will send to Tony when the prerequisites are merged.

swsusp-add-architecture-special-saveable-pages-support.patch
swsusp-i386-mark-special-saveable-unsaveable-pages.patch
swsusp-x86_64-mark-special-saveable-unsaveable-pages.patch
swsusp-take-lowmem-reserves-into-account.patch
kernel-power-snapshotc-cleanups.patch
swsusp-use-less-memory-during-resume.patch
dont-use-flush_tlb_all-in-suspend-time.patch
swsusp-documentation-updates.patch

 Will merge.

m68k-completely-initialize-hw_regs_t-in-ide_setup_ports.patch
m68k-atyfb_base-compile-fix-for-config_pci=n.patch
m68k-cleanup-unistdh.patch
m68k-remove-some-unused-definitions-in-zorroh.patch
m68k-use-c99-initializer.patch
m68k-print-correct-stack-trace.patch
m68k-restore-amikbd-compatibility-with-24.patch
m68k-extra-delay.patch
m68k-use-proper-defines-for-zone-initialization.patch
m68k-adjust-to-changed-hardirq_mask.patch
m68k-m68k-mac-via2-fixes-and-cleanups.patch

 Will merge.

uml-make-copy__user-atomic.patch
uml-fix-not_dead_yet-when-directory-is-in-bad-state.patch
uml-rename-and-improve-actually_do_remove.patch

 These are marked "mm only".  I'm not sure if that's permanent?

xtensa-remove-verify_area-macros.patch
xtensa-remove-verify_area-macros-fix.patch

 Will merge.

remove-fs-jffs2-ioctlc.patch

 Will re-re-re-spam maintainer.

work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
kernel-kernel-cpuc-to-mutexes.patch

 ug.  We cannot convert the cpu.c semaphore into a mutex until we work out
 why power4 goes titsup if you enable local interrupts during boot.

fix-a-race-condition-between-i_mapping-and-iput.patch
insert-identical-resources-above-existing-resources.patch
make-sure-nobodys-leaking-resources.patch
remove-steal_locks.patch
avoid-tasklist_lock-at-getrusage-for-multithreaded-case-too.patch
add-prctl-to-change-endian-of-a-task.patch
#writeback-fix-range-handling.patch
fix-dcache-race-during-umount.patch
prune_one_dentry-tweaks.patch
vgacon-make-vga_map_mem-take-size-remove-extra-use.patch
zlib_inflate-upgrade-library-code-to-a-recent-version.patch
zlib_inflate-upgrade-library-code-to-a-recent-version-fix.patch
initramfs-cpio-unpacking-fix.patch
fix-cdrom-being-confused-on-using-kdump.patch
read_mapping_page-for-address-space.patch
locks-dont-unnecessarily-fail-posix-lock-operations.patch
locks-dont-do-unnecessary-allocations.patch
locks-clean-up-locks_remove_posix.patch
vfs-add-lock-owner-argument-to-flush-operation.patch
fs-locksc-make-posix_locks_deadlock-static.patch
moduleh-updated-comments-with-a-new.patch
remove-config_parport_arc-drivers-parport-parport_arcc.patch
add-poisonh-and-patch-primary-users.patch
update-2-drivers-for-poisonh.patch
mmput-might-sleep.patch
fs-fat-miscc-unexport-fat_sync_bhs.patch
poll-cleanups-microoptimizations.patch
ptrace-document-the-locking-rules.patch
cleanup-default-value-of-sched_smt.patch
cleanup-default-value-of-syscall_debug.patch
cleanup-default-value-of-usb_isp116x_hcd-usb_sl811_hcd-and-usb_sl811_cs.patch
cleanup-default-value-of-ip_dccp_ackvec.patch
cleanup-default-value-of-dvb_cinergyt2_enable_rc_input_device.patch
dup-fd-error.patch
rtc-framework-driver-for-ds1307-and-similar-rtc-chips.patch
cond-resched-might-sleep-fix.patch
enhancing-accessibility-of-lxdialog.patch
the-scheduled-unexport-of-insert_resource.patch
jbd-fix-bug-in-journal_commit_transaction.patch
jbd-fix-bug-in-journal_commit_transaction-fix.patch
rename-swapper-to-idle.patch
oss-cs46xx-cleanup-and-tiny-bugfix.patch
i4l-memory-leak-fix-for-sc_ioctl.patch
isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub.patch
isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub-fix.patch
invert-irq-migrationc-brach-prediction.patch
x86-powerpc-make-hardirq_ctx-and-softirq_ctx-__read_mostly.patch
jbd-avoid-kfree-null.patch
ext3_clear_inode-avoid-kfree-null.patch
make-noirqdebug-irqfixup-__read_mostly-add-unlikely.patch
leds-amstrad-delta-led-support.patch
leds-amstrad-delta-led-support-tidy.patch
update-devicestxt.patch
binfmt_elf-codingstyle-cleanup-and-remove-some-pointless-casts.patch
binfnt_elf-remove-more-casts.patch
fix-incorrect-sa_onstack-behaviour-for-64-bit-processes.patch
percpu-counters-add-percpu_counter_exceeds.patch
percpu-counter-data-type-changes-to-suppport.patch
remove-unlikely-in-might_sleep_if.patch
process-events-header-cleanup.patch
process-events-license-change.patch
strstrip-api.patch
ipmi-strstrip-conversion.patch
connector-exports.patch
config_net=n-build-fix.patch
remove-softlockup-from-invalidate_mapping_pages.patch
add-doc-submitchecklist.patch
kernel-sysc-doesnt-need-inith.patch
make-rcu-api-inaccessible-to-non-gpl-linux-kernel-modules.patch
doc-add-audit-acct-to-docbook.patch
ip2-fix-sections.patch
sgi-ioc4-detect-io-card-variant.patch
two-additions-to-linux-documentation-ioctl-numbertxt.patch
list-introduce-list_replace-helper.patch
list-use-list_replace_init-instead-of-list_splice_init.patch
when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop.patch
when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop-use-list_replace_init.patch
codingstyle-add-typedefs-chapter.patch
fs-bufferc-possible-cleanups.patch
rtc-rtc-dev-uie-emulation.patch
drivers-md-raid6algosc-fix-a-null-dereference.patch
adjust-handle_irr_event-return-type.patch
sparse-fixes-for-synclink_cs.patch
jbd-split-checkpoint-lists.patch
add-__iowrite64_copy.patch
mark-address_space_operations-const.patch
more-bug_on-conversion.patch
make-kernel-ignore-bogus-partitions.patch
drivers-block-loopc-dont-return-garbage-if-loop_set_status-not-called.patch
docs-update-sparsetxt-with-check_endian.patch
drivers-acorn-char-pcf8583-vs-rtc-subsystem.patch
rewritten-backlight-infrastructure-for-portable-apple-computers.patch
rewritten-backlight-infrastructure-for-portable-apple-computers-fix.patch
ensure-null-deref-cant-possibly-happen-in-is_exported.patch
bluetooth-fix-potential-null-ptr-deref-in-dtl1_cscdtl1_hci_send_frame.patch
bloat-o-meter-gcc-4-fix.patch
random-remove-sa_sample_random-from-floppy-driver.patch
random-make-cciss-use-add_disk_randomness.patch
random-change-cpqarray-to-use-add_disk_randomness.patch
random-remove-bogus-sa_sample_random-from-at91-compact-flash-driver.patch
random-remove-redundant-sa_sample_random-from-touchscreen-drivers.patch
define-__raw_get_cpu_var-and-use-it.patch
allow-for-per-cpu-data-being-in-tdata-and-tbss-sections.patch
allow-for-per-cpu-data-being-in-tdata-and-tbss-sections-fix.patch
allow-for-per-cpu-data-being-in-tdata-and-tbss-sections-tidy.patch
deprecate-smbfs-in-favour-of-cifs.patch
allow-raw_notifier-callouts-to-unregister-themselves.patch
hptiop-highpoint-rocketraid-3xxx-controller-driver.patch
fix-kbuild-dependencies-for-synclink-drivers.patch
fs-freevxfs-cleanup-of-spelling-errors.patch
pnp-card_probe-fix-memory-leak.patch
ufs-ufs_trunc_indirect-infinite-cycle.patch
ufs-right-block-allocation.patch
ufs-change-block-number-on-the-fly.patch
ufs-directory-and-page-cache-install-aops.patch
ufs-directory-and-page-cache-from-blocks-to-pages.patch
ufs-wrong-type-cast.patch
ufs-not-usual-amounts-of-fragments-per-block.patch
ufs-unmark-config_ufs_fs_write-as-broken-mm-tree.patch
ufs-easy-debug.patch
ufs-little-directory-lookup-optimization.patch
ufs-i_blocks-wrong-count.patch
ufs-unlock_super-without-lock.patch
ufs-zero-metadata.patch
ufs-printk-warning-fixes.patch
oprofile-fix-unnecessary-cleverness.patch
msnd-section-fix.patch
oprofile-convert-from-semaphores-to-mutexes.patch
drivers-char-applicomc-proper-module_initexit.patch
remove-dead-entry-in-net-wan-makefile.patch
openpromfs-fix-missing-nul.patch
openpromfs-remove-unnecessary-casts.patch
openpromfs-factorize-out.patch
openpromfs-factorize-out-tidy.patch
idetape-gcc-41-warning-fix.patch
add-driver-for-arm-amba-pl031-rtc.patch
rtc-subsystem-fix-capability-checks-in-kernel-interface.patch
rtc-subsystem-add-capability-checks.patch
add-export_unused_symbol-and-export_unused_symbol_gpl.patch
add-export_unused_symbol-and-export_unused_symbol_gpl-default.patch
make-printk-work-for-really-early-debugging.patch
kernel-sysc-cleanups.patch
kernel-sysc-cleanups-fix.patch
nbd-kill-obsolete-changelog-add-gpl.patch
fix-listh-kernel-doc.patch
listh-doc-change-counter-to-control.patch
fix-magic-sysrq-on-strange-keyboards.patch
ide-cd-end-of-media-error-fix.patch
add-a-sysfs-file-to-determine-if-a-kexec-kernel-is-loaded.patch
cpqarray-section-fix.patch
pdflush-handle-resume-wakeups.patch
edd-isnt-experimental-anymore.patch
kernel-doc-drop-leading-space-in-sections.patch
kernel-doc-script-cleanups.patch
schedule_on_each_cpu-reduce-kmalloc-size.patch
avoid-disk-sector_t-overflow-for-2tb-ext3-filesystem.patch
cleanup-dead-code-from-ext2-mount-code.patch
fix-memory-leak-when-the-ext3s-journal-file-is-corrupted.patch
remove-inconsistent-space-before-exclamation-point-in-ext3s-mount-code.patch
moxa-remove-pointless-casts.patch
moxa-remove-pointless-check-of-tty-argument-vs-null.patch
moxa-partial-codingstyle-cleanup-spelling-fixes.patch
updated-kdump-documentation.patch
cpuset-remove-extra-cpuset_zone_allowed-check-in-__alloc_pages.patch
spin-rwlock-init-cleanups.patch
make-debug_mutex_on-__read_mostly.patch
constify-parts-of-kernel-power.patch
constify-libcrc32c-table.patch
apple-motion-sensor-driver.patch
prepare-for-__copy_from_user_inatomic-to-not-zero-missed-bytes.patch
make-copy_from_user_inatomic-not-zero-the-tail-on-i386.patch
remove-unecessary-null-check-in-kernel-acctc.patch
ax88796-parallel-port-driver.patch
ax88796-parallel-port-driver-build-fix.patch
wd7000-fix-section-mismatch-warnings.patch
megaraid_mbox-fix-section-mismatch-warnings.patch
keys-fix-race-between-two-instantiators-of-a-key.patch
keys-fix-race-between-two-instantiators-of-a-key-tidy.patch
ext3_fsblk_t-filesystem-group-blocks-and-bug-fixes.patch
ext3_fsblk_t-the-rest-of-in-kernel-filesystem-blocks.patch
list_del-debug.patch
inotify-split-kernel-api-from-userspace-support.patch
inotify-add-names-inode-to-event-handler.patch
inotify-add-interfaces-to-kernel-api.patch
inotify-allow-watch-removal-from-event-handler.patch
inotify-update-kernel-documentation.patch
kernel-doc-mm-readhead-fixup.patch
make-procfs-obligatory-except-under-config_embedded.patch
lock-validator-introduce-warn_on_oncecond.patch
lock-validator-introduce-warn_on_oncecond-speedup.patch
make-sysctl-obligatory-except-under-config_embedded.patch
for_each_cpu_mask-warning-fix.patch
emu10k1-mark-midi_spinlock-as-used.patch
add-max6902-rtc-support.patch
add-max6902-rtc-support-update.patch
add-max6902-rtc-support-tidy.patch
rtc-small-documentation-update.patch
#big-kernel-lock-contention-in-do_open-and-blkdev_put.patch
make-ext2_debug-work-again.patch
nbd-endian-annotations.patch
epoll-use-unlocked-wqueue-operations.patch

 This is the misc-random-stuff-which-doesnt-have-a-subsystem-tree queue. 
 Will mostly merge, based upon re-review.

use-list_add_tail-instead-of-list_add.patch
arch-use-list_move.patch
core-use-list_move.patch
net-rxrpc-use-list_move.patch
drivers-use-list_move.patch
fs-use-list_move.patch

 Will merge.

per-task-delay-accounting-setup.patch
per-task-delay-accounting-setup-fix-1.patch
per-task-delay-accounting-setup-fix-2.patch
per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch
per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection-fix-1.patch
per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch
per-task-delay-accounting-cpu-delay-collection-via-schedstats-fix-1.patch
per-task-delay-accounting-utilities-for-genetlink-usage.patch
per-task-delay-accounting-taskstats-interface.patch
per-task-delay-accounting-taskstats-interface-fix-1.patch
per-task-delay-accounting-taskstats-interface-fix-2.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
per-task-delay-accounting-documentation.patch
per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch
per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch

 I just don't know.  There are a number of groups who pop up with various
 enhanced accounting requirements and patches (all quite different) but I
 haven't heard a lot of enthusiasm from any of them over this work, which
 attempts to provide an extensible framework for accumulation and querying
 of per-task metrics.

 But then again, we cannot just sit there and wait for everyone to be 100%
 happy.  So I'm 51% inclined to push this along.

 Anyone else who has an interest in this sort of thing needs to be aware
 that there will be an expectation that any future statistics submissions
 should use these interfaces.  So the time to pay attention is right now.

time-clocksource-infrastructure.patch
time-clocksource-infrastructure-dont-enable-irq-too-early.patch
time-use-clocksource-infrastructure-for-update_wall_time.patch
time-use-clocksource-infrastructure-for-update_wall_time-mark-few-functions-as-__init.patch
time-let-user-request-precision-from-current_tick_length.patch
time-use-clocksource-abstraction-for-ntp-adjustments.patch
time-use-clocksource-abstraction-for-ntp-adjustments-optimize-out-some-mults-since-gcc-cant-avoid-them.patch
time-introduce-arch-generic-time-accessors.patch
hangcheck-remove-monotomic_clock-on-x86.patch
time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
time-i386-conversion-part-2-rework-tsc-support.patch
time-i386-conversion-part-3-enable-generic-timekeeping.patch
time-i386-conversion-part-4-remove-old-timer_opts-code.patch
time-i386-clocksource-drivers.patch
time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy.patch
time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup.patch
time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup-fix-missing-to-rename-pmtmr_good-to-acpi_pm_good.patch
time-i386-clocksource-drivers-fix-spelling-typos.patch
time-rename-clocksource-functions.patch
make-pmtmr_ioport-__read_mostly.patch
generic-time-add-macro-to-simplify-hide-mask.patch
time-fix-time-going-backward-w-clock=pit.patch

 John's x86 time clocksource patches.   Will merge.  At last.

kprobe-boost-2byte-opcodes-on-i386.patch
kprobemulti-kprobe-posthandler-for-booster.patch
kprobemulti-kprobe-posthandler-for-booster-kprobes-bugfix-of-kprobe-booster-reenable-kprobe-booster.patch
notify-page-fault-call-chain-for-x86_64.patch
notify-page-fault-call-chain-for-i386.patch
notify-page-fault-call-chain-for-ia64.patch
notify-page-fault-call-chain-for-powerpc.patch
notify-page-fault-call-chain-for-sparc64.patch
kprobes-registers-for-notify-page-fault.patch
notify-page-fault-call-chain.patch

 Will merge.

kconfig-select-things-at-the-closest-tristate-instead-of-bool.patch

 <wonders what this is>

sched-fix-smt-nice-lock-contention-and-optimization.patch
sched-fix-smt-nice-lock-contention-and-optimization-tidy.patch

 Will merge.

sched-comment-bitmap-size-accounting.patch
sched-fix-interactive-ceiling-code.patch
unnecessary-long-index-i-in-sched.patch
sched-implement-smpnice.patch
sched-protect-calculation-of-max_pull-from-integer-wrap.patch
sched-store-weighted-load-on-up.patch
sched-add-discrete-weighted-cpu-load-function.patch
sched-prevent-high-load-weight-tasks-suppressing-balancing.patch
sched-improve-stability-of-smpnice-load-balancing.patch
sched-improve-smpnice-load-balancing-when-load-per-task.patch
smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing.patch
smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix.patch
smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix-2patch.patch
sched-modify-move_tasks-to-improve-load-balancing-outcomes.patch
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks-fix-2.patch
sched_domain-handle-kmalloc-failure.patch
sched_domain-handle-kmalloc-failure-fix.patch
sched_domain-dont-use-gfp_atomic.patch
sched_domain-use-kmalloc_node.patch
sched_domain-allocate-sched_group-structures-dynamically.patch
sched2-sched-domain-sysctl.patch

 It's all been quiet on the sched performance regressions front lately. 
 I'll ping the usual suspects and see if we can get smpnice merged this
 time.

sched-add-above-background-load-function.patch
mm-implement-swap-prefetching.patch
mm-implement-swap-prefetching-fix.patch
mm-implement-swap-prefetching-sched-batch.patch
swap-prefetch-fix-lru_cache_add_tail.patch
swap-prefetch-fix-lru_cache_add_tail-tidy.patch
mm-swap-prefetch-fix-lowmem-reserve-calc.patch

 Swap prefetch.  I remain skeptical, but I have a lot of RAM.  Multiple
 people have sung its praises.  I guess I'll re-review and tentatively plan
 on sending them along or 2.6.18.  Opinions are sought.

pi-futex-futex-code-cleanups.patch
pi-futex-robust-futex-docs-fix.patch
pi-futex-introduce-debug_check_no_locks_freed.patch
pi-futex-introduce-warn_on_smp.patch
pi-futex-add-plist-implementation.patch
pi-futex-scheduler-support-for-pi.patch
pi-futex-rt-mutex-core.patch
pi-futex-rt-mutex-docs.patch
pi-futex-rt-mutex-docs-update.patch
pi-futex-rt-mutex-debug.patch
pi-futex-rt-mutex-tester.patch
pi-futex-rt-mutex-futex-api.patch
pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
#
futex_requeue-optimization.patch

 Priority-inheriting futexes.  I don't have a clue how this code works,
 but it sure has a lot of trylocks for something which allegedly works. 
 Will merge.

proc-fix-the-inode-number-on-proc-pid-fd.patch
proc-remove-useless-bkl-in-proc_pid_readlink.patch
proc-remove-unnecessary-and-misleading-assignments.patch
proc-simplify-the-ownership-rules-for-proc.patch
proc-replace-proc_inodetype-with-proc_inodefd.patch
proc-remove-bogus-proc_task_permission.patch
proc-kill-proc_mem_inode_operations.patch
proc-properly-filter-out-files-that-are-not-visible.patch
proc-fix-the-link-count-for-proc-pid-task.patch
proc-move-proc_maps_operations-into-task_mmuc.patch
proc-rewrite-the-proc-dentry-flush-on-exit.patch
proc-close-the-race-of-a-process-dying-durning.patch
proc-refactor-reading-directories-of-tasks.patch
proc-remove-tasklist_lock-from-proc_pid_readdir.patch
proc-remove-tasklist_lock-from-proc_pid_lookup-and.patch
proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid.patch
proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
proc-dont-lock-task_structs-indefinitely.patch
proc-dont-lock-task_structs-indefinitely-task_mmu-small-fixes.patch
proc-use-struct-pid-not-struct-task_ref.patch
proc-optimize-proc_check_dentry_visible.patch
proc-use-sane-permission-checks-on-the-proc-pid-fd.patch
proc-cleanup-proc_fd_access_allowed.patch
proc-remove-tasklist_lock-from-proc_task_readdir.patch
simplify-fix-first_tid.patch
cleanup-next_tid.patch

 /proc/pid revamp.  Will merge.

de_thread-fix-lockless-do_each_thread.patch
coredump-optimize-mm-users-traversal.patch
coredump-speedup-sigkill-sending.patch
coredump-kill-ptrace-related-stuff.patch
coredump-kill-ptrace-related-stuff-fix.patch
coredump-dont-take-tasklist_lock.patch
coredump-some-code-relocations.patch
coredump-shutdown-current-process-first.patch
coredump-copy_process-dont-check-signal_group_exit.patch

 Will merge.  I have a note here that Roland had issues with
 coredump-kill-ptrace-related-stuff.patch?

ecryptfs-fs-makefile-and-fs-kconfig.patch
ecryptfs-fs-makefile-and-fs-kconfig-remove-ecrypt_debug-from-fs-kconfig.patch
ecryptfs-documentation.patch
ecryptfs-makefile.patch
ecryptfs-main-module-functions.patch
ecryptfs-main-module-functions-uint16_t-u16.patch
ecryptfs-header-declarations.patch
ecryptfs-header-declarations-update.patch
ecryptfs-header-declarations-update-convert-signed-data-types-to-unsigned-data-types.patch
ecryptfs-header-declarations-remove-unnecessary-ifndefs.patch
ecryptfs-superblock-operations.patch
ecryptfs-dentry-operations.patch
ecryptfs-file-operations.patch
ecryptfs-file-operations-remove-null-==-syntax.patch
ecryptfs-file-operations-remove-extraneous-read-of-inode-size-from-header.patch
#ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap.patch
#ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch
ecryptfs-file-operations-fix.patch
ecryptfs-file-operations-fix-premature-release-of-file_info-memory.patch
ecryptfs-inode-operations.patch
ecryptfs-mmap-operations.patch
mark-address_space_operations-const-vs-ecryptfs-mmap-operations.patch
ecryptfs-keystore.patch
ecryptfs-crypto-functions.patch
ecryptfs-debug-functions.patch
ecryptfs-alpha-build-fix.patch
ecryptfs-convert-assert-to-bug_on.patch
ecryptfs-remove-unnecessary-null-checks.patch
ecryptfs-rewrite-ecryptfs_fsync.patch
ecryptfs-overhaul-file-locking.patch

 Christoph has half-reviewed this and all the issues arising from that
 have, I believe, been addressed.  With the exception of the "we should
 have a generic stacking layer" issue.  Which is true.  Michael's take is
 "yes, but that's not my job".  Which also is true.

 Don't know.

proc-sysctl-add-_proc_do_string-helper.patch
namespaces-add-nsproxy.patch
namespaces-add-nsproxy-dont-include-compileh.patch
namespaces-incorporate-fs-namespace-into-nsproxy.patch
namespaces-utsname-introduce-temporary-helpers.patch
namespaces-utsname-switch-to-using-uts-namespaces.patch
namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
namespaces-utsname-switch-to-using-uts-namespaces-cleanup.patch
namespaces-utsname-use-init_utsname-when-appropriate.patch
namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch
namespaces-utsname-implement-utsname-namespaces.patch
namespaces-utsname-implement-utsname-namespaces-export.patch
namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch
namespaces-utsname-sysctl-hack.patch
namespaces-utsname-sysctl-hack-cleanup.patch
namespaces-utsname-sysctl-hack-cleanup-2.patch
namespaces-utsname-sysctl-hack-cleanup-2-fix.patch
namespaces-utsname-remove-system_utsname.patch
namespaces-utsname-implement-clone_newuts-flag.patch
uts-copy-nsproxy-only-when-needed.patch
# needed if git-klibc isn't there:
#namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit.patch
#namespaces-utsname-use-init_utsname-when-appropriate-klibc-bit.patch
#namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-2.patch

 utsname virtualisation.  This doesn't seem very pointful as a standalone
 thing.  That's a general problem with infrastructural work for a very
 large new feature.

 So probably I'll continue to babysit these patches, unless someone can
 identify a decent reason why mainline needs this work.

 I don't want to carry an ever-growing stream of OS-virtualisation
 groundwork patches for ever and ever so if we're going to do this thing...
 faster, please.

readahead-kconfig-options.patch
radixtree-introduce-radix_tree_scan_hole.patch
mm-introduce-probe_page.patch
mm-introduce-pg_readahead.patch
readahead-add-look-ahead-support-to-__do_page_cache_readahead.patch
readahead-delay-page-release-in-do_generic_mapping_read.patch
readahead-insert-cond_resched-calls.patch
readahead-minmax_ra_pages.patch
readahead-events-accounting.patch
readahead-rescue_pages.patch
readahead-sysctl-parameters.patch
readahead-sysctl-parameters-fix.patch
readahead-min-max-sizes.patch
readahead-state-based-method-aging-accounting.patch
readahead-state-based-method-routines.patch
readahead-state-based-method.patch
readahead-state-based-method-readahead-state-based-method-stand-alone-size-limit-code.patch
readahead-context-based-method.patch
readahead-context-based-method-apply-stream_shift-size-limits-to-contexta-method.patch
readahead-context-based-method-fix-remain-counting.patch
readahead-initial-method-guiding-sizes.patch
readahead-initial-method-thrashing-guard-size.patch
readahead-initial-method-expected-read-size.patch
readahead-initial-method-user-recommended-size.patch
readahead-initial-method.patch
readahead-backward-prefetching-method.patch
readahead-backward-prefetching-method-add-use-case-comment.patch
readahead-seeking-reads-method.patch
readahead-thrashing-recovery-method.patch
readahead-call-scheme.patch
readahead-laptop-mode.patch
readahead-loop-case.patch
readahead-nfsd-case.patch
readahead-turn-on-by-default.patch
readahead-debug-radix-tree-new-functions.patch
readahead-debug-traces-showing-accessed-file-names.patch
readahead-debug-traces-showing-read-patterns.patch

 It's early days yet - needs heaps more performance testing.  The results
 from "Linux Portal" <linportal@gmail.com> were discouraging.

reiser4-export-handle_ra_miss.patch
reiser4-sb_sync_inodes.patch
reiser4-export-remove_from_page_cache.patch
reiser4-export-radix_tree_preload.patch
reiser4-export-find_get_pages.patch
make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
reiser4.patch
reiser4-hardirq-include-fix.patch
reiser4-fix-trivial-tyops-which-were-hard-to-hit.patch
reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch

 We need to do something about this.  It does need an intensive review and
 there aren't many people who have the experience to do that right, and
 there are fewer who have the time.  Uptake by a vendor or two would be
 good.

ide-pdc202xx_oldc-remove-unneeded-tuneproc-call.patch
ide-claim-extra-dma-ports-regardless-of-channel.patch
ide-remove-dma_base2-field-form-ide_hwif_t.patch
ide-always-release-dma-engine.patch
fix-ide-locking-error.patch
ide-error-handling-fixes.patch
ide-hpt3xxn-clocking-fixes.patch
ide-io-increase-timeout-value-to-allow-for-slave-wakeup.patch
ide-actually-honor-drives-minimum-pio-dma-cycle-times.patch
ide-fix-hpt37x-timing-tables.patch
ide-optimize-hpt37x-timing-tables.patch
ide-fix-hpt3xx-hotswap-support.patch
ide-fix-the-case-of-multiple-hpt3xx-chips-present.patch
ide-hpt3xx-fix-pci-clock-detection.patch
ide-hpt3xx-fix-pci-clock-detection-fix-2.patch
ide-pdc202xx_old-remove-the-obsolete-busproc.patch
piix-fix-82371mx-enablebits.patch
piix-remove-check-for-broken-mw-dma-mode-0.patch
piix-slc90e66-pio-mode-fallback-fix.patch
make-number-of-ide-interfaces-configurable.patch
ide_dma_speed-fixes.patch
ide_dma_speed-fixes-warning-fix.patch
ide_dma_speed-fixes-tidy.patch
hpt3xx-rework-rate-filtering.patch
hpt3xx-rework-rate-filtering-tidy.patch
hpt3xx-print-the-real-chip-name-at-startup.patch
hpt3xx-switch-to-using-pci_get_slot.patch
hpt3xx-cache-channels-mcr-address.patch

 Will merge, subject to maintainer-poking.

radeonfb-powerdrain-issue-on-ibm-thinkpads-and-suspend-to-d2.patch
savagefb-allocate-space-for-current-and-saved-register.patch
savagefb-add-state-save-and_restore-hooks.patch
savagefb-add-state-save-and_restore-hooks-tidy.patch
savagefb-add-state-save-and_restore-hooks-fix.patch
backlight-locomo-backlight-driver-updates.patch
fbdev-cleanup-the-config_video_select-mess.patch
fbdev-remove-duplicate-includes.patch
fbdev-more-accurate-sync-range-extrapolation.patch
nvidiafb-revise-pci_device_id-table.patch
atyfb-fix-hardware-cursor-handling.patch
atyfb-remove-unneeded-calls-to-wait_for_idle.patch
atyfb-set-correct-acceleration-flags.patch
epson1355fb-update-platform-code.patch
vesafb-update-platform-code.patch
vfb-update-platform-code.patch
vga16fb-update-platform-code.patch
fbdev-static-pseudocolor-with-depth-less-than-4-does.patch
savagefb-whitespace-cleanup.patch
fbdev-firmware-edid-fixes.patch
fbdev-firmware-edid-fixes-fix.patch
nvidiafb-add-support-for-geforce-6100-and-related-chipsets.patch
fbdev-add-1366x768-wxga-mode-to-mode-database.patch
vesafb-fix-return-code-of-vesafb_setcolreg.patch
vesafb-prefer-vga-registers-over-pmi.patch
vt-delay-the-update-of-the-visible-console.patch
atyfb-fix-dead-code.patch
fbdev-coverity-bug-85.patch
fbdev-coverity-bug-90.patch
fbdev-remove-unused-exports.patch
s3c2410fb-fix-resume.patch
backlight-fix-kconfig-dependency.patch
au1100fb-add-power-management-support.patch
au1100fb-add-power-management-support-tidy.patch
skeletonfb-remove-duplicate-module-init-exit-license-lines.patch
neofb-fix-unblank-logic-interfering-with-lid-toggled-backlight.patch

 Will merge.

dm-snapshot-unify-chunk_size.patch
lib-add-idr_replace.patch
lib-add-idr_replace-tidy.patch
dm-fix-idr-minor-allocation.patch
dm-move-idr_pre_get.patch
dm-change-minor_lock-to-spinlock.patch
dm-add-dmf_freeing.patch
dm-fix-mapped-device-ref-counting.patch
dm-add-module-ref-counting.patch
dm-fix-block-device-initialisation.patch
dm-mirror-sector-offset-fix.patch
dm-table-get_target-fix-last-index.patch

 Will merge.

md-reformat-code-in-raid1_end_write_request-to-avoid-goto.patch
md-remove-arbitrary-limit-on-chunk-size.patch
md-remove-useless-ioctl-warning.patch
md-increase-the-delay-before-marking-metadata-clean-and-make-it-configurable.patch
md-merge-raid5-and-raid6-code.patch
md-remove-nuisance-message-at-shutdown.patch
md-allow-checkpoint-of-recovery-with-version-1-superblock.patch
md-allow-checkpoint-of-recovery-with-version-1-superblock-fix.patch
md-allow-a-linear-array-to-have-drives-added-while-active.patch
md-support-stripe-offset-mode-in-raid10.patch
md-make-md_print_devices-static.patch
md-split-reshape-portion-of-raid5-sync_request-into-a-separate-function.patch
#
md-bitmap-fix-online-removal-of-file-backed-bitmaps.patch
md-bitmap-remove-bitmap-writeback-daemon.patch
md-bitmap-cleaner-separation-of-page-attribute-handlers-in-md-bitmap.patch
md-bitmap-use-set_bit-etc-for-bitmap-page-attributes.patch
md-bitmap-remove-unnecessary-page-reference-manipulations-from-md-bitmap-code.patch
md-bitmap-remove-dead-code-from-md-bitmap.patch
md-bitmap-tidy-up-i_writecount-handling-in-md-bitmap.patch
md-bitmap-change-md-bitmap-file-handling-to-use-bmap-to-file-blocks.patch
md-change-md-bitmap-file-handling-to-use-bmap-to-file-blocks-fix.patch
md-calculate-correct-array-size-for-raid10-in-new-offset-mode.patch
#
md-md-kconfig-speeling-feex.patch
md-fix-kconfig-error.patch
md-fix-bug-that-stops-raid5-resync-from-happening.patch
md-allow-re-add-to-work-on-array-without-bitmaps.patch
md-dont-write-dirty-clean-update-to-spares-leave-them-alone.patch
md-set-get-state-of-array-via-sysfs.patch
md-allow-rdev-state-to-be-set-via-sysfs.patch
md-allow-raid-layout-to-be-read-and-set-via-sysfs.patch
md-allow-resync_start-to-be-set-and-queried-via-sysfs.patch
md-allow-the-write_mostly-flag-to-be-set-via-sysfs.patch

 Will merge.

statistics-infrastructure-prerequisite-list.patch
statistics-infrastructure-prerequisite-parser.patch
statistics-infrastructure-prerequisite-timestamp.patch
statistics-infrastructure-prerequisite-timestamp-fix.patch
statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
statistics-infrastructure-documentation.patch
statistics-infrastructure.patch
statistics-infrastructure-update-1.patch
statistics-infrastructure-update-2.patch
statistics-infrastructure-update-3.patch
statistics-infrastructure-exploitation-zfcp.patch

 Another tough one.  It offers generic intrastructure for non-task-related
 instrumentation and it would really be good if someone who has an interest
 in this for something other than the zfcp driver could stand up and say
 "this works for us".

genirq-rename-desc-handler-to-desc-chip.patch
genirq-rename-desc-handler-to-desc-chip-power-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch
genirq-sem2mutex-probe_sem-probing_active.patch
genirq-cleanup-merge-irq_affinity-into-irq_desc.patch
genirq-cleanup-remove-irq_descp.patch
genirq-cleanup-remove-irq_descp-fix.patch
genirq-cleanup-remove-fastcall.patch
genirq-cleanup-misc-code-cleanups.patch
genirq-cleanup-reduce-irq_desc_t-use-mark-it-obsolete.patch
genirq-cleanup-include-linux-irqh.patch
genirq-cleanup-merge-irq_dir-smp_affinity_entry-into-irq_desc.patch
genirq-cleanup-merge-pending_irq_cpumask-into-irq_desc.patch
genirq-cleanup-turn-arch_has_irq_per_cpu-into-config_irq_per_cpu.patch
genirq-debug-better-debug-printout-in-enable_irq.patch
genirq-add-retrigger-irq-op-to-consolidate-hw_irq_resend.patch
genirq-doc-comment-include-linux-irqh-structures.patch
genirq-doc-handle_irq_event-and-__do_irq-comments.patch
genirq-cleanup-no_irq_type-cleanups.patch
genirq-doc-add-design-documentation.patch
genirq-add-genirq-sw-irq-retrigger.patch
genirq-add-irq_noprobe-support.patch
genirq-add-irq_norequest-support.patch
genirq-add-irq_noautoen-support.patch
genirq-update-copyrights.patch
genirq-core.patch
genirq-msi-fixes-2.patch
genirq-add-irq-chip-support.patch
genirq-add-irq-chip-support-fix.patch
genirq-add-handle_bad_irq.patch
genirq-add-irq-wake-power-management-support.patch
genirq-add-sa_trigger-support.patch
genirq-cleanup-no_irq_type-no_irq_chip-rename.patch
genirq-convert-the-x86_64-architecture-to-irq-chips.patch
genirq-convert-the-i386-architecture-to-irq-chips.patch
genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
genirq-more-verbose-debugging-on-unexpected-irq-vectors.patch
genirq-add-chip-eoi-fastack-fasteoi.patch
genirq-add-chip-eoi-fastack-fasteoi-fix.patch

 Still stabilising.  It's looking more like 2.6.19 material.  Needs more
 review from arch maintainers too.

lock-validator-floppyc-irq-release-fix.patch
lock-validator-floppyc-irq-release-fix-fix.patch
lock-validator-forcedethc-fix.patch
lock-validator-mutex-section-binutils-workaround.patch
lock-validator-add-__module_address-method.patch
lock-validator-better-lock-debugging.patch
lock-validator-locking-api-self-tests.patch
lock-validator-locking-api-self-tests-self-test-fix.patch
lock-validator-locking-init-debugging-improvement.patch
lock-validator-beautify-x86_64-stacktraces.patch
lock-validator-beautify-x86_64-stacktraces-fix.patch
lock-validator-beautify-x86_64-stacktraces-fix-2.patch
lock-validator-beautify-x86_64-stacktraces-fix-3.patch
lock-validator-beautify-x86_64-stacktraces-fix-4.patch
lock-validator-x86_64-document-stack-frame-internals.patch
lock-validator-stacktrace.patch
lock-validator-stacktrace-build-fix.patch
lock-validator-stacktrace-warning-fix.patch
lock-validator-stacktrace-fix-on-x86_64.patch
lock-validator-fown-locking-workaround.patch
lock-validator-sk_callback_lock-workaround.patch
lock-validator-irqtrace-core.patch
lock-validator-irqtrace-core-powerpc-fix-1.patch
lock-validator-irqtrace-core-non-x86-fix.patch
lock-validator-irqtrace-core-non-x86-fix-2.patch
lock-validator-irqtrace-core-non-x86-fix-3.patch
lock-validator-irqtrace-entrys-fix.patch
lock-validator-irqtrace-core-remove-softirqc-warn_on.patch
lock-validator-irqtrace-cleanup-include-asm-i386-irqflagsh.patch
lock-validator-irqtrace-cleanup-include-asm-x86_64-irqflagsh.patch
lock-validator-x86_64-irqflags-trace-entrys-fix.patch
lock-validator-lockdep-add-local_irq_enable_in_hardirq-api.patch
lock-validator-add-per_cpu_offset.patch
lock-validator-add-per_cpu_offset-fix.patch
lock-validator-core.patch
lock-validator-core-early_boot_irqs_-build-fix.patch
lock-validator-core-fix-compiler-warning.patch
lock-validator-procfs.patch
lock-validator-core-multichar-fix.patch
lock-validator-core-count_matching_names-fix.patch
lock-validator-design-docs.patch
lock-validator-prove-rwsem-locking-correctness.patch
lock-validator-prove-rwsem-locking-correctness-fix.patch
lock-validator-prove-rwsem-locking-correctness-powerpc-fix.patch
lock-validator-prove-spinlock-rwlock-locking-correctness.patch
lock-validator-prove-mutex-locking-correctness.patch
lock-validator-prove-mutex-locking-correctness-fix-null-type-name-bug.patch
lock-validator-print-all-lock-types-on-sysrq-d.patch
lock-validator-x86_64-early-init.patch
lock-validator-smp-alternatives-workaround.patch
lock-validator-do-not-recurse-in-printk.patch
lock-validator-disable-nmi-watchdog-if-config_lockdep.patch
lock-validator-disable-nmi-watchdog-if-config_lockdep-i386.patch
lock-validator-disable-nmi-watchdog-if-config_lockdep-x86_64.patch
lock-validator-special-locking-bdev.patch
lock-validator-special-locking-direct-io.patch
lock-validator-special-locking-serial.patch
lock-validator-special-locking-serial-fix.patch
lock-validator-special-locking-dcache.patch
lock-validator-special-locking-i_mutex.patch
lock-validator-special-locking-s_lock.patch
lock-validator-special-locking-futex.patch
lock-validator-special-locking-genirq.patch
lock-validator-special-locking-completions.patch
lock-validator-special-locking-waitqueues.patch
lock-validator-special-locking-mm.patch
lock-validator-special-locking-serio.patch
lock-validator-special-locking-slab.patch
lock-validator-special-locking-skb_queue_head_init.patch
lock-validator-special-locking-net-ipv4-igmpcpatch.patch
lock-validator-special-locking-net-ipv4-igmpc-2.patch
lock-validator-special-locking-timerc.patch
lock-validator-special-locking-schedc.patch
lock-validator-special-locking-hrtimerc.patch
lock-validator-special-locking-sock_lock_init.patch
lock-validator-special-locking-af_unix.patch
lock-validator-special-locking-bh_lock_sock.patch
lock-validator-special-locking-mmap_sem.patch
lock-validator-special-locking-sb-s_umount.patch
lock-validator-special-locking-sb-s_umount-fix.patch
lock-validator-special-locking-sb-s_umount-2.patch
lock-validator-special-locking-sb-s_umount-2-fix.patch
lockdep-annotate-rpc_populate-for.patch
lock-validator-special-locking-jbd.patch
lock-validator-special-locking-posix-timers.patch
lock-validator-special-locking-sch_genericc.patch
lock-validator-special-locking-xfrm.patch
lockdep-add-i_mutex-ordering-annotations-to-the-sunrpc.patch
lockdep-add-parent-child-annotations-to-usbfs.patch
lock-validator-special-locking-sound-core-seq-seq_portsc.patch
lock-validator-special-locking-sound-core-seq-seq_devicec.patch
lock-validator-special-locking-sound-core-seq-seq_devicec-fix.patch
lock-validator-fix-rt_hash_lock_sz.patch
lock-validator-introduce-irq__lockdep.patch
locking-validator-special-rule-8390c-disable_irq.patch
locking-validator-special-rule-3c59xc-disable_irq.patch
lock-validator-enable-lock-validator-in-kconfig.patch
lock-validator-enable-lock-validator-in-kconfig-require-trace_irqflags_support.patch
lock-validator-enable-lock-validator-in-kconfig-not-yet.patch
lockdep-one-stacktrace-column-if-config_lockdep=y.patch
i386-remove-multi-entry-backtraces.patch
lockdep-further-improve-stacktrace-output.patch
lock-validator-irqtrace-support-non-x86-architectures.patch
lock-validator-disable-oprofile-if-lockdep=y.patch
lock-validator-select-kallsyms_all.patch

 I'm not really sure that this has as good a bugfixes/effort ratio as would,
 say, working on our ever-growing bugzilla list.

 But given that it exists, and that it'll fix (or rather prevent) future
 bugs at a constant-but-low rate for a long time, I guess it's something we
 want.

 I think it's more like 2.6.19 material.  The number of
 teach-lockdep-about-this-unusual-but-correct-locking-code patches
 continues to grow and I don't think we fully have a handle on how it'll
 all end up looking.


