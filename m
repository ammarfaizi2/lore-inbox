Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVHBFIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVHBFIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVHBFIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:08:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261379AbVHBFHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:07:53 -0400
Date: Mon, 1 Aug 2005 22:07:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.13-rc5
Message-ID: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, one more in the series towards final 2.6.13.

This one is small enough that both shortlog and diffstat fit comfortably:  
no big architecture updates or anything like that. Some input, x86-64 and
ppc updates, and various fairly small fixes in random places.

Some reverts back to 2.6.12 behaviour - you've seen the discussions, and
I'm sure we'll end up discussing things further for a long while still,
but the plan is to release 2.6.13 with known behaviour characteristics. 

Give it a good testing, I'm hoping this can really turn into 2.6.13.

		Linus

---

Adam Kropelin:
  Input: HID - only report events coming from interrupts to hiddev

Adrian Bunk:
  include/linux/dcookies.h: dummy functions must be "static inline"
  SCSI_SATA has to be a tristate
  USB: drivers/usb/net/: remove two unused multicast_filter_limit variables
  DEBUG_FS must depend on SYSFS

Alan Stern:
  USB: Usbcore: Don't try to delete unregistered interfaces
  USB: usbfs: Don't leak uninitialized data

Alasdair G Kergon:
  device-mapper: fix md->lock deadlocks in core
  device-mapper: fix deadlocks in core
  device-mapper: fix deadlocks in core (prep)

Alexander Nyberg:
  x86_64: cpu hotplug changes kills nmi watchdog

Alexey Kuznetsov:
  [NET]: fix oops after tunnel module unload

Andi Kleen:
  x86_64: Remove unused variable in k8-bus.c
  x86_64: Fix SRAT handling on non dual core systems
  x86_64: Switch to the interrupt stack when running a softirq in local_bh_enable()
  x86_64: Small assembly improvements
  x86_64: Remove unnecessary include in fault.c
  x86_64: When running cpuid4 need to run on the correct CPU
  x86_64: Turn BUG data into valid instruction
  x86_64: Support more than 8 cores on AMD systems
  x86_64: Remove the broadcast options that were added for cpuhotplug
  x86_64: Remove IA32_* build tools in Makefile
  x86_64: Create per CPU machine check sysfs directories
  x86_64: Print a boot message for hotplug memory zones
  x86_64: Fix incorrectly defined MSR_K8_SYSCFG
  x86_64: Fix some typos in system.h comments
  x86_64: Remove obsolete eat_key prototype
  x86_64: Fix some comments in tlbflush.h
  x86_64: Some updates for boot-options.txt
  x86_64: Improve CONFIG_GART_IOMMU description and make it default y
  x86_64: Remove unused variable in delay.c
  x86_64: Some cleanup in setup64.c
  x86_64: Clarify Booting processor ... message
  x86_64: Minor clean up to CPU setup - use smp_processor_id instead of custom hack
  x86_64: Move cpu_present/possible_map parsing earlier
  x86_64: i386/x86_64: remove prototypes for not existing functions in smp.h
  x86_64: Use for_each_cpu_mask for clustered IPI flush
  x86_64: Update defconfig
  x86_64: Always ack IPIs even on errors

Andreas Gruenbacher:
  x86_64: Icecream has no way of detecting assembler-level includes

Andrew Morton:
  shm: CONFIG_SHMEM=n build fix
  transmeta: CONFIG_PROC_FS=n build fix
  skge build fix
  i2c-mpc.c: revert duplicate patch
  revert bogus softirq changes
  Input: cannot refer to __exit from within __init.

Anton Blanchard:
  ppc64: topology API fix

Antonino A. Daplas:
  tridentfb: Fix scrolling artifacts during disk IO
  tridentfb: Fix scrolling artifacts if acceleration is enabled
  vesafb: Document mtrr boot option usage
  fbdev: Replace memcpy with for-loop when preparing bitmap
  vesafb: Fix mtrr bugs

