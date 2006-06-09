Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWFIWGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWFIWGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWFIWGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:06:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:12449 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030539AbWFIWGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:content-disposition:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=eWRLxSrvxLO1QWqcOIACuHHYcNr1esumaoCMXxznMvhDgcdvB1TB4VfaXeEeVrw42mgx+e+DLurGnA5LvDlgbkfk/mHNxKkbruLvIyahey3EXF+NNhxvRsQF9m78NRqu94GspnK/psQ+9SWjN6roTkYqCQchEUgswfZofOeKdAw=
Content-Disposition: inline
From: Jonathan Jara-Almonte <jonjara@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: CardBus cards not detected, PCMCIA cards are
Date: Fri, 9 Jun 2006 17:01:42 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200606091701.42268.jonjara@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I was asked to CC this message concerning a Compaq Presario 2100US's 
inability to list CardBus cards in lspci to this mailing list.

----------  Forwarded Message  ----------

Subject: Re: CardBus cards not detected, PCMCIA cards are
Date: Friday 09 June 2006 16:57
From: Jonathan Jara-Almonte <jonjara@gmail.com>
To: linux-pcmcia@lists.infradead.org, Larry Finger 
<Larry.Finger@lwfinger.net>, linux@dominikbrodowski.net

On Friday 09 June 2006 16:38, Dominik Brodowski wrote:
> Hi,
>
> On Fri, Jun 09, 2006 at 04:21:50PM -0500, Jonathan Jara-Almonte wrote:
> > and with a card in:
> >
> > 00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP
> > 340M] (rev 02)
> > 00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M]
> > 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> > 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
> > Controller Audio Device (rev 02)
> > 00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge
> > [Aladdin IV/V/V+]
> > 00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller
> > 00:0a.0 CardBus bridge: O2 Micro, Inc. OZ601/6912/711E0
> > CardBus/SmartCardBus Controller
> > 00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
> > 00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
> > 00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
> > (MacPhyter) Ethernet Controller
> > 01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP
> > 330M/340M/350M
> >
> >
> > as you can see there are no differences, and even if I use a -vvv flag no
> > differences appear between the two. So what should I try next?
>
> What's the "dmesg" output? And which kernel do you use?
>
> 	Dominik

Addressing both of you at once since your remarks were similar. Same thing
happens when I insert the card before booting and you're right I do have the
problem that sometimes the card is not recognized when I put it in (the power
light does not come on then).

kernel is gentoo-sources-2.6.16-r8

dmesg output is:

000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bf70000 (usable)
 BIOS-e820: 000000000bf70000 - 000000000bf7f000 (ACPI data)
 BIOS-e820: 000000000bf7f000 - 000000000bf80000 (ACPI NVS)
 BIOS-e820: 000000000bf80000 - 000000000c000000 (reserved)
 BIOS-e820: 000000001bf80000 - 000000001c000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49008
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 44912 pages, LIFO batch:7
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6ae0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0bf78e73
ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x0bf7ef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0bf7efd8
ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 20000000 (gap: 1c000000:e3f80000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 video=vesafb:mtrr:3,ywrap,1024x768-32@60
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1594.945 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 190040k/196032k available (2635k kernel code, 5504k reserved, 758k
data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3194.88 BogoMIPS
(lpj=6389760)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
00000400 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
 00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00000400
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Celeron(R) CPU 1.60GHz stepping 07
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0420)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd89b, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 7 *10)
ACPI: Embedded Controller [EC0] (gpe 24) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
 report pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x480-0x48f has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:07: ioport range 0x8000-0x807f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: d0300000-d03fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Enabling device 0000:00:0a.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) ->
