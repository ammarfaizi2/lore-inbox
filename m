Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129586AbRBRVD2>; Sun, 18 Feb 2001 16:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129793AbRBRVDS>; Sun, 18 Feb 2001 16:03:18 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:38409 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S129586AbRBRVDE>; Sun, 18 Feb 2001 16:03:04 -0500
Message-Id: <200102182102.WAA12512@usr01.cybercity.no>
Subject: PROBLEM: pci bridge fails to wake up from suspend/resume( Inspiron 
	8000 )
From: Morten Stenseth <nfp3033@privat.cybercity.no>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-CkhLAbOEoBu/PPy9jAxz"
X-Mailer: Evolution (0.8 - Preview Release)
Date: 18 Feb 2001 22:02:05 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CkhLAbOEoBu/PPy9jAxz
Content-Type: text/plain

Hello , i have some problems with my inspiron 8000
running kernler 2.4.1-ac16 and hope someone on this
list can help me. 

the built in network card do not function after a 
suspend/resume , the only messages i receive is 
"eepro100: wait_for_cmd_done timeout!" , i belive 
the problem is in the pci bridge  that the internal 
network card and modem is on(look tree.txt ) , 
i took a lspci -vx  before suspend and one after 
and it seems as the io ports gets disabled for both
 the network card and modem ( look at before.txt /after.txt ) 
when i resume the machine again. I have included 
the following files which i hope can help in diagnose
this problem:

	before.txt  = lspci -vx before suspend
	after.txt     = lspci -vx after  resume
	tree.txt      = lspci -tv
 dmesg.txt  = dmesg 

if you need more info just give me a howler ?
best regards
Morten Stenseth
nfp3033@privat.cybercity.no


--=-CkhLAbOEoBu/PPy9jAxz
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg.txt
Content-Transfer-Encoding: 7bit

