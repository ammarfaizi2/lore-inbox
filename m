Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTJBJWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 05:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbTJBJWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 05:22:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:14226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263315AbTJBJWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 05:22:23 -0400
Date: Thu, 2 Oct 2003 02:23:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test6-mm2
Message-Id: <20031002022341.797361bc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm2/

. A large series of VFS patches from Al Viro which replace usage of
  file->f_dentry->d_inode->i_mapping with the new file->f_mapping.

  This is mainly so we can get disk hot removal right.

. More work on the O_DIRECT-vs-buffered data coherency problem.  It's
  still not quite there.




Changes since 2.6.0-test6-mm1:


 linus.patch

 Latest Lius tree

-acpi-20030916.patch
-acpi_disabled-fix.patch
-dscc4-warning-fixes.patch
-serio-reconnect.patch
-synaptics-reconnect.patch
-hugetlbfs_fill_super-leak-fix.patch
-com200020-request_region-fix.patch
-bin2c-copyrights.patch
-CDROM_SEND_PACKET-fix.patch
-isdn_common-build-fix.patch
-dev_t-forward-compatibility.patch
-smbfs-build-fix.patch
-fs-Kconfig-use-select.patch
-mman-h-fix.patch
-flush-invalidate-fixes.patch
-flush-invalidate-fixes-doc-fixes.patch
-ide_floppy-maybe-fix.patch
-ali14xx-update.patch
-dtc2278-update.patch
-ht6560b-update.patch
-qd65xx-update.patch
-umc8672-update.patch
-filesystem-option-parsing.patch
-filesystem-option-parsing-tweaks.patch
-filesystem-option-parsing-fixes.patch
-filesystem-option-parsing-no-alloca.patch
-befs-use-parser.patch
-befs-use-parser-update.patch
-acpi-pci-irq-fix-439.patch
-module_parm_array-fix.patch
-proc-sys-permission-checking.patch
-mtd-leak-fix.patch
-selinux-convert_context-fix.patch
-security_inode_permission-wants-nameidata.patch
-pnmtologo-warning-fix.patch
-befs-memleak-fix.patch
-misc38.patch
-auxv2.patch

 Merged

-d-task-xid.patch
-d-task-xid-fixes.patch

 Dropped: not the way linus wants it done

+RD0-initrd-B6.patch
+RD1-cdrom_ioctl-B6.patch
+RD2-ioctl-B6.patch
+RD3-cdrom_open-B6.patch
+RD4-open-B6.patch
+RD5-cdrom_release-B6.patch
+RD6-release-B6.patch
+RD7-presto_journal_close-B6.patch
+RD8-f_mapping-B6.patch
+RD9-f_mapping2-B6.patch
+RD10-i_sem-B6.patch
+RD11-f_mapping3-B6.patch
+RD12-generic_osync_inode-B6.patch
+RD13-bd_acquire-B6.patch
+RD14-generic_write_checks-B6.patch
+RD15-I_BDEV-B6.patch
+RD16-rest-B6.patch

 f_mapping rework

+serio-01-renaming.patch
+serio-02-race-fix.patch
+serio-03-blacklist.patch
+serio-04-synaptics-cleanup.patch
+serio-05-reconnect-facility.patch
+serio-06-synaptics-use-reconnect.patch

 Input device things

+radeonfb-line_length-fix.patch

 Radeon fix

+8139too-edimax.patch

 New 8139too PCI ID

+futex_refs_and_lock_fix.patch

 Futex locking fix

-do_no_page-debug.patch

 This was a ppc64 bug...

-reenable-athlon-prefetch.patch

 Dropped for now.

-call_usermodehelper-retval-fix-2.patch
+call_usermodehelper-retval-fix-3.patch

 Fixed, we hope.

+alsa-gameport-fix.patch

 Lame ALSA config fix

+scsi-handle-zero-length-requests.patch

 SCSI fix

+sizeof-in-ioctl-fix.patch

 Probably wrong fix for a few compat ioctls

+asus-L5-fix.patch

 Fix radeonfb on Asus L% laptop

+bonding-ioctl-fix.patch

 compat ioctl fixes

+ax25-timer-cleanup.patch

 ax25 protocol timer cleanups

+jffs-use-daemonize.patch

 Don't open-code daemonize() guts in jffs

-psmouse_ipms2-option.patch

 This got broken.

+keyboard-repeat-rate-setting-fix.patch

 Fix for AT keyboard repeat rate changing

+show_task-on-runqueue.patch

 Teach sysrq-T to displayu which tasks actually have the CPU

+aio-refcounting-fix.patch

 AIO use-after-free fix

