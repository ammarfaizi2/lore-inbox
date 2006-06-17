Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWFQFZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWFQFZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFQFZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:25:48 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:26884 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751532AbWFQFZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:25:47 -0400
Date: Sat, 17 Jun 2006 13:24:58 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Dave Jones <davej@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
In-Reply-To: <Pine.LNX.4.64.0606171315220.2812@raven.themaw.net>
Message-ID: <Pine.LNX.4.64.0606171323100.2433@raven.themaw.net>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
 <20060617034633.GC2893@redhat.com> <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net>
 <20060617044625.GA8328@redhat.com> <Pine.LNX.4.64.0606171315220.2812@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 5, autolearn=not spam)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006, Ian Kent wrote:

> On Sat, 17 Jun 2006, Dave Jones wrote:
> 
> > On Sat, Jun 17, 2006 at 12:02:30PM +0800, Ian Kent wrote:
> > 
> >  > >  > I've been having trouble with my Radeon card not working with X.
> >  > >  > 
> >  > >  > 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 
> >  > >  > 9550]
> >  > >  > 
> >  > >  > The only thing I can find that may be a clue is:
> >  > >  > 
> >  > >  > Jun 17 11:12:48 raven kernel: agpgart: Detected AGP bridge 0
> >  > >  > Jun 17 11:12:48 raven kernel: agpgart: unable to get memory for graphics 
> >  > >  > translation table.
> >  > >  > Jun 17 11:12:48 raven kernel: agpgart: agp_backend_initialize() failed.
> >  > >  > Jun 17 11:12:48 raven kernel: agpgart-amd64: probe of 0000:00:00.0 failed 
> >  > >  > with error -12
> >  > >  
> >  > > Is this with the free Xorg drivers, or the ATI fglx thing ?
> >  > > I don't think I've ever seen agp_generic_create_gatt_table() fail before,
> >  > > and that hasn't changed for a looong time.
> >  > 
> >  > xorg driver yep.
> > 
> > Bizarre, I have no ideas.
> > 
> > full dmesg ? lspci ?
> > This is running 64 bit mode or 32 ?
> 
> I'll boot without X to get this and yes x86_64.

Linux raven.themaw.net 2.6.16-1.2289_FC6xen #1 SMP Thu Jun 15 14:48:53 EDT 
2006 x86_64 x86_64 x86_64 GNU/Linux
----
Bootdata ok (command line is ro root=LABEL=/ rhgb quiet)
Linux version 2.6.16-1.2289_FC6xen (brewbuilder@hs20-bc2-3.build.redhat.com) (gcc version 4.1.1 20060612 (Red Hat 4.1.1-3)) #1 SMP Thu Jun 15 14:48:53 EDT 2006
BIOS-provided physical RAM map:
 Xen: 0000000000000000 - 000000003ad68000 (usable)
On node 0 totalpages: 241000
  DMA zone: 241000 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fac60
ACPI: XSDT (v001 A M I  OEMXSDT  0x12000506 MSFT 0x00000097) @ 0x000000003ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x12000506 MSFT 0x00000097) @ 0x000000003ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x12000506 MSFT 0x00000097) @ 0x000000003ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000506 MSFT 0x00000097) @ 0x000000003ffbe040
ACPI: DSDT (v001  A0347 A0347001 0x00000001 INTL 0x02002026) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to xen
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Xen reported: 1800.086 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Software IO TLB enabled: 
 Aperture:     2 megabytes
 Bus range:    0x0000000023a00000 - 0x0000000023c00000
 Kernel range: 0xffff880000bf9000 - 0xffff880000df9000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Memory: 926976k/964000k available (2308k kernel code, 36504k reserved, 1002k data, 164k init)
Calibrating delay using timer specific routine.. 4501.81 BogoMIPS (lpj=9003637)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Brought up 1 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 2262k freed
Grant table initialized
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7.P7P9._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7.P7P8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PA._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
xen_mem: Initialising balloon driver.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:07: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-bfff
  MEM window: ff500000-ff5fffff
  PREFETCH window: 97f00000-d7efffff
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:13.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:13.1
  IO window: c000-cfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:13.0 to 64
