Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUFXIsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUFXIsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 04:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUFXIsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 04:48:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:7892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263804AbUFXIrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 04:47:53 -0400
Date: Thu, 24 Jun 2004 01:46:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm2
Message-Id: <20040624014655.5d2a4bfb.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/


- Added a patch from Ingo which reworks the placement of mmaps within the
  ia32 virtual memory layout.  Has been in RH kernels for a long time.

  If it breaks something, the app was already buggy.  You can use

	setarch -L my-buggy-app <args>

  to run in back-compat mode.  This requires a setarch patch - see the
  changelog in flexible-mmap-267-mm1-a0.patch for details.

- knfsd update, arch updates, various fixes, cleanups and new bugs.




Changes since 2.6.7-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of external trees

-opti92x-ad1848-locking-fix.patch
-bk-input-build-fix.patch
-ppc64-build-fix.patch
-ppc64-eeh-warning-fix.patch
-pcm_native-stack-reduction.patch
-export-dmi-check-functions.patch
-hp-pavilion-use-dmi-api.patch
-pcmcia-enable-read-prefetch-on-o2micro-bridges-to-fix-hdsp.patch
-permit-inode-dentry-hash-tables-to-be-allocated-max_order-size.patch
-permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-update.patch
-improved-psx-support-in-input-joystick-gameconc.patch
-o_noatime-support.patch
-ppp_syncttyc-receive-write_wakeup-fix.patch
-ide-stack-reduction-cleanup.patch
-airo-broke.patch
-jfs-build-fix.patch
-hid-tmff-fix-again.patch
-swapoff-activate-pages.patch
-add-ovcamchip-driver.patch
-uninline-machine_specific_memory_setup.patch
-add-wait_event_interruptible_exclusive-macro.patch
-iommu-max-segment-size.patch
-v4l-v4l2-api-updates.patch
-v4l-update-video-buf-for-per-frame-input-switching.patch
-v4l-video-buf-magic-numbers.patch
-v4l-video-buf-fixes.patch
-v4l-msp3400-cleanup.patch
-v4l-ir-common-update.patch
-v4l-tuner-tda9887-updates.patch
-v4l-bttv-driver-update.patch
-v4l-ir-input-driver-update.patch
-saa7134-update.patch
-v4l-cx88-driver-update.patch
-v4l-radio-zoltrix-fix.patch
-fix-isdn-to-not-assume-memio-return-values.patch
-sys_ioctl-export.patch
-mprotect-propagate-anon_vma.patch
-sparsify-quotactl.patch
-fix-possible-stack-corruption-during-reiserfs_file_write.patch
-numa-api-updates.patch
-isp16-check_region-removal.patch
-deadline-docco.patch
-move-as-docco.patch
-credits-update.patch
-nls-support-for-ascii.patch
-mips-remove-old-junk.patch
-ds1286-cleanups.patch
-cobalt-lcd-driver-update.patch
-add-m48t35-rtc-driver.patch
-farsync-warning-fix.patch
-sparc64-bug-needs-compiler-h.patch
-jfs-warning-fix.patch
-velocity-warning-fixes.patch
-velocity-warning-fixes-2.patch
-velocity-warning-fixes-3.patch
-velocity-warning-fixes-4.patch
-lindent-rwsem.patch
-tdfxb-warning-fix.patch
-idrh-path.patch
-wanxl-firmware-build-fix.patch
-avoid-rebuild-of-ikcfg-when-using-o=.patch
-kbuild-add-deb-pkg-target.patch
-x86_64-double-clock-speed-fix.patch

 Merged

+kbuild-improve-kernel-build-with-separated-output.patch

 kbuild improvements for building in a separate object directory

+kgdb-gapatch-fix-for-i386-single-step-into-sysenter.patch

 Fix kgdb sysenter handling

-config_spinline.patch

 Temporarily dropped so that
 allow-i386-to-reenable-interrupts-on-lock-contention.patch gets properly
 tested.

-schedstats.patch

 Dropped due to some reject I was getting and was too lazy to fix.

-SL0-core-RC6-bk5.patch
-SL1-ext2-RC6-bk5.patch
-SL2-trivial-RC6-bk5.patch
-SL3-page-RC6-bk5.patch
-SL4-smb-RC6-bk5.patch
-SL5-xfs-RC6-bk5.patch
-SL6-shm-RC6-bk5.patch
-SL7-befs-RC6-bk5.patch
-SL8-jffs2-RC6-bk5.patch

 These are out of date.

