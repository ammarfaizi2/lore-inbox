Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUAIJk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 04:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUAIJk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 04:40:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:20190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266450AbUAIJj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 04:39:29 -0500
Date: Fri, 9 Jan 2004 01:40:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.1-mm1
Message-Id: <20040109014003.3d925e54.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/


- A big ALSA update.

- Added support for kgdb on the x86_64 platform.  You'll need a couple of
  patches to gdb-6.0 itself to use it properly.  They may be found at

  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/gdb/gdb-6.0/

- Dropped the remap_file_pages() and prefault work - it is suspected of
  causing stability problems.

- The PCI IDE drivers should work as modules now.

- A significant update to the NFS client.

- A large s390 update.  Various device drivers and IO layer changes there.

  Note that the 's390' patches actually include significant core MM changes
  in the area of pte writeback/invalidate, rmap tweaks, etc.  Relevant
  patches are:

	s390-11-tlb-flush-optimisation.patch
	s390-12-dirty-referenced-bits.patch
	s390-13-tlb-flush-race-fix.patch
	s390-14-rmap-optimisation.patch
	s390-15-superfluous-flush_tlb_range-calls.patch
	s390-16-follow_page-lockup-fix.patch

- Merged the large SN2 update which Pat and Christoph have been discussing.





Changes since 2.6.1-rc2-mm1:


-ppc64-proc-fixes.patch
-ppc64-missing-section-definition.patch
-xfs-update-01.patch

 Merged

+alsa-101.patch

 ALSA update

+kgdb-x86_64-support.patch

 kgdb for x86_64

+uml-build-fix.patch

 Fix the build for UML.

+loop-fd-leak-fix.patch

 Fix file descriptior leak in loop_set_fd()

-sn-console-update.patch
-sn-serial-medusa-fix.patch

 Dropped - these are in the sn2 update, below.

+qla1280-build-fix.patch

 Fix qla1280-update-2.patch

-alsa-sleep-in-spinlock-fix.patch
-alsa-gus-scheduling-in-interrupt-fix.patch

 Now in the ALSA patch.

-68k-369.patch

 Greg had a few issues with this.

-set_cpus_allowed-locking-fix-fix.patch

 Folded into set_cpus_allowed-locking-fix.patch

-remap_file_pages-fixes-2.6.1-A3.patch
-remap_file_pages-prot-2.6.1-H2.patch
-prefault-2.6.0-A0.patch

 These seem to need a litle more work.

+do_no_page-leak-fix.patch

 Fix possible memleak in do_no_page()

+vt-locking-fixes-oops_in_progress-fix.patch

 Suppress warning about console_sem if we're processing an oops.

+drm-include-fix.patch

 Include headers from the right directory.

+kthread-primitive.patch
+use-kthread-primitives.patch

 Rusty's kthread abstraction.  Undecided as to whether we really want this,
 unless hotplug CPU is merged.

+check-for-truncated-modules.patch

 Sanity check for bad module files.

+forcedeth-v20.patch

 Update to the nForce ethernet driver

+alpha-module-relocation-overflow-fix.patch

 Fix module processing on Alpha

+eicon-memory-access-size-fix.patch

 Fix IO port access in this ISDN driver

+ppc32-of-bootwrapper-support.patch

 ppc32 Open Firmware stuff.

+lsi-megaraid-pci-id.patch

 Add a new PCI ID to this driver

+ide-pci-modules-fix.patch

 Maek IDE drivers work as modules.
 
+use-diff-dash-p.patch

 Start a fight over how patches should look.

