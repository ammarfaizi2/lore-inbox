Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSG3MQF>; Tue, 30 Jul 2002 08:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318245AbSG3MQF>; Tue, 30 Jul 2002 08:16:05 -0400
Received: from [213.69.213.4] ([213.69.213.4]:9371 "EHLO i-t-c-s.de")
	by vger.kernel.org with ESMTP id <S318242AbSG3MQB> convert rfc822-to-8bit;
	Tue, 30 Jul 2002 08:16:01 -0400
X-AuthUser: tmi@wikon.de
Content-Type: text/plain;
  charset="us-ascii"
From: Thomas Mierau <tmi@wikon.de>
Organization: WIKON Kommunikationstechnik GmbH
To: linux-kernel@vger.kernel.org
Subject: Tyan K7X with AMD MP 2.4.19-rc3-ac4
Date: Tue, 30 Jul 2002 14:21:18 +0200
X-Mailer: KMail [version 1.4]
Cc: thomas@mierau.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207301421.18701.tmi@wikon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am trying to get the above board to work. Somehow it doesn't.
I tried kernel  2.4.18, 2.4.19-rc3, 2.4.19-rc3-ac3 and of course the latest 
2.4.19-rc3-ac4

The machine itself is "working" stable under 2.4.18 with a limited 
functionality (no network, no additional scsi ports, no printer, no usb ...)

The problem is always the same. The eth1 is not working properly and the IRQ's 
are not setup correctly. The I/O-APIC reports ok.

I disabled all the I/O that I don't need. otherwise I will have the raid, 
another scsi and the eth0 on IRQ11

The unknown bridges are all identified correctly by vendor and device. But 
somehow I have the feelng that the conversion for the AMD768 PIC is not 
working correctly.

