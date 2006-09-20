Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWITUy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWITUy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWITUy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:54:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751050AbWITUyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:54:55 -0400
Date: Wed, 20 Sep 2006 13:54:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19 -mm merge plans
Message-Id: <20060920135438.d7dd362b.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A wander through the -mm patch queue, along with some commentary on my
intentions.


When replying to this email, please rewrite the Subject: to something
appropriate.  Please also attempt to cc the appropriate developer(s).


There are quite a lot of patches here which belong in subsystem trees. 
I'll patchbomb the relevant maintainers soon.  Could I pleeeeeze ask that
they either merge the patches or solidly nack them (with reasons)?  Don't
just ignore it all and leave me hanging onto this stuff for ever.  Thanks.





autofs4-zero-timeout-prevents-shutdown.patch
rtc-lockdep-fix-workaround.patch
fix-longstanding-load-balancing-bug-in-the-scheduler.patch
trigger-a-syntax-error-if-percpu-macros-are-incorrectly-used.patch
allow-file-systems-to-manually-d_move-inside-of-rename.patch
jbd-fix-commit-of-ordered-data-buffers.patch
update-to-the-kernel-kmap-kunmap-api.patch

 Misc random patches.

 Will merge most of these, subject to re-review.

acpi-fix-section-for-cpu-init-functions.patch
acpi-fix-printk-format-warnings.patch
acpi-sci-interrupt-source-override.patch
acpi-clear-gpe-before-disabling-it.patch
asus_acpi-fix-proc-files-parsing.patch
asus_acpi-dont-printk-on-writing-garbage-to-proc-files.patch
acpi-mwait-c-state-fixes.patch
acpi-check-if-parent-is-on-dock.patch
acpi-add-removable-drive-bay-support.patch
fix-incorrect-handling-of-pci-express-root-bridge-_hid.patch

 ACPI queue -> Len

sound-core-use-seek_set-cur.patch
opl4-use-seek_set-cur.patch
gus-use-seek_set-cur.patch
mixart-use-seek_set-cur.patch

 ALSA queue -> Jaroslav

remove-silly-messages-from-input-layer.patch
stowaway-keyboard-support.patch
stowaway-keyboard-support-update.patch
stowaway-vs-driver-tree.patch
input-i8042-disable-keyboard-port-when-panicking-and-blinking.patch
i8042-activate-panic-blink-only-in-x.patch
wistron-fix-detection-of-special-buttons.patch

 Input queue -> Dmitry

kerneldoc-error-on-ata_piixc.patch
libata-add-40pin-short-cable-support-honour-drive.patch
libata-add-40pin-short-cable-support-honour-drive-fix.patch
1-of-2-jmicron-driver.patch
1-of-2-jmicron-driver-fix.patch
2-of-2-jmicron-driver-plumbing-and-quirk.patch
2-of-2-jmicron-driver-plumbing-and-quirk-cleanup.patch
non-libata-driver-for-jmicron-devices.patch
via-pata-controller-xfer-fixes.patch
via-pata-controller-xfer-fixes-fix.patch
via-sata-oops-on-init.patch

 ATA stuff.  I am hopelessly confused regarding which patches pertain to
 sata, which to pata and which to legacy IDE.  It's a matter of weeding
 through all of these and finding an appropriate route to get them merged.

mtd-maps-ixp4xx-partition-parsing.patch
fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch
mtd-printk-format-warning.patch
fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch
drivers-mtd-nand-au1550ndc-removal-of-old-code.patch

 MTD queue -> dwmw2

e1000-memory-leak-in-e1000_set_ringparam.patch
3x59x-fix-pci-resource-management.patch
update-smc91x-driver-with-arm-versatile-board-info.patch
drivers-net-acenicc-removal-of-old-code.patch
drivers-net-tokenring-lanstreamerc-removal-of-old-code.patch
drivers-net-tokenring-lanstreamerh-removal-of-old-code.patch
drivers-net-typhoonc-removal-of-old-code.patch
signedness-issue-in-drivers-net-phy-phy_devicec.patch
b44-fix-eeprom-endianess-issue.patch
fix-possible-null-ptr-deref-in-forcedeth.patch
ip100a-fix-tx-pause-bug-reset_tx-intr_handler.patch
ip100a-change-phy-address-search-from-phy=1-to-phy=0.patch
ip100a-correct-initial-and-close-hardware-step.patch
ip100a-solve-host-error-problem-in-low-performance.patch
forcedeth-hardirq-lockdep-warning.patch
drivers-net-ns83820c-add-paramter-to-disable-auto.patch
natsemi-add-support-for-using-mii-port-with-no-phy.patch
tulip-fix-shutdown-dma-irq-race.patch
tulip-fix-for-64-bit-mips.patch
tulip-natsemi-dp83840a-phy-fix.patch

 netdev queue -> Jeff

net-ipv6-bh_lock_sock_nested-on-tcp_v6_rcv.patch
via-ircc-fix-memory-leak.patch
atm-he-fix-section-mismatch.patch
add-netpoll-netconsole-support-to-vlan-devices.patch
neighbourc-pneigh_get_next-skips-published-entry.patch

 net queue -> davem

add-newline-to-nfs-dprintk.patch
fs-nfs-make-code-static.patch

 NFS queue -> Trond.

 The NFS git tree breaks autofs4 submounts.  Still.

pcmcia-update-alloc_io_space-for-conflict-checking-for-multifunction-pc-card-for-linux-kernel-26154.patch
pcmcia-ds-must_check-fixes.patch
config_pm=n-slim-drivers-pcmcia.patch
i82092-wire-up-errors-from-pci_register_driver.patch
drivers-net-pcmcia-xirc2ps_csc-remove-unused-label.patch
pcmcia-au1000_generic-fix.patch

 PCMCIA queue -> Dominik

ppc-fix-typo-in-cpm2h.patch
ppc-sbc8560-fixes.patch

 PPC queue -> Paul

drivers-returning-proper-error-from-serial-driver.patch
tickle-nmi-watchdog-on-serial-output.patch
tickle-nmi-watchdog-on-serial-output-fix.patch
config_pm=n-slim-drivers-serial-8250_pcic.patch
omap1510-serial-fix-for-115200-baud.patch
magic-sysrq-sak-does-nothing-on-serial-consoles.patch
8250-uart-backup-timer.patch

 Serial queue -> Russell

via-irq-quirk-behaviour-change.patch
pcie-check-and-return-bus_register-errors-fix.patch
pci-add-ich7-8-acpi-gpio-io-resource-quirks.patch
pci-quirks-update.patch

 PCI queue -> Greg

git-scsi-misc-nlmsg_multicast-fix.patch
drivers-scsi-aic7xxx-possible-cleanups.patch
drivers-scsi-small-cleanups.patch
drivers-scsi-qla2xxx-make-some-functions-static.patch
drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_match_scb-static.patch
aic7xxx-deinline-large-functions-save-80k-of-text.patch
aic7xxx-s-__inline-inline.patch
aic7xxx-fix-byte-i-o-order-in-ahd_inw.patch
drivers-scsi-aic7xxx-possible-cleanups-2.patch
scsi-clean-up-warnings-in-advansys-driver.patch
drivers-scsi-advansysc-cleanups.patch
dc395x-fix-printk-format-warning.patch
make-drivers-scsi-aic7xxx-aic79xx_coreahd_set_tags-static.patch
pci_module_init-conversion-in-scsi-subsys-2nd-try.patch
megaraid-gcc-41-warning-fix.patch
megaraid-fix-warnings-when-config_proc_fs=n.patch
megaraid-use-the-proper-type-to-hold-the-irq-number.patch
drivers-scsi-dpt-dpti_i2oh-removal-of-old.patch
drivers-scsi-gdthh-removal-of-old-scsi-code.patch
drivers-scsi-nsp32h-removal-of-old-scsi-code.patch
drivers-scsi-pcmcia-nsp_csh-removal-of-old.patch
drivers-message-fusion-linux_compath-removal-of-old-code.patch
signedness-issue-in-drivers-scsi-iprc.patch
signedness-issue-in-drivers-scsi-osstc.patch
bodge-scsi-misc-module-reference-count-checks-with-no-module_unload.patch
scsi-remove-seagateh.patch
scsi-seagate-scsi_cmnd-conversion.patch
aha152x-fix.patch
3w-xxxx-fix-ata-udma-upgrade-message-number.patch
scsi-included-header-cleanup.patch

 SCSI queue -> James

gregkh-usb-usb-storage-add-rio-karma-eject-support-fix.patch
fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
usb-storage-unusual_devsh-entry-for-sony.patch
microtek-usb-scanner-scsi_cmnd-conversion.patch
usb-force-root-hub-resume-after-power-loss.patch
usb-fix-root-hub-resume-when-config_usb_suspend-is-not-set.patch

 USB queue -> Greg

revert-x86_64-mm-i386-remove-lock-section.patch
unwinder-warning-fixes.patch
fix-x86_64-mm-i386-backtrace-ebp-fallback.patch
fix-x86_64-mm-i386-pda-smp-processorid.patch
fix-x86_64-mm-spinlock-cleanup.patch
x86-remaining-pda-patches.patch

 x86/x86_64 queue -> Andi

hot-add-mem-x86_64-fixup-externs.patch
hot-add-mem-x86_64-kconfig-changes.patch
hot-add-mem-x86_64-enable-sparsemem-in-sratc.patch
hot-add-mem-x86_64-memory_add_physaddr_to_nid-enable.patch
hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup.patch
hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup-fix.patch
hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup-fix-2.patch
hot-add-mem-x86_64-use-config_memory_hotplug_sparse.patch
hot-add-mem-x86_64-use-config_memory_hotplug_reserve.patch
hot-add-mem-x86_64-use-config_memory_hotplug_reserve-fix.patch

 Will merge.

xfs-add-lock-annotations-to-xfs_trans_update_ail-and-xfs_trans_delete_ail.patch
fs-xfs-xfs_dmapih-removal-of-old-code.patch
xfs-rename-uio_read.patch

 XFS queue -> xfs-masters

touchkit-ps-2-touchscreen-driver.patch

 Having trouble getting rid of this.  Will send to Dmitry.

mm-thrash-detect-process-thrashing-against-itself.patch

 Might drop this.

