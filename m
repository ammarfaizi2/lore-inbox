Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFZR2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 13:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTFZR2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 13:28:18 -0400
Received: from fmr04.intel.com ([143.183.121.6]:36312 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262175AbTFZR1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 13:27:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading
Date: Thu, 26 Jun 2003 09:29:16 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1901048896@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading
Thread-Index: AcM76vimLfRZaHyuT3SgjeN7Lj4YGQAFH5EA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Bruno Cornec" <Bruno.Cornec@hp.com>, <linux-kernel@vger.kernel.org>
Cc: <sophie.pasquier@hp.com>
X-OriginalArrivalTime: 26 Jun 2003 16:29:17.0485 (UTC) FILETIME=[16B0ADD0:01C33C00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

  Can you enable ACPI in the config and try again. With that you should be able to see all the processors.

Thanks,
-Venki
> -----Original Message-----
> From: Bruno Cornec [mailto:Bruno.Cornec@hp.com] 
> Sent: Thursday, June 26, 2003 7:08 AM
> To: linux-kernel@vger.kernel.org
> Cc: sophie.pasquier@hp.com; Pallipadi, Venkatesh
> Subject: Re: PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading
> 
> 
> Hello,
> 
> Thanks to Venkatesh Pallipadi, I made some progress on that problem.
> I recompiled 2.4.21-ac2 and activated the CONFIG_X86_CLUSTERED_APIC
> Now with HT activated in the BIOS, the machine is able to 
> boot but only 
> half of the processors are detected :-(
> 
> I've attached my .config and the result of dmesg just after booting.
> I've surely missed something so ask again for your kind support.
> Thanks in advance for your help.
> 
> Bruno Cornec (Bruno.Cornec@hp.com) said:
> 
> (Distro SuSE SLES8 - kernel 2.4.21-ac2)
> --------------------------------------------------------------------
> The latest BIOS has been put on the system (P44 - 2003-02-18)
> --------------------------------------------------------------------
> cat /proc/cmdline :
> root=/dev/cciss/c0d0p1  ide=nodma  (16 CPUs)
> 
> --------------------------------------------------------------------
> boot.msg
> 
> Inspecting /boot/System.map
> Loaded 18441 symbols from /boot/System.map.
> Symbols match kernel version 2.4.21.
> No module symbols loaded.
> klogd 1.4.1, log source = ksyslog started.
> <4>Linux version 2.4.21-ac2 (root@linux) (gcc version 3.2) #1 
> SMP Tue Jun 24 11:09:11 CEST 2003
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
> <4> BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
> <4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> <4> BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
> <4> BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
> <4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> <4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
> <4> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> <4> BIOS-e820: 0000000100000000 - 000000040ffff000 (usable)
> <5>15743MB HIGHMEM available.
> <5>896MB LOWMEM available.
> <4>found SMP MP-table at 000f4fd0
> <4>hm, page 000f4000 reserved twice.
> <4>hm, page 000f5000 reserved twice.
> <4>hm, page 000f7000 reserved twice.
> <4>hm, page 000f8000 reserved twice.
> <4>On node 0 totalpages: 4259839
> <4>zone(0): 4096 pages.
> <4>zone(1): 225280 pages.
> <4>zone(2): 4030463 pages.
> <4>Intel MultiProcessor Specification v1.4
> <4>    Virtual Wire compatibility mode.
> <4>OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
> <4>Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #2 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #4 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #8 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #10 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #12 Pentium 4(tm) XEON(tm) APIC version 20
> <4>Processor #14 Pentium 4(tm) XEON(tm) APIC version 20
> <4>I/O APIC #8 Version 17 at 0xFEC00000.
> <4>I/O APIC #9 Version 17 at 0xFEC01000.
> <4>I/O APIC #10 Version 17 at 0xFEC02000.
> <4>Processors: 8
> <4>xAPIC support is present
> <4>Enabling APIC mode: Flat.	Using 3 I/O APICs
> <4>Kernel command line: root=/dev/cciss/c0d0p1  ide=nodma
> <6>ide_setup: ide=nodma : Prevented DMA
> <6>Initializing CPU#0
> <4>Detected 1999.337 MHz processor.
> <4>Console: colour VGA+ 80x25
> <4>Calibrating delay loop... 3984.58 BogoMIPS
> <6>Memory: 16573608k/17039356k available (1617k kernel code, 
> 203152k reserved, 376k data, 288k init, 15859644k highmem)
> <6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> <6>Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
> <6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> <6>Buffer cache hash table entries: 524288 (order: 9, 2097152 bytes)
> <4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 0
> <6>Intel machine check architecture supported.
> <6>Intel machine check reporting enabled on CPU#0.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <6>Enabling fast FPU save and restore... done.
> <6>Enabling unmasked SIMD FPU exception support... done.
> <6>Checking 'hlt' instruction... OK.
> <4>POSIX conformance testing by UNIFIX
> <4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> <4>mtrr: detected mtrr type: Intel
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 0
> <6>Intel machine check reporting enabled on CPU#0.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>per-CPU timeslice cutoff: 1462.74 usecs.
> <4>task migration cache decay timeout: 10 msecs.
> <4>enabled ExtINT on CPU#0
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Booting processor 1/2 eip 2000
> <6>Initializing CPU#1
> <4>masked ExtINT on CPU#1
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 1
> <6>Intel machine check reporting enabled on CPU#1.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>Booting processor 2/4 eip 2000
> <6>Initializing CPU#2
> <4>masked ExtINT on CPU#2
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 2
> <6>Intel machine check reporting enabled on CPU#2.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>Booting processor 3/6 eip 2000
> <6>Initializing CPU#3
> <4>masked ExtINT on CPU#3
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 3
> <6>Intel machine check reporting enabled on CPU#3.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>Booting processor 4/8 eip 2000
> <6>Initializing CPU#4
> <4>masked ExtINT on CPU#4
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 4
> <6>Intel machine check reporting enabled on CPU#4.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>Booting processor 5/10 eip 2000
> <6>Initializing CPU#5
> <4>masked ExtINT on CPU#5
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 5
> <6>Intel machine check reporting enabled on CPU#5.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU5: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>Booting processor 6/12 eip 2000
> <6>Initializing CPU#6
> <4>masked ExtINT on CPU#6
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 6
> <6>Intel machine check reporting enabled on CPU#6.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <4>Booting processor 7/14 eip 2000
> <6>Initializing CPU#7
> <4>masked ExtINT on CPU#7
> <4>ESR value before enabling vector: 00000000
> <4>ESR value after enabling vector: 00000000
> <4>Calibrating delay loop... 3997.69 BogoMIPS
> <6>CPU: Trace cache: 12K uops, L1 D cache: 8K
> <6>CPU: L2 cache: 512K
> <6>CPU: L3 cache: 2048K
> <6>CPU: Physical Processor ID: 7
> <6>Intel machine check reporting enabled on CPU#7.
> <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> <4>CPU7: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
> <6>Total of 8 processors activated (31968.46 BogoMIPS).
> <4>WARNING: No sibling found for CPU 0.
> <4>WARNING: No sibling found for CPU 1.
> <4>WARNING: No sibling found for CPU 2.
> <4>WARNING: No sibling found for CPU 3.
> <4>WARNING: No sibling found for CPU 4.
> <4>WARNING: No sibling found for CPU 5.
> <4>WARNING: No sibling found for CPU 6.
> <4>WARNING: No sibling found for CPU 7.
> <4>ENABLING IO-APIC IRQs
> <4>Setting 8 in the phys_id_present_map
> <6>...changing IO-APIC physical APIC ID to 8 ... ok.
> <4>Setting 9 in the phys_id_present_map
> <6>...changing IO-APIC physical APIC ID to 9 ... ok.
> <4>Setting 10 in the phys_id_present_map
> <6>...changing IO-APIC physical APIC ID to 10 ... ok.
> <7>init IO_APIC IRQs
> <7> IO-APIC (apicid-pin) 8-0, 8-3, 8-5, 8-7, 8-11, 10-1, 
> 10-2, 10-4 not connected.
> <6>..TIMER: vector=0x31 pin1=2 pin2=0
> <7>number of MP IRQ sources: 68.
> <7>number of IO-APIC #8 registers: 16.
> <7>number of IO-APIC #9 registers: 16.
> <7>number of IO-APIC #10 registers: 16.
> <6>testing the IO APIC.......................
> <4>
> <7>IO APIC #8......
> <7>.... register #00: 08000000
> <7>.......    : physical APIC id: 08
> <7>.......    : Delivery Type: 0
> <7>.......    : LTS          : 0
> <7>.... register #01: 000F0011
> <7>.......     : max redirection entries: 000F
> <7>.......     : PRQ implemented: 0
> <7>.......     : IO APIC version: 0011
> <7>.... register #02: 08000000
> <7>.......     : arbitration: 08
> <7>.... IRQ redirection table:
> <7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
> <7> 00 000 00  1    0    0   0   0    0    0    00
> <7> 01 0FF 0F  0    0    0   0   0    1    1    39
> <7> 02 040 00  0    0    0   0   0    1    1    31
> <7> 03 000 00  1    0    0   0   0    0    0    00
> <7> 04 0FF 0F  0    0    0   0   0    1    1    41
> <7> 05 000 00  1    0    0   0   0    0    0    00
> <7> 06 0FF 0F  0    0    0   0   0    1    1    49
> <7> 07 000 00  1    0    0   0   0    0    0    00
> <7> 08 0FF 0F  0    0    0   0   0    1    1    51
> <7> 09 0FF 0F  1    1    0   1   0    1    1    59
> <7> 0a 0FF 0F  1    1    0   1   0    1    1    61
> <7> 0b 000 00  1    0    0   0   0    0    0    00
> <7> 0c 0FF 0F  0    0    0   0   0    1    1    69
> <7> 0d 0FF 0F  1    1    0   1   0    1    1    71
> <7> 0e 0FF 0F  0    0    0   0   0    1    1    79
> <7> 0f 0FF 0F  0    0    0   0   0    1    1    81
> <4>
> <7>IO APIC #9......
> <7>.... register #00: 09000000
> <7>.......    : physical APIC id: 09
> <7>.......    : Delivery Type: 0
> <7>.......    : LTS          : 0
> <7>.... register #01: 000F0011
> <7>.......     : max redirection entries: 000F
> <7>.......     : PRQ implemented: 0
> <7>.......     : IO APIC version: 0011
> <7>.... register #02: 09000000
> <7>.......     : arbitration: 09
> <7>.... IRQ redirection table:
> <7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
> <7> 00 0FF 0F  1    1    0   1   0    1    1    89
> <7> 01 0FF 0F  1    1    0   1   0    1    1    91
> <7> 02 0FF 0F  1    1    0   1   0    1    1    99
> <7> 03 0FF 0F  1    1    0   1   0    1    1    A1
> <7> 04 0FF 0F  1    1    0   1   0    1    1    A9
> <7> 05 0FF 0F  1    1    0   1   0    1    1    B1
> <7> 06 0FF 0F  1    1    0   1   0    1    1    B9
> <7> 07 0FF 0F  1    1    0   1   0    1    1    C1
> <7> 08 0FF 0F  1    1    0   1   0    1    1    C9
> <7> 09 0FF 0F  1    1    0   1   0    1    1    D1
> <7> 0a 0FF 0F  1    1    0   1   0    1    1    D9
> <7> 0b 0FF 0F  1    1    0   1   0    1    1    E1
> <7> 0c 0FF 0F  1    1    0   1   0    1    1    E9
> <7> 0d 0FF 0F  1    1    0   1   0    1    1    32
> <7> 0e 0FF 0F  1    1    0   1   0    1    1    3A
> <7> 0f 0FF 0F  1    1    0   1   0    1    1    42
> <4>
> <7>IO APIC #10......
> <7>.... register #00: 0A000000
> <7>.......    : physical APIC id: 0A
> <7>.......    : Delivery Type: 0
> <7>.......    : LTS          : 0
> <7>.... register #01: 000F0011
> <7>.......     : max redirection entries: 000F
> <7>.......     : PRQ implemented: 0
> <7>.......     : IO APIC version: 0011
> <7>.... register #02: 0A000000
> <7>.......     : arbitration: 0A
> <7>.... IRQ redirection table:
> <7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
> <7> 00 0FF 0F  1    1    0   1   0    1    1    4A
> <7> 01 000 00  1    0    0   0   0    0    0    00
> <7> 02 000 00  1    0    0   0   0    0    0    00
> <7> 03 0FF 0F  1    1    0   1   0    1    1    52
> <7> 04 000 00  1    0    0   0   0    0    0    00
> <7> 05 0FF 0F  1    1    0   1   0    1    1    5A
> <7> 06 0FF 0F  1    1    0   1   0    1    1    62
> <7> 07 0FF 0F  1    1    0   1   0    1    1    6A
> <7> 08 0FF 0F  1    1    0   1   0    1    1    72
> <7> 09 0FF 0F  1    1    0   1   0    1    1    7A
> <7> 0a 0FF 0F  1    1    0   1   0    1    1    82
> <7> 0b 0FF 0F  1    1    0   1   0    1    1    8A
> <7> 0c 0FF 0F  1    1    0   1   0    1    1    92
> <7> 0d 0FF 0F  1    1    0   1   0    1    1    9A
> <7> 0e 0FF 0F  1    1    0   1   0    1    1    A2
> <7> 0f 0FF 0F  1    1    0   1   0    1    1    AA
> <7>IRQ to pin mappings:
> <7>IRQ0 -> 0:2
> <7>IRQ1 -> 0:1
> <7>IRQ4 -> 0:4
> <7>IRQ6 -> 0:6
> <7>IRQ8 -> 0:8
> <7>IRQ9 -> 0:9
> <7>IRQ10 -> 0:10
> <7>IRQ12 -> 0:12
> <7>IRQ13 -> 0:13
> <7>IRQ14 -> 0:14
> <7>IRQ15 -> 0:15
> <7>IRQ16 -> 1:0
> <7>IRQ17 -> 1:1
> <7>IRQ18 -> 1:2
> <7>IRQ19 -> 1:3
> <7>IRQ20 -> 1:4
> <7>IRQ21 -> 1:5
> <7>IRQ22 -> 1:6
> <7>IRQ23 -> 1:7
> <7>IRQ24 -> 1:8
> <7>IRQ25 -> 1:9
> <7>IRQ26 -> 1:10
> <7>IRQ27 -> 1:11
> <7>IRQ28 -> 1:12
> <7>IRQ29 -> 1:13
> <7>IRQ30 -> 1:14
> <7>IRQ31 -> 1:15
> <7>IRQ32 -> 2:0
> <7>IRQ35 -> 2:3
> <7>IRQ37 -> 2:5
> <7>IRQ38 -> 2:6
> <7>IRQ39 -> 2:7
> <7>IRQ40 -> 2:8
> <7>IRQ41 -> 2:9
> <7>IRQ42 -> 2:10
> <7>IRQ43 -> 2:11
> <7>IRQ44 -> 2:12
> <7>IRQ45 -> 2:13
> <7>IRQ46 -> 2:14
> <7>IRQ47 -> 2:15
> <6>.................................... done.
> <4>Using local APIC timer interrupts.
> <4>calibrating APIC timer ...
> <4>..... CPU clock speed is 1999.1451 MHz.
> <4>..... host bus clock speed is 99.9571 MHz.
> <4>cpu: 0, clocks: 999571, slice: 111063
> <4>CPU0<T0:999568,T1:888496,D:9,S:111063,C:999571>
> <4>cpu: 1, clocks: 999571, slice: 111063
> <4>cpu: 2, clocks: 999571, slice: 111063
> <4>cpu: 3, clocks: 999571, slice: 111063
> <4>cpu: 6, clocks: 999571, slice: 111063
> <4>cpu: 4, clocks: 999571, slice: 111063
> <4>cpu: 7, clocks: 999571, slice: 111063
> <4>cpu: 5, clocks: 999571, slice: 111063
> <4>CPU2<T0:999568,T1:666368,D:11,S:111063,C:999571>
> <4>CPU1<T0:999568,T1:777440,D:2,S:111063,C:999571>
> <4>CPU3<T0:999568,T1:555312,D:4,S:111063,C:999571>
> <4>CPU5<T0:999568,T1:333184,D:6,S:111063,C:999571>
> <4>CPU4<T0:999568,T1:444240,D:13,S:111063,C:999571>
> <4>CPU6<T0:999568,T1:222112,D:15,S:111063,C:999571>
> <4>CPU7<T0:999568,T1:111056,D:8,S:111063,C:999571>
> <4>migration_task 0 on cpu=0
> <4>migration_task 1 on cpu=1
> <4>migration_task 2 on cpu=2
> <4>migration_task 3 on cpu=3
> <4>migration_task 4 on cpu=4
> <4>migration_task 5 on cpu=5
> <4>migration_task 6 on cpu=6
> <4>migration_task 7 on cpu=7
> <6>PCI: PCI BIOS revision 2.10 entry at 0xf1135, last bus=22
> <6>PCI: Using configuration type 1
> <6>PCI: Probing PCI hardware
> <4>PCI: Probing PCI hardware (bus 00)
> <6>PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
> <6>PCI: Discovered primary peer bus 03 [IRQ]
> <6>PCI: Discovered primary peer bus 07 [IRQ]
> <6>PCI: Discovered primary peer bus 0b [IRQ]
> <6>PCI: Discovered primary peer bus 0f [IRQ]
> <6>PCI: Discovered primary peer bus 13 [IRQ]
> <6>PCI->APIC IRQ transform: (B0,I12,P0) -> 37
> <6>PCI->APIC IRQ transform: (B0,I13,P0) -> 41
> <6>PCI->APIC IRQ transform: (B0,I14,P0) -> 40
> <6>PCI->APIC IRQ transform: (B0,I15,P0) -> 10
> <6>PCI->APIC IRQ transform: (B0,I16,P0) -> 39
> <6>PCI->APIC IRQ transform: (B0,I16,P1) -> 32
> <6>PCI->APIC IRQ transform: (B0,I16,P2) -> 38
> <6>PCI->APIC IRQ transform: (B0,I30,P0) -> 35
> <6>PCI->APIC IRQ transform: (B3,I2,P0) -> 43
> <6>PCI->APIC IRQ transform: (B3,I30,P0) -> 35
> <6>PCI->APIC IRQ transform: (B7,I30,P0) -> 35
> <6>PCI->APIC IRQ transform: (B11,I30,P0) -> 35
> <6>PCI->APIC IRQ transform: (B15,I30,P0) -> 35
> <6>PCI->APIC IRQ transform: (B19,I30,P0) -> 35
> <4>PCI: Device 00:78 not found by BIOS
> <4>PCI: Device 00:7b not found by BIOS
> <4>PCI: Device 00:b8 not found by BIOS
> <4>PCI: Device 00:c0 not found by BIOS
> <4>PCI: Device 00:c2 not found by BIOS
> <4>PCI: Device 00:c4 not found by BIOS
> <4>PCI: Device 00:c6 not found by BIOS
> <4>PCI: Device 00:c8 not found by BIOS
> <4>PCI: Device 00:ca not found by BIOS
> <6>Linux NET4.0 for Linux 2.4
> <6>Based upon Swansea University Computer Society NET3.039
> <4>Initializing RT netlink socket
> <4>Starting kswapd
> <4>allocated 32 pages and 32 bhs reserved for the highmem bounces
> <6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> <4>pty: 256 Unix98 ptys configured
> <6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS 
> SHARE_IRQ SERIAL_PCI enabled
> <6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
> <6>Floppy drive(s): fd0 is 1.44M
> <6>FDC 0 is a National Semiconductor PC87306
> <6>loop: loaded (max 8 devices)
> <6>HP CISS Driver (v 2.4.44)
> <7>cciss: Device 0xb178 has been found at bus 0 dev 14 func 0
> <6>      blocks= 35553120 block_size= 512
> <6>      heads= 255, sectors= 32, cylinders= 4357 RAID 1(0+1)
> <4>
> <6>      blocks= 35553120 block_size= 512
> <6>      heads= 255, sectors= 32, cylinders= 4357 RAID 1(0+1)
> <4>
> <4>blk: queue c03a8b60, I/O limit 4294967295Mb (mask 
> 0xffffffffffffffff)
> <6>Partition check:
> <6> cciss/c0d0: p1 p2 p3 p4 < p5 p6 >
> <6> cciss/c0d1: p1
> [...]
> --------------------------------------------------------------------
> 
> The corresponding .config is:
> --------------------------------------------------------------------
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 
> #
> # Code maturity level options
> #
> # CONFIG_EXPERIMENTAL is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_HAS_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_F00F_WORKS_OK=y
> CONFIG_X86_MCE=y
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
> CONFIG_HIGHIO=y
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_X86_CLUSTERED_APIC=y
> # CONFIG_X86_NUMA is not set
> # CONFIG_X86_TSC_DISABLE is not set
> CONFIG_X86_TSC=y
> CONFIG_HAVE_DEC_LOCK=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_ISA is not set
> # CONFIG_SCx200 is not set
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
> # CONFIG_HOTPLUG_PCI is not set
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_IKCONFIG is not set
> # CONFIG_PM is not set
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> # CONFIG_APM_CPU_IDLE is not set
> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_RTC_IS_GMT is not set
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> 
> #
> # ACPI Support
> #
> # CONFIG_ACPI is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_CPQ_DA is not set
> CONFIG_BLK_CPQ_CISS_DA=y
> # CONFIG_CISS_SCSI_TAPE is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_NBD=m
> CONFIG_BLK_DEV_RAM=m
> CONFIG_BLK_DEV_RAM_SIZE=4096
> # CONFIG_BLK_STATS is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> # CONFIG_NETLINK_DEV is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_VLAN_8021Q is not set
> 
> #
> #  
> #
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> 
> #
> # Appletalk devices
> #
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_CMD640=y
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_BLK_DEV_GENERIC is not set
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_BLK_DEV_ADMA100 is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> CONFIG_BLK_DEV_RZ1000=y
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_SVWKS=y
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_CHR_DEV_ST=m
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=m
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_MEGARAID2 is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_BOOT is not set
> # CONFIG_FUSION_ISENSE is not set
> # CONFIG_FUSION_CTL is not set
> # CONFIG_FUSION_LAN is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=m
> CONFIG_BONDING=m
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> # CONFIG_NET_ETHERNET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> CONFIG_TIGON3=y
> # CONFIG_FDDI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Input core support
> #
> # CONFIG_INPUT is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> # CONFIG_SERIAL_CONSOLE is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> # CONFIG_HVC_CONSOLE is not set
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> # CONFIG_82C710_MOUSE is not set
> # CONFIG_PC110_PAD is not set
> # CONFIG_MK712_MOUSE is not set
> 
> #
> # Joysticks
> #
> # CONFIG_INPUT_GAMEPORT is not set
> 
> #
> # Input core support is needed for gameports
> #
> 
> #
> # Input core support is needed for joysticks
> #
> # CONFIG_QIC02_TAPE is not set
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_AMD_RNG is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_AMD_PM768 is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=y
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> CONFIG_EXT3_FS=m
> CONFIG_JBD=m
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=m
> # CONFIG_CRAMFS is not set
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> CONFIG_ISO9660_FS=y
> # CONFIG_JOLIET is not set
> # CONFIG_ZISOFS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_UDF_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_XFS_FS is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_ZISOFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VIDEO_SELECT is not set
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # Bluetooth support
> #
> # CONFIG_BLUEZ is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_PANIC_MORSE is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> 
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> # CONFIG_ZLIB_INFLATE is not set
> # CONFIG_ZLIB_DEFLATE is not set
> --------------------------------------------------------------------
> -- 
> Linux Solution Consultant         Tél: +33 476 143 278 - Fax: 
> +33 476 146 105
> HP/Intel Solution Center http://hpintelco.net Hewlett-Packard 
> Grenoble/France
> Des infos sur Linux?  http://www.HyPer-Linux.org      
http://www.hp.com/linux
La musique ancienne?  http://www.musique-ancienne.org http://www.medieval.org
