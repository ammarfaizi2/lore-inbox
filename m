Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUDZImE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUDZImE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 04:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUDZImD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 04:42:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:34945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262014AbUDZIkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 04:40:03 -0400
Date: Mon, 26 Apr 2004 01:39:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc2-mm2
Message-Id: <20040426013944.49a105a8.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/

- Largeish reiserfs feature update.  The biggest change is probably the new
  block allocation algorithm.  See the changelog inside
  reiserfs-group-alloc-9.patch for details.

- Added the ia64 CPU hotplug support patch

- More work against the ext3 block allocator.

- Several more framebuffer driver update, some quite substantial.

- Lots of fixes, mostly minor.




Changes since 2.6.6-rc2-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of various external trees

-fix-nfsroot-option-parsing.patch
-aic7xxx-deadlock-fix.patch
-pcmcia-netdev-ordering-fixes.patch
-3ware-update.patch
-jgarzik-warnings.patch
-aic7xxx-unload-fix.patch
-rndis-fix.patch
-ext3-data-leak-fix.patch
-populate-rootfs-later.patch
-remove-amd7saucy_tco.patch
-ehci-oops-fix.patch
-lockfs-vfs-bits.patch
-lockfs-reiserfs-fix.patch
-lockfs-xfs-bits.patch
-lockfs-dm-bits.patch
-lockfs-dm-bits-2.patch
-i4l-compat-ioctls.patch
-selinux-change-context_to_sid-handling-for-no-policy-case.patch
-selinux-add-runtime-disable.patch
-selinux-remove-hardcoded-policy-assumption-from-get_user_sids-logic.patch
-i810_dma-range-check.patch
-fb_ioctl-usercopy-fix.patch
-writeback-livelock-fix.patch
-new-set-of-input-patches-lkkbd-whitespace.patch
-new-set-of-input-patches-lkkbd-simplify-checks.patch
-i386-hugetlb-tlb-correction.patch
-loop_set_fd-sendfile-check-fix.patch

 Merged

-create_singlethread_workqueue-fix.patch

 Folded into create_singlethread_workqueue.patch

-use-workqueue-for-call_usermodehelper-fix.patch

 Folded into use-workqueue-for-call_usermodehelper.patch

+1-1-reiserfs-ignore-prepared-and-locked-buffers.patch

 reiserfs fix

+frame-pointer-based-stack-dumps.patch

 Use the frame pointer to generate nicer stack traces on x86.

 Turns out that enabling framepointers makes basically no difference to code
 size at all.

-compute-creds-race-fix.patch
-compute-creds-race-fix-fix.patch
-compute-creds-race-fix-fix-fix.patch
+credentials-locking-fix.patch

 Re-fix locking around credential checks.

+ext3-journalled-quota-locking-fix.patch

 Fix some ext3 locking

+bigger-quota-hashtable.patch

 Quotas speedup

+per-sb-dquot-dirty-lists.patch

 More quota speedups

+minor-fixes-in-journalled-quota.patch

 Journalled quota fixlets

+ppc64-split-promc-into-pre-reloc-and-post-reloc-functions.patch
+ppc64-rearrage-finish_device_tree-and-its-functions-in-c.patch
+ppc64-rearrage-copy_device_tree-and-its-functions-in-c.patch
+ppc64-rearrage-interpret_funcs-in-c-order.patch
+ppc64-rearrage-rest-of-promc-in-c-order.patch
+ppc64-make-finish_device_tree-use-lmb_alloc-not-klimit.patch
+ppc64-make_room-macro-for-ppc64-promc.patch
+ppc64-fix-promc-to-boot-on-g5-after-make_room-fix.patch
+ppc64-clean-up-prom-functions-in-promc.patch
+ppc64-initrd-cleanup.patch
+ppc64-move-initrd.patch
+ppc64-remove-duplicated-mb-and-comment-from-__cpu_up.patch

 PPC64 update

+acpi-build-fix.patch

 Fix build prob in bk-acpi.patch

+i_shared_lock-fix-1.patch
+i_shared_lock-fix-2.patch
+i_shared_lock-mremap-fix.patch

 Various fixes for the i_shared_sem->i_shared_lock conversion

+hotplug-cpu-sched_balance_exec-fix.patch

 Fix deadlock with CPU hotplug and the CPU scheduler changes

+cond_resched-might-sleep.patch

 Add a debug check