Baruch Even:
  [NET]: Spelling mistakes threshoulds -> thresholds

Ben Dooks:
  USB: add S3C24XX USB Host driver support

Benjamin Herrenschmidt:
  ppc64: Fix CONFIG_ALTIVEC not set

Bjorn Helgaas:
  serial: add MMIO support to 8250_pnp

Bodo Stroesser:
  uml: Fix typo
  uml: Fix skas0 stub return

Christophe Lucas:
  uml: Clean up prink calls

Conger, Chris A:
  USB: fix Bug in usb-skeleton.c

Cornelia Huck:
  s390: device recognition

Dan Streetman:
  USB: fix in usb_calc_bus_time

Daniel Walker:
  stable_api_nonsense.txt fixes

Daniele Gaffuri:
  PCI: Hidden SMBus bridge on Toshiba Tecra M2

Dave Hansen:
  re-disable TSC on NUMAQ

Dave Jones:
  arch/i386/kernel/cpu/cpufreq/powernow-k8.c: In function `powernow_k8_cpu_init_acpi':
  Fix up powernow-k8 compile. (Missing definitions).
  powernow-k8.c: In function `query_current_values_with_pending_wait':
  Here are two possible cleanups in cpufreq.c:
  Opteron revision F will support higher frequencies than
  powernow-k8 requires that a data structure for

Dave Peterson:
  x86_64: fix bug in csum_partial_copy_generic()

David Moore:
  Input: ALPS - fix resume (for DualPoints)

David S. Miller:
  [NET]: Fix busy waiting in dev_close().

David Shaohua Li:
  [ACPI] suspend/resume ACPI PCI Interrupt Links
  [ACPI] address boot-freeze with updated DMI blacklist for c-states

Denis Lunev:
  [NET] Fix too aggressive backoff in dst garbage collection

Denis Vlasenko:
  silence cs89x0

Dmitry Torokhov:
  Input: i8042 - don't use negation to mark AUX data
  Input: i8042 - add Alienware Sentia to NOMUX blacklist.
  Input: serio_raw - link serio_raw misc device to corresponding
  Merge rsync://www.kernel.org/.../torvalds/linux-2.6
  Input: make name, phys and uniq be 'const char *' because once
  Input: rearrange procfs code to reduce number of #ifdefs
  Sonypi: make sure that input_work is not running when unloading
  Input: introduce usb_to_input_id() to uniformly produce
  Input: acecad - drop unneeded cast and couple unneeded spaces.
  Input: serio - add modalias attribute and environment variable to
  Input: uinput - use completions instead of events and manual
  Input: clean up uinput driver (formatting, extra braces)

Dominik Brodowski:
  pcmcia: fix multiple insertion of multifunction cards
  pcmcia: defer ide-cs initialization after other IDE drivers started up
  [ACPI] Always set P-state on initialization

Eric Dumazet:
  sys_set_mempolicy() doesnt check if mode < 0

Eric Lammerts:
  disable addres space randomization default on transmeta CPUs

Eric W. Biederman:
  Fix sync_tsc hang
  x86_64 machine_kexec: Use standard pagetable helpers
  x86_64 machine_kexec: Cleanup inline assembly.
  i386 machine_kexec: Cleanup inline assembly
  reboot: remove device_suspend(PMSG_FREEZE) from kernel_kexec

Eugene Surovegin:
  ppc32: add missing 4xx EMAC sysfs nodes
  ppc32: fix 44x early serial debug for configurations with more than 512M of RAM

Evgeniy Polyakov:
  w1: kconfig/Makefile fix.

George Anzinger:
  posix timers: fix normalization problem

Gerald Schaefer:
  s390: fix inline assembly in appldata

Greg Felix:
  libata: Check PCI sub-class code before disabling AHCI

Greg Kroah-Hartman:
  Add the rules about the -stable kernel releases to the Documentation directory