mm-vm_bug_on.patch
radix-tree-rcu-lockless-readside.patch
redo-radix-tree-fixes.patch
adix-tree-rcu-lockless-readside-update.patch
radix-tree-rcu-lockless-readside-semicolon.patch
adix-tree-rcu-lockless-readside-update-tidy.patch
adix-tree-rcu-lockless-readside-fix-2.patch
adix-tree-rcu-lockless-readside-fix-3.patch
radix-tree-cleanup-radix_tree_deref_slot-and.patch
cleanup-radix_tree_derefreplace_slot-calling-conventions.patch
cleanup-radix_tree_derefreplace_slot-calling-conventions-warning-fixes.patch
mm-tracking-shared-dirty-pages.patch
mm-tracking-shared-dirty-pages-nommu-fix-2.patch
mm-balance-dirty-pages.patch
mm-optimize-the-new-mprotect-code-a-bit.patch
mm-small-cleanup-of-install_page.patch
mm-fixup-do_wp_page.patch
mm-msync-cleanup.patch
mm-tracking-shared-dirty-pages-checks.patch
mm-tracking-shared-dirty-pages-wimp.patch
mm-make-functions-static.patch
convert-i386-numa-kva-space-to-bootmem.patch
convert-i386-numa-kva-space-to-bootmem-tidy.patch
bootmem-remove-useless-__init-in-header-file.patch
bootmem-mark-link_bootmem-as-part-of-the-__init-section.patch
bootmem-remove-useless-parentheses-in-bootmem-header.patch
bootmem-limit-to-80-columns-width.patch
bootmem-remove-useless-headers-inclusions.patch
bootmem-use-pfn-page-conversion-macros.patch
bootmem-miscellaneous-coding-style-fixes.patch
reduce-max_nr_zones-remove-two-strange-uses-of-max_nr_zones.patch
reduce-max_nr_zones-fix-max_nr_zones-array-initializations.patch
reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem.patch
reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem-tidy.patch
reduce-max_nr_zones-move-highmem-counters-into-highmemc-h.patch
reduce-max_nr_zones-move-highmem-counters-into-highmemc-h-fix.patch
reduce-max_nr_zones-page-allocator-zone_highmem-cleanup.patch
reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment.patch
reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup.patch
reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-fix.patch
reduce-max_nr_zones-make-zone_dma32-optional.patch
reduce-max_nr_zones-make-zone_highmem-optional.patch
reduce-max_nr_zones-make-zone_highmem-optional-fix.patch
reduce-max_nr_zones-make-zone_highmem-optional-fix-fix.patch
reduce-max_nr_zones-make-zone_highmem-optional-fix-fix-fix.patch
reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones.patch
reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix.patch
reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix-fix.patch
reduce-max_nr_zones-fix-i386-srat-check-for-max_nr_zones.patch
mempolicies-fix-policy_zone-check.patch
apply-type-enum-zone_type.patch
apply-type-enum-zone_type-fix.patch
linearly-index-zone-node_zonelists.patch
out-of-memory-notifier.patch
out-of-memory-notifier-tidy.patch
cpu-hotplug-compatible-alloc_percpu.patch
cpu-hotplug-compatible-alloc_percpu-fix.patch
cpu-hotplug-compatible-alloc_percpu-fix-2.patch
add-kerneldocs-for-some-functions-in-mm-memoryc.patch
mm-remove_mapping-safeness.patch
mm-remove_mapping-safeness-fix.patch
mm-non-syncing-lock_page.patch
slab-respect-architecture-and-caller-mandated-alignment.patch
mm-swap-write-failure-fixup.patch
mm-swap-write-failure-fixup-update.patch
mm-swap-write-failure-fixup-fix.patch
oom-use-unreclaimable-info.patch
oom-reclaim_mapped-on-oom.patch
oom-cpuset-hint.patch
oom-handle-current-exiting.patch
oom-handle-oom_disable-exiting.patch
oom-swapoff-tasks-tweak.patch
oom-kthread-infinite-loop-fix.patch
oom-more-printk.patch
bootmem-use-max_dma_address-instead-of-low32limit.patch
add-some-comments-to-slabc.patch
#mm-speculative-get_page.patch
#mm-speculative-get_page-uninlining.patch
#mm-speculative-get_page-fix.patch
#mm-lockless-pagecache.patch
update-some-mm-comments.patch
slab-optimize-kmalloc_node-the-same-way-as-kmalloc.patch
slab-optimize-kmalloc_node-the-same-way-as-kmalloc-fix.patch
slab-extract-__kmem_cache_destroy-from-kmem_cache_destroy.patch
slab-do-not-panic-when-alloc_kmemlist-fails-and-slab-is-up.patch
slab-fix-lockdep-warnings.patch
slab-fix-lockdep-warnings-fix.patch
slab-fix-lockdep-warnings-fix-2.patch
add-__gfp_thisnode-to-avoid-fallback-to-other-nodes-and-ignore.patch
add-__gfp_thisnode-to-avoid-fallback-to-other-nodes-and-ignore-fix.patch
sys_move_pages-do-not-fall-back-to-other-nodes.patch
guarantee-that-the-uncached-allocator-gets-pages-on-the-correct.patch
cleanup-add-zone-pointer-to-get_page_from_freelist.patch
profiling-require-buffer-allocation-on-the-correct-node.patch
define-easier-to-handle-gfp_thisnode.patch
fix-potential-stack-overflow-in-mm-slabc.patch
standardize-pxx_page-macros.patch
standardize-pxx_page-macros-fix.patch
optimize-free_one_page.patch
do-not-check-unpopulated-zones-for-draining-and-counter.patch
extract-the-allocpercpu-functions-from-the-slab-allocator.patch
introduce-mechanism-for-registering-active-regions-of-memory.patch
have-power-use-add_active_range-and-free_area_init_nodes.patch
have-power-use-add_active_range-and-free_area_init_nodes-ppc-fix.patch
have-x86-use-add_active_range-and-free_area_init_nodes.patch
have-x86-use-add_active_range-and-free_area_init_nodes-fix.patch
have-x86_64-use-add_active_range-and-free_area_init_nodes.patch
have-ia64-use-add_active_range-and-free_area_init_nodes.patch
have-ia64-use-add_active_range-and-free_area_init_nodes-fix.patch
account-for-memmap-and-optionally-the-kernel-image-as-holes.patch
account-for-memmap-and-optionally-the-kernel-image-as-holes-fix.patch
account-for-holes-that-are-outside-the-range-of-physical-memory.patch
allow-an-arch-to-expand-node-boundaries.patch
replace-min_unmapped_ratio-by-min_unmapped_pages-in-struct-zone.patch
zvc-support-nr_slab_reclaimable--nr_slab_unreclaimable.patch
zone_reclaim-dynamic-slab-reclaim.patch
zone_reclaim-dynamic-slab-reclaim-tidy.patch
zone-reclaim-with-slab-avoid-unecessary-off-node-allocations.patch
oom-kill-update-comments-to-reflect-current-code.patch
hugepages-use-page_to_nid-rather-than-traversing-zone-pointers.patch
numa-add-zone_to_nid-function.patch
numa-add-zone_to_nid-function-update.patch
vm-add-per-zone-writeout-counter.patch
own-header-file-for-struct-page.patch
convert-s390-page-handling-macros-to-functions.patch
convert-s390-page-handling-macros-to-functions-fix.patch
page-invalidation-cleanup.patch
slab-fix-kmalloc_node-applying-memory-policies-if-nodeid-==-numa_node_id.patch
slab-fix-kmalloc_node-applying-memory-policies-if-nodeid-==-numa_node_id-fix.patch
condense-output-of-show_free_areas.patch
add-numa_build-definition-in-kernelh-to-avoid-ifdef.patch
disable-gfp_thisnode-in-the-non-numa-case.patch
gfp_thisnode-for-the-slab-allocator-v2.patch
gfp_thisnode-for-the-slab-allocator-v2-fix.patch
add-node-to-zone-for-the-numa-case.patch
add-node-to-zone-for-the-numa-case-fix.patch
get-rid-of-zone_table.patch
get-rid-of-zone_table-fix.patch
do-not-allocate-pagesets-for-unpopulated-zones.patch
zone_statistics-use-hot-node-instead-of-cold-zone_pgdat.patch
deal-with-cases-of-zone_dma-meaning-the-first-zone.patch
introduce-config_zone_dma.patch
optional-zone_dma-in-the-vm.patch
optional-zone_dma-in-the-vm-tidy.patch
optional-zone_dma-for-i386.patch
optional-zone_dma-for-x86_64.patch
optional-zone_dma-for-ia64.patch
remove-zone_dma-remains-from-parisc.patch
remove-zone_dma-remains-from-sh-sh64.patch
mm-micro-optimise-zone_watermark_ok.patch

 Memory management queue (big, isn't it?).  Will merge.

acx1xx-wireless-driver.patch
fix-tiacx-on-alpha.patch
tiacx-fix-attribute-packed-warnings.patch
tiacx-pci-build-fix.patch
tiacx-ia64-fix.patch
tiacx-build-fix.patch
tiacx-sparse-cleanups.patch

 We're unable to work out whether this is safe to merge (it's
 reverse-engineered).  I might drop it.

selinux-eliminate-selinux_task_ctxid.patch
selinux-rename-selinux_ctxid_to_string.patch
selinux-replace-ctxid-with-sid-in.patch
selinux-enable-configuration-of-max-policy-version.patch
selinux-enable-configuration-of-max-policy-version-improve-security_selinux_policydb_version_max_value-help-texts.patch
selinux-add-support-for-range-transitions-on-object.patch
selinux-1-3-eliminate-inode_security_set_security.patch
selinux-2-3-change-isec-semaphore-to-a-mutex.patch
selinux-3-3-convert-sbsec-semaphore-to-a-mutex.patch
selinux-fix-tty-locking.patch

 Will merge.

binfmt_elf-consistently-use-loff_t.patch

 Will merge.

frv-use-the-generic-irq-stuff.patch
frv-improve-frvs-use-of-generic-irq-handling.patch
frv-permit-__do_irq-to-be-dispensed-with.patch
frv-fix-fls-to-handle-bit-31-being-set-correctly.patch
frv-implement-fls64.patch
frv-optimise-ffs.patch

 Will merge

alchemy-delete-unused-pt_regs-argument-from-au1xxx_dbdma_chan_alloc.patch

 MIPS-related IDE changes.  Will merge.

avr32-arch.patch
avr32-config_debug_bugverbose-and-config_frame_pointer.patch
avr32-fix-invalid-constraints-for-stcond.patch
avr32-add-support-for-irq-flags-state-tracing.patch
avr32-turn-off-support-for-discontigmem-and-sparsemem.patch
avr32-always-enable-config_embedded.patch
avr32-export-the-find__bit-functions.patch
avr32-add-defconfig-for-at32stk1002.patch
avr32-use-autoconf-instead-of-marker.patch
avr32-dont-assume-anything-about-max_nr_zones.patch
avr32-add-i-o-port-access-primitives.patch
avr32-use-linux-pfnh.patch
avr32-kill-config_discontigmem-support-completely.patch
avr32-fix-bug-in-__avr32_asr64.patch
avr32-switch-to-generic-timekeeping-framework.patch
avr32-set-kbuild_defconfig.patch
avr32-kprobes-compile-fix.patch
avr32-asm-ioh-should-include-asm-byteorderh.patch
avr32-fix-output-constraints-in-asm-bitopsh.patch
avr32-standardize-pxx_page-macros-fix.patch
avr32-rename-at32stk100x-atstk100x.patch
avr32-dont-leave-dbe-set-when-resetting-cpu.patch
avr32-make-prot_write-prot_exec-imply-prot_read.patch
avr32-remove-set_wmb.patch
avr32-use-parse_early_param.patch
avr32-fix-exported-headers.patch
avr32-fix-__const_udelay-overflow-bug.patch
remove-zone_dma-remains-from-avr32.patch

 AVR32 architecture.  Will fold into a single patch, and will merge.

