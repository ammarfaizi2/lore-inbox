Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUGNB1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUGNB1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267288AbUGNB1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 21:27:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:29647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267287AbUGNB1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 21:27:10 -0400
Date: Tue, 13 Jul 2004 18:25:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc1-mm1
Message-Id: <20040713182559.7534e46d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/

- Lots of little fixes, mainly

- Numerous scheduling latency fixes, mainly in the ext3 area.

  This is a first pass - these patches need redoing and a bit of
  infrastructure consolidation.

- Outta here: I won't be in a position to handle patches until July 26.  Off
  to http://www.tech-forum.org/upcoming/open_source_software_06-10-04.htm and
  then Kernel Summit and then OLS.




Changes since 2.6.7-mm7:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-dma-declare-coherent-memory.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-jfs.patch
 bk-libata.patch
 bk-mpc52xx.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pnp.patch
 bk-scsi.patch
 bk-usb.patch

 External trees

-jfs_dmap-build-fix.patch
-bfusb-hack.patch
-quota-iflags-locking-fix.patch
-ppc64-out-of-line-some-user-copy-routines.patch
-clean-up-module-install-rules.patch
-kbuild-sort-modules-for-modpost-and-modinst.patch
-intrinsic-automount-and-mountpoint-degradation-support.patch
-intrinsic-automount-and-mountpoint-degradation-support-fix.patch
-kafs-automount-support.patch
-kafs-automount-support-build-fix.patch
-ia64-audit-support.patch
-more-mca_legacy-dependencies.patch
-use-llseek-instead-of-f_pos=-for-directory-seeking.patch
-reduce-tlb-flushing-during-process-migration-3.patch
-fix-compile-errors-with-x86_powernow_k78=y-and-acpi_processor=m.patch
-mptbase-warning-fix.patch
-remove-dead-isdn-pcmcia-code.patch
-sparse-fix-warnings-in-net-sctp.patch
-kallsyms-ppc32-fix.patch
-noexec-kernel-parameters-update.patch
-cfq-bad-allocation.patch
-fat-update-document.patch
-use-null-instead-of-integer-0-in-security-selinux.patch
-int-return-to-unsigned-in-smb_proc_readdir_long-in.patch
-trivial-scripts_kernel-doc-ignoring-embedded-structs-shouldnt.patch
-trivial-scripts_kernel-doc-missing-bracket.patch
-trivial-little-arch_i386_kernel_timers_timer_nonec-fix.patch
-trivial-rcs___ignore-quilt-backup-files.patch
-trivial-remove-warning-in-ftape.patch
-trivial-arch_i386_kernel_scx200c-kill-duplicate.patch
-trivial-kill-off-config_pci_console.patch
-convert-uses-of-zone_highmem-to-is_highmem.patch
-smbfs-compilation-warning-in-267.patch
-remove-always-false-check-in-mm-slabc.patch
-correct-return-type-of-hashfn-in-fs-dquotc.patch
-fix-misplaced-inline-in-include-linux-iso_fsh.patch
-pagefault-readaround-fix.patch
-trivial-fix-to-include-scsi-scsi_deviceh.patch
-alpha-print-the-symbol-name-in-oops.patch
-port-acpi-sleep-workaround-to-new-dmi-probing.patch
-dmi-isnt-broken-anymore.patch
-fix-crc16-misnaming.patch
-crc16-kconfig-touchups.patch
-crc16-renaming-in-ax25-drivers.patch
-crc16-renaming-in-irda-drivers.patch
-crc16-renaming-in-isdn-drivers.patch
-crc16-renaming-in-ppp-driver.patch
-sh64-cpumask-cleanup.patch
-sh64-fix-init_taskc-build.patch
-sh64-add-asm-sh64-setuph.patch
-sh64-defconfig-update.patch
-add-missing-sysfs-support-to-cpia-webcam-video-driver.patch
-tmpfs-scheduling-while-atomic-fix.patch
-ad1889-warning-fix.patch
-writepage-fs-corruption-fixes.patch
-block_write_full_page-comment-fixes.patch
-deflate-remove-lazy-allocation.patch

 Merged