PCI: Setting latency timer of device 0000:02:00.0 to 64
PCI: Setting latency timer of device 0000:02:00.1 to 64
PCI: Setting latency timer of device 0000:00:13.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IA-32 Microcode Update Driver: v1.14-xen <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1150550389.596:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 65705BE9473BFB32
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:02:00.0 to 64
pcie_portdrv_probe->Dev[287c:1106] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:00.0:pcie00]
PCI: Setting latency timer of device 0000:02:00.1 to 64
pcie_portdrv_probe->Dev[287d:1106] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:02:00.1:pcie00]
ACPI: Processor [CPU1] (supports 16 throttling states)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: unable to get memory for graphics translation table.
agpgart: agp_backend_initialize() failed.
agpgart-amd64: probe of 0000:00:00.0 failed with error -12
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Xen virtual console successfully installed as ttyS0
Event-channel device installed.
blkif_init: reqs=64, pages=704, mmap_vstart=0xffff880039c00000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 0
VP_IDE: chipset revision 7
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8251 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1200JB-00EVA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ATAPI CD-ROM DRIVE 40X MAXIMUM, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for ATAPI CD-ROM DRIVE 40X MAXIMUM (blacklisted)
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
input: AT Translated Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 62
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1150550394.136:2): selinux=0 auid=4294967295
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
GSI 16 sharing vector 0xA0 and IRQ 16
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 16
eth0: VIA Rhine II at 0xff6ff400, 00:00:00:00:01:f8, IRQ 16.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 41e1.
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
USB Universal Host Controller Interface driver v3.0
GSI 17 sharing vector 0xA8 and IRQ 17
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 20 (level, low) -> IRQ 17
PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 17, io base 0x0000e080
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
GSI 18 sharing vector 0xB0 and IRQ 18
ACPI: PCI Interrupt 0000:00:10.1[C] -> GSI 22 (level, low) -> IRQ 18
PCI: VIA IRQ fixup for 0000:00:10.1, from 5 to 2
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000e000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 19 sharing vector 0xB8 and IRQ 19
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000dc00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 23 (level, low) -> IRQ 16
PCI: VIA IRQ fixup for 0000:00:10.3, from 3 to 0
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 16, io base 0x0000d880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
gameport: EMU10K1 is pci0000:05:0c.1/gameport0, io 0xcc00, speed 916kHz
usb 1-1: configuration #1 chosen from 1 choice
usb 1-2: new full speed USB device using uhci_hcd and address 3
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 22 (level, low) -> IRQ 18
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: debug port 1
ehci_hcd 0000:00:10.4: irq 18, io mem 0xff6ff800
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb 1-1: USB disconnect, address 2
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
GSI 20 sharing vector 0xC0 and IRQ 20
ACPI: PCI Interrupt 0000:05:0c.0[A] -> GSI 17 (level, low) -> IRQ 20
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
usb 1-1: new full speed USB device using uhci_hcd and address 4
lp0: using parport0 (interrupt-driven).
lp0: console ready
usb 1-1: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 1 alt 0 proto 2 vid 0x03F0 pid 0x3D11
usb 1-2: new full speed USB device using uhci_hcd and address 5
usb 1-2: configuration #1 chosen from 1 choice
Linux video capture interface: v1.00
pwc Philips webcam module version 9.0.2-unofficial loaded.
pwc Supports Philips PCA645/646, PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
pwc Also supports the Askey VC010, various Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
pwc the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
usbcore: registered new driver snd-usb-audio
pwc Logitech QuickCam 4000 Pro USB webcam detected.
pwc Registered as /dev/video0.
usbcore: registered new driver Philips webcam
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 594396k swap on /dev/hda2.  Priority:-1 extents:1 across:594396k
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
----
00:00.0 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
00:0f.0 IDE interface: VIA Technologies, Inc. VT8251 AHCI/SATA 4-Port Controller
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
00:11.0 ISA bridge: VIA Technologies, Inc. Unknown device 3287
00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
00:13.0 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCIE Bridge
00:13.1 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCI Bridge
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 9550]
01:00.1 Display controller: ATI Technologies Inc RV350 ?? [Radeon 9550] (Secondary)
02:00.0 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
02:00.1 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
05:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
05:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