avr32-mtd-static-memory-controller-driver-try-2.patch
avr32-mtd-at49bv6416-platform-device-for-atstk1000.patch
avr32-mtd-unlock-flash-if-necessary.patch

 MTD changes for avr32.   Will send to dwmw2.

nommu-check-that-access_process_vm-has-a-valid-target.patch
nommu-set-bdi-capabilities-for-dev-mem-and-dev-kmem.patch
nommu-set-bdi-capabilities-for-dev-mem-and-dev-kmem-tidy.patch
nommu-use-find_vma-rather-than-reimplementing-a-vma-search.patch
check-if-start-address-is-in-vma-region-in-nommu-function-get_user_pages.patch
nommu-check-vma-protections.patch
nommu-permit-ptrace-to-ignore-non-prot_write-vmas-in-nommu-mode.patch
nommu-implement-proc-pid-maps-for-nommu.patch
nommu-order-the-per-mm_struct-vma-list.patch
nommu-make-mremap-partially-work-for-nommu-kernels.patch
nommu-add-docs-about-shared-memory.patch
nommu-make-futexes-work-under-nommu-conditions.patch
nommu-make-futexes-work-under-nommu-conditions-doc.patch
nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch
nommu-move-the-fallback-arch_vma_name-to-a-sensible-place-fix.patch

 Will merge.

hpet-rtc-emulation-add-watchdog-timer-2.patch
sleazy-fpu-feature-i386-support.patch
add-seccomp_disable_tsc-config-option.patch
i386-fix-recursive-faults-during-oops-when-current.patch
i386-show_registers-try-harder-to-print-failing.patch
use-bug_onfoo-instead-of-if-foo-bug-in-include-asm-i386-dma-mappingh.patch
apm-clean-up-module-initalization.patch
x86-remove-locally-defined-ldt-structure-in-favour-of-standard-type.patch
x86-implement-always-locked-bit-ops-for-memory-shared-with-an-smp-hypervisor.patch
x86-roll-all-the-cpuid-asm-into-one-__cpuid-call.patch
x86-make-__fixaddr_top-variable-to-allow-it-to-make-space-for-a-hypervisor.patch
x86-add-a-bootparameter-to-reserve-high-linear-address-space.patch
x86-put-note-sections-into-a-pt_note-segment-in-vmlinux.patch
x86-put-note-sections-into-a-pt_note-segment-in-vmlinux-fix.patch
x86-enable-vmsplit-for-highmem-kernels.patch
x86-trivial-pgtableh-__assembly__-move.patch
x86-trivial-move-of-__have-macros-in-i386-pagetable-headers.patch
x86-trivial-move-of-ptep_set_access_flags.patch
x86-remove-unused-include-from-efi_stubs.patch
i386-adds-smp_call_function_single.patch
voyager-tty-locking.patch
i386-kill-references-to-xtime.patch
mtrr-add-lock-annotations-for-prepare_set-and.patch
x86-remove-default_ldt-and-simplify-ldt-setting.patch
i386-adds-smp_call_function_single-fix.patch

 Random x86 things.  Will merge.

 I think from hereon I'll be sending all x86 updates through Andi.

convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls.patch
convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls-tidy.patch

 This patch causes bad performance regression on NUMAQ.  Won't merge until
 that is resolved.

alpha-fix-alpha_ev56-dependencies-typo.patch

 Will merge.

swsusp-write-timer.patch
swsusp-write-speedup.patch
swsusp-read-timer.patch
swsusp-read-speedup.patch
swsusp-read-speedup-fix.patch
swsusp-read-speedup-cleanup.patch
swsusp-read-speedup-cleanup-2.patch
swsusp-read-speedup-fix-fix-2.patch
swsusp-clean-up-browsing-of-pfns.patch
swsusp-struct-snapshot_handle-cleanup.patch
make-swsusp-avoid-memory-holes-and-reserved-memory-regions-on-x86_64.patch
disable-cpu-hotplug-during-suspend-2.patch
swsusp-fix-mark_free_pages.patch
swsusp-reorder-memory-allocating-functions.patch
swsusp-fix-alloc_pagedir.patch
clean-up-suspend-header.patch
change-the-name-of-pagedir_nosave.patch
swsusp-introduce-some-helpful-constants.patch
swsusp-introduce-memory-bitmaps.patch
swsusp-use-memory-bitmaps-during-resume.patch
swsusp-use-memory-bitmaps-during-resume-fix.patch
swsusp-use-suspend_console.patch
pm-make-it-possible-to-disable-console-suspending.patch
pm-make-it-possible-to-disable-console-suspending-fix.patch
pm-make-it-possible-to-disable-console-suspending-fix-2.patch
make-it-possible-to-disable-serial-console-suspend.patch
i386-detect-clock-skew-during-suspend.patch
pm-add-pm_trace-switch.patch
pm-add-pm_trace-switch-doc.patch

 Will merge.

uml-use-klibc-setjmp-longjmp.patch
uml-use-array_size-more-assiduously.patch
uml-fix-stack-alignment.patch
uml-whitespace-fixes.patch
uml-fix-handling-of-failed-execs-of-helpers.patch
uml-improve-sigbus-diagnostics.patch
uml-sigio-cleanups.patch
uml-move-signal-handlers-to-arch-code.patch
uml-move-signal-handlers-to-arch-code-fix.patch
uml-timer-cleanups.patch
uml-remove-unused-variable.patch
uml-clean-our-set_ether_mac.patch
uml-stack-usage-reduction.patch
uml-tty-locking.patch
split-i386-and-x86_64-ptraceh.patch
split-i386-and-x86_64-ptraceh-fix.patch
make-uml-use-ptrace-abih.patch

 Will merge.

uml-use-mcmodel=kernel-for-x86_64.patch
uml-fix-proc-vs-interrupt-context-spinlock-deadlock.patch

 These are on hold.  I'll poll Jeff.

uml-remove-pte_mkexec.patch

 This is "-mm only"

s390-fix-cmm-kernel-thread-handling.patch

 Will merge.

deprecate-smbfs-in-favour-of-cifs.patch

 Will poll sfrench, see if we're ready to switch everyone over to CIFS yet.

block-layer-early-detection-of-medium-not-present.patch
scsi-core-and-sd-early-detection-of-medium-not-present.patch
sd-early-detection-of-medium-not-present.patch

 James has issues with these.  Will poll him and will drop them if that's
 negative.

scsi-early-detection-of-medium-not-present-updated.patch

 -> James

edac-new-opteron-athlon64-memory-controller-driver.patch
edac-new-opteron-athlon64-memory-controller-driver-tidy.patch

 There was a bunfight over these which I need to reignite so we can get some
 closure.

add-address_space_operationsbatch_write.patch
add-address_space_operationsbatch_write-fix.patch
pass-io-size-to-batch_write-address-space-operation.patch

 These add a new address_space operation.  For reiser4, with potential for
 use by other filesystems.

 Problem is, 2.6.18 has a significant writev() performace regression on NFS
 and probably on other filesystems.  Because 2.6.18 does
 prepare_write/commit_write for each iovec segment.  We want to go back to
 copying mulitple iovec segments within a single prepare_write/commit_write.

 Plus there's still the possible deadlock in our standard write() function
 (thw thing which fault_in_pages_readable() tries to prevent).

 All of this should be fixed.  But these new patches ehshrine the
 one-prepare_write-per-segment concept in the filemap.c function layout. 
 These patches should be dropped.

