Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWCWE4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWCWE4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 23:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWCWE4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 23:56:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965205AbWCWE4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 23:56:31 -0500
Date: Wed, 22 Mar 2006 20:53:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: -mm merge plans
Message-Id: <20060322205305.0604f49b.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A look at the -mm lineup for 2.6.17:


proc-fix-duplicate-line-in-proc-devices.patch
sys_alarm-unsigned-signed-conversion-fixup.patch
sys_alarm-unsigned-signed-conversion-fixup-fix.patch
validate-and-sanitze-itimer-timeval-from-userspace.patch
validate-and-sanitze-itimer-timeval-from-userspace-fix.patch
fix-scheduler-deadlock.patch
fix-bug-bio_rw_barrier-requests-to-md-raid1-hang.patch

  Will merge.  Will also submit for 2.6.16.1.

  The timer changes address back-incompatibilities with earlier kernels. 
  This means that 2.6.16's alarm() and setitimer() are, under
  unlikely-to-occur circumstances, incompatible with earlier kernels.  If
  merged into 2.6.16.1 these patches will fix that.

git-acpi-up-fix.patch
sem2mutex-drivers-acpi.patch
sem2mutex-acpi-acpi_link_lock.patch
pnpacpi-fix-non-memory-address-space-descriptor-handling.patch
pnpacpi-remove-some-code-duplication.patch
pnpacpi-whitespace-cleanup.patch
acpi-request-correct-fixed-hardware-resource-type-mmio-vs-i-o-port.patch
acpi-add-acpi-to-motherboard-resources-in-proc-iomemport.patch
acpi-update-asus_acpi-driver-registration.patch
acpi-fix-sonypi-acpi-driver-registration.patch
acpi-make-acpi_bus_register_driver-return-success-failure-not-device-count.patch
acpi-simplify-scanc-coding.patch
acpi-print-wakeup-device-list-on-same-line-as-label.patch
acpi-fix-memory-hotplug-range-length-handling.patch
hpet-fix-acpi-memory-range-length-handling.patch
acpi_os_acquire_object-gfp_kernel-called-with-irqs.patch
acpi-ia64-wake-on-lan-fix.patch
acpi-remove-__init-__exit-from-asus-add-remove-methods.patch
serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi.patch
acpi-signedness-fix-2.patch
acpi-should-depend-on-not-select-pci.patch
acpi-ec-acpi-ecdt-uid-hack.patch
acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces.patch

  To be processed by the ACPI team.

msi-k8t-neo2-fir-onboardsound-and-additional-soundcard.patch
fix-sequencer-missing-negative-bound-check.patch
pnp-adjust-pnp_register_card_driver-signature-ad1816a.patch
pnp-adjust-pnp_register_card_driver-signature-als100.patch
pnp-adjust-pnp_register_card_driver-signature-azt2320.patch
pnp-adjust-pnp_register_card_driver-signature-cmi8330.patch
pnp-adjust-pnp_register_card_driver-signature-dt019x.patch
pnp-adjust-pnp_register_card_driver-signature-es18xx.patch
pnp-adjust-pnp_register_card_driver-signature-es968.patch
pnp-adjust-pnp_register_card_driver-signature-interwave.patch
pnp-adjust-pnp_register_card_driver-signature-sb16.patch
pnp-adjust-pnp_register_card_driver-signature-sb_card.patch
pnp-adjust-pnp_register_card_driver-signature-sscape.patch
pnp-adjust-pnp_register_card_driver-signature-wavefront.patch

  Will send to the ALSA team.

blk_execute_rq_nowait-speedup.patch
block-layer-increase-size-of-disk-stat.patch

  Will be merged.

cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch
powernow-remove-private-for_each_cpu_mask.patch
cpufreq_conservative-aligning-of-codebase-with-ondemand.patch
cpufreq_conservative-alter-default-responsiveness.patch
cpufreq_conservative-make-for_each_cpu-safe.patch
cpufreq_conservative-alternative-initialise-approach.patch

  Will send to the cpufreq team.

v4l-printk-warning-fixes.patch
saa7110-fix-array-overrun.patch
saa7111-prevent-array-overrun.patch
saa7114-fix-i2c-block-write.patch
adv7175-drop-unused-encoder-dump-command.patch
adv7175-drop-unused-register-cache.patch
zoran-use-i2c_master_send-when-possible.patch
bt856-spare-memory.patch
zoran-init-cleanups.patch
saa7111c-fix.patch
sem2mutex-zoran.patch

  Sent to the v4l team.

ia64-update-hp-csr-space-discovery-via-acpi.patch
ia64-sn_check_intr-use-ia64_get_irr.patch

  Sent to Tony.

sem2mutex-drivers-ieee1394.patch
ieee1394-speed-up-of-dma_region_sync_for_cpu.patch
drivers-ieee1394-ohci1394c-function-calls-without-effect.patch

  Sent to the ieee1394 team.

m25p80-printk-warning-fix.patch
sem2mutex-mtd-doc2000c.patch
sem2mutex-drivers-mtd.patch
drivers-mtd-small-cleanups.patch
mtd_nand_sharpsl-and-mtd_nand_nandsim-should-be-tristates.patch
drivers-mtd-use-array_size-macro.patch
mtd-cmdlinepart-allow-zero-offset-value.patch
fix-debug-statement-in-inftlcorec.patch
kill-ifdefs-in-mtdcorec.patch
dead-code-in-mtd-maps-pcic.patch
add-chip-used-in-collie-to-jedec_probe.patch

  Sent to the MTD team.

natsemi-support-oversized-eeproms.patch
tulip-natsemi-dp83840a-phy-fix.patch
natsemi-add-support-for-using-mii-port-with-no-phy.patch
fix-spidernet-build-issue.patch
add-a-pci-vendor-id-definition-for-aculab.patch
amd-au1xx0-fix-ethernet-tx-stats.patch
natsemi-add-quirks-for-aculab-e1-t1-pmxc-cpci-carrier-cards.patch
tulip-fix-for-64-bit-mips.patch
drivers-net-ns83820c-add-paramter-to-disable-auto.patch

  Plugging away with unloved netdev patches.  We'll see.

nfs-make-2-functions-static.patch
fs-locksc-make-posix_locks_deadlock-static.patch
remove-needless-check-in-nfs_opendir.patch

  Sent to Trond.

optimise-d_find_alias.patch

  spose so.

gdth-add-execute-firmware-command-abstraction.patch

  That's up to Christoph

megaraid-unused-variable.patch
drivers-scsi-aic7xxx-possible-cleanups.patch
drivers-scsi-small-cleanups.patch
drivers-scsi-megaraidc-add-a-dummy-mega_create_proc_entry-for-proc_fs=y.patch
drivers-scsi-gdthc-make-__gdth_execute-static.patch
drivers-scsi-qla2xxx-make-some-functions-static.patch
drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_done_with_status-static.patch
aacraid-fix-the-comparison-with-sizeof.patch
small-whitespace-cleanup-for-qlogic-driver.patch
scsi-megaraid-megaraid_mmc-fix-a-null-pointer-dereference.patch
remove-drivers-scsi-constantscscsi_print_req_sense.patch
link-scsi_debug-later.patch
drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_match_scb-static.patch

  Will keep sending.

areca-raid-linux-scsi-driver.patch
areca-raid-linux-scsi-driver-update4.patch

  Would be nice.  Needs followup from the scsi team.

cirrus-ep93xx-watchdog-driver.patch
cirrus-ep93xx-watchdog-driver-tidy.patch

  Will merge

drivers-block-floppyc-dont-free_irq-from-irq-context.patch
drivers-block-floppyc-dont-free_irq-from-irq-context-fix.patch
warn-if-free_irq-is-called-from-irq-context.patch
protect-remove_proc_entry.patch

  Some of these are a bit dodgy.

slab-leaks.patch
slab-leaks3-locking-fix.patch
slab-leaks3-default-y.patch
slab-introduce-kmem_cache_zalloc-allocator.patch
slab-optimize-constant-size-kzalloc-calls.patch
mm-use-kmem_cache_zalloc.patch
slab-add-transfer_objects-function.patch
slab-add-transfer_objects-function-fix.patch
slab-bypass-free-lists-for-__drain_alien_cache.patch
alloc_kmemlist-some-cleanup-in-preparation-for-a-real-memory-leak-fix.patch
slab-fix-memory-leak-in-alloc_kmemlist.patch
slab-fix-memory-leak-in-alloc_kmemlist-fix.patch
add-api-for-flushing-anon-pages.patch
add-flush_kernel_dcache_page-api.patch
mm-make-page-migration-dependent-on-swap-and-numa.patch

  Will merge.