-reduce-tlb-flushing-during-process-migration.patch
-reduce-tlb-flushing-during-process-migration-oops-fix.patch

 Dropped, obsolete.

+rcu-no-arg-fastcall-fix.patch
+sch_generic-rcu-fix.patch

 Fix up rcu-no-arg.patch

+nx-update-2.patch

 Update to the ia32 no-execute-bit patch

-input-serio-dynamic-allocation-fix.patch

 I forget what happened to this.

+abs-fix-fix.patch

 Fix abs-fix

+r8169_napi-help-text.patch

 Kconfig help fix

+for-netmos-based-pci-cards-providing-serial-and-parallel-ports.patch

 Driver fix

+kbuild-distclean-srctree-fix.patch

 kbuild fix

+help-text-for-fb_riva_i2c.patch

 Kconfig help fix

+nr_pagecache-can-go-negative.patch

 handle nr_pagecache going transiently negative

+nr_swap_pages-is-long.patch
+nr_swap_pages-is-long-fixes.patch
+total_swap_pages-is-long.patch

 Make nr_swap_pages and total_swap_pages longs.

+a2-rewrite-and-26-fixes.patch

 MIPS sound driver rewrite.

+dell-laptop-lockup-fix-for-alsa.patch

 Fix a dell laptop problem

+mips-update.patch
+mips-indydog-update.patch

 Mips updates

+re-267-mm1-linker-trouble-with-config_fb_riva_i2c=y-and-modular-i2c.patch

 fb driver build fix

+fix-early-cpu-vendor-detection-for-non-intel-cpus.patch

 Fix early CPU detect

+oprofile-allow-normal-user-to-trigger-sample-dumps.patch

 oprofile permission fix

+make-__free_pages_bulk-more-comprehensible.patch

 Code cleanup

+tiny-update-to-documentation-submittingdrivers-list-xorg.patch

 Documentation update

+net-at1700c-depends-on-mca_legacy.patch
+net-ne2c-needs-mca_legacy.patch

 net driver build fixes

+core-fbcon-fixes.patch

 fbcon fixes

+video-mode-change-notify-fbset.patch

 fb driver fixes

+fix-power3-numa-init.patch

 ppc64 fix

+cap_dac_override.patch

 CAP_DAC_OVERRIDE consistency

+add-ppc85xx-maintainers-entry.patch

 MAINTAINERS update

+flexible-mmap-267-mm1-a0.patch
+flexible-mmap-267-mm1-a0-fix.patch

 rework ia32 mmap layout to increase the available virtual address space.

+oprofile-documentation-basic_profilingtxt-updates.patch

 documentation update

+selinux-extend-and-revise-calls-to-secondary-module.patch

 selinux fix

+fix-allocate_pgdat-comments.patch

 Fix comments

+drivers-media-video-tda9840c-honour-return-code-of.patch

 driver fix

+altix-serial-driver.patch
+altix-serial-driver-fix.patch

 Altic serial driver update

+zap_pte_range-speedup.patch

 Remove some unneeded code

+h8300-delete-obsolute-header.patch

 h8/300 cleanup

+cirrusfb-it-lives.patch

 Big cirrusfb update

+update-ikconfig-help-text.patch
+update-ikconfig-generator-script.patch
+consolidate-in-kernel-configuration.patch

 ikconfig fixes

+hugetlb-use-safe-iterator.patch
+more-bug-fix-in-mm-hugetlbc-fix-try_to_free_low.patch

 hugetlb fixes

+bridge-fix-bpdu-message_age.patch

 bridge driver fix

+swsusp-minor-docs-updates.patch
+prepare-for-smp-suspend.patch
+swsusp-shuffle-cpuc-to-make-it-usable-for-smp-suspend.patch

 swsusp updates

+267-mm1-port-acer-laptop-irq-routing-workaround-to-new-dmi-probing.patch
+267-mm1-port-pnp-bios-driver-to-new-dmi-probing.patch
+267-mm1-port-sonypi-driver-to-new-dmi-probing.patch
+267-mm1-port-piix4-smbus-driver-to-new-dmi-probing.patch
+267-mm1-port-powernow-k7-driver-to-new-dmi-probing.patch
+267-mm1-remove-unused-asus-k7v-rm-dmi-quirk.patch
+267-mm1-port-apm-bios-driver-to-new-dmi-probing.patch

 Use the new dmi APIs

