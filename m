Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTIVIec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 04:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTIVIec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 04:34:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:35487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261882AbTIVIeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 04:34:10 -0400
Date: Mon, 22 Sep 2003 01:35:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test5-mm4
Message-Id: <20030922013548.6e5a5dcf.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm4/


. A series of patches from Al Viro which introduce 32-bit dev_t support

. Various new fixes




Changes since 2.6.0-test5-mm3:


 linus.patch

 Latest Linus tree

-ecc-support.patch
-rt-tasks-special-vm-treatment.patch
-rt-tasks-special-vm-treatment-2.patch
-group_leader-rework.patch
-group_leader-rework-fix.patch
-claim-serio-early.patch
-reiserfs-large-file-fix.patch
-irq-vector-overflow-check.patch
-mtrr-warning-fix.patch
-nls-alias-fixes.patch
-nls-elisp-removal.patch
-sched-2.6.0-test2-mm2-A3.patch
-ppc-sched_clock.patch
-sched-balance-tuning.patch
-sched-interactivity.patch
-might_sleep-diags.patch
-agp-build-fix.patch
-slab-debug-additions.patch
-slab-debug-additions-fix.patch
-remove-smp-txt.patch
-agp-warning-fix.patch
-mwave-needs-8250.patch
-any_online_cpu-fix.patch
-numa-detection-fail-fix.patch
-misc35.patch
-reiserfs-consistency-checks.patch
-remove-dupe-SOUND_RME96XX.patch
-istallion-build-fix.patch
-flock-memleak2.patch
-init-argv-fix.patch
-ens1370-name-fix.patch
-summit-apic-numbering-rework.patch
-wanXL-driver.patch
-floppy-pending-timer-fix.patch
-remove-config_build_info.patch
-access_ok-is-likely.patch
-elv-doc.patch
-sysfs_remove_dir-leak-fix.patch
-modpost-typo-fix.patch
-sbni-compile-fix.patch
-export-new-cdev-functions.patch
-INPUT_KEYCODE-fix.patch
-hangcheck-compile-fix.patch
-fix-make-rpm.patch
-NCR5380-timeout-fix.patch
-SIGRTMAX-fix.patch
-x445-no-ioapic-check.patch
-deadline-insert_here-fix.patch
-bio_dirty_fn-release-fix.patch
-direct-io-skip-compound-pages.patch
-e1000-build-fix.patch
-right-ctrl-scancode-fix.patch
-p00001_synaptics-restore-on-close.patch
-p00002_psmouse-reset-timeout.patch
-p00003_synaptics-multi-button.patch
-p00004_synaptics-optional.patch
-p00005_synaptics-pass-through.patch
-p00006_psmouse-suspend-resume.patch
-p00007_synaptics-old-proto.patch
-synaptics-mode-set.patch
-syn-multi-btn-fix.patch

 Merged

