Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbUCTDja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 22:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUCTDja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 22:39:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:29107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263212AbUCTDjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 22:39:05 -0500
Date: Fri, 19 Mar 2004 19:39:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.5-rc2
Message-ID: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hotplug CPU's, USB, ALSA, input layer updates. And various random things.

		Linus

---

Summary of changes from v2.6.5-rc1 to v2.6.5-rc2
============================================

<a.kasparas:gmc.lt>:
  o [AF_KEY]: More accurate error codes

<brill:fs.math.uni-frankfurt.de>:
  o USB Storage: unusual_devs.h entry submission

<cieciwa:alpha.zarz.agh.edu.pl>:
  o drivers/cdrom/cdu31a - wrong tmp_irq declaration

<henning:wh9.tu-dresden.de>:
  o USB: unusual_devs.h update

<home:mdiehl.de>:
  o input: Add support for devices which need some padding at the end
    of a HID report.

<jamesl:appliedminds.com>:
  o input: Fix hid-core for devices that have less usages than values
    in a hid report. We could iterate beyond the end of array of usages
    before.
  o input: Add a new ioctl to hiddev, which allows multiple usages to
    be set in a single request. Also fixes sizes of fields in hiddev
    structs to use _uXX types.

<jeffm:suse.com>:
  o USB: Fix for kl5kusb105 driver

<john:fremlin.de>:
  o input: Add a NEC USB gamepad to badpad blacklist

<jurgen:botz.org>:
  o USB: visor patch for Samsung SPH-i500

<katzj:redhat.com>:
  o Fix blkpg ioctl32 handling

<mcgrof:ruslug.rutgers.edu>:
  o [wireless prism54] add two final missing bits

<mcgrof:studorgs.rutgers.edu>:
  o [wireless prism54] use netdev_priv() helper
  o [wireless prism54] several minor updates

<michal_dobrzynski:mac.com>:
  o USB: add IRTrans support to ftdi_sio driver

<szuk:telusplanet.net>:
  o input: Restore LED state in atkbd.c after resume

<tejohnson:yahoo.com>:
  o USB: add new USB Touchscreen Driver

<thoffman:arnor.net>:
  o USB: add driver for ATI USB/RF remotes
  o USB: update driver for ATI USB/RF remotes

<u233:shaw.ca>:
  o USB: kbtab.c (Jamstudio Tablet) with optional pressure

<weeve:gentoo.org>:
  o [CS4231]: Fix build error, use SNDRV_DMA_TYPE_DEV and missing comma

<weicht:in.tum.de>:
  o input: Fix a bug introduced by Andrew Morton's gcc3.2 fixes

Adrian Bunk:
  o USB_STORAGE: remove a comment
  o USB: remove USB_SCANNER MAINTAINERS entry

Alan Stern:
  o USB Storage: unusual_devs.h update
  o USB Storage: update unusual_devs.h comments
  o USB: Fix a bug in the UHCI dequeueing code
  o USB: Enable interrupts in UHCI after PM resume
  o USB: Return better result codes in UHCI
  o USB: Remove name obfuscation in UHCI
  o USB: Use list_splice instead of looping over list elements
  o USB Storage: Remove Minolta Dimage 7i from unusual_devs.h
  o USB Storage: Revision of as202, Genesys quirk patch
  o USB: Don't add/del interfaces, register/unregister them
  o USB: Improve handling of altsettings
  o USB: Convert usbcore to use cur_altsetting
  o USB: Small improvements for devio.c
  o USB: Convert usb-storage to use cur_altsetting
  o USB: Convert usbtest to the new altsetting regime
  o USB: Update USB class drivers
  o USB: Remove interface/altsettings assumption from audio driver
  o USB UHCI: restore more state following PM resume
  o USB: Interface/altsetting update for ISDN hisax driver
  o USB: Remove interface/altsetting assumptions from usb-midi
  o USB: Altsetting/interface update for USB image drivers

Alexander Viro:
  o hpfs: namei.c failure case cleanups
  o hpfs: clean up lock ordering
  o hpfs: new/read/write_inode() cleanups
  o hpfs: hpfs iget locking cleanup preparation
  o hpfs: hpfs iget locking cleanup
  o hpfs: deadlock fixes
  o hpfs: fix locking scheme
  o hpfs: general cleanup
  o missing check in do_add_mount()
  o add file_accessed() helper
  o add touch_atime() helper