Harald Welte:
  [NETFILTER] Inherit masq_index to slave connections

Heiko Carstens:
  s390: kexec fixes and improvements.
  s390: check for interrupt before waiting

Hirokazu Takata:
  m32r: Fix local-timer event handling

Hugh Dickins:
  x86_64: access of some bad address

Ian Abbott:
  USB: ftdi_sio: fix a couple of timeouts
  USB: ftdi_sio: Update RTS and DTR simultaneously
  USB: ftdi_sio: new microHAM and Evolution Robotics devices

Ingo Molnar:
  remove sys_set_zone_reclaim()

Ivan Kokshaysky:
  PCI: remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c

James Simmons:
  Display name of fbdev device

Jay Vosburgh:
  bonding: documentation update

Jean Delvare:
  I2C: 24RF08 corruption prevention (again)
  I2C: missing new lines in i2c-core messages
  I2C: use time_after in 3 chip drivers
  I2C: Missing space in split strings

Jeff Dike:
  uml: fix vsyscall brokenness
  uml: Fix load average >=1
  uml: Fix redundant assignment
  uml: vm86 compile fix
  uml: fix TT mode by reverting "use fork instead of clone"

Jesse Millan:
  x86_64: Fix gcc 4 warning in sched_find_first_bit

John McCutchan:
  inotify: fix race between the kernel and user space
  inotify: fix file deletion by rename detection

Jon Smirl:
  PCI: Adjust PCI rom code to handle more broken ROMs
  fbdev: colormap fixes fix

Keith Mannthey:
  x86_64: Fix overflow in NUMA hash function setup

Kumar Gala:
  ppc32: Mark boards that don't build as BROKEN
  PCI: fix up errors after dma bursting patch and CONFIG_PCI=n -- bug?
  I2C-MPC: Restore code removed

Ladislav Michl:
  I2C: ds1337 - fix 12/24 hour mode bug

Len Brown:
  merge 2.6.13-rc4 with ACPI's to-linus tree
  /home/lenb/src/to-linus branch 'acpi-2.6.12'

Linus Torvalds:
  Linux v2.6.13-rc5
  Revert ACPI interrupt resume changes
  Fix get_user_pages() race for write access
  Merge head 'upstream-fixes' of master.kernel.org:/.../jgarzik/netdev-2.6
  Merge head 'upstream-fixes' of master.kernel.org:/.../jgarzik/libata-dev
  Revert "yenta free_irq on suspend"
  Merge master.kernel.org:/.../lenb/to-linus
  Merge master.kernel.org:/.../davej/cpufreq
  x86: fix new find_first_bit()
  Merge master.kernel.org:/.../davej/cpufreq
  Merge master.kernel.org:/.../dtor/input
  Merge master.kernel.org:/home/rmk/linux-2.6-arm-smp
  Merge head 'upstream' of master.kernel.org:/.../jgarzik/libata-dev
  Merge master.kernel.org:/.../davem/net-2.6

Luca T:
  Input: HID - add a quirk for Aashima Trust (06d6:0025) gamepad

Luming Yu:
  [ACPI] Add "ec_polling" boot option

Maneesh Soni:
  sysfs: fix sysfs_setattr
  sysfs: fix sysfs_chmod_file

Mark Haverkamp:
  aacraid: Fix for controller load based timeouts

Martin J. Bligh:
  Fix NUMA node sizing in nr_free_zone_pages

Martin Schwidefsky:
  s390: ioprio & inotify system calls.
  s390: default configuration

Masahito Omote:
  USB: Patch for KYOCERA AH-K3001V support

Mathieu:
  USB: drivers/net/usb/zd1201.c: Gigabyte GN-WLBZ201 dongle usbid

Matt Porter:
  ppc32: add bamboo defconfig
  ppc32: add bamboo platform
  ppc32: add 440ep support

