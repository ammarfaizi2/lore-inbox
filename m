Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUCKRl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUCKRl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:41:28 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:8838 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261606AbUCKRj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:39:27 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 no boot report
Date: Thu, 11 Mar 2004 17:30:34 GMT
Message-ID: <043MZAY12@server5.heliogroup.fr>
X-Mailer: Pliant 90
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 04:32:31PM +0000, Hubert Tonneau wrote:
> I've successfully run Linux kernel 2.6 on several boxes, with the excepti> on
> of the Dell PowerEdge 2600:
> The box is:
> . dual Xeon
> . Fusion SCSI controler
> . root partition is software RAID 1
> . Intel pro 1000 ethernet
> 
> It fails with all 2.6 kernel I tried, including the fresh 2.6.4
> No error message at all, the machine just freezes after displaying network
> protocols and before displaying VFS root mounting message.

You might be interested with these lines that appear in the 2.4.25 boot
sequence near the place where 2.6 freezes:

<4>SCSI Error: (0:0:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 2A 00 11 17 5D BF 00 00 08 00
<4>

Here is the 2.4.25 full boot sequence:

<4>Linux version 2.4.25 (root@sx270) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Thu Mar 11 17:43:06 CET 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 000000007ffe0000 (usable)
<4> BIOS-e820: 000000007ffe0000 - 000000007ffefc00 (ACPI data)
<4> BIOS-e820: 000000007ffefc00 - 000000007ffff000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
<5>1151MB HIGHMEM available.
<5>896MB LOWMEM available.
<4>found SMP MP-table at 000fe710
<4>hm, page 000fe000 reserved twice.
<4>hm, page 000ff000 reserved twice.
<4>hm, page 000f0000 reserved twice.
<4>On node 0 totalpages: 524256
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 294880 pages.
<6>ACPI: RSDP (v000 DELL                                      ) @ 0x000fdc20
<6>ACPI: RSDT (v001 DELL   PE2600   0x00000001 MSFT 0x0100000a) @ 0x000fdc34
<6>ACPI: FADT (v001 DELL   PE2600   0x00000001 MSFT 0x0100000a) @ 0x000fdc64
<6>ACPI: MADT (v001 DELL   PE2600   0x00000001 MSFT 0x0100000a) @ 0x000fdcd8
<6>ACPI: SPCR (v001 DELL   PE2600   0x00000001 MSFT 0x0100000a) @ 0x000fdd96
<6>ACPI: DSDT (v001 DELL   PE2600   0x00000001 MSFT 0x0100000a) @ 0x00000000
<6>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
<4>Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
<4>Processor #2 Pentium 4(tm) XEON(tm) APIC version 20
<6>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
<4>Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
<6>ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
<4>Processor #3 Pentium 4(tm) XEON(tm) APIC version 20
<6>ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
<6>Using ACPI for processor (LAPIC) configuration information
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode.
<4>OEM ID: DELL     Product ID: PE 0123      APIC at: 0xFEE00000
<4>I/O APIC #4 Version 32 at 0xFEC00000.
<4>I/O APIC #5 Version 32 at 0xFEC80000.
<4>I/O APIC #6 Version 32 at 0xFEC81000.
<4>I/O APIC #7 Version 32 at 0xFEC82000.
<4>I/O APIC #8 Version 32 at 0xFEC82800.
<4>Enabling APIC mode: Flat. Using 5 I/O APICs
<4>Processors: 4
<4>Kernel command line: BOOT_IMAGE=recover ro root=900
<6>Initializing CPU#0
<4>Detected 2791.809 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 5570.56 BogoMIPS
<6>Memory: 2070128k/2097024k available (1125k kernel code, 26512k reserved, 295k data, 112k init, 1179520k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<6>Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 0
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 0
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
<4>per-CPU timeslice cutoff: 1463.07 usecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000040
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/1 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 5570.56 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 0
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
<4>Booting processor 2/2 eip 2000
<6>Initializing CPU#2
<4>masked ExtINT on CPU#2
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 5583.66 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 3
<6>Intel machine check reporting enabled on CPU#2.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
<4>Booting processor 3/3 eip 2000
<6>Initializing CPU#3
<4>masked ExtINT on CPU#3
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 5570.56 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 3
<6>Intel machine check reporting enabled on CPU#3.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
<6>Total of 4 processors activated (22295.34 BogoMIPS).
<4>cpu_sibling_map[0] = 1
<4>cpu_sibling_map[1] = 0
<4>cpu_sibling_map[2] = 3
<4>cpu_sibling_map[3] = 2
<4>ENABLING IO-APIC IRQs
<4>Setting 4 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 4 ... ok.
<4>Setting 5 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 5 ... ok.
<4>Setting 6 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 6 ... ok.
<4>Setting 7 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 7 ... ok.
<4>Setting 8 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 8 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 4-0, 4-5, 4-11, 4-13, 4-21, 4-22, 4-23, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23, 6-12, 6-13, 6-14, 6-15, 6-16, 6-17, 6-18, 6-19, 6-20, 6-21, 6-22, 6-23, 7-2, 7-3, 7-4, 7-5, 7-6, 7-7, 7-8, 7-9, 7-10, 7-11, 7-12, 7-13, 7-14, 7-15, 7-16, 7-17, 7-18, 7-19, 7-20, 7-21, 7-22, 7-23, 8-8, 8-9, 8-10, 8-11, 8-12, 8-13, 8-14, 8-15, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22, 8-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 53.
<7>number of IO-APIC #4 registers: 24.
<7>number of IO-APIC #5 registers: 24.
<7>number of IO-APIC #6 registers: 24.
<7>number of IO-APIC #7 registers: 24.
<7>number of IO-APIC #8 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #4......
<7>.... register #00: 04000000
<7>.......    : physical APIC id: 04
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 00F 0F  0    0    0   0   0    1    1    39
<7> 02 00F 0F  0    0    0   0   0    1    1    31
<7> 03 00F 0F  0    0    0   0   0    1    1    41
<7> 04 00F 0F  0    0    0   0   0    1    1    49
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 00F 0F  0    0    0   0   0    1    1    51
<7> 07 00F 0F  0    0    0   0   0    1    1    59
<7> 08 00F 0F  0    0    0   0   0    1    1    61
<7> 09 00F 0F  0    0    0   0   0    1    1    69
<7> 0a 00F 0F  0    0    0   0   0    1    1    71
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 00F 0F  0    0    0   0   0    1    1    79
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 00F 0F  0    0    0   0   0    1    1    81
<7> 0f 00F 0F  0    0    0   0   0    1    1    89
<7> 10 00F 0F  1    1    0   1   0    1    1    91
<7> 11 00F 0F  1    1    0   1   0    1    1    99
<7> 12 00F 0F  1    1    0   1   0    1    1    A1
<7> 13 00F 0F  1    1    0   1   0    1    1    A9
<7> 14 00F 0F  1    1    0   1   0    1    1    B1
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #5......
<7>.... register #00: 05000000
<7>.......    : physical APIC id: 05
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 05000000
<7>.......     : arbitration: 05
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 00F 0F  1    1    0   1   0    1    1    B9
<7> 01 00F 0F  1    1    0   1   0    1    1    C1
<7> 02 00F 0F  1    1    0   1   0    1    1    C9
<7> 03 00F 0F  1    1    0   1   0    1    1    D1
<7> 04 00F 0F  1    1    0   1   0    1    1    D9
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 000 00  1    0    0   0   0    0    0    00
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 000 00  1    0    0   0   0    0    0    00
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #6......
<7>.... register #00: 06000000
<7>.......    : physical APIC id: 06
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 06000000
<7>.......     : arbitration: 06
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 00F 0F  1    1    0   1   0    1    1    E1
<7> 01 00F 0F  1    1    0   1   0    1    1    E9
<7> 02 00F 0F  1    1    0   1   0    1    1    32
<7> 03 00F 0F  1    1    0   1   0    1    1    3A
<7> 04 00F 0F  1    1    0   1   0    1    1    42
<7> 05 00F 0F  1    1    0   1   0    1    1    4A
<7> 06 00F 0F  1    1    0   1   0    1    1    52
<7> 07 00F 0F  1    1    0   1   0    1    1    5A
<7> 08 00F 0F  1    1    0   1   0    1    1    62
<7> 09 00F 0F  1    1    0   1   0    1    1    6A
<7> 0a 00F 0F  1    1    0   1   0    1    1    72
<7> 0b 00F 0F  1    1    0   1   0    1    1    7A
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #7......
<7>.... register #00: 07000000
<7>.......    : physical APIC id: 07
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 07000000
<7>.......     : arbitration: 07
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 00F 0F  1    1    0   1   0    1    1    82
<7> 01 00F 0F  1    1    0   1   0    1    1    8A
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 000 00  1    0    0   0   0    0    0    00
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 000 00  1    0    0   0   0    0    0    00
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 000 00  1    0    0   0   0    0    0    00
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #8......
<7>.... register #00: 08000000
<7>.......    : physical APIC id: 08
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 08000000
<7>.......     : arbitration: 08
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 00F 0F  1    1    0   1   0    1    1    92
<7> 01 00F 0F  1    1    0   1   0    1    1    9A
<7> 02 00F 0F  1    1    0   1   0    1    1    A2
<7> 03 00F 0F  1    1    0   1   0    1    1    AA
<7> 04 00F 0F  1    1    0   1   0    1    1    B2
<7> 05 00F 0F  1    1    0   1   0    1    1    BA
<7> 06 00F 0F  1    1    0   1   0    1    1    C2
<7> 07 00F 0F  1    1    0   1   0    1    1    CA
<7> 08 000 00  1    0    0   0   0    0    0    00
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ12 -> 0:12
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ24 -> 1:0
<7>IRQ25 -> 1:1
<7>IRQ26 -> 1:2
<7>IRQ27 -> 1:3
<7>IRQ28 -> 1:4
<7>IRQ48 -> 2:0
<7>IRQ49 -> 2:1
<7>IRQ50 -> 2:2
<7>IRQ51 -> 2:3
<7>IRQ52 -> 2:4
<7>IRQ53 -> 2:5
<7>IRQ54 -> 2:6
<7>IRQ55 -> 2:7
<7>IRQ56 -> 2:8
<7>IRQ57 -> 2:9
<7>IRQ58 -> 2:10
<7>IRQ59 -> 2:11
<7>IRQ72 -> 3:0
<7>IRQ73 -> 3:1
<7>IRQ96 -> 4:0
<7>IRQ97 -> 4:1
<7>IRQ98 -> 4:2
<7>IRQ99 -> 4:3
<7>IRQ100 -> 4:4
<7>IRQ101 -> 4:5
<7>IRQ102 -> 4:6
<7>IRQ103 -> 4:7
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2791.7565 MHz.
<4>..... host bus clock speed is 99.7054 MHz.
<4>cpu: 0, clocks: 997054, slice: 199410
<4>CPU0<T0:997040,T1:797616,D:14,S:199410,C:997054>
<4>cpu: 1, clocks: 997054, slice: 199410
<4>cpu: 2, clocks: 997054, slice: 199410
<4>cpu: 3, clocks: 997054, slice: 199410
<4>CPU1<T0:997040,T1:598208,D:12,S:199410,C:997054>
<4>CPU2<T0:997040,T1:398800,D:10,S:199410,C:997054>
<4>CPU3<T0:997040,T1:199392,D:8,S:199410,C:997054>
<4>checking TSC synchronization across CPUs: passed.
<4>Waiting on wait_init_idle (map = 0xe)
<4>All processors have done init_idle
<6>PCI: PCI BIOS revision 2.10 entry at 0xfc6ce, last bus=11
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
<4>Transparent bridge - PCI device 8086:244e
<6>PCI: Using IRQ router PIIX/ICH [8086/2480] at 00:1f.0
<6>PCI->APIC IRQ transform: (B0,I29,P0) -> 16
<6>PCI->APIC IRQ transform: (B0,I31,P0) -> 16
<6>PCI->APIC IRQ transform: (B3,I1,P0) -> 28
<6>PCI->APIC IRQ transform: (B9,I13,P0) -> 72
<6>PCI->APIC IRQ transform: (B9,I13,P1) -> 73
<6>PCI->APIC IRQ transform: (B11,I0,P0) -> 16
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS not found.
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<6>Detected PS/2 Mouse Port.
<6>Real Time Clock Driver v1.10f
<6>Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
<6>Copyright (c) 1999-2003 Intel Corporation.
<6>eth0: Intel(R) PRO/1000 Network Connection
<4>3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
<6>See Documentation/networking/vortex.txt
<6>0b:00.0: 3Com PCI 3c905C Tornado at 0xcc80. Vers LK1.1.18-ac
<4> 00:04:75:c9:70:0c, IRQ 16
<6>  product code 564c rev 00.6 date 09-28-02
<7>  Internal config register is 1800000, transceivers 0xa.
<6>  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
<6>  MII transceiver found at address 24, status 7809.
<6>  Enabling bus-master transmits and whole-frame receives.
<6>0b:00.0: scatter/gather enabled. h/w checksums enabled
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>ICH3: IDE controller at PCI slot 00:1f.1
<4>PCI: Enabling device 00:1f.1 (0005 -> 0007)
<6>ICH3: chipset revision 2
<6>ICH3: not 100% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
<6>    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
<4>hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<6>SCSI subsystem driver Revision: 1.00
<6>Fusion MPT base driver 2.05.11.03
<6>Copyright (c) 1999-2003 LSI Logic Corporation
<6>mptbase: Initiating ioc0 bringup
<6>ioc0: 53C1030: Capabilities={Initiator}
<6>mptbase: Initiating ioc1 bringup
<6>ioc1: 53C1030: Capabilities={Initiator}
<6>mptbase: 2 MPT adapters found, 2 installed.
<6>Fusion MPT SCSI Host driver 2.05.11.03
<6>scsi0 : ioc0: LSI53C1030, FwRev=01000c00h, Ports=1, MaxQ=255, IRQ=72
<6>scsi1 : ioc1: LSI53C1030, FwRev=01000c00h, Ports=1, MaxQ=255, IRQ=73
<4>blk: queue f7bb0a18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: FUJITSU   Model: MAP3147NC         Rev: 5605
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7bb0818, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: FUJITSU   Model: MAP3147NC         Rev: 5605
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7bb0618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: PE/PV     Model: 1x2 SCSI BP       Rev: 1.1 
<4>  Type:   Processor                          ANSI SCSI revision: 02
<4>blk: queue f7affc18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LC       Rev: DS04
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7adca18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LC       Rev: DS04
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7adc818, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LC       Rev: DS04
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7adc618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LC       Rev: DS04
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7adc418, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LC       Rev: DS04
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7adc218, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LC       Rev: DS04
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue f7adc018, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: PE/PV     Model: 1x6 SCSI BP       Rev: 1.1 
<4>  Type:   Processor                          ANSI SCSI revision: 02
<4>blk: queue f7a0ee18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
<4>Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
<4>Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
<4>Attached scsi disk sde at scsi1, channel 0, id 2, lun 0
<4>Attached scsi disk sdf at scsi1, channel 0, id 3, lun 0
<4>Attached scsi disk sdg at scsi1, channel 0, id 4, lun 0
<4>Attached scsi disk sdh at scsi1, channel 0, id 5, lun 0
<4>SCSI device sda: 286749480 512-byte hdwr sectors (146816 MB)
<6>Partition check:
<6> sda: sda1
<4>SCSI device sdb: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdb: sdb1
<4>SCSI device sdc: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdc: sdc1
<4>SCSI device sdd: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdd: sdd1
<4>SCSI device sde: 286749480 512-byte hdwr sectors (146816 MB)
<6> sde: sde1
<4>SCSI device sdf: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdf: sdf1
<4>SCSI device sdg: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdg: sdg1
<4>SCSI device sdh: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdh: sdh1
<6>md: linear personality registered as nr 1
<6>md: raid0 personality registered as nr 2
<6>md: raid1 personality registered as nr 3
<6>md: raid5 personality registered as nr 4
<6>raid5: measuring checksumming speed
<4>   8regs     :  3225.200 MB/sec
<4>   32regs    :  2412.400 MB/sec
<4>   pIII_sse  :  3657.200 MB/sec
<4>   pII_mmx   :  3299.600 MB/sec
<4>   p5_mmx    :  3363.200 MB/sec
<4>raid5: using function: pIII_sse (3657.200 MB/sec)
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6> [events: 00000027]
<6> [events: 00000027]
<6> [events: 00000017]
<6> [events: 00000017]
<6> [events: 00000017]
<6> [events: 00000017]
<6> [events: 00000017]
<6> [events: 00000017]
<6>md: autorun ...
<6>md: considering sdh1 ...
<6>md:  adding sdh1 ...
<6>md:  adding sdg1 ...
<6>md:  adding sdf1 ...
<6>md:  adding sde1 ...
<6>md:  adding sdd1 ...
<6>md:  adding sdc1 ...
<6>md: created md1
<6>md: bind<sdc1,1>
<6>md: bind<sdd1,2>
<6>md: bind<sde1,3>
<6>md: bind<sdf1,4>
<6>md: bind<sdg1,5>
<6>md: bind<sdh1,6>
<6>md: running: <sdh1><sdg1><sdf1><sde1><sdd1><sdc1>
<6>md: sdh1's event counter: 00000017
<6>md: sdg1's event counter: 00000017
<6>md: sdf1's event counter: 00000017
<6>md: sde1's event counter: 00000017
<6>md: sdd1's event counter: 00000017
<6>md: sdc1's event counter: 00000017
<6>md1: max total readahead window set to 1280k
<6>md1: 5 data-disks, max readahead per data-disk: 256k
<6>raid5: device sdh1 operational as raid disk 5
<6>raid5: device sdg1 operational as raid disk 4
<6>raid5: device sdf1 operational as raid disk 3
<6>raid5: device sde1 operational as raid disk 2
<6>raid5: device sdd1 operational as raid disk 1
<6>raid5: device sdc1 operational as raid disk 0
<6>raid5: allocated 6429kB for md1
<4>raid5: raid level 5 set md1 active with 6 out of 6 devices, algorithm 0
<4>RAID5 conf printout:
<4> --- rd:6 wd:6 fd:0
<4> disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc1
<4> disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdd1
<4> disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sde1
<4> disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdf1
<4> disk 4, s:0, o:1, n:4 rd:4 us:1 dev:sdg1
<4> disk 5, s:0, o:1, n:5 rd:5 us:1 dev:sdh1
<4>RAID5 conf printout:
<4> --- rd:6 wd:6 fd:0
<4> disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc1
<4> disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdd1
<4> disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sde1
<4> disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdf1
<4> disk 4, s:0, o:1, n:4 rd:4 us:1 dev:sdg1
<4> disk 5, s:0, o:1, n:5 rd:5 us:1 dev:sdh1
<6>md: updating md1 RAID superblock on device
<6>md: sdh1 [events: 00000018]<6>(write) sdh1's sb offset: 143371968
<6>md: sdg1 [events: 00000018]<6>(write) sdg1's sb offset: 143371968
<6>md: sdf1 [events: 00000018]<6>(write) sdf1's sb offset: 143371968
<6>md: sde1 [events: 00000018]<6>(write) sde1's sb offset: 143371968
<6>md: sdd1 [events: 00000018]<6>(write) sdd1's sb offset: 143371968
<6>md: sdc1 [events: 00000018]<6>(write) sdc1's sb offset: 143371968
<6>md: considering sdb1 ...
<6>md:  adding sdb1 ...
<6>md:  adding sda1 ...
<6>md: created md0
<6>md: bind<sda1,1>
<6>md: bind<sdb1,2>
<6>md: running: <sdb1><sda1>
<6>md: sdb1's event counter: 00000027
<6>md: sda1's event counter: 00000027
<6>md: RAID level 1 does not need chunksize! Continuing anyway.
<6>md0: max total readahead window set to 124k
<6>md0: 1 data-disks, max readahead per data-disk: 124k
<6>raid1: device sdb1 operational as mirror 1
<6>raid1: device sda1 operational as mirror 0
<6>raid1: raid set md0 active with 2 out of 2 mirrors
<6>md: updating md0 RAID superblock on device
<6>md: sdb1 [events: 00000028]<6>(write) sdb1's sb offset: 143371968
<6>md: sda1 [events: 00000028]<6>(write) sda1's sb offset: 143371968
<4>SCSI Error: (0:0:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 2A 00 11 17 5D BF 00 00 08 00
<4>
<6>md: ... autorun DONE.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP
<6>IP: routing cache hash table of 16384 buckets, 128Kbytes
<6>TCP: Hash tables configured (established 262144 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<6>Freeing unused kernel memory: 112k freed
<4>raid5: switching cache buffer size, 4096 --> 1024
<4>raid5: switching cache buffer size, 1024 --> 4096
<6>e1000: eth0 NIC Link is Up 100 Mbps Full Duplex

