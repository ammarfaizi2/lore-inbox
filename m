Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbUJ2IxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUJ2IxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUJ2IxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:53:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:41638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263151AbUJ2Ivc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:51:32 -0400
Date: Fri, 29 Oct 2004 01:49:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm2
Message-Id: <20041029014930.21ed5b9a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/


- There are a bunch of CPU scheduler changes here in the load balancing
  area.  They have been shown to help some workloads, but extra performance
  testing is needed.

- More fiddling with the memory reclaim code.  We're making gradual progress
  here, so people who have had issues in the past with VM behaviour should
  keep an eye out for improvements or regressions.

- sparc64 and possibly other architectures fail to compile at all due to
  a kbuild problem.  A fix is in progress.  Apparently doing

	touch include/asm-foo/Kbuild

  will work around this.


Changes since 2.6.10-rc1-mm1:

 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pnp.patch
 bk-scsi.patch
 bk-serial.patch

 External bk trees

-move-key_init-to-security_initcall.patch
-sysfs-backing-store-prepare-file_operations.patch
-sysfs-backing-store-prepare-file_operations-fix.patch
-sysfs-backing-store-add-sysfs_dirent.patch
-sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
-sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
-sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
-shmem-numa-policy-spinlock.patch
-statm-__vm_stat_accounting.patch
-statm-shared-=-rss-anon_rss.patch
-statm-fix-negative-data.patch
-tmpfs-truncate-latency.patch
-omit-commitavail.patch
-anon-cris-align-address_space.patch
-selinux-fix-netif-bugs-and-simplify.patch
-selinux-fix-sidtab-locking-bug.patch
-ppc64-iseries-console-cleanup-after-tty_write-user-copies-removal.patch
-ppc64-cpu-hotplug-notifier-for-numa.patch
-add-pci_get_legacy_ide_irq.patch
-ppc32-disable-broken-l2-cache-on-all-440gx-revs.patch
-sh-do_signal-update-for-generic-changes.patch
-sh-compile-fixes.patch
-sh-syscall-updates.patch
-hpet-reenabling-after-suspend-resume.patch
-skip-sync_arb_ids-on-p4-xeon.patch
-x86-64-clustered-apic-support.patch
-fix-deadlocks-on-dpm_sem.patch
-kill-useless-pm_access-from-vtc.patch
-add-typechecking-to-suspend-types-and-powerdown-types.patch
-swsusp-print-error-message-when-swapping-is-disabled.patch
-scheduler-remove-redundant-ifdef.patch
-cpufreq-driver-for-nforce2-kernel-267.patch
-remove-unconditional-pci-acpi-irq-routing.patch
-propagate-pci_enable_device-errors.patch
-fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
-possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch
-add-hook-for-pci-resource-deallocation-2.patch
-ia64-alignment-error-stack-dump.patch
-changed-pci_find_device-to-pci_get_device.patch
-rmmod-ohci1394-hangs.patch
-vmscan-pages_scanned-fix.patch
-savagefb-export-fixes.patch
-radeonfb-screeninfo-initialization-cleanup.patch
-radeonfb-if-no-video-memory-exit-with-error.patch
-ia64-get_fs-build-fix.patch
-remove-unused-internal-exports-from-ide-core.patch
-unexport-raise_softirq.patch
-vmalloc_to_page-helper.patch
-make-filemap_fdatawrite_range-static.patch
-remove-unused-code-dump_extended_fpu.patch
-v4l-bttv-ir-input-update.patch
-v4l-bttv-whitespace-cleanup.patch
-v4l-i2c-whitespace-cleanup.patch
-v4l-ir-whitespace-cleanup.patch
-v4l-msp3400-update.patch
-v4l-tuner-update.patch
-v4l-videobuf-whitespace-cleanup.patch
-v4l-videodev-whitespace-cleanup.patch
-remove-module_parm-from-allyesconfig-almost.patch
-rcu-rcu_assign_pointer-removal-of-memory-barriers.patch
-rcu-use-rcu_assign_pointer.patch
-rcu-eliminating-explicit-memory-barriers-from-sysv-ipc.patch
-remove-dead-exports-in-sounds-oss.patch
-remove-dead-exports-in-sounds-oss-fix.patch
-unexport-getnstimeofday.patch
-unexport-kick_process.patch
-remove-page_follow_link.patch
-unexport-sys_lseek.patch
-remove-ext2-xatts-exports.patch
-parport-kill-dead-code-and-exports.patch
-parport-kill-dead-code-and-exports-2.patch
-unexport-vc_cons_allocated.patch
-mark-pi_unclaim-static.patch
-unexport-set_selection-and-paste_selection.patch
-unexport-firmware_class.patch
-ramdisktxt-update.patch
-unexport-some-rxrpc-symbols.patch
-kill-excessive-cdrom-prints.patch
-unexport-add_timer_on.patch
-fix-incorrect-mt-rainier-detection.patch
-add-a-bunch-of-missing-files-to-documentation-00-index.patch
-make-buffer-head-argument-of-buffer_name-const.patch
-ftape-has-no-maintainer.patch
-ftape-documentation-fixes.patch
-signal-gcc34-fix.patch
-lock-initializer-unifying-core.patch
-lock-initializer-unifying-network-drivers.patch
-fix-show_refcnt-return-value-type.patch
-remove-invoke_softirq.patch
-remove-mousedriverssgml.patch
-fix-via-pmuc-compilation-without-config_pmac_pbook.patch
-fatfs-name-termination-fix.patch
-remove-itimer_ticks-and-itimer_next.patch
-handle-posix-message-queues-with-proc-sys-disabled.patch

 Merged