autofs4-needs-to-force-fail-return-revalidate.patch
kdump-introduce-reset_devices-command-line-option.patch
drivers-edac-make-code-static.patch
fat-cleanup-fat_get_blocks.patch
inode_diet-replace-inodeugeneric_ip-with-inodei_private.patch
inode_diet-replace-inodeugeneric_ip-with-inodei_private-gfs-fix.patch
inode-diet-move-i_pipe-into-a-union.patch
inode-diet-move-i_bdev-into-a-union.patch
inode-diet-move-i_cdev-into-a-union.patch
inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch
inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix.patch
inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix-fix.patch
reiserfs-warn-about-the-useless-nolargeio-option.patch
x86-microcode-microcode-driver-cleanup.patch
x86-microcode-microcode-driver-cleanup-tidy.patch
x86-microcode-using-request_firmware-to-pull-microcode.patch
x86-microcode-add-sysfs-and-hotplug-support.patch
x86-microcode-add-sysfs-and-hotplug-support-fix.patch
x86-microcode-add-sysfs-and-hotplug-support-fix-fix-2.patch
x86-microcode-dont-check-the-size.patch
consistently-use-max_errno-in-__syscall_return.patch
consistently-use-max_errno-in-__syscall_return-fix.patch
eisa-bus-modalias-attributes-support-1.patch
eisa-bus-modalias-attributes-support-1-fix.patch
eisa-bus-modalias-attributes-support-1-fix-git-kbuild-fix.patch
alloc_fdtable-cleanup.patch
include-__param-section-in-read-only-data-range.patch
msi-use-kmem_cache_zalloc.patch
sysctl-allow-proc-sys-without-sys_sysctl.patch
sysctl-allow-proc-sys-without-sys_sysctl-fix.patch
sysctl-document-that-sys_sysctl-will-be-removed.patch
pid-implement-transfer_pid-and-use-it-to-simplify-de_thread.patch
pid-remove-temporary-debug-code-in-attach_pid.patch
de_thread-use-tsk-not-current.patch
add-probe_kernel_address.patch
x86-use-probe_kernel_address-in-handle_bug.patch
kernel-params-must_check-fixes.patch
blockdevc-check-errors.patch
blockdevc-check-errors-fix.patch
block-handle-subsystem_register-init-errors.patch
fs-namespace-handle-init-registration-errors.patch
make-prot_write-imply-prot_read.patch
debug-variants-of-linked-list-macros.patch
make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on.patch
make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on-fix.patch
remove-unnecessary-barrier-in-rtc_get_rtc_time.patch
drivers-char-scx200_gpioc-make-code-static.patch
drivers-char-pc8736x_gpioc-remove-unused-static-functions.patch
let-warn_on-warn_on_once-return-the-condition.patch
let-warn_on-warn_on_once-return-the-condition-fix.patch
let-warn_on-warn_on_once-return-the-condition-fix-2.patch
scx200_gpio-export-cleanups.patch
make-net48xx-led-use-scx200_gpio_ops.patch
libfs-remove-page-up-to-date-check-from-simple_readpage.patch
kernel-doc-for-relay-interface.patch
kernel-doc-move-filesystems-together.patch
kthread-convert-loopc-to-kthread.patch
fs-conversions-from-kmallocmemset-to-kzcalloc.patch
include-documentation-for-functions-in-drivers-base-classc.patch
fix-parameter-names-in-drivers-base-classc.patch
fs-removing-useless-casts.patch
spinlock_debug-dont-recompute-jiffies_per_loop.patch
omap-add-smc91x-support-for-ti-omap2420-h4-board.patch
omap-add-watchdog-driver-support.patch
omap-add-watchdog-driver-support-tweaks.patch
omap-add-keypad-driver-4.patch
omap-update-omap1-2-boards-to-give-keymapsize-and-other.patch
use-gcc-o1-in-fs-reiserfs-only-for-ancient-gcc-versions.patch
irq-fixed-coding-style.patch
irq-removed-a-extra-line.patch
efi-add-lock-annotations-for-efi_call_phys_prelog-and-efi_call_phys_epilog.patch
mbcache-add-lock-annotation-for-__mb_cache_entry_release_unlock.patch
afs-add-lock-annotations-to-afs_proc_cell_servers_startstop.patch
fuse-add-lock-annotations-to-request_end-and-fuse_read_interrupt.patch
hugetlbfs-add-lock-annotation-to-hugetlbfs_forget_inode.patch
lockdep-dont-pull-in-includes-when-lockdep-disabled.patch
jbd-add-lock-annotation-to-jbd_sync_bh.patch
bluetooth-guard-bt_proto-with-rwlock.patch
bluetooth-use-gfp_atomic-in-_sock_creates-sk_alloc.patch
fs-add-lock-annotation-to-grab_super.patch
rcu-add-lock-annotations-to-rcu_bh_torture_read_lockunlock.patch
kthread-drivers-base-firmware_classc.patch
require-mmap-handler-for-aout-executables.patch
module_subsys-initialize-earlier.patch
fuse-use-dentry-in-statfs.patch
vfs-define-new-lookup-flag-for-chdir.patch
timer-add-lock-annotation-to-lock_timer_base.patch
dmi-decode-and-save-oem-string-information.patch
remove-unused-tty_struct-variable.patch
ignore-partition-table-on-disks-with-aix-label.patch
#aio-remove-unused-aio_run_iocbs.patch
task_struct-ifdef-missedem-v-ipc.patch
ifdef-blktrace-debugging-fields.patch
mount-udf-udf_part_flag_read_only-partitions-with-ms_rdonly.patch
fix-intel-rng-detection.patch
rtmutex-clean-up-and-remove-some-extra-spinlocks.patch
rtmutex-clean-up-and-remove-some-extra-spinlocks-more.patch
oom_adj-oom_score-documentation.patch
fix-kerneldoc-comments-in-kernel-timerc.patch
fix-kerneldoc-comments-in-kernel-timerc-fix.patch
there-is-no-devfs-there-has-never-been-a-devfs-we-have.patch
move-valid_dma_direction-from-x86_64-to-generic-code.patch
move-valid_dma_direction-from-x86_64-to-generic-code-fix.patch
use-valid_dma_direction-in-include-asm-i386-dma-mappingh.patch
lsm-remove-bsd-secure-level-security-module.patch
tty_ioc-keep-davej-sane.patch
apple-motion-sensor-driver-2.patch
apple-motion-sensor-driver-2-fixes-update.patch
apple-motion-sensor-driver-kconfig-fix.patch
single-bit-flip-detector.patch
single-bit-flip-detector-tidy.patch
ucb1x00-ts-handle-errors-from-input_register_device.patch
console-utf-8-mode-fixes.patch
make-reiserfs-default-to-barrier=flush.patch
make-ext3-mount-default-to-barrier=1.patch
reiserfs_fsync-should-only-use-barriers-when-they-are-enabled.patch
fix-reiserfs-latencies-caused-by-data=ordered.patch
ifdef-quota_read-quota_write.patch
unwind-fix-unused-variable-warning-when.patch
reiserfs-ifdef-xattr_sem.patch
reiserfs-ifdef-acl-stuff-from-inode.patch
fsh-ifdef-security-fields.patch
oprofile-ppro-need-to-enable-disable-all-the-counters.patch
add-o-flush-for-fat.patch
tty-locking-on-resize.patch
kthread-convert-arch-i386-kernel-apmc.patch
fix-unserialized-task-files-changing.patch
fix-unserialized-task-files-changing-fix.patch
fix-conflict-with-the-is_init-identifier-on-parisc.patch
pidspace-is_init.patch
chardev-checking-of-overlapping-ranges.patch
ahci-ati-sb600-sata-support-for-various-modes.patch
atiixp-ati-sb600-ide-support-for-various-modes.patch
lockdep-print-kernel-version.patch
memory-ordering-in-__kfifo-primitives.patch
small-update-to-credits.patch
fix-wrong-error-code-on-interrupted-close-syscalls.patch
fix-wrong-error-code-on-interrupted-close-syscalls-fix.patch
remove-another-configh.patch
make-ledsh-include-relevant-headers.patch
config_pm=n-slim-drivers-parport-parport_serialc.patch
config_pm=n-slim-sound-oss-tridentc.patch
config_pm=n-slim-sound-oss-cs46xxc.patch
ext3-and-jbd-cleanup-remove-whitespace.patch
remove-old-drivers-char-s3c2410_rtcc.patch
sound-mips-au1x00-use-array_size-macro.patch
sound-sparc-dbri-use-array_size-macro.patch
check-return-value-of-cpu_callback.patch
fix-serial-amba-pl011c-console-kconfig.patch
elf_core_dump-dont-take-tasklist_lock.patch
elf_fdpic_core_dump-dont-take-tasklist_lock.patch
fix-memory-leak-in-vc_resize-vc_allocate.patch
dquot-add-proper-locking-when-using-current-signal-tty.patch
update-documentation-kernel-parameterstxt.patch
posix-timers-fix-clock_nanosleep-doesnt-return-the-remaining-time-in-compatibility-mode-2.patch
posix-timers-fix-the-flags-handling-in-posix_cpu_nsleep-2.patch
i-o-error-attempting-to-read-last-partial-block-of-a-file-in-an-iso9660-file-system.patch
has_stopped_jobs-cleanup.patch
__dequeue_signal-cleanup.patch
simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem-2.patch
kexec-warning-fix.patch
tty-trivial-kzalloc-opportunity.patch
tty-lock-ticogwinsz.patch
tty-stop-the-tty-vanishing-under-procfs-access.patch
exit-fix-crash-case.patch
tty-make-termios_sem-a-mutex.patch
tty-make-termios_sem-a-mutex-fix.patch
cdev-documentation-was-drop-second-arg-of-unregister_chrdev.patch
use-decimal-for-ptrace_attach-and-ptrace_detach.patch
return-better-error-codes-if-drivers-char-rawc-module-init-fails.patch
fix-____call_usermodehelper-errors-being-silently-ignored.patch
kill-extraneous-printk-in-kernel_restart.patch
do_sched_setscheduler-dont-take-tasklist_lock.patch
introduce-is_rt_policy-helper.patch
sched_setscheduler-fix-policy-checks.patch
reparent_to_init-use-has_rt_policy.patch
copy_process-cosmetic-ioprio-tweak.patch
autofs4-autofs4_follow_link-false-negative-fix.patch
autofs4-pending-flag-not-cleared-on-mount-fail.patch
futex_find_get_task-dont-take-tasklist_lock.patch
sys_get_robust_list-dont-take-tasklist_lock.patch
docbook-fix-segfault-in-docprocc.patch
solaris-emulation-incorrect-tty-locking.patch
solaris-emulation-incorrect-tty-locking-fix.patch
solaris-emulation-incorrect-tty-locking-fix-2.patch
tty-fix-bits-and-note-more-bits-to-fix.patch
windfarm_smu_satc-simplify-around-i2c_add_driver.patch
make-spinlock-rwlock-annotations-more-accurate-by-using.patch
replace-_spin_trylock-with-spin_trylock-in-the-irq.patch
ext3-turn-on-reservation-dump-on-block-allocation-errors.patch
ext3-add-more-comments-in-block-allocation-reservation-code.patch
generic-boolean.patch
fs-ntfs-conversion-to-generic-boolean.patch
fs-jfs-conversion-to-generic-boolean.patch
block_devc-mutex_lock_nested-fix.patch
fix-mem_write-return-value.patch
doc-fix-kernel-parameters-quiet.patch
pass-a-lock-expression-to-__cond_lock-like-__acquire-and.patch
cramfs-rewrite-init_cramfs_fs.patch
freevxfs-fix-leak-on-error-path.patch
cramfs-make-cramfs_uncompress_exit-return-void.patch
9p-fix-leak-on-error-path.patch
ban-register_filesystemnull.patch
jbd-use-build_bug_on-in-journal-init.patch
fix-ext3-mounts-at-16t.patch
fix-ext3-mounts-at-16t-fix.patch
fix-ext2-mounts-at-16t.patch
fix-ext2-mounts-at-16t-fix.patch
more-ext3-16t-overflow-fixes.patch
more-ext3-16t-overflow-fixes-fix.patch
ext3-inode-numbers-are-unsigned-long.patch
ext3-inode-numbers-are-unsigned-long-fix.patch
lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis.patch
really-ignore-kmem_cache_destroy-return-value.patch
make-kmem_cache_destroy-return-void.patch
set-exit_dead-state-in-do_exit-not-in-schedule.patch
kill-pf_dead-flag.patch
introduce-task_dead-state.patch
select_bad_process-kill-a-bogus-pf_dead-task_dead-check.patch
select_bad_process-cleanup-releasing-check.patch
oom_kill_task-cleanup-mm-checks.patch
oom-dont-kill-current-when-another-oom-in-progress.patch
fix-typo-in-rtc-kconfig.patch
cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map.patch
cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map-fix.patch
cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map-fix-2.patch
cpuset-hotunplug-cpus-and-mems-in-all-cpusets.patch
remove-sound-oss-copying.patch
fs-partitions-conversion-to-generic-boolean.patch
loop-forward-port-resource-leak-checks-from-solar.patch
maximum-latency-tracking-infrastructure.patch
maximum-latency-tracking-infrastructure-tidy.patch
maximum-latency-tracking-alsa-support.patch
add-to-maintainers-file.patch
lib-rwsemc-un-inline-rwsem_down_failed_common.patch
add-section-on-function-return-values-to-codingstyle.patch
fs-nameic-replace-multiple-current-fs-by-shortcut-variable.patch
fs-nameic-replace-multiple-current-fs-by-shortcut-variable-tidy.patch
superh-maintainership-change.patch
mem-driver-fix-conditional-on-isa-i-o-support.patch
remove-static-variable-mm-page-writebackctotal_pages.patch
call-mm-page-writebackcset_ratelimit-when-new-pages.patch
call-mm-page-writebackcset_ratelimit-when-new-pages-tidy.patch
valid_swaphandles-fix.patch
mention-documenation-abi-requirements-in-documentation-submitchecklist.patch
rate-limiting-for-the-ldisc-open-failure-messages.patch
lib-ts_fsmc-constify-structs.patch
submittingpatches-cleanups.patch
ibm-acpi-documentation-delete-irrelevant-how-to-compile-external-module.patch
network-block-device-is-mostly-known-as-nbd.patch
superh-list-is-moderated.patch
sys-modules-patch-allow-full-length-section-names.patch
uninitialized-variable-in-drivers-net-wan-syncpppc.patch
enforce-rlimit_nofile-in-poll.patch
generic-infrastructure-for-acls.patch
generic-infrastructure-for-acls-update.patch
access-control-lists-for-tmpfs.patch
access-control-lists-for-tmpfs-cleanup.patch
ext3-wrong-error-behavior.patch
stop_machinec-copyright.patch
build-sound-sound_firmwarec-only-for-oss.patch
build-sound-sound_firmwarec-only-for-oss-doc.patch
rtc-more-xstp-vdet-support-for-rtc-rs5c348-driver.patch
generic_serial-remove-private-decoding-of-baud-rate-bits.patch
istallion-remove-private-baud-rate-decoding-which-is.patch
specialix-remove-private-speed-decoding.patch
fix-locking-for-tty-drivers-when-doing-urgent-characters.patch
audit-accounting-tty-locking.patch
documentation-submittingdrivers-minor-update.patch
clean-up-expand_fdtable-and-expand_files-take-2.patch
expand_fdtable-remove-pointless-unlocklock.patch
kcore-elf-note-namesz-field-fix.patch
lockdep-core-improve-the-lock-chain-hash.patch
linux-kernel-dump-test-module.patch
linux-kernel-dump-test-module-fixes.patch
ext3-more-whitespace-cleanups.patch
ext3-fix-sparse-warnings.patch
submittingpatches-add-a-note-about-format=flowed-when-sending-patches.patch
kmemdup-introduce.patch
kmemdup-some-users.patch
cpuset-fix-obscure-attach_task-vs-exiting-race.patch
create-fs-utimesc.patch
cciss-support-for-2tb-logical-volumes.patch
serial-fix-up-offenders-peering-at-baud-bits-directly.patch
remove-the-old-bd_mutex-lockdep-annotation.patch
new-bd_mutex-lockdep-annotation.patch
codingstyle-cleanup-for-kernel-sysc.patch
allow-proc-configgz-to-be-built-as-a-module.patch
add-config_headers_check-option-to-automatically-run-make-headers_check.patch
add-config_headers_check-option-to-automatically-run-make-headers_check-nobble.patch
pci-via82cxxx_audio-use-pci_get_device.patch
pci-cs46xx-oss-switch-to-pci_get_device.patch
pci-piix-use-refcounted-interface-when-searching-for-a-450nx.patch
pci-serverworks-switch-to-pci-refcounted-interfaces.patch
pci-sis5513-switch-to-pci-refcounting.patch
pci-mtd-switch-to-pci_get_device-and-do-ref-counting.patch
pci-via-switch-to-pci_get_device-refcounted-pci-api.patch
mbcs-use-seek_set-cur.patch
eicon-isdn-removed-unused-definitions-for-os_seek_.patch
vfs-use-seek_set-cur.patch
proper-flags-type-of-spin_lock_irqsave.patch
submit-checklist-mention-headers_check.patch
doc-lockdep-design-explain-display-of-state-bits.patch
leds-turn-led-off-when-changing-triggers.patch
directed-yield-cpu_relax-variants-for-spinlocks-and-rw-locks.patch
directed-yield-direct-yield-of-spinlocks-for-powerpc.patch
directed-yield-direct-yield-of-spinlocks-for-s390.patch
synclink_gt-add-bisync-and-monosync-modes.patch
synclink_gt-increase-max-devices.patch
cciss-remove-unneeded-spaces-in-output-for-attached-volumes-resend.patch

 Misc patches.  Will merge, subject to re-review.