+w9968cf-build-fix.patch

 USB build fix

+ppc32-pmac_zilog-initialize-port-spinlock-on-all-init-paths.patch

 pmac UART driver fix

+x86-64-support-for-singlestep-into-32-bit-system-calls.patch

 x86_64 ptrace fix

+perfctr-documentation-update.patch

 perfctr documentation

+kernelthread-idle-fix.patch

 Fix idling of kernel threads

+i810_audio-fix-the-error-path-of-resource-management.patch

 Audio driver fix

+add-a-few-might_sleep-checks-fix.patch

 Add additional sleep-in-spinlock checks

+release_task-may-sleep.patch

 Fix release_task() locking

+fix-airo-oops-on-removal.patch

 Fix wireless driver oops after renaming the interface

+serious-performance-regression-due-to-nx-patch.patch

 Fix the NX patch for ia64 (in progress)

+per_cpu-per_cpu-cpu_gdt_table.patch
+per_cpu-per_cpu-init_tss.patch
+per_cpu-per_cpu-cpu_tlbstate.patch

 Convert some NR_CPUS arrays to per-cpu.

+gcc35-advansys.c.patch
+gcc35-alps_tdlb7.c.patch
+gcc35-always-inline.patch
+gcc35-arlan.h.patch
+gcc35-auerswald.c.patch
+gcc35-dabusb.c.patch
+gcc35-ds.c.patch
+gcc35-fixmap.h.patch
+gcc35-fore200e.c.patch
+gcc35-index.html.patch
+gcc35-ip6_fib.c.patch
+gcc35-iphase.h.patch
+gcc35-irttp.h.patch
+gcc35-mtrr.h.patch
+gcc35-netrom.h.patch
+gcc35-pppoe.c.patch
+gcc35-sonypi.patch
+gcc35-sp887x.c.patch
+gcc35-tda1004x.c.patch
+gcc35-transport.h.patch
+gcc35-ufs_fs.h.patch
+gcc35-usblp.c.patch
+gcc35-videodev.c.patch
+gcc35-wavefront_fx.c.patch
+gcc35-xfrm6_state.c.patch

 gcc-3.5 fixes

+fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc.patch
+fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc-fix.patch

 rivafb fix

+dev-zero-vs-hugetlb-mappings.patch
+hugetlbfs-vm_pgoff-bugs.patch
+hugetlbfs-private-mappings.patch

 hugetlbpage fixes.

+net-kconfig-crc16-fix.patch

 Net driver Kconfig fixes

+fix-oops-in-device_platform_unregister.patch

 driver core oops fix

+preset-loops_per_jiffy-for-faster-booting.patch

 Add the "lpj=" kernel boot option

+define-inline-as-__attribute__always_inline-also-for-gcc-=-34.patch
+gcc-34-and-broken-inlining.patch

 Fix up the compiler-specific inline decls

+handle-undefined-symbols.patch

 Another attempt at handling symbols which end up undefined in vmlinux

+fix-3c59xc-uses-of-plain-integer-as-null-pointer.patch

 sparse fixes

+small-style-fixups-for-the-new-automount-code.patch

 cleanups

+split-generic_file_aio_write-into-buffered-and-direct-i-o-parts.patch

 Split up some VFS pagecache functions for future XFS work.

+ifndef-guard-percpu_counterh-and-blockgroup_lockh.patch

 Build fix

+floppyc-remove-superfluous-variable-initialization.patch

 Cleanup

+unknown-symbol-in-drivers-scsi-pcmcia-fdomain_csko.patch

 Kconfig fix

+radeonfb-cleanup-and-little-fixes.patch

 fbdev driver fixes

+unknown-symbol-in-sound-oss-kahluako-needs-unknown-symbol-udelay.patch

 Sound driver build fix

+remove-struct_cpy.patch

 Kill struct_cpy()

+autoselect-fatfs.patch

 Kconfig simplification for FATFS

+making-i-dhash_entries-cmdline-work-as-it-use-to.patch

 permit huge VFS cache hashes.

+fix-double-reset-in-aic7xxx-driver.patch

 aic7xxx fix