Matthew Garrett:
  agp: restore APBASE after setting APSIZE

Mauro Carvalho Chehab:
  v4l: bug fix to correct tea5767 autodetection
  V4L: Miscellaneous fixes

Michael Hund:
  USB: ldusb fixes

Michael Kerrisk:
  MAINTAINERS record -- MAN-PAGES

Michael Krufky:
  v4l: cx88 card support and documentation finishing touches

Michael Prokop:
  Input: elo - fix help in Kconfig (wrong module name)

Mike Kravetz:
  ppc64: POWER 4 fails to boot with NUMA

Natalie.Protasevich@unisys.com:
  x86_64: avoid wasting IRQs patch update
  x86: avoid wasting IRQs patch update

Neil Brown:
  Input: serio_raw - fix Kconfig help

NeilBrown:
  md: make sure raid5/raid6 resync uses correct 'max_sectors'

Nishanth Aravamudan:
  x86_64: Use msleep in smpboot.c

Paolo 'Blaisorblade' Giarrusso:
  uml: implement hostfs syncing
  uml: avoid unnecessary pcap rebuild

Paul Jackson:
  plug MAN-PAGES maintainer in Documentation/SubmittingPatches

Pete Zaitcev:
  USB: hidinput_hid_event() oops fix

Peter Osterlund:
  Input: ALPS - unconditionally enable tapping mode

Rafael J. Wysocki:
  sk98lin: basic suspend/resume support fixes
  [ACPI] fix resume issues on Asus L5D

Ralf Baechle:
  SMP fix for 6pack driver

Ravikiran G Thirumalai:
  mm: Ensure proper alignment for node_remap_start_pfn
  x86_64: fix cpu_to_node setup for sparse apic_ids

Robert Love:
  ppc64: inotify syscalls
  ppc32: inotify syscalls

Roman Zippel:
  hfs: don't reference missing page
  hfs: don't dirty unchanged inode

Russell King:
  [ARM SMP] Ensure secondary CPUs see their pen release
  [ARM SMP] Fix another ARMv6 bitop problem
  [ARM SMP] Ensure secondary CPUs have a clean TLB

Rusty Russell:
  Module per-cpu alignment cannot always be met

Sergey Vlasov:
  Input: synaptics - fix setting packet size on passthrough port.

Simon Horman:
  Input: synaptics - limit rate to 40pps on Toshiba Dynabooks

Stephen Hemminger:
  sk98lin: fix workaround for yukon-lite chipset (> rev 7)
  skge: version 0.8
  skge: led toggle cleanup
  skge: ignore phy interrupts during negotiation
  skge: fifo control register access fix
  skge: whitespace fixes
  skge: support yukon lite rev 4
  skge: phy lock deadlock
  skge: disable tranmitter on shutdown
  skge: remove SK-9EE support
  skge: silence mac data parity messages

Stephen Smalley:
  selinux: Fix address length checks in connect hook

Tobias Klauser:
  Input: joydev - remove custom conversion from jiffies to msecs

Tony Lindgren:
  Fix OMAP specific typo in smc91x.h

Venkatesh Pallipadi:
  [ACPI] delete boot-time printk()s from processor_idle.c
  [ACPI] Fix memset arguments in acpi processor_idle.c
  [ACPI] Fix the regression with c1_default_handler on some systems

Vojtech Pavlik:
  Input: check keycodesize when adjusting keymaps
  Input: psmouse - wheel mice (imps, exps) always have 3rd button
  Input: i8042 - add Fujitsu T3010 to NOMUX blacklist.

