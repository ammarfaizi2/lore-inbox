Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTB0GEd>; Thu, 27 Feb 2003 01:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTB0GEd>; Thu, 27 Feb 2003 01:04:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10649 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261205AbTB0GEZ>; Thu, 27 Feb 2003 01:04:25 -0500
Date: Thu, 27 Feb 2003 03:14:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre5
Message-ID: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre5.


Summary of changes from v2.4.21-pre4 to v2.4.21-pre5
============================================

<ajoshi@kernel.crashing.org>:
  o rivafb 0.9.4 update

<alex_williamson@hp.com[helgaas]>:
  o ia64: fix typo in ia32_support.c

<andrew.wood@ivarch.com>:
  o USB: USB-MIDI support for Roland SC8820

<arun.sharma@intel.com[helgaas]>:
  o ia64: ia32 emulation layer bug fix

<bbosch@iphase.com>:
  o [netdrvr ns83820] big endian fixes

<benh@zion.wanadoo.fr>:
  o Fix a bug in the workaround for closed P2P bridge IO windows which could actually break bridges that didn't need fixing
  o Export atomic_{clear,set}_mask for modules
  o Request Open Firmware to open all "display" devices instead limiting us to the first one. This helps getting all cards properly POSTed
  o Prevent the stack from growing on reads. This works around a problem with the mount syscall calling copy_mount_options() which can trigger a fault via copy_from_user() between the last core VMA and the stack.
  o Properly fixup the Winbond W83C553 IDE on Longtrail and BriQ's so the controller is switched to fully native mode and interrupts are configured properly
  o Fix serial table for BriQ hardware (different base clock) and make sure it works with CONFIG_VT
  o Fix a warning
  o Make sure xmon doesn't try to tap a hash table when none exist
  o Add asm byteswapped 64 bits accessors
  o Rework inline syscall macros, fix clobbers & gcc3.3 (From Franz Sirl)
  o Remove old gross hack that did nothing good

<bergner@vnet.ibm.com>:
  o Remove kdb from PowerPC-64
  o ppc64 updates to 2.4.21-pre4

<bjorn_helgaas@hp.com[helgaas]>:
  o ia64: Add local_irq_set() and save_and_sti()
  o ia64: Use IA64_PSR_I rather than (1UL << 14)
  o ia64: Reverse SGI scatterlist changes so SGI update will apply
  o ia64: Simple ndelay implementation
  o ia64: Add some default configs
  o ia64: whitespace fixes
  o ia64: add infrastructure for multiple IO port spaces
  o ia64: add support for MMIO and IO port spaces from ACPI _CRS
  o ia64: add iomem_resource and ioport_resource allocation
  o ia64: update defconfigs
  o Rename configs

<cniehaus@handhelds.org>:
  o spelling fix for drivers_usb_usbnet.c

<d3august@dtek.chalmers.se>:
  o USB: small uhci bug

<dave@thedillows.org>:
  o The initial release of the driver for the 3Com 3cr990 family

<davidm@tiger.hpl.hp.com[helgaas]>:
  o ia64: For ia32 emulation, do not turn on O_LARGEFILE automatically
  o ia64: Don't risk running past the end of the unwind-table.  Based on a patch by Suresh Siddha.

<davidm@wailua.hpl.hp.com[helgaas]>:
  o ia64: Fix ia64_fls() so it works for all possible 64-bit values

<eranian@frankl.hpl.hp.com[helgaas]>:
  o ia64: new perfmon patch for 2.4.20
  o ia64: perfmon update

<green@linuxhacker.ru>:
  o radio-cadet compile fix

<henning@meier-geinitz.de>:
  o USB scanner.c: Adjust syslog output

<ionut@badula.org>:
  o VLAN support, 64-bit support, bugfixes

<jbarnes@sgi.com>:
  o MAINTAINERS update for 2.4 SN support

<jgarzik@pobox.com>:
  o Fix undefined references for smp + apm

<jh@sgi.com[helgaas]>:
  o ia64: Update SGI SN files

<jochen@scram.de>:
  o [tokenring smctr] fix MAC address input
  o [tokenring madgemc] fix memory leak, add proper refcounting

<kare.sars@lmf.ericsson.se>:
  o [atm nicstar] fix incorrect traffic class assumption

<m.c.p@wolk-project.de>:
  o Speedup 'make dep'

<meissner@suse.de>:
  o [netdrvr pcnet32] fix multicast on big endian

<mikal@stillhq.com>:
  o Handle scsi_register() failure

<p.guehring@futureware.at>:
  o USB: FTDI driver, new id added

<peter@bergner.org>:
  o PPC64 update

<raul@pleyades.net>:
  o mmap.c corner case fix