+hpet-fixes.patch
+hpet-fixes-fix.patch

 HPET driver fixes

+reduce-tlb-flushing-during-process-migration-2.patch

 ia64 context switch speedup

+sparse-trivial-fixes-of-assignment-expression-in-conditional-in-fs.patch

 sparsification

+per-node-huge-page-stats-in-sysfs.patch

 per-numa-node hugetlb stats in sysfs

+shut-up-kaweth-usb-net-driver.patch
+scsi-printk-fixes.patch

 Squich noisy driver printks

+oom-killer-fix.patch

 Fix an oom-killer problem

+sh-sh-3-on-chip-adc-support.patch
+sh-dma-mapping-updates.patch
+sh-dma-driver-updates.patch
+sh-early-printk-cleanup.patch
+sh-fixmap-support.patch
+sh-renesas-hs7751rvoip-board-support.patch
+sh-ide-cleanup.patch
+sh-ptep_get_and_clear-compile-fix.patch
+sh-sh-sci-updates.patch
+sh-solutionengine-7300-board-support.patch
+sh-renesas-rts7751r2d-board-support.patch
+sh-pci-updates.patch
+sh-sh7705-sh7300-subtype-support-st40-updates.patch
+sh-voyagergx-companion-chip-support.patch
+sh-merge.patch
+sh-consolidate-systemh-with-other-renesas-boards.patch

 Super-H update

+md-fix-up-handling-for-read-error-in-raid1.patch

 RAID1 fix

+knfsd-mark-nfs-tcp-server-not-experimental.patch
+knfsd-simplify-nfsd4-name-encoding.patch
+knfsd-simplify-nfsd4_release_lockowner.patch
+knfsd-delete-an-obsolete-comment-from-nfsd-rpc-code.patch
+knfsd-reduce-stack-usage-in-nfsd4.patch
+knfsd-nfsd4-lockowner-fixes.patch
+knfsd-parse-nsfd4-callback-information.patch
+knfsd-improve-cleaning-up-of-nfsd4-requests.patch
+knfsd-allow-user-to-set-nfsv4-lease-time.patch

 kNFSd updates

+md-xor-template-selection-redo.patch

 MD fix

+kswapd-warning-fix.patch
+balanced_irq-warning-fix.patch
+tr-warning-fixes.patch
+fc-warning-fix.patch
+pkt_sched-warning-fixes.patch

 Fix some warnings

+ip_fw_compat_masq-build-fix.patch

 netfilter compile fix

+267-fix-broken-alpha-build-ptracec-error.patch

 alpha compile fix





All 195 patches:


linus.patch

kbuild-improve-kernel-build-with-separated-output.patch
  kbuild: Improve Kernel build with separated output

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

sysfs-leaves-mount.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-dir.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-file.patch
  sysfs backing store: sysfs_create() changes

sysfs-leaves-bin.patch
  sysfs backing store: bin attribute changes

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups and misc routines

ext3-jbd-needs-to-wait-for-locked-buffers.patch
  jbd needs to wait for locked buffers

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-arm.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pcmcia.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

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

kgdb-gapatch-fix-for-i386-single-step-into-sysenter.patch
  kgdb-ga.patch fix for i386 single-step into sysenter

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

radix_tree_tag_set-atomic.patch
  Make radix_tree_tag_set/clear atomic wrt the tag

radix_tree_tag_set-only-needs-read_lock.patch
  radix_tree_tag_set only needs read_lock()

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

mustfix-lists.patch
  mustfix lists

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

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

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

larger-io-bitmap.patch
  larger IO bitmaps

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

ftruncate-vs-block_write_full_page.patch
  ftruncate vs block_write_full_page race fix

ia32-fault-deadlock-fix-2.patch
  ia32: fix deadlocks when oopsing while mmap_sem is held

ppc64-fault-deadlock-fix-2.patch
  ppc64: fix deadlocks when oopsing while mmap_sem is held

ipr-ppc64-depends.patch
  Make ipr.c require ppc

