Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272969AbTGaKYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272970AbTGaKYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:24:31 -0400
Received: from mx0.gmx.de ([213.165.64.100]:62975 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S272968AbTGaKYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:24:20 -0400
Date: Thu, 31 Jul 2003 12:24:18 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
MIME-Version: 1.0
Subject: [2.4.22-pre9] Unexpected IO-APIC (works)...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <714.1059647058@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling IO-APIC support on my hardware, everything works correctly,
but the kernel reports finding an unexpected IO-APIC:

"An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org"

The hardware is Shuttle P4 SS51G with FS51 motherboard (SiS 651 northbridge
w/ SiS 5513 southbridge).

What information do I need to add an entry to identify/recognise this
IO-APIC? If someone can let me know, I'll submit a patch. The obvious info follows.

--- [ # dmesg ]

Linux version 2.4.22-pre9 (root@phlox) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r1, propolice)) #1 Thu Jul 31
 10:22:32 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fbf0000 (usable)
 BIOS-e820: 000000003fbf0000 - 000000003fbf3000 (ACPI NVS)
 BIOS-e820: 000000003fbf3000 - 000000003fc00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f5650
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 1
Kernel command line: root=/dev/hda1 console=ttyS0,115200
Initializing CPU#0
Detected 2004.569 MHz processor.
Calibrating delay loop... 3997.69 BogoMIPS
Memory: 905128k/917504k available (1276k kernel code, 11992k reserved, 321k
data, 260k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2004.6657 MHz.
..... host bus clock speed is 100.2331 MHz.
cpu: 0, clocks: 1002331, slice: 501165
CPU0<T0:1002320,T1:501152,D:3,S:501165,C:1002331>
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I3,P0) -> 20
PCI->APIC IRQ transform: (B0,I3,P1) -> 21
PCI->APIC IRQ transform: (B0,I3,P2) -> 22
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I15,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xf8800000, 00:30:1b:ab:9e:71, IRQ 18
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
hda: Maxtor 6Y160P0, ATA DISK drive
blk: queue c02ffb60, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63,
UDMA(133)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,1)) ...
for (ide0(3,1))
ide0(3,1):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 260k freed
INIT: version 2.84 booting

--- [ # cat /proc/interrupts ]
           CPU0
  0:      28638    IO-APIC-edge  timer
  2:          0          XT-PIC  cascade
  4:       1282    IO-APIC-edge  serial
 14:      11870    IO-APIC-edge  ide0
 17:      82593   IO-APIC-level  CnxAdsl
 18:      25717   IO-APIC-level  eth0
NMI:          0
LOC:      28572
ERR:          0
MIS:          0

--- [# lspci -v]

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0651
(rev 01)
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0651
        Flags: bus master, medium devsel, latency 32
        Memory at e8000000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if
00 [Normal decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8400000-e84fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
        Flags: bus master, medium devsel, latency 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if
80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller
(A,B step)
        Flags: bus master, medium devsel, latency 128, IRQ 16
        I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Flags: medium devsel, IRQ 20
        Memory at e8514000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Flags: medium devsel, IRQ 21
        Memory at e8510000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Flags: medium devsel, IRQ 22
        Memory at e8511000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:0a.0 System peripheral: Conexant: Unknown device 1610 (rev 01)
        Subsystem: Conexant: Unknown device 1610
        Flags: bus master, medium devsel, latency 32, IRQ 17
        BIST result: 00
        Memory at e8513000 (32-bit, non-prefetchable) [size=64]
        Memory at e8500000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 2

00:0a.1 ATM network controller: Conexant: Unknown device 1611 (rev 01)
        Subsystem: Conexant: Unknown device 1611
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at e8515000 (32-bit, non-prefetchable) [size=128]
        Memory at e8516000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at e400 [size=256]
        Memory at e8517000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:10.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: Unknown device 9712:25f0
        Flags: medium devsel, IRQ 19
        Memory at e8518000 (32-bit, non-prefetchable) [disabled] [size=2K]
        I/O ports at e800 [disabled] [size=128]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: Unknown
device 6325 (prog-if 00 [VGA])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device
f451
        Flags: 66Mhz, medium devsel, IRQ 16
        BIST result: 00
        Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
        Memory at e8400000 (32-bit, non-prefetchable) [disabled] [size=128K]
        I/O ports at c000 [disabled] [size=128]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] AGP version 2.0

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