+fix-saa7146-compilation-on-268-rc1.patch

 build fix

+fix-return-codes-after-i2c_add_driver-in-tea6415c.patch

 i2c driver fix

+remove-outdated-stallion-contact-information.patch

 Update comments and documentation.

+rivafb-i2c-fixes.patch

 Fix rivafb i2c handling

+x86-64-singlestep-through-sigreturn-system-call.patch

 x86_64 single-step fix

+jbd-recovery-latency-fix.patch
+truncate_inode_pages-latency-fix.patch
+journal_clean_checkpoint_list-latency-fix.patch
+kjournald-smp-latency-fix.patch
+unmap_vmas-smp-latency-fix.patch
+__cleanup_transaction-latency-fix.patch
+prune_dcache-latency-fix.patch
+filemap_sync-latency-fix.patch
+get_user_pages-latency-fix.patch
+slab-latency-fix.patch

 Various scheduling latency fixes

+fix-ia64-early_printk-build-problem.patch

 ia64 build fix

+fix-inode-state-corruption-268-rc1-bk1.patch

 Fix lost inodes in VFS writeback.





All 252 patches:


linus.patch

kbuild-improve-kernel-build-with-separated-output.patch
  kbuild: Improve Kernel build with separated output

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

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-dma-declare-coherent-memory.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-ieee1394.patch

bk-input.patch

bk-jfs.patch

bk-libata.patch

bk-mpc52xx.patch

bk-netdev.patch

bk-ntfs.patch

bk-pnp.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

w9968cf-build-fix.patch
  w9968cf build fix

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

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

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

ppc32-pmac_zilog-initialize-port-spinlock-on-all-init-paths.patch
  pmac_zilog: initialize port spinlock on all init paths

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

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

x86-64-support-for-singlestep-into-32-bit-system-calls.patch
  x86-64 support for singlestep into 32-bit system calls

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

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

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

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups

perfctr-ppc32-buglet-fix.patch
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-documentation-update.patch
  perfctr documentation update

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

altix-serial-driver-2.patch
  Altix serial driver updates
  altix-serial-driver-fix

sched-clean-init-idle.patch
  sched: cleanup init_idle()

sched-clean-fork.patch
  sched: cleanup, improve sched <=> fork APIs

sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
  sched: rename wake_up_new_process -> wake_up_new_task

sched-misc-cleanups-2.patch
  sched: misc cleanups #2

sched-unlikely-rt_task.patch
  sched: make rt_task unlikely

sched-misc.patch
  sched: sched misc changes

sched-misc-fix-rt.patch
  sched: fix RT scheduling & interactivity estimator

sched-no-balance-clone.patch
  sched: disable balance on clone

sched-remove-balance-clone.patch
  sched: remove balance on clone

sched-fork-hotplug-cleanuppatch.patch
  sched: fork hotplug hanling cleanup

kernelthread-idle-fix.patch
  sched: kernel_thread idle fix

memory-backed-inodes-fix.patch
  memory-backed inodes fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

flexible-mmap-2.6.7-mm3-A8.patch
  i386 virtual memory layout rework

flexible-mmap-bug-fix.patch
  flexible-mmap BUG fix

flexible-mmap-updatepatch-267-mm5.patch
  flexible-mmap update

driver-model-and-sysfs-support-for-pcmcia-1-3.patch
  driver model and sysfs support for PCMCIA (1/3)

update-drivers-net-pcmcia-2-3.patch
  update drivers/net/pcmcia (2/3)

update-drivers-net-wireless-3-3.patch
  update drivers/net/wireless (3/3)

posix-locking-fix-to-posix_same_owner.patch
  posix locking: Minimal fix to posix_same_owner()

posix-locking-fix-to-locking-code.patch
  posix locking: more locking code fixes

posix-locking-fix-up-nfs4statec.patch
  posix locking: Fix up nfs4state.c

posix-locking-fix-up-lockd.patch
  posix locking: Fix up lockd to make use of the new interface

posix-locking-fl_owner_t-to-pid-mapping.patch
  posix locking: mapping between fl_owner_t and client-side "pid"