acx1xx-wireless-driver.patch

  Is up to John, Jeff and Denis.   Would be nice.

bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm.patch
bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-update.patch
bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-update-tidy.patch

  Will merge.

macintosh-cleanup-the-use-of-i2c-headers.patch
via-pmu-warning-fix.patch
powerpc-tidy-up-of_register_driver-driver_register-return-values.patch
macintosh-tidy-up-driver_register-return-values.patch

  Sent to paulus.

x86-cache-pollution-aware-__copy_from_user_ll.patch
i386-let-regparm-no-longer-depend-on-experimental.patch
make-config_regparm-enabled-by-default.patch
i386-multi-column-stack-backtraces.patch
x86-smp-alternatives.patch
i386-__devinit-should-be-__cpuinit.patch
i386-allow-disabling-x86_feature_sep-at-boot.patch
i386-add-a-temporary-to-make-put_user-more-type-safe.patch
i386-fall-back-to-sensible-cpu-model-name.patch
compilation-fix-for-es7000-when-no-acpi-is-specified-in-config-i386.patch
i386-remove-duplicate-declaration-of-mp_bus_id_to_pci_bus.patch
make-isoimage-support-fdinitrd=-support-minor-cleanups.patch
i386-traps-merge-printk-calls.patch
i386-dont-let-ptrace-set-the-nested-task-bit.patch
i386-let-signal-handlers-set-the-resume-flag.patch
x86-early-printk-handling-fixes.patch
x86-start-early_printk-at-sensible-screen-row.patch
x86-early-printk-remove-max_ypos-and-max_xpos-macros.patch
register-the-boot-cpu-in-the-cpu-maps-earlier.patch
register-the-boot-cpu-in-the-cpu-maps-earlier-fix.patch
i386-pass-proper-trap-numbers-to-die-chain-handlers.patch
i386-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
i386-actively-synchronize-vmalloc-area-when-registering-certain-callbacks-tidy.patch
i386-fix-uses-of-user_mode-vs-user_mode_vm.patch
i386-fix-singlestep-through-an-int80-syscall.patch
i386-more-vsyscall-documentation.patch
fix-implicit-declaration-of-get_apic_id-in-arch-i386-kernel-apicc.patch
fix-the-imlicit-declaration-of-mtrr_centaur_report_mcr-in-arch-i386-kernel-cpu-centaurc.patch
fix-the-imlicit-declaration-of-mtrr_centaur_report_mcr-in-arch-i386-kernel-cpu-centaurc-fix.patch
i386-cleanup-after-cpu_gdt_descr-conversion-to.patch
i386-fix-dump_stack.patch
x86-cpuid4-doesnt-need-cpu-level-5.patch
x86-deterine-xapic-using-apic-version.patch
i386-spinlocks-disable-interrupts-only-if-we-enabled.patch
x86-some-fixups-for-the-x86_numaq-dependencies.patch
x86-make-_syscallx-macros-compile-in-pic-mode.patch
x86-topology-dont-create-a-control-file-for-bsp-that-cannot-be-removed.patch
x86-make-config_hotplug_cpu-depend-on-x86_pc.patch

  Pending a one-at-a-time re-review: will merge.

remove-entries-in-sys-firmware-acpi-for-processor-also.patch
remove-unnecessary-lapic-definition-from-acpidefh.patch
support-physical-cpu-hotplug-for-x86_64.patch
support-physical-cpu-hotplug-for-x86_64-fix-2.patch
patch-to-limit-present-cpus-to-fake-cpu-hot-add-testing.patch
enable-sci_emulate-to-manually-simulate-physical-hotplug-testing.patch
enable-sci_emulate-to-manually-simulate-physical-hotplug-testing-fix.patch
drivers-acpi-busc-make-struct-acpi_sci_dir-static.patch

  Will send to the relevant maintainers

ia64-use-i386-dmi_scanc.patch
ia64-use-i386-dmi_scanc-fix.patch
efi-dev-mem-simplify-efi_mem_attribute_range.patch
ia64-ioremap-check-efi-for-valid-memory-attributes.patch
dmi-only-ioremap-stuff-we-actually-need.patch
efi-keep-physical-table-addresses-in-efi-structure.patch
efi-fixes.patch
acpi-clean-up-memory-attribute-checking-for-map-read-write.patch

  Will merge.

revert-swsusp-fix-breakage-with-swap-on-lvm.patch
swsusp-low-level-interface-rev-2.patch
swsusp-separate-swap-writing-reading-code-rev-2.patch
swsusp-separate-swap-writing-reading-code-rev-2-fix-writing-progress-meter.patch
mm-kernel-power-move-externs-to-header-files.patch
swsusp-documentation-updates.patch
swsusp-documentation-updates-update.patch
swsusp-documentation-updates-warn-about-filesystems-mounted-from-usb-devices.patch
swsusp-documentation-fix.patch
add-s2ram-pointer-to-suspend-documentation.patch
swsusp-userland-interface.patch
swsusp-userland-interface-fixes.patch
swsusp-userland-interface-fix-breakage-with-swap-on-lvm.patch
swsusp-freeze-user-space-processes-first.patch
suspend-make-progress-printing-prettier.patch
swsusp-finally-solve-mysqld-problem.patch
swsusp-drain-high-mem-pages.patch
swsusp-add-check-for-suspension-of-x-controlled-devices.patch
swsusp-let-userland-tools-switch-console-on-suspend.patch
swsusp-add-s2ram-ioctl-to-userland-interface.patch
remove-kernel-power-pmcpm_unregister.patch

  Will merge.

pm-print-name-of-failed-suspend-function.patch

  Will send to Greg.

m68k-rtc-driver-cleanup.patch

  Will merge.

s390-wrong-interrupt-delivered-for-hsch-or-csch.patch
s390-cio-documentation-update.patch
s390-channel-path-measurements.patch
s390-early-parameter-parsing.patch
s390-proc-sys-vm-cmm_-permission-bits.patch
s390-bug-warnings.patch
s390-cpu-up-retries.patch
s390-connector-support.patch
s390-use-normal-switch-statement-for-ioctls-in-dasd_ioctlc.patch
s390-use-normal-switch-statement-for-ioctls-in-dasd_ioctlc-2.patch
s390-merge-cmb-into-dasdc.patch
s390-remove-dynamic-dasd-ioctls.patch
s390-remove-old-history-whitespave-from-partition-code.patch
s390-remove-experimental-flag-from-dasd-diag.patch
s390-random-values-in-result-of-biodasdinfo2.patch
s390-dasd-extended-error-reporting.patch
s390-tape-retry-flooding-by-deferred-cc-in-interrupt.patch
s390-tape-operation-abortion-leads-to-panic.patch
s390-fix-endless-retry-loop-in-tape-driver.patch
s390-3590-tape-driver.patch
s390-remove-support-for-ttys-over-ctc-connections.patch
s390-cex2a-crt-message-length.patch
s390-kzalloc-conversion-in-arch-s390.patch
s390-kzalloc-conversion-in-drivers-s390.patch
arch-s390-makefile-remove-finline-limit=10000.patch
dasd-cleanup-dasd_ioctl-fix.patch

  Will merge (needs a little work yet).

oops-reporting-tool.patch

  Might drop this.  Is it useful?

reiser4-export-page_cache_readahead.patch
ext3_readdir-use-generic-readahead.patch

  Will merge.

reduce-nr-of-ptr-derefs-in-fs-jffs2-summaryc.patch
remove-fs-jffs2-ioctlc.patch

  Will keep sending to maintainer

