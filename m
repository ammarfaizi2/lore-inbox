Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130724AbRBCBFb>; Fri, 2 Feb 2001 20:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRBCBFW>; Fri, 2 Feb 2001 20:05:22 -0500
Received: from cloudburst.umist.ac.uk ([130.88.119.66]:16388 "EHLO
	cloudburst.umist.ac.uk") by vger.kernel.org with ESMTP
	id <S130724AbRBCBFR>; Fri, 2 Feb 2001 20:05:17 -0500
From: T.Stewart@student.umist.ac.uk
To: Urban Widmark <urban@teststation.com>
Date: Sat, 3 Feb 2001 01:06:39 -0000
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-344
Subject: Re: DFE-530TX with no mac address
CC: linux-kernel@vger.kernel.org
Message-ID: <3A7B599F.18307.47A4F1@localhost>
In-Reply-To: <l03130310b6a0ac26266f@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.30.0102021953560.10971-100000@cola.teststation.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

On 2 Feb 2001, at 20:17, Urban Widmark wrote:
> 
> > >I did this and compiled it into the kernel. It detects it at boot
> > >(via- rhine v1.08-LK1.1.6 8/9/2000 Donald Becker) but says the
> > >hardware address (mac address?) is 00-00-00-00-00-00.
> 
> This is a good example of what is missed by not copying the exact
> message. For example, mine says:
Im Sorry.

> eth0: VIA VT3043 Rhine at 0xd400, 00:50:ba:a4:15:86, IRQ 19.
> eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link
> 0000.
> 
> Does it say "VIA VT6102 Rhine-II" for both of you?
> If not, could you do an 'lspci -n'?

Yep (see attachments), as bootup:-

via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 9 for device 00:0a.0
eth0: VIA VT6102 Rhine-II at 0xd400, 00:00:00:00:00:00, IRQ 9.


> My VT3043 survives win98, but it may be a new feature in the newer
> chip. It may be a bios setting or something ...
> 
> 
> > I have an identical card, which usually works - except when I've
> > rebooted from Windows, when it shows the above symptoms.  After
> > using Windows, I have to power the machine off, including turning
> > off the "standby power" switch on the PSU, then turn it back on and
> > boot straight into Linux.  Very occasionally it also loses
> > "identity" and requires a similar reset, even when running Linux.
> 
> Yes, the card is in some (for the linux driver) unknown state.
> Powering off completely resets it. Something that could help someone
> find out what is going on is running these two commands, both when the
> card is working and when it is not.
> 
> via-diag -aaeemm
> lspci -vvvxxx -d 1106:3065
> 
> via-diag is available from http://www.scyld.com/diag/index.html
> 
> (1106:3065 is the pci id, if lspci -n gives you a different number you
> use 
>  that of course.)
> 
> /Urban
> 

I can now get my card to work (when I unplug the box), thank u 
people.

My device is 00:0a.0, which is 1106:3065 (as u said)

I have supplyed my outputs from via-diag and lspci in body and as 
attachments. Sorry for the long message.

tom

via-daig -aaeemm, with card not working:-
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:00:00:00:00:00.
 Tx disabled, Rx disabled, half-duplex (0x0804).
  Receive  mode is 0x00: Unknown/invalid.
  Transmit mode is 0x00: Normal transmit, 128 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 00000000 00000000 00000804 00000000 00000000 
00000000 00000000 00000000
 0x020: 00000400 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
 0x040: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 feffffff
 0x060: 00000000 00000000 00000000 0e09131f 00008100 
08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 09 0e 00 00 47 02 73 73
 ***WARNING***: No MII transceivers found!

via-diag -aaeemm, with card working:-
via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:50:ba:6e:d8:55.
 Tx enabled, Rx enabled, full-duplex (0x0c5a).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x20: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 6eba5000 206c55d8 00000c5a 4eff0000 80000000 
00000000 01264010 01264190
 0x020: 80000400 00000600 079ae810 01264020 80000000 
00000600 079ad010 01264030
 0x040: 00000000 00e08000 00000000 012641a0 00000000 
00000000 013c013c feffffff
 0x060: 00000000 00000000 00000000 00061108 782d8100 
08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 50 ba 6e d8 55 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73
 MII PHY found at address 8, status 0x782d.
 MII PHY #8 transceiver registers:
   3000 782d 0016 f880 01e1 4461 ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0022 ff40 0050 ffc0 00a0 ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff.

lspci -vvxxx with card not working:-
00:0a.0 Ethernet controller: VIA Technologies, Inc.: Unknown 
device 3065 (rev 42)
	Subsystem: D-Link System Inc: Unknown device 1400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ 
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) 
[size=256]
	Expansion ROM at dffe0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 08 40 00 00
