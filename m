Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278613AbRJZPBY>; Fri, 26 Oct 2001 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278605AbRJZPBO>; Fri, 26 Oct 2001 11:01:14 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:18191 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S278583AbRJZPBI>; Fri, 26 Oct 2001 11:01:08 -0400
Date: Fri, 26 Oct 2001 17:01:43 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: PCI IRQ (routing) problem with mediaGX
Message-ID: <20011026170143.B15834@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am having some strange problems with a special mediaGX device.
There is a BT878 and a DP83815 onboard, and I want to use an
MPEG2 decoder in its only PCI slot, this is why I try to compile
a kernel for it.
The original SuSE 7.2 kernel (2.4.4) works, but every kernel I
tried to compile for it fails because the DP83815 does not get
its interrupt. This is what the driver says:
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.8, Aug 07, 2001  Jeff Garzik
, Tjeerd Mulder)
PCI: Found IRQ 10 for device 00:0e.0
IRQ routing conflict for 00:0e.0, have irq 11, want irq 10
eth0: NatSemi DP83815 at 0xc2815000, fb:ff:fb:ff:fb:ff, IRQ 11.
eth0: Transceiver status 0x7869 advertising 05e1.

Attached are lspci -v output and the boot.msg of the non-working kernel
2.4.9-ac12 (sorry, latest I tried...)

Any help (configuration options, patches, hints) welcome! :)

Thanks,
Wolfgang


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Cyrix Corporation PCI Master
	Flags: bus master, medium devsel, latency 0

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Flags: medium devsel
	Memory at 10000000 (32-bit, prefetchable) [disabled] [size=4K]

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Flags: medium devsel
	Memory at 10001000 (32-bit, prefetchable) [disabled] [size=4K]

00:0e.0 Ethernet controller: National Semiconductor Corporation: Unknown device 0020
	Subsystem: Unknown device fffb:fffb
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at f800 [size=256]
	Memory at fedff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

00:10.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 02)
	Flags: medium devsel, IRQ 10
	Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 1

00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua]
	Flags: bus master, medium devsel, latency 0

00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
	Flags: medium devsel
	Memory at 40012000 (32-bit, non-prefetchable) [size=256]

00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua] (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 0
	I/O ports at fc00 [size=16]

00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
	Flags: bus master, medium devsel, latency 0
	Memory at 40011000 (32-bit, non-prefetchable) [size=128]

00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua] (prog-if 00 [VGA])
	Subsystem: Cyrix Corporation: Unknown device 0001
	Flags: medium devsel
	Memory at 40800000 (32-bit, non-prefetchable) [size=8M]

00:13.0 USB Controller: Compaq Computer Corporation USB Open Host Controller (rev 06) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation USB Open Host Controller
	Flags: medium devsel, IRQ 11
	Memory at fedfe000 (32-bit, non-prefetchable) [size=4K]


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.msg-2.4.9-ac12"