Andi Kleen:
  o Fix memory corruption on hyperthreaded x86-64 machines

Andreas Schwab:
  o PCI Hotplug: Fix PCIE and SHPC hotplug drivers for ia64

Andrew Morton:
  o USB ati_remote.c: don't be a namespace hog
  o Fix early parallel make failures
  o Save some memory in mem_map on x86-64
  o ppc32 compile fix
  o s390: update for altered page_state structure
  o selinux: Conditional policy extension and MLS detection support
  o ide-scsi error handling fixes
  o drivers_cdrom_cm206.c check_region() fix
  o ACPI: document acpi_sleep option
  o Document tricks to get S3_swsusp working
  o drivers_cdrom_sjcd.c check_region() fix
  o rename one of the acpi_disable() instances
  o filemap.c comment fix
  o fix for kallsyms module symbol resolution problem
  o Fix scripts/ver_linux
  o chardev module aliases
  o minor credits updates
  o Fix comment in drivers/block/genhd.c
  o add warning to DocBook/Makefile
  o drivers_cdrom_cdu31c.c check_region() fix
  o move PCIBIOS access help text
  o fix modular fb drivers
  o kbuild: fix modpost when used with O=
  o selinux: fix compute_av bug
  o flush_scheduled_work() deadlock fix
  o flush_workqueue(): detect excessive nesting
  o page_referenced() simplification
  o fbdev: character drawing enhancement
  o kernel-doc build fix
  o reiserfs: fix null pointer deref
  o resierfs: scheduling latency improvements
  o reiserfs: search_by_key fix
  o reiserfs: fix transaction sizes
  o reiserfs: atomicity fix
  o resierfs: AIO support
  o do_write_mem() return value check
  o document unchecked do_munmaps in ipc/shm.c
  o slab: fix display of object length in corruption detector
  o kthreads hold files open
  o kill INIT_THREAD_SIZE
  o blk: statically initialise the congestion waitqueue_heads
  o iostats averaging fix
  o Reduce stack overflow check to 4096 bytes
  o Remove bogus sys_oldumount sign extension code
  o Remove some unused ppc64 variables
  o Make dma API handle PCI and VIO
  o Add hypervisor busy return codes
  o Handle longbusy return codes in IBM VETH driver
  o Add some missing EXPORT_SYMBOLs
  o Fix for hotplug of multifunction cards
  o Fix multiple EEH-related bugs
  o Fix xics IRQ affinity
  o Add some functions to make vio.h consistant with pci_dma.h and
    dma_mapping.h
  o Move iSeries specific EXPORT_SYMBOLs out of ppc_ksyms.c
  o update iseries default target
  o Export find_next_bit
  o Add slow path lookup in xics_get_irq
  o Dont enable interrupts during interrupt processing on iseries
  o Remove pci DMA exports
  o Added rtas_set_power_level()
  o Fixed NULL ptr deref in RTAS syscall ppc_rtas()
  o Add kernel version to oops
  o Cleanup ppc64 procfs code
  o Clean up xmon backtrace code
  o Fix hvc console sleep in spinlock bug
  o ppc64 defconfig update
  o ppc64: fix for massive OF properties
  o ppc32: Fix c&p error in arch/ppc/syslib/indirect_pci.c
  o ppc32: Fix PCI DMA API changes
  o ppc32: Update <asm-ppc/dma-mapping.h>
  o ppc32: Fix thinko in PCI_DMA_FOO to DMA_FOO conversion
  o ppc64: run bitops.c through Lindent
  o s390: core
  o s390: common i/o layer
  o s390: sclp fix
  o s390: network driver fixes
  o s390: dasd driver fixes
  o s390: z/VM monitor stream
  o s390: tape driver fixes
  o x86 vsyscall alignment fix
  o make config_max_raw_devices work
  o hugetlb_zero_setup() race fix
  o clean up devices.txt
  o devices.txt: typos and removal of dead devices
  o devices.txt: add more devices
  o cpqarray: increment version number
  o cpqarray: rmmod oops fix
  o cpqarray: I/O address fixes
  o cpqarray: use PCI APIs
  o cpqarray: check pci_register_driver() return value
  o SHMLBA compat task alignment fix
  o Remove old config options from defconfigs
  o Fix x86_64 compile warning in bad_page()
  o ppc32: fix SMP build
  o ppc32: Fix booting some IBM PRePs
  o ppc64: wrap some stuff in __KERNEL__
  o ppc64: xmon oops-the-kernel option
  o ppc64: CONFIG_PREEMPT Kconfig help fix
  o JBD: avoid panic on corrupted journal superblock
  o exportfs - Remove unnecessary locking from find_exported_dentry()
  o ISDN kernelcapi debug message enable
  o ISDN kernelcapi notifier workqueue re-structured
  o ISDN kernelcapi notifier NULL pointer fix
  o Fw: [PATCH 2.6] netpoll for pcnet_cs
  o [NET]: Give struct flowi explicit alignment, with help from
    yoshfuji
  o ppc64: iSeries virtual tape driver
  o ppc64: remove IO_DEBUG
  o ppc64: Add numa=off command line option
  o ppc64: Fix SLB reload bug
  o ppc64: Fix POWER3 TCE allocation
  o Add dma_error() and pci_dma_error()
  o sysfs_remove_dir-vs-dcache_readdir race fix
  o Fix dentry refcounting in sysfs_remove_group()
  o sysfs: pin kobjects to fix use-after-free crashes
  o proper alignment of init task in kernel image
  o don't abuse empty_zero_page (x86)
  o kconfig: fix xconfig on /lib64 properly
  o kconfig: don't rename target dir when saving config
  o config: disable debug prints
  o config: persistent qconf configuration
  o config: choice fix
  o 8250_pnp: probe and remove can be __devinit/__devexit
  o slab: start_cpu_timer() can be __init
  o doc. updates/typos
  o ip2: fix double operator
  o procfs: use kernel min/max
  o reiserfs: use kernel min/max
  o sound: use kernel min/max
  o zlib: use kernel min/max
  o fix HZ leaking to userspace in BSD accounting
  o Fix uninlined memcmp on i386
  o EDD: move code from i386-specific locations to generic
  o EDD: move code from i386-specific locations to generic
  o EDD: split assembly code
  o pte_chain comment fix
  o add note about "Copyright" to SubmittingDrivers
  o sonypi devinit section usage
  o VM overcommit documentation fixes
  o meye driver update
  o remove_suid() should return error code