10: 01 d4 00 00 00 ff ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 fe df 40 00 00 00 00 00 00 00 09 01 03 08
40: 01 00 02 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

lspci -vvxxx with card working:-
00:0a.0 Ethernet controller: VIA Technologies, Inc.: Unknown 
device 3065 (rev 42)
	Subsystem: D-Link System Inc: Unknown device 1400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ 
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) 
[size=256]
	Expansion ROM at dffe0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 08 40 00 00
10: 01 d4 00 00 00 ff ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 fe df 40 00 00 00 00 00 00 00 09 01 03 08
40: 01 00 02 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00




--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'via-diag_working.txt'

via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:50:ba:6e:d8:55.
 Tx enabled, Rx enabled, full-duplex (0x0c5a).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x20: Normal transmit, 256 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 6eba5000 206c55d8 00000c5a 4eff0000 80000000 00000000 01264010 01264190
 0x020: 80000400 00000600 079ae810 01264020 80000000 00000600 079ad010 01264030
 0x040: 00000000 00e08000 00000000 012641a0 00000000 00000000 013c013c feffffff
 0x060: 00000000 00000000 00000000 00061108 782d8100 08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 50 ba 6e d8 55 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 06 00 00 00 47 02 73 73
 MII PHY found at address 8, status 0x782d.
 MII PHY #8 transceiver registers:
   3000 782d 0016 f880 01e1 4461 ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0022 ff40 0050 ffc0 00a0 ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff.

--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'dmesg_working.txt'

Linux version 2.4.1 (root@diamond) (gcc version 2.95.3 20010125 (prerelease)) #1 Fri Feb 2 13:33:07 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000004000 @ 00000000000dc000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000008000 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000008000 @ 0000000007ff8000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=305
Initializing CPU#0
Detected 798.108 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 126436k/131008k available (1119k kernel code, 4184k reserved, 469k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
29 structures occupying 980 bytes.
DMI table at 0x000F0600.
BIOS Vendor: American Megatrends Inc.
BIOS Version: 62710
BIOS Release: 09/15/2000
System Vendor: American Megatrends Inc..
Product Name: VIA694X/686A.
Version 00000000.
Serial Number 00000000.
Board Vendor: Gigabyte Technology Co., Ltd.
Board Name: 6VXC7-4X.
Board Version: 1.0.
Asset Tag: 00000000.
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD DESKJET
parport_pc: Via 686A parallel port: io=0x378, irq=7
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
block: queued sectors max/low 83965kB/27988kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD307AA-00BAA0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: Pioneer DVD-ROM ATAPIModel DVD-115 0111, ATAPI CD/DVD-ROM drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63, UDMA(66)
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 1280kB Cache, DMA
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 9 for device 00:0a.0
eth0: VIA VT6102 Rhine-II at 0xd400, 00:50:ba:6e:d8:55, IRQ 9.
eth0: MII PHY found at address 8, status 0x7829 advertising 01e1 Link 4461.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 128M @ 0xe0000000
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
Creative EMU10K1 PCI Audio Driver, version 0.7, 13:34:34 Feb  2 2001
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:07.2
emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xd000-0xd01f, IRQ 10
usb.c: registered new driver hub
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.43 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000 Conectiva, Inc.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
uhci.c: root-hub INT complete: port1: 49b port2: 48a data: 6
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x3f0/0x405) is not claimed by any active driver.
uhci.c: root-hub INT complete: port1: 495 port2: 488 data: 4
Adding Swap: 136512k swap-space (priority -1)
eth0: Setting full-duplex based on MII #8 link partner capability of 4461.

