Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266487AbSLJX2G>; Tue, 10 Dec 2002 18:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSLJX2F>; Tue, 10 Dec 2002 18:28:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43976 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S266487AbSLJX2A>; Tue, 10 Dec 2002 18:28:00 -0500
Date: Tue, 10 Dec 2002 18:37:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre1
Message-ID: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes the first pre of 2.4.21 including the new IDE code merged
from Alan's tree.

Test it carefully, since the new IDE code is not yet fully tested.

Do not use it with critical data.

Summary of changes from v2.4.20 to v2.4.21-pre1
============================================

<baldrick@wanadoo.fr>:
  o usbdevfs: finalize urbs on interface release
  o usbdevfs: finalize urbs on interface release
  o usbdevfs: more list cleanups

<chris@qwirx.com>:
  o [SPARC]: Add missing iounmap to display7seg driver

<dana.lacoste@peregrine.com>:
  o RATOC USB-60 patch

<eranian@frankl.hpl.hp.com>:
  o efirtc update

<erik@aarg.net>:
  o USB: added support for Palm Tungsten T devices to visor driver

<ganesh@tuxtop.vxindia.veritas.com>:
  o USB ipaq: brown paper bag bug - uninitialized spinlock fixed
  o USB ipaq: added support for insmod options to specify vendor/product id

<gronkin@nerdvana.com>:
  o [netdrvr tulip] new pci id

<henning@meier-geinitz.de>:
  o [PATCH 2.4.20-rc1] scanner.h: add/fix vendor/product ids

<m.c.p@wolk-project.de>:
  o ide-scsi update to new IDE
  o Remove IDE init calls from blk_dev_init (IDE merge)
  o Add missing system.h bits (IDE merge)

<marcel@holtmann.org[holtmann]>:
  o [Bluetooth] Add RFCOMM protocol support
  o [Bluetooth] UART driver update
  o [Bluetooth] Add HCI UART PC Card driver
  o [Bluetooth] Add BCSP TXCRC option

<nicolas.mailhot@laposte.net>:
  o AGP support for VIA KT400

<oliver@oenone.homelinux.org>:
  o use of unplugged scanner oops fix

<petkan@tequila.dce.bg>:
  o USB: pegasus: the kmalloc/kfree crap removed from [get|set]_registers();

<plcl@telefonica.net>:
  o usb-midi patch for 2.4.20-pre11

<srompf@isg.de>:
  o [netdrvr starfire] add netif_carrier_{on,off} calls

<stelian@popies.net>:
  o sonypi driver update
  o meye driver update
  o export pci symbols for pcmcia modules

<tvrtko@net4u.hr>:
  o usb-uhci, fixed memory leak with one-shot interrupt transfers

<will@sowerbutts.com>:
  o USB: add USB powermate driver

<wstinson@wanadoo.fr>:
  o [netdrvr de620] remove unneeded, and ifdef'd out, check_region call

Adam Kropelin <akropel1@rochester.rr.com>:
  o [netdrvr ewrk3] fix and enable ethtool phys-id ioctl
  o [netdrvr ewrk3] allow user to change MAC address via SIOCSIFHWADDR

Adrian Bunk <bunk@fs.tum.de>:
  o CONFIG_AGP_AMD_8151 Configure.help entry
  o Fix pcmcia_net link error

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ppc stuff for new ide layer
  o update mousedriver docs as in 2.5
  o bring loop device up to date
  o parisc mux console config
  o add scx200 drivers
  o work around ALi magick chipset hangs with video capture
  o fix cyclades resource handling
  o vendor update for mpt fusion
  o pcmcia networking updates
  o lanstreamer updates
  o pcmcia parport update
  o new pci ids
  o reserve some I/O ports on the ATI radeon IGP
  o new pci idents
  o pcmcia core updates from David Hinds
  o backport 2.5 advansys off by one fix
  o ac IDE merge
  o t128 compile fix if non modular
  o core code for new nsp32 driver
  o fix ac97 string formatting errors
  o fix mad16 bugs
  o some laptops need longer delay
  o make cdcether work
  o latest i810 audio update
  o BeOS fs updates
  o fix off by one in module loader rename of module
  o work around 8253 timer funnies
  o ensure memcpy_to/from_io don't prefetch
  o Sort out the tachyon driver

Andrew Morton <akpm@digeo.com>:
  o Fix for the ext3 data=journal unmount problem

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o Add support for JTEC FA8101 USB to Ethernet device