+use-kconfig-range-for-NR_CPUS.patch

 Use the Kconfig `range' statement for specifying NR_CPUS

+sysfs-pin-kobject.patch

 sysfs oops fix

+bio-documentation-update.patch

 Docco

+nfs-fix-bogus-setattr-calls.patch
+nfs-optimise-COMMIT-calls.patch
+nfs-open-intent-fix.patch
+nfs-readonly-mounts-fix.patch
+nfs-client-deadlock-fix.patch
+nfs-rpc-debug-oops-fix.patch

 NFS update

+s390-01-base.patch
+s390-02-common-io-layer.patch
+s390-03-console-driver.patch
+s390-04-dasd-driver.patch
+s390-05-tape-driver.patch
+s390-06-network-drivers.patch
+s390-07-zfcp-host-adapter.patch
+s390-08-new-3270-driver.patch
+s390-09-32-bit-emulation-fixes.patch
+s390-10-32-bit-ioctl-emulation-fixes.patch
+s390-11-tlb-flush-optimisation.patch
+s390-12-dirty-referenced-bits.patch
+s390-13-tlb-flush-race-fix.patch
+s390-14-rmap-optimisation.patch
+s390-15-superfluous-flush_tlb_range-calls.patch
+s390-16-follow_page-lockup-fix.patch

 s390 and core MM work

+sn01.patch
+sn03.patch
+sn05.patch
+sn06.patch
+sn07.patch
+sn08.patch
+sn09.patch
+sn10.patch
+sn11.patch
+sn12.patch
+sn13.patch
+sn14.patch
+sn15.patch
+sn16.patch
+sn17.patch
+sn18.patch
+sn19.patch
+sn20.patch
+sn21.patch
+sn22.patch
+sn23.patch
+sn24.patch
+sn25.patch
+sn26.patch
+sn27.patch
+sn28.patch
+sn29.patch
+sn30.patch
+sn31.patch
+sn32.patch
+sn33.patch
+sn34.patch
+sn35.patch
+sn36.patch
+sn37.patch
+sn38.patch
+sn39.patch
+sn40.patch
+sn41.patch
+sn42.patch
+sn43.patch
+sn44.patch
+sn45.patch
+sn46.patch
+sn47.patch
+sn48.patch
+sn49.patch
+sn50.patch
+sn51.patch
+sn52.patch
+sn53.patch
+sn54.patch
+sn55.patch
+sn56.patch
+sn57.patch
+sn58.patch
+sn59.patch
+sn60.patch
+sn61.patch
+sn62.patch
+sn63.patch
+sn65.patch
+sn66.patch
+sn67.patch
+sn68.patch
+sn69.patch
+sn70.patch
+sn71.patch
+sn73.patch
+sn74.patch

 SN2 updates




All 393 patches

mm.patch
  add -mmN to EXTRAVERSION

alsa-101.patch
  ALSA 1.0.1

2.6.0-rc1-netdrvr-exp1.patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes

kgdb-doc-fix.patch
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-x86_64-support.patch
  kgdb for x86_64 2.6 kernels

uml-build-fix.patch
  Fix UML compilation breakage in fs/proc/task_mmu.c

radeon-line-length-fix.patch
  radeonfb line length fix

scsi-rename-TIMEOUT.patch
  fix scsi.h #define collision

loop-fix-hardsect.patch
  loop: fix hard sector size

loop-fd-leak-fix.patch
  loop: fix file refcount leak

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

RD1-open-mm.patch

RD2-release-mm.patch

RD3-presto_journal_close-mm.patch

RD4-f_mapping-mm.patch

RD5-f_mapping2-mm.patch

RD6-i_sem-mm.patch

RD7-f_mapping3-mm.patch

RD8-generic_osync_inode-mm.patch

RD9-bd_acquire-mm.patch

RD10-generic_write_checks-mm.patch

RD11-I_BDEV-mm.patch

cramfs-use-pagecache.patch
  cramfs: use pagecache better

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

net-jiffy-normalisation-fix.patch
  NET: Normalize jiffies reported to userspace, in neighbor management code

input-mousedev-remove-jitter.patch
  Input: smooth out mouse jitter

input-mousedev-ps2-emulation-fix.patch
  mousedev PS/@ emulation fix

input-01-i8042-suspend.patch
  input: i8042 suspend

input-02-i8042-option-parsing.patch
  input: i8042 option parsing

input-03-psmouse-option-parsing.patch
  input: psmouse option parsing

input-04-atkbd-option-parsing.patch
  input: atkbd option parsing

input-05-missing-module-licenses.patch
  input: missing module licenses

input-06-Kconfig-Synaptics-help.patch
  Kconfig Synaptics help

input-07-sis-aux-port.patch
  input: SiS AUX port

input-11-98busmouse-compile-fix.patch
  Fix compile error in 98busmouse.c module

input-12-mouse-drivers-use-module_param.patch
  Convert mouse drivers to use module_param

input-13-tsdev-use-module_param.patch
  Convert tsdev to use module_param

keyboard-repeat-fix.patch
  Fix key repeat problems

input-use-after-free-checks.patch
  input layer debug checks

cpu_sibling_map-fix.patch
  cpu_sibling_map fix

acpi-20031203.patch

acpi-20031203-fix.patch

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-syscall6-macro.patch
  add syscall6 macro to ppc64

ppc64-sched_clock-2.patch
  ppc64: add sched_clock

ppc64-32bit-compat-update.patch
  ppc64: 32bit compat update

ppc64-OF-device-tree-update.patch
  ppc64: Change to new OF device tree API

ppc64-numa-sign-extension-fix-2.patch
  ppc64: fix sign extension in numa code

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-IRQ_INPROGRESS-fix.patch
  ppc64: revert IRQ_INPROGRESS change

qla1280-update-2.patch
  qla1280 update

qla1280-build-fix.patch
  qla1280.c doesn't compile

sym-speed-fix.patch
  sym2 Ultra-160 fix

aic7xxx_old-proc-oops-fix.patch
  aic7x_old /proc oops fix

aic7xxx_old-oops-fix.patch

ramdisk-leak-fix.patch
  fix memory leak in ram disk

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

asus-L5-fix.patch
  Asus L5 framebuffer fix

jffs-use-daemonize.patch

get_user_pages-handle-VM_IO.patch

support-zillions-of-scsi-disks.patch
  support many SCSI disks

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

loop-bio-index-fix.patch
  loop bio indexing fix

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-clone.patch
  loop bio clone optimisation

loop-recycle.patch
  loop bio recycling optimisation

acpi-pm-timer.patch
  ACPI PM Timer

acpi-timer-fixes-A5.patch
  ACPI PM timer fixes

timer_pm-warning-fix.patch

as-regression-fix.patch
  Fix IO scheduler regression

as-request-poisoning.patch
  AS: request poisoning

as-request-poisoning-fix.patch
  AS: request poisining fix

as-fix-all-known-bugs.patch
  AS fixes

as-new-process-estimation.patch
  AS: new process estimation

as-cooperative-thinktime.patch
  AS: thinktime improvement

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

alpha-stack-dump.patch

sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
  sysfs_remove_dir Vs dcache_readdir race fix

invalidate_mmap_range-non-gpl-export.patch
  mark invalidate_mmap_range() as EXPORT_SYMBOL

sym2-speed-selection-fix.patch
  Speed selection fix for sym53c8xx

ppc-export-consistent_sync_page.patch
  PPC32: Export consistent_sync_page.

ppc-use-EXPORT_SYMBOL_NOVERS.patch
  PPC32: Change all EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL in ppc_ksyms.c

ppc-CONFIG_PPC_STD_MMU-fix.patch
  PPC32: Select arch/ppc/kernel/head.S on CONFIG_PPC_STD_MMU.

ppc-IBM-MPC-header-cleanups.patch
  PPC32: Minor cleanups to IBM4xx and MPC82xx headers.

percpu-gcc-34-warning-fix.patch
  fix gcc-3.4 warning in percpu code

nr_requests-oops-fix.patch
  Fix oops when modifying /sys/block/dm-0/queue/nr_requests

netfilter_bridge-compile-fix.patch

aacraid-warning-fix.patch
  aacraid warning fix

atapi-mo-support.patch
  ATAPI MO drive support

mt-ranier-support.patch
  mt rainier support

atapi-mo-support-update.patch
  ATAPI MO support update
  cdrom_open fix

ppp_async-locking-fix.patch
  Make ppp_async callable from hard interrupt

make-try_to_free_pages-walk-zonelist.patch
  make try_to_free_pages walk zonelist

make-try_to_free_pages-walk-zonelist-fix.patch
  zone scanning fix

remove-CardServices-from-pcmcia-net-drivers.patch
  CardServices() removal from pcmcia net drivers

remove-CardServices-from-ide-cs.patch
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: [PATCH 1/10] CardServices() removal from pcmcia net drivers

remove-CardServices-from-drivers-net-wireless.patch
  remove CardServices() from drivers/net/wireless

remove-CardServices-from-drivers-serial.patch
  Remvoe CardServices() from drivers/serial

remove-CardServices-from-drivers-serial-fix.patch
  serial_cs CardServices removal fix

remove-CardServices-from-axnet_cs.patch
  remvoe CardServices from axnet_cs

remove-CardServices-final.patch
  final CardServices() removal patches

CardServices-compatibility-layer.patch
  CardServices compatibility layer

sysfs-add-simple-class-device-support.patch
  sysfs: add "simple" class device support

sysfs-remove-tty-class-device-logic.patch
  sysfs: remove tty class device logic

sysfs-add-mem-device-support.patch
  sysfs: add mem class

sysfs-add-misc-class.patch
  sysfs: add misc class

vc-init-race-fix.patch
  virtual consle initialisation race fix

sysfs-add-video-class.patch
  sysfs: add video class

sysfs-add-oss-class.patch
  sysfs sound class patch for OSS drivers

sysfs-add-alsa-class.patch
  sysfs sound class patch for ALSA drivers

sysfs-add-input-class-support.patch
  sysfs: input class patch

tridentfb-non-flatpanel-fix.patch
  fix for tridentfb.c usage on CRTs.

CONFIG_EPOLL-file_struct-members.patch
  CONFIG_EPOLL=n space reduction

epoll-oneshot-support.patch
  One-shot support for epoll

kill_fasync-speedup.patch
  kill_fasync speedup

o21-sched.patch
  O21 for interactivity 2.6.0

sched-clock-2.6.0-A1.patch
  Relax synchronization of sched_clock()

sched-can-migrate-2.6.0-A2.patch
  can_migrate_task cleanup

sched-cleanup-2.6.0-A2.patch
  CPU scheduler cleanup

sched-style-2.6.0-A5.patch
  sched.c style cleanups

decrypt-CONFIG_PDC202XX_FORCE-help.patch
  Change cryptic description and help for CONFIG_PDC202XX_FORCE

ide-siimage-seagate.patch

ide-siimage-stack-fix.patch

ide-siimage-sil3114.patch

ide-pdc_old-pio-fix.patch

ide-pdc_old-udma66-fix.patch

ide-pdc_old-66mhz_clock-fix.patch

ide-pdc_new-proc.patch

make-for_each_cpu-iterator-more-friendly.patch
  Make for_each_cpu() Iterator More Friendly

make-for_each_cpu-iterator-more-friendly-fix.patch
  Fix alpha build failure

use-for_each_cpu-in-right-places.patch
  Use for_each_cpu() Where It's Meant To Be

for_each_cpu-oprofile-fix.patch
  for_each_cpu oprofile fix

for_each_cpu-oprofile-fix-2.patch

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

kernel-locking-doc-end-tags-fix.patch
  Missing end tags in kernel-locking kerneldoc

rcupdate-c99-initialisers.patch
  C99 change to rcupdate.h

68k-339.patch
  M68k floppy selection

68k-340.patch
  M68k head console

68k-341.patch
  M68k head unused

68k-342.patch
  M68k head comments

68k-343.patch
  M68k head pic

68k-344.patch
  M68k head white space

68k-345.patch
  M68k cache mode

68k-346.patch
  M68k RMW accesses

68k-347.patch
  Atari Hades PCI C99

68k-348.patch
  Amiga sound C99

68k-349.patch
  BVME6000 RTC C99

68k-350.patch
  M68k symbol exports

68k-351.patch
  M68k math emu C99

68k-352.patch
  MVME16x RTC C99

68k-353.patch
  Q40 interrupts C99

68k-354.patch
  Sun-3 ID PROM C99

68k-355.patch
  Mac ADB IOP fix

68k-359.patch
  Mac ESP SCSI setup

68k-360.patch
  Mac SCSI

68k-361.patch
  Macfb setup

68k-364.patch
  Mac ADB

68k-365.patch
  ncr53c7xx SCSI

68k-366.patch
  BVME6000 SCSI

68k-367.patch
  Amiga Gayle IDE cleanup

68k-368.patch
  Amiga Gayle E-Matrix 530 IDE

68k-374.patch
  Amiga debug fix

68k-375.patch
  Mac II VIA

68k-377.patch
  M68k asm/system.h

68k-378.patch
  Amiga NCR53c710 SCSI

68k-379.patch
  Amiga core C99

68k-380.patch
  M68k has no VGA/MDA

68k-381.patch
  M68k thread

68k-382.patch
  M68k thread_info

68k-383.patch
  M68k extern inline

68k-384.patch
  NCR53C9x SCSI inline

68k-385.patch
  Cirrusfb extern inline

68k-386.patch
  Genrtc warning

68k-387.patch
  M68k Documentation

68k-390.patch
  Amiga Buddha/CatWeasel IDE

printk_ratelimit.patch
  generalise net_ratelimit (printk_ratelimit)

printk_ratelimit-fix.patch
  parintk_ratelimit fix

freevxfs-MODULE_ALIAS.patch
  MODULE_ALIAS for freevxfs

trident-cleanup-indentation-D1-2.6.0.patch
  reindent trident OSS sound driver

trident-sound-driver-fixes.patch
  trident OSS sound driver fixes

trident-cleanup-2.patch
  trident: use pr_debug instead of home-brewed TRDBG

compound-page-page_count-fix.patch
  fix page counting for compound pages

inia100-fix.patch
  fix inia100 driver

MAINTAINERS-lanana-update.patch
  MAINTAINERS update

devfs-joystick-fix.patch
  fix devfs names for joystick

s3-sleep-remove-debug-code.patch
  s3 sleep: Kill obsolete debugging code

swsusp-doc-updates.patch
  swsusp/sleep documentation update

watchdog-updates.patch
  Watchdog patches

watchdog-updates-2.patch
  Watchdog patches (part 2)

ext2_new_inode-cleanup.patch
  ext2_new_inode nanocleanup

ext2-s_next_generation-fix.patch
  ext2: s_next_generation locking

ext3-s_next_generation-fix.patch
  ext3: s_next_generation fixes

alt-arrow-console-switch-fix.patch
  Fix Alt-arrow console switch droppage

ia32-remove-SIMNOW.patch
  Remove x86_64 leftover SIMNOW code

softcursor-fix.patch
  Fix softcursor

ext2-debug-build-fix.patch
  ext2: fix build when EXT2_DEBUG is set

efi-inline-fixes.patch
  Fix weird placement of inline

do_timer_gettime-cleanup.patch
  do_timer_gettime() cleanup

set_cpus_allowed-locking-fix.patch
  set_cpus_allowed locking
  fix set_cpus_allowed locking even more

rmmod-race-fix.patch
  module removal race fix

remove-hpet-intel-check.patch
  Remove Intel check in i386 HPET code

devfs-d_revalidate-oops-fix.patch
  devfs d_revalidate race/oops fix

laptop-mode-2.patch
  laptop-mode for 2.6, version 6

laptop-mode-doc-update.patch
  Documentation/laptop-mode.txt

e1000-1019-fix.patch
  e1000: device 1019 fix

ali-m1533-hang-fix.patch
  ALI M1533 audio hang fix

start_this_handle-retval-fix.patch
  jbd: start_this_handle() return value fix

remove-eicon-isdn-driver.patch
  remove old Eicon isdn driver

do_no_page-leak-fix.patch
  do_no_page leak fix

vt-locking-fixes.patch
  VT locking fixes

vt-locking-fixes-warning-fix.patch

vt-locking-fixes-oops_in_progress-fix.patch

pid_max-fix.patch
  Bug when setting pid_max > 32k

allow-SGI-IOC4-chipset-support.patch
  allow SGI IOC4 chipset support

oss-dmabuf-deadlock-fix.patch
  OSS dmabuf deadlock fix

workqueue-cleanup.patch
  Remove redundant code in workqueue.c

libata-update.patch
  update libata

tridentfb-documentation-fix.patch
  tridentfb documentation fix

proc_pid_lookup-speedup.patch
  Optimize proc_pid_lookup

bio_endio-clarifications.patch
  clarify meaning of bio fields in the end_io function

rtc-leak-fixes.patch
  2.6.1 RTC leaks.

simplify-node-zone-fields-3.patch
  Simplify node/zone field in page->flags

r8169-oops-fix.patch
  erroneous __devinitdata in the r8169 driver

radeonfb-pdi-id-addition.patch
  Identify RADEON Yd in radeonfb

mpt-fusion-update.patch
  MPT Fusion driver 3.00.00 update

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

raid6-20040107.patch
  RAID-6

kthread-primitive.patch
  kthread primitive

use-kthread-primitives.patch
  Use kthread primitives

check-for-truncated-modules.patch
  check for truncated modules

forcedeth-v20.patch
  forcedeth: v20

alpha-module-relocation-overflow-fix.patch
  Relocation overflow with modules on Alpha

eicon-memory-access-size-fix.patch
  Eicon isdn driver hardware access fix

ppc32-of-bootwrapper-support.patch
  ppc32: OF bootwrapper support

lsi-megaraid-pci-id.patch
  LSI Logic MegaRAID3 PCI ID

ide-pci-modules-fix.patch
  fix issues with loading PCI IDE drivers as modules

use-diff-dash-p.patch
  Fix Documentation/SubmittingPatches to use -p

use-kconfig-range-for-NR_CPUS.patch
  Kconfig: use range for NR_CPUS

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

bio-documentation-update.patch
  bio documentation update

nfs-fix-bogus-setattr-calls.patch
  NFS: fix bogus setattr calls

nfs-optimise-COMMIT-calls.patch
  nfs: Optimize away unnecessary NFSv3 COMMIT calls.

nfs-open-intent-fix.patch
  nfs: Fix an open intent bug

nfs-readonly-mounts-fix.patch
  nfs: Fix readonly mounts

nfs-client-deadlock-fix.patch
  nfs: Fix a possible client deadlock

nfs-rpc-debug-oops-fix.patch
  nfs: Fix an Oops in the RPC debug code...

m68knommu-module-support.patch
  allow for building module support for m68knommu architecture

m68knommu-module-support-2.patch
  add module support for m68knommu architecture

m68knommu-sched_clock.patch
  sched_clock() for m68knommu architectures

m68knommu-include-fix.patch
  m68knommu include fix

m68knommu-cpustats-fix.patch
  fix cpu stats in m68knommu entry.S

m68knommu-types-cleanup.patch
  use m68k/types.h for m68knommu

m68knommu-find_extend_vma.patch
  implement find_extend_vma() for nommu

s390-01-base.patch
  s390: general update

s390-02-common-io-layer.patch
  s390: common i/o layer

s390-03-console-driver.patch
  s390: console driver.

s390-04-dasd-driver.patch
  s390: dasd driver

s390-05-tape-driver.patch
  s390: tape driver.

s390-06-network-drivers.patch
  s390: network drivers

s390-07-zfcp-host-adapter.patch
  s390: zfcp host adapter

s390-08-new-3270-driver.patch
  s390: new 3270 driver.

s390-09-32-bit-emulation-fixes.patch
  s390: 32 bit emulation fixes.

s390-10-32-bit-ioctl-emulation-fixes.patch
  s390: 32 bit ioctl emulation fixes.

s390-11-tlb-flush-optimisation.patch
  s390: tlb flush optimization.

s390-12-dirty-referenced-bits.patch
  s390: physical dirty/referenced bits.

s390-13-tlb-flush-race-fix.patch
  s390: tlb flush race.

s390-14-rmap-optimisation.patch
  s390: rmap optimization.

s390-15-superfluous-flush_tlb_range-calls.patch
  s390: superflous flush_tlb_range calls.

s390-16-follow_page-lockup-fix.patch
  s390: endless loop in follow_page.

const-fixes.patch
  const vs. __attribute__((const)) confusion

sn01.patch
  sn: Some hwgraph code clean up

sn03.patch
  sn: copyright update

sn05.patch
  sn: namespace cleanup: ioerror_dump->sn_ioerror_dump

sn06.patch
  sn: kill big endian stuff

sn07.patch
  sn: kill $Id$

sn08.patch
  sn: remove unused enum

sn09.patch
  From: Pat Gefre <pfg@sgi.com>
  Subject: Re: [PATCH] Updating our sn code in 2.6] - Patch 009

sn10.patch
  sn: Kill nag.h

sn11.patch
  sn: Kill the arcs/*.h files

sn12.patch
  sn: Delete invent.h

sn13.patch
  sn: General code clean up of sn/io/io.c

sn14.patch
  sn: machvec/pci.c clean up

sn15.patch
  sn: General clean up of xbow.c

sn16.patch
  sn: Remove the bridge and xbridge code - everything not PIC

sn17.patch
  sn: Fix the last patch - missed an IS_PIC_SOFT and needed the CG definition

sn18.patch
  sn: Fix the last patch - missed an IS_PIC_SOFT and needed the CG definition

sn19.patch
  sn: New code for Opus and CGbrick

sn20.patch
  sn: klgraph.c clean up

sn21.patch
  sn: More klgraph.c clean up

sn22.patch
  sn: General module.c clean up

sn23.patch
  sn: shubio.c cleanup

sn24.patch
  sn: General xtalk.c clean up

sn25.patch
  sn: irq clean up and update

sn26.patch
  sn: code pruning - a couple of adds due to the clean up

sn27.patch
  sn: Fix a couple of compiler warnings

sn28.patch
  sn: hcl.c clean up for init failures and OOM

sn29.patch
  sn: Some small bte code clean ups

sn30.patch
  sn: Moved code out of pciio and into its own file - snia_if.c and renamed the functions

sn31.patch
  sn: A few small clean ups

sn32.patch
  sn: Some more minor clean up

sn33.patch
  sn: Remove __ASSEMBLY__ tags from shubio.h

sn34.patch
  sn: Small check for invalid node in shub ioctl function

sn35.patch
  sn: More code clean up - this time ioconfig_bus.c

sn36.patch
  sn: Code changes for interrupt redirect

sn37.patch
  sn: Forget to check in the _reg file

sn38.patch
  sn: Merged 2 files into another (sgi_io_sim and irix_io_init into sgi_io_init)

sn39.patch
  sn: Support for the LCD

sn40.patch
  sn: Missed an include file in the last patch

sn41.patch
  sn: One less panic

sn42.patch
  sn: SAL interface clean up

sn43.patch
  sn: Fixes for shuberror.c

sn44.patch
  sn: Need a bigger max compact node value

sn45.patch
  sn: Use numionodes

sn46.patch
  sn: Change the definition and usage of iio_itte - make it an array

sn47.patch
  sn: Debug clean up in pcibr_dvr.c

sn48.patch
  sn: New pci provider interfaces

sn49.patch
  sn: Fix IIO_ITTE_DISABLE() args

sn50.patch
  sn: Added a missed opus mod and oom mod

sn51.patch
  sn: Added cbrick_type_get_nasid() function

sn52.patch
  sn: Clean up the bit twiddle macros in pcibr_config.c

sn53.patch
  sn: Fixed an oom in pci_bus_cvlink.c

sn54.patch
  sn: Remove the pcibr_wrap... functions

sn55.patch
  sn: printk cleanup

sn56.patch
  sn: pci dma cleanup

sn57.patch
  sn: Make pcibr debug variables static

sn58.patch
  sn: Include file clean up in pcibr_hints.c

sn59.patch
  sn: Added call to pcireg_intr_status_get

sn60.patch
  sn: More code clean up = mostly pcibr_slot.c

sn61.patch
  sn: pcibr_rrb.c cleanup

sn62.patch
  sn: Minor code clean up of pcibr_error.c

sn63.patch
  sn: sn_pci_fixup() clean up or is it fix up ???

sn65.patch
  sn: Remove irix_io_init - replace with sgi_master_io_infr_init

sn66.patch
  sn: Don't call init_hcl from the fixup code

sn67.patch
  sn: Error devenable not used - delete defs

sn68.patch
  sn: Delete unused code in pcibr_slot.c

sn69.patch
  sn: Delete unused pciio.c code (???_host???_[sg]et)

sn70.patch
  sn: Minor clean up for ml_iograph.c

sn71.patch
  sn: Simulator check in pci_bus_cvlink.c

sn73.patch
  sn: Mostly printk clean up and remove some dead code

sn74.patch
  sn: A little re-formatting

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

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
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework
  O_DIRECT XFS fix

dio-aio-fixes.patch
  direct-io AIO fixes
  dio-aio fix fix

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-sysctl-parms.patch
  aio sysctl parms

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL
  AIO: flush workqueues before destroying ioctx'es
  AIO: hold the context lock across unuse_mm
  task task_lock in use_mm()

4g4g-aio-hang-fix.patch
  Fix AIO and 4G-4G hang

aio-retry-elevated-refcount.patch
  aio: extra ref count during retry

aio-splice-runlist.patch
  Splice AIO runlist for fairer handling of multiple io contexts

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



