Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131904AbRABU6X>; Tue, 2 Jan 2001 15:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131909AbRABU6N>; Tue, 2 Jan 2001 15:58:13 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:26603 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131904AbRABU55>;
	Tue, 2 Jan 2001 15:57:57 -0500
From: thunder7@xs4all.nl
Date: Fri, 4 Feb 2000 08:26:40 +0100
To: linux-smp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: unexpected io-apic (Abit VP6)
Message-ID: <20000204082640.A1940@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon booting my shiny new Abit VP6 motherboard, I get:

.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org

and here is the dmesg, followed by lspci -xx.

Hope it is of some use!

Greetings,
Jurriaan

Linux version 2.2.19pre3 (root@middle) (gcc version 2.95.2 19991024 (release)) #1 SMP Wed Dec 27 20:40:38 CET 2000
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 0ff00000 @ 00100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 703165 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1402.47 BogoMIPS
Memory: 257520k/262144k available (1224k kernel code, 420k reserved, 2892k data, 88k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
CPU serial number disabled.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
per-CPU timeslice cutoff: 49.96 usecs.
CPU0: Intel Pentium III (Coppermine) stepping 03
Getting VERSION: 40011
Getting VERSION: 40011
Getting LVT0: 700
Getting LVT1: 400
setup_APIC_clock() called.
calibrating APIC timer ... 
..... 7031144 CPU clocks in 1 timer chip tick.
..... 1004448 APIC bus clocks in 1 timer chip tick.
..... CPU clock speed is 703.1144 MHz.
..... system bus clock speed is 100.4448 MHz.
CPU map: 3
Booting processor 1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Deasserting INIT.
Sending STARTUP #1.
After apic_write.
Before start apic_write.
Startup point 1.
Waiting for send to finish...
CPU#1 waiting for CALLOUT
+Sending STARTUP #2.
After apic_write.
Before start apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before enable_local_APIC().
setup_APIC_clock() called.
waiting for other CPU calibrating APIC ... done, continuing.
Calibrating delay loop... 1405.74 BogoMIPS
Stack at about cfffbfa4
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (2808.21 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-12, 2-17, 2-20, 2-21, 2-22, 2-23 not connected.
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  0    0    0   0   0    1    1    71
 06 000 00  0    0    0   0   0    1    1    79
 07 000 00  0    0    0   0   0    1    1    81
 08 000 00  0    0    0   0   0    1    1    89
 09 000 00  0    0    0   0   0    1    1    91
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    99
 0f 000 00  0    0    0   0   0    1    1    A1
 10 0FF 0F  1    1    0   1   0    1    1    A9
 11 000 00  1    0    0   0   0    0    0    00
 12 0FF 0F  1    1    0   1   0    1    1    B1
 13 0FF 0F  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
matroxfb: Matrox unknown G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x24bpp (virtual: 1024x5460)
matroxfb: framebuffer at 0xD4000000, mapped to 0xd0805000, size 33554432
Console: switching to colour frame buffer device 85x38
fb0: MATROX VGA frame buffer device
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DHEA-34330, ATA DISK drive
hdb: IBM-DJNA-372200, ATA DISK drive
hde: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdc00-0xdc07,0xe002 on irq 18
hda: IBM-DHEA-34330, 4134MB w/476kB Cache, CHS=527/255/63, UDMA(33)
hdb: IBM-DJNA-372200, 21557MB w/1966kB Cache, CHS=2748/255/63, UDMA(33)
hde: IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=89355/16/63, UDMA(100)
FDC 0 is a post-1991 82077
scsi : 0 hosts.
scsi : detected total.
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
PPP BSD Compression module registered
PPP Deflate Compression module registered
pcnet32.c: PCI bios is present, checking for devices...
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 >
 hdb: hdb1 hdb2
 hde: [PTBL] [5606/255/63] hde1 hde2 hde3 hde4 < hde5 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 88k freed
Adding Swap: 530104k swap-space (priority -1)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00: 06 11 91 06 06 00 10 22 c4 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 04 a2
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 d6 f0 d8 00 d4 f0 d5 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 04 00 00

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00: 06 11 38 30 07 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 04 00 00

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00: 06 11 57 30 00 00 90 02 40 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 03)
00: 03 11 04 00 05 00 30 02 03 00 80 01 08 78 00 00
10: 01 dc 00 00 01 e0 00 00 01 e4 00 00 01 e8 00 00
20: 01 ec 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03)
00: 2b 10 25 05 07 00 90 02 03 00 00 03 08 20 00 00
10: 08 00 00 d4 00 00 00 d6 00 00 00 d7 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 f8 19
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 10 20

-- 
BOFH excuse #272:

Netscape has crashed
GNU/Linux 2.2.19pre3 SMP 2x1117 bogomips load av: 0.00 0.00 0.00
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