+direct-io-write-memory-leak-fix.patch

 Fix memory leak in direct-io writing

+add-typechecking-to-suspend-types-and-powerdown-types.patch

 typechecking in the power management code

-netfilter_debug-is-buggy.patch

 Dropped: not needed now

+key_init-ordering-fix.patch

 Fix early oops with the key management code

+acpi_processor_start-fix.patch
+acpi_processor_add-warning-fix.patch

 Fix ACPI stuff

+swapper_space-warning-suppression.patch

 Kill out-of-memory allocation warning

+mm-keep-count-of-free-areas.patch
+mm-higher-order-watermarks.patch
+mm-teach-kswapd-about-higher-order-areas.patch

 Teach page reclaim to keep pools of higher-order pages

+bootmem-use-node_data.patch

 bootmem cleanup

-aes-allow-modular-build.patch

 Dropped - was dubious

+netpoll-fix-null-ifa_list-pointer-dereference.patch

 netpoll oops fix

+ppc32-fix-ppc4xx_progress-warnings.patch
+ppc32-fix-boot-on-powermac.patch
+ppc64-iseries-fix-for-generic-irq-changes.patch
+ppc64-setup-cpu_sibling_map-on-iseries.patch
+ppc64-enable-maple-ide-fixup.patch

 ppc32/ppc64 updates

+superhyway-bus-support.patch

 Mysterious new bus for sh arch.

+fix-iounmap-and-a-pageattr-memleak-x86-and-x86-64.patch

 x86/x86_64 low-level page management fixes

+x86_64-fix-safe_smp_processor_id-after-genapic.patch
+x86_64-fix-warning-in-genapic.patch

 x86_64 fixes for the new clustered apic code

+m32r-fix-a-typo-of-delayc.patch

 m32r fix

+uml-fix-mainline-lazyness-about-tty-layer-patch.patch

 UML build fix

+pcmcia-17-device-model-integration.patch
+pcmcia-18a-client_t-and-pcmcia_device-integration.patch
+pcmcia-18b-error-on-leftover-devices.patch
+pcmcia-19-netdevice-integration.patch

 pcmcia device model integration is back.

+sched-more-agressive-wake_idle.patch
+sched-can_migrate-exception-for-idle-cpus.patch
+sched-newidle-fix.patch
+sched-active_load_balance-fixlet.patch

 scheduler load balancing fixes

+add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
+add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix.patch
+add-sysctl-interface-to-sched_domain-parameters.patch

 Add /proc tunables for the scheduler domains code

-reiser4-delete_from_page_cache.patch

 No longer appropriate

+early-uart-console-support.patch
+move-hcdp-pcdp-to-early-uart-console.patch

 early console support for certain UART types

-dio-handle-eof-fix.patch

 Folded into dio-handle-eof.patch