disk-barrier-core.patch
  disk barriers: core
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE
  disk-barrier-ide-symbol-expoprt
  disk-barrier ide warning fix

barrier-update.patch
  barrier update

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support
  reiserfs-v3-barrier-support-tweak

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

ext3-barrier-support.patch
  ext3 barrier support

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

ide-print-failed-opcode.patch
  ide: print failed opcode on IO errors
  From: Jens Axboe <axboe@suse.de>
  Subject: Re: ide errors in 7-rc1-mm1 and later

add-bh_eopnotsupp-for-testing.patch
  add BH_Eopnotsupp for testing async barrier failures

handle-async-barrier-failures.patch
  Handle async barrier failures

x86-stack-dump-fixes.patch
  x86 stack dump fixes

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c
  arch/i386/boot/compressed/misc.c warning fixes

rcu-lock-update-add-per-cpu-batch-counter.patch
  rcu lock update: Add per-cpu batch counter

rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
  rcu lock update: Use a sequence lock for starting batches

rcu-lock-update-code-move-cleanup.patch
  rcu lock update: Code move & cleanup

singly-linked-rcu.patch
  reduce rcu_head size - core

rcu-no-arg.patch
  rcu: avoid passing an argument to the callback function

rcu-no-arg-fix.patch
  reduce rcu_head size fix

rcu-no-arg-fastcall-fix.patch
  rcu-no-arg fastcall fix

sch_generic-rcu-fix.patch
  sch_generic-rcu-fix

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

nx-2.6.7-rc2-bk2-AF.patch
  NX (No eXecute) support for x86

nx-update.patch
  nx update

nx-update-2.patch
  nx update 2

cpumask-1-10-cpu_present_map-real-even-on-non-smp.patch
  cpumask 1/10 cpu_present_map real even on non-smp

cpumask-2-10-bitmap-cleanup-preparation-for-cpumask.patch
  cpumask 2/10 bitmap cleanup preparation for cpumask  overhaul

cpumask-3-10-bitmap-inlining-and-optimizations.patch
  cpumask 3/10 bitmap inlining and optimizations

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based.patch
  cpumask 5/10 rewrite cpumask.h - single bitmap based  implementation

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based-cpu_mask_none-fix.patch
  CPU_MASK_NONE fix

s390-fix-cpu_online-redefined-warnings.patch
  s390: fix "cpu_online" redefined warnings

cpumask-6-10-remove-26-no-longer-used-cpumaskh-files.patch
  cpumask 6/10 remove 26 no longer used cpumask*.h files

cpumask-7-10-remove-obsolete-cpumask-macro-uses-i386-arch.patch
  cpumask 7/10 remove obsolete cpumask macro uses - i386 arch

cpumask-8-10-remove-obsolete-cpumask-macro-uses-other.patch
  cpumask 8/10 remove obsolete cpumask macro uses - other  archs

x86_64-cpu_online-fix.patch
  x86_64-cpu_online-fix

ppc64-cpu_online-fix.patch
  ppc64: cpu_online fix

cpumask-9-10-remove-no-longer-used-obsolete-macro-emulation.patch
  cpumask 9/10 Remove no longer used obsolete macro emulation

cpumask-10-10-optimize-various-uses-of-new-cpumasks.patch
  cpumask 10/10 optimize various uses of new cpumasks

cpumask-11-10-comment-spacing-tweaks.patch
  cpumask: comment, spacing tweaks

cleanup-cpumask_t-temporaries.patch
  clean up cpumask_t temporaries

alpha-cpumask-fix.patch
  alpha: cpumask fixups

irqaction-use-cpumask.patch
  make irqaction use a cpu mask
  Fix irqaction-use-cpumask.patch for voyager

fix-and-reenable-msi-support-on-x86_64.patch
  Fix and Reenable MSI Support on x86_64
  Fix and Reenable MSI Support on x86_64 fix

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-cpus_complement-fix.patch
  perfctr-cpus_complement-fix

perfctr-cpumask-cleanup.patch
  perfctr cpumask cleanup

perfctr-misc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

vmscan-shuffle-things-around.patch
  vmscan.c: shuffle things around

vmscan-scan-sanity.patch
  vmscan.c scan rate fixes

vmscan-dont-reclaim-too-many-pages.patch
  vmscan.c: dont reclaim too many pages

vfs-shrinkage-tuning.patch
  vm: vfs shrinkage tuning

