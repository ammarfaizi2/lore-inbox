Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWHGOec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWHGOec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWHGOec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:34:32 -0400
Received: from smtp.enter.net ([216.193.128.24]:29958 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750962AbWHGOeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:34:31 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI Resource Allocation Error
Date: Mon, 7 Aug 2006 10:34:27 -0400
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0901EgyVBhi2dB3"
Message-Id: <200608071034.28366.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_0901EgyVBhi2dB3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

After using 2.6.8 and 2.6.11 for a *long* time I decided to upgrade. When I 
first tried using 2.6.15 I tested a vanilla kernel and ran into the following 
message in the dmesg:

PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0

Since I'm running FC4 I figured that a fix might have made it into the distro 
supplied kernel, so I again upgraded, this time to 2.6.17-1.2142_FC4. I see 
the same message in the dmesg output, so I'm certain that it hasn't been 
fixed.

This is definately caused by my graphics card, an  NVidia GeForce 5200, just 
because that's the PCI ID of the AGP port.

I know a lot of you will tell me to file a report with RedHat, but after 
checking the LKML archives I see this problem was introduced around 2.6.13 
and though I saw some patches to fix this, I'm pretty certain they were 
either for x86-64 or were not ever merged.

Attached is the full dmesg.

DRH

--Boundary-00=_0901EgyVBhi2dB3
Content-Type: text/x-log;
  charset="us-ascii";
  name="dmesg-08-07-2006.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg-08-07-2006.log"

Linux version 2.6.17-1.2142_FC4 (bhcompile@hs20-bc1-4.build.redhat.com) (gc=
c version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Tue Jul 11 22:41:14 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000040fd800 (usable)
 BIOS-e820: 00000000040fd800 - 00000000040ff800 (ACPI data)
 BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
 BIOS-e820: 00000000040ffc00 - 0000000030000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
768MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 196608
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 192512 pages, LIFO batch:31
DMI 2.1 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6bb0
ACPI: RSDT (v001 PTLTD    RSDT   0x00000001 PTL  0x01000000) @ 0x040fdbcb
ACPI: FADT (v001 DELL   KUBLAI   0x20000322 PTL  0x000f4240) @ 0x040ff78c
ACPI: DSDT (v001  Intel  S2440BX 0x00000001 MSFT 0x01000004) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 40000000 (gap: 30000000:cff80000)
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ rhgb quiet
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01607000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc077d000 soft=3Dc077e000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 848.201 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773884k/786432k available (1977k kernel code, 12080k reserved, 1358=
k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1697.58 BogoMIPS (lpj=3D33=
95178)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f1ff 00000000 00000000 00000040 00000000 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a08)
checking if image is initramfs... it is
=46reeing initrd memory: 1076k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd993, last bus=3D1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 8000-803f claimed by PIIX4 ACPI
PCI quirk: region 7000-700f claimed by PIIX4 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:01: ioport range 0x7000-0x700f has been reserved
pnp: 00:01: ioport range 0x8000-0x803f could not be reserved
PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c1000000-c1ffffff
  PREFETCH window: e0000000-efffffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
* this time source is slow.  Consider trying other time sources (clock=3D)
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1154926364.940:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
=2D Added public key 7EEDE88F5E4DFD06
=2D User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN1] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1480-0x1487, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1488-0x148f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG DVD-ROM SD-612, ATAPI CD/DVD-ROM drive
hdd: DVD RW DRU-820A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20262: IDE controller at PCI slot 0000:00:0d.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
PDC20262: chipset revision 1
PDC20262: ROM enabled at 0x40020000
PDC20262: 100% native mode on irq 11
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x1400-0x1407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg:DMA, hdh:DMA
Probing IDE interface ide2...
hde: Maxtor 54098H8, ATA DISK drive
hdf: Maxtor 4D040H2, ATA DISK drive
ide2 at 0x14b0-0x14b7,0x14a6 on irq 11
Probing IDE interface ide3...
hdg: WDC WD800JB-00JJC0, ATA DISK drive
ide3 at 0x14a8-0x14af,0x14a2 on irq 11
hde: max request size: 128KiB
hde: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(6=
6)
hde: cache flushes not supported
 hde: hde1
hdf: max request size: 128KiB
hdf: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(6=
6)
hdf: cache flushes not supported
 hdf: hdf1
hdg: max request size: 128KiB
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=3D65535/16/63, UDMA(=
66)
hdg: cache flushes supported
 hdg: hdg1 hdg3
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
hda: No disk in drive
hda: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MICE] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:=20
PCI0 USB0 UAR1  KBC MICE=20
ACPI: (supports S0 S1 S5)
=46reeing unused kernel memory: 212k freed
Write protecting the kernel read-only data: 924k
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hdf1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 3368538
ext3_orphan_cleanup: deleting unreferenced inode 3368529
ext3_orphan_cleanup: deleting unreferenced inode 3370934
ext3_orphan_cleanup: deleting unreferenced inode 3370906
EXT3-fs: hdf1: 4 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1154926371.048:2): selinux=3D0 auid=3D4294967295
=46DC 0 is a post-1991 82077
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 3 (level, low) ->=
 IRQ 3
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth0: ADMtek Comet rev 17 at f081a000, 00:14:BF:53:E9:27, IRQ 3.
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKD] -> GSI 9 (level, low) ->=
 IRQ 9