+fbdev-convert-module_parm-to-module_param-in-i810fb.patch
+fbdev-remove-module-parameter-disabled-from-savagefb.patch
+fbdev-convert-module_parm-to-module_param-in-intelfb.patch
+fbdev-convert-module_parm-to-module_param-in-neofb.patch
+fbdev-fix-io-access-in-neofb.patch
+fbdev-add-__iomem-annotations-to-sstfb.patch
+fbdev-add-__iomem-annotations-to-tdfxfb.patch
+fbdev-do-not-memset-the-framebuffer-memory-in-asiliantfb.patch
+fbdev-add-__iomem-annotations-to-cyber2000fb.patch
+fbdev-add-__iomem-annotations-to-pm2fb.patch
+fbdev-add-__iomem-annotations-to-hgafb.patch
+fbdev-add-__iomem-annotations-to-cirrusfb.patch
+fbdev-add-__iomem-annotations-to-vfb.patch
+fbdev-check-if-cursor-image-has-changed-in-intelfb.patch
+fbdev-maintainership.patch

 Minor fbdev updates

+export-power_status-parameter-through-sysfs.patch

 module parameters for the i8k SMM BIOS driver

+via8231-support-for-parallel-port-driver.patch
+via8231-support-for-parallel-port-driver-warning-fix.patch

 parport support for a VIA chipset

+fix-altsysrq-deadlock.patch

 Fix the sysrq-inside-sysrq deadlock