ide-stack-reduction.patch
  IDE stack reduction

dnotify-remove-dn_lock.patch
  dnotify.c: use inode->i_lock in place of dn_lock

dont-writeback-fd-bdev-inodes.patch
  dont-writeback-fd-bdev-inodes

fancy-wakeups-in-wait-h.patch
  Use fancy wakeups in wait.h

input-psmouse-resync-for-kvm-users.patch
  input: psmouse resync for KVM users

input-psmouse-state-locking.patch
  input: psmouse state locking

input-serio-connect-disconnect-mandatory.patch
  input: serio connect/disconnect mandatory

input-serio-renames-1.patch
  input: serio renames 1

input-serio-renames-1-fix.patch
  input-serio-renames-1-fix

input-serio-renames-2.patch
  input: serio renames 2

input-serio-dynamic-allocation.patch
  input: serio dynamic allocation

input-serio-dynamic-allocation-fix-2.patch
  input-serio-dynamic-allocation-fix-2

input-serio-dynamic-allocation-fix-3.patch
  input-serio-dynamic-allocation-fix-3

input-serio-no-recursion.patch
  input: serio no recursion

input-serio-sysfs-integration.patch
  input: serio sysfs integration

input-serio-allow-rebinding.patch
  input: serio allow rebinding

input-serio-manual-bind.patch
  input: serio manual bind

input-serio_raw-driver.patch
  input: serio_raw driver

buddy-reordering.patch
  tweak the buddy allocator for better I/O merging

hwcache-align-kmalloc-caches.patch
  hwcache align kmalloc caches

reduce-function-inlining-in-slabc.patch
  reduce function inlining in slab.c

abs-fix.patch
  abs() fixes

abs-fix-fix.patch
  abs-fix-fix

ide-taskfilec-fixups-cleanups.patch
  ide: remove redundant hwgroup->handler checks from ide-taskfile.c

ide-end-request-fix-for-config_ide_taskfile_io=y-pio-handlers.patch
  ide: end request fix for CONFIG_IDE_TASKFILE_IO=y PIO handlers

ide-pio-in-drive-busy-fix-config_ide_taskfile_io=y.patch
  ide: PIO-in drive busy fix (CONFIG_IDE_TASKFILE_IO=y)

ide-check-drive-mult_count-in-flagged_taskfile.patch
  ide: check drive->mult_count in flagged_taskfile()

ide-last-irq-fix-for-task_mulout_intr-config_ide_taskfile_io=n.patch
  ide: last IRQ fix for task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n)

ide-remove-dtf-debugging-printks-from-ide-taskfilec.patch
  ide: remove DTF() debugging printks from ide-taskfile.c

ide-add-task_multi_sectors-to-ide-taskfilec.patch
  ide: add task_multi_sectors() to ide-taskfile.c

ide-split-task_sectors-and-task_multi_sectors.patch
  ide: split task_sectors() and task_multi_sectors()

ide-dont-clear-rq-errors-for-req_drive_taskfile-requests.patch
  ide: don't clear rq->errors for REQ_DRIVE_TASKFILE requests

ide-use-task_buffer_sectors-in-ide-taskfilec.patch
  ide: use task_buffer[_multi]_sectors() in ide-taskfile.c

ide-pio-out-setup-fixes-config_ide_taskfile_io=n.patch
  ide: PIO-out setup fixes (CONFIG_IDE_TASKFILE_IO=n)

sysfs-overflow-debug.patch
  sysfs-overflow-debug

fix-smbfs-readdir-oops.patch
  Fix smbfs readdir oops

remove-smbfs-server-rcls-err.patch
  Remove smbfs server->rcls/err

kallsyms-exclude.patch
  kallsyms: exclude kallsyms-generated symbols

kallsyms-verify.patch
  kallsyms: verify that System.map is stable

r8169_napi-help-text.patch
  R8169_NAPI help text

for-netmos-based-pci-cards-providing-serial-and-parallel-ports.patch
  Support NetMOS based PCI cards providing serial and parallel ports

kbuild-distclean-srctree-fix.patch
  kbuild: distclean srctree fix

help-text-for-fb_riva_i2c.patch
  help text for FB_RIVA_I2C

nr_pagecache-can-go-negative.patch
  nr_pagecache can go negative