<sprite@sprite.fr.eu.org>:
  o [SPARC64]: Avoid use of -e option with echo

<stelian@popies.net>:
  o sonypi and input subsystem integration
  o CREDITS update
  o use correct gcc flags when compiling for
  o sonypi driver update
  o make mousedev accept the jogdial
  o meye suspend/resume capabilities

Adrian Bunk <bunk@fs.tum.de>:
  o fix compile error with two IrDA drivers

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ACPI apparently wasnt bios
  o fix wrong date in microcode comment
  o add another legitimate P4 type
  o must disallow write combine on 450NX
  o add framework for ndelay (nanoseconds)
  o first block of parisc resend
  o second block of parisc merge
  o third block of parisc merge
  o Ian Nelson moved
  o update videobook docs to avoid check_region
  o docs for IPMI
  o remove dead init call
  o add AMD hammer rng
  o IPMI driver updates
  o keyboard changes
  o fix wrong test in raw driver
  o fix paths for ide
  o clarify hpt37x config
  o fix more ide paths
  o Paul's fix to do ide_cs handling in task context
  o more ide paths
  o fix use of check_region in umc driver
  o more ide comment/doc info updates
  o promise printk cleanups
  o another wrong path
  o IDE printk/cleanup bits
  o fix serverworks paths/docs
  o clean up the siimage driver
  o update sis driver comments/docs/notes
  o update PIIX driver to know about more errata
  o fix winbond driver for new ide
  o more ide doc/comment updates
  o fix ppc ide paths
  o Ide raid updates
  o fix sbp2 compile failure
  o fix unsafe signed wrap check in pcilynx
  o use kbd_refresh_leds to keep USB/base keyboad lights right
  o clean up radio-cadet locking
  o use skb_padto to fix 3c527 padding
  o fix typo in 3c523 fixups
  o fix ethernet padding on 82596
  o fix ethernet padding on ariadne
  o fix ethernet padding on a2065
  o fix ethernet padding on atarilance
  o fix ethernet padding on am79c961a
  o fix ethernet padding on bagetlance
  o fix ethernet padding on declance
  o fix padding on depca
  o fix padding on eepro driver
  o fix padding on eexpress driver
  o fix ethernet padding on fmv18x
  o fix e2100 crash
  o fix ethernet padding on eth16i
  o fix ethernet padding on lasi
  o fix padding on epic100 driver
  o fix ethernet padding on lp486e
  o fix ethernet padding on lancr
  o fix padding on fmvj18x_cs
  o fix ethernet padding on hp100
  o fix ethernet padding on pcmcia/ray_cs
  o fix ethernet padding on xircom
  o fix ethernet padding on r8169
  o fix ethernet padding on seeq8005
  o fix padding on smc9194
  o fix padding on via_rhine
  o fix padding on yellowfin
  o fix padding on znet
  o fix padding on wavelan
  o update pci.ids for syskonnect
  o add 450NX streaming quirk, add via northbridge detect
  o fix dpt_i2o out of memory check
  o fix eata_generic jiffies check
  o document an ICH errata we have to deal with
  o fix sb_mixer handling
  o dont fail on 5451 reset
  o ide.h changes
  o add prototypes for kbdrefresh_leds
  o add skb_padto operation
  o fix ipc/msg race by dropping optimisation out
  o add skb_pad operation
  o copy OUTBSYNC operation too
  o fix the ide irq masking bug Ross found
  o fix confusing extra DMA off messages
  o add but dont yet use ide_execute_comman
  o sk98 driver vendor update

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Patches for the ECONNRESET error (2.4)

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [TCP]: Do not forget data copy while collapsing retransmission queue

Andi Kleen <ak@muc.de>:
  o [IPV4]: Better behavior for NETDEV_CHANGENAME requests
  o x86-64 update
  o Workaround for AMD 8131 bug
  o Fix get_vm_area

Andrea Arcangeli <andrea@suse.de>:
  o xdr nfs highmem deadlock fix

Andrew Morton <akpm@digeo.com>:
  o ia32 syscall compatibility stubs

Andrey Panin <pazke@orbita1.ru>:
  o [netdrvr eepro100] add config option for PIO register read/write

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Implement workarounds for errata on recent G3 and G4 cpus

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: Delete all SGI SN defconfig files
  o ia64: Dont execute srlz.d needlessly (reported by Chris Ruemmler)
  o ia64: smp_threads_ready: make non-volatile
  o don't swapon mounted devices
  o ia64: Use has_8259 rather than initdata
  o ia64: Really remove ACPI SPCR parsing
  o Cset exclude: eranian@frankl.hpl.hp.com[helgaas]|ChangeSet|20030103231109|26349
  o ia64: fix perfmon typo (PFM_CPU_SYST_WIDE should be PFM_CPUINFO_SYST_WIDE)