Inspecting /boot/System.map-2.4.9-ac12
Loaded 14790 symbols from /boot/System.map-2.4.9-ac12.
Symbols match kernel version 2.4.9.
No module symbols loaded.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.4.9-ac12 (root@bigmac) (gcc version 2.95.3 20010315 (SuSE)) #1 Thu Sep 27 12:33:34 MEST 2001
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000ed000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000001d70000 (usable)
<4> BIOS-e820: 0000000001d70000 - 0000000001d7fc00 (ACPI data)
<4> BIOS-e820: 0000000001d7fc00 - 0000000001d80000 (ACPI NVS)
<4> BIOS-e820: 00000000fffed000 - 0000000100000000 (reserved)
<4>On node 0 totalpages: 7536
<4>zone(0): 4096 pages.
<4>zone(1): 3440 pages.
<4>zone(2): 0 pages.
<4>Kernel command line: auto BOOT_IMAGE=neu ro root=303 BOOT_FILE=/boot/bzImage-2.4.9-ac12 vga=0x0301
<6>Initializing CPU#0
<6>Working around Cyrix MediaGX virtual DMA bugs.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 34.30 BogoMIPS
<4>Memory: 27364k/30144k available (1109k kernel code, 2392k reserved, 313k data, 188k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
<4>Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<4>Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
<4>Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
<7>CPU: Before vendor init, caps: 00808131 01818131 00000000, vendor = 1
<6>Working around Cyrix MediaGX virtual DMA bugs.
<7>CPU: After vendor init, caps: 00808121 00818131 00000000 00000001
<7>CPU:     After generic, caps: 00808121 00818131 00000000 00000001
<7>CPU:             Common caps: 00808121 00818131 00000000 00000001
<4>CPU: Cyrix MediaGXtm MMXtm Enhanced stepping 03
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: none
<4>PCI: PCI BIOS revision 2.10 entry at 0xfd994, last bus=0
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<6>PCI: Using IRQ router NatSemi [1078/0100] at 00:12.0
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>PnP: PNP BIOS installation structure at 0xc00f7ca0
<6>PnP: PNP BIOS version 1.0, entry at f0000:a6be, dseg at 400
<4>PnPBIOS: PNP0c02: request 0xfc10-0xfc80 ok
<4>PnPBIOS: PNP0c02: request 0x480-0x490 ok
<4>PnPBIOS: PNP0c02: request 0xac00-0xac20 ok
<4>PnPBIOS: PNP0c02: request 0xac80-0xac86 ok
<4>PnPBIOS: PNP0c02: request 0xac90-0xaca0 ok
<4>PnPBIOS: PNP0c02: request 0x4d0-0x4d2 ok
<6>PnP: 19 devices detected total
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>ACPI BOOT descriptor is wrong length (39)
<6>Simple Boot Flag extension found and enabled.
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
<4>Starting kswapd v1.8
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
<6>Non-volatile memory driver v1.1
<4>block: queued sectors max/low 17890kB/5963kB, 64 slots per queue
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>CS5530: IDE controller on PCI bus 00 dev 92
<4>CS5530: chipset revision 0
<4>CS5530: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
<4>hda: TOSHIBA MK2110MAT, ATA DISK drive
<4>hdb: CD-316E, ATAPI CD/DVD-ROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hda: cs5530_set_xfer_mode(UDMA 2)
<6>hda: 4233600 sectors (2168 MB), CHS=525/128/63, UDMA(33)
<4>hdb: ATAPI 16X CD-ROM drive, 128kB Cache
<6>Uniform CD-ROM driver Revision: 3.12
<6>Partition check:
<6> hda: hda1 hda2 hda3 hda4
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a National Semiconductor PC87306
<6>usb.c: registered new driver usbdevfs
<6>usb.c: registered new driver hub
<6>uhci.c: :USB Universal Host Controller Interface driver
<6>PCI: Found IRQ 11 for device 00:13.0
<6>usb-ohci.c: USB OHCI at membase 0xc2800000, IRQ 11
<6>usb-ohci.c: usb-00:13.0, Compaq Computer Corporation USB Open Host Controller
<6>usb.c: new USB bus registered, assigned bus number 1
<7>usb.c: kmalloc IF c1d5fc40, numif 1
<7>usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
<7>usb.c: USB device number 1 default language ID 0x0
<6>Product: USB OHCI Root Hub
<6>SerialNumber: c2800000
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<7>hub.c: standalone hub
<7>hub.c: ganged power switching
<7>hub.c: global over-current protection
<7>hub.c: Port indicators are not supported
<7>hub.c: power on to power good time: 2ms
<7>hub.c: hub controller current requirement: 0mA
<7>hub.c: port removable status: RR
<7>hub.c: local power source is good
<7>hub.c: no over-current condition exists
<7>hub.c: enabling power on all ports
<7>usb.c: hub driver claimed interface c1d5fc40
<7>usb.c: call_policy add, num 1 -- no FS yet
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 512 buckets, 4Kbytes
<4>TCP: Hash tables configured (established 2048 bind 2048)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>Freeing unused kernel memory: 188k freed
<6>Adding Swap: 100792k swap-space (priority -1)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--6TrnltStXW4iwmi0--