Charles White <charles.white@hp.com>:
  o Add support for the SA641, SA642 and SA6400 controllers

Christoph Hellwig <hch@lst.de>:
  o small sd error handling fix
  o update scsi largelun blacklist
  o make flock Posix 2001 compatible

Christoph Hellwig <hch@sgi.com>:
  o cleanup b_inode usage and fix onstack inode abuse
  o backport 2.5 inode allocation changes
  o fix memory leak in sd.c

Dave Jones <davej@suse.de>:
  o Intel cache handling fixes

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o Add more statistics to /proc/fs/jfs/ to help with performance tuning
  o JFS: Avoid writing partial log pages for lazy transactions
  o JFS: forced metadata pages were not being flushed to disk
  o jfs_clear_inode should skip bad inodes instead of choking on them
  o JFS: Move index table out of directory inode's address space
  o JFS: Fix off-by one error when symlink size == 256 bytes
  o JFS: flush pending commit records to journal during unmount
  o jfs_truncate needs to call block_truncate_page

David Brownell <david-b@pacbell.net>:
  o usbnet talks to Zaurus

David Brownell <dbrownell@users.sourceforge.net>:
  o USB:  USB 2.0 controller and hubs bugfixes

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC]: Ignore SIGURG if not caught
  o [SPARC]: NR_IRQS is off by one
  o [SPARC64]: Fix dnotify_parent call in do_readv_writev32
  o [SPARC64]: Add some missing semicolons newer gcc warns about
  o [SPARC64]: Add -finline-limit=100000 to CFLAGS if gcc supports it
  o [SPARC64]: Clobber register l1 in switch_to if gcc >= 3.0
  o [SPARC]: Synchronize MAINTAINERS entry with 2.5.x
  o [SPARC]: Fix dependency on previous NR_IRQS value
  o [SPARC64]: Export __flush_dcache_range
  o [SPARC64]: Update defconfig
  o [SPARC]: Implement local_irq_set
  o [SPARC64]: Fix read_pil_and_sti

Edward Peng <edward_peng@dlink.com.tw>:
  o dl2k net driver update from vendor
  o [netdrvr dl2k] only read 0x100 through 0x150 statistics registers if mem mapping

Eric Brower <ebrower@usa.net>:
  o [SPARC]: Make APC idle a boot time cmdline option

Greg Kroah-Hartman <greg@kroah.com>:
  o Cset exclude: acme@conectiva.com.br|ChangeSet|20021011180213|25533
  o USB: added support for Clie NX60 device
  o removed vicamurbs.h
  o USB: added Palm Tungsten W support

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: alcor and sable fixes
  o alpha misc fixes
  o alpha initrd fix
  o asm-alpha/regdef.h
  o alpha __stxncpy fixes
  o Fixup Alpha IDE PCI

Jeff Garzik <jgarzik@redhat.com>:
  o Add 00-INDEX file describing contents of Documentation/BK-usage directory
  o Small clarification in BK kernel howto
  o In several drivers, use pci_[gs]et_drvdata instead of directly referencing struct pci_dev::driver_data.
  o [net drivers] update hamachi and starfire to use MII lib
  o Update my email address
  o Remove performance barrier in i810_rng char driver
  o [netdrvr bmac] remove init_timer call that was erroneously removed
  o [netdrvr fealnx] remove bogus line due to patch error
  o [netdrvr] add "r8169", a new Realtek 8169 gigabit ethernet driver
  o [netdrvr r8169] large style cleanup
  o [netdrvr r8169] minor functional cleanups and bug fixes
  o Handle internal proc_register failure in proc_symlink, proc_mknod, proc_mkdir, and create_proc_entry.
  o [netdrvr] Make a special section in drivers/net/Makefile for
  o [netdrvr sunhme] remove memset in init, alloc_etherdev does it for us
  o [netdrvr] fix Stanford checker buffer overflows in ni52, 3c523 (rarely if ever would be hit)
  o [netdrvr 3c515] fix unlikely buffer overrun when >8 adapters present
  o [netdrvr] zap PCI_VPD_ADDR constants from skfp, sk98lin drivers
  o [netdrvr r8169] use pci_[gs]et_drvdata instead of pdev->driver_data
  o Clarify locking/context docs for network interfaces, in Documentation/networking/netdevices.txt.

Joe Burks <joe@wavicle.org>:
  o Vicam patch against 2.4.20-pre9

