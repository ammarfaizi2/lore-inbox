Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313693AbSDHUQJ>; Mon, 8 Apr 2002 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313699AbSDHUQI>; Mon, 8 Apr 2002 16:16:08 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:41739 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S313693AbSDHUQH>;
	Mon, 8 Apr 2002 16:16:07 -0400
Subject: 2.4.19-pre5-ac3: Panic on boot
From: Shawn Starr <shawn.starr@datawire.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 08 Apr 2002 16:16:06 -0400
Message-Id: <1018296966.203.19.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried to 2.4.19-pre5-ac3. swapper caused panic on boot. Kernel
tried to kill init ;)

Anyone else having issues?

lspci info:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 02)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)
02:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
02:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)


*NOTE*: Dmesg reporting 2.4.18-pre7-ac1-wli1. This is my current stable
kernel im using.


Linux version 2.4.18-pre7-ac1-wli1 (root@unaropia) (gcc version 3.0.3)
#2 Wed Jan 30 12:59:04 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffeb000 (usable)
 BIOS-e820: 000000000ffeb000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65515
zone(0): 4096 pages.
zone(1): 61419 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linuxold ro root=304
Initializing CPU#0
Detected 938.041 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1867.77 BogoMIPS
Memory: 256084k/262060k available (1153k kernel code, 5588k reserved,
282k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0d90, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
request_module[parport_lowlevel]: Root fs not mounted
lp: driver loaded but no devices found
Real Time Clock Driver v1.10e
i810_rng: cannot disable RNG, aborting
i810_rng hardware driver 0.9.6 loaded
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdc: MATSHITA CR-594, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80315072 sectors (41121 MB) w/1902KiB Cache, CHS=4999/255/63,
UDMA(100)
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 9 for device 02:0c.0
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:D0:B7:68:91:DD, IRQ 9.
  Board assembly 721383-008, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...
sb: I/O, IRQ, and DMA are mandatory
AWE32: No ISAPnP cards found
AWE32: not detectedes1371: found es1371 rev 2 at io 0xb800 irq 5
es1371: features: joystick 0x0
PCI: Enabling device 02:0a.0 (0004 -> 0005)
PCI: Assigned IRQ 5 for device 02:0a.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: version v0.30 time 12:55:37 Jan 30 2002
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 136544k swap-space (priority -1)


:(

-- 
Shawn Starr
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008