gameport: EMU10K1 is pci0000:00:10.1/gameport0, io 0x14b8, speed 1217kHz
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
parport0: Printer, HEWLETT-PACKARD DESKJET 690C
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKC] -> GSI 3 (level, low) ->=
 IRQ 3
parport1: PC-style at 0x14d0 [PCSPP,TRISTATE,EPP]
0000:00:11.0: ttyS1 at I/O 0x14e0 (irq =3D 3) is a 16550A
0000:00:11.0: ttyS2 at I/O 0x14d8 (irq =3D 3) is a 16550A
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 9 (level, low) ->=
 IRQ 9
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 9, io base 0x00001440
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-2.4: new full speed USB device using uhci_hcd and address 3
usb 1-2.4: configuration #1 chosen from 1 choice
hub 1-2.4:1.0: USB hub found
hub 1-2.4:1.0: 4 ports detected
usb 1-2.4.1: new low speed USB device using uhci_hcd and address 4
usb 1-2.4.1: configuration #1 chosen from 1 choice
input: Microsoft Microsoft=AE Digital Media Pro Keyboard as /class/input/in=
put0
input: USB HID v1.11 Keyboard [Microsoft Microsoft=AE Digital Media Pro Key=
board] on usb-0000:00:07.2-2.4.1
input: Microsoft Microsoft=AE Digital Media Pro Keyboard as /class/input/in=
put1
input: USB HID v1.11 Device [Microsoft Microsoft=AE Digital Media Pro Keybo=
ard] on usb-0000:00:07.2-2.4.1
usb 1-2.4.2: new low speed USB device using uhci_hcd and address 5
usb 1-2.4.2: configuration #1 chosen from 1 choice
input: Logitech Trackball as /class/input/input2
input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:07.2-2.4.2
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
hda: No disk in drive
hda: No disk in drive
EXT3 FS on hdf1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Adding 996020k swap on /dev/hdg3.  Priority:-1 extents:1 across:996020k
0000:00:0f.0: tulip_stop_rxtx() failed
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
audit(1154940811.160:3): audit_pid=3D1884 old=3D0 by auid=3D4294967295
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
eth0: no IPv6 routers present
lp0: using parport0 (interrupt-driven).
lp0: console ready
lp1: using parport1 (polling).
NET: Registered protocol family 4
NET: Registered protocol family 5
application firefox-bin uses obsolete OSS audio interface

--Boundary-00=_0901EgyVBhi2dB3--
