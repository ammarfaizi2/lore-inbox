Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290034AbSAKRdp>; Fri, 11 Jan 2002 12:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290031AbSAKRdb>; Fri, 11 Jan 2002 12:33:31 -0500
Received: from [199.217.175.51] ([199.217.175.51]:34960 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S290030AbSAKRdH>; Fri, 11 Jan 2002 12:33:07 -0500
From: Jim Studt <jim@federated.com>
Message-Id: <200201111732.g0BHWYhV003902@core.federated.com>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.LNX.4.33.0201111650370.17814-100000@netfinity.realnet.co.sz>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Date: Fri, 11 Jan 2002 11:32:34 -0600 (CST)
CC: jim@federated.com, Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL94 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo asks for more info...

I have IO-APIC configured in the kernel...
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y



# cat /proc/interrupts (with the card ifconfig-ed up, eth2 is on the 2nd PCI)
           CPU0       
  0:    3183548    IO-APIC-edge  timer
  1:          6    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
 15:          4    IO-APIC-edge  ide1
 20:     143691   IO-APIC-level  eth0
 24:     108732   IO-APIC-level  aic7xxx
 26:          9   IO-APIC-level  eth2
NMI:          0 
LOC:    3183669 
ERR:          0
MIS:          0



And the dmesg of the most recent boot.  IO-APIC is enabled.

Linux version 2.4.17 (root@warehouse) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 SMP Fri Jan 11 02:22:20 CST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
found SMP MP-table at 000f7ac0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: Gateway Product ID: 7450R       APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #0 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=Linux ro root=801
Initializing CPU#0
Detected 930.434 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1854.66 BogoMIPS
Memory: 255668k/262080k available (1013k kernel code, 6024k reserved, 307k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.26 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 0 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 0 ... ok.
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-1, 2-2, 2-3, 2-6, 2-7, 2-11, 2-12, 2-13, 2-14, 2-15 not connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
number of MP IRQ sources: 21.
number of IO-APIC #0 registers: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #0......
.... register #00: 00000000
.......    : physical APIC id: 00
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    1    0   1   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 001 01  1    1    0   1   0    1    1    A9
 05 001 01  1    1    0   1   0    1    1    B1
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 001 01  1    1    0   1   0    1    1    B9
 09 001 01  1    1    0   1   0    1    1    C1
 0a 001 01  1    1    0   1   0    1    1    C9
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 1:10
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 930.3575 MHz.
..... host bus clock speed is 132.9081 MHz.
cpu: 0, clocks: 1329081, slice: 664540
CPU0<T0:1329072,T1:664528,D:4,S:664540,C:1329081>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfda1f, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI->APIC IRQ transform: (B0,I7,P0) -> 20
PCI->APIC IRQ transform: (B0,I9,P0) -> 21
PCI->APIC IRQ transform: (B0,I11,P0) -> 24
PCI->APIC IRQ transform: (B0,I12,P0) -> 25
PCI->APIC IRQ transform: (B1,I13,P0) -> 26
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:DMA, hdd:pio
hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:C0:9F:04:5E:15, IRQ 20.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: Intel Corp. 82557 [Ethernet Pro 100] (#2), 00:C0:9F:04:5E:14, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SDR       Model: GEM318            Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: unknown partition table
Attached scsi generic sg2 at scsi0, channel 0, id 8, lun 0,  type 3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed


-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