+really-fix-make-rpm.patch

 Fix `make rpm'

+sysrq-cleanups.patch

 cleanup some peftovers

+misc36.patch

 Misc fixes

+declaration-after-statement-check.patch

 Use -Wdeclaration-after-statement i the compiler supports it

-flush-invalidate-fixes-warning-fix.patch

 Folded into flush-invalidate-fixes.patch

+sysfs-dentry-leak-fix.patch

 Fix possible sysfs dentry leak

+filesystem-option-parsing-tweaks.patch
+filesystem-option-parsing-fixes.patch
+filesystem-option-parsing-no-alloca.patch

 Fixes and cleanups for filesystem-option-parsing.patch

+node-enumeration-cleanup-fix-01.patch

 Update to the NUMA node enumeration patches

+CONFIG_HUGETLBFS-sets-CONFIG_HUGETLB_PAGE.patch

 Compile the arch hugetlb support if hugetlbfs is selected

+acpi-thinkpad-fix.patch

 input fix

+readonly-bind-mounts.patch

 Support readonly mount --bind (preliminary - Al needs a go at this)

+setuid-removal-fix.patch

 Correctly clear setuid bits

+synaptics-fix.patch
+synaptics-multibutton-fix.patch
+synaptics-code-cleanup.patch

 Synaptics work

+smbfs-nls-fix.patch

 SMBFS fix

+KD28-reiserfs-B5.patch
+KD29-drm-B5.patch
+KD30-xfs-B5.patch
+KD31-tty_devnum-B5.patch
+KD32-nfs-B5.patch
+KD33-jfs-B5.patch
+KD34-jffs2-B5.patch
+KD35-md-B5.patch
+KD36-dm-B5.patch
+KD37-misc3-B5.patch
+KD38-syscalls-B5.patch
+KD39-loop-B5.patch
+KD40-coda-B5.patch
+KD41-stat-B5.patch
+KD42-32bit-B5.patch
+KD43-real32-B5.patch

 32-bit dev_t

+keyboard-resend-fix-fix.patch

 Fix keyboard-resend-fix.patch for ppc64 and others.






All 158 patches:


linus.patch
  cset-20030917_2214.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-buff-too-big.patch
  kgdb buffer overflow fix

kgdb-warning-fix.patch
  kgdbL warning fix

kgdb-build-fix.patch

kgdb-spinlock-fix.patch

kgdb-fix-debug-info.patch
  kgdb: CONFIG_DEBUG_INFO fix

kgdb-cpumask_t.patch

kgdb-x86_64-fixes.patch
  x86_64 fixes

kgdb-over-ethernet.patch
  kgdb-over-ethernet patch

kgdb-over-ethernet-fixes.patch
  kgdb-over-ethernet fixlets

kgdb-CONFIG_NET_POLL_CONTROLLER.patch
  kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers

kgdb-handle-stopped-NICs.patch
  kgdb: handle netif_stopped NICs

eepro100-poll-controller.patch

tlan-poll_controller.patch

tulip-poll_controller.patch

tg3-poll_controller.patch
  kgdb: tg3 poll_controller

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

kgdb-eth-reattach.patch

kgdb-skb_reserve-fix.patch
  kgdb-over-ethernet: skb_reserve() fix

acpi-20030916.patch
  acpi-20030916

separate-output-dir.patch
  kbuild: Separate output directory support

really-fix-make-rpm.patch
  Really fix `make rpm'

acpi_disabled-fix.patch
  acpi_disabled fix

acpi_off-fix.patch
  fix acpi=off

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

no-unit-at-a-time.patch
  Use -fno-unit-at-a-time if gcc supports it

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-sym2-fix.patch
  ppc64 sym2 fix

sym-do-160.patch
  make the SYM driver do 160 MB/sec

input-use-after-free-checks.patch
  input layer debug checks

fbdev.patch
  framebbuffer driver update

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

intel8x0-cleanup.patch
  intel8x0 cleanups

mark-devfs-obsolete.patch
  mark devfs obsolete

uml-update.patch
  Update UML to 2.6.0-test5

md-make_request-crash-fix.patch
  md: crash fix

sysfs-dput-fix.patch
  sysfs dput fix

sysrq-cleanups.patch
  kill some leftovers from the big sysrq syncing rewrite

misc36.patch
  misc fixes

declaration-after-statement-check.patch
  add -Wdeclaration-after-statement

test5-pm2.patch

test5-pm2-fix.patch

flush-invalidate-fixes.patch
  memory writeback/invalidation fixes

ide_floppy-maybe-fix.patch
  might fix ide_floppy

pdflush-diag.patch

joydev-exclusions.patch
  joydev is too eager claiming input devices

utime-on-immutable-file-fix.patch
  disallow utime{s}() on immutable or append-only files

dgap.patch
  New DGAP driver

dgap-cleanups.patch
  dgap driver cleanups

pdc4030-update.patch
  update pdc4030 driver

ali14xx-update.patch
  update ali14xx driver

dtc2278-update.patch
  update dtc2278 driver

ht6560b-update.patch
  update ht6560b driver

qd65xx-update.patch
  update qd65xx driver

umc8672-update.patch
  update umc8672 driver

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

futex_lock-splitup.patch
  Split futex global spinlock futex_lock

futex-uninlinings.patch
  futex uninlining

sysfs-dentry-leak-fix.patch
  sysfs dentry leak fix

filesystem-option-parsing.patch
  table-driven filesystems option parsing

filesystem-option-parsing-tweaks.patch
  whitespace tweaks