reduce-size-of-bio-mempools.patch
shrinks-sizeoffiles_struct-and-better-layout.patch
avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage.patch
cleanup-cdrom_ioctl.patch
kill-cdrom-dev_ioctl-method.patch
move-read_mostly-definition-to-asm-cacheh.patch
fix-oops-in-invalidate_dquots.patch
kernel-cpusetc-mutex-conversion.patch
convert-kernel-rcupdatecrcu_barrier_sema-to-mutex.patch
convert-fs-9p-to-mutexes-fix-locking-bugs.patch
sem2mutex-kcapic.patch
sem2mutex-drivers-raw-connector-dcdbas-ppp_generic.patch
sem2mutex-drivers-scsi-ide-scsic.patch
sem2mutex-kernel.patch
sem2mutex-fs.patch
sem2mutex-drivers-block-pktcdvdc.patch
sem2mutex-drivers-block-floppyc.patch
sem2mutex-drivers-char.patch
sem2mutex-misc-static-one-file-mutexes.patch
sem2mutex-blockdev-2.patch
sem2mutex-blockdev-2-git-blktrace-fix.patch
sem2mutex-quota.patch
sem2mutex-inotify.patch
sem2mutex-tty.patch
sem2mutex-eventpoll.patch
sem2mutex-vfs_rename_mutex.patch
sem2mutex-iprune.patch
sem2mutex-jbd-j_checkpoint_mutex.patch
sem2mutex-kprobes.patch
sem2mutex-ipc-idsem.patch
sem2mutex-ipc-idsem-fix.patch
sem2mutex-fs-libfsc.patch
sem2mutex-fs-seq_filec.patch
sem2mutex-drivers-block-loopc.patch
sem2mutex-drivers-block-nbdc.patch
sem2mutex-sound-oss.patch
sem2mutex-jffs.patch
sem2mutex-ntfs.patch
sem2mutex-netfilter-x_tablec.patch
sem2mutex-autofs4-wq_sem.patch
convert-the-semaphores-in-the-sisusb-driver-to-mutexes.patch
sem2mutex-hpfs.patch
convert-ext3s-truncate_sem-to-a-mutex.patch
sem2mutex-ncpfs.patch
sem2mutex-udf.patch
sem2mutex-serial-port_write_mutex.patch
sem2mutex-drivers-ide.patch
kernel-modulec-semaphore-to-mutex-conversion-for-module_mutex.patch
oss-semaphore-to-mutex-conversion.patch
work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
kernel-kernel-cpuc-to-mutexes.patch
fat_lock-is-used-as-a-mutex-convert-it-to-using-the-new-mutex.patch
snsc-kmalloc2kzalloc.patch
sigprocmask-kill-unneeded-temp-var.patch
fs-ufs-filec-drop-insane-header-dependencies.patch
extract-inode_inc_count-inode_dec_count.patch
minix-switch-to-inode_inc_link_count-inode_dec_link_count.patch
sysv-switch-to-inode_inc_link_count-inode_dec_link_count.patch
ext2-switch-to-inode_inc_link_count-inode_dec_link_count.patch
ufs-switch-to-inode_inc_link_count-inode_dec_link_count.patch
make-bug-messages-more-consistent.patch
notifier-profileh-forward-decl.patch
kill-_inline_.patch
pause_on_oops-command-line-option.patch
pnpbios-missing-small_tag_enddep-tag.patch
build_lock_ops-cleanup-preempt_disable-usage.patch
devpts-use-lib-parserc-for-parsing-mount-options.patch
kernel-rcupdatec-make-two-structs-static.patch
fs-filec-drop-insane-header-dependencies.patch
atomic-add_unless-cmpxchg-optimise.patch
get_empty_filp-tweaks-inline-epoll_init_file.patch
only-allocate-percpu-data-for-possible-cpus.patch
more-for_each_cpu-conversions.patch
i386-instead-of-poisoning-init-zone-change-protection.patch
__generic_per_cpu-changes.patch
fs-use-array_size-macro.patch
remove-fs-jffs2-histoh.patch
remove-isa-legacy-functions-drivers-char-toshibac.patch
remove-isa-legacy-functions-drivers-scsi-g_ncr5380c.patch
remove-isa-legacy-functions-drivers-scsi-in2000c.patch
remove-isa-legacy-functions-drivers-net-hp-plusc.patch
remove-isa-legacy-functions-drivers-net-lancec.patch
remove-isa-legacy-functions-remove-the-helpers.patch
remove-isa-legacy-functions-remove-documentation.patch
bitmap-region-cleanup.patch
bitmap-region-multiword-spanning-support.patch
bitmap-region-restructuring.patch
free_uid-locking-improvement.patch
represent-dirty__centisecs-as-jiffies-internally.patch
represent-laptop_mode-as-jiffies-internally.patch
range-checking-in-do_proc_dointvec_userhz_jiffies_conv.patch
rcu_process_callbacks-dont-cli-while-testing-nxtlist.patch
fs-9p-possible-cleanups.patch
fs-ext2-proper-ext2_get_parent-prototype.patch
fs-coda-proper-prototypes.patch
tvec_bases-too-large-for-per-cpu-data.patch
remove-drivers-mca-mca-procc.patch
unify-pxm_to_node-id-ver2-generic-code.patch
unify-pxm_to_node-id-ver2-for-ia64.patch
unify-pxm_to_node-id-ver2-for-x86_64.patch
unify-pxm_to_node-id-ver2-for-i386.patch
extract-ikconfig-use-mktemp1.patch
extract-ikconfig-be-sure-binoffset-exists-before-extracting.patch
extract-ikconfig-dont-use-long-options.patch
kill-include-linux-platformh-default_idle-cleanup.patch
rcutorture-tag-success-failure-line-with-module-parameters.patch
cpusets-only-wakeup-kswapd-for-zones-in-the-current-cpuset.patch
cpuset-cleanup-not-not-operators.patch
cpuset-use-combined-atomic_inc_return-calls.patch
cpuset-memory-spread-basic-implementation.patch
cpuset-memory-spread-page-cache-implementation-and-hooks.patch
cpuset-memory-spread-slab-cache-filesys.patch
cpuset-memory-spread-slab-cache-format.patch
cpuset-memory-spread-slab-cache-implementation.patch
cpuset-memory-spread-slab-cache-optimizations.patch
cpuset-memory-spread-slab-cache-hooks.patch
cpuset-remove-unnecessary-null-check.patch
cpuset-remove-unnecessary-null-check-comment-fix.patch
cpuset-dont-need-to-mark-cpuset_mems_generation-atomic.patch
cpuset-memory_spread_slab-drop-useless-pf_spread_page-check.patch
cpuset-remove-useless-local-variable-initialization.patch
# awaiting PJ ack
add-gfp-flag-__gfp_policy-to-control-policies-and-cpusets-redirection.patch
remove-double-semicolons.patch
isofs-remove-unused-debugging-macros.patch
remove-ipmi-pm_power_off-redefinition.patch
fast-ext3_statfs.patch
fw-abstract-type-size-specification-for-assembly.patch
config_unwind_info.patch
filemap_fdata_write-api-fix-end-parameter.patch
fadvise-async-write-commands.patch
early_printk-cleanup-trailiing-whitespace.patch
sb_set_blocksize-cleanup.patch
shmdt-check-address-aligment.patch
block-floppy98-removal-really.patch
sound-remove-pc98-specific-opl3_hw_opl3_pc98.patch
net-remove-config_net_cbus-conditional-for-ns8390.patch
hotplug_cpu-avoid-hitting-too-many-cachelines-in-recalc_bh_state.patch
balance_dirty_pages_ratelimited-take-nr_pages-arg.patch
set_page_dirty-return-value-fixes.patch
msync-perform-dirty-page-levelling.patch
msync-ms_sync-dont-hold-mmap_sem-while-syncing.patch
msync-fix-return-value.patch
fsync-extract-internal-code.patch
msync-use-do_fsync.patch
secure-digital-host-controller-id-and-regs.patch
secure-digital-host-controller-id-and-regs-fix.patch
mmc-secure-digital-host-controller-interface-driver.patch
mmc-secure-digital-host-controller-interface-driver-fix.patch
mmc-sdhci-build-fix.patch
updated-documentation-nfsroottxt.patch
console_setup-depends-wrongly-on-config_printk.patch
conditionalize-compat_sys_newfstatat.patch
show-mcp-menu-only-on-arch_sa1100.patch
ide-allow-ide-interface-to-specify-its-not-capable-of-32-bit.patch
deprecate-the-kernel_thread-export.patch
fix-value-computed-not-used-warnings.patch
update-obsolete_oss_driver-schedule-and-dependencies.patch
update-obsolete_oss_driver-schedule-and-dependencies-update.patch
make-the-oss-sound_via82cxxx-option-available-again.patch
rio-more-header-cleanup.patch
rioboot-lindent.patch
rioboot-post-lindent.patch
rio-driver-rework-continued-1.patch
rio-driver-rework-continued-2.patch
rio-driver-rework-continued-3.patch
rio-driver-rework-continued-4.patch
rio-driver-rework-continued-5.patch
yet-more-rio-cleaning-1-of-2.patch
yet-more-rio-cleaning-2-of-2.patch
deprecate-the-tasklist_lock-export.patch
sys_setrlimit-cleanup.patch
rlimit_cpu-fix-handling-of-a-zero-limit.patch
rlimit_cpu-document-wrong-return-value.patch
ext3-properly-report-backup-block-present-in-a-group.patch
fix-module-refcount-leak-in-__set_personality.patch
# greg might have issues
timer-irq-driven-soft-watchdog-cleanups.patch
softlockup-detection-vs-cpu-hotplug.patch
timer-irq-driven-soft-watchdog-cleanups-update.patch
strndup_user.patch
strndup_user-convert-module.patch
strndup_user-convert-keyctl.patch
keys-fix-key-quota-management-on-key-allocation.patch
keys-replace-duplicate-non-updateable-keys-rather-than-failing.patch
jbd-embed-j_commit_timer-in-journal-struct.patch
jbd-convert-kjournald-to-kthread-api.patch
missed-error-checking-for-intents-filp-in-open_namei.patch
small-cleanup-in-quotah.patch
decrapify-asm-generic-localh.patch
fs-inodec-make-iprune_mutex-static.patch
reiserfs-fix-transaction-overflowing.patch
reiserfs-handle-trans_id-overflow.patch
reiserfs-reiserfs_file_write-will-lose-error-code-when-a-0-length-write-occurs-w-o_sync.patch
introduce-fmode_exec-file-flag.patch
add-lookup_instantiate_filp-usage-warning.patch
isdn-fix-copy_to_user-unused-result-warning-in-isdn_ppp.patch
constify-tty-flip-buffer-handling.patch
drivers-block-nbdc-dont-defer-compile-error-to-runtime.patch
hysdn-remove-custom-types.patch
remove-module_parm.patch
remove-module_parm-fix.patch
kernel-paramsc-make-param_array-static.patch
fix-edd-to-properly-ignore-signature-of-non-existing-drives.patch
fix-defined-but-not-used-warning-in-net-rxrpc-maincrxrpc_initialise.patch
sysrq-cleanup.patch
cache-align-futex-hash-buckets.patch
inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix-2.patch
ide-fix-section-mismatch-warning.patch
block-floppy-fix-section-mismatch-warnings.patch
move-pp_major-from-ppdevh-to-majorh.patch
# controversial:
mark-unwind-info-for-signal-trampolines-in-vdsos.patch
reiserfs-cleanups.patch
initcall-failure-reporting.patch
reiserfs-use-balance_dirty_pages_ratelimited_nr-in-reiserfs_file_write.patch
hp300-fix-driver_register-return-handling-remove-dio_module_init.patch
eisa-tidy-up-driver_register-return-value.patch
amiga-fix-driver_register-return-handling-remove-zorro_module_init.patch
kconfig-clarify-memory-debug-options.patch
v9fs-consolidate-trans_sock-into-trans_fd.patch
v9fs-rename-tids-to-tags-to-be-consistent-with-plan-9-documentation.patch
v9fs-print-9p-messages.patch
v9fs-print-9p-messages-fix.patch
v9fs-print-9p-messages-fix-2.patch
fs-9p-make-2-functions-static.patch
v9fs-print-9p-messages-fix-3.patch
v9fs-print-9p-messages-fix-4.patch
v9fs-add-extension-field-to-tcreate.patch
v9fs-fix-vfs_inode-dereference-before-null-check.patch
v9fs-update-license-boilerplate.patch
9p-fix-name-consistency-problems.patch
9p-update-documentation.patch
smbfs-fix-debug-logging-only-compilation-error.patch
adjust-dev-kmemmemport-write-handlers.patch
remove-maintainers-entry-for-rtlinux.patch
fix-hardcoded-values-in-collie-frontlight.patch
collie-fix-missing-pcmcia-bits.patch
tpm-sparc32-build-fix.patch
ads7846-build-fix.patch
irq-uninline-migration-functions.patch
irq-prevent-enabling-of-previously-disabled-interrupt.patch
pollrdhup-epollrdhup-handling-for-half-closed-devices.patch
add-a-proper-prototype-for-setup_arch.patch
refactor-capable-to-one-implementation-add-__capable-helper.patch
make-cap_ptrace-enforce-ptrace_tracme-checks.patch
fix-messages-in-fs-minix.patch
freeze_bdev-cleanup.patch
move-cond_resched-after-iput-in-sync_sb_inodes.patch
reduce-sched-latency-in-shrink_dcache_sb.patch
kallsyms-handle-malloc-failure.patch
per-cpufy-net-proto-structures-add-percpu_counter_modbh.patch
per-cpufy-net-proto-structures-add-percpu_counter_modbh-tidy.patch
percpu-counters-add-percpu_counter_exceeds.patch
percpu-counters-add-percpu_counter_exceeds-tidy.patch
per-cpufy-net-proto-structures-protomemory_allocated.patch
per-cpufy-net-proto-structures-protomemory_allocated-use-percpu_counter_exceeds.patch
per-cpufy-net-proto-structures-sockets_allocated.patch
per-cpufy-net-proto-structures-protoinuse.patch
per-cpufy-net-proto-structures-protoinuse-fix.patch
ext3-fix-debug-logging-only-compilation-error.patch
find_task_by_pid-needs-tasklist_lock.patch
blk_dev_initrd-do-not-require-blk_dev_ram=y.patch
reiserfs-xattr_aclcreiserfs_get_acl-make-size-an-int.patch
md-bitmapcbitmap_mask_state-fix-inconsequent-null-checking.patch
drivers-char-ipmi-ipmi_msghandlerc-fix-a-memory-leak.patch
removal-of-long-incorrect-address-for-jamie-lokier.patch
remove-dead-address-from-maintainers-list.patch
indirect_print_item-warning-fix.patch
update-some-vfs-documentation.patch
update-some-vfs-documentation-fix.patch
honour-aop_truncate_page-returns-in-page_symlink.patch
make-address_space_operations-sync_page-return-void.patch
make-address_space_operations-invalidatepage-return-void.patch
make-address_space_operations-invalidatepage-return-void-jbd-fix.patch
make-address_space_operations-invalidatepage-return-void-versus-git-nfs.patch
make-address_space_operations-invalidatepage-return-void-fix.patch
maintainers-remove-dead-url.patch
ext2-flags-shouldnt-report-nogrpid.patch
fix-backwards-meaning-of-ms_verbose.patch
no-need-to-protect-current-group_info-in-sys_getgroups.patch
roundup_pow_of_two-64-bit-fix.patch
fix-alloc_large_system_hash-roundup.patch
fix-a-race-condition-between-i_mapping-and-iput.patch
i2o_dump_hrt-output-cleanup.patch
compat_sys_nfsservctl-handle-errors-correctly.patch
radix-tree-documentation-cleanups.patch
i4l-isdn_ttyc-fix-a-check-after-use.patch
fix-sb_mixer-use-before-validation.patch
altix-rs422-support-for-ioc4-serial-driver.patch
altix-rs422-support-for-ioc4-serial-driver-fixes.patch
cpumask-uninline-first_cpu.patch
cpumask-uninline-next_cpu.patch
cpumask-uninline-highest_possible_processor_id.patch
cpumask-uninline-any_online_cpu.patch
oss-fix-leak-in-awe_wave-also-remove-pointless-cast.patch
fix-memory-leak-in-isapnp.patch
use-kzalloc-and-kcalloc-in-core-fs-code.patch
udf-fix-uid-gid-options-and-add-uid-gid=ignore-and-forget.patch
direct-io-bug-fix-in-dio-handling-write-error.patch
doc-more-serial-console-info.patch
check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu.patch
check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu-fix.patch
cleanup-smp_call_function-up-build.patch
use-unsigned-int-types-for-a-faster-bsearch.patch
eisa-ignore-generated-file-drivers-eisa-devlisth.patch
insert-identical-resources-above-existing-resources.patch
make-sure-nobodys-leaking-resources.patch
udf-remove-duplicate-definitions.patch
ipmi-add-generic-pci-handling.patch
ipmi-add-generic-pci-handling-tidy.patch
ipmi-add-full-sysfs-support.patch
ipmi-add-full-sysfs-support-fixes.patch
ipmi-add-full-sysfs-support-tidy.patch
ipmi-add-full-sysfs-support-tidy-2.patch
hpet-header-sanitization.patch
doc-fix-example-firmware-source-code.patch
use-__read_mostly-on-some-hot-fs-variables.patch
remove-needless-check-in-binfmt_elfc.patch
remove-needless-check-in-fs-read_writec.patch
add-sa_percpu_irq-flag-support.patch
kernel-timec-remove-unused-pps_-variables.patch
vfsfs-locksc-cleanup-locks_insert_block.patch
vfsfs-lockscnfsd4-add-race_free-posix_lock_file_conf.patch
vfsfs-lockscnfsd4-add-race_free-posix_lock_file_conf-tidy.patch
nfsd4-return-conflict-lock-without-races.patch

  Will merge, subject to re-review.