I hope anybody has an idea
(by the way forget the noapic, doesn't change anything)

Here is my dmesg

Inspecting /boot/System.map-2.4.19-rc3-ac4
Loaded 16636 symbols from /boot/System.map-2.4.19-rc3-ac4.
Symbols match kernel version 2.4.19.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.19-rc3-ac4 (root@jaegermeister) (gcc version 2.95.3 
20010315 (SuSE)) #2 SMP Tue Jul 30 12:03:13 CEST 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
<4> BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 00000000e3ef0000 (usable)
<4> BIOS-e820: 00000000e3ef0000 - 00000000e3ef6000 (ACPI data)
<4> BIOS-e820: 00000000e3ef6000 - 00000000e3f00000 (ACPI NVS)
<4> BIOS-e820: 00000000e3f00000 - 00000000e3f80000 (usable)
<4> BIOS-e820: 00000000e3f80000 - 00000000e4000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>2751MB HIGHMEM available.
<5>896MB LOWMEM available.
<4>found SMP MP-table at 000f7180
<4>hm, page 000f7000 reserved twice.
<4>hm, page 000f8000 reserved twice.
<4>hm, page 0009f000 reserved twice.
<4>hm, page 000a0000 reserved twice.
<4>On node 0 totalpages: 933760
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 704384 pages.
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode.
<4>OEM ID: TYAN     Product ID: PAULANER     APIC at: 0xFEE00000
<4>Processor #1 Pentium(tm) Pro APIC version 16
<4>Processor #0 Pentium(tm) Pro APIC version 16
<4>I/O APIC #2 Version 17 at 0xFEC00000.
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<4>Processors: 2
<4>Kernel command line: auto BOOT_IMAGE=l-2.4.19-rc3 ro root=803
<6>Initializing CPU#0
<4>Detected 1666.742 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3329.22 BogoMIPS
<6>Memory: 3680476k/3735040k available (1472k kernel code, 54108k reserved, 
459k data, 248k init, 2817472k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Mount cache hash table entries: 65536 (order: 7, 524288 bytes)
<7>ramfs: mounted with options: <defaults>
<7>ramfs: max_pages=460059 max_file_pages=0 max_inodes=0 max_dentries=460059
<6>Buffer cache hash table entries: 262144 (order: 8, 1048576 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<7>CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<7>CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<7>CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<7>CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
<4>CPU0: AMD Athlon(tm) MP 2000+ stepping 02
<4>per-CPU timeslice cutoff: 731.44 usecs.
<4>task migration cache decay timeout: 10 msecs.
<4>masked ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/2 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3329.22 BogoMIPS
<7>CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<7>CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
<4>CPU1: AMD Athlon(tm) Processor stepping 02
<6>Total of 2 processors activated (6658.45 BogoMIPS).
<4>ENABLING IO-APIC IRQs
<4>Setting 2 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 2 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-22, 2-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 22.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.... register #01: 00170011
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 003 03  0    0    0   0   0    1    1    39
<7> 02 001 01  0    0    0   0   0    1    1    31
<7> 03 003 03  0    0    0   0   0    1    1    41
<7> 04 003 03  0    0    0   0   0    1    1    49
<7> 05 003 03  1    1    0   1   0    1    1    51
<7> 06 003 03  0    0    0   0   0    1    1    59
<7> 07 003 03  0    0    0   0   0    1    1    61
<7> 08 003 03  0    0    0   0   0    1    1    69
<7> 09 003 03  0    0    0   0   0    1    1    71
<7> 0a 003 03  1    1    0   1   0    1    1    79
<7> 0b 003 03  1    1    0   1   0    1    1    81
<7> 0c 003 03  0    0    0   0   0    1    1    89
<7> 0d 003 03  0    0    0   0   0    1    1    91
<7> 0e 003 03  0    0    0   0   0    1    1    99
<7> 0f 003 03  0    0    0   0   0    1    1    A1
<7> 10 003 03  0    0    0   0   0    1    1    A9
<7> 11 003 03  0    0    0   0   0    1    1    B1
<7> 12 003 03  0    0    0   0   0    1    1    B9
<7> 13 003 03  0    0    0   0   0    1    1    C1
<7> 14 003 03  0    0    0   0   0    1    1    C9
<7> 15 003 03  1    1    0   1   0    1    1    D1
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ21 -> 0:21
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1666.7429 MHz.
<4>..... host bus clock speed is 266.6787 MHz.
<4>cpu: 0, clocks: 2666787, slice: 888929
<4>CPU0<T0:2666784,T1:1777840,D:15,S:888929,C:2666787>
<4>cpu: 1, clocks: 2666787, slice: 888929
<4>CPU1<T0:2666784,T1:888912,D:14,S:888929,C:2666787>
<4>checking TSC synchronization across CPUs: passed.
<4>migration_task 0 on cpu=0
<4>migration_task 1 on cpu=1
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=3
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<3>Unknown bridge resource 0: assuming transparent
<3>Unknown bridge resource 1: assuming transparent
<3>Unknown bridge resource 2: assuming transparent
<3>Unknown bridge resource 0: assuming transparent
<3>Unknown bridge resource 1: assuming transparent
<3>Unknown bridge resource 2: assuming transparent
<3>Unknown bridge resource 2: assuming transparent
<6>PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
<4>BIOS failed to enable PCI standards compliance, fixing this error.
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00f7140
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9ab5, dseg 0x400
<6>PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<4> tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
<4>Parsing 
Methods:................................................................................
<4>80 Control Methods found and parsed (294 nodes total)
<4>ACPI Namespace successfully loaded at root c03811a0
<6>ACPI: Core Subsystem version [20011018]
<4>evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode 
successful
<4>Executing device _INI methods:............................
<4>28 Devices found: 28 _STA, 1 _INI
<4>Completing Region and Field initialization:....................
<4>20/25 Regions, 0/0 Fields initialized (294 nodes total)
<6>ACPI: Subsystem enabled
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>Real Time Clock Driver v1.10e
<6>Non-volatile memory driver v1.1
<6>amd768_rng: AMD768 system management I/O registers at 0x8000.
<6>amd768_rng hardware driver 0.1.0 loaded
<6>amd-smp-idle: AMD processor idle module version 20020702
<6>amd-smp-idle: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 
MP [IGD4-2P] System Controller
<6>amd-smp-idle: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 
[Opus] ACPI
<6>amd-smp-idle: AMD-768 southbridge initialized.
<6>amd-smp-idle: AMD-762 northbridge initialized.
<4>block: 1024 slots per queue, batch=256
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 816M
<6>agpgart: Detected AMD 760MP chipset
<6>agpgart: AGP aperture is 64M @ 0xf8000000
<6>SCSI subsystem driver Revision: 1.00
<6>Loading Adaptec I2O RAID: Version 2.4 Build 5
<6>Detecting Adaptec I2O RAID controllers...
<6>Adaptec I2O RAID controller 0 at f8832000 size=100000 irq=11
<6>dpti: If you have a lot of devices this could take a few minutes.
<6>dpti0: Reading the hardware resource table.
<6>TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001    
<6>TID 519  Vendor: ADAPTEC      Device: RAID-5       Rev: 380E        
<6>scsi0 : Vendor: Adaptec  Model: 2110S            FW:380E
<4>  Vendor: ADAPTEC   Model: RAID-5            Rev: 380E
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>SCSI device sda: 143372288 512-byte hdwr sectors (73407 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3
<6>I2O Core - (C) Copyright 1999 Red Hat Software
<6>I2O: Event thread created as pid 11
<6>Linux I2O PCI support (c) 1999 Red Hat Software.
<6>i2o: Checking for PCI I2O controllers...
<6>i2o: Skipping Adaptec/DPT I2O raid with preferred native driver.
<6>I2O configuration manager v 0.04.
<6>  (C) Copyright 1999 Red Hat Software
<6>I2O Block Storage OSM v0.9
<6>   (c) Copyright 1999-2001 Red Hat Software.
<6>i2o_block: Checking for Boot device...
<6>i2o_block: Checking for I2O Block devices...
<4>i2o_scsi.c: Version 0.0.1
<4>  chain_pool: 0 bytes @ c421546c
<4>  (512 byte buffers X 4 can_queue X 0 i2o controllers)
<6>md: raid5 personality registered as nr 4
<6>raid5: measuring checksumming speed
<4>   8regs     :  2249.600 MB/sec
<4>   32regs    :  2113.600 MB/sec
<4>   pIII_sse  :  4524.000 MB/sec
<4>   pII_mmx   :  3894.800 MB/sec
<4>   p5_mmx    :  5002.000 MB/sec
<4>raid5: using function: pIII_sse (4524.000 MB/sec)
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 16384 buckets, 256Kbytes
<6>TCP: Hash tables configured (established 131072 bind 43690)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>reiserfs: checking transaction log (device 08:03) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 248k freed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>Adding Swap: 1052248k swap-space (priority 42)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.


and also my /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 17).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xf6200000 [0xf6200fff].
      I/O at 0x1010 [0x1013].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(rev 0).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
      Master Capable.  Latency=64.  
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=64.  
  Bus  0, device   9, function  0:
    I2O: Distributed Processing Technology SmartRAID V Controller (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=1.
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].
  Bus  0, device   9, function  1:
    PCI bridge: Distributed Processing Technology PCI Bridge (rev 1).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  3, device   7, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      Master Capable.  Latency=66.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xf5000000 [0xf5ffffff].
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xf4001000 [0xf4001fff].
  Bus  3, device   8, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] 
(rev 120).
      IRQ 11.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x2400 [0x247f].
      Non-prefetchable 32 bit memory at 0xf4002000 [0xf400207f].
  Bus  3, device   9, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] 
(#2) (rev 120).
      IRQ 5.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x2480 [0x24ff].
      Non-prefetchable 32 bit memory at 0xf4002400 [0xf400247f].