John Stultz <johnstul@us.ibm.com>:
  o Summit chipset support: Clustered apic tweaks
  o Summit chipset support: Logical/Physical apicid additions
  o Summit chipset support: CLUSTERED_APIC_XAPIC switches
  o Summit chipset support: CONFIG_X86_SUMMIT, auto-detection, cleanup

Juan Quintela <quintela@mandrakesoft.com>:
  o Fix journalling api documentation

Kent Yoder <key@austin.ibm.com>:
  o [netdrvr lanstreamer] a fix and a feature addition

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o RFCOMM TTY fixes
  o BNEP fixes
  o HCI UART fixes
  o Fix typo in hci_usb_open() (MAX_BULK_TX -> MAX_BULK_RX)
  o Fix L2CAP client/server PSM clash
  o Fix hci_dev_get_list() for big endian machines
  o Ordinary users are not allowed to use raw L2CAP sockets
  o BNEP extension headers handling fix

Manfred Spraul <manfred@colorfullife.com>:
  o [netdrvr 8139too] skb_copy_and_csum_dev use allows us to enable the NETIF_F_HIGHDMA feature.

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Module description cleanup for BNEP
  o [Bluetooth] Config cleanup for BNEP
  o [Bluetooth] Add HCI id for Bluetooth PCI cards
  o [Bluetooth] Support for suspend/resume interface for HCI devices
  o [Bluetooth] Fix typo in role change event size
  o [Bluetooth] Cosmetic changes to the config files
  o [Bluetooth] Initialize hardware broadcast
  o [Bluetooth] Check for signals while waiting for DLC
  o [Bluetooth] Fix operator precedence for modem status
  o [Bluetooth] Don't do wakeup if protocol is not set
  o [Bluetooth] Fix some bits of the modem status handling
  o [Bluetooth] Free skbs with kfree_skb() instead of kfree()
  o [Bluetooth] Fix another operator precedence for modem status
  o [Bluetooth] Update help entry for CONFIG_BLUEZ
  o [Bluetooth] The function l2cap_do_connect() should be static
  o [Bluetooth] Don't use %d notation for non devfs name field of tty_driver
  o Disable bluetooth.o if Bluetooth subsystem is used

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o megaraid driver update
  o Update gdth driver
  o Cset exclude: akpm@digeo.com|ChangeSet|20021202135530|52474
  o Backout wrong change of gdth update
  o Cset exclude: khalid_aziz@hp.com|ChangeSet|20021129142249|58780
  o Add missing x86 system.h bits from IDE -ac merge
  o Changed EXTRAVERSION to -pre1
  o Cset exclude: raul@pleyades.net|ChangeSet|20021210155107|09736
  o Cset exclude: hch@lst.de|ChangeSet|20021210165533|06540

Matt Domsch <matt_domsch@dell.com>:
  o aacraid Dell PERC 320/DC support

Matthew Wilcox <willy@debian.org>:
  o update lasi_82596 net driver to use spinlock instead of cli/sti
  o Add PCI-X register definitions

Olaf Hering <olh@suse.de>:
  o minor fixes for compile warnings in 2.4.20pre11 , usb-2.4 tree

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Clobber l3 in context switch
  o [SPARC]: kill NR_IRQS + 1 stuff

Randy Dunlap <randy.dunlap@verizon.net>:
  o USB: use time_before() to compare times
  o tiglusb timeouts

Randy Dunlap <rddunlap@osdl.org>:
  o USB requires MIDI

Richard Henderson <rth@dorothy.sfbay.redhat.com>:
  o [ALPHA] Add local_irq_set
  o [ALPHA] Fix asm clobber problem diagnosed by current gcc 3.3 snap
  o CREDITS

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: Fix loop terminator in iommu_get_scsi_sgl_pflush

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr ns83820] fix oops in ioctl, and initialize dev->priv to prevent such slipups again
  o [netdrvr via-rhine] version bump, C99 initializers
  o [netdrvr via-rhine] fix up strange C99 notation in previous patch

Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>:
  o Kill unneeded declaration from drivers/scsi/sim710.h

Romain Lievin <rlievin@free.fr>:
  o USB: tiglusb sync with 2.5

Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver: remove driver-isolated flag/lock

Takayoshi Kouchi <t-kouchi@mvf.biglobe.ne.jp>:
  o ACPI PCI hotplug updates

Tim Waugh <twaugh@redhat.com>:
  o 2.4.20: fix aladdin card hang