pass-sparse-the-lock-expression-given-to-lock-annotations.patch

 Will merge.

ntp-move-all-the-ntp-related-code-to-ntpc.patch
ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch
ntp-add-ntp_update_frequency.patch
ntp-add-ntp_update_frequency-fix.patch
ntp-add-time_adj-to-tick-length.patch
ntp-add-time_freq-to-tick-length.patch
ntp-prescale-time_offset.patch
ntp-add-time_adjust-to-tick-length.patch
ntp-remove-time_tolerance.patch
ntp-convert-time_freq-to-nsec-value.patch
ntp-convert-to-the-ntp4-reference-model.patch
ntp-cleanup-defines-and-comments.patch
kernel-time-ntpc-possible-cleanups.patch
kill-wall_jiffies.patch

 Will merge.

reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
reiserfs-clean-up-bitmap-block-buffer-head-references.patch
reiserfs-reorganize-bitmap-loading-functions.patch
reiserfs-on-demand-bitmap-loading.patch
reiserfs-use-generic_file_open-for-open-checks.patch
reiserfs-eliminate-minimum-window-size-for-bitmap-searching.patch

 Will merge.

vectorize-aio_read-aio_write-fileop-methods.patch
vectorize-aio_read-aio_write-fileop-methods-xfs-fix.patch
vectorize-aio_read-aio_write-fileop-methods-hypfs-fix.patch
remove-readv-writev-methods-and-use-aio_read-aio_write.patch
streamline-generic_file_-interfaces-and-filemap.patch
streamline-generic_file_-interfaces-and-filemap-gfs-fix.patch
add-vector-aio-support.patch
add-vector-aio-support-fix.patch

 Will probably merge.  It depends upon interactions with the writev() problem
 described above.

add-genetlink-utilities-for-payload-length-calculation.patch
fix-taskstats-size-calculation-use-the-new-genetlink-utility-functions.patch
fix-getdelaysc-cpumask-length-and-error-reporting.patch

 Will merge.

csa-basic-accounting-over-taskstats.patch
csa-basic-accounting-over-taskstats-fix.patch
csa-extended-system-accounting-over-taskstats.patch
csa-convert-config-tag-for-extended-accounting-routines.patch
csa-accounting-taskstats-update.patch

 Will merge.

reiserfs-make-sure-all-dentries-refs-are-released-before-calling-kill_block_super-try-2.patch
fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch
fs-cache-generic-filesystem-caching-facility.patch
fs-cache-release-page-private-in-failed-readahead.patch
fs-cache-release-page-private-after-failed-readahead-12.patch
fs-cache-make-kafs-use-fs-cache.patch
fs-cache-make-kafs-use-fs-cache-fix.patch
fs-cache-make-kafs-use-fs-cache-12.patch
fs-cache-make-kafs-use-fs-cache-12-fix.patch
fs-cache-make-kafs-use-fs-cache-vs-streamline-generic_file_-interfaces-and-filemap.patch
nfs-use-local-caching.patch
nfs-use-local-caching-12.patch
nfs-use-local-caching-12-fix.patch
add-missing-page_copy-export-for-ppc-and-powerpc.patch
fs-cache-cachefiles-ia64-missing-copy_page-export.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-printk-format-warning.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-cachefiles_write_page-shouldnt-indicate-error-twice.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-handle-enospc-on-create-mkdir-better.patch
fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-inode-count-maintenance.patch
autofs-make-sure-all-dentries-refs-are-released-before-calling-kill_anon_super.patch
vfs-destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch

 Sigh.  Will merge if Trond is OK with it.

r-o-bind-mount-prepare-for-write-access-checks-collapse-if.patch
r-o-bind-mount-prepwork-move-open_nameis-vfs_create.patch
r-o-bind-mount-unlink-monitor-i_nlink.patch
r-o-bind-mount-prepwork-inc_nlink-helper.patch
r-o-bind-mount-clean-up-ocfs2-nlink-handling-2.patch
r-o-bind-mount-monitor-zeroing-of-i_nlink.patch

Will merge.


stack-overflow-safe-kdump-safe_smp_processor_id.patch
stack-overflow-safe-kdump-safe_smp_processor_id_voyager.patch
stack-overflow-safe-kdump-crash_use_safe_smp_processor_id.patch
stack-overflow-safe-kdump-crash_use_safe_smp_processor_id-fix.patch
stack-overflow-safe-kdump-safe_smp_send_nmi_allbutself.patch

Will merge.

generic-ioremap_page_range-implementation.patch
generic-ioremap_page_range-implementation-fix.patch
generic-ioremap_page_range-implementation-nommu-fix.patch
generic-ioremap_page_range-flush_cache_vmap.patch
generic-ioremap_page_range-alpha-conversion.patch
generic-ioremap_page_range-avr32-conversion.patch
generic-ioremap_page_range-cris-conversion.patch
generic-ioremap_page_range-i386-conversion.patch
generic-ioremap_page_range-i386-conversion-fix.patch
generic-ioremap_page_range-m32r-conversion.patch
generic-ioremap_page_range-mips-conversion.patch
generic-ioremap_page_range-mips-conversion-fix.patch
generic-ioremap_page_range-parisc-conversion.patch
generic-ioremap_page_range-s390-conversion.patch
generic-ioremap_page_range-sh-conversion.patch
generic-ioremap_page_range-sh64-conversion.patch
generic-ioremap_page_range-x86_64-conversion.patch
generic-ioremap_page_range-x86_64-conversion-fix.patch

 Will merge.

paravirt-remove-read-hazard-from-cow.patch
paravirt-pte-clear-not-present.patch
paravirt-lazy-mmu-mode-hooks.patch
paravirt-combine-flush-accessed-dirty.patch
paravirt-kpte-flush.patch
paravirt-optimize-ptep-establish-for-pae.patch
paravirt-remove-set-pte-atomic.patch
paravirt-pae-compile-fix.patch
paravirt-update-pte-hook.patch

 Will merge if they're still suitable.

vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers.patch
vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers-alpha-fix.patch
nfs-represent-64-bit-fileids-as-64-bit-inode-numbers-on-32-bit-systems.patch

 Will merge.

some-cleanup-in-the-pipe-code.patch
some-cleanup-in-the-pipe-code-tidy.patch
create-call_usermodehelper_pipe.patch
support-piping-into-commands-in-proc-sys-kernel-core_pattern.patch
support-piping-into-commands-in-proc-sys-kernel-core_pattern-fix.patch
support-piping-into-commands-in-proc-sys-kernel-core_pattern-fix-2.patch

 Will merge.

proc-readdir-race-fix-take-3.patch
proc-readdir-race-fix-take-3-race-fix.patch
proc-reorder-the-functions-in-basec.patch
proc-modify-proc_pident_lookup-to-be-completely-table-driven.patch
proc-give-the-root-directory-a-task.patch
pid-implement-access-helpers-for-a-tacks-various-process-groups.patch
pid-add-do_each_pid_task.patch
pid-implement-signal-functions-that-take-a-struct-pid.patch
pid-export-the-symbols-needed-to-use-struct-pid.patch
pid-implement-pid_nr.patch
vt-rework-the-console-spawning-variables.patch
vt-make-vt_pid-a-struct-pid-making-it-pid-wrap-around-safe.patch
file-modify-struct-fown_struct-to-use-a-struct-pid.patch
file-modify-struct-fown_struct-to-use-a-struct-pid-fix.patch
remove-null-check-in-register_nls.patch
fs-inodec-tweaks.patch
const-struct-tty_operations.patch
pids-coding-style-use-struct-pidmap.patch
proc-readdir-race-fix-take-3-fix-1.patch
simplify-pid-iterators.patch
move-pidmap-to-pspaceh.patch
move-pidmap-to-pspaceh-fix.patch
define-struct-pspace.patch
proc-readdir-race-fix-take-3-fix-2.patch
update-mq_notify-to-use-a-struct-pid.patch
file-add-locking-to-f_getown.patch
usb-fixup-usb-so-it-uses-struct-pid.patch
s390-update-fs3270-to-use-a-struct-pid.patch

 Will merge.

mxser-make-an-experimental-clone.patch

 Will merge.