3c59x-use-mii_check_media.patch
3c59x-use-mii_check_media-tidy.patch
3c59x-decrease-polling-intervall.patch
3c59x-carriercheck-for-forced-media.patch
3c59x-use-ethtool_op_get_link.patch
3c59x-remove-per-driver-versioning.patch
3c59x-minor-cleanups.patch
3c59x-documentation-update.patch

  Will merge.

exec-allow-init-to-exec-from-any-thread.patch
simplify-exec-from-inits-subthread.patch
remove-dead-kill_sl-prototype-from-schedh.patch
do_tty_hangup-use-group_send_sig_info-not.patch
do_sak-dont-depend-on-session-id-0.patch
pidhash-kill-switch_exec_pids.patch
choose_new_parent-remove-unused-arg-sanitize-exit_state-check.patch
remove-add_parents-parent-argument.patch
dont-use-remove_links-set_links-for-reparenting.patch
kill-set_links-remove_links.patch
pidhash-dont-count-idle-threads.patch
pidhash-dont-use-zero-pids.patch
reparent_thread-use-remove_parent-add_parent.patch
wait_for_helper-trivial-style-cleanup.patch
release_task-replace-open-coded-ptrace_unlink.patch
convert-sighand_cache-to-use-slab_destroy_by_rcu.patch
introduce-lock_task_sighand-helper.patch
introduce-sig_needs_tasklist-helper.patch
copy_process-cleanup-bad_fork_cleanup_sighand.patch
copy_process-cleanup-bad_fork_cleanup_signal.patch
copy_process-cleanup-bad_fork_cleanup_signal-update.patch
cleanup-__exit_signal.patch
rename-__exit_sighand-to-cleanup_sighand.patch
move-__exit_signal-to-kernel-exitc.patch
revert-optimize-sys_times-for-a-single-thread-process.patch
do-__unhash_process-under-siglock.patch
sys_times-dont-take-tasklist_lock.patch
relax-sig_needs_tasklist.patch
do_signal_stop-dont-take-tasklist_lock.patch
do_group_exit-dont-take-tasklist_lock.patch
do_sigaction-dont-take-tasklist_lock.patch
pids-kill-pidtype_tgid.patch
make-fork-atomic-wrt-pgrp-session-signals.patch

  This is Oleg's romp through the core kernel.  There's a ton of material
  here.  I'll probably send it all to Linus and ask him to review it.  (aka
  blame-shifting).