--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'lspci_notworking.txt'

00:0a.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3065 (rev 42)
	Subsystem: D-Link System Inc: Unknown device 1400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dffe0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 08 40 00 00
10: 01 d4 00 00 00 ff ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 fe df 40 00 00 00 00 00 00 00 09 01 03 08
40: 01 00 02 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'lspci_working.txt'

00:0a.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3065 (rev 42)
	Subsystem: D-Link System Inc: Unknown device 1400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dffe0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 08 40 00 00
10: 01 d4 00 00 00 ff ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 fe df 40 00 00 00 00 00 00 00 09 01 03 08
40: 01 00 02 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'via-diag_notworking.txt'

via-diag.c:v2.04 7/14/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3065 Rhine-II adapter at 0xd400.
 Station address 00:00:00:00:00:00.
 Tx disabled, Rx disabled, half-duplex (0x0804).
  Receive  mode is 0x00: Unknown/invalid.
  Transmit mode is 0x00: Normal transmit, 128 byte threshold.
VIA VT3065 Rhine-II chip registers at 0xd400
 0x000: 00000000 00000000 00000804 00000000 00000000 00000000 00000000 00000000
 0x020: 00000400 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 0x040: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 feffffff
 0x060: 00000000 00000000 00000000 0e09131f 00008100 08000080 02470000 00000000
 No interrupt sources are pending (0000).
  Access to the EEPROM has been disabled (0x80).
    Direct reading or writing is not possible.
EEPROM contents (Assumed from chip registers):
0x100:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x110:  00 00 00 00 00 00 00 00 09 0e 00 00 47 02 73 73
 ***WARNING***: No MII transceivers found!

--Message-Boundary-344
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'dmesg_notworking.txt'

Linux version 2.4.1 (root@diamond) (gcc version 2.95.3 20010125 (prerelease)) #1 Fri Feb 2 13:33:07 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000004000 @ 00000000000dc000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000008000 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000008000 @ 0000000007ff8000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=305
Initializing CPU#0
Detected 798.095 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 126436k/131008k available (1119k kernel code, 4184k reserved, 469k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
29 structures occupying 980 bytes.
DMI table at 0x000F0600.
BIOS Vendor: American Megatrends Inc.
BIOS Version: 62710
BIOS Release: 09/15/2000
System Vendor: American Megatrends Inc..
Product Name: VIA694X/686A.
Version 00000000.
Serial Number 00000000.
Board Vendor: Gigabyte Technology Co., Ltd.
Board Name: 6VXC7-4X.
Board Version: 1.0.
Asset Tag: 00000000.
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD DESKJET
parport_pc: Via 686A parallel port: io=0x378, irq=7
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
block: queued sectors max/low 83965kB/27988kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD307AA-00BAA0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: Pioneer DVD-ROM ATAPIModel DVD-115 0111, ATAPI CD/DVD-ROM drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63, UDMA(66)
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 1280kB Cache, DMA
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 9 for device 00:0a.0
eth0: VIA VT6102 Rhine-II at 0xd400, 00:00:00:00:00:00, IRQ 9.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 128M @ 0xe0000000
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
Creative EMU10K1 PCI Audio Driver, version 0.7, 13:34:34 Feb  2 2001
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:07.2
emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xd000-0xd01f, IRQ 10
usb.c: registered new driver hub
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.43 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000 Conectiva, Inc.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
uhci.c: root-hub INT complete: port1: 49b port2: 48a data: 6
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x3f0/0x405) is not claimed by any active driver.
uhci.c: root-hub INT complete: port1: 495 port2: 488 data: 4
Adding Swap: 136512k swap-space (priority -1)

--Message-Boundary-344--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