kprobes-make-kprobe-modules-more-portable.patch
kprobes-make-kprobe-modules-more-portable-update.patch
kprobes-handle-symbol-resolution-when-modulesymbol-is-specified.patch
kprobes-handle-symbol-resolution-when-modulesymbol-is-specified-tidy.patch
add-regs_return_value-helper.patch
update-documentation-kprobestxt.patch
update-documentation-kprobestxt-update.patch

 Will merge.

isdn4linux-gigaset-driver-fix-__must_check-warning.patch
isdn-work-around-excessive-udelay.patch
hisax-niccy-cleanup.patch

 Will merge.

cpumask-add-highest_possible_node_id.patch
cpumask-export-cpu_online_map-and-cpu_possible_map.patch
cpumask-export-node_to_cpu_mask-consistently.patch

 Will merge.

knfsd-knfsd-add-some-missing-newlines-in-printks.patch
knfsd-knfsd-remove-an-unused-variable-from-e_show.patch
knfsd-knfsd-remove-an-unused-variable-from-auth_unix_lookup.patch
knfsd-add-a-callback-for-when-last-rpc-thread-finishes.patch
knfsd-add-a-callback-for-when-last-rpc-thread-finishes-tidy.patch
knfsd-add-a-callback-for-when-last-rpc-thread-finishes-fix.patch
knfsd-be-more-selective-in-which-sockets-lockd-listens-on.patch
knfsd-remove-nfsd_versbits-as-intermediate-storage-for-desired-versions.patch
knfsd-separate-out-some-parts-of-nfsd_svc-which-start-nfs-servers.patch
knfsd-separate-out-some-parts-of-nfsd_svc-which-start-nfs-servers-tweaks.patch
knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports.patch
knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports-tidy.patch
knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports-fix.patch
knfsd-allow-sockets-to-be-passed-to-nfsd-via-portlist.patch
knfsd-use-seq_start_token-instead-of-hardcoded-magic-void1.patch
nfsd-add-lock-annotations-to-e_start-and-e_stop.patch
knfsd-drop-serv-option-to-svc_recv-and-svc_process.patch
knfsd-drop-serv-option-to-svc_recv-and-svc_process-nfs-callback-fix-nfs-callback-fix.patch
knfsd-check-return-value-of-lockd_up-in-write_ports.patch
knfsd-move-makesock-failed-warning-into-make_socks.patch
knfsd-correctly-handle-error-condition-from-lockd_up.patch
knfsd-move-tempsock-aging-to-a-timer.patch
knfsd-move-tempsock-aging-to-a-timer-tidy.patch
knfsd-convert-sk_inuse-to-atomic_t.patch
knfsd-use-new-lock-for-svc_sock-deferred-list.patch
knfsd-convert-sk_reserved-to-atomic_t.patch
knfsd-test-and-set-sk_busy-atomically.patch
knfsd-split-svc_serv-into-pools.patch
knfsd-split-svc_serv-into-pools-fix.patch
knfsd-add-svc_get.patch
knfsd-add-svc_set_num_threads.patch
knfsd-use-svc_set_num_threads-to-manage-threads-in-knfsd.patch
knfsd-make-rpc-threads-pools-numa-aware.patch
knfsd-make-rpc-threads-pools-numa-aware-fix.patch
knfsd-allow-admin-to-set-nthreads-per-node.patch
nfsd-lockdep-annotation.patch
knfsd-nfsd-lockdep-annotation-fix.patch
knfsd-call-lockd_down-when-closing-a-socket-via-a-write-to-nfsd-portlist.patch
knfsd-protect-update-to-sn_nrthreads-with-lock_kernel.patch
knfsd-fixed-handling-of-lockd-fail-when-adding-nfsd-socket.patch
knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one.patch
knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one-fix.patch
knfsd-avoid-excess-stack-usage-in-svc_tcp_recvfrom.patch
knfsd-prepare-knfsd-for-support-of-rsize-wsize-of-up-to-1mb-over-tcp.patch
knfsd-allow-max-size-of-nfsd-payload-to-be-configured.patch
knfsd-make-nfsd-readahead-params-cache-smp-friendly.patch
knfsd-knfsd-cache-ipmap-per-tcp-socket.patch
knfsd-hide-use-of-lockds-h_monitored-flag.patch
knfsd-consolidate-common-code-for-statd-lockd-notification.patch
knfsd-when-looking-up-a-lockd-host-pass-hostname-length.patch
knfsd-lockd-introduce-nsm_handle.patch
knfsd-lockd-introduce-nsm_handle-fix.patch
knfsd-misc-minor-fixes-indentation-changes.patch
knfsd-lockd-make-nlm_host_rebooted-use-the-nsm_handle.patch
knfsd-lockd-make-the-nsm-upcalls-use-the-nsm_handle.patch
knfsd-lockd-make-the-hash-chains-use-a-hlist_node.patch
knfsd-lockd-change-list-of-blocked-list-to-list_node.patch
knfsd-change-nlm_file-to-use-a-hlist.patch
knfsd-lockd-make-nlm_traverse_-more-flexible.patch
knfsd-lockd-add-nlm_destroy_host.patch
knfsd-simplify-nlmsvc_invalidate_all.patch
knfsd-lockd-optionally-use-hostnames-for-identifying-peers.patch
knfsd-make-nlmclnt_next_cookie-smp-safe.patch
knfsd-match-granted_res-replies-using-cookies.patch
knfsd-export-nsm_local_state-to-user-space-via-sysctl.patch
knfsd-lockd-fix-use-of-h_nextrebind.patch
knfsd-register-all-rpc-programs-with-portmapper-by-default.patch
knfsd-lockd-introduce-nsm_handle-sem2mutex.patch
knfsd-svcrpc-gss-factor-out-some-common-wrapping-code.patch
knfsd-svcrpc-gss-fix-failure-on-svc_denied-in-integrity-case.patch
knfsd-svcrpc-use-consistent-variable-name-for-the-reply-state.patch
knfsd-nfsd4-refactor-exp_pseudoroot.patch
knfsd-nfsd4-clean-up-exp_pseudoroot.patch
knfsd-nfsd4-acls-relax-the-nfsv4-posix-mapping.patch
knfsd-nfsd4-acls-fix-inheritance.patch
knfsd-nfsd4-acls-simplify-nfs4_acl_nfsv4_to_posix-interface.patch
knfsd-nfsd4-acls-fix-handling-of-zero-length-acls.patch

 Will merge.

sched-force-sbin-init-off-isolated-cpus.patch
sched-remove-unnecessary-sched-group-allocations.patch
sched-remove-unnecessary-sched-group-allocations-fix.patch
sched-dont-print-migration-cost-when-only-1-cpu.patch
lower-migration-thread-stop-machine-prio.patch
sched-generic-sched_group-cpu-power-setup.patch
sched-fixing-wrong-comment-for-find_idlest_cpu.patch
scheduler-numa-aware-placement-of-sched_group_allnodes.patch

 Will merge.

sched2-sched-domain-sysctl.patch

 -mm only.

sched-add-above-background-load-function.patch
mm-implement-swap-prefetching.patch
swap_prefetch-vs-zoned-counters.patch
zvc-support-nr_slab_reclaimable--nr_slab_unreclaimable-swap_prefetch.patch
reduce-max_nr_zones-swap_prefetch-remove-incorrect-use-of-zone_highmem.patch
sched-cleanup-remove-task_t-convert-to-struct-task_struct-prefetch.patch
numa-add-zone_to_nid-function-swap_prefetch.patch

 Will continue to dither.

ecryptfs-fs-makefile-and-fs-kconfig.patch
ecryptfs-fs-makefile-and-fs-kconfig-kconfig-help-update.patch
ecryptfs-documentation.patch
ecryptfs-makefile.patch
ecryptfs-main-module-functions.patch
ecryptfs-header-declarations.patch
ecryptfs-superblock-operations.patch
#ecryptfs-superblock-operations-ecryptfs-build-fix.patch
ecryptfs-dentry-operations.patch
ecryptfs-file-operations.patch
#ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap.patch
#ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch
ecryptfs-inode-operations.patch
ecryptfs-mmap-operations.patch
ecryptfs-mmap-operations-fix.patch
ecryptfs-keystore.patch
ecryptfs-crypto-functions.patch
ecryptfs-crypto-functions-mutex-fixes.patch
fs-ecryptfs-possible-cleanups.patch
ecryptfs-debug-functions.patch
ecryptfs-alpha-build-fix.patch
ecryptfs-convert-assert-to-bug_on.patch
ecryptfs-remove-pointless-bug_ons.patch
ecryptfs-remove-unnecessary-null-checks.patch
ecryptfs-rewrite-ecryptfs_fsync.patch
ecryptfs-overhaul-file-locking.patch
ecryptfs-remove-lock-propagation.patch
ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch
ecryptfs-asm-scatterlisth-linux-scatterlisth.patch
ecryptfs-support-for-larger-maximum-key-size.patch
ecryptfs-add-codes-for-additional-ciphers.patch
ecryptfs-unencrypted-key-size-based-on-encrypted-key-size.patch
ecryptfs-packet-and-key-management-update-for-variable-key-size.patch
ecryptfs-add-ecryptfs_-prefix-to-mount-options-key-size-parameter.patch
ecryptfs-set-the-key-size-from-the-default-for-the-mount.patch
ecryptfs-check-for-weak-keys.patch
ecryptfs-add-define-values-for-cipher-codes-from-rfc2440-openpgp.patch
ecryptfs-convert-bits-to-bytes.patch
ecryptfs-more-elegant-aes-key-size-manipulation.patch
ecryptfs-more-intelligent-use-of-tfm-objects.patch
ecryptfs-remove-debugging-cruft.patch
ecryptfs-get_sb_dev-fix.patch
ecryptfs-validate-minimum-header-extent-size.patch
ecryptfs-validate-body-size.patch
ecryptfs-validate-packet-length-prior-to-parsing-add-comments.patch
ecryptfs-use-the-passed-in-max-value-as-the-upper-bound.patch
ecryptfs-change-the-maximum-size-check-when-writing-header.patch
ecryptfs-print-the-actual-option-that-is-problematic.patch
ecryptfs-add-a-maintainers-entry.patch
ecryptfs-partial-signed-integer-to-size_t-conversion-updated-ii.patch
ecryptfs-graceful-handling-of-mount-error.patch
inode-diet-move-i_pipe-into-a-union-ecryptfs.patch
inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-ecryptfs.patch
streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch
ecryptfs-fix-printk-format-warnings.patch
ecryptfs-associate-vfsmount-with-dentry-rather-than-superblock.patch
ecryptfs-mntput-lower-mount-on-umount_begin.patch
vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers-ecryptfs.patch
make-kmem_cache_destroy-return-void-ecryptfs.patch
ecryptfs-inode-numbering-fixes.patch
ecryptfs-versioning-fixes.patch
ecryptfs-versioning-fixes-tidy.patch

 Will fold into a single patch and will then merge.