mempool-add-page-allocator.patch
mempool-use-common-mempool-page-allocator.patch
mempool-add-kmalloc-allocator.patch
mempool-use-common-mempool-kmalloc-allocator.patch
mempool-add-kzalloc-allocator.patch
mempool-use-common-mempool-kzalloc-allocator.patch
mempool-add-mempool_create_slab_pool.patch
mempool-use-mempool_create_slab_pool.patch

  Will merge.

autofs4-lookup-white-space-cleanup.patch
autofs4-use-libfs-routines-for-readdir.patch
autofs4-cant-mount-due-to-mount-point-dir-not-empty.patch
autofs4-expire-code-readability-cleanup.patch
autofs4-simplify-expire-tree-traversal.patch
autofs4-fix-false-negative-return-from-expire.patch
autofs4-expire-mounts-that-hold-no-extra-references-only.patch
autofs4-remove-update_atime-unused-function.patch
autofs4-add-a-show-mount-options-for-proc-filesystem.patch
autofs4-white-space-cleanup-for-waitqc.patch
autofs4-rename-simple_empty_nolock-function.patch
autofs4-change-may_umount-functions-to-boolean.patch
autofs4-increase-module-version.patch
autofs4-nameidata-needs-to-be-up-to-date-for-follow_link.patch
autofs4-add-v5-follow_link-mount-trigger-method.patch
autofs4-add-v5-expire-logic.patch
autofs4-add-new-packet-type-for-v5-communications.patch
autofs4-add-new-packet-type-for-v5-communications-fix.patch
autofs4-change-autofs_typ_-autofs_type_.patch
remove-redundant-check-from-autofs4_put_super.patch
autofs4-follow_link-missing-funtionality.patch

  Will merge.

permit-dual-mit-gpl-licenses.patch
led-class-documentation.patch
led-add-led-class.patch
led-add-led-trigger-support.patch
led-add-led-timer-trigger.patch
led-add-sharp-charger-status-led-trigger.patch
led-add-led-device-support-for-the-zaurus-corgi-and.patch
led-add-led-device-support-for-locomo-devices.patch
led-add-led-device-support-for-ixp4xx-devices.patch
led-add-device-support-for-tosa.patch
led-add-nand-mtd-activity-led-trigger.patch
led-add-ide-disk-activity-led-trigger.patch
ensure-ide-taskfile-calls-any-driver-specific.patch

  Will merge.

2tb-files-st_blocks-is-invalid-when-calling-stat64.patch
2tb-files-add-blkcnt_t.patch
2tb-files-add-blkcnt_t-fixes.patch
2tb-files-change-type-of-kstatfs-entries.patch

  Will merge.

ext3-get-blocks-maping-multiple-blocks-at-a-once.patch
ext3-get-blocks-maping-multiple-blocks-at-a-once-vs-ext3_readdir-use-generic-readahead.patch
ext3-get-blocks-maping-multiple-blocks-at-a-once-get-block-chain-confliction-fix.patch
ext3-get-blocks-maping-multiple-blocks-at-a-once-journal-reentry-fix.patch
ext3-get-blocks-multiple-block-allocation.patch
ext3-get-blocks-support-multiple-blocks-allocation-in.patch
ext3-get-blocks-adjust-accounting-info-in.patch
ext3-get-blocks-adjust-accounting-info-in-fix.patch
ext3-get-blocks-adjust-reservation-window-size-for.patch

  Will merge.

change-buffer_headb_size-to-size_t.patch
pass-b_size-to-get_block.patch
pass-b_size-to-get_block-speedup.patch
pass-b_size-to-get_block-remove-unneeded-assignments.patch
map-multiple-blocks-for-mpage_readpages.patch
map-multiple-blocks-for-mpage_readpages-tidy.patch
map-multiple-blocks-for-mpage_readpages-use-buffer_mapped.patch
remove-get_blocks-support.patch
ext3-cleanups-and-warn_on.patch
ext3-multi-block-get_block.patch

  Will probably merge.

ext3-add-o-bh-option.patch
ext3-add-o-bh-option-fix.patch
ext3-nobh-writeback-support-for-filesystems-blocksize.patch

  Will less probably merge.

mutex-subsystem-add-include-asm-arm-mutexh-fix.patch

  Will send to rmk.

hrtimer-optimize-softirq-runqueues.patch
pass-current-time-to-hrtimer_forward.patch
posix-timer-cleanup-common_timer_get.patch
posix-timer-cleanup-common_timer_get-fix.patch
hrtimer-simplify-nanosleep.patch
hrtimer-remove-state-field.patch
hrtimer-remove-state-field-fix.patch
remove-it_real_value-calculation-from-proc-stat.patch
remove-define_ktime-and-ktime_to_clock_t.patch
remove-nsec_t-typedef.patch
hrtimers-remove-data-field.patch

  Will merge.

time-clocksource-infrastructure.patch
time-use-clocksource-infrastructure-for-update_wall_time.patch
time-let-user-request-precision-from-current_tick_length.patch
time-use-clocksource-abstraction-for-ntp-adjustments.patch
time-introduce-arch-generic-time-accessors.patch
time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
time-i386-conversion-part-2-rework-tsc-support.patch
time-i386-conversion-part-3-enable-generic-timekeeping.patch
time-i386-conversion-part-4-remove-old-timer_opts-code.patch
time-i386-clocksource-drivers.patch

  This has just been reissued.  Doesn't compile yet.  It's doubtful for
  2.6.17 - we'll see.