Christoph Hellwig <hch@sgi.com>:
  o handle too large vmallocs gracefully

Dave Jones <davej@codemonkey.org.uk>:
  o [netdrvr sunqe] remove incorrect kfree()

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: replace ugly JFS debug macros with simpler ones
  o JFS: Minor update in Documentation/filesystems/jfs.txt
  o JFS: implement get_index_page to replace some uses of read_index_page
  o JFS: Add debug code to help catch elusive bug
  o JFS: simplify jfs_err() to avoid parsing bug in gcc-2.95
  o JFS: Fix jfs_sync_fs

David Brownell <david-b@pacbell.net>:
  o USB: ehci-hcd, more hangs gone

David Gibson <david@gibson.dropbear.id.au>:
  o PPC32: Add work-around for erratum #77 on IBM 405 processors
  o Update orinoco driver to 0.13b

David S. Miller <davem@nuts.ninka.net>:
  o [TG3]: Let chip do pseudo-header csum on rx
  o [TG3]: Add device IDs for 5704S/5702a3/5703a3
  o [TG3]: Prevent dropped frames when flow-control is enabled
  o [TG3]: Correct MIN_DMA and ONE_DMA settings in dma_rwctrl
  o [TG3]: Workaround 5701 back-to-back register write bug
  o [TG3]: Add workaround for third-party phy issues
  o [TG3]: Remove anal grc_misc_cfg board IDs check
  o [TG3]: Fix typos in previous changes
  o [TCP]: In tcp_check_req, handle ACKless packets properly
  o [SPARC]: Add ndelay
  o [SPARC]: Add ndelay ksyms export

David Woodhouse <dwmw2@infradead.org>:
  o Export skb_pad() in 2.4.21-pre4

Gerd Knorr <kraxel@bytesex.org>:
  o bttv documentation update
  o tuner module update
  o video4linux i2c modules update
  o bttv update

Gerd Knorr <kraxel@suse.de>:
  o bttv config fix

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: hid blacklist update
  o USB: more hid blacklist items
  o USB: added tripp device id's to pl2303 driver

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha dma fix
  o alpha update

