Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbULEA7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbULEA7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULEA7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:59:22 -0500
Received: from ns.schottelius.org ([213.146.113.242]:12699 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S261214AbULEA6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:58:55 -0500
Date: Sun, 5 Dec 2004 01:59:46 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linux-ide.org>, Frank Tiernan <frankt@promise.com>
Subject: [BUG] pdc202xx_new and ACPI fails
Message-ID: <20041205005946.GA7695@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
	Frank Tiernan <frankt@promise.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello dear developers,

when loading pdc202xx_new on a 2.6.9 kernel with ACPI on the moprobe
 call will never return and prints many errors [0].

The controller is a Promise Technology, Inc. PDC20270 (FastTrak100 LP/TX2/T=
X4) (rev 02).

If loading the driver without the forced option, it says deactivated
by BIOS.

On the other hand, when loading with apm onlyi and enabling forced,=20
it works fine [1].

So my questions:

- Why does it fail with ACPI?
- Is it possible to fix that? If, how?
- Is it possible to make forced enabling a module option?like force_against=
_bios=3D0|1
- Where in which bios (controller/Mainboard) should one activate the ports?

Greetings,=20

Nico

[0]: see attached dmesg.eiche

[1]:=20
PDC20270: IDE controller at PCI slot 0000:02:01.0
PDC20270: chipset revision 2
PDC20270: ROM enabled at 0xdfee0000
PDC20270: 100% native mode on irq 10
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdh: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide3 at 0xc400-0xc407,0xc002 on irq 10
Probing IDE interface ide4...
Probing IDE interface ide5...
hdk: WDC WD1200BB-00GUA0, ATA DISK drive
ide5 at 0xb000-0xb007,0xac02 on irq 10
hdk: max request size: 1024KiB
hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=3D16383/255/63, UDM=
A(100)
hdk: cache flushes supported
 /dev/ide/host4/bus1/target0/lun0: unknown partition table


--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.eiche"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.9 (root@eiche) (gcc version 3.3.4 (Debian 1:3.3.4-11)) #1=
1 Sun Dec 5 01:44:49 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa700
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x0fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x0fff00c0
ACPI: DSDT (v001    VIA    KM266 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: rsbac_softmode
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1249.937 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255772k/262080k available (2260k kernel code, 5740k reserved, 656k =
data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2449.40 BogoMIPS (lpj=3D1224704)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdae1, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.1, from 3 to 5
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SV2042H, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD400EB-00CPF0, ATA DISK drive
hdd: SAMSUNG SV3064D, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 39865392 sectors (20411 MB) w/426KiB Cache, CHS=3D39549/16/63, UDMA(10=
0)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: max request size: 128KiB
hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(1=
00)
hdc: cache flushes not supported
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
hdd: max request size: 128KiB
hdd: 59794560 sectors (30614 MB) w/434KiB Cache, CHS=3D59320/16/63, UDMA(66)
hdd: cache flushes not supported
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices:=20
PCI0 UAR1 USB1 USB2 USB3 EHCI PS2M PS2K  AC9  MC9 ILAN SLPB=20
BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
Mount JFS Failure: -22
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 164k freed
Adding 112444k swap on /dev/ide/host0/bus0/target0/lun0/part3.  Priority:-1=
 extents:1
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hdc
Ending clean XFS mount for filesystem: hdc
XFS mounting filesystem hdd
Ending clean XFS mount for filesystem: hdd
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0000e400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 21, io base 0000e800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 21, io base 0000ec00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 21, pci mem d0806f00
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
eth0: VIA Rhine II at 0xdffffe00, 00:0b:6a:15:06:68, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
apm: BIOS not found.
PDC20270: IDE controller at PCI slot 0000:02:01.0
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 19 (level, low) -> IRQ 19
PDC20270: chipset revision 2
PDC20270: ROM enabled at 0xdfee0000
PDC20270: 100% native mode on irq 19
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
    ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdh: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide3 at 0xc400-0xc407,0xc002 on irq 19
Probing IDE interface ide4...
Probing IDE interface ide5...
hdk: WDC WD1200BB-00GUA0, ATA DISK drive
ide5 at 0xb000-0xb007,0xac02 on irq 16
hdk: max request size: 1024KiB
irq 19: nobody cared!
 [<c0106614>] __report_bad_irq+0x24/0x80
 [<c01066f1>] note_interrupt+0x61/0x90
 [<c01065bb>] handle_IRQ_event+0x2b/0x60
 [<c01069aa>] do_IRQ+0x11a/0x130
 [<c0104974>] common_interrupt+0x18/0x20
handlers:
[<c0290d90>] (ide_intr+0x0/0x170)
Disabling IRQ #19

--6TrnltStXW4iwmi0--

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQbJdgLOTBMvCUbrlAQKQEA//f0e0h98LYbvk/NVDHwiwjaa30heGguxF
emJDzhD1nY1nSJOmSYlrOKZy9hcjpdj8X1OKvh3c9GFw8O/7Q6V9xJTSw/POJ+e7
Pa6a9oL8wOz6UiKjwwAxXhOEGj5l/309JmdxHOF20m+HMI+5+y0/458QIxKJRyVo
NmCUKlfXbYb2kvkY4neeKagKlWvZKuZxPcKAXlRXLmyOJMoBJ8QPlF58SHakKkUF
tfm55szXiJhSWloFm/c6pONCXtu6gDJi0vI9JoNaqvYZRl1bIvKJBbxKy/BetV15
fOdP68CFTCPoLrpG5vTuI9WeBxY13j5OkZBZCYY00jjMGcKWTF8SVjzvtHHGHZQZ
1L7WHlEKqehRl0PXCxH2vLZMbC0ZDCe6FZFNp3LnDdv2pc9mJj3RPOWMR7966H7K
0IkG4Nx5USQXucNq6W/NqAvMqB7mForhWS1EwBBN97+ahBgZ9rNURCwWBZEJ/cj3
AwWcfKUkiK602HCOHCDjTQ3pplY4qC35VdKn+ll0w4Rvim27Qq1A4q/dkj3OghQi
eBDy5z6v5SxspYtsQRabwfnnIR2lLhJa18CSsJpJe0v222/3SoJ1FgXMTKHMoCxJ
H+jX5vziAV0+KMTRvSHx5UrAQaVyUDPy+GZF2l5tXWtPtRK+c2i/ChNa+txy0Msf
UiFXwScUHxQ=
=3Ps1
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