kprobes-clean-up-resume_execute.patch
x86-kprobes-booster.patch
x86-kprobes-booster-fix.patch
kretprobe-kretprobe-booster.patch
kretprobe-kretprobe-booster-spinlock-recursive-remove.patch
kretprobe-instance-recycled-by-parent-process.patch
kretprobe-instance-recycled-by-parent-process-tidy.patch
kretprobe-instance-recycled-by-parent-process-fix.patch
kprobe-handler-discard-user-space-trap.patch
kprobe-handler-discard-user-space-trap-fix.patch
kprobe-handler-discard-user-space-trap-fix-2.patch
kprobe-handler-discard-user-space-trap-fix-3.patch
kprobes-fix-broken-fault-handling-for-i386.patch
kprobes-fix-broken-fault-handling-for-x86_64.patch
kprobes-fix-broken-fault-handling-for-powerpc64.patch
kprobes-fix-broken-fault-handling-for-ia64.patch
kprobes-fix-broken-fault-handling-for-sparc64.patch
kprobes-fix-broken-fault-handling-for-sparc64-fix.patch

  Will merge.

dlm-core-locking.patch
dlm-core-locking-resend-lookups.patch
dlm-lockspaces-callbacks-directory.patch
dlm-communication.patch
dlm-recovery.patch
dlm-recovery-clear-new_master-flag.patch
dlm-recovery-remove-true-false-defines.patch
dlm-configuration.patch
dlm-device-interface.patch
dlm-device-interface-fix-device-refcount.patch
dlm-device-interface-dlm-force-unlock.patch
dlm-device-interface-missing-variable.patch
dlm-device-interface-check-allocation.patch
dlm-device-interface-fix-unlock-race.patch
dlm-device-interface-use-kzalloc.patch
dlm-debug-fs.patch
dlm-build.patch
dlm-node-weights.patch
dlm-rsb-flag-ops-with-inlined-functions.patch
dlm-rework-recovery-control.patch
dlm-better-handling-of-first-lock.patch
dlm-no-directory-option.patch
dlm-release-list-of-root-rsbs.patch
dlm-return-error-in-status-reply.patch
configfs-export-config_group_find_obj.patch
dlm-use-configfs.patch
dlm-remove-file.patch
dlm-use-jhash.patch
dlm-maintainer.patch
drivers-dlm-fix-up-schedule_timeout-usage.patch
dlm-cleanup-unused-functions.patch
dlm-include-own-headers.patch
dlm-sem2mutex.patch

  Will continue to baby-sit these in -mm.

isdn4linux-siemens-gigaset-drivers-kconfigs-and-makefiles.patch
isdn4linux-siemens-gigaset-drivers-common-module.patch
isdn4linux-siemens-gigaset-drivers-event-layer.patch
isdn4linux-siemens-gigaset-drivers-isdn4linux-interface.patch
isdn4linux-siemens-gigaset-drivers-tty-interface.patch
isdn4linux-siemens-gigaset-drivers-procfs-interface.patch
isdn4linux-siemens-gigaset-drivers-direct-usb-connection.patch
isdn4linux-siemens-gigaset-drivers-isochronous-data-handler.patch
isdn4linux-siemens-gigaset-drivers-m105-usb-dect-adapter.patch
dead-code-in-drivers-isdn-avm-avmcardh.patch

  Will ping Karsten.

edac-switch-to-kthread_-api.patch
edac-switch-to-kthread_-api-tidy.patch
edac-printk-cleanup.patch
edac-name-cleanup.patch
edac-amd76x-pci_dev_get-pci_dev_put-fixes.patch
edac-e752x-cleanup.patch
edac-i82860-cleanup.patch
edac-i82875p-cleanup.patch
edac-e7xxx-fix-minor-logic-bug.patch
edac-cleanup-code-for-clearing-initial-errors.patch
edac-edac_mc_add_mc-fix-1.patch
edac-edac_mc_add_mc-fix-2.patch
edac-kobject_init-kobject_put-fixes.patch
edac-kobject-sysfs-fixes.patch
edac-protect-memory-controller-list.patch
edac-kconfig-dependency-changes.patch
edac-reorder-export_symbol-macros.patch
edac-formatting-cleanup.patch
edac-documentation-spelling-fixes.patch
edac-use-sysbus_message-in-e752x-code.patch
edac-use-sysbus_message-in-e752x-code-fix.patch
edac-add-maintainers-for-chipset-drivers.patch
edac-use-export_symbol_gpl.patch

  Will merge.

knfsd-change-the-store-of-auth_domains-to-not-be-a-cache.patch
knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix.patch
knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-2.patch
knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3.patch
knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3-fix.patch
knfsd-break-the-hard-linkage-from-svc_expkey-to-svc_export.patch
knfsd-get-rid-of-inplace-sunrpc-caches.patch
knfsd-create-cache_lookup-function-instead-of-using-a-macro-to-declare-one.patch
knfsd-convert-ip_map-cache-to-use-the-new-lookup-routine.patch
knfsd-use-new-cache_lookup-for-svc_export.patch
knfsd-use-new-cache_lookup-for-svc_expkey-cache.patch
knfsd-use-new-sunrpc-cache-for-rsi-cache.patch
knfsd-use-new-cache-code-for-rsc-cache.patch
knfsd-use-new-cache-code-for-name-id-lookup-caches.patch
knfsd-an-assortment-of-little-fixes-to-the-sunrpc-cache-code.patch
knfsd-remove-definecachelookup.patch
knfsd-unexport-cache_fresh-and-fix-a-small-race.patch
knfsd-convert-sunrpc_cache-to-use-krefs.patch
knfsd-convert-sunrpc_cache-to-use-krefs-fix.patch
fs-nfsd-exportcnet-sunrpc-cachec-make-needlessly-global-code-static.patch

  Will merge after confirmation from Neil.

sched-fix-task-interactivity-calculation.patch
small-schedule-microoptimization.patch
#
sched-implement-smpnice.patch
sched-smpnice-apply-review-suggestions.patch
sched-smpnice-fix-average-load-per-run-queue-calculations.patch
sched-store-weighted-load-on-up.patch
sched-add-discrete-weighted-cpu-load-function.patch
sched-add-above-background-load-function.patch
# Suresh had problems
# con:
sched-cleanup_task_activated.patch
sched-make_task_noninteractive_use_sleep_type.patch
sched-dont_decrease_idle_sleep_avg.patch
sched-include_noninteractive_sleep_in_idle_detect.patch
sched-remove-on-runqueue-requeueing.patch
sched-activate-sched-batch-expired.patch
sched-reduce-overhead-of-calc_load.patch
#
sched-fix-interactive-task-starvation.patch
#
# "strange load balancing problems": pwil3058@bigpond.net.au
sched-new-sched-domain-for-representing-multi-core.patch
sched-fix-group-power-for-allnodes_domains.patch
x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch

  Will mostly-merge.  We'll see.

mm-implement-swap-prefetching.patch
mm-implement-swap-prefetching-fix.patch
mm-implement-swap-prefetching-tweaks.patch

  Still don't have a compelling argument for this, IMO.

cmpci-dont-use-generig_hweight32.patch
frv-remove-unnecessary-ampersand.patch
function-typo-fixes.patch
um-fix-undefined-reference-to-hweight32.patch
arm-fix-undefined-reference-to-generic_fls.patch
oss-sonicvibesc-defines-its-own-hweight32.patch
bitops-alpha-use-config-options-instead-of-__alpha_fix__-and-__alpha_cix__.patch
bitops-ia64-use-cpu_set-instead-of-__set_bit.patch
bitops-parisc-add-pair-in-__ffz-macro.patch
bitops-cris-remove-unnecessary-local_irq_restore.patch
bitops-use-non-atomic-operations-for-minix__bit-and-ext2__bit.patch
bitops-generic-test_and_setclearchange_bit.patch
bitops-generic-test_and_setclearchange_bit-fix.patch
bitops-generic-__test_and_setclearchange_bit-and-test_bit.patch
bitops-generic-__ffs.patch
bitops-generic-ffz.patch
bitops-generic-fls.patch
bitops-generic-fls64.patch
bitops-generic-find_nextfirst_zero_bit.patch
bitops-generic-sched_find_first_bit.patch
bitops-generic-ffs.patch
bitops-generic-hweight6432168.patch
bitops-generic-hweight6432168-fix.patch
bitops-generic-ext2_setcleartestfind_first_zerofind_next_zero_bit.patch
bitops-generic-ext2_setclear_bit_atomic.patch
bitops-generic-minix_testsettest_and_cleartestfind_first_zero_bit.patch
bitops-alpha-use-generic-bitops.patch
bitops-arm-use-generic-bitops.patch
bitops-arm26-use-generic-bitops.patch
bitops-cris-use-generic-bitops.patch
bitops-frv-use-generic-bitops.patch
bitops-h8300-use-generic-bitops.patch
bitops-i386-use-generic-bitops.patch
bitops-ia64-use-generic-bitops.patch
bitops-m32r-use-generic-bitops.patch
bitops-m68k-use-generic-bitops.patch
bitops-m68k-use-generic-bitops-fix.patch
bitops-ppc-use-generic-bitops.patch
bitops-m68knommu-use-generic-bitops.patch
bitops-mips-use-generic-bitops.patch
bitops-parisc-use-generic-bitops.patch
bitops-powerpc-use-generic-bitops.patch
bitops-s390-use-generic-bitops.patch
bitops-sh-use-generic-bitops.patch
bitops-sh64-use-generic-bitops.patch
bitops-sparc-use-generic-bitops.patch
bitops-sparc64-use-generic-bitops.patch
bitops-v850-use-generic-bitops.patch
bitops-x86_64-use-generic-bitops.patch
bitops-xtensa-use-generic-bitops.patch
bitops-update-include-asm-generic-bitopsh.patch
bitops-make-thread_infoflags-an-unsigned-long.patch
bitops-ia64-make-partial_pagebitmap-an-unsigned-long.patch
bitops-ntfs-remove-generic_ffs.patch
bitops-remove-unused-generic-bitops-in-include-linux-bitopsh.patch
bitops-hweight-related-cleanup.patch
bitops-hweight-speedup.patch

  Will merge