nr_swap_pages-is-long.patch
  Make nr_swap_pages a long

nr_swap_pages-is-long-fixes.patch
  nr_swap_pages-is-long-fixes

total_swap_pages-is-long.patch
  make total_swap_pages a long

a2-rewrite-and-26-fixes.patch
  mips: SGI A2 audio rewrite and 2.6 fixes

dell-laptop-lockup-fix-for-alsa.patch
  Dell laptop lockup fix for ALSA

mips-update.patch
  MIPS Update

mips-indydog-update.patch
  Indydog update

re-267-mm1-linker-trouble-with-config_fb_riva_i2c=y-and-modular-i2c.patch
  fix linker trouble with CONFIG_FB_RIVA_I2C=y and modular I2C

fix-early-cpu-vendor-detection-for-non-intel-cpus.patch
  Fix early CPU vendor detection for non intel cpus

oprofile-allow-normal-user-to-trigger-sample-dumps.patch
  OProfile: allow normal user to trigger sample dumps

make-__free_pages_bulk-more-comprehensible.patch
  make __free_pages_bulk more comprehensible

tiny-update-to-documentation-submittingdrivers-list-xorg.patch
  SubmittingDrivers fix

net-at1700c-depends-on-mca_legacy.patch
  net/at1700.c depends on MCA_LEGACY

net-ne2c-needs-mca_legacy.patch
  net/ne2.c needs MCA_LEGACY

core-fbcon-fixes.patch
  Core fbcon fixes

video-mode-change-notify-fbset.patch
  fbdev: video mode change notify (fbset)

fix-power3-numa-init.patch
  ppc64: fix POWER3 NUMA init

cap_dac_override.patch
  CAP_DAC_OVERRIDE fix

add-ppc85xx-maintainers-entry.patch
  Add PPC85xx MAINTAINERS entry

flexible-mmap-267-mm1-a0.patch
  i386 virtual memory layout rework

flexible-mmap-267-mm1-a0-fix.patch
  flexible-mmap-267-mm1-a0 x86_64 fix

oprofile-documentation-basic_profilingtxt-updates.patch
  (o)profile Documentation/basic_profiling.txt updates

selinux-extend-and-revise-calls-to-secondary-module.patch
  SELinux: Extend and revise calls to secondary module

fix-allocate_pgdat-comments.patch
  fix allocate_pgdat comments

drivers-media-video-tda9840c-honour-return-code-of.patch
  drivers/media/video/tda9840.c: honour return code of i2c_add_driver()

altix-serial-driver.patch
  Altix serial driver updates

altix-serial-driver-fix.patch
  altix-serial-driver-fix

zap_pte_range-speedup.patch
  zap_pte_range speedup

h8300-delete-obsolute-header.patch
  h8300: delete obsolute header

cirrusfb-it-lives.patch
  cirrusfb: major update

update-ikconfig-help-text.patch
  update ikconfig help text

update-ikconfig-generator-script.patch
  update ikconfig generator script

hugetlb-use-safe-iterator.patch
  hugetlb.c: use safe iterator

bridge-fix-bpdu-message_age.patch
  Bridge - Fix BPDU message_age

swsusp-minor-docs-updates.patch
  swsusp minor docs updates

prepare-for-smp-suspend.patch
  Prepare for SMP suspend

swsusp-shuffle-cpuc-to-make-it-usable-for-smp-suspend.patch
  swsusp: shuffle cpu.c to make it usable for smp suspend

267-mm1-port-acer-laptop-irq-routing-workaround-to-new-dmi-probing.patch
  dmi_scan: port Acer laptop irq routing workaround to new DMI probing

267-mm1-port-pnp-bios-driver-to-new-dmi-probing.patch
  dmi_scan: port PnP BIOS driver to new DMI probing

267-mm1-port-sonypi-driver-to-new-dmi-probing.patch
  dmi_scan: port sonypi driver to new DMI probing

267-mm1-port-piix4-smbus-driver-to-new-dmi-probing.patch
  dmi_scan: port PIIX4 SMBUS driver to new DMI probing

267-mm1-port-powernow-k7-driver-to-new-dmi-probing.patch
  dmi_scan: port powernow-k7 driver to new DMI probing

267-mm1-remove-unused-asus-k7v-rm-dmi-quirk.patch
  dmi_scan: remove unused ASUS K7V-RM DMI quirk