-warn-on-mdelay-in-irq-handlers.patch

 This seems to have done its job.

+aic7xxx-deadlock-fix.patch
+aic7xxx-section-fix.patch

 More adaptec driver fixes.

-numa-api-core-i_shared_sem.patch

 Dropped, not needed any more.

+numa-api-docs-policy_vma-fix.patch
+include-linux-gfph-cleanup-for-numa-api.patch

 NUMA API fixes

-ext3-reservation-regression-fix.patch
-ext3_rsv_mount.patch
-ext3_rsv_dw.patch

 Folded into ext3_rsv_base.patch

+4-autofs4-260-expire-20040405-fix-fix.patch

 Fix the autofs4 update

+new-set-of-input-patches-serio-whitespace.patch
+new-set-of-input-patches-serio-open-close-optional.patch
+psmouse-fix-mouse-hotplugging.patch

 Input driver rework

+bssprot.patch
+bssprot-sparc-fix.patch
+bssprot-cleanup.patch
+bssprot-more-fixes.patch

 Fix vma permissions for ELF PT_LOAD segments

+slab-alignment-fixes.patch

 Slab object alignment changes

+neomagic-driver-update.patch

 Update this fbdev driver

+kernel_ppc8xx_misc.patch

 PPC32 build fixes

+prune_dcache-comment-fix.patch

 Fix buggy comment

+m68k-superfluous-whitespace.patch
+amiga-a2065-ethernet-kern.patch
+m68k-bitops.patch

 68k stuff

+efivars-remove-from-ia64.patch
+efivars-add-to-drivers-firmware.patch
+efivars-remove-x86-references.patch

 EFI driver updates

+s390-9-9-no-timer-interrupts-in-idle.patch

 Tickless mode for S390.

+task_lock-comment-update.patch

 Fix a comment

+dio_bio_reap-retval-fix.patch

 Fix a return value

+crypto_null-autoload.patch

 Fix module loading

+remove-bootsect_helper-and-a-comment-fix-iii.patch

 Remove unneeded code

+fix-config_sysfs=n-compile-warning.patch

 Warning fix

+isofs-default-nls-charset-not-used-fix.patch

 Use CONFIG_NLS_DEFAULT rather than hard-coding it.

+fixes-to-mvme5100-support-in-265.patch

 PPC32 stuff

+fealnx-mac-address-and-other-issues.patch

 Fix this net driver a bit.

+remove-some-unused-variables-in-s2io.patch

 Cleanup for this net driver

+new-version-of-early-cpu-detect.patch
+new-version-of-early-cpu-detect-fix.patch

 Bring back the very-early detection of the x86 CPU type

+slab-order-0-for-vfs-caches.patch

 Prevent slab from ever using higher-order allocations for VFS caches: it's
 deadlocky.

+radeon-garbled-screen-fix.patch

 Radeon fix

+smb_writepage-retval-fix.patch

 ->writepage() return 0 or -errno.  It should _not_ return the
 number-of-bytes-written.  Unless you want it to perform like crap, that is.

+writepage-retval-warning.patch

 Runtime check for filesystem which wish to perform like crap.

+shrink_slab-handle-GFP_NOFS.patch

 Fiddle with slab-vs-pagecache reclaim balancing

+simplify-put_page.patch

 Require that compound pages have a destructor.

+hugepage-fixes.patch
+hugepage-fixes-fix.patch

 Consolidate up a few hugetlbpage helpers

+26-isdn-eicon-driver-remove-call-to-trap-usermode-helper.patch

 ISDN cleanup

+tips-for-s3-resume-on-radeon-cards.patch

 Power management documentation update

+fix-3c59xc-to-allow-3c905c-100bt-fd.patch

 3c59x MII programming fix

+ppc32-fix-head_44xs-copyrights.patch

 PPC32 assembly code copyright corrections

+proc-array-old-gcc-fix.patch

 Work around problems with older gcc's

+use-dos_extended_partition.patch

 Use the provided enums rather than magic constants.

+blkdevh-functions-no-longer-inline.patch

 Make declarations match implementations

+reiserfs-acl-mknod.patch
+reiserfs-xattrs-04.patch
+reiserfs-acl-02.patch
+reiserfs-trusted-02.patch
+reiserfs-selinux-02.patch
+reiserfs-xattr-locking-02.patch
+reiserfs-quota.patch
+reiserfs-permission.patch
+reiserfs-warning.patch
+reiserfs-group-alloc-9.patch
+reiserfs-group-alloc-9-build-fix.patch
+reiserfs-search_reada-5.patch

 reiserfs update