Jay Vosburgh <fubar@us.ibm.com>:
  o [netdrvr 3c59x] move netif_carrier_off() call outside vortex_debug test

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o arch/i386/Makefile: fix Via C3 build flags with gcc 3.<recent>

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] bump version, tidy comments
  o [netdrvr amd8111e] remove stray ';', fixing register dump [#311]
  o [netdrvr tg3] DMA MRM bit only exists on 5700, 5701
  o [netdrvr fc/iphase] correct PCI probe loop-end test logic [#323]
  o [tokenring smctr] remove stray ';' that prevented a loop from working [#312]
  o [ARM] CREDITS, MAINTAINERS, Documentation/arm/* updates
  o [ARM] misc janitorial cleanups for arch/arm/kernel
  o [ARM] misc janitorial cleanups for arch/arm/mach*, arch/arm/mm
  o [ARM] misc janitorial cleanups for include/asm-arm
  o [netdrvr 8390] if ARM, only redefine EI_SHIFT, not I/O macros
  o [netdrvr] add new ARM net drivers cirrus, ether00
  o [netdrvr bmac] Remove unneeded memset()
  o [netdrvr 8139too] add some boards to the list of tested boards
  o [netdrvr tg3] disable 5701 h/w bug workaround during core clock reset
  o [netdrvr tg3] fix NAPI deadlock
  o [netdrvr tg3] bump version to 1.4c / Feb 18
  o [netdrvr tg3] properly synchronize with TX, in tg3_netif_stop
  o [netdrvr tg3] fix TX race in previous code, and another buglet
  o [netdrvr] Update Doc/networking/netdevices.txt with more locking rules

Jens Axboe <axboe@suse.de>:
  o Remove unused node from ide-probe.c
  o Andrea's elevator backmerge patch]

Johannes Erdfelt <johannes@erdfelt.com>:
  o usb_get_driver_np() gives wrong driver name (usb_mouse)
  o USB: OHCI trivial remove unused field
  o USB: 2.4 OHCI trivial comment cleanup

John Stultz <johnstul@us.ibm.com>:
  o Fix target_cpus()

Kurt Garloff <garloff@suse.de>:
  o Handle SCSI recovered errors

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o [Bluetooth] Add support for vendor specific commands

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20030224224251|29662
  o Changed EXTRAVERSION to -pre5
  o Define kmap_nonblock() for non highmem

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix our L2 / L3 cache updates for the bootloader

Martin Devera <devik@cdi.cz>:
  o [NET_SCHED]: HTB scheduler updates from Devik

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 base architecture update
  o xpram driver fix for 64-bit
  o s390 idals.h update

Matthew Wilcox <willy@debian.org>:
  o [wireless airo] call pci_enable_device, pci_set_master where needed

Olaf Hering <olh@suse.de>:
  o ide_fix_driveid unresolved in usb-storage

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Fix DIRECT IO interference with tail packing

Oliver Neukum <oliver@neukum.name>:
  o USB: 2.4 ehci uses SLAB_KERNEL in interrupt
  o USB: kaweth length calculation fix
  o USB: new device id for kaweth

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix the clone syscall, and make exec clear fp and vr registers
  o PPC32: Clean up exception and oops handling
  o PPC32: Tighten up the stack expansion code
  o PPC32: Fix handling of alignment traps on some PPC processors
  o PPC32: Actually use the FP exception mode requested with prctl()
  o PPC32: use the standard __stringify instead of a local version
  o PPC32: Further fixes for the stack expansion code
  o PPC32: add ndelay(), update udelay() to be more accurate and robust
  o PPC32: Minor cleanups in the CHRP platform code
  o PPC32: Allow for RAM not starting at 0, for APUS (and potentially others)
  o PPC32: PReP platform fixes from Hollis Blanchard, Tom Rini, Leigh Brown and others
  o PPC32: Fixes for byte-swapping macros, from Franz Sirl
  o PPC32: PCI fixes.  We can now restrict I/O windows to 16MB or so because this code lets us move the I/O windows of PCI-PCI bridges if necessary.
  o PPC32: Fix copy_from_user to copy as much as possible even when it gets a fault
  o PPC32: Provide a default implementation of ide_init_hwif_ports in asm-ppc/ide.h and use it if there is no platform-specific version.
  o PPC32: fix compilation error in arch/ppc/platforms/pmac_setup.c
  o PPC32: Move some variable declarations related to the MMU hash table to <asm/mmu.h>

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC32]: Backport fixes from 2.5.x

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus update (2.4)

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr via-rhine] trivial bits
  o [netdrvr via-rhine] fix broken tx-underrun handling
  o [netdrvr via-rhine] various duplex-related fixes
  o [netdrvr via-rhine] reset function rewrite
  o [netdrvr via-rhine] bump version, use constant instead of magic number

Rusty Russell <rusty@rustcorp.com.au>:
  o namespace pollution in procfs
  o arch_ia64_sn_io_sn1_pcibr.c, typo: the the
  o misc register audit fix on qtronix
  o duplicate header in drivers_bluetooth_hci_h4.c
  o write with buffer>2GB returns broken errno
  o misc register audit fix on ppc64's nvram.c
  o USB: Clean up some USB macros
  o available spell fixes
  o correct description of Griffin Powermate
  o namespace pollution in eth bridge driver
  o drivers_net_wan_sdla_x25.c, typo: the the
  o es1372.c doesn't free resources correctly
  o Typos in drivers_s390_net_iucv.c
  o i2c ID addition
  o NCR5380 unbalanced curly brace
  o Fix floppy.h's CROSS_64KB()

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e100] math fixes and a cleanup

Stephen C. Tweedie <sct@redhat.com>:
  o Fix signed use of i_blocks in ext3 truncate

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Change the MPC8xx IRQ code so that things are arranged like other systems.
  o PPC32: Enable PCMCIA and a tested wifi card on some MPC8xx targets
  o PPC32: Change the MontaVista copyright / GPL boilerplate to a condensed version.
  o PPC32: Fix an oops on hardware without an RTC in timer_interrupt()
  o PPC32: Fix building of the IBM Spruce platform and !CONFIG_SERIAL
  o PPC32: Fix some gcc-3.x warnings on the IBM Spruce
  o PPC32: Cleanup the boot code to better deal with no console
  o PPC32: Minor KGDB warning fixes
  o PPC32: Add CONFIG_KGDB_CONSOLE to MPC 8xx systems
  o PPC32: MPC8xx KGDB fixes, from Dan Malek
  o PPC32: Add KGDB support for the IBM Spruce platform
  o PPC32: Ask about CONFIG_BOOTX_TEXT in the 'Kernel hacking' menu
  o PPC32: Put reading of PReP/PPCBUG nvram into CONFIG_PPCBUG_NVRAM
  o PPC32: Add support for the Motorola LoPEC platform
  o PPC32: Remove the 'BK Id' tags from files
  o PPC32: Fix SysRq on IBM Spruce

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix XID allocation race in 2.4.21-pre4

Wolfgang Muees <wolfgang@iksw-muees.de>:
  o USB: updated Auerswald driver