proc-sysctl-add-_proc_do_string-helper.patch
make-kernel-sysctlc_proc_do_string-static.patch
namespaces-add-nsproxy.patch
namespaces-add-nsproxy-move-init_nsproxy-into-kernel-nsproxyc.patch
namespaces-incorporate-fs-namespace-into-nsproxy.patch
namespaces-incorporate-fs-namespace-into-nsproxy-whitespace.patch
namespaces-utsname-introduce-temporary-helpers.patch
namespaces-utsname-switch-to-using-uts-namespaces.patch
namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit.patch
namespaces-utsname-use-init_utsname-when-appropriate-klibc-bit.patch
namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-2.patch
namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-sparc.patch
namespaces-utsname-use-init_utsname-when-appropriate.patch
namespaces-utsname-implement-utsname-namespaces.patch
namespaces-utsname-sysctl-hack.patch
namespaces-utsname-remove-system_utsname.patch
namespaces-utsname-implement-clone_newuts-flag.patch
namespaces-utsname-implement-clone_newuts-flag-fix.patch
uts-copy-nsproxy-only-when-needed.patch

 Will merge.

 This is prep work for namespace virtualisation.  This doesn't really make
 sense on its own, so there's an act of faith here - it assumes that Linux
 will eventually have full-on virtualisation of the various namespaces with
 sufficient coverage to actually be useful to userspace.

 Normally I'd just buffer all the functionality into -mm until it's ready to
 go and is actually useful to userspace.  But for this work that would mean
 just too many patches held for too long.  So I'll start moving little pieces
 like this into mainline.

ipc-namespace-core.patch
ipc-namespace-utils.patch
ipc-namespace-msg.patch
ipc-namespace-sem.patch
ipc-namespace-shm.patch
ipc-namespace-sysctls.patch
ipc-namespace-fix.patch

 Will fold into a single patch and shall then merge.

ipc-replace-kmalloc-and-memset-in-get_undo_list-with-kzalloc.patch

 Will merge.

introduce-kernel_execve.patch
rename-the-provided-execve-functions-to-kernel_execve.patch
rename-the-provided-execve-functions-to-kernel_execve-fixes.patch
rename-the-provided-execve-functions-to-kernel_execve-headers-fix.patch
provide-kernel_execve-on-all-architectures.patch
provide-kernel_execve-on-all-architectures-fix.patch
provide-kernel_execve-on-all-architectures-mips-fix.patch
provide-kernel_execve-on-all-architectures-fix-2.patch
provide-kernel_execve-on-all-architectures-fix-3.patch
provide-kernel_execve-on-all-architectures-m68knommu-fix.patch
remove-the-use-of-_syscallx-macros-in-uml.patch
sh64-remove-the-use-of-kernel-syscalls.patch
remove-remaining-errno-and-__kernel_syscalls__-references.patch
avr32-implement-kernel_execve.patch

 Will merge.

proc-make-the-generation-of-the-self-symlink-table-driven.patch
proc-factor-out-an-instantiate-method-from-every-lookup-method.patch
proc-remove-the-hard-coded-inode-numbers.patch
proc-merge-proc_tid_attr-and-proc_tgid_attr.patch
proc-use-pid_task-instead-of-open-coding-it.patch
proc-convert-task_sig-to-use-lock_task_sighand.patch
proc-convert-do_task_stat-to-use-lock_task_sighand.patch
proc-drop-tasklist-lock-in-task_state.patch
proc-properly-compute-tgid_offset.patch
proc-remove-trailing-blank-entry-from-pid_entry-arrays.patch
proc-remove-the-useless-smp-safe-comments-from-proc.patch
proc-comment-what-proc_fill_cache-does.patch
introduce-get_task_pid-to-fix-unsafe-get_pid.patch

 /proc changes.  Will merge.

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
readahead-state-based-method-aging-accounting-apply-type-enum-zone_type-readahead.patch
readahead-state-based-method-routines.patch
readahead-state-based-method.patch
readahead-context-based-method.patch
readahead-initial-method-guiding-sizes.patch
readahead-initial-method-thrashing-guard-size.patch
readahead-initial-method-expected-read-size.patch
readahead-initial-method-user-recommended-size.patch
readahead-initial-method.patch
readahead-backward-prefetching-method.patch
readahead-seeking-reads-method.patch
readahead-thrashing-recovery-method.patch
readahead-call-scheme.patch
readahead-call-scheme-fix.patch
readahead-laptop-mode.patch
readahead-loop-case.patch
readahead-nfsd-case.patch
readahead-turn-on-by-default.patch
readahead-debug-radix-tree-new-functions.patch
readahead-debug-traces-showing-accessed-file-names.patch
readahead-debug-traces-showing-read-patterns.patch
readahead-remove-size-limit-on-read_ahead_kb.patch
readahead-backward-prefetching-method-fix.patch
readahead-remove-the-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch

 The readahead code is complex, I'm unconvinced that it has a lot of benefit
 and Wu has gone quiet.  Will drop.

reiser4-export-handle_ra_miss.patch
reiser4-sb_sync_inodes.patch
reiser4-export-remove_from_page_cache.patch
reiser4-export-radix_tree_preload.patch
reiser4-export-find_get_pages.patch
make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
reiser4.patch
make-kmem_cache_destroy-return-void-reiser4.patch
reiser4-hardirq-include-fix.patch
reiser4-fix-trivial-tyops-which-were-hard-to-hit.patch
reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch
reiser4-bug-fixes.patch
reiser4-write-via-do_sync_write.patch
reiser4-fix-gcc-ws-compains.patch
fs-reiser4-possible-cleanups.patch
reiser4-get_sb_dev-fix.patch
reiser4-vs-zoned-allocator.patch
inode_diet-replace-inodeugeneric_ip-with-inodei_private-reiser4.patch
inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-reiser4.patch
reiser4-vs-streamline-generic_file_-interfaces-and-filemap.patch
reiser4-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch
reiser4-rename-generic_sounding_globalspatch.patch
reiser4-rename-generic_sounding_globalspatch-fix.patch
reiser4-decribe-new-atom-locking-and-nested-atom-locks-to-lock-validator.patch
reiser4-use-generic-file-read.patch
reiser4-simplify-reading-of-partially-converted-files.patch
reiser4-use-page_offset.patch
reiser4-use-reiser4_gfp_mask_get-in-reiser4-inode-allocation.patch
reiser4-re-add-page_count-check-to-reiser4_releasepage.patch
reiser4-restore-fibmap-ioctl-support-for-packed-files.patch
reiser4-possible-cleanups-2.patch

 reiser4.  I was planning on merging this, but the batch_write/writev problem
 might wreck things, and I don't think the patches arising from my recent
 partial review have come through yet.  So it's looking more like 2.6.20.

ide-claim-extra-dma-ports-regardless-of-channel.patch
ide-always-release-dma-engine.patch
ide-error-handling-fixes.patch
ide-hpt3xxn-clocking-fixes.patch
ide-fix-hpt37x-timing-tables.patch
ide-optimize-hpt37x-timing-tables.patch
ide-fix-hpt3xx-hotswap-support.patch
ide-fix-the-case-of-multiple-hpt3xx-chips-present.patch
ide-hpt3xx-fix-pci-clock-detection.patch
ide-hpt3xx-fix-pci-clock-detection-fix-2.patch
piix-fix-82371mx-enablebits.patch
piix-remove-check-for-broken-mw-dma-mode-0.patch
piix-slc90e66-pio-mode-fallback-fix.patch
make-number-of-ide-interfaces-configurable.patch
ide_dma_speed-fixes.patch
hpt3xx-rework-rate-filtering.patch
hpt3xx-rework-rate-filtering-tidy.patch
hpt3xx-print-the-real-chip-name-at-startup.patch
hpt3xx-switch-to-using-pci_get_slot.patch
hpt3xx-cache-channels-mcr-address.patch
hpt3x7-merge-speedproc-handlers.patch
hpt370-clean-up-dma-timeout-handling.patch
enable-cdrom-dma-access-with-pdc20265_old.patch
ide-fix-revision-comparison-in-ide_in_drive_list.patch
ide-backport-piix-fixes-from-libata-into-the-legacy-driver.patch

 Various legacy IDE things from Sergei.  These have been in -mm for some
 time.  Last time around Alan's comments were rather waffly so I held off. 
 I'll be looking to merge pretty much all of this into 2.6.19, subject to
 another round of reviewing.

hpt3xx-init-code-rewrite.patch
move-ide-to-unmaintained-drop-reference-to-old-git-tree.patch
ide-core-must_check-fixes.patch
drivers-ide-cleanups.patch
ide-remove-dma_base2-field-from-ide_hwif_t.patch
# ide-reprogram-disk-pio-timings-on-resume.patch: Sergei Shtylyov <sshtylyov@ru.mvista.com> has issues
ide-reprogram-disk-pio-timings-on-resume.patch
pcmcia-add-few-ids-into-ide-cs.patch
config_pm=n-slim-drivers-ide-pci-sc1200c.patch
ide-fix-crash-on-repeated-reset.patch
ide-fix-crash-on-repeated-reset-tidy.patch
allow-ide_generic_all-to-be-used-modular-and-built-in.patch

 More legacy IDE work.  Will merge.

au1100fb-add-option-to-enable-disable-the-cursor.patch
intelfb-documentation-update.patch
rivafb-use-constants-instead-of-magic-values.patch
vfb-document-option-to-enable-the-driver.patch
fbdev-add-generic-ddc-read-functionality.patch
nvidiafb-use-generic-ddc-reading.patch
rivafb-use-generic-ddc-reading.patch
i810fb-use-generic-ddc-reading.patch
savagefb-use-generic-ddc-reading.patch
savagefb-use-generic-ddc-reading-fix.patch
radeonfb-use-generic-ddc-reading.patch
fbcon-use-persistent-allocation-for-cursor-blinking.patch
fbcon-remove-cursor-timer-if-unused.patch
vt-honor-the-return-value-of-device_create_file.patch
fbdev-honor-the-return-value-of-device_create_file.patch
fbcon-honor-the-return-value-of-device_create_file.patch
atyfb-honor-the-return-value-of-pci_register_driver.patch
matroxfb-honor-the-return-value-of-pci_register_driver.patch
nvidiafb-honor-the-return-value-of-pci_enable_device.patch
i810fb-honor-the-return-value-of-pci_enable_device.patch
drivers-video-sis-init301h-removal-of-old.patch
drivers-video-sis-initextlfbc-removal-of.patch
drivers-video-sis-inith-removal-of-old-code.patch
drivers-video-sis-osdefh-removal-of-old-code.patch
drivers-video-sis-sis_accelc-removal-of-old.patch
drivers-video-sis-sis_accelh-removal-of-old.patch
drivers-video-sis-sis_mainc-removal-of-old.patch
drivers-video-sis-sis_mainc-removal-of-old-2.patch
drivers-video-sis-vgatypesh-removal-of-old.patch
drivers-video-sis-sis_mainh-removal-of-old.patch
atyfb-possible-cleanups.patch
mbxfb-fix-a-chip-bug-resulting-in-wrong-pixclock.patch
mbxfb-fix-framebuffer-size-smaller-than-requested.patch
fbcon-make-3-functions-static.patch
vt-proper-prototypes-for-some-console-functions.patch
sstfb-clean-ups.patch

 fbdev.  Will merge.