unify-pfn_to_page-generic-functions.patch
unify-pfn_to_page-sparc64-pfn_to_page.patch
unify-pfn_to_page-i386-pfn_to_page.patch
unify-pfn_to_page-x86_64-pfn_to_page.patch
unify-pfn_to_page-powerpc-pfn_to_page.patch
unify-pfn_to_page-alpha-pfn_to_page.patch
unify-pfn_to_page-arm-pfn_to_page.patch
unify-pfn_to_page-arm26-pfn_to_page.patch
unify-pfn_to_page-cris-pfn_to_page.patch
unify-pfn_to_page-frv-pfn_to_page.patch
unify-pfn_to_page-h8300-pfn_to_page.patch
unify-pfn_to_page-m32r-pfn_to_page.patch
unify-pfn_to_page-mips-pfn_to_page.patch
unify-pfn_to_page-parisc-pfn_to_page.patch
unify-pfn_to_page-ppc-pfn_to_page.patch
unify-pfn_to_page-s390-pfn_to_page.patch
unify-pfn_to_page-sh-pfn_to_page.patch
unify-pfn_to_page-sh64-pfn_to_page.patch
unify-pfn_to_page-sparc-pfn_to_page.patch
unify-pfn_to_page-uml-pfn_to_page.patch
unify-pfn_to_page-v850-pfn_to_page.patch
unify-pfn_to_page-xtensa-pfn_to_page.patch
unify-pfn_to_page-ia64-pfn_to_page.patch
remove-zone_mem_map.patch
for_each_online_pgdat-take2-define.patch
for_each_online_pgdat-take2-for_each_bootmem.patch
for_each_online_pgdat-take2-for_each_bootmem-fix.patch
for_each_online_pgdat-take2-renaming.patch
for_each_online_pgdat-take2-remove-sorting-pgdat.patch
for_each_online_pgdat-take2-remove-pgdat_list.patch
uninline-zone-helpers.patch
uninline-zone-helpers-fix.patch

  Will merge.

ia64-add-ptr-to-compatpatch.patch
s390-add-ptr-compatpatch.patch
parisc-add-ptr-compatpatch.patch
mips-add-ptr-compatpatch.patch
lightweight-robust-futexes-arch-defaults.patch
lightweight-robust-futexes-arch-defaults-fix.patch
lightweight-robust-futexes-core.patch
lightweight-robust-futexes-docs.patch
lightweight-robust-futexes-docs-update.patch
lightweight-robust-futexes-compat.patch
lightweight-robust-futexes-i386.patch
lightweight-robust-futexes-i386-fix.patch
lightweight-robust-futexes-x86_64.patch
lightweight-robust-futexes-x86_64-fix.patch

  Will merge.

notifier-chain-update-api-changes.patch
notifier-chain-update-api-changes-register-atomic_notifiers-in-atomic-context.patch
notifier-chain-update-api-changes-export-new-notifier-chain-routines-as-gpl.patch
notifier-chain-update-api-changes-avoid-calling-down_read-and-down_write-during-startup.patch
notifier-chain-update-simple-definition-changes.patch
notifier-chain-update-remove-unneeded-protection.patch
notifier-chain-update-remove-unneeded-protection-the-idle-notifier-chain-should-be-atomic.patch
notifier-chain-update-die_chain-changes.patch
notifier-chain-update-dont-unregister-yourself.patch
notifier-chain-update-dont-unregister-yourself-fix.patch
notifier-chain-update-changes-to-dcdbasc.patch
notifier-chain-update-update-usb_notify.patch
notifier-chain-update-remaining-changes-for-new-api.patch
notifier-chain-initialization.patch

  Will merge.  (Not my favouritest-ever patches, but they do fix bugs).

mips-fixed-collision-of-rtc-function-name.patch
rtc-subsystem-library-functions.patch
rtc-subsystem-library-functions-fix.patch
rtc-subsystem-arm-cleanup.patch
rtc-subsystem-arm-integrator-cleanup.patch
rtc-subsystem-class.patch
rtc-subsystem-i2c-cleanup.patch
rtc-subsystem-i2c-driver-ids.patch
rtc-subsystem-sysfs-interface.patch
rtc-subsystem-proc-interface.patch
rtc-subsystem-dev-interface.patch
rtc-subsystem-x1205-driver.patch
rtc-subsystem-test-device-driver.patch
rtc-subsystem-ds1672-driver.patch
rtc-subsystem-pcf8563-driver.patch
rtc-subsystem-rs5c372-driver.patch
rtc-subsystem-ep93xx-driver.patch
rtc-subsystem-sa1100-pxa2xx-driver.patch
rtc-subsystem-m48t86-driver.patch

  Will merge.

rtc-remove-rtc-uip-synchronization-on-x86.patch
rtc-remove-rtc-uip-synchronization-on-x86_64.patch
rtc-remove-rtc-uip-synchronization-on-x86_64-fix.patch
rtc-remove-rtc-uip-synchronization-on-sparc64.patch
rtc-remove-rtc-uip-synchronization-on-ppc-chrp-arch-ppc.patch
rtc-remove-rtc-uip-synchronization-on-chrp-arch-powerpc.patch
rtc-remove-rtc-uip-synchronization-on-ppc-maple.patch
rtc-remove-rtc-uip-synchronization-on-arm.patch
rtc-remove-rtc-uip-synchronization-on-mips-mc146818.patch
rtc-remove-rtc-uip-synchronization-on-mips-based-dec.patch
rtc-remove-rtc-uip-synchronization-on-sh03.patch
rtc-remove-rtc-uip-synchronization-on-sh-mpc1211.patch
rtc-remove-rtc-uip-synchronization-on-alpha.patch
rtc-fix-up-some-rtc-whitespace-and-style.patch
rtc-remove-some-duplicate-bcd-definitions.patch

  Will probably merge.

trivial-cleanup-to-proc_check_chroot.patch
resurrect-__put_task_struct.patch
task-rcu-protect-task-usage.patch
task-make-task-list-manipulations-rcu-safe.patch
make-setsid-more-robust.patch
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
dcache-add-helper-d_hash_and_lookup.patch
proc-rewrite-the-proc-dentry-flush-on-exit.patch
proc-close-the-race-of-a-process-dying-durning.patch
proc-refactor-reading-directories-of-tasks.patch
proc-refactor-reading-directories-of-tasks-dont-assume-pid_aliveinit_task-==-false.patch
proc-remove-tasklist_lock-from-proc_pid_readdir.patch
proc-remove-tasklist_lock-from-proc_pid_lookup-and.patch
proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid.patch
proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid-fix.patch
#
pidhash-refactor-the-pid-hash-table.patch
pidhash-refactor-the-pid-hash-table-fixes.patch
#
proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
proc-dont-lock-task_structs-indefinitely.patch
proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
proc-dont-lock-task_structs-indefinitely-mem_read-fix.patch
proc-dont-lock-task_structs-indefinitely-task_mmu-bug-fix.patch
proc-dont-lock-task_structs-indefinitely-kill-init_tref.patch
proc-dont-lock-task_structs-indefinitely-kill-init_tref-inode.patch
proc-dont-lock-task_structs-indefinitely-tref-ensure-the-references-is-always-on-the-first-task.patch
proc-dont-lock-task_structs-indefinitely-always-drop-the-reference-count-in-tid_fd_revalidate.patch
proc-dont-lock-task_structs-indefinitely-fix-the-locking-when-reading-the-number-of-threads-in.patch
proc-dont-lock-task_structs-indefinitely-fix-the-locking-when-reading-the-number-of-threads-in-nitpick.patch
proc-dont-lock-task_structs-indefinitely-fix-stat-on-proc-pid.patch
proc-use-struct-pid-not-struct-task_ref.patch
proc-optimize-proc_check_dentry_visible.patch
proc-use-sane-permission-checks-on-the-proc-pid-fd.patch
proc-use-sane-permission-checks-on-the-proc-pid-fd-fix.patch
proc-use-sane-permission-checks-on-the-proc-pid-fd-fix-2.patch
proc-cleanup-proc_fd_access_allowed.patch
proc-remove-tasklist_lock-from-proc_task_readdir.patch
simplify-fix-first_tid.patch
simplify-fix-first_tid-fix.patch
cleanup-next_tid.patch

  Eric's romp through /proc.  Scary, not sure yet.

