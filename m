Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTI2CKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 22:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTI2CKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 22:10:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:28613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbTI2CJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 22:09:55 -0400
Date: Sun, 28 Sep 2003 19:10:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test6-mm1
Message-Id: <20030928191038.394b98b4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1


Lots of small things mainly.

The O_DIRECT-vs-buffers I/O locking changes appear to be complete, so testing
attention on O_DIRECT workloads would be useful.




Changes since 2.6.0-test5-mm4:

 linus.patch

 Latest Linus tree

-separate-output-dir.patch
-really-fix-make-rpm.patch
-slab-hexdump.patch
-delay-ksoftirqd-fallback.patch
-mark-devfs-obsolete.patch
-md-make_request-crash-fix.patch
-sysfs-dput-fix.patch
-sysrq-cleanups.patch
-misc36.patch
-declaration-after-statement-check.patch
-test5-pm2.patch
-test5-pm2-fix.patch
-utime-on-immutable-file-fix.patch
-futex_lock-splitup.patch
-sysfs-dentry-leak-fix.patch
-hugetlbfs-accounting-fix.patch
-CONFIG_HUGETLBFS-sets-CONFIG_HUGETLB_PAGE.patch
-setuid-removal-fix.patch
-synaptics-fix.patch
-synaptics-multibutton-fix.patch
-synaptics-code-cleanup.patch
-smbfs-nls-fix.patch
-KD28-reiserfs-B5.patch
-KD29-drm-B5.patch
-KD30-xfs-B5.patch
-KD31-tty_devnum-B5.patch
-KD32-nfs-B5.patch
-KD33-jfs-B5.patch
-KD34-jffs2-B5.patch
-KD35-md-B5.patch
-KD36-dm-B5.patch
-KD37-misc3-B5.patch
-KD38-syscalls-B5.patch
-KD39-loop-B5.patch
-KD40-coda-B5.patch
-KD41-stat-B5.patch
-KD42-32bit-B5.patch
-KD43-real32-B5.patch

 Merged

+d-task-xid.patch
+d-task-xid-fixes.patch

 Abstract out access to current->euid and friends, in preparation for
 obtaining this from the group leader

-no-unit-at-a-time.patch

 Dropped: we'll fix this properly, with attribute(used)

+selectable-logbuf-size.patch

 Add log_buf_size= kernel boot parameter.

+dscc4-warning-fixes.patch

 WAN driver warning fix

+serio-reconnect.patch

 serio reinitialisation infrastructure

+synaptics-reconnect.patch

 Synaptics update

+hugetlbfs_fill_super-leak-fix.patch

 memleak fix

+com200020-request_region-fix.patch

 resource allocation fixes

+bin2c-copyrights.patch

 Historical revisionism

+CDROM_SEND_PACKET-fix.patch

 Kill CDROM_SEND_PACKET setup, use SG_IO internally.

+isdn_common-build-fix.patch

 Compile fix

+dev_t-forward-compatibility.patch

 Initialise ext2/3 inodes a bit more.

+smbfs-build-fix.patch

 Compile fix

+fs-Kconfig-use-select.patch

 Tidy up fs/Kconfig

+mman-h-fix.patch

 Remove duplicated #defines

+flush-invalidate-fixes-doc-fixes.patch

 cachetlb.txt clarity

-joydev-exclusions.patch

 Became unneeded

+utime-on-immutable-file-fix-cleanup.patch

 Tidy up handling on utime() against immutable files

-pdc4030-update.patch

 Broke.

+befs-use-parser-update.patch

 Fix befs-use-parser.patch for API changes

+compat-ioctl-consolidation.patch

 Factorisation

+acpi-pci-irq-fix-439.patch

 Fix ACPI PCI IRQ routing again

+module_parm_array-fix.patch

 Fix intarray module parms

+proc-sys-permission-checking.patch

 Tidy permission checking for /proc/sys

+mtd-leak-fix.patch

 memleak

+selinux-convert_context-fix.patch
+security_inode_permission-wants-nameidata.patch

 SELinux/security fixes

+pnmtologo-warning-fix.patch

 warning fix

+befs-memleak-fix.patch

 leak