filesystem-option-parsing-fixes.patch
  filesystem option parser: fix handling of integers

filesystem-option-parsing-no-alloca.patch
  filesystem option parser: don't use alloca()

befs-use-parser.patch
  BEFS: Use table-driven option parsing

do_no_page-debug.patch

node-enumeration-cleanup-01.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [1/5]

node-enumeration-cleanup-02.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [2/5]

node-enumeration-cleanup-03.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [3/5]

node-enumeration-cleanup-04.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [4/5]

node-enumeration-cleanup-05.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [5/5]

node-enumeration-cleanup-fix-01.patch
  node enumeration fixes

reenable-athlon-prefetch.patch
  Athlon/Opteron Prefetch Fix

hugetlbfs-accounting-fix.patch
  Hugetlb FS quota accounting problem
  hugetlbfs-accounting-fix tweaks

CONFIG_HUGETLBFS-sets-CONFIG_HUGETLB_PAGE.patch
  make CONFIG_HUGETLB_PAGE mirror CONFIG_HUGETLBFS

zap_page_range-debug.patch
  zap_page_range() debug

acpi-thinkpad-fix.patch
  APCI fix for thinkpads

readonly-bind-mounts.patch
  readonly mount --bind support

setuid-removal-fix.patch
  setuid clearing fix

synaptics-fix.patch
  Fix psmouse->pktcnt in Synaptics mode

synaptics-multibutton-fix.patch
  synaptics: Don't try to handle more than eight multi buttons

synaptics-code-cleanup.patch
  synaptics: Code cleanup

smbfs-nls-fix.patch

KD28-reiserfs-B5.patch

KD29-drm-B5.patch

KD30-xfs-B5.patch

KD31-tty_devnum-B5.patch

KD32-nfs-B5.patch

KD33-jfs-B5.patch

KD34-jffs2-B5.patch

KD35-md-B5.patch

KD36-dm-B5.patch

KD37-misc3-B5.patch

KD38-syscalls-B5.patch

KD39-loop-B5.patch

KD40-coda-B5.patch

KD41-stat-B5.patch

KD42-32bit-B5.patch

KD43-real32-B5.patch

psmouse_ipms2-option.patch
  Force mouse detection as imps/2 (and fix my KVM switch)

i8042-history.patch
  debug: i8042 history dumping

keyboard-resend-fix.patch
  keyboard resend fix

keyboard-resend-fix-fix.patch

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch
  print a few config options on oops

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

20-odirect_enable.patch

21-odirect_cruft.patch

22-read_proc.patch

23-write_proc.patch

24-commit_proc.patch

25-odirect.patch

nfs-O_DIRECT-always-enabled.patch
  Force CONFIG_NFS_DIRECTIO

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix

4g4g-cyclone-timer-fix.patch

4g4g-copy_mount_options-fix.patch
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c

4g4g-might_sleep-warning-fix.patch
  4G/4G might_sleep warning fix

4g4g-pagetable-accounting-fix.patch
  4g/4g pagetable accounting fix

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

aio-09-o_sync.patch
  aio O_SYNC

aio-10-BUG-fix.patch
  AIO: fix a BUG

aio-11-workqueue-flush.patch
  AIO: flush workqueues before destroying ioctx'es

aio-12-readahead.patch
  AIO: readahead fixes

aio-dio-no-readahead.patch
  aio O_DIRECT no readahead

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

aio-take-task_lock.patch
  task task_lock in use_mm()

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes
  aio-O_SYNC-fix bits got lost
  aio: writev nr_segs fix

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup

aio-osync-fix-2.patch
  More AIO O_SYNC related fixes

gang_lookup_next.patch
  Change the page gang lookup API

aio-gang_lookup-fix.patch
  AIO gang lookup fixes

aio-O_SYNC-short-write-fix.patch
  Fix for O_SYNC short writes

O_DIRECT-race-fixes.patch
  DIO fixes forward port and AIO-DIO fix

O_DIRECT-race-fixes-fixes.patch

O_DIRECT-race-fixes-commentary.patch
  O_DIRECT race fixes comments

O_DIRECT-race-fixes-fixes-2.patch
  O_DRIECT race fixes fix fix fix