pnp-parport-adjust-pnp_register_driver-signature.patch
pnp-mpu401-adjust-pnp_register_driver-signature.patch
pnp-cs4236-adjust-pnp_register_driver-signature.patch
pnp-opl3sa2-adjust-pnp_register_driver-signature.patch
pnp-irda-adjust-pnp_register_driver-signature.patch
pnp-cs4232-adjust-pnp_register_driver-signature.patch
pnp-pnp-adjust-pnp_register_driver-signature.patch

  Will merge.

reiser4-*

  Will retain in -mm.

ide-amd756-no-host-side-cable-detection.patch
small-fixes-backported-to-old-ide-sis-driver.patch
ide_generic_all_on-warning-fix.patch
fix-ide-locking-error.patch

  Will consult with Alan and Bart.

vgacon-fix-ega-cursor-resize-function.patch
vgacon-add-support-for-soft-scrollback.patch
nvidiafb-add-suspend-and-resume-hooks.patch
fbdev-framebuffer-driver-for-geode-gx.patch
fbdev-framebuffer-driver-for-geode-gx-update.patch
fbdev-framebuffer-driver-for-geode-gx-warning-fix.patch
fbdev-framebuffer-driver-for-geode-gx-kconfig-fix-2.patch
matroxfb-simply-return-what-i2c_add_driver-does.patch
matrox-maven-memory-allocation-and-other-cleanups.patch
au1200fb-alchemy-au1200-framebuffer-driver.patch
fbdev-make-bios-edid-reading-configurable.patch
framebuffer-cmap-setting-return-values.patch
rivafb-remove-null-check.patch
nvidiafb-remove-null-check.patch
nvidiafb-remove-null-check-2.patch
i810fb-remove-null-check.patch
savagefb-remove-null-check.patch
atyfb-remove-dead-code.patch
imsttfb-remove-dead-code.patch
nvidiafb-add-id-for-quadro-nvs280.patch
newportcon-sparse-fix-warnings-in-newport-driver-about.patch
fbdev-add-modeline-for-1680x1050-60.patch
drivers-video-use-array_size-macro.patch

  Will merge.

device-mapper-snapshot-fix-origin_write-pending_exception-submission.patch
device-mapper-snapshot-replace-sibling-list.patch
device-mapper-snapshot-replace-sibling-list-fix.patch
device-mapper-snapshot-fix-invalidation.patch
drivers-md-dm-raid1c-fix-inconsistent-mirroring-after-interrupted.patch
dm-remove-sector_format.patch
dm-make-sure-queue_flag_cluster-is-set-properly.patch
dm-snapshot-fix-kcopyd-destructor.patch
dm-flush-queue-eintr.patch
dm-store-md-name.patch
dm-tidy-mdptr.patch
dm-table-store-md.patch
dm-store-geometry.patch
dm-md-dependency-tree-in-sysfs-holders-slaves-subdirectory.patch
dm-md-dependency-tree-in-sysfs-bd_claim_by_kobject.patch
dm-md-dependency-tree-in-sysfs-md-to-use-bd_claim_by_disk.patch
dm-md-dependency-tree-in-sysfs-dm-to-use-bd_claim_by_disk.patch
dm-md-dependency-tree-in-sysfs-convert-bd_sem-to-bd_mutex.patch
dm-remove-unnecessary-typecast.patch
md-dm-reduce-stack-usage-with-stacked-block-devices.patch

  Will merge after checking with Alasdair

md-make-sure-queue_flag_cluster-is-set-properly-for-md.patch
md-add-4-to-the-list-of-levels-for-which-bitmaps-are-supported.patch
md-fix-the-failed-count-for-version-0-superblocks.patch
md-update-status_resync-to-handle-large-devices.patch
md-split-disks-array-out-of-raid5-conf-structure-so-it-is-easier-to-grow.patch
md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array.patch
md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array-init_list_head-to-list_head-conversions.patch
md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array-init_list_head-to-list_head-conversions-documentation-and-tidy-up-for-resize_stripes.patch
md-infrastructure-to-allow-normal-io-to-continue-while-array-is-expanding.patch
md-core-of-raid5-resize-process.patch
md-core-of-raid5-resize-process-make-new-function-stripe_to_pdidx-static.patch
md-final-stages-of-raid5-expand-code.patch
md-final-stages-of-raid5-expand-code-fix.patch
md-checkpoint-and-allow-restart-of-raid5-reshape.patch
md-checkpoint-and-allow-restart-of-raid5-reshape-remove-an-unused-variable.patch
md-only-checkpoint-expansion-progress-occasionally.patch
md-split-reshape-handler-in-check_reshape-and-start_reshape.patch
md-make-reshape-a-possible-sync_action-action.patch
md-support-suspending-of-io-to-regions-of-an-md-array.patch
md-improve-comments-about-locking-situation-in-raid5-make_request.patch
md-remove-some-stray-semi-colons-after-functions-called-in-macro.patch
sem2mutex-drivers-md.patch

  Will merge after checking with Neil.

optimize-select-poll-by-putting-small-data-sets-on-the-stack.patch
use-fget_light-in-select-poll.patch
fold-select_bits_alloc-free-into-caller-code.patch

  Will merge.

for_each_possible_cpu-defines-for_each_possible_cpu.patch
for_each_possible_cpu-defines-for_each_possible_cpu-fix.patch
for_each_possible_cpu-fixes-for-generic-part.patch
for_each_possible_cpu-network-codes.patch
for_each_possible_cpu-under-drivers-acpi.patch
for_each_possible_cpu-loopback-device.patch
for_each_possible_cpu-oprofile.patch
for_each_possible_cpu-scsi.patch
for_each_possible_cpu-for-arm.patch
for_each_possible_cpu-i386.patch
for_each_possible_cpu-i386-fix.patch
for_each_possible_cpu-i386-fix-2.patch
for_each_possible_cpu-ia64.patch
for_each_possible_cpu-mips.patch
for_each_possible_cpu-powerpc.patch
for_each_possible_cpu-ppc.patch
for_each_possible_cpu-s390.patch
for_each_possible_cpu-sh.patch
for_each_possible_cpu-sparc.patch
for_each_possible_cpu-sparc64.patch
for_each_possible_cpu-x86_64.patch
for_each_possible_cpu-xfs.patch
for_each_possible_cpu-documentaion.patch

  Will merge.

ia64-const-f_ops-fix.patch
mark-f_ops-const-in-the-inode.patch
make-most-file-operations-structs-in-fs-const.patch

  Will merge.

documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch
docs-update-missing-files-and-descriptions-for-filesystems-00-index.patch

  Will merge.

arch-i386-kernel-microcodec-remove-the-obsolete-microcode_ioctl.patch
drivers-block-use-time_after-and-friends.patch
nvidia-agp-use-time_before_eq.patch
ide-tape-use-time_after-time_after_eq.patch
drivers-scsi-use-time_after-and-friends.patch
replace-0xff-with-correct-dma_xbit_mask.patch
vfree-null-check-fixup-for-sb_card.patch
maestro3-vfree-null-check-fixup.patch
no-need-to-check-vfree-arg-for-null-in-oss-sequencer.patch
vfree-does-its-own-null-check-no-need-to-be-explicit-in-oss-msndc.patch
fix-signed-vs-unsigned-in-nmi-watchdog.patch
trivial-typos-in-documentation-cputopologytxt.patch
typos-grab-bag-of-the-month.patch

  Will merge.

