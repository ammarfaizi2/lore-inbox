Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLTTYS>; Wed, 20 Dec 2000 14:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbQLTTYI>; Wed, 20 Dec 2000 14:24:08 -0500
Received: from nets5.rz.RWTH-Aachen.DE ([137.226.144.13]:21187 "EHLO
	nets5.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S129410AbQLTTXy>; Wed, 20 Dec 2000 14:23:54 -0500
Date: Wed, 20 Dec 2000 19:40:31 +0100
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: David Hinds <dhinds@valinux.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Problems with ToPIC97 reappear between test10 and test13pre2
Message-ID: <20001220194031.A3827@maggie.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	David Hinds <dhinds@valinux.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.rutgers.edu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sent a similar message earlier, but it has not shown up on
linux-kernel so I guess something went wrong...


I am starting to have problems again with the Cardbus controller
somewhere inbetween 2.4.0-test10 (works) and 2.4.0-test13-pre2 (fails).

The problem shows as follows: When I boot the kernel (I have PCMCIA
compiled in) only one of my cards gets detected due to the following
error:
cs: socket c5feb800 timed out during reset.  Try increasing setup_delay.
cs: socket c5fb5000 voltage interrogation timed out

I did not have see this error before and increasing setup_delay manually 
in the source did not help.

Now when I do "cardctl eject; cardctl insert" things work out fine.

I am not sure if this is somehow related to the problems that were
fixed with test5pre6, but the sumptoms are kind of similar (one slot
works - other does not).

If you want me to try something please let me know.

Jens

ps: attached please find the dmesg output.

-- 
Jens Taprogge


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.4.0-test13pre2"

Linux version 2.4.0-test13-pre2 (root@al) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #9 Sun Dec 17 15:21:56 CET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000004000 @ 00000000000e8000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000005ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 0000000005ff0000 (ACPI data)
 BIOS-e820: 0000000000016e00 @ 00000000100a0000 (reserved)
 BIOS-e820: 0000000000000200 @ 00000000100b6e00 (ACPI NVS)
 BIOS-e820: 0000000000049000 @ 00000000100b7000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (0119a000)
Kernel command line: root=/dev/hda2 video=vesa vga=771 mem=96M parport=0x378,auto pci=biosirq opl3sa2=0x538,5,1,0,0x530,0x388
Initializing CPU#0
Detected 233.294 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 465.31 BogoMIPS
Memory: 93888k/98304k available (1795k kernel code, 4028k reserved, 123k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1927, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:02.0
PCI: Found IRQ 11 for device 00:02.1
PCI: Cannot allocate resource region 4 of device 00:07.1
  got res[10000000:10000fff] for resource 0 of Toshiba America Info Systems ToPIC97
  got res[10001000:10001fff] for resource 0 of Toshiba America Info Systems ToPIC97 (#2)
  got res[1000:100f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.14)
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
vesafb: framebuffer at 0xfe000000, mapped to 0xc6800000, size 2048k
vesafb: mode is 800x600x8, linelength=800, pages=0
vesafb: protected mode interface info at c000:96e0
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4006MAV, ATA DISK drive
hdc: CD-224E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8007552 sectors (4100 MB), CHS=993/128/63, UDMA(33)
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
NTFS version 000607
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
Found OPL3-SAx (YMF719)
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:02.0
PCI: Found IRQ 11 for device 00:02.1
Yenta IRQ list 0418, PCI irq11
Socket status: 30000411
Yenta IRQ list 0418, PCI irq11
Socket status: 30000011
ACPI: System description tables found
    ACPI-0191: *** Warning: Invalid table signature found
    ACPI-0073: *** Error: Acpi_load_tables: Could not load RSDT: AE_BAD_SIGNATURE
    ACPI-0101: *** Error: Acpi_load_tables: Could not load tables: AE_BAD_SIGNATURE
ACPI: System description table load failed
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: socket c5feb800 timed out during reset.  Try increasing setup_delay.
cs: socket c5fb5000 voltage interrogation timed out
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 60384k swap-space (priority -1)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ttyS01 at port 0x02f8 (irq = 3) is a 16550A
NET4: Linux IPX 0.42v4 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000 Conectiva, Inc.
Trying to open MFT
PPP BSD Compression module registered

--6c2NcOVqGQ03X4Wi--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