ide_tf_pio_out_fixes.patch
  ide: PIO-out fixes for ide-taskfile.c (CONFIG_IDE_TASKFILE_IO=n)

ide_tf_pio_out_prehandler.patch
  ide: PIO-out ->prehandler() fixes (CONFIG_IDE_TASKFILE_IO=y)

ide_tf_pio_out_error.patch
  ide: PIO-out error handling fixes (CONFIG_IDE_TASKFILE_IO=y)

ide_task_in_intr.patch
  ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)

ide_pre_task_out_intr.patch
  remove pre_task_out_intr() comment (CONFIG_IDE_TASKFILE_IO=n)

ide_pre_task_mulout_intr.patch
  ide: pre_task_mulout_intr() cleanup (CONFIG_IDE_TASKFILE_IO=n)

ide_tf_no_partial.patch
  ide: no partial completions for PIO (CONFIG_IDE_TASKFILE_IO=y)

ide_non_tf_pio.patch
  ide: merge CONFIG_IDE_TASKFILE_IO=y|n PIO handlers together

ide_no_flagged_pio.patch
  ide: use "normal" handlers for "flagged" taskfiles (ide-taskfile.c)

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.

fix-race-in-pktcdvd-kernel-thread-handling.patch
  Fix race in pktcdvd kernel thread handling

fix-open-close-races-in-pktcdvd.patch
  Fix open/close races in pktcdvd

packet-writing-review-fixups.patch
  packet writing: review fixups

remove-pkt_dev-from-struct-pktcdvd_device.patch
  Remove pkt_dev from struct pktcdvd_device

packet-writing-docco.patch
  packet writing documentation

convert-packet-writing-to-seq_file.patch
  packet writing: convert to seq_file

r8169_napi-help-text-2.patch
  R8169_NAPI help text

no-sysgood-for-ptrace-singlestep.patch
  Don't use SYSGOOD for ptrace singlestep

err2-6-hashbin_remove_this-locking-fix.patch
  err2-6: hashbin_remove_this() locking fix

dm-use-idr.patch
  devicemapper: use an IDR tree for tracking minors

ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
  ipc: Add refcount to ipc_rcu_alloc

ipc-2-3-remove-sem_revalidate.patch
  ipc: remove sem_revalidate

ipc-3-3-enforce-semvmx-limit-for-undo.patch
  ipc: enforce SEMVMX limit for undo

cleanup-of-ipc-msgc.patch
  cleanup of ipc/msg.c

sk98lin-procfs-fix.patch
  sk98lin procfs fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

i2c-i2c-devci2c_dev_init-cleanup.patch
  i2c/i2c-dev.c::i2c_dev_init() cleanup.

uml-base-patch.patch
  uml: Uml base patch

uml-readds-just-for-now-ghashh-for-uml.patch
  uml: Readds (just for now) ghash.h for UML

uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
  uml: Avoid that gcc breaks UML with "unit at a time" compilation mode.

uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
  uml: Fixes an host fd leak caused by hostfs.

uml-adds-legacy_pty-config-option.patch
  uml: Adds LEGACY_PTY config option

uml-makes-make-help-arch=um-work.patch
  uml: Makes "make help ARCH=um" work.

uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
  uml: Fixes "fixdep.c" to support arch/um/include/uml-config.h.

uml-kill-useless-warnings.patch
  uml: Kill useless warnings

uml-avoids-compile-failure-when-host-misses-tkill.patch
  uml: Avoids compile failure when host misses tkill().

uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
  uml: Reduces code in *_user files, by moving it in _kern files if already possible.

uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
  uml: Fixes raw() and uses it in check_one_sigio; also fixes a silly panic (EINTR returned by call).

uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
  uml: Folds hostaudio_user.c into hostaudio_kern.c.

uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
  uml: Use PTRACE_SCEMU (the so-called SYSEMU) to reduce syscall cost.

uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
  uml: Adds the "nosysemu" command line parameter to disable SYSEMU

uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
  uml: Adds /proc/sysemu to toggle SYSEMU usage.

uml-fix-for-sysemu-patches.patch
  uml: Fix for sysemu patches

uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
  uml: Handles correctly errno == EINTR in lots of places.

