Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267088AbRGXIZV>; Tue, 24 Jul 2001 04:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbRGXIZC>; Tue, 24 Jul 2001 04:25:02 -0400
Received: from [202.190.167.54] ([202.190.167.54]:28168 "HELO
	corpemail.asiaonline.net.my") by vger.kernel.org with SMTP
	id <S267088AbRGXIY7>; Tue, 24 Jul 2001 04:24:59 -0400
Message-ID: <20010724083909.12454.qmail@corpemail.asiaonline.net.my>
From: Toni Mattila <tontsa@asiaonline.net.my>
To: linux-kernel@vger.kernel.org
Subject: I2O, v2.2.19, Intel 3U-1L, mounting root
Date: Tue, 24 Jul 2001 16:39:09
X-Sender-IP: 202.185.158.242
X-User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
Organization: Asia Online Utusan Sdn. Bhd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

The server is Intel ISP 2150G, 2U casing. The card is Intel 
Integrated Raid U3-1L. Kernel is 2.2.19 vanilla. Compiled with 
Mandrake 8.0's kgcc(egcs-2.91.66/egcs-1.1.2 release).

I've got everything happily installed to the RAID array from a IDE
harddisk. I had I2O subsystem installed as modules, i2o_pci, i2o_core,
i2o_block and i2o_config.

Now I compiled a kernel which has the I2O PCI/core and block as builtin. I 
installed lilo with the Intel provided lilo-i2o-hack. 

Please CC me, I'm not subscribed to the list.

The /boot is i2o/hda1, / is i2o/hda8

But when the kernel is booting I get:
Partition check:
 i2o/hda: i2o/hda1 i2o/hda2 < i2o/hda5 i2o/hda6 i2o/hda7 i2o/hda8 i2o/hda9 i2o/hda10 i2o/hda11 >
i2o_block: Checking for I2O Block devices...
 i2o/hda:<3>
/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
i2ob: attempting retry 2 for request c0205fa8

/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
i2ob: attempting retry 3 for request c0205fa8

/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
i2ob: attempting retry 4 for request c0205fa8

/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
end_request: I/O error, dev 50:00 (i2o block), sector 0

The complete boot message:
Linux version 2.2.19t3 (root@awfawef.com.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release / Linux-Mandrake 8.0)) #5 SMP Tue Jul 24 15:38:53 MYT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009c000 @ 00000000 (usable)
 BIOS-e820: 1fef0000 @ 00100000 (usable)
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 796562 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 517448k/524224k available (836k kernel code, 432k reserved, 5452k data, 56k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU serial number disabled.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
per-CPU timeslice cutoff: 49.97 usecs.
CPU1: Intel Pentium III (Coppermine) stepping 03
calibrating APIC timer ... 
..... CPU clock speed is 796.5462 MHz.
..... system bus clock speed is 99.5681 MHz.
Booting processor 0 eip 2000
Calibrating delay loop... 1592.52 BogoMIPS
CPU serial number disabled.
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
OK.
CPU0: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3181.77 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-16, 2-17, 2-18, 2-22, 2-23 not connected.
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  0    0    0   0   0    1    1    71
 07 000 00  0    0    0   0   0    1    1    79
 08 000 00  0    0    0   0   0    1    1    81
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    91
 0f 000 00  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 0FF 0F  1    1    0   1   0    1    1    A1
 14 0FF 0F  1    1    0   1   0    1    1    A9
 15 0FF 0F  1    1    0   1   0    1    1    B1
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
.................................... done.
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfdab0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
PCI->APIC IRQ transform: (B2,I4,P0) -> 20
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5 
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2860-0x2867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2868-0x286f, BIOS settings: hdc:DMA, hdd:pio
hdc: SAMSUNG CD-ROM SN-124, ATAPI CDROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Loading I2O Core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 2 at 33.
i2o: PCI I2O controller at 0xFC000000 size=8388608
I2O: MTRR workaround for Intel i960 processor
i2o/iop0: Installed at IRQ20
i2o: 1 I2O controller found and installed.
Activating I2O controllers
This may take a few minutes if there are many devices
i2o/iop0: LCT has 11 entries.
Target ID 0.
     Vendor: Wind River Sys.<6>     Device: IxWorks<6>  Rev: 0201    
    Class: <6>Executive            
  Subclass: 0x0001
     Flags: PM
Target ID 8.
     Vendor: Intel           <6>     Device: Integrated RAID <6>  Rev: 2.03.6  
    Class: <6>Device Driver Module 
  Subclass: 0x0021
     Flags: PM
Target ID 9.
     Vendor: Symbios Logic<6>     Device: SYM SCSI/BS HDM<6>  Rev: 1.03.46
    Class: <6>Device Driver Module 
  Subclass: 0x0020
     Flags: PM
Target ID 10.
     Vendor: ESG-SHV         <6>     Device: SCA HSBP M10    <6>  Rev: 0.06    
    Class: <6>SCSI Device          
  Subclass: 0x0003
     Flags: PM
Target ID 11.
i2o_core: post_wait reply: UTIL_PARAMS_GET, <6>ERROR_PARTIAL_TRANSFER / <6>UNKNOWN_ERROR.
i2o_core: post_wait reply: UTIL_PARAMS_GET, <6>ERROR_PARTIAL_TRANSFER / <6>UNKNOWN_ERROR.
i2o_core: post_wait reply: UTIL_PARAMS_GET, <6>ERROR_PARTIAL_TRANSFER / <6>UNKNOWN_ERROR.
    Class: <6>Secondary Bus Port   
  Subclass: 0x0001
     Flags: PM
Target ID 13.
     Vendor: Symbios Logic   <6>     Device: Sym53C1010-66   <6>  Rev: 0x00
    Class: <6>Secondary Bus Port   
  Subclass: 0x0001
     Flags: PM
Target ID 14.
     Vendor: SEAGATE         <6>     Device: ST336705LC      <6>  Rev: 5063    
    Class: <6>SCSI Device          
  Subclass: 0x0000
     Flags: PM
Target ID 15.
     Vendor: SEAGATE         <6>     Device: ST336705LC      <6>  Rev: 5063    
    Class: <6>Block Device         
  Subclass: 0x0000
     Flags: PM
Target ID 16.
     Vendor: SEAGATE         <6>     Device: ST336705LC      <6>  Rev: 5063    
    Class: <6>SCSI Device          
  Subclass: 0x0000
     Flags: PM
Target ID 18.
     Vendor: Intel           <6>     Device: Raid 1 Volume   <6>  Rev: 2.03.6  
    Class: <6>Block Device         
  Subclass: 0x0000
     Flags: PM
Target ID 19.
     Vendor: SEAGATE         <6>     Device: ST336705LC      <6>  Rev: 5063    
    Class: <6>Block Device         
  Subclass: 0x0000
     Flags: PM
event thread created as pid 7 
I2O configuration manager v 0.04
(C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9. (C) 1999 Red Hat Software.
i2o_block: Checking for Boot device...
Claiming as Boot device: Controller 0, TID 18
i2o/iop0: Unknown event...check config
i2ob: Installing tid 18 device at unit 0
Max Segments set to 12
Byte limit is 6144.
i2o_core: post_wait reply: UTIL_PARAMS_GET, <6>ERROR_PARTIAL_TRANSFER / <6>UNKNOWN_ERROR.
i2o/hda: Type 223- 34999Mb, 512 byte sectors.
i2o/hda: Maximum sectors/read set to 128.
Partition check:
 i2o/hda: i2o/hda1 i2o/hda2 < i2o/hda5 i2o/hda6 i2o/hda7 i2o/hda8 i2o/hda9 i2o/hda10 i2o/hda11 >
i2o_block: Checking for I2O Block devices...
 i2o/hda:<3>
/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
i2ob: attempting retry 2 for request c0205fa8

/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
i2ob: attempting retry 3 for request c0205fa8

/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
i2ob: attempting retry 4 for request c0205fa8

/dev/i2o/hda error: Device is locked by another user - DDM attempted 1 retries
end_request: I/O error, dev 50:00 (i2o block), sector 0
 unable to read partition table
 i2o/hdb:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:10 (i2o block), sector 0
 unable to read partition table
 i2o/hdc:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:20 (i2o block), sector 0
 unable to read partition table
 i2o/hdd:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:30 (i2o block), sector 0
 unable to read partition table
 i2o/hde:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:40 (i2o block), sector 0
 unable to read partition table
 i2o/hdf:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:50 (i2o block), sector 0
 unable to read partition table
 i2o/hdg:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:60 (i2o block), sector 0
 unable to read partition table
 i2o/hdh:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:70 (i2o block), sector 0
 unable to read partition table
 i2o/hdi:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:80 (i2o block), sector 0
 unable to read partition table
 i2o/hdj:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:90 (i2o block), sector 0
 unable to read partition table
 i2o/hdk:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:a0 (i2o block), sector 0
 unable to read partition table
 i2o/hdl:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:b0 (i2o block), sector 0
 unable to read partition table
 i2o/hdm:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:c0 (i2o block), sector 0
 unable to read partition table
 i2o/hdn:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:d0 (i2o block), sector 0
 unable to read partition table
 i2o/hdo:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:e0 (i2o block), sector 0
 unable to read partition table
 i2o/hdp:I2O: ERROR I/O Request to a non existent device !
end_request: I/O error, dev 50:f0 (i2o block), sector 0
 unable to read partition table
attempt to access beyond end of device
50:08: rw=0, want=2, limit=0
dev 50:08 blksize=1024 blocknr=1 sector=2 size=1024 count=1
EXT2-fs: unable to read superblock
Kernel panic: VFS: Unable to mount root fs on 50:08

Thanks in advance,
Toni Mattila