+misc38.patch

 misc fixes

+call_usermodehelper-retval-fix-2.patch

 Return the subprocess's exit code correctly for synchronous
 call_usermodehelper().

-i8042-history.patch

 Broke, dropped.

-keyboard-resend-fix.patch
-keyboard-resend-fix-fix.patch

 Broke.  (Not needed any more?)

-4g4g-cyclone-timer-fix.patch
-4g4g-copy_mount_options-fix.patch
-4g4g-might_sleep-warning-fix.patch
-4g4g-pagetable-accounting-fix.patch

 Folded into 4g-2.6.0-test2-mm2-A5.patch

-O_DIRECT-race-fixes.patch
-O_DIRECT-race-fixes-fixes.patch
-O_DIRECT-race-fixes-commentary.patch
-O_DIRECT-race-fixes-fixes-2.patch
+O_DIRECT-race-fixes-rollup.patch
+O_DIRECT-race-fixes-rework-XFS-fix.patch

 Make the new O_DIRECT-vs-buffered locking code work.





All 137 patches


linus.patch

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

d-task-xid.patch
  virtualize access to uid, euid, ...

d-task-xid-fixes.patch

acpi-20030916.patch
  acpi-20030916

acpi_disabled-fix.patch
  acpi_disabled fix

acpi_off-fix.patch
  fix acpi=off

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

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

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

uml-update.patch
  Update UML to 2.6.0-test5

selectable-logbuf-size.patch
  boot-time selectable log buffer size

dscc4-warning-fixes.patch
  dscc4 warning fixes

serio-reconnect.patch
  serio reconnect

synaptics-reconnect.patch
  Synaptics reconnect

hugetlbfs_fill_super-leak-fix.patch
  Fix memory leak in hugetlbfs

com200020-request_region-fix.patch
  Fix double request_region in com20020

bin2c-copyrights.patch
  Add bin2c copyrights

CDROM_SEND_PACKET-fix.patch
  CDROM_SEND_PACKET fix

isdn_common-build-fix.patch
  Add missing label in isdn_common.c

dev_t-forward-compatibility.patch
  dev_t forward compatibility fix

smbfs-build-fix.patch
  smbfs build fix

fs-Kconfig-use-select.patch
  select for fs/Kconfig

mman-h-fix.patch
  x86 mman.h fix

flush-invalidate-fixes.patch
  memory writeback/invalidation fixes

flush-invalidate-fixes-doc-fixes.patch

ide_floppy-maybe-fix.patch
  might fix ide_floppy

pdflush-diag.patch

utime-on-immutable-file-fix-cleanup.patch

dgap.patch
  New DGAP driver

dgap-cleanups.patch
  dgap driver cleanups

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

futex-uninlinings.patch
  futex uninlining

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

befs-use-parser-update.patch

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

zap_page_range-debug.patch
  zap_page_range() debug

acpi-thinkpad-fix.patch
  APCI fix for thinkpads

readonly-bind-mounts.patch
  readonly mount --bind support

compat-ioctl-consolidation.patch
  compat ioctl consolidation

acpi-pci-irq-fix-439.patch
  YA APCI IRQ routing fix

module_parm_array-fix.patch
  module parameter array fixes

proc-sys-permission-checking.patch
  check permission in ->open for /proc/sys/

mtd-leak-fix.patch
  fix memleak in mtd/chips/cfi_cmdset_0020.c

selinux-convert_context-fix.patch
  Fix bug in SELinux convert_context

security_inode_permission-wants-nameidata.patch
  Pass nameidata to security_inode_permission hook

pnmtologo-warning-fix.patch
  scripts/pnmtologo.c warning fixes

befs-memleak-fix.patch
  befs: fix resource leak on register_filesystem failure

misc38.patch
  misc fixes

call_usermodehelper-retval-fix-2.patch
  Make call_usermodehelper report exit status

auxv2.patch
  /proc/PID/auxv file and NT_AUXV core note

psmouse_ipms2-option.patch
  Force mouse detection as imps/2 (and fix my KVM switch)

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
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework

O_DIRECT-race-fixes-rework-XFS-fix.patch
  O_DIRECT XFS fix

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