uml-adds-some-exports.patch
  uml: Adds some exports

uml-avoids-a-panic-for-a-legal-situation.patch
  uml: Avoids a panic for a legal situation

uml-removes-dead-code-in-trap_kernc.patch
  uml: Removes dead code in trap_kern.c

uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
  uml: Make malloc() call vmalloc if needed. Needed for hostfs on 2.6 host.

uml-little-kmalloc.patch
  uml: little-kmalloc

uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch
  uml: Fix os_process_pc and os_process_parent for corner cases.

fix-warnings-in-net-irda.patch
  sparse: fix warnings in net/irda/*

i810_audio-mmio-support.patch
  i810_audio MMIO support

i810_audio-mmio-support-2.patch
  i810_audio MMIO support #2

i810_audio-fix-the-error-path-of-resource-management.patch
  i810_audio: Fix the error path of resource management

fix-warnings-drivers-net-sk98lin-skaddrc.patch
  Fix warnings drivers/net/sk98lin/skaddr.c

fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch
  Fix drivers/isdn/hisax/avm_pci.c build warning when !CONFIG_ISAPNP

idr-stale-comment.patch
  idr.c: remove stale comment

bio_copy_user-cleanups.patch
  bio_copy_user() cleanups

idr-comments-updates.patch
  idr comments updates

detect-too-early-schedule-attempts.patch
  detect too early schedule attempts

schedule-profiling.patch
  schedule() profiling
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: schedule profileing

add-a-few-might_sleep-checks.patch
  Add a few might_sleep() checks

add-a-few-might_sleep-checks-fix.patch
  add-a-few-might_sleep-checks fix

release_task-may-sleep.patch
  permit sleeping in release_task()

ia64-ptrace-fix-fix.patch
  Make get_user_pages() work again for ia64 gate area

possible-buglet-in-drivers-input-joystick-tmdcc.patch
  Possible buglet in drivers/input/joystick/tmdc.c

crc16-renaming-in-via-velocity-ethernet-driver.patch
  CRC16 renaming in VIA Velocity ethernet driver

fix-airo-oops-on-removal.patch
  fix airo oops-on-removal

serious-performance-regression-due-to-nx-patch.patch
  Fix serious performance regression due to NX patch

per_cpu-per_cpu-cpu_gdt_table.patch
  percpu: cpu_gdt_table

per_cpu-per_cpu-init_tss.patch
  percpu: init_tss

per_cpu-per_cpu-cpu_tlbstate.patch
  percpu: cpu_tlbstate

gcc35-advansys.c.patch
  gcc-3.5 fixes

gcc35-alps_tdlb7.c.patch
  gcc-3.5 fixes

gcc35-always-inline.patch
  gcc-3.5 fixes

gcc35-arlan.h.patch
  gcc-3.5 fixes

gcc35-auerswald.c.patch
  gcc-3.5 fixes

gcc35-dabusb.c.patch
  gcc-3.5 fixes

gcc35-ds.c.patch
  gcc-3.5 fixes

gcc35-fixmap.h.patch
  gcc-3.5 fixes

gcc35-fore200e.c.patch
  gcc-3.5 fixes

gcc35-index.html.patch
  gcc-3.5 fixes

gcc35-ip6_fib.c.patch
  gcc-3.5 fixes

gcc35-iphase.h.patch
  gcc-3.5 fixes

gcc35-irttp.h.patch
  gcc-3.5 fixes

gcc35-mtrr.h.patch
  gcc-3.5 fixes

gcc35-netrom.h.patch
  gcc-3.5 fixes

gcc35-pppoe.c.patch
  gcc-3.5 fixes

gcc35-sonypi.patch
  gcc-3.5 fixes

gcc35-sp887x.c.patch
  gcc-3.5 fixes

gcc35-tda1004x.c.patch
  gcc-3.5 fixes

gcc35-transport.h.patch
  gcc-3.5 fixes

gcc35-ufs_fs.h.patch
  gcc-3.5 fixes

gcc35-usblp.c.patch
  gcc-3.5 fixes

gcc35-videodev.c.patch
  gcc-3.5 fixes

gcc35-wavefront_fx.c.patch
  gcc-3.5 fixes

gcc35-xfrm6_state.c.patch
  gcc-3.5 fixes

fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc.patch
  Fix rivafb's NV_ARCH_, cleanup DEBUG, backlight control on ppc

fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc-fix.patch
  fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc fix

dev-zero-vs-hugetlb-mappings.patch
  /dev/zero vs hugetlb mappings.

hugetlbfs-vm_pgoff-bugs.patch
  hugetlbfs vm_pgoff bugs

hugetlbfs-private-mappings.patch
  hugetlbfs private mappings

net-kconfig-crc16-fix.patch
  net/Kconfig crc16 warning fix

fix-oops-in-device_platform_unregister.patch
  Fix OOPS in device_platform_unregister

preset-loops_per_jiffy-for-faster-booting.patch
  preset loops_per_jiffy for faster booting

define-inline-as-__attribute__always_inline-also-for-gcc-=-34.patch
  #define inline as __attribute__((always_inline)) also for gcc >= 3.4

gcc-34-and-broken-inlining.patch
  clean up __always_inline__ usage

handle-undefined-symbols.patch
  Fail if vmlinux contains undefined symbols

fix-3c59xc-uses-of-plain-integer-as-null-pointer.patch
  Fix 3c59x.c uses of plain integer as NULL pointer

small-style-fixups-for-the-new-automount-code.patch
  small style fixups for the new automount code

split-generic_file_aio_write-into-buffered-and-direct-i-o-parts.patch
  split generic_file_aio_write into buffered and direct I/O parts

ifndef-guard-percpu_counterh-and-blockgroup_lockh.patch
  #ifndef guard percpu_counter.h and blockgroup_lock.h

floppyc-remove-superfluous-variable-initialization.patch
  floppy.c: remove superfluous variable initialization

unknown-symbol-in-drivers-scsi-pcmcia-fdomain_csko.patch
  fdomain_cs needs ISA

radeonfb-cleanup-and-little-fixes.patch
  radeonfb: cleanup and little fixes

unknown-symbol-in-sound-oss-kahluako-needs-unknown-symbol-udelay.patch
  `unknown symbol' in sound/oss/kahlua.ko needs unknown symbol udelay

remove-struct_cpy.patch
  remove struct_cpy()

autoselect-fatfs.patch
  autoselect FAT_FS in config

making-i-dhash_entries-cmdline-work-as-it-use-to.patch
  Make i/dhash_entries cmdline work as it use to.

fix-double-reset-in-aic7xxx-driver.patch
  Fix double reset in aic7xxx driver

fix-saa7146-compilation-on-268-rc1.patch
  fix saa7146 compilation

fix-return-codes-after-i2c_add_driver-in-tea6415c.patch
  fix return codes after i2c_add_driver() in tea6415c and tea6420

remove-outdated-stallion-contact-information.patch
  remove outdated Stallion contact information

rivafb-i2c-fixes.patch
  Rivafb I2C fixes

x86-64-singlestep-through-sigreturn-system-call.patch
  x86-64 singlestep through sigreturn system call

jbd-recovery-latency-fix.patch
  jbd recovery latency fix

truncate_inode_pages-latency-fix.patch
  truncate_inode_pages-latency-fix

journal_clean_checkpoint_list-latency-fix.patch
  journal_clean_checkpoint_list latency fix

kjournald-smp-latency-fix.patch
  kjournald-smp-latency-fix

unmap_vmas-smp-latency-fix.patch
  unmap_vmas-smp-latency-fix

__cleanup_transaction-latency-fix.patch
  __cleanup_transaction-latency-fix

prune_dcache-latency-fix.patch
  prune_dcache-latency-fix

filemap_sync-latency-fix.patch
  filemap_sync-latency-fix

slab-latency-fix.patch
  slab-latency-fix

fix-ia64-early_printk-build-problem.patch
  fix ia64 early_printk build problem

fix-inode-state-corruption-268-rc1-bk1.patch
  fix inode state incoherency

get_user_pages-latency-fix.patch
  get_user_pages-latency-fix