+nfs_writepages-retval-fix.patch

 The nfs_writepages() return value is fishy as well.

+ext3-reservation-ifdef-cleanup-patch.patch
+ext3-reservation-max-window-size-check-patch.patch
+ext3-reservation-file-ioctl-fix.patch
+ext3-lazy-discard-reservation-window-patch.patch
+ext3-discard-reservation-in-last-iput-fix-patch.patch
+ext3-discard-reservation-in-last-iput-fix-patch-fix.patch

 Reservation-based ext3 block allocator updates

+include-asm-ppc-dma-mappingh-dma_unmap_page.patch

 Fix ppc32's dma_unmap_page()

+nfs_writepage-retval-fix.patch

 As is the nfs_writepage() return value.

+problems-with-atkbd_command--atkbd_interrupt-interaction.patch

 AT keyboard fix

+fix-fs-proc-task_nommuc-compile.patch

 NOMMU build fix

+remove-documentation-docbook-parportbooktmpl.patch

 Remove documentation which has an inappropriate license.

+set-module-license-in-mcheck-non-fatalc.patch

 Add a MODULE_LICENSE()

+submittingpatches-diffing-update.patch

 Fix wording in SubmittingPatches

+mptfusion-depends-on-scsi.patch

 Kconfig dependency fix

+fix-null-ptr-dereference-in-pm2fb_probe-2.patch

 Fix an oops

+mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch

 This serial driver doesn't work.  Mark it as broken.