267-mm1-port-apm-bios-driver-to-new-dmi-probing.patch
  dmi_scan: port APM BIOS driver to new DMI probing

hpet-fixes.patch
  hpet fixes

hpet-fixes-fix.patch
  hpet-fixes fix

consolidate-in-kernel-configuration.patch
  consolidate in-kernel configuration

reduce-tlb-flushing-during-process-migration-2.patch
  Reduce TLB flushing during process migration

sparse-trivial-fixes-of-assignment-expression-in-conditional-in-fs.patch
  sparse: fixes for "assignment expression in conditional" in fs/*

more-bug-fix-in-mm-hugetlbc-fix-try_to_free_low.patch
  hugetlb.c - fix try_to_free_low()

per-node-huge-page-stats-in-sysfs.patch
  per node huge page stats in sysfs

shut-up-kaweth-usb-net-driver.patch
  shut-up kaweth  usb/net driver

scsi-printk-fixes.patch
  scsi printk fixes

oom-killer-fix.patch
  oom killer: ignore free swapspace

sh-sh-3-on-chip-adc-support.patch
  sh: SH-3 On-Chip ADC support

sh-dma-mapping-updates.patch
  sh: dma-mapping updates.

sh-dma-driver-updates.patch
  sh: DMA driver updates.

sh-early-printk-cleanup.patch
  sh: early printk() cleanup.

sh-fixmap-support.patch
  sh: fixmap support.

sh-renesas-hs7751rvoip-board-support.patch
  sh: Renesas HS7751RVoIP board support.

sh-ide-cleanup.patch
  sh: IDE cleanup.

sh-ptep_get_and_clear-compile-fix.patch
  sh: ptep_get_and_clear() compile fix.

sh-sh-sci-updates.patch
  sh: sh-sci updates.

sh-solutionengine-7300-board-support.patch
  sh: SolutionEngine 7300 board support.

sh-renesas-rts7751r2d-board-support.patch
  sh: Renesas RTS7751R2D board support.

sh-pci-updates.patch
  sh: PCI updates

sh-sh7705-sh7300-subtype-support-st40-updates.patch
  sh: SH7705/SH7300 subtype support, ST40 updates.

sh-voyagergx-companion-chip-support.patch
  sh: VoyagerGX companion chip support.

sh-merge.patch
  sh: merge.

sh-consolidate-systemh-with-other-renesas-boards.patch
  sh: Consolidate SystemH with other Renesas boards.

md-fix-up-handling-for-read-error-in-raid1.patch
  md: Fix up handling for read error in raid1.

knfsd-mark-nfs-tcp-server-not-experimental.patch
  knfsd: mark NFS/TCP server not EXPERIMENTAL

knfsd-simplify-nfsd4-name-encoding.patch
  knfsd: simplify nfsd4 name encoding.

knfsd-simplify-nfsd4_release_lockowner.patch
  knfsd: simplify nfsd4_release_lockowner

knfsd-delete-an-obsolete-comment-from-nfsd-rpc-code.patch
  knfsd: delete an obsolete comment from nfsd rpc code

knfsd-reduce-stack-usage-in-nfsd4.patch
  knfsd: reduce stack usage in nfsd4

knfsd-nfsd4-lockowner-fixes.patch
  knfsd: nfsd4 lockowner fixes

knfsd-parse-nsfd4-callback-information.patch
  knfsd: parse nsfd4 callback information

knfsd-improve-cleaning-up-of-nfsd4-requests.patch
  knfsd: improve cleaning up of nfsd4 requests

knfsd-allow-user-to-set-nfsv4-lease-time.patch
  knfsd: allow user to set NFSv4 lease time.

md-xor-template-selection-redo.patch
  md: XOR template selection redo

kswapd-warning-fix.patch
  kswapd warning fix

balanced_irq-warning-fix.patch
  balanced_irq warning fix

tr-warning-fixes.patch
  tr.c warning fix

fc-warning-fix.patch
  fc.c warning fix

ip_fw_compat_masq-build-fix.patch
  ip_fw_compat_masq.c build fix

pkt_sched-warning-fixes.patch
  pkt_sched.h warning fixes

267-fix-broken-alpha-build-ptracec-error.patch
  fix broken alpha build ptrace.c error



