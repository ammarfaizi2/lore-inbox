Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314640AbSEBQ3R>; Thu, 2 May 2002 12:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314641AbSEBQ3Q>; Thu, 2 May 2002 12:29:16 -0400
Received: from mail2.uww.edu ([140.146.128.180]:42018 "EHLO mail2.uww.edu")
	by vger.kernel.org with ESMTP id <S314640AbSEBQ3N>;
	Thu, 2 May 2002 12:29:13 -0400
From: "Nick Ciesinski" <ciesinskna26@uww.edu>
To: <linux-kernel@vger.kernel.org>
Subject: i860 Chipset and Hyper-Threading Processors
Date: Thu, 2 May 2002 11:30:25 -0500
Message-ID: <000701c1f1f6$aa0074d0$1cde928c@UW3RYG00Y7HQGM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-OriginalArrivalTime: 02 May 2002 16:29:11.0162 (UTC) FILETIME=[7D6CDDA0:01C1F1F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently received a machine with the Intel 860 chipset that has 2
Intel Hyper-Threading processors.  The system uses the Supermicro P4DCE
mainboard.  I went digging through the linux-kernel mailing list
archives and found information regarding the P4DCE+ mainboard.  I was
able to get Linux recognize all the siblings from the information
provided in February.  The questions I have are to some of the boot log
messages.  

The first is the "init.c:148: bad pte 7fff3163." Message that appears.
In the original posting pack in February, Alan Cox said this is
something to look into.  He said that the issue may be resolved in a
patch that was delayed at that time.  The user at that time was using
kernel 2.4.17, I am using kernel 2.4.18 and I am getting the message.
Was the patch ever added to the new kernel?  I could not see anything
regarding the issue in the change logs.  The reason I am asking is
because if it is indeed an issue with the BIOS that I want to let our PC
vendor know.  Does anyone have any insight about this error message.

The other message I am getting is:

ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#0 ID 2 is already used!...
... fixing up to 4. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 4 ... ok.


This message I saw in the users post back in February, but nothing was
mentioned about it.  Is this a serious issue? Once again if this is a
serious bug I would like to get it corrected.  I just don't want to send
our hardware vendor on a wild goose chase if the issue is not serious
and it is simply a cosmetic error.  I know that someone probably put it
in there for a reason, but I have seen to many errors like this for
other OS's that I was later told are cosmetic.

I have included the entire boot log below if you want more information.

Thanks

Nick Ciesinski
University of Wisconsin - Whitewater

Linux version 2.4.18 (root@buzzsaw.reslife.uww.edu) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-98)) #4 SMP Thu May 2 01:10:02 CDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved) 1151MB
HIGHMEM available. found SMP MP-table at 000f5010 hm, page 000f5000
reserved twice. hm, page 000f6000 reserved twice. hm, page 000f1000
reserved twice. hm, page 000f2000 reserved twice. On node 0 totalpages:
524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f6bf0
RSD PTR  v0 [IntelR]
ACPI table found: RSDT v1 [IntelR AWRDACPI 16944.11825]
init.c:148: bad pte 7fff3163.
ACPI table found: FACP v1 [IntelR AWRDACPI 16944.11825]
init.c:148: bad pte 7fff3163.
ACPI table found: APIC v1 [IntelR AWRDACPI 16944.11825]
init.c:148: bad pte 7fff6163.
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0001] id[0x1] enabled[1])
CPU 1 (0x0100) enabledProcessor #1 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
CPU 2 (0x0200) enabledProcessor #2 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0003] id[0x3] enabled[1])
CPU 3 (0x0300) enabledProcessor #3 Unknown CPU [15:2] APIC version 16

IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0]) INT_SRC_OVR
(bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x3]) INT_SRC_OVR
(bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3]) 4 CPUs
total Local APIC address fee00000 Enabling the CPU's according to the
ACPI table Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000 I/O APIC
#2 Version 17 at 0xFEC00000.
Processors: 4
init.c:148: bad pte 7fff6163.
Kernel command line: BOOT_IMAGE=linux ro root=303
BOOT_FILE=/boot/vmlinuz-2.4.18 acpismp=force Initializing CPU#0 Detected
1982.576 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3958.37 BogoMIPS
Memory: 2061292k/2097088k available (1445k kernel code, 35408k reserved,
412k data, 224k init, 1179584k highmem) Dentry-cache hash table entries:
262144 (order: 9, 2097152 bytes) Inode-cache hash table entries: 131072
(order: 8, 1048576 bytes) Mount-cache hash table entries: 32768 (order:
6, 262144 bytes) Buffer-cache hash table entries: 131072 (order: 7,
524288 bytes) Page-cache hash table entries: 524288 (order: 9, 2097152
bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000 Intel
machine check architecture supported. Intel machine check reporting
enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000 Intel
machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
per-CPU timeslice cutoff: 1463.19 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3958.37 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000 Intel
machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3958.37 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000 Intel
machine check reporting enabled on CPU#2.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU2: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3958.37 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000 Intel
machine check reporting enabled on CPU#3.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU3: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Total of 4 processors activated (15833.49 BogoMIPS). cpu_sibling_map[0]
= 3 cpu_sibling_map[1] = 2 cpu_sibling_map[2] = 1 cpu_sibling_map[3] = 0
ENABLING IO-APIC IRQs BIOS bug, IO-APIC#0 ID 2 is already used!... ...
fixing up to 4. (tell your hw vendor) ...changing IO-APIC physical APIC
ID to 4 ... ok. init IO_APIC IRQs  IO-APIC (apicid-pin) 4-0, 4-5, 4-9,
4-10, 4-11, 4-18, 4-20, 4-21, 4-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  0    0    0   0   0    1    1    51
 07 00F 0F  0    0    0   0   0    1    1    59
 08 00F 0F  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    1    1    69
 0d 00F 0F  0    0    0   0   0    1    1    71
 0e 00F 0F  0    0    0   0   0    1    1    79
 0f 00F 0F  0    0    0   0   0    1    1    81
 10 00F 0F  1    1    0   1   0    1    1    89
 11 00F 0F  1    1    0   1   0    1    1    91
 12 000 00  1    0    0   0   0    0    0    00
 13 00F 0F  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 00F 0F  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1982.4323 MHz.
..... host bus clock speed is 99.1214 MHz.
cpu: 0, clocks: 991214, slice: 198242
CPU0<T0:991200,T1:792928,D:30,S:198242,C:991214>
cpu: 1, clocks: 991214, slice: 198242
cpu: 2, clocks: 991214, slice: 198242
cpu: 3, clocks: 991214, slice: 198242
CPU1<T0:991200,T1:594704,D:12,S:198242,C:991214>
CPU2<T0:991200,T1:396464,D:10,S:198242,C:991214>
CPU3<T0:991200,T1:198224,D:8,S:198242,C:991214>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P2) -> 23
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B4,I4,P0) -> 16
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039 Initializing RT
netlink socket Starting kswapd allocated 32 pages and 32 bhs reserved
for the highmem bounces Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled ttyS00 at 0x03f8 (irq = 4) is a 16550A ttyS01
at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 4
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340016A, ATA DISK drive
hdc: CDU5211, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:30:48:11:A8:CB, IRQ 16.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Intel i860 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Unknown @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 2040244k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal kjournald
starting.  Commit interval 5 seconds EXT3 FS 2.4-0.9.17, 10 Jan 2002 on
ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