+O_SYNC-speedup-2-f_mapping-fixes.patch
+aio-09-o_sync-f_mapping-fixes.patch
+aio-12-readahead-f_mapping-fix.patch

 Fix AIO patches for f_mapping rework

-aio-10-BUG-fix.patch
-aio-11-workqueue-flush.patch
-lock_buffer_wq-fix.patch
-unuse_mm-locked.patch
-aio-take-task_lock.patch
-aio-O_SYNC-fix.patch
-aio-readahead-rework.patch
-aio-osync-fix-2.patch

 Various patches rolled into other patches






All 125 patches


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

RD0-initrd-B6.patch

RD1-cdrom_ioctl-B6.patch

RD2-ioctl-B6.patch

RD3-cdrom_open-B6.patch

RD4-open-B6.patch

RD5-cdrom_release-B6.patch

RD6-release-B6.patch

RD7-presto_journal_close-B6.patch

RD8-f_mapping-B6.patch

RD9-f_mapping2-B6.patch

RD10-i_sem-B6.patch

RD11-f_mapping3-B6.patch

RD12-generic_osync_inode-B6.patch

RD13-bd_acquire-B6.patch

RD14-generic_write_checks-B6.patch

RD15-I_BDEV-B6.patch

RD16-rest-B6.patch

serio-01-renaming.patch
  serio: rename serio_[un]register_slave_port to __serio_[un]register_port

serio-02-race-fix.patch
  serio: possible race between port removal and kseriod

serio-03-blacklist.patch
  Add black list to handler<->device matching

serio-04-synaptics-cleanup.patch
  Synaptics: code cleanup

serio-05-reconnect-facility.patch
  serio: reconnect facility

serio-06-synaptics-use-reconnect.patch
  Synaptics: use serio_reconnect

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

radeonfb-line_length-fix.patch
  From: Peter Chubb <peter@chubb.wattle.id.au>
  Subject: Radeon framebuffer problems i 2.6.0-test6

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

uml-update.patch
  Update UML to 2.6.0-test5

selectable-logbuf-size.patch
  boot-time selectable log buffer size

8139too-edimax.patch

pdflush-diag.patch

utime-on-immutable-file-fix-cleanup.patch

dgap.patch
  New DGAP driver

dgap-cleanups.patch
  dgap driver cleanups

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

futex_refs_and_lock_fix.patch
  futex locking fix

futex-uninlinings.patch
  futex uninlining

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

zap_page_range-debug.patch
  zap_page_range() debug

acpi-thinkpad-fix.patch
  APCI fix for thinkpads

readonly-bind-mounts.patch
  readonly mount --bind support

compat-ioctl-consolidation.patch
  compat ioctl consolidation

alsa-gameport-fix.patch
  ALSA pci Kconfig fix

scsi-handle-zero-length-requests.patch
  scsi: handle zero-length requests

sizeof-in-ioctl-fix.patch
  incorrect use of sizeof() in aty128fb

call_usermodehelper-retval-fix-3.patch
  Make call_usermodehelper report exit status

asus-L5-fix.patch
  Asus L5 framebuffer fix

bonding-ioctl-fix.patch
  ioctl32 fix for bond_ioctl()

ax25-timer-cleanup.patch
  X25 timer cleanup

jffs-use-daemonize.patch

keyboard-repeat-rate-setting-fix.patch
  keyboard repeat rate setting fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch
  print a few config options on oops

show_task-free-stack-fix.patch
  show_task() fix and cleanup

show_task-on-runqueue.patch
  show the running task in show_task()

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
  AIO: flush workqueues before destroying ioctx'es
  AIO: hold the context lock across unuse_mm
  task task_lock in use_mm()

aio-refcounting-fix.patch
  aio ref count in io_submit_one

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait
  lock_buffer_wq fix

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

O_SYNC-speedup-2-f_mapping-fixes.patch

aio-09-o_sync.patch
  aio O_SYNC
  AIO: fix a BUG
  Unify o_sync changes for aio and regular writes
  aio-O_SYNC-fix bits got lost
  aio: writev nr_segs fix
  More AIO O_SYNC related fixes

aio-09-o_sync-f_mapping-fixes.patch

gang_lookup_next.patch
  Change the page gang lookup API

aio-gang_lookup-fix.patch
  AIO gang lookup fixes

aio-O_SYNC-short-write-fix.patch
  Fix for O_SYNC short writes

aio-12-readahead.patch
  AIO: readahead fixes
  aio O_DIRECT no readahead
  Unified page range readahead for aio and regular reads

aio-12-readahead-f_mapping-fix.patch

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



