Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVGFUoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVGFUoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVGFUlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:41:21 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:61057 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262514AbVGFUg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:36:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
Date: Wed, 6 Jul 2005 22:33:14 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <200507061128.49843.rjw@sisk.pl> <20050706164724.GB14165@kroah.com>
In-Reply-To: <20050706164724.GB14165@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KAEzChbNpuTO6hb"
Message-Id: <200507062233.14915.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_KAEzChbNpuTO6hb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday, 6 of July 2005 18:47, Greg KH wrote:
> On Wed, Jul 06, 2005 at 11:28:49AM +0200, Rafael J. Wysocki wrote:
> > PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.0
> > PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.1
> > PCI: Failed to allocate I/O resource #7:1000@e000 for 0000:02:01.1
> > PCI: Failed to allocate I/O resource #8:1000@e000 for 0000:02:01.1
> 
> Do you also get the above errors on booting with -rc1?

No, I don't.

> > PCI: Bus 3, cardbus bridge: 0000:02:01.0
> >   IO window: 0000b000-0000bfff
> >   IO window: 0000c000-0000cfff
> >   PREFETCH window: 30000000-31ffffff
> > PCI: Bus 7, cardbus bridge: 0000:02:01.1
> >   PREFETCH window: 32000000-33ffffff
> > PCI: Bridge: 0000:00:0a.0
> >   IO window: b000-dfff
> >   MEM window: f8a00000-feafffff
> >   PREFETCH window: 30000000-34ffffff
> > PCI: Bridge: 0000:00:0b.0
> >   IO window: disabled.
> >   MEM window: f6900000-f89fffff
> >   PREFETCH window: c6800000-e67fffff
> > PCI: Setting latency timer of device 0000:00:0a.0 to 64
> > PCI: Device 0000:02:01.0 not available because of resource collisions
> > PCI: Device 0000:02:01.1 not available because of resource collisions
> 
> And these?

No ...

> As this is your carbus bridge, I'm guessing that is why -rc2 
> is failing for you.

I guess so.

The dmesg output from -rc1 is attached for reference.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_KAEzChbNpuTO6hb
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg-rc1.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-rc1.out"

Bootdata ok (command line is root=/dev/hdc6 vga=792 selinux=0 noapic nmi_watchdog=0 resume=/dev/hdc3 console=ttyS0,57600 console=tty0 debug)
Linux version 2.6.13-rc1 (rafael@albercik) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #3 Tue Jul 5 22:35:19 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff40000 (usable)
 BIOS-e820: 000000002ff40000 - 000000002ff50000 (ACPI data)
 BIOS-e820: 000000002ff50000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f76e0
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000425 MSFT 0x00000097) @ 0x000000002ff40000
ACPI: FADT (v001 A M I  OEMFACP  0x05000425 MSFT 0x00000097) @ 0x000000002ff40200
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000425 MSFT 0x00000097) @ 0x000000002ff50040
  >>> ERROR: Invalid checksum
ACPI: DSDT (v001  L5DK8 L5DK8014 0x00000014 INTL 0x02002026) @ 0x0000000000000000
On node 0 totalpages: 196416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192320 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  <6>Product ID: L5D          <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Setting APIC routing to flat
Processors: 1
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hdc6 vga=792 selinux=0 noapic nmi_watchdog=0 resume=/dev/hdc3 console=ttyS0,57600 console=tty0 debug
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1795.378 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 767860k/785664k available (2847k kernel code, 17340k reserved, 1143k data, 176k init)
Calibrating delay using timer specific routine.. 3594.97 BogoMIPS (lpj=7189944)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
ACPI: setting ELCR to 0200 (from 0c20)
Using local APIC timer interrupts.
Detected 12.467 MHz APIC timer.
testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 37)
Losing some ticks... checking if CPU frequency changed.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LKLN] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAUI] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LKMO] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LATA] (IRQs 3 4 6 7 10 11 12 *14 15)
ACPI: Power Resource [GFAN] (off)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1120687738.336:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: framebuffer at 0xd0000000, mapped to 0xffffc20000100000, using 6144k, total 65536k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hdb: TOSHIBA DVD-ROM SD-R2512, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC25N060ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 1024KiB
hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
usbmon: debugs is not available
mice: PS/2 mouse device common for all mice
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 56Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
cpu_init done, current fid 0xa, vid 0x2
PM: Checking swsusp image.
swsusp: Resume From Partition /dev/hdc3
input: AT Translated Set 2 keyboard on isa0060/serio0
swsusp: Suspend partition has wrong signature?
swsusp: Error -22 check for resume file
PM: Resume from disk failed.
ACPI wakeup devices: 
 MDM P0P1 LAN0 LAN1 USB0 USB1 USB2 SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
kjournald starting.  Commit interval 5 seconds
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
spurious 8259A interrupt: IRQ7.
EXT3 FS on hdc6, internal journal
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
cdrom: open failed.
SCSI subsystem initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hdc9: found reiserfs format "3.6" with standard journal
ReiserFS: hdc9: using ordered data mode
ReiserFS: hdc9: journal params: device hdc9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc9: checking transaction log (hdc9)
cdrom: open failed.
ReiserFS: hdc9: Using r5 hash to sort names
ReiserFS: hdc10: found reiserfs format "3.6" with standard journal
ReiserFS: hdc10: using ordered data mode
ReiserFS: hdc10: journal params: device hdc10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc10: checking transaction log (hdc10)
ReiserFS: hdc10: Using r5 hash to sort names
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
st: Version 20050501, fixed bufsize 32768, s/g segs 256
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xfebfb000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 11, io mem 0xfebfc000
usb 1-2: new low speed USB device using ohci_hcd and address 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
usb 1-2: USB disconnect, address 2
usb 1-2: new low speed USB device using ohci_hcd and address 3
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Adding 1534196k swap on /dev/hdc3.  Priority:42 extents:1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:01.0 [1043:1854]
Yenta: ISA IRQ mask 0x0018, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xb000 - 0xdfff
pcmcia: parent PCI bridge Memory window: 0xf8a00000 - 0xfeafffff
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.1 [1043:1854]
Yenta: ISA IRQ mask 0x0098, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xb000 - 0xdfff
pcmcia: parent PCI bridge Memory window: 0xf8a00000 - 0xfeafffff
ds: ds_open(socket 0)
ds: ds_open(socket 1)
ds: ds_open(socket 2)
ds: ds_open(socket 2)
NET: Registered protocol family 17
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff804a8540(lo)
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3069 buckets, 24552 max) - 336 bytes per conntrack
Disabled Privacy Extensions on device ffff81002db8e480(sit0)
eth0: no IPv6 routers present
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LAUI] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 67044 usecs
intel8x0: clocking to 48000
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Thermal Zone [THRM] (53 C)
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
ds: ds_open(socket 0)
ds: ds_open(socket 0)
ds: ds_open(socket 0)
ds: ds_open(socket 0)
ds: ds_open(socket 0)
ds: ds_open(socket 0)
ds: ds_open(socket 0)
ds: ds_open(socket 0)

--Boundary-00=_KAEzChbNpuTO6hb--