+cputime-introduce-cputime.patch
+cputime-introduce-cputime-fix.patch
+cputime-missing-pieces.patch

 New `cputime' abstration

+detect-atomic-counter-underflows.patch

 debug check to catch atomic_t's going negative - this usually indicates a
 bug.

+fix-deprecated-module_parm-for-capi-subsystem.patch

 MODULE_PARM() removal

+documentation-cpqarraytxt-update.patch
+documentation-mkdevida-removal.patch

 Documentation updates

+lock-initializer-unifying-batch-2-alpha.patch
+lock-initializer-unifying-batch-2-ia64.patch
+lock-initializer-unifying-batch-2-m32r.patch
+lock-initializer-unifying-batch-2-mips.patch
+lock-initializer-unifying-batch-2-misc-drivers.patch
+lock-initializer-unifying-batch-2-block-devices.patch
+lock-initializer-unifying-batch-2-bluetooth.patch
+lock-initializer-unifying-batch-2-drm.patch
+lock-initializer-unifying-batch-2-character-devices.patch
+lock-initializer-unifying-batch-2-rio.patch
+lock-initializer-unifying-batch-2-firewire.patch
+lock-initializer-unifying-batch-2-isdn.patch
+lock-initializer-unifying-batch-2-raid.patch
+lock-initializer-unifying-batch-2-media-drivers.patch
+lock-initializer-unifying-batch-2-pci.patch
+lock-initializer-unifying-batch-2-scsi.patch
+lock-initializer-unifying-batch-2-drivers-serial.patch
+lock-initializer-unifying-batch-2-usb.patch
+lock-initializer-unifying-batch-2-filesystems.patch
+lock-initializer-unifying-batch-2-video.patch
+lock-initializer-unifying-batch-2-networking.patch
+lock-initializer-unifying-batch-2-sound.patch

 Replace lots of SPIN_LOCK_UNLOCKED assignments with spin_lock_init().

+remove-module_parm-from-allyesconfig-almost.patch
+convert-module_parm-to-module_param-family.patch
+more-module_parm-conversions.patch

 More MODULE_PARM conversions.




number of patches in -mm: 382
number of changesets in external trees: 408
number of patches in -mm only: 363
total patches: 771



All 381 patches:


linus.patch

direct-io-write-memory-leak-fix.patch
  direct IO write memory leak fix

add-typechecking-to-suspend-types-and-powerdown-types.patch
  Add typechecking to suspend types and powerdown types

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

key_init-ordering-fix.patch
  key_init ordering fix

bk-acpi.patch

acpi_processor_start-fix.patch
  acpi_processor_start fix

acpi_processor_add-warning-fix.patch
  acpi_processor_add warning fix

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

bk-agpgart.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-ia64.patch

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-kbuild.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pnp.patch

bk-scsi.patch

bk-serial.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

swapper_space-warning-suppression.patch
  swapper_space warning suppression

mm-keep-count-of-free-areas.patch
  mm: keep count of free areas

mm-higher-order-watermarks.patch
  mm: higher order watermarks

mm-teach-kswapd-about-higher-order-areas.patch
  mm: teach kswapd about higher order areas

bootmem-use-node_data.patch
  bootmem use NODE_DATA

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

use-mmiowb-in-tg3_poll.patch
  use mmiowb in tg3_poll

x25-stop-x25_destroy_socket-timer-looping.patch
  X.25: Stop x25_destroy_socket timer looping

ethertap-debug-no-newline.patch
  ethertap debug no newline

x25-stop-proc-net-x25-route-infinitely.patch
  X.25: Stop /proc/net/x25/route infinitely reading

x25-dont-log-unknown-frame-type-when.patch
  X.25: Dont log "unknown frame type" when receiving clear confirm

avoid-warning-on-conntrack_stat_inc-in-destroy_conntrack.patch
  Avoid warning on CONNTRACK_STAT_INC in destroy_conntrack()

netpoll-fix-null-ifa_list-pointer-dereference.patch
  netpoll: fix null ifa_list pointer dereference

ppc32-fix-ppc4xx_progress-warnings.patch
  ppc32: fix ppc4xx_progress warnings

ppc32-fix-boot-on-powermac.patch
  ppc32: Fix boot on PowerMac

ppc64-iseries-fix-for-generic-irq-changes.patch
  ppc64 iSeries: fix for generic irq changes

ppc64-setup-cpu_sibling_map-on-iseries.patch
  ppc64: setup cpu_sibling_map on iSeries

ppc64-enable-maple-ide-fixup.patch
  ppc64: Enable maple IDE fixup

ppc64-reloc_hide.patch

superhyway-bus-support.patch
  SuperHyway bus support

optimize-stack-pointer-access-reduce-register-usage.patch
  x86: optimize stack pointer access (reduce register usage)

fix-iounmap-and-a-pageattr-memleak-x86-and-x86-64.patch
  fix iounmap and a pageattr memleak (x86 and x86-64)

x86_64-fix-safe_smp_processor_id-after-genapic.patch
  x86_64: Fix safe_smp_processor_id after genapic

x86_64-fix-warning-in-genapic.patch
  x86_64: Fix warning in genapic

m32r-fix-a-typo-of-delayc.patch
  m32r: fix a typo of delay.c

uml-fix-mainline-lazyness-about-tty-layer-patch.patch
  uml: fix mainline lazyness about TTY layer patch

pcmcia-17-device-model-integration.patch
  pcmcia-17: device model integration

pcmcia-18a-client_t-and-pcmcia_device-integration.patch
  pcmcia-18a: client_t and pcmcia_device integration

pcmcia-18b-error-on-leftover-devices.patch
  pcmcia-18b: error on leftover devices

pcmcia-19-netdevice-integration.patch
  pcmcia-19: netdevice integration

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
  perfctr: core

perfctr-i386.patch
  perfctr: i386

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

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

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-ppc32-update.patch
  perfctr ppc32 update

ext3-online-resize-patch.patch
  ext3: online resizing

sched-more-agressive-wake_idle.patch
  sched: more agressive wake_idle()

sched-can_migrate-exception-for-idle-cpus.patch
  sched: can_migrate exception for idle cpus

sched-newidle-fix.patch
  sched: newidle fix

sched-active_load_balance-fixlet.patch
  sched: active_load_balance() fixlet

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions

add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix.patch
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

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

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

serialize-access-to-ide-devices.patch
  serialize access to ide devices

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

kexec-ide-spindown-fix.patch
  kexec-ide-spindown-fix

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

early-uart-console-support.patch
  early uart console support

move-hcdp-pcdp-to-early-uart-console.patch
  move HCDP/PCDP to early uart console

vm-pageout-throttling.patch
  vm: pageout throttling

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

dio-handle-eof.patch
  direct-IO: handle EOF
  dio-handle-eof fix

fbdev-convert-module_parm-to-module_param-in-i810fb.patch
  fbdev: Convert MODULE_PARM to module_param in i810fb

fbdev-remove-module-parameter-disabled-from-savagefb.patch
  fbdev: Remove module parameter 'disabled' from savagefb

fbdev-convert-module_parm-to-module_param-in-intelfb.patch
  fbdev: Convert MODULE_PARM to module_param in intelfb

fbdev-convert-module_parm-to-module_param-in-neofb.patch
  fbdev: Convert MODULE_PARM to module_param in neofb

fbdev-fix-io-access-in-neofb.patch
  fbdev: Fix io access in neofb

fbdev-add-__iomem-annotations-to-sstfb.patch
  fbdev: Add __iomem annotations to sstfb

fbdev-add-__iomem-annotations-to-tdfxfb.patch
  fbdev: Add __iomem annotations to tdfxfb

fbdev-do-not-memset-the-framebuffer-memory-in-asiliantfb.patch
  fbdev: Do not memset the framebuffer memory in asiliantfb

fbdev-add-__iomem-annotations-to-cyber2000fb.patch
  fbdev: Add __iomem annotations to cyber2000fb

fbdev-add-__iomem-annotations-to-pm2fb.patch
  fbdev: Add __iomem annotations to pm2fb

fbdev-add-__iomem-annotations-to-hgafb.patch
  fbdev: Add __iomem annotations to hgafb

fbdev-add-__iomem-annotations-to-cirrusfb.patch
  fbdev: Add __iomem annotations to cirrusfb

fbdev-add-__iomem-annotations-to-vfb.patch
  fbdev: Add __iomem annotations to vfb

fbdev-check-if-cursor-image-has-changed-in-intelfb.patch
  fbdev: Check if cursor image has changed in intelfb

fbdev-maintainership.patch
  fbdev: Maintainership

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

use-mmiowb-in-tg3c.patch
  use mmiowb in tg3.c

invalidate_inode_pages-mmap-coherency-fix.patch
  invalidate_inode_pages2() mmap coherency fix

export-power_status-parameter-through-sysfs.patch
  export power_status parameter through sysfs

yenta_socketc-fix-missing-pci_disable_dev.patch
  yenta_socket.c: Fix missing pci_disable_dev

unwind-information-fix-for-the-vsyscall-dso.patch
  Unwind information fix for the vsyscall DSO

make-dnotify-a-configure-time-option.patch
  make dnotify a configure-time option

make-dnotify-a-configure-time-option-embedded.patch
  make-dnotify-a-configure-time-option-embedded

convert-pipefs-to-fs_initcall.patch
  convert pipefs to fs_initcall()

yenta-dont-enable-read-prefetch-on-older-o2-bridges.patch
  yenta: don't enable read prefetch on older o2 bridges.

via8231-support-for-parallel-port-driver.patch
  VIA8231 support for parallel port driver

via8231-support-for-parallel-port-driver-warning-fix.patch
  via8231-support-for-parallel-port-driver warning fix

fix-altsysrq-deadlock.patch
  fix alt-sysrq deadlock

cputime-introduce-cputime.patch
  cputime: introduce cputime

cputime-introduce-cputime-fix.patch
  cputime-introduce-cputime fix

cputime-missing-pieces.patch
  cputime: missing pieces.

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

fix-deprecated-module_parm-for-capi-subsystem.patch
  Fix deprecated MODULE_PARM for CAPI subsystem

documentation-cpqarraytxt-update.patch
  Documentation/cpqarray.txt update

documentation-mkdevida-removal.patch
  Documentation/mkdev.ida removal

lock-initializer-unifying-batch-2-alpha.patch
  Lock initializer unifying: ALPHA

lock-initializer-unifying-batch-2-ia64.patch
  Lock initializer unifying: IA64

lock-initializer-unifying-batch-2-m32r.patch
  Lock initializer unifying: M32R

lock-initializer-unifying-batch-2-mips.patch
  Lock initializer unifying: MIPS

lock-initializer-unifying-batch-2-misc-drivers.patch
  Lock initializer unifying: Misc drivers

lock-initializer-unifying-batch-2-block-devices.patch
  Lock initializer unifying: Block devices

lock-initializer-unifying-batch-2-bluetooth.patch
  Lock initializer unifying: Bluetooth

lock-initializer-unifying-batch-2-drm.patch
  Lock initializer unifying: DRM

lock-initializer-unifying-batch-2-character-devices.patch
  Lock initializer unifying: character devices

lock-initializer-unifying-batch-2-rio.patch
  Lock initializer unifying: RIO

lock-initializer-unifying-batch-2-firewire.patch
  Lock initializer unifying: Firewire

lock-initializer-unifying-batch-2-isdn.patch
  Lock initializer unifying: ISDN

lock-initializer-unifying-batch-2-raid.patch
  Lock initializer unifying: Raid

lock-initializer-unifying-batch-2-media-drivers.patch
  Lock initializer unifying: media drivers

lock-initializer-unifying-batch-2-pci.patch
  Lock initializer unifying: PCI

lock-initializer-unifying-batch-2-scsi.patch
  Lock initializer unifying: SCSI

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-usb.patch
  Lock initializer unifying: USB

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-networking.patch
  Lock initializer unifying: Networking

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

remove-module_parm-from-allyesconfig-almost.patch
  Remove MODULE_PARM from allyesconfig (almost)

convert-module_parm-to-module_param-family.patch
  convert MODULE_PARM() to module_param() family

more-module_parm-conversions.patch
  more MODULE_PARM conversions