dm-support-ioctls-on-mapped-devices.patch
dm-linear-support-ioctls.patch
dm-mpath-support-ioctls.patch
dm-export-blkdev_driver_ioctl.patch
dm-support-ioctls-on-mapped-devices-fix-with-fake-file.patch
dm-fix-alloc_dev-error-path.patch
dm-snapshot-fix-invalidation-enomem.patch
dm-snapshot-allow-zero-chunk_size.patch
dm-snapshot-fix-metadata-error-handling.patch
dm-snapshot-make-read-and-write-exception-functions-void.patch
dm-snapshot-fix-metadata-writing-when-suspending.patch
dm-snapshot-tidy-snapshot_map.patch
dm-snapshot-tidy-pending_complete.patch
dm-snapshot-add-workqueue.patch
dm-snapshot-tidy-pe-ref-counting.patch
dm-snapshot-fix-freeing-pending-exception.patch
dm-mirror-remove-trailing-space-from-table.patch
dm-mpath-tidy-ctr.patch
dm-mpath-use-kzalloc.patch
dm-add-uevent-change-event-on-resume.patch
dm-add-debug-macro.patch
dm-table-add-target-preresume.patch
dm-crypt-add-key-msg.patch
dm-crypt-restructure-for-workqueue-change.patch
dm-crypt-restructure-write-processing.patch
dm-crypt-move-io-to-workqueue.patch
dm-crypt-use-private-biosets.patch
dm-use-private-biosets.patch
dm-extract-device-limit-setting.patch
dm-table-add-target-flush.patch

 Device mapper.  Will merge.

md-the-scheduled-removal-of-the-start_array-ioctl-for-md.patch
md-fix-a-comment-that-is-wrong-in-raid5h.patch
md-factor-out-part-of-raid10d-into-a-separate-function.patch
md-replace-magic-numbers-in-sb_dirty-with-well-defined-bit-flags.patch
md-remove-the-working_disks-and-failed_disks-from-raid5-state-data.patch
md-remove-working_disks-from-raid10-state.patch
md-new-sysfs-interface-for-setting-bits-in-the-write-intent-bitmap.patch
md-remove-unnecessary-variable-x-in-stripe_to_pdidx.patch
md-factor-out-part-of-raid1d-into-a-separate-function.patch
md-remove-working_disks-from-raid1-state-data.patch
md-improve-locking-around-error-handling.patch
md-define-backing_dev_infocongested_fn-for-raid0-and-linear.patch
md-define-congested_fn-for-raid1-raid10-and-multipath.patch
md-add-a-congested_fn-function-for-raid5-6.patch
md-make-messages-about-resync-recovery-etc-more-specific.patch

 RAID.  Will merge.

md-dm-reduce-stack-usage-with-stacked-block-devices.patch

 Will hold in -mm.  But we should do something about DM's stack consumption.

statistics-infrastructure-prerequisite-list.patch
statistics-infrastructure-prerequisite-parser.patch
statistics-infrastructure-prerequisite-timestamp.patch
statistics-infrastructure-prerequisite-timestamp-fix.patch
statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
statistics-infrastructure-documentation.patch
statistics-infrastructure.patch
statistics-infrastructure-update-9.patch
statistics-use-the-enhanced-percpu-interface.patch
statistics-replace-inode-ugeneric_ip-with-i_private.patch
statistics-infrastructure-exploitation-zfcp.patch
statistics-infrastructure-exploitation-zfcp-sched_clock-fix.patch
zfcp-gather-hba-specific-latencies-in-statistics.patch

 Waffle.  Not sure.  It seems like nice code but is, perhaps, overly complete.

genirq-msi-restore-__do_irq-compat-logic-temporarily.patch
genirq-convert-the-x86_64-architecture-to-irq-chips.patch
genirq-convert-the-i386-architecture-to-irq-chips.patch
genirq-irq-convert-the-move_irq-flag-from-a-32bit-word-to-a-single-bit.patch
genirq-irq-add-moved_masked_irq.patch
genirq-x86_64-irq-reenable-migrating-irqs-to-other-cpus.patch
genirq-msi-simplify-msi-enable-and-disable.patch
genirq-msi-make-the-msi-boolean-tests-return-either-0-or-1.patch
genirq-msi-implement-helper-functions-read_msi_msg-and-write_msi_msg.patch
genirq-msi-refactor-the-msi_ops.patch
genirq-msi-simplify-the-msi-irq-limit-policy.patch
genirq-irq-add-a-dynamic-irq-creation-api.patch
genirq-ia64-irq-dynamic-irq-support.patch
genirq-i386-irq-dynamic-irq-support.patch
genirq-x86_64-irq-dynamic-irq-support.patch
genirq-msi-make-the-msi-code-irq-based-and-not-vector-based.patch
genirq-x86_64-irq-move-msi-message-composition-into-io_apicc.patch
genirq-i386-irq-move-msi-message-composition-into-io_apicc.patch
genirq-msi-only-build-msi-apicc-on-ia64.patch
genirq-msi-only-build-msi-apicc-on-ia64-fix.patch
genirq-x86_64-irq-remove-the-msi-assumption-that-irq-==-vector.patch
genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector.patch
genirq-irq-remove-msi-hacks.patch
genirq-irq-generalize-the-check-for-hardirq_bits.patch
genirq-x86_64-irq-make-the-external-irq-handlers-report-their-vector-not-the-irq-number.patch
genirq-x86_64-irq-make-vector_irq-per-cpu.patch
genirq-x86_64-irq-make-vector_irq-per-cpu-fix.patch
genirq-x86_64-irq-make-vector_irq-per-cpu-warning-fix.patch
genirq-x86_64-irq-kill-gsi_irq_sharing.patch
genirq-x86_64-irq-kill-irq-compression.patch

 genirq changes.  We still need some MSI fixes against this.  That's in
 progress.   Will merge.

add-hypertransport-capability-defines.patch
add-hypertransport-capability-defines-fix.patch
initial-generic-hypertransport-interrupt-support.patch
initial-generic-hypertransport-interrupt-support-Kconfig-fix.patch

 Will merge.

srcu-3-rcu-variant-permitting-read-side-blocking.patch
srcu-3-rcu-variant-permitting-read-side-blocking-fix.patch
srcu-3-rcu-variant-permitting-read-side-blocking-srcu-add-lock-annotations.patch
srcu-3-rcu-variant-permitting-read-side-blocking-comments.patch
srcu-3-add-srcu-operations-to-rcutorture.patch
srcu-3-add-srcu-operations-to-rcutorture-fix.patch
add-srcu-based-notifier-chains.patch
add-srcu-based-notifier-chains-cleanup.patch
srcu-report-out-of-memory-errors.patch
srcu-report-out-of-memory-errors-fixlet.patch
cpufreq-make-the-transition_notifier-chain-use-srcu.patch
rcu-add-module_author-to-rcutorture-module.patch
rcu-fix-incorrect-description-of-default-for-rcutorture.patch
rcu-mention-rcu_bh-in-description-of-rcutortures.patch
rcu-avoid-kthread_stop-on-invalid-pointer-if-rcutorture.patch
rcu-fix-sign-bug-making-rcu_random-always-return-the-same.patch
rcu-add-fake-writers-to-rcutorture.patch
rcu-add-fake-writers-to-rcutorture-tidy.patch
rcu-refactor-srcu_torture_deferred_free-to-work-for.patch
rcu-add-rcu_sync-torture-type-to-rcutorture.patch
rcu-add-rcu_bh_sync-torture-type-to-rcutorture.patch
rcu-add-sched-torture-type-to-rcutorture.patch
rcu-simplify-improve-batch-tuning.patch
rcu-credits-and-maintainers.patch

 Will merge.

the-scheduled-removal-of-some-oss-drivers.patch
the-scheduled-removal-of-some-oss-drivers-fix.patch
the-scheduled-removal-of-some-oss-drivers-fix-fix.patch
kill-sound-oss-_symsc.patch

 Will merge.


kill-include-linux-configh.patch
pci_module_init-convertion-in-ata_genericc.patch
pci_module_init-convertion-in-ata_genericc-fix.patch
pci_module_init-convertion-in-amso1100-driver.patch
pci_module_init-convertion-for-k8_edacc.patch
pci_module_init-convertion-in-the-legacy-megaraid-driver.patch
pci_module_init-convertion-in-olympicc.patch
pci_module_init-conversion-for-pata_pdc2027x.patch
pci_module_init-convertion-in-tmscsimc.patch
mark-pci_module_init-deprecated.patch
pr_debug-aio-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
pr_debug-configfs-use-size_t-length-modifier-in-pr_debug-format-argument.patch
pr_debug-sysfs-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
pr_debug-umem-repair-nonexistant-bh-pr_debug-reference.patch
pr_debug-tipar-repair-nonexistant-pr_debug-argument-use.patch
pr_debug-dell_rbu-fix-pr_debug-argument-warnings.patch
pr_debug-ifb-replace-missing-comma-to-separate-pr_debug-arguments.patch
pr_debug-trident-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
pr_debug-check-pr_debug-arguments-arm-fix.patch
isdn-debug-build-fix.patch
isdn-more-pr_debug-fixes.patch
pr_debug-check-pr_debug-arguments.patch

 Will merge.

mprotect-patch-for-use-by-slim.patch
integrity-service-api-and-dummy-provider.patch
integrity-service-api-and-dummy-provider-compilation-warning-fix.patch
slim-main-patch.patch
slim-main-patch-socket_post_create-hook-return-code.patch
slim-secfs-patch.patch
slim-make-and-config-stuff.patch
slim-debug-output.patch
slim-fix-security-issue-with-the-task_post_setuid-hook.patch
slim-secfs-inode-i_private-build-fix.patch
slim-documentation.patch

 SLIM is way outside my area of knowledge.  I'd like to see more feedback
 from the other security developers and preferably some statement of interest
 from distros.

documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch
ioctl-messtxt-xfs-typos.patch

 Will retain in -mm.  (What do we need to do to finish this?)

list_del-debug.patch
make-sure-nobodys-leaking-resources.patch
journal_add_journal_head-debug.patch
page-owner-tracking-leak-detector.patch
unplug-can-sleep.patch
firestream-warnings.patch
#periodically-scan-redzone-entries-and-slab-control-structures.patch
releasing-resources-with-children.patch
nr_blockdev_pages-in_interrupt-warning.patch
detect-atomic-counter-underflows.patch
device-suspend-debug.patch
slab-cache-shrinker-statistics.patch
mm-debug-dump-pageframes-on-bad_page.patch
debug-shared-irqs.patch
debug-shared-irqs-kconfig-fix.patch
make-frame_pointer-default=y.patch
i386-enable-4k-stacks-by-default.patch
pidhash-temporary-debug-checks.patch
mutex-subsystem-synchro-test-module.patch
x86-e820-debugging.patch
slab-leaks3-default-y.patch
x86-kmap_atomic-debugging.patch
profile-likely-unlikely-macros.patch
vdso-print-fatal-signals.patch
vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch
restore-rogue-readahead-printk.patch
put_bh-debug.patch
e1000_7033_dump_ring.patch
acpi_format_exception-debug.patch

 This is -mm only debug stuff.  It shall remain in -mm.

jmicron-warning-fix.patch

 Will merge.