Linux version 2.4.1-ac16 (root@super-babar) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Sat Feb 17 00:58:02 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 000000000000c000 @ 00000000000c0000 (reserved)
 BIOS-e820: 000000000feec000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000004000 @ 000000000ffec000 (reserved)
 BIOS-e820: 0000000000200000 @ 00000000ffe00000 (reserved)
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux2.4ac16 ro root=305 BOOT_FILE=/boot/vmlinuz-2.4.1-ac16
Initializing CPU#0
Detected 848.157 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 255504k/262064k available (1016k kernel code, 6172k reserved, 388k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc06e, last bus=8
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
  got res[f2000000:f2000fff] for resource 0 of Texas Instruments PCI4451 PC card Cardbus Controller
  got res[f2001000:f2001fff] for resource 0 of Texas Instruments PCI4451 PC card Cardbus Controller (#2)
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169770kB/56590kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=244a
PCI_IDE: chipset revision 2
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-232, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 62506080 sectors (32003 MB) w/1874KiB Cache, CHS=3890/255/63
hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:20:E0:64:49:64, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 727095-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:0f.0
PCI: The same IRQ used for device 00:1f.2
PCI: The same IRQ used for device 02:0f.1
PCI: The same IRQ used for device 02:0f.2
PCI: Found IRQ 11 for device 02:0f.1
PCI: The same IRQ used for device 00:1f.2
PCI: The same IRQ used for device 02:0f.0
PCI: The same IRQ used for device 02:0f.2
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 281096k swap-space (priority -1)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: agpgart: Detected an Intel i815, but could not find the secondary device. Assuming a non-integrated video card.
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xe4000000
eth0: 0 multicast blocks dropped.

--=-CkhLAbOEoBu/PPy9jAxz
Content-Type: text/plain
Content-Disposition: attachment; filename=before.txt
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
	Flags: bus master, fast devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
00: 86 80 30 11 06 01 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e8000000-ebffffff
00: 86 80 31 11 07 01 20 00 02 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 a0 a2
20: 00 fc f0 fd 00 e8 f0 eb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=32
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: f2000000-fbffffff
00: 86 80 48 24 07 01 80 00 02 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 08 20 d0 f0 80 22
20: 00 f2 f0 fb f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00

00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 02)
	Flags: bus master, medium devsel, latency 0
00: 86 80 4c 24 0f 01 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0
	I/O ports at bfa0 [size=16]
00: 86 80 4a 24 05 00 80 02 02 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 bf 00 00 00 00 00 00 00 00 00 00 86 80 41 45
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bce0 [size=32]
00: 86 80 42 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 bc 00 00 00 00 00 00 00 00 00 00 86 80 41 45
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M4 AGP (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, VGA palette snoop, stepping, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	I/O ports at cc00 [size=256]
	Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2
00: 02 10 46 4d a7 00 b0 02 00 00 00 03 08 20 00 00
10: 08 00 00 e8 01 cc 00 00 00 c0 ff fc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a4 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at dc00 [size=256]
	Memory at f6ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2
00: 5d 12 98 19 07 00 90 02 10 00 01 04 00 20 00 00
10: 01 dc 00 00 00 e0 ff f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a4 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18

02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=02, secondary=08, subordinate=08, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f8000000-f9ffffff
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]
00: 68 16 00 01 07 00 90 02 11 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 02 08 08 20 e0 e0 80 22
20: 00 f8 f0 f9 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 00 06 00

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=09, subordinate=09, sec-latency=176
	Memory window 0: f2400000-f27ff000 (prefetchable)
	Memory window 1: f2800000-f2bff000
	I/O window 0: 0000d000-0000d0ff
	I/O window 1: 0000d400-0000d4ff
	16-bit legacy interface ports at 0001
00: 4c 10 42 ac 07 00 10 02 00 00 07 06 08 a8 82 00
10: 00 00 00 f2 a0 00 00 02 02 09 09 b0 00 00 40 f2
20: 00 f0 7f f2 00 00 80 f2 00 f0 bf f2 00 d0 00 00
30: fc d0 00 00 00 d4 00 00 fc d4 00 00 0b 01 c0 05
40: 28 10 a4 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at f2001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=0d, subordinate=0d, sec-latency=176
	Memory window 0: f2c00000-f2fff000 (prefetchable)
	Memory window 1: f3000000-f33ff000
	I/O window 0: 0000d800-0000d8ff
	I/O window 1: 0000f000-0000f0ff
	16-bit legacy interface ports at 0001
00: 4c 10 42 ac 07 00 10 02 00 00 07 06 08 a8 82 00
10: 00 10 00 f2 a0 00 00 02 02 0d 0d b0 00 00 c0 f2
20: 00 f0 ff f2 00 00 00 f3 00 f0 3f f3 00 d8 00 00
30: fc d8 00 00 00 f0 00 00 fc f0 00 00 0b 01 c0 05
40: 28 10 a4 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f6ffd800 (32-bit, non-prefetchable) [size=2K]
	Memory at f6ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
00: 4c 10 27 80 16 01 10 02 00 10 00 0c 08 20 80 00
10: 00 d8 ff f6 00 80 ff f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a4 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 04

08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Action Tec Electronics Inc: Unknown device 1100
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f8fff000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ecc0 [size=64]
	Memory at f8e00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 01 90 02 08 00 00 02 08 20 00 00
10: 00 f0 ff f8 c1 ec 00 00 00 00 e0 f8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 68 16 00 11
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38

08:08.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at f8ffec00 (32-bit, non-prefetchable) [size=256]
	I/O ports at ecb8 [size=8]
	I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
00: c1 11 48 04 07 01 90 02 01 00 80 07 00 00 00 00
10: 00 ec ff f8 b9 ec 00 00 01 e8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 68 16 00 24
30: 00 00 00 00 f8 00 00 00 00 00 00 00 0b 01 fc 0e


--=-CkhLAbOEoBu/PPy9jAxz
Content-Type: text/plain
Content-Disposition: attachment; filename=after.txt
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
	Flags: bus master, fast devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
00: 86 80 30 11 06 01 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e8000000-ebffffff
00: 86 80 31 11 07 01 20 00 02 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 a0 22
20: 00 fc f0 fd 00 e8 f0 eb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=32
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: f2000000-fbffffff
00: 86 80 48 24 07 01 80 00 02 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 08 20 d0 f0 80 22
20: 00 f2 f0 fb f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00

00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 02)
	Flags: bus master, medium devsel, latency 0