Anton Blanchard:
  o fix ppc rtas compile

Aristeu Sergio Rozanski Filho:
  o input: Remove the obsolete "busmouse.c" helper driver

Art Haas:
  o USB: C99 initializers for drivers/usb/serial/keyspan.h
  o [IPVS]: Add C99 initializers to ip_vs_ctl.c
  o [IPVS]: Add C99 initializers to net/ipv4/ipvs/ip_vs_lblc.c
  o [IPVS]: Add C99 initializers to net/ipv4/ipvs/ip_vs_lblcr.c

Bartlomiej Zolnierkiewicz:
  o ide-scsi.c: fix ATAPI multi-lun support
  o remove dead "hdXlun=" kernel parameter
  o ATI IXP IDE support
  o hpt366.c: DMA timeout fix for HPT374
  o hpt366.c: PLL fix needed for some HPT374
  o remove ide_hwif_t->initializing
  o remove AMIGA/MAC hacks from IDE resource handling code
  o ide-dma.c: remove unused/obsoleted code for hwif->mmio == 1
  o add missing MODULE_DEVICE_TABLE() to IDE PCI drivers

Benjamin Herrenschmidt:
  o g5: Fix iommu vs. pci_device_to_OF_node

Bjorn Helgaas:
  o ia64: clean up ACPI GSI/IRQ conversions (ia64 part)
  o ia64: move consistent_dma_mask to the generic device
  o ia64: update ia64/Kconfig
  o ia64: fix up DMA API breakage in generic build

Chen Yang:
  o Make intermezzo work again

Christoph Hellwig:
  o ia64: update simscsi to 2.6 scsi APIs

Dave Kleikamp:
  o JFS: zero new log pages, etc

David Brownell:
  o USB: usbnet learns about Zaurus C-860
  o USB Gadget: gadget config buffer utilities
  o USB: EHCI and full-speed ISO-OUT
  o USB Gadget: make usb gadget strings talk utf-8
  o USB: HCD names, for better troubleshooting
  o USB: usbnet and ALI M5632
  o USB: gadget config buf utilities
  o USB: clarify CONFIG_USB_GADGET
  o USB: usbcore doc update
  o USB gadget: dualspeed {run,compile}-time flags
  o USB: usb_unlink_urb() has distinct "not linked" fault
  o USB: usbtest updates (new firmware)
  o USB: usb buffer allocation shouldn't require DMA
  o USB gadget: gadget zero, simplified controller-specific
    configuration
  o USB Gadget: add "gadget_chips.h"

