Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUGAS5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUGAS5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbUGAS5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:57:24 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:26401 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266222AbUGASzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:55:08 -0400
Subject: Re: 2.6.7-mm5
From: Redeeman <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040630172656.6949ec60.akpm@osdl.org>
References: <20040630172656.6949ec60.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 01 Jul 2004 20:55:06 +0200
Message-Id: <1088708106.15328.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there are severe net problems :(

everything else is running damn good

On Wed, 2004-06-30 at 17:26 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/
> 
> - bk-acpi.patch is back.  If devices mysteriously fail to function please
>   try reverting it with
> 
>        patch -p1 -R -i ~/bk-acpi.patch
> 
> - last call for reviewers of the perfctr patches.
> 
> - s390, ppc64, ppc32 and IDE updates.
> 
> 
> 
> 
> Changes since 2.6.7-mm4:
> 
>  linus.patch
>  bk-acpi.patch
>  bk-agpgart.patch
>  bk-alsa.patch
>  bk-cpufreq.patch
>  bk-driver-core.patch
>  bk-ieee1394.patch
>  bk-input.patch
>  bk-netdev.patch
>  bk-ntfs.patch
>  bk-pnp.patch
>  bk-scsi.patch
>  bk-usb.patch
> 
>  External trees
> 
> -x86_64-setup-section-alignment-fix.patch
> -pwc-uncompress-build-fix.patch
> -ppc64-fault-deadlock-fix-2.patch
> -binary-translator-fs-passing.patch
> -translate-japanese-comments-in-arch-v850.patch
> -kill-mm_structused_hugetlb.patch
> -provide-console_device.patch
> -provide-console_device-comment.patch
> -provide-console_suspend-and-console_resume.patch
> -v267-indydogc-patch-20040627.patch
> -fbcon-display-artifacts-fix.patch
> -fix-to-microcode-driver-for-the-old-cpus.patch
> -credits-update.patch
> -pcdp-console-detection-support-fixes.patch
> -ppc64-vio-infrastructure-modifications.patch
> -ppc64-iseries_veth-integration.patch
> -ppc64-viodasd-integration.patch
> -ppc64-viocd-integration.patch
> -ppc64-viotape-integration.patch
> -hpet-fixes-3.patch
> -sh64-merge.patch
> -cirrusfb-minor-fixes.patch
> -signed-bug-in-drivers-video-console-fbconc-con2fb_map.patch
> -edd-store-mbr_signature-on-first-16-int13-devices.patch
> -combined-patch-for-remaining-trivial-sparse.patch
> -dma_get_required_mask.patch
> -add-m68k-support-to-checkstack.patch
> -small-fixes-to-checkstack.patch
> -add-linux-compilerh-to-linux-fdh.patch
> -fix-page-count-discrepancy-for-zero-page.patch
> -alpha-build-fix.patch
> 
>  Merged
> 
> +ppc64-remove-rtas-arguments-from-paca.patch
> +ppc64-paca-cleanup.patch
> +ppc64-janitor-log_rtas_error-call-arguments.patch
> +ppc64-janitor-rtas_call-return-variables.patch
> 
>  ppc64 udpates
> 
> +ppc32-ocp-for-mp10x.patch
> +ppc32-ppc44x-updates.patch
> +ppc32-ppc4xx-preempt-fixes.patch
> 
>  ppc32 updates
> 
> +pefrctr-x86_tests-build-fix.patch
> +perfctr-update-4-6-ppc32-cleanups.patch
> +perfctr-update-6-6-misc-minor-cleanups.patch
> +perfctr-update-3-6-__user-annotations.patch
> +perfctr-update-2-6-kconfig-related-updates.patch
> +perfctr-update-5-6-reduce-stack-usage.patch
> 
>  perfctr updates
> 
> -r8169_napi-help-text.patch
> 
>  This broke
> 
> -bridge-fix-bpdu-message_age.patch
> 
>  Sort-of merged
> 
> -reduce-tlb-flushing-during-process-migration-2-fix.patch
> -tlb_migrate_flush-docs.patch
> 
>  Folded into  reduce-tlb-flushing-during-process-migration-2.patch
> 
> -sched-cleanup-init_idle.patch
> -sched-cleanup-improve-sched-fork-apis.patch
> -sched-misc-changes.patch
> -sched-disable-balance-on-clone-by-default.patch
> -sched-exit-race.patch
> +sched-clean-init-idle.patch
> +sched-clean-fork.patch
> +sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
> +sched-misc-cleanups-2.patch
> +sched-unlikely-rt_task.patch
> +sched-misc.patch
> +sched-misc-fix-rt.patch
> +sched-no-balance-clone.patch
> +sched-remove-balance-clone.patch
> 
>  New set of CPU scheduler updates
> 
> -input-psmouse-state-locking.patch
> -input-serio-connect-disconnect-mandatory.patch
> -input-serio-renames-1.patch
> -input-serio-renames-2.patch
> -input-serio-dynamic-allocation.patch
> -input-serio-avoid-recursion.patch
> -input-serio-sysfs-intergration.patch
> -input-serio-rebind.patch
> -input-9-19-serio-manual-bind.patch
> -input-serio_raw-driver.patch
> -input-add-platform_device_register_simple.patch
> -input-convert-i8042-into-a-platform-device.patch
> -input-more-platform-device-conversions.patch
> -input-bind-serio-ports-and-their-parents.patch
> -input-synaptics-passthrough-handling.patch
> -input-add-bus-default-driver-attributes.patch
> -input-serio-use-bus-default-driver-device-attributes.patch
> -input-add-driver_find.patch
> -input-serio-use-driver_find.patch
> 
>  These were partly-merged into bk-input, so I dropped everything.
> 
> +pcmcia-net-device-unplugging-ordering-fix.patch
> 
>  Fix pcmcia netdev takedown ordering
> 
> +remove-upf_resources.patch
> 
>  PCMCIA cleanup/fix
> 
> +define-max-kernel-symbol-lenght-and-clean-up.patch
> +fix-sparse-warnings-in-kernel-power.patch
> +fix-sparse-warnings-in.patch
> 
>  sparse fixes
> 
> +convert-private-abs-to-kernels-abs.patch
> 
>  Remove private ABS() implementations
> 
> +posix-locking-fix-to-posix_same_owner.patch
> +posix-locking-fix-to-locking-code.patch
> +posix-locking-fix-up-nfs4statec.patch
> +posix-locking-fix-up-lockd.patch
> +posix-locking-fl_owner_t-to-pid-mapping.patch
> 
>  POSIX file locking fixes
> 
> +rivafb-fixes.patch
> +mode-switch-in-fbcon_blank.patch
> +another-batch-of-fbcon-fixes.patch
> +asiliantfb-fixes.patch
> 
>  fbdev driver fixes
> 
> +pdcp-needs-io_h.patch
> 
>  Build fix
> 
> +es7000-subarch-update-for-target_cpus.patch
> 
>  es7000 build fix
> 
> +zombie-with-clone_thread.patch
> 
>  Prevent creation of zombies with obscure CLONE_THREAD usage
> 
> +64-bit-bug-in-radix-tree-lookup.patch
> 
>  Fix 32-bit overflow in the radix-tree code
> 
> +s390-core-changes.patch
> +s390-comon-i-o-layer.patch
> +s390-dasd-driver-changes.patch
> +s390-sclp-console-driver.patch
> +s390-network-driver-changes.patch
> +s390-zfcp-host-adapter.patch
> 
>  s390 update
> 
> +ide_tf_pio_out_fixes.patch
> +ide_tf_pio_out_prehandler.patch
> +ide_tf_pio_out_error.patch
> +ide_task_in_intr.patch
> +ide_pre_task_out_intr.patch
> +ide_pre_task_mulout_intr.patch
> +ide_tf_no_partial.patch
> +ide_non_tf_pio.patch
> +ide_no_flagged_pio.patch
> 
>  IDE update
> 
> +x86_64-edd-build-fix.patch
> 
>  Build fix
> 
> +telephony-driver-isapnp-fix.patch
> 
>  ixj.c actually works!
> 
> +1-4-dm-kcopydc-remove-unused-include.patch
> +2-4-dm-kcopydc-make-client_add-return-void.patch
> +3-4-dm-dm-raid1c-enforce-max-of-9-mirrors.patch
> +4-4-dm-dm-raid1c-use-fixed-size-arrays.patch
> 
>  device mapper tweaks
> 
> +physnode-map-can-go-negative.patch
> 
>  Probably fix the NUMAQ remap_pte_range bug.
> 
> +flexible-mmap-bug-fix.patch
> 
>  Fix BUG in the flexible-mmap patches.
> 
> 
> 
> 
> 
> All 161 patches:
> 
> 
> 
> linus.patch
> 
> kbuild-improve-kernel-build-with-separated-output.patch
>   kbuild: Improve Kernel build with separated output
> 
> sysfs-leaves-mount.patch
>   sysfs backing store: add sysfs_dirent
> 
> sysfs-leaves-dir.patch
>   sysfs backing store: add sysfs_dirent
> 
> sysfs-leaves-file.patch
>   sysfs backing store: sysfs_create() changes
> 
> sysfs-leaves-bin.patch
>   sysfs backing store: bin attribute changes
> 
> sysfs-leaves-symlink.patch
>   sysfs backing store: sysfs_create_link changes
> 
> sysfs-leaves-misc.patch
>   sysfs backing store: attribute groups and misc routines
> 
> bk-acpi.patch
> 
> bk-agpgart.patch
> 
> bk-alsa.patch
> 
> bk-cpufreq.patch
> 
> bk-driver-core.patch
> 
> bk-ieee1394.patch
> 
> bk-input.patch
> 
> bk-netdev.patch
> 
> bk-ntfs.patch
> 
> bk-pnp.patch
> 
> bk-scsi.patch
> 
> bk-usb.patch
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> alsa-gus-compile-error.patch
>   fix ALSA gus compile error
> 
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>   kgdb buffer overflow fix
>   kgdbL warning fix
>   kgdb: CONFIG_DEBUG_INFO fix
>   x86_64 fixes
>   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
>   kgdb: fix for recent gcc
>   kgdb warning fixes
>   THREAD_SIZE fixes for kgdb
>   Fix stack overflow test for non-8k stacks
> 
> kgdb-gapatch-fix-for-i386-single-step-into-sysenter.patch
>   kgdb-ga.patch fix for i386 single-step into sysenter
> 
> kgdboe-netpoll.patch
>   kgdb-over-ethernet via netpoll
>   kgdboe: fix configuration of MAC address
> 
> kgdb-x86_64-support.patch
>   kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
>   kgdb-x86_64-warning-fixes
> 
> kgdb-ia64-support.patch
>   IA64 kgdb support
>   ia64 kgdb repair and cleanup
> 
> kgdb-irqaction-use-cpumask.patch
> 
> kgdb-ia64-fix.patch
>   ia64 kgdb fix
> 
> make-tree_lock-an-rwlock.patch
>   make mapping->tree_lock an rwlock
> 
> radix_tree_tag_set-atomic.patch
>   Make radix_tree_tag_set/clear atomic wrt the tag
> 
> radix_tree_tag_set-only-needs-read_lock.patch
>   radix_tree_tag_set only needs read_lock()
> 
> must-fix.patch
>   must fix lists update
>   must fix list update
>   mustfix update
> 
> must-fix-update-5.patch
>   must-fix update
> 
> mustfix-lists.patch
>   mustfix lists
> 
> ppc64-remove-rtas-arguments-from-paca.patch
>   ppc64: emove RTAS arguments from PACA
> 
> ppc64-paca-cleanup.patch
>   ppc64: PACA cleanup
> 
> ppc64-janitor-log_rtas_error-call-arguments.patch
>   ppc64: janitor log_rtas_error() call arguments
> 
> ppc64-janitor-rtas_call-return-variables.patch
>   ppc64: Janitor rtas_call() return variables
> 
> ppc32-ocp-for-mp10x.patch
>   ppc32: OCP for MP10x
> 
> ppc32-ppc44x-updates.patch
>   ppc32: PPC44x defconfig update and fixes
> 
> ppc32-ppc4xx-preempt-fixes.patch
>   ppc32: PPC4xx preempt fix
> 
> ppc64-reloc_hide.patch
> 
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
>   more invalidate_inodes speedup fixes
> 
> get_user_pages-handle-VM_IO.patch
>   fix get_user_pages() against mappings of /dev/mem
> 
> fa311-mac-address-fix.patch
>   wrong mac address with netgear FA311 ethernet card
> 
> pid_max-fix.patch
>   Bug when setting pid_max > 32k
> 
> jbd-remove-livelock-avoidance.patch
>   JBD: remove livelock avoidance code in journal_dirty_data()
> 
> journal_add_journal_head-debug.patch
>   journal_add_journal_head-debug
> 
> list_del-debug.patch
>   list_del debug check
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> lockmeter.patch
>   lockmeter
>   ia64 CONFIG_LOCKMETER fix
> 
> unplug-can-sleep.patch
>   unplug functions can sleep
> 
> firestream-warnings.patch
>   firestream warnings
> 
> ext3_rsv_cleanup.patch
>   ext3 block reservation patch set -- ext3 preallocation cleanup
> 
> ext3_rsv_base.patch
>   ext3 block reservation patch set -- ext3 block reservation
>   ext3 reservations: fix performance regression
>   ext3 block reservation patch set -- mount and ioctl feature
>   ext3 block reservation patch set -- dynamically increase reservation window
>   ext3 reservation ifdef cleanup patch
>   ext3 reservation max window size check patch
>   ext3 reservation file ioctl fix
> 
> ext3-reservation-default-on.patch
>   ext3 reservation: default to on
> 
> ext3-lazy-discard-reservation-window-patch.patch
>   ext3 lazy discard reservation window patch
>   ext3 discard reservation in last iput fix patch
>   Fix lazy reservation discard
>   ext3 reservations: bad_inode fix
>   ext3 reservation discard race fix
> 
> hugetlb_shm_group-sysctl-gid-0-fix.patch
>   hugetlb_shm_group sysctl-gid-0-fix
> 
> really-ptrace-single-step-2.patch
>   ptrace single-stepping fix
> 
> ipr-ppc64-depends.patch
>   Make ipr.c require ppc
> 
> disk-barrier-core.patch
>   disk barriers: core
>   disk-barrier-core-tweaks
> 
> disk-barrier-ide.patch
>   disk barriers: IDE
>   disk-barrier-ide-symbol-expoprt
>   disk-barrier ide warning fix
> 
> barrier-update.patch
>   barrier update
> 
> disk-barrier-scsi.patch
>   disk barriers: scsi
> 
> disk-barrier-dm.patch
>   disk barriers: devicemapper
> 
> disk-barrier-md.patch
>   disk barriers: MD
> 
> reiserfs-v3-barrier-support.patch
>   reiserfs v3 barrier support
>   reiserfs-v3-barrier-support-tweak
> 
> sync_dirty_buffer-retval.patch
>   make sync_dirty_buffer() return something useful
> 
> ext3-barrier-support.patch
>   ext3 barrier support
> 
> jbd-barrier-fallback-on-failure.patch
>   jbd: barrier fallback on failure
> 
> ide-print-failed-opcode.patch
>   ide: print failed opcode on IO errors
>   From: Jens Axboe <axboe@suse.de>
>   Subject: Re: ide errors in 7-rc1-mm1 and later
> 
> add-bh_eopnotsupp-for-testing.patch
>   add BH_Eopnotsupp for testing async barrier failures
> 
> handle-async-barrier-failures.patch
>   Handle async barrier failures
> 
> enable-suspend-resuming-of-e1000.patch
>   Enable suspend/resuming of e1000
> 
> tty_io-hangup-locking.patch
>   tty_io.c hangup locking
> 
> perfctr-core.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
>   CONFIG_PERFCTR=n build fix
> 
> perfctr-i386.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
>   perfctr #if/#ifdef cleanup
>   perfctr Dothan support
> 
> pefrctr-x86_tests-build-fix.patch
>   perfctr x86_tests build fix
> 
> perfctr-x86_64.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64
> 
> perfctr-ppc.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
> 
> perfctr-ppc32-update.patch
>   perfctr ppc32 update
> 
> perfctr-update-4-6-ppc32-cleanups.patch
>   perfctr update 4/6: PPC32 cleanups
> 
> perfctr-virtualised-counters.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
> 
> perfctr-update-6-6-misc-minor-cleanups.patch
>   perfctr update 6/6: misc minor cleanups
> 
> perfctr-update-3-6-__user-annotations.patch
>   perfctr update 3/6: __user annotations
> 
> perfctr-ifdef-cleanup.patch
>   perfctr ifdef cleanup
> 
> perfctr-update-2-6-kconfig-related-updates.patch
>   perfctr update 2/6: Kconfig-related updates
> 
> perfctr-cpus_complement-fix.patch
>   perfctr-cpus_complement-fix
> 
> perfctr-cpumask-cleanup.patch
>   perfctr cpumask cleanup
> 
> perfctr-update-5-6-reduce-stack-usage.patch
>   perfctr update 5/6: reduce stack usage
> 
> perfctr-misc.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc
> 
> ext3-online-resize-patch.patch
>   ext3: online resizing
> 
> ext3-online-resize-warning-fix.patch
>   ext3-online-resize-warning-fix
> 
> net-at1700c-depends-on-mca_legacy.patch
>   net/at1700.c depends on MCA_LEGACY
> 
> net-ne2c-needs-mca_legacy.patch
>   net/ne2.c needs MCA_LEGACY
> 
> altix-serial-driver-2.patch
>   Altix serial driver updates
>   altix-serial-driver-fix
> 
> reduce-tlb-flushing-during-process-migration-2.patch
>   Reduce TLB flushing during process migration
>   reduce-tlb-flushing-during-process-migration-2-fix
>   tlb_migrate_flush documentation
> 
> sched-clean-init-idle.patch
>   sched: cleanup init_idle()
> 
> sched-clean-fork.patch
>   sched: cleanup, improve sched <=> fork APIs
> 
> sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
>   sched: rename wake_up_new_process -> wake_up_new_task
> 
> sched-misc-cleanups-2.patch
>   sched: misc cleanups #2
> 
> sched-unlikely-rt_task.patch
>   sched: make rt_task unlikely
> 
> sched-misc.patch
>   sched: sched misc changes
> 
> sched-misc-fix-rt.patch
>   sched: fix RT scheduling & interactivity estimator
> 
> sched-no-balance-clone.patch
>   sched: disable balance on clone
> 
> sched-remove-balance-clone.patch
>   sched: remove balance on clone
> 
> memory-backed-inodes-fix.patch
>   memory-backed inodes fix
> 
> ext3_bread-cleanup.patch
>   ext3_bread() cleanup
> 
> flexible-mmap-2.6.7-mm3-A8.patch
>   i386 virtual memory layout rework
> 
> next-step-of-smp-support-fix-device-suspending.patch
>   swsusp: preparation for smp support & fix device suspending
> 
> next-step-of-smp-support-fix-device-suspending-warning-fix.patch
>   next-step-of-smp-support-fix-device-suspending warning fix
> 
> next-step-of-smp-support-fix-device-suspending-warning-fix-2.patch
>   next-step-of-smp-support-fix-device-suspending warning fix 2
> 
> next-step-of-smp-support-fix-device-suspending-x86_64-fix.patch
>   next-step-of-smp-support-fix-device-suspending x86_64 fix
> 
> produce-a-warning-on-unchecked-inode_setattr-use.patch
>   produce a warning on unchecked inode_setattr use
> 
> driver-model-and-sysfs-support-for-pcmcia-1-3.patch
>   driver model and sysfs support for PCMCIA (1/3)
> 
> update-drivers-net-pcmcia-2-3.patch
>   update drivers/net/pcmcia (2/3)
> 
> update-drivers-net-wireless-3-3.patch
>   update drivers/net/wireless (3/3)
> 
> bugfix-for-clock_realtime-absolute-timer.patch
>   Bugfix for CLOCK_REALTIME absolute timer
> 
> pcmcia-net-device-unplugging-ordering-fix.patch
>   PCMCIA net device unplugging ordering fix
> 
> remove-upf_resources.patch
>   serial: remove UPF_RESOURCES
> 
> define-max-kernel-symbol-lenght-and-clean-up.patch
>   sparse: define max kernel symbol length and clean up errors in kernel/kallsyms.c
> 
> fix-sparse-warnings-in-kernel-power.patch
>   sparse: fix sparse warnings in kernel/power/*
> 
> fix-sparse-warnings-in.patch
>   sparse: fix sparse in drivers/pnp/pnpbios/*
> 
> convert-private-abs-to-kernels-abs.patch
>   convert private ABS() to kernel's abs()
> 
> posix-locking-fix-to-posix_same_owner.patch
>   posix locking: Minimal fix to posix_same_owner()
> 
> posix-locking-fix-to-locking-code.patch
>   posix locking: more locking code fixes
> 
> posix-locking-fix-up-nfs4statec.patch
>   posix locking: Fix up nfs4state.c
> 
> posix-locking-fix-up-lockd.patch
>   posix locking: Fix up lockd to make use of the new interface
> 
> posix-locking-fl_owner_t-to-pid-mapping.patch
>   posix locking: mapping between fl_owner_t and client-side "pid"
> 
> rivafb-fixes.patch
>   Rivafb fixes
> 
> mode-switch-in-fbcon_blank.patch
>   Mode Switch in fbcon_blank()
> 
> another-batch-of-fbcon-fixes.patch
>   Another batch of fbcon fixes
> 
> pdcp-needs-io_h.patch
>   pcdp.c needs io.h
> 
> es7000-subarch-update-for-target_cpus.patch
>   es7000 subarch update for target_cpus()
> 
> zombie-with-clone_thread.patch
>   Fix zombie with CLONE_THREAD
> 
> asiliantfb-fixes.patch
>   asiliantfb fix
> 
> 64-bit-bug-in-radix-tree-lookup.patch
>   64 bit bug in radix-tree lookup.
> 
> s390-core-changes.patch
>   s390: core changes
> 
> s390-comon-i-o-layer.patch
>   s390: comon i/o layer
> 
> s390-dasd-driver-changes.patch
>   s390: dasd driver changes
> 
> s390-sclp-console-driver.patch
>   s390: sclp console driver
> 
> s390-network-driver-changes.patch
>   s390: network driver changes
> 
> s390-zfcp-host-adapter.patch
>   s390: zfcp host adapter
> 
> ide_tf_pio_out_fixes.patch
>   ide: PIO-out fixes for ide-taskfile.c (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_tf_pio_out_prehandler.patch
>   ide: PIO-out ->prehandler() fixes (CONFIG_IDE_TASKFILE_IO=y)
> 
> ide_tf_pio_out_error.patch
>   ide: PIO-out error handling fixes (CONFIG_IDE_TASKFILE_IO=y)
> 
> ide_task_in_intr.patch
>   ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_pre_task_out_intr.patch
>   remove pre_task_out_intr() comment (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_pre_task_mulout_intr.patch
>   ide: pre_task_mulout_intr() cleanup (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_tf_no_partial.patch
>   ide: no partial completions for PIO (CONFIG_IDE_TASKFILE_IO=y)
> 
> ide_non_tf_pio.patch
>   ide: merge CONFIG_IDE_TASKFILE_IO=y|n PIO handlers together
> 
> ide_no_flagged_pio.patch
>   ide: use "normal" handlers for "flagged" taskfiles (ide-taskfile.c)
> 
> x86_64-edd-build-fix.patch
>   x86_64 EDD build fix
> 
> telephony-driver-isapnp-fix.patch
>   Telephony Driver ISAPNP fix
> 
> 1-4-dm-kcopydc-remove-unused-include.patch
>   DM: kcopyd.c: Remove unused include
> 
> 2-4-dm-kcopydc-make-client_add-return-void.patch
>   DM: kcopyd.c: make client_add() return void
> 
> 3-4-dm-dm-raid1c-enforce-max-of-9-mirrors.patch
>   DM: dm-raid1.c: Enforce max of 9 mirrors
> 
> 4-4-dm-dm-raid1c-use-fixed-size-arrays.patch
>   DM: dm-raid1.c: Use fixed-size arrays
> 
> physnode-map-can-go-negative.patch
>   ia32 NUMA: physnode_map entries can be negative
> 
> flexible-mmap-bug-fix.patch
>   flexible-mmap BUG fix
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