IRQ 11
Simple Boot Flag at 0x37 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1149889984.196:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Ati IGP330/340/345/350/M chipset
agpgart: AGP aperture is 64M @ 0xd4000000
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) ->
IRQ 10
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=14.32 MHz (RefDiv=31) Memory=183.00 Mhz, System=133.00
 MHz radeonfb: PLL min 12000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: QDI141X1LH03
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 128x48
radeonfb (0000:01:05.0): ATI Radeon C7
vesafb: ATI Technologies Inc., MS2 , 01.00 (OEM: ATI RS200M  )
vesafb: VBE version: 2.0
vesafb: protected mode interface info at c000:51af
vesafb: pmi: set display start = c00c5243, set palette = c00c528f
vesafb: pmi: ports = 9010 9016 9054 9038 903c 905c 9000 9004 90b0 90b2 90b4
vesafb: no monitor limits have been set
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: cannot reserve video memory at 0xd8000000
vesafb: framebuffer at 0xd8000000, mapped to 0xcd900000, using 6144k, total
65472k
fb1: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (45 C)
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNK6] -> GSI 10 (level, low) ->
IRQ 10
0000:00:08.0: ttyS1 at I/O 0x1428 (irq = 10) is a 8250
0000:00:08.0: ttyS2 at I/O 0x1440 (irq = 10) is a 8250
0000:00:08.0: ttyS3 at I/O 0x1450 (irq = 10) is a 8250
Couldn't register serial port 0000:00:08.0: -28
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x2348b3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNK1] -> GSI 10 (level, low) ->
IRQ 10
natsemi eth0: NatSemi DP8381[56] at 0xd0004000 (0000:00:12.0),
00:0b:cd:54:ad:51, IRQ 10, port TP.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: HITACHI_DK23EA-30, ATA DISK drive
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
ieee1394: raw1394: /dev/raw1394 device initialized
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
ip_conntrack version 2.4 (1531 buckets, 12248 max) - 172 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
PCI0 MDEM  LAN COM1  LID
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
kjournald starting.  Commit interval 5 seconds
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) ->
IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:002a]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000821
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNK8] -> GSI 10 (level, low) ->
IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 10, io mem 0xd0000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNK7] -> GSI 5 (level, low) ->
IRQ 5
usb 1-1: new full speed USB device using ohci_hcd and address 2
pccard: CardBus card inserted into slot 0
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using ohci_hcd and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full speed USB device using ohci_hcd and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new full speed USB device using ohci_hcd and address 5
usb 1-1: device not accepting address 5, error -110
cs: IO port probe 0xff40-0xff7f: clean.
cs: IO port probe 0xfc00-0xfcff: clean.
cs: IO port probe 0xfd00-0xfdff: clean.
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.
ali15x3_smbus 0000:00:11.0: ALI15X3_smb region uninitialized - upgrade BIOS
 or use force_addr=0xaddr
ali15x3_smbus 0000:00:11.0: ALI15X3 not detected, module not inserted.
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1 across:498004k
EXT3 FS on hda3, internal journal
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) ->
IRQ 10
[drm] Initialized radeon 1.22.0 20051229 on minor 0
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
eth0: DSPCFG accepted after 0 usec.
i2c_adapter i2c-4: Error: command never completed
i2c_adapter i2c-4: Error: command never completed
i2c_adapter i2c-4: Error: command never completed
i2c_adapter i2c-4: Error: command never completed
i2c_adapter i2c-4: Error: command never completed
i2c_adapter i2c-4: Error: command never completed
i2c_adapter i2c-4: Error: command never completed
usb 1-1: new full speed USB device using ohci_hcd and address 6
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 1 port detected
usb 1-1.1: new full speed USB device using ohci_hcd and address 7
usb 1-1.1: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 7
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Sony      Model: Storage Media     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
sda: Write Protect is off
sda: Mode Sense: 00 26 00 00
sda: assuming drive cache: write through
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
sda: Write Protect is off
sda: Mode Sense: 00 26 00 00
sda: assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
usb-storage: device scan complete
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0
sd 0:0:0:0: ioctl_internal_command return code = 8000002

   : Current: sense key=0x0

    ASC=0x0 ASCQ=0x0


lspci -vvv output is:

00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M]
(rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d0005000 (32-bit, prefetchable) [size=4K]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if
10 [OHCI])
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin
IV/V/V+]
	Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00
[Generic])
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1400 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ601/6912/711E0 CardBus/SmartCardBus
Controller
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0003000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 2000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at d0004000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 24000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA
 PME(D0+,D1+,D2+,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP
330M/340M/350M (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company Unknown device 002a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d0300000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at d0320000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
		Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks for the responses

-------------------------------------------------------