David Howells:
  o FD_CLOEXEC fcntl cleanup

David Mosberger:
  o input: Avoid an endless loop in hid-core.c, if a device has some
    empty reports.
  o input: When reading input reports from a device via the ctrl pipe,
    set idle time of the device. This makes buggy devices which take
    the idle time into account for the ctrl pipe work.
  o ia64: Forward-port hp-agp.c fix from 2.4
  o ia64: Based on patch by Keith Owens: put stop bit to work around
    GCC problem
  o ia64: Update defconfig
  o ia64: Prevent GCC from clobbering r13.  Found by Luming You

David S. Miller:
  o [SPARC64]: Implement pci_dma_error()
  o [PM2FB]: Fix build on big-endian
  o [SPARC64]: Update defconfig
  o [SPARC64]: Export sbus_dma_sync_X_for_device routines too
  o [NET]: Preemption disabling is superfluous in net_rx_action()

Dmitry Torokhov:
  o Atkbd: whitespace fixes
  o Atkbd: Clean up unclean merge (remove old MODULE_PARMs)
  o Input: Switch between strict/relaxed synaptics protocol checks
    based on data in the first full data packet. Having strict checks
    helps getting rid of bad data after losing sync, but not all
    harware implements strict protocol.
  o Psmouse: whitespace fixes
  o Psmouse: some hardware does not ACK "disable streaming mode"
    command
  o Introduce module_param_array_named to allow for module options with
    name different form corresponding array variable. Allows using
    short (but descriptive) option names without hurting code
    readability.
  o Input: Convert joystick modules to the new way of handling
    parameters and document them in kernel-parameters.txt
  o Setup: introduce __obsolete_setup macro to denote truly obsolete
    parameters. Whenever such parameter is specified kernel will
    complain that "Parameter %s is obsolete, ignored"
  o Input: use __obsolete_setup to document removed (renamed)
  o Input: when disconnecting PS/2 mouse give protocol's disconnect
    handler chance to run before starting ignoring mouse data.
  o Input: do a full reset of Synaptics touchpad if extended protocol
    probes failed, otherwise trackpoint on the pass-through port may
    stop working (reset-disable isn't enough to revive it)    
  o Input: if Synaptics' absolute mode is disabled make sure that
    touchpad is reset back to relative mode and gestures (taps) are
    enabled

Don Fry:
  o back out netdev_priv() for loopback

Greg Kroah-Hartman:
  o USB Storage: remove unneeded debug message
  o USB: delete unneeded scanner documentation
  o USB: fix build for older versions of gcc and the mtouchusb driver
  o USB: fix up the input Makefile after these last few drivers were
    added
  o USB: remove act_altsetting usages in the remaining drivers/usb/
    drivers
  o USB: remove act_altsetting usages in more USB drivers
  o USB: remove intf->act_altsetting altogether from the USB core and
    usb.h
  o merge fixups with irda usb code
  o USB: fix the pcwd_usb driver due to act_altsetting going away
  o USB: fix usb-serial core to look at the proper interface descriptor
  o USB: fix compiler warning in hfc_usb.c driver
  o PCI Hotplug: fix compiler warning in acpiphp driver
  o USB: replace kobject with kref in usb-serial core

Helge Deller:
  o input: Convert HP/PARISC Lasi/Dino PS/2 keyboard/mouse driver from
    an input driver to a serio driver.

James Bottomley:
  o Fix 3c509

Jan-Benedict Glaw:
  o input: Add serio entries for LK keyboards
  o input: Add DEC LK201/LK401 keyboard support
  o input: Add driver for DEC VSXXX mice

Jaroslav Kysela:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> I2C cs8427 Don't
    reset chip when PCM rate was not changed
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Generic drivers
    Clean the 'AUTO' checking
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver,Trident driver fixed the mapping of silent pages on emu10k1
    and trident SG buffers.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
    fixed the compilation with sparc sbus support.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> GUS Extreme
    driver <davej@redhat.com> Whilst chasing an oops, I shortened some
    error paths.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core
    <davej@redhat.com> Try modprobing a driver that the hardware
    doesn't exist for.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ES18xx
    driver,ES1688 driver,GUS Classic driver,GUS Extreme driver GUS MAX
    driver,AMD InterWave driver,SB16/AWE driver,SB8 driver
    <davej@redhat.com> This is a *really* silly one.  The various
    probing routines in these drivers can return -ENODEV, -ENOMEM etc..
    so when we do something like
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ES968 driver
    <davej@redhat.com> This oopses on rmmod, as we do
    pnp_unregister_card_driver twice.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> DT019x
    driver,ES968 driver <davej@redhat.com> Miscellaneous junk,
    indentation fixes and the like.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> DT019x driver
    Added missing pnp_unregister_card_driver call
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> GUS Extreme
    driver Fixed typo
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ES968 driver Fix
    against Dave's fix: put back the behaviour common to all ISA PnP
    modules
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> MPU401 UART
    don't use acpi_disabled because it isn't exported in all archs
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> MPU401 UART
    don't use negative return value as card count
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> MPU401 UART
    use global variable to count cards
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> SPARC cs4231 driver
    fixed the dma allocation type.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> SPARC cs4231 driver
    fixed the compilation error (missing comma).
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> au88x0 driver Manuel
    Jander <mjander@elo.utfsm.cl>:
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver don't resubmit unlinked urbs; move interface releasing after
    urb unlinking
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PPC PMAC driver
    Fix against the new DMA API
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    added the quirk for Compaq Evo D510C.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver fix get_iface_desc macro
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver replace usage of interface index with calls to
    usb_ifnum_to_if
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver add comments in USB MIDI vendor-specific detection functions
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver Returned back get_iface() macro for quirks Removed extra
    variable to avoid warning

Jeff Garzik:
  o [libata] bump libata and sata_sil driver versions
  o [blk carmel] add copyright statement and license mention
  o [netdrvr natsemi] Fix RX DMA mapping
  o [blk carmel] call del_gendisk(), if disk is 'up', at cleanup time
  o [libata sata_vsc] minor cleanup
  o [libata] Several updates to via driver
  o [netdrvr de2104x] initialize bus mode properly
  o [libata] update dma start/stop path to only set/clear the bits we
    care about
  o [libata sata_sil] port init cleanup, mask SATA phy interrupts
  o [libata] API cleanup
  o [libata sata_sil] add post-set-mode hook to libata, use it
  o [libata] remove unneeded linux/config.h includes
  o [blk carmel] use statically allocated majors for first two hosts
  o [libata] explicitly set consistent DMA mask to 0xffffffff
  o [libata] increase max from UDMA/100 to UDMA/133 for some drivers

Jens Axboe:
  o allow random write to cdrom devices with profile 2 (removable disk)

Jesse Barnes:
  o ia64: kill CONFIG_IA64_MCA

Jochen Hein:
  o usb: Minor documentation fix reflecting new USB module names in
    acm.txt

John S. Marvin:
  o yia64: Fix show_mem() panic

Keith Owens:
  o ia64: Decode salinfo oemdata for SN2 via PROM

Krzysztof Halasa:
  o [netdrvr de2104x] fix ifup/down and promise mode

Linda Xie:
  o PCI Hotplug: rpaphp/rpadlpar latest (support for vio and
    multifunction devices )

Linus Torvalds:
  o Remove bogus linux/irq.h include that fails build on ARM
  o cpu.c needs <linux/module.h> for symbol exports
  o Make ppc64 __FD_ISSET() return a proper boolean return value
  o Add FBIOBLANK to list of compatible ioctls
  o Linux 2.6.5-rc2

Marcel Sebek:
  o input: Use request_region() instead of check_region() in ns558.c
    it's both safer and correct.
  o input: Fix a memory leak in ns558.c

Martin Diehl:
  o USB: fix stack usage in pl2303 driver

Martin Hicks:
  o ia64: Update SN2 defconfig

Matt Mackall:
  o fix netpoll warning in tulip

Matthew Dharm:
  o USB Storage: DSC-T1 unusual_devs.h entry
  o USB Storage: Fix for Fuji Finepix 1400
  o USB Storage: Remove unneeded macro
  o USB Storage: tighten sense-clearing code

Matthew Wilcox:
  o PCI: insert_resource can succeed and return an error
  o PCI: Use insert_resource in pci_claim_resource
  o PCI: claim PCI resources on ia64

Oliver Neukum:
  o USB: locking fix for pid.c
  o USB: fixes for aiptek driver
  o USB: bug in error code path of kbtab driver
  o USB: wacom driver fixes
  o input: fixes in wacom.c

Panagiotis Issaris:
  o input: Credit to Panagiotis Issaris for Graphire 3 support

Pat Gefre:
  o ia64: fix missing braces in SN2 console code

Patrick McHardy:
  o [PKT_SCHED]: Fix broken indentation in HFSC scheduler
  o [NET_SCHED]: Fix requeueing in HFSC scheduler

Paulo Marques:
  o USB: usblp.c (Was: usblp_write spins forever after an error)

Per Winkvist:
  o USB Storage: unusual devs fix for Pentax cameras

Petko Manolov:
  o USB: 2.6 pegasus.h updates

Ralf Bächle:
  o [hamradio 6pack] cleanup

Randy Dunlap:
  o USB: fix net2280 section usage
  o revert some netdev_priv() changes

Russell King:
  o input: Fix i8042 PS/2 mouse on ARM
  o fix "optimize  &&  ?"

Rusty Russell:
  o wait_task_inactive should not return on preempt
  o Export cpu notifiers and do locking
  o Implement migrate_all_tasks
  o Hotplug CPUs: cpu_down()
  o Hotplug CPUs: Sysfs Online Attribute
  o Hotplug CPUs: don't pull onto offline CPUs
  o Hotplug CPUs: Take cpu Lock Around Migration
  o Hotplug CPUs: Keep IRQs off in Migration Thread Calling
  o Hotplug CPUs: Set prio of migration thread before CPU
  o Hotplug CPUs: Make Migration Thread Handle CPUs Going
  o Hotplug CPUs: Read Copy Update Changes
  o Hotplug CPUs: Make ksoftirqd Handle CPU Going Down
  o Hotplug CPUs: Workqueue Changes
  o Hotplug CPUs: Kswapd Changes
  o Hotplug CPUs: Other CPU_DEAD Notifiers
  o Hotplug CPUs: Remove CPU_OFFLINE Notifier

Scott Feldman:
  o update e100.txt

Stephen Hemminger:
  o [NET_SCHED]: Add packet delay scheduler

Stéphane Doyon:
  o USB brlvger: Driver obsoleted by rewrite using usbfs

Takayoshi Kochi:
  o PCI Hotlug: fix acpiphp unable to power off slots

Thomas Sailer:
  o USB: USB OSS audio driver workaround for buggy descriptors

Vojtech Pavlik:
  o input: It looks like the Saitek RumblePad needs a BADPAD entry
  o input: Add support for another a4tech 2-wheel USB mouse, with a
    Cypress ID this time. Also rearrange the HID blacklist a bit - it
    has grown too long.
  o input: Fix sunkbd.c to work with serport. Must sleep
  o input: Bail out in atkbd.c if scancode set is changed, don't
    reinitialize scancode map. This is even more anoying than a new
    keyboard device in the unlikely case of set change.
  o input: Add support for scroll wheel on MS Office and similar
    keyboards
  o input: Create an extra option for enabling IBM RapidAccess keyboard
    special features (atkbd.extra), instead of abusing the atkbd.set
    option for this.
  o input: Fix "psmouse: Lost sync" problem. It was really losing sync
  o input: Fix a warning in i8042.c
  o input: Re-add a loop to set the old scancode bit in device key
    bitmap
  o input: Workaround i8042 chips with broken MUX mode
  o input: Only do hotplug on PS/2 HW when the HW sends 0xaa. This
    avoids problems with broken USB->PS/2 legacy emulation in certain
    BIOSes.
  o input: i8042.c
  o input: Update the Wacom driver to latest version from Ping Cheng
    from Wacom.
  o input: Add a Chic gamepad into badpad quirk list
  o input: Don't define DEBUG in hid-ff by default. It spews messgaes
    even when no FF device is present.
  o input: Fix oops (NULL pointer dereference) on resume in psmouse.c,
    when the mouse goes away while sleeping.

William Lee Irwin III:
  o [SPARC]: NR_SYSCALLS in entry.S needs to be 273

Zephaniah E. Hull:
  o input: HID needs to distinguish between two types of A4Tech
    two-wheel mice.