-- diffstat ---

 Documentation/SubmittingPatches             |    5 
 Documentation/fb/vesafb.txt                 |   16 
 Documentation/networking/bonding.txt        |  976 +++++++++++++++++++--------
 Documentation/stable_api_nonsense.txt       |    2 
 Documentation/stable_kernel_rules.txt       |   58 ++
 Documentation/video4linux/CARDLIST.cx88     |    1 
 Documentation/video4linux/CARDLIST.tuner    |    2 
 Documentation/x86_64/boot-options.txt       |   10 
 MAINTAINERS                                 |    6 
 Makefile                                    |    2 
 arch/arm/kernel/smp.c                       |    1 
 arch/arm/lib/bitops.h                       |    2 
 arch/arm/mach-integrator/platsmp.c          |    2 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    7 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c  |   38 +
 arch/i386/kernel/cpu/cpufreq/powernow-k8.h  |   32 +
 arch/i386/kernel/cpu/intel_cacheinfo.c      |   20 -
 arch/i386/kernel/cpu/transmeta.c            |    6 
 arch/i386/kernel/machine_kexec.c            |   22 -
 arch/i386/kernel/mpparse.c                  |   10 
 arch/i386/kernel/numaq.c                    |    9 
 arch/i386/kernel/syscall_table.S            |    2 
 arch/i386/mm/discontig.c                    |    8 
 arch/i386/pci/acpi.c                        |    1 
 arch/i386/pci/common.c                      |    6 
 arch/i386/pci/irq.c                         |    1 
 arch/i386/pci/pci.h                         |    1 
 arch/ia64/kernel/entry.S                    |    2 
 arch/m32r/kernel/time.c                     |   13 
 arch/ppc/Kconfig                            |    2 
 arch/ppc/boot/simple/Makefile               |    6 
 arch/ppc/boot/simple/pibs.c                 |    4 
 arch/ppc/configs/bamboo_defconfig           |  943 ++++++++++++++++++++++++++
 arch/ppc/kernel/cputable.c                  |   20 +
 arch/ppc/kernel/entry.S                     |    1 
 arch/ppc/kernel/head_44x.S                  |   24 -
 arch/ppc/kernel/misc.S                      |    4 
 arch/ppc/platforms/4xx/Kconfig              |   20 -
 arch/ppc/platforms/4xx/Makefile             |    2 
 arch/ppc/platforms/4xx/bamboo.c             |  427 ++++++++++++
 arch/ppc/platforms/4xx/bamboo.h             |  136 ++++
 arch/ppc/platforms/4xx/ebony.c              |    6 
 arch/ppc/platforms/4xx/ebony.h              |   13 
 arch/ppc/platforms/4xx/ibm440ep.c           |  220 ++++++
 arch/ppc/platforms/4xx/ibm440ep.h           |   76 ++
 arch/ppc/platforms/4xx/ocotea.c             |    4 
 arch/ppc/platforms/4xx/ocotea.h             |   13 
 arch/ppc/syslib/Makefile                    |    2 
 arch/ppc/syslib/ibm440gx_common.c           |   15 
 arch/ppc/syslib/ibm44x_common.h             |    4 
 arch/ppc64/kernel/misc.S                    |    6 
 arch/ppc64/kernel/prom.c                    |    2 
 arch/ppc64/mm/numa.c                        |    7 
 arch/s390/appldata/appldata_base.c          |    6 
 arch/s390/defconfig                         |  253 ++++---
 arch/s390/kernel/compat_wrapper.S           |   26 +
 arch/s390/kernel/head.S                     |    7 
 arch/s390/kernel/head64.S                   |    7 
 arch/s390/kernel/machine_kexec.c            |    7 
 arch/s390/kernel/relocate_kernel.S          |   41 +
 arch/s390/kernel/relocate_kernel64.S        |   45 +
 arch/s390/kernel/smp.c                      |    6 
 arch/s390/kernel/syscalls.S                 |    5 
 arch/s390/kernel/traps.c                    |   15 
 arch/um/drivers/Makefile                    |    4 
 arch/um/drivers/mconsole_kern.c             |    2 
 arch/um/kernel/exitcode.c                   |    2 
 arch/um/kernel/process.c                    |   48 +
 arch/um/kernel/process_kern.c               |    2 
 arch/um/kernel/skas/process.c               |    2 
 arch/um/kernel/skas/trap_user.c             |    1 
 arch/um/kernel/time_kern.c                  |    5 
 arch/um/os-Linux/elf_aux.c                  |    6 
 arch/um/os-Linux/user_syms.c                |    3 
 arch/um/sys-i386/stub_segv.c                |    6 
 arch/x86_64/Kconfig                         |    5 
 arch/x86_64/Makefile                        |   12 
 arch/x86_64/defconfig                       |  224 ++++--
 arch/x86_64/ia32/Makefile                   |    4 
 arch/x86_64/ia32/syscall32.c                |   10 
 arch/x86_64/ia32/syscall32_syscall.S        |   17 
 arch/x86_64/kernel/entry.S                  |   22 -
 arch/x86_64/kernel/genapic.c                |   33 +
 arch/x86_64/kernel/genapic_flat.c           |  142 ++--
 arch/x86_64/kernel/head.S                   |   16 
 arch/x86_64/kernel/irq.c                    |   19 +
 arch/x86_64/kernel/machine_kexec.c          |   99 +--
 arch/x86_64/kernel/mce.c                    |   93 ++-
 arch/x86_64/kernel/mpparse.c                |   34 +
 arch/x86_64/kernel/setup.c                  |    5 
 arch/x86_64/kernel/setup64.c                |   18 
 arch/x86_64/kernel/smp.c                    |   66 ++
 arch/x86_64/kernel/smpboot.c                |   84 +-
 arch/x86_64/kernel/traps.c                  |    3 
 arch/x86_64/lib/csum-copy.S                 |    2 
 arch/x86_64/lib/delay.c                     |    2 
 arch/x86_64/mm/fault.c                      |    1 
 arch/x86_64/mm/numa.c                       |   50 +
 arch/x86_64/mm/srat.c                       |   22 -
 arch/x86_64/pci/k8-bus.c                    |    2 
 drivers/acpi/ec.c                           |  889 ++++++++++++++++++++-----
 drivers/acpi/pci_irq.c                      |   85 ++
 drivers/acpi/pci_link.c                     |  109 ++-
 drivers/acpi/processor_idle.c               |   31 -
 drivers/char/agp/agp.h                      |    1 
 drivers/char/agp/intel-agp.c                |   12 
 drivers/char/keyboard.c                     |    4 
 drivers/char/sonypi.c                       |  146 ++--
 drivers/cpufreq/cpufreq.c                   |    4 
 drivers/hwmon/adm1026.c                     |    2 
 drivers/hwmon/atxp1.c                       |    5 
 drivers/hwmon/fscpos.c                      |    4 
 drivers/hwmon/gl520sm.c                     |    4 
 drivers/hwmon/max1619.c                     |    2 
 drivers/hwmon/pc87360.c                     |    2 
 drivers/i2c/busses/i2c-i801.c               |    6 
 drivers/i2c/chips/ds1337.c                  |    6 
 drivers/i2c/chips/eeprom.c                  |    8 
 drivers/i2c/chips/max6875.c                 |    8 
 drivers/i2c/i2c-core.c                      |    8 
 drivers/ide/legacy/ide-cs.c                 |    2 
 drivers/input/evdev.c                       |    1 
 drivers/input/input.c                       |  389 +++++------
 drivers/input/joydev.c                      |    6 
 drivers/input/misc/uinput.c                 |  181 ++---
 drivers/input/mouse/alps.c                  |   29 -
 drivers/input/mouse/logips2pp.c             |    2 
 drivers/input/mouse/psmouse-base.c          |    2 
 drivers/input/mouse/synaptics.c             |   14 
 drivers/input/serio/Kconfig                 |    2 
 drivers/input/serio/i8042-x86ia64io.h       |   14 
 drivers/input/serio/i8042.c                 |   62 +-
 drivers/input/serio/serio.c                 |   42 +
 drivers/input/serio/serio_raw.c             |    1 
 drivers/input/touchscreen/Kconfig           |    2 
 drivers/md/dm-table.c                       |    6 
 drivers/md/dm.c                             |  194 ++---
 drivers/md/raid5.c                          |    1 
 drivers/md/raid6main.c                      |    1 
 drivers/media/video/bttv-driver.c           |    7 
 drivers/media/video/bttv.h                  |    6 
 drivers/media/video/bttvp.h                 |    4 
 drivers/media/video/cx88/cx88-cards.c       |   33 +
 drivers/media/video/cx88/cx88-video.c       |    4 
 drivers/media/video/cx88/cx88.h             |    3 
 drivers/media/video/msp3400.c               |    4 
 drivers/media/video/saa7134/saa7134-i2c.c   |    4 
 drivers/media/video/saa7134/saa7134.h       |    4 
 drivers/media/video/tea5767.c               |   26 -
 drivers/media/video/tuner-core.c            |   29 +
 drivers/media/video/tuner-simple.c          |    8 
 drivers/media/video/tveeprom.c              |    2 
 drivers/net/cs89x0.c                        |   12 
 drivers/net/cs89x0.h                        |    1 
 drivers/net/hamradio/Kconfig                |    2 
 drivers/net/sk98lin/skge.c                  |   80 ++
 drivers/net/sk98lin/skgeinit.c              |    2 
 drivers/net/sk98lin/skxmac2.c               |    8 
 drivers/net/skge.c                          |  233 +++---
 drivers/net/skge.h                          |   41 -
 drivers/net/smc91x.h                        |    2 
 drivers/pci/probe.c                         |    2 
 drivers/pci/quirks.c                        |    5 
 drivers/pci/rom.c                           |    4 
 drivers/pci/setup-bus.c                     |   12 
 drivers/pcmcia/ds.c                         |    2 
 drivers/pcmcia/yenta_socket.c               |    9 
 drivers/s390/cio/device_fsm.c               |    3 
 drivers/scsi/Kconfig                        |    2 
 drivers/scsi/aacraid/aacraid.h              |    6 
 drivers/scsi/aacraid/linit.c                |    3 
 drivers/scsi/ata_piix.c                     |   19 -
 drivers/serial/8250_pnp.c                   |   22 -
 drivers/usb/Kconfig                         |    1 
 drivers/usb/class/cdc-acm.c                 |    3 
 drivers/usb/core/devio.c                    |   18 
 drivers/usb/core/hcd.c                      |    4 
 drivers/usb/core/hcd.h                      |    8 
 drivers/usb/core/message.c                  |    6 
 drivers/usb/host/ehci-q.c                   |    4 
 drivers/usb/host/ohci-hcd.c                 |    5 
 drivers/usb/host/ohci-s3c2410.c             |  496 ++++++++++++++
 drivers/usb/input/acecad.c                  |   14 
 drivers/usb/input/aiptek.c                  |    6 
 drivers/usb/input/ati_remote.c              |    8 
 drivers/usb/input/hid-core.c                |   24 -
 drivers/usb/input/hid-input.c               |   11 
 drivers/usb/input/itmtouch.c                |    6 
 drivers/usb/input/kbtab.c                   |    6 
 drivers/usb/input/mtouchusb.c               |    6 
 drivers/usb/input/powermate.c               |    6 
 drivers/usb/input/touchkitusb.c             |    7 
 drivers/usb/input/usbkbd.c                  |    6 
 drivers/usb/input/usbmouse.c                |    6 
 drivers/usb/input/wacom.c                   |    6 
 drivers/usb/input/xpad.c                    |    6 
 drivers/usb/media/konicawc.c                |    6 
 drivers/usb/misc/ldusb.c                    |    7 
 drivers/usb/net/pegasus.c                   |    1 
 drivers/usb/net/rtl8150.c                   |    2 
 drivers/usb/net/zd1201.c                    |    1 
 drivers/usb/serial/ftdi_sio.c               |  146 +---
 drivers/usb/serial/ftdi_sio.h               |   14 
 drivers/usb/usb-skeleton.c                  |    6 
 drivers/video/fbmem.c                       |    6 
 drivers/video/fbsysfs.c                     |   22 -
 drivers/video/tridentfb.c                   |   28 -
 drivers/video/vesafb.c                      |   47 +
 drivers/w1/Kconfig                          |    2 
 fs/hfs/bnode.c                              |    2 
 fs/hfs/extent.c                             |    3 
 fs/hfsplus/bnode.c                          |    2 
 fs/hfsplus/extents.c                        |    4 
 fs/hostfs/hostfs.h                          |    1 
 fs/hostfs/hostfs_kern.c                     |    2 
 fs/hostfs/hostfs_user.c                     |   16 
 fs/inotify.c                                |    5 
 fs/namei.c                                  |    2 
 fs/sysfs/file.c                             |   18 
 fs/sysfs/inode.c                            |    2 
 include/acpi/acpi_drivers.h                 |    3 
 include/asm-arm/bitops.h                    |    5 
 include/asm-generic/sections.h              |    1 
 include/asm-i386/bitops.h                   |   13 
 include/asm-i386/smp.h                      |    3 
 include/asm-ppc/ibm44x.h                    |   34 +
 include/asm-ppc/ibm4xx.h                    |    4 
 include/asm-ppc/ibm_ocp.h                   |   12 
 include/asm-ppc/ppc_asm.h                   |    6 
 include/asm-ppc/unistd.h                    |    5 
 include/asm-ppc64/topology.h                |    5 
 include/asm-ppc64/unistd.h                  |    5 
 include/asm-s390/unistd.h                   |    7 
 include/asm-um/vm86.h                       |    6 
 include/asm-x86_64/bitops.h                 |    3 
 include/asm-x86_64/bug.h                    |   13 
 include/asm-x86_64/desc.h                   |    1 
 include/asm-x86_64/ipi.h                    |   45 +
 include/asm-x86_64/irq.h                    |    2 
 include/asm-x86_64/msr.h                    |    2 
 include/asm-x86_64/pgtable.h                |    2 
 include/asm-x86_64/smp.h                    |    6 
 include/asm-x86_64/system.h                 |    7 
 include/asm-x86_64/tlbflush.h               |    9 
 include/linux/acpi.h                        |    4 
 include/linux/dcookies.h                    |    4 
 include/linux/fsnotify.h                    |    7 
 include/linux/input.h                       |    6 
 include/linux/pci.h                         |    5 
 include/linux/uinput.h                      |    5 
 include/linux/usb_input.h                   |   25 +
 include/media/tuner.h                       |    4 
 include/net/tcp.h                           |    2 
 init/main.c                                 |    3 
 ipc/shm.c                                   |    2 
 kernel/module.c                             |   15 
 kernel/posix-timers.c                       |   17 
 kernel/sys.c                                |    1 
 kernel/sys_ni.c                             |    1 
 lib/Kconfig.debug                           |    2 
 mm/memory.c                                 |   29 -
 mm/mempolicy.c                              |    2 
 mm/page_alloc.c                             |   21 -
 net/core/dev.c                              |    3 
 net/core/dst.c                              |   15 
 net/ipv4/ip_gre.c                           |   21 -
 net/ipv4/ipip.c                             |   20 -
 net/ipv4/ipmr.c                             |    6 
 net/ipv4/netfilter/ip_conntrack_core.c      |    5 
 net/ipv6/sit.c                              |   21 +
 security/selinux/hooks.c                    |    4 
 sound/pci/intel8x0.c                        |    7 
 272 files changed, 6683 insertions(+), 2374 deletions(-)