+fix-warning-in-prefetch_range.patch

 Fix a compile warning (I'm suspecting gcc breakage)

+virtual-fbdev-updates.patch
+vesa-fbdev-update.patch
+vesa-fbdev-update-fix.patch

 fbdev updates

+ia64-cpu-hotplug-core_kernel_init.patch
+ia64-cpu-hotplug-init_removal_ia64.patch
+ia64-cpu-hotplug-sysfs_ia64.patch
+ia64-cpu-hotplug-hotcpu_ia64.patch
+ia64-cpu-hotplug-ia64_palinfo.patch
+ia64-cpu-hotplug-cpu_present.patch
+ia64-cpu-hotplug-migrate_irq.patch

 Impement CPU hotplug for ia64

+promc-fix-for-config_blk_dev_initrd=n.patch

 Build fix

+parport-pnp-detection-fix.patch

 Maybe fix recent SuperIO parport breakage.

+scsi_disk_release-warning-fix.patch

 SCSI warning fix

+8139too-suspend-fix.patch

 Fix power management in this net driver 

+sata_sx4-warning-fix.patch
+cifssmb-warning-fix.patch

 Fix a couple of warnings.





All 308 patches


linus.patch

create_singlethread_workqueue.patch
  reate_singlethread_workqueue()
  create_singlethread_workqueue fix

use-workqueue-for-call_usermodehelper.patch
  Use workqueue for call_usermodehelper
  use-workqueue-for-call_usermodehelper fix

1-1-reiserfs-ignore-prepared-and-locked-buffers.patch
  Subject: [PATCH] 1/1 reiserfs: ignore prepared and locked buffers

mc.patch
  Add -mcN to EXTRAVERSION

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

frame-pointer-based-stack-dumps.patch
  x86: stack dumps using frame pointers

credentials-locking-fix.patch
  credentials locking fix

ext3-journalled-quota-locking-fix.patch
  ext3 journalled quota locking fix

bigger-quota-hashtable.patch
  Bigger quota hashtable

per-sb-dquot-dirty-lists.patch
  From: Jan Kara <jack@ucw.cz>
  Subject: [PATCH] Per-sb dquot dirty lists

minor-fixes-in-journalled-quota.patch
  Minor fixes for ext3 journalled quotas

ppc64-split-promc-into-pre-reloc-and-post-reloc-functions.patch
  ppc64: Split prom.c Into pre-reloc and post-reloc Functions

ppc64-rearrage-finish_device_tree-and-its-functions-in-c.patch
  ppc64: Rearrage finish_device_tree() and its functions in C Order

ppc64-rearrage-copy_device_tree-and-its-functions-in-c.patch
  ppc64: Rearrage copy_device_tree() and its functions in C 	Order

ppc64-rearrage-interpret_funcs-in-c-order.patch
  ppc64: Rearrage interpret_funcs in C Order

ppc64-rearrage-rest-of-promc-in-c-order.patch
  ppc64: Rearrage Rest of prom.c in C Order

ppc64-make-finish_device_tree-use-lmb_alloc-not-klimit.patch
  ppc64: Make finish_device_tree use lmb_alloc, not klimit

ppc64-make_room-macro-for-ppc64-promc.patch
  ppc64: make_room macro for ppc64 prom.c

ppc64-fix-promc-to-boot-on-g5-after-make_room-fix.patch
  ppc64: Fix prom.c to boot on G5 after make_room fix

ppc64-clean-up-prom-functions-in-promc.patch
  ppc64: Clean up prom functions in prom.c

ppc64-initrd-cleanup.patch
  ppc64: Initrd Cleanup

ppc64-move-initrd.patch
  ppc64: Move Initrd

acpi-build-fix.patch
  acpi build fix

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

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap

ia64-rmap-build-fix.patch
  ia64 rmap build fix

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear

slab-panic.patch
  slab: consolidate panic code

rmap-9-remove-pte_chains.patch
  rmap 9 remove pte_chains

rmap-10-add-anonmm-rmap.patch
  rmap 10 add anonmm rmap

rmap-11-mremap-moves.patch
  rmap 11 mremap moves

rmap-12-pgtable-remove-rmap.patch
  rmap 12 pgtable remove rmap

rmap-13-include-asm-deletions.patch
  rmap 13 include/asm deletions

i_shared_lock.patch
  Convert i_shared_sem back to a spinlock

i_shared_lock-fix-1.patch
  i_shared_lock fix 1

i_shared_lock-fix-2.patch
  i_shared_lock fix 2

i_shared_lock-mremap-fix.patch
  i_shared_lock mremap fix

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-find-busiest-fix.patch
  sched-find-busiest-fix

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-local-load.patch
  sched: add local load metrics

process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-misc-fixes.patch
  sched: misc fixes

hotplug-cpu-sched_balance_exec-fix.patch
  Hotplug CPU sched_balance_exec Fix

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-domain-setup-lock.patch
  sched: fix setup races

ppc64-sched_domains-fix.patch
  ppc64-sched_domains-fix

sched-domain-setup-lock-ppc64-fix.patch

sched-minor-cleanups.patch
  sched: minor cleanups

sched-inline-removals.patch
  sched: uninlinings

sched-move-cold-task.patch
  sched: move cold task in mysteriouis ways

sched-migrate-shortcut.patch
  sched: add migration shortcut

sched-more-sync-wakeups.patch
  sched: extend sync wakeups

sched-boot-fix.patch
  sched: lock cpu_attach_domain for hotplug

sched-cleanups.patch
  sched: cleanups

sched-damp-passive-balance.patch
  sched: passive balancing damping

sched-cpu-load-cleanup.patch
  sched: cpu load management cleanup

sched-balance-context.patch
  sched: balance-on-clone

sched-less-idle.patch
  sched: reduce idle time

sched-wake_up-speedup.patch
  sched: micro-optimisation for wake_up

ppc64-smt-sched-stuff.patch
  ppc64: SMT scheduler support

schedstats.patch
  sched: scheduler statistics

cond_resched-might-sleep.patch
  cond_resched() might sleep

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz-2.patch
  reduce NMI watchdog call frequency with local APIC.

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

stack-reductions-nfsread.patch
  stack reductions: nfs read

speed-up-sata.patch
  speed up SATA

advansys-fix.patch
  advansys check_region() fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

nfs-direct-warning-fix.patch
  nfs/direct.c warning fix

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

aic7xxx-swsusp-support.patch
  support swsusp for aic7xxx
  aic79xx_osm.c build fix

aic7xxx-section-fix.patch
  aic7...: Fix bad __exit reference

xfs-laptop-mode.patch
  Laptop mode support for XFS

xfs-laptop-mode-syncd-synchronization.patch
  Synchronize XFS sync daemon with laptop mode syncs.

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

cciss-logical-device-queues.patch
  cciss: per logical device queues

numa-api-x86_64.patch
  numa api: -64 support

numa-api-bitmap-fix.patch
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code

numa-api-docs-policy_vma-fix.patch
  numa api: docs and policy_vma() locking fix

include-linux-gfph-cleanup-for-numa-api.patch
  From: Matthew Dobson <colpatch@us.ibm.com>
  Subject: [PATCH] include/linux/gfp.h cleanup for NUMA API

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-core-tweaks.patch
  numa-api-core-tweaks

numa-api-fixes.patch
  Some fixes for NUMA API

numa-api-statistics-2.patch
  Re-add NUMA API statistics

numa-api-core-bitmap_clear-fixes.patch
  numa-api-core bitmap_clear fixes

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy

numa-api-vma-policy-hooks-fix.patch
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support

numa-api-shared-memory-support-tweaks.patch
  numa-api-shared-memory-support-tweaks

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB
  skvpd-build-fix

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

fix-acer-travelmate-360-interrupt-routing.patch
  fix Acer TravelMate 360 interrupt routing

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

sched-in_sched_functions.patch
  sched: in_sched_functions() cleanup

sysfs-d_fsdata-race-fix-2.patch
  kobject/sysfs race fix

0-autofs4-2.6.0-signal-20040405.patch
  autofs: dnotify + autofs may create signal/restart syscall loop

add-omitted-autofs4-super-block-field.patch
  add omitted autofs4 super block field

1-autofs4-2.6.4-cleanup-20040405.patch
  autofs: printk cleanups

2-autofs4-2.6.4-fill_super-20040405.patch

3-autofs4-2.6.0-bkl-20040405.patch
  autofs: locking rework

4-autofs4-2.6.0-expire-20040405.patch
  autofs: expiry refcount fixes

4-autofs4-260-expire-20040405-fix.patch
  4-autofs4-2.6.0-expire-20040405 locking fix

4-autofs4-260-expire-20040405-fix-fix.patch
  autofs expiry fix

5-autofs4-2.6.0-readdir-20040405.patch
  autofs: readdir fixes

umount-after-bad-chdir.patch
  fix umount after bad chdir

autofs4-fix-handling-of-chdir-and-chroot.patch
  autofs4: fix handling of chdir and chroot

6-autofs4-2.6.0-may_umount-20040405.patch
  autofs: add ioctl to query unmountability

7-autofs4-2.6.0-extra-20040405.patch
  autofs: readdir futureproofing

lindent-rwsem.patch
  cleanup lib/rwsem.c lib/rwsem-spinlock.c

de-racify-rwsem-take-2.patch
  de-racify rwsem take 2

as-increase-batch-expiry.patch
  AS: increase batch expiry intervals

consolidate-sys32_readv-and-sys32_writev.patch
  Consolidate sys32_readv and sys32_writev

consolidate-do_execve32.patch
  Consolidate do_execve32

consolidate-sys32_select.patch
  Consolidate sys32_select

consolidate-sys32_nfsservctl.patch
  Consolidate sys32_nfsservctl

intel8x0-resume-fix.patch
  intel8x0 suspend/resume fix

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

radeon-fb-screen-corruption-fix.patch
  radeonfb display corruption fix

es7000-subarch-update-2.patch
  es7000 subarch update

tridentfbc-warning-fix.patch
  video/tridentfb.c warning fix

hgafbc-warning-fix.patch
  video/hgafb.c warning fix

imsttfbc-warning-fix.patch
  video/imsttfb.c. warning fix

dquot-unneeded-test.patch
  dquot: remove unneeded test

fbdev-logo-handling-fix.patch
  fbdev: clean up logo handling

fbdev-redundant-prows-calculation-removal.patch
  fbdev: remove redundant p->vrows calculation

fbdev-remove-redundant-local.patch
  fbdev: remove redundant local

fbdev-access_align-default.patch
  fbdev: set a default access_align value

kbuild-improved-external-module-support.patch
  kbuild: Improved external module support

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

use-less-stack-in-ide_unregister.patch
  use less stack in ide_unregister

string_h-needs-compiler_h.patch
  string.h needs compiler.h

new-set-of-input-patches-synaptics-cleanup.patch
  input: synaptics cleanup

new-set-of-input-patches-synaptics-middle-button-support.patch
  input: synaptics middle button support

new-set-of-input-patches-dont-change-max-proto.patch
  input: dont change max proto

new-set-of-input-patches-atkbd-soften-accusation.patch
  input: atkbd soften accusation

new-set-of-input-patches-atkbd-trailing-whitespace.patch
  input: atkbd trailing whitespace

new-set-of-input-patches-atkbd-use-bitfields.patch
  input: atkbd - use bitfields

new-set-of-input-patches-atkbd-timeout-complaints.patch
  input: atkbd timeout complaints

new-set-of-input-patches-psmouse-rescan-on-hotplug.patch
  input: psmouse rescan on hotplug

new-set-of-input-patches-psmouse-reconnect-after-error.patch
  input: psmouse reconnect after error

new-set-of-input-patches-psmouse-add-protocol_handler.patch
  input: psmouse add protocol_handler

new-set-of-input-patches-psmouse-sliced-commands.patch
  input: psmouse sliced commands

new-set-of-input-patches-atkbd-reconnect-probe.patch
  input: atkbd reconnect probe

new-set-of-input-patches-allow-disabling-psaux.patch
  input: allow disabling psaux

new-set-of-input-patches-serio-whitespace.patch
  input: serio whitespace

new-set-of-input-patches-serio-open-close-optional.patch
  input: serio open/close optional

psmouse-fix-mouse-hotplugging.patch
  psmouse: fix mouse hotplugging

bssprot.patch
  binfmt_elf.c: allow .bss with no access

bssprot-sparc-fix.patch
  bssprot sparc64 fix

bssprot-cleanup.patch
  bssprot cleanup

bssprot-more-fixes.patch
  bssprot: more fixes

slab-alignment-fixes.patch
  slab alignment fixes

neomagic-driver-update.patch
  Neomagic driver update.

kernel_ppc8xx_misc.patch
  ppc32: ppc8xx build fixes

prune_dcache-comment-fix.patch
  prune_dcache comment fix

m68k-superfluous-whitespace.patch
  M68k superfluous whitespace

amiga-a2065-ethernet-kern.patch
  m68k: Amiga A2065 Ethernet KERN_*

m68k-bitops.patch
  m68k bitops

efivars-remove-from-ia64.patch
  efivars: remove from arch/ia64

efivars-add-to-drivers-firmware.patch
  efivars: add to drivers/firmware

efivars-remove-x86-references.patch
  efivars: remove x86 references

s390-9-9-no-timer-interrupts-in-idle.patch
  s390: no timer interrupts in idle.

task_lock-comment-update.patch
  task_lock() comment update

dio_bio_reap-retval-fix.patch
  dio_bio_reap() return value fix

crypto_null-autoload.patch
  crypto_null autoload

remove-bootsect_helper-and-a-comment-fix-iii.patch
  Remove bootsect_helper and a comment fix

fix-config_sysfs=n-compile-warning.patch
  fix CONFIG_SYSFS=n compile warning

isofs-default-nls-charset-not-used-fix.patch
  isofs "default NLS charset not used" fix

fixes-to-mvme5100-support-in-265.patch
  Fixes to MVME5100 support

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

remove-some-unused-variables-in-s2io.patch
  remove some unused variables in s2io

new-version-of-early-cpu-detect.patch
  New version of early CPU detect

new-version-of-early-cpu-detect-fix.patch
  new-version-of-early-cpu-detect-fix

slab-order-0-for-vfs-caches.patch
  slab: use order 0 for vfs caches

radeon-garbled-screen-fix.patch
  radeonfb: fix garbled screen

smb_writepage-retval-fix.patch
  smb_writepage retval fix

writepage-retval-warning.patch
  writepage-retval-warning

shrink_slab-handle-GFP_NOFS.patch
  shrink_slab: improved handling of GFP_NOFS allocations

simplify-put_page.patch
  simplify put_page()

hugepage-fixes.patch
  hugepage fixes

hugepage-fixes-fix.patch
  hugepage-fixes-fix

26-isdn-eicon-driver-remove-call-to-trap-usermode-helper.patch
  ISDN Eicon driver: remove call to trap usermode helper

tips-for-s3-resume-on-radeon-cards.patch
  Tips for S3 resume on radeon cards

fix-3c59xc-to-allow-3c905c-100bt-fd.patch
  fix 3c59x.c to allow 3c905c 100bT-FD

ppc32-fix-head_44xs-copyrights.patch
  ppc32: fix head_44x.S copyrights

proc-array-old-gcc-fix.patch
  fs/proc/array.c: workaround for gcc-2.96

use-dos_extended_partition.patch
  partitioning cleanup: use DOS_EXTENDED_PARTITION

blkdevh-functions-no-longer-inline.patch
  blkdev.h: functions no longer inline

reiserfs-acl-mknod.patch
  reiserfs: acl device node initialization

reiserfs-xattrs-04.patch
  reiserfs: xattr support

reiserfs-acl-02.patch
  reiserfs: ACL support

reiserfs-trusted-02.patch
  reiserfs: support trusted xattrs

reiserfs-selinux-02.patch
  reiserfs: selinux support

reiserfs-xattr-locking-02.patch
  reiserfs: xattr locking fixes

reiserfs-quota.patch
  reiserfs: quota support

reiserfs-permission.patch
  reiserfs: xattr permission fix

reiserfs-warning.patch
  reiserfs: add device info to diagnostic messages

reiserfs-group-alloc-9.patch
  reiserfs: block allocator optimizations

reiserfs-group-alloc-9-build-fix.patch
  reiserfs-group-alloc-9 build fix

reiserfs-search_reada-5.patch
  reiserfs: btree readahead

nfs_writepages-retval-fix.patch
  nfw_writepages() return value fix

ext3-reservation-ifdef-cleanup-patch.patch
  ext3 reservation ifdef cleanup patch

ext3-reservation-max-window-size-check-patch.patch
  ext3 reservation max window size check patch

ext3-reservation-file-ioctl-fix.patch
  ext3 reservation file ioctl fix

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch

ext3-discard-reservation-in-last-iput-fix-patch.patch
  ext3 discard reservation in last iput fix patch

ext3-discard-reservation-in-last-iput-fix-patch-fix.patch
  Fix lazy reservation discard

include-asm-ppc-dma-mappingh-dma_unmap_page.patch
  ppc32: dma_unmap_page() fix

nfs_writepage-retval-fix.patch
  nfs_write-apge-retval-fix

problems-with-atkbd_command--atkbd_interrupt-interaction.patch
  Problems with atkbd_command & atkbd_interrupt interaction

fix-fs-proc-task_nommuc-compile.patch
  fix fs/proc/task_nommu.c compile

remove-documentation-docbook-parportbooktmpl.patch
  remove Documentation/DocBook/parportbook.tmpl

set-module-license-in-mcheck-non-fatalc.patch
  Set module license in mcheck/non-fatal.c

submittingpatches-diffing-update.patch
  SubmittingPatches diffing update.

mptfusion-depends-on-scsi.patch
  mptfusion depends on scsi

fix-null-ptr-dereference-in-pm2fb_probe-2.patch
  Fix NULL-ptr dereference in pm2fb_probe

mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch
  Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken

fix-warning-in-prefetch_range.patch
  Fix warning in prefetch_range

virtual-fbdev-updates.patch
  Virtual fbdev updates

vesa-fbdev-update.patch
  Vesa Fbdev update

vesa-fbdev-update-fix.patch
  Vesa Fbdev update fix

ia64-cpu-hotplug-core_kernel_init.patch
  IA64 hotplug: core kernel initialisation

ia64-cpu-hotplug-init_removal_ia64.patch
  IA64 hotplug: init section changes

ia64-cpu-hotplug-sysfs_ia64.patch
  IA64 hotplug: add sysfs entries

ia64-cpu-hotplug-hotcpu_ia64.patch
  IA64 hotplug: core ia64 hotplug CPU support

ia64-cpu-hotplug-ia64_palinfo.patch
  IA64 hotplug: create /proc entries in hotplug callbacks

ia64-cpu-hotplug-cpu_present.patch
  IA64 hotplug: add cpu_present iterators

ia64-cpu-hotplug-migrate_irq.patch
  IA64 hotplug: IRQ migration for hotplug

promc-fix-for-config_blk_dev_initrd=n.patch
  prom.c fix for CONFIG_BLK_DEV_INITRD=n

ppc64-remove-duplicated-mb-and-comment-from-__cpu_up.patch
  ppc64: remove duplicated mb() and comment from __cpu_up

parport-pnp-detection-fix.patch
  parport pnp detection fix

scsi_disk_release-warning-fix.patch
  scsi_disk_release() warning fix

8139too-suspend-fix.patch
  8139too not running s3 suspend/resume pci fix

sata_sx4-warning-fix.patch
  sata_sx4.c warning fix

cifssmb-warning-fix.patch
  cifssmb.c warning fix