00: 86 80 4c 24 0f 01 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0
	I/O ports at bfa0 [size=16]
00: 86 80 4a 24 05 00 80 02 02 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 bf 00 00 00 00 00 00 00 00 00 00 86 80 41 45
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bce0 [size=32]
00: 86 80 42 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 bc 00 00 00 00 00 00 00 00 00 00 86 80 41 45
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M4 AGP (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, VGA palette snoop, stepping, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	I/O ports at cc00 [size=256]
	Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2
00: 02 10 46 4d a7 00 b0 02 00 00 00 03 08 20 00 00
10: 08 00 00 e8 01 cc 00 00 00 c0 ff fc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a4 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at dc00 [size=256]
	Memory at f6ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2
00: 5d 12 98 19 07 00 90 02 10 00 01 04 00 20 00 00
10: 01 dc 00 00 00 e0 ff f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a4 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18

02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=02, secondary=08, subordinate=08, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]
00: 68 16 00 01 07 00 90 02 11 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 02 08 08 20 e0 e0 80 22
20: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 00 00 00

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=09, subordinate=09, sec-latency=176
	Memory window 0: f2400000-f27ff000 (prefetchable)
	Memory window 1: f2800000-f2bff000
	I/O window 0: 0000d000-0000d0ff
	I/O window 1: 0000d400-0000d4ff
	16-bit legacy interface ports at 0001
00: 4c 10 42 ac 07 00 10 02 00 00 07 06 08 a8 82 00
10: 00 00 00 f2 a0 00 00 02 02 09 09 b0 00 00 40 f2
20: 00 f0 7f f2 00 00 80 f2 00 f0 bf f2 00 d0 00 00
30: fc d0 00 00 00 d4 00 00 fc d4 00 00 0b 01 c0 05
40: 28 10 a4 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at f2001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=0d, subordinate=0d, sec-latency=176
	Memory window 0: f2c00000-f2fff000 (prefetchable)
	Memory window 1: f3000000-f33ff000
	I/O window 0: 0000d800-0000d8ff
	I/O window 1: 0000f000-0000f0ff
	16-bit legacy interface ports at 0001
00: 4c 10 42 ac 07 00 10 02 00 00 07 06 08 a8 82 00
10: 00 10 00 f2 a0 00 00 02 02 0d 0d b0 00 00 c0 f2
20: 00 f0 ff f2 00 00 00 f3 00 f0 3f f3 00 d8 00 00
30: fc d8 00 00 00 f0 00 00 fc f0 00 00 0b 01 c0 05
40: 28 10 a4 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f6ffd800 (32-bit, non-prefetchable) [size=2K]
	Memory at f6ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
00: 4c 10 27 80 16 01 10 02 00 10 00 0c 08 20 80 00
10: 00 d8 ff f6 00 80 ff f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a4 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 04

08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Action Tec Electronics Inc: Unknown device 1100
	Flags: medium devsel, IRQ 11
	[virtual] Memory at f8fff000 (32-bit, non-prefetchable) [disabled] [size=4K]
	I/O ports at ecc0 [disabled] [size=64]
	[virtual] Memory at f8e00000 (32-bit, non-prefetchable) [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
00: 86 80 29 12 00 00 90 02 08 00 00 02 00 00 00 00
10: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 68 16 00 11
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 01 08 38

08:08.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Flags: medium devsel, IRQ 11
	[virtual] Memory at f8ffec00 (32-bit, non-prefetchable) [disabled] [size=256]
	I/O ports at ecb8 [disabled] [size=8]
	I/O ports at e800 [disabled] [size=256]
	Capabilities: [f8] Power Management version 2
00: c1 11 48 04 00 00 90 02 01 00 80 07 00 00 00 00
10: 00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 68 16 00 24
30: 00 00 00 00 f8 00 00 00 00 00 00 00 00 01 fc 0e


--=-CkhLAbOEoBu/PPy9jAxz--

