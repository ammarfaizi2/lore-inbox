Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUFJVUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUFJVUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUFJVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:20:15 -0400
Received: from mailadmin.WKU.EDU ([161.6.18.52]:36019 "EHLO mailadmin.wku.edu")
	by vger.kernel.org with ESMTP id S263079AbUFJVTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:19:38 -0400
From: "Bikram Assal" <bikram.assal@wku.edu>
Subject: 
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Thu, 10 Jun 2004 16:19:38 -0500
Message-ID: <web-68586171@mailadmin.wku.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem.
Few days back I got this error on one of my servers.
This message was on the screen. The server didn't hang or anything. But i fear that the server might be running out of memory.
It is a DELL PowerEdge 6400 with 8GB of memory.

I got this error in /var/log/messages only one time.
the error is : ENOMEM in do_get_write_access, retrying.

Please help me find out the cause of it.

And ya one more thing, the total memory on the system is 8GB but it always shows the free memory as between 10 MB and 50 MB. I m running Oracle8i on this server.

Somewhere I had read that the total free memory available to the server is free + cached + buffer
The following is the reference link where I read it:
http://marc.theaimsgroup.com/?l=redhat-list&m=106703084117181&w=2

How true is that and am I running out of memory ?

A part of top output looks like this:

Mem: 7745436K av, 7719332K used, 26104K free, 0K shrd, 170784K buff
Swap: 2097136K av, 0K used, 2097136K free 7187696K cache


The following is the output from dmesg:

4>hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 2097152
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 1867776 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL Product ID: POWEREDGE 9C APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
Processor #2 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Processors: 4
Kernel command line: ro root=/dev/sda3
Initializing CPU#0
Detected 899.142 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 7745112k/8388608k available (1514k kernel code, 118816k reserved, 985k data, 260k init, 6946808k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer cache hash table entries: 524288 (order: 9, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Cascades) stepping 04
per-CPU timeslice cutoff: 5851.89 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1795.68 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Cascades) stepping 04
Booting processor 2/1 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1795.68 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#2.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU2: Intel Pentium III (Cascades) stepping 04
Booting processor 3/2 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1795.68 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#3.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU3: Intel Pentium III (Cascades) stepping 04
Total of 4 processors activated (7182.74 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-2, 4-10, 4-11, 4-13, 5-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 48.
number of IO-APIC #4 registers: 16.
testing the IO APIC.......................
                                                                                                                                                                                    
IO APIC #4......
.... register #00: 04000000
....... : physical APIC id: 04
.... register #01: 000F0011
....... : max redirection entries: 000F
....... : PRQ implemented: 0
....... : IO APIC version: 0011
.... register #02: 00000000
....... : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F 0 0 0 0 0 1 1 31
 01 00F 0F 0 0 0 0 0 1 1 39
 02 000 00 1 0 0 0 0 0 0 00
 03 00F 0F 0 0 0 0 0 1 1 41
 04 00F 0F 0 0 0 0 0 1 1 49
 05 00F 0F 1 1 0 1 0 1 1 51
 06 00F 0F 0 0 0 0 0 1 1 59
 07 00F 0F 0 0 0 0 0 1 1 61
 08 00F 0F 0 0 0 0 0 1 1 69
 09 00F 0F 0 0 0 0 0 1 1 71
 0a 000 00 1 0 0 0 0 0 0 00
 0b 000 00 1 0 0 0 0 0 0 00
 0c 00F 0F 0 0 0 0 0 1 1 79
 0d 000 00 1 0 0 0 0 0 0 00
 0e 00F 0F 0 0 0 0 0 1 1 81
 0f 00F 0F 0 0 0 0 0 1 1 89
                                                                                                                                                                                    
IO APIC #5......
.... register #00: 05000000
....... : physical APIC id: 05
.... register #01: 000F0011
....... : max redirection entries: 000F
....... : PRQ implemented: 0
....... : IO APIC version: 0011
.... register #02: 0F000000
....... : arbitration: 0F
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F 1 1 0 1 0 1 1 91
 01 00F 0F 1 1 0 1 0 1 1 99
 02 00F 0F 1 1 0 1 0 1 1 A1
 03 00F 0F 1 1 0 1 0 1 1 A9
 04 00F 0F 1 1 0 1 0 1 1 B1
 05 00F 0F 1 1 0 1 0 1 1 B9
 06 00F 0F 1 1 0 1 0 1 1 C1
 07 00F 0F 1 1 0 1 0 1 1 C9
 08 00F 0F 1 1 0 1 0 1 1 D1
 09 00F 0F 1 1 0 1 0 1 1 D9
 0a 00F 0F 1 1 0 1 0 1 1 E1
 0b 00F 0F 1 1 0 1 0 1 1 E9
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 1:10
IRQ27 -> 1:11
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 899.0812 MHz.
..... host bus clock speed is 99.8977 MHz.
cpu: 0, clocks: 998977, slice: 199795
CPU0<T0:998976,T1:799168,D:13,S:199795,C:998977>
cpu: 1, clocks: 998977, slice: 199795
cpu: 2, clocks: 998977, slice: 199795
cpu: 3, clocks: 998977, slice: 199795
CPU2<T0:998976,T1:399584,D:7,S:199795,C:998977>
CPU3<T0:998976,T1:199792,D:4,S:199795,C:998977>
CPU1<T0:998976,T1:599376,D:10,S:199795,C:998977>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
migration_task 2 on cpu=2
migration_task 3 on cpu=3
PCI: PCI BIOS revision 2.10 entry at 0xfc7ee, last bus=15
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 03 [IRQ]
Unknown bridge resource 0: assuming transparent
PCI: Discovered primary peer bus 0d [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B0,I5,P0) -> 17
PCI->APIC IRQ transform: (B0,I5,P1) -> 18
PCI->APIC IRQ transform: (B0,I8,P0) -> 26
PCI->APIC IRQ transform: (B4,I4,P0) -> 22
PCI->APIC IRQ transform: (B4,I5,P0) -> 26
PCI->APIC IRQ transform: (B14,I1,P0) -> 29
PCI->APIC IRQ transform: (B15,I0,P0) -> 19
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 256 pages and 256 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller on PCI bus 00 dev 79
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG CD-ROM SC-148C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:06:5B:88:3D:CA, IRQ 26.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 00009c-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eth1: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:A4:77:8F, IRQ 22.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly a67265-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth2: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:A4:77:90, IRQ 26.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly a67265-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
                                                                                                                                                                                    
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
                                                                                                                                                                                    
megaraid: v1.18a (Release Date: Mon Mar 11 11:38:38 EST 2002)
megaraid: found 0x101e:0x1960:idx 0:bus 15:slot 0:func 0
scsi2 : Found a MegaRAID controller at 0xf8817000, IRQ: 19
scsi2 : Enabling 64 bit support
megaraid: [1.92:3.31] detected 1 logical drives
megaraid: supports extended CDBs.
megaraid: channel[1] is raid.
megaraid: channel[2] is raid.
scsi2 : LSI Logic MegaRAID 1.92 254 commands 15 targs 5 chans 7 luns
blk: queue c817dc18, I/O limit 4095Mb (mask 0xffffffff)
scsi2: scanning virtual channel 0 for logical drives.
  Vendor: MegaRAID Model: LD 0 RAID5 86G Rev: 1.92
  Type: Direct-Access ANSI SCSI revision: 02
blk: queue c8139c18, I/O limit 4095Mb (mask 0xffffffff)
scsi2: scanning virtual channel 1 for logical drives.
scsi2: scanning virtual channel 2 for logical drives.
scsi2: scanning physical channel 0 for devices.
  Vendor: DELL Model: 1x8 U2W SCSI BP Rev: 5.51
  Type: Processor ANSI SCSI revision: 02
blk: queue f7405618, I/O limit 4095Mb (mask 0xffffffff)
scsi2: scanning physical channel 1 for devices.
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sda: 176926720 512-byte hdwr sectors (90586 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
Attached scsi generic sg1 at scsi2, channel 4, id 6, lun 0, type 3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 65536 buckets, 512Kbytes
TCP: Hash tables configured (established 262144 bind 65536
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (8192 buckets, 65536 max)
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 60k freed
VFS: Mounted root (ext2 filesystem).
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting. Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 260k freed
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,3), internal journal
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ENOMEM in do_get_write_access, retrying.




- Bikram 
OCA ( Oracle Certified Associate )
Database Specialist, WKU
http://www.wku.edu/~bikram.assal/
