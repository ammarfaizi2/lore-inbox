Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268501AbTBWP07>; Sun, 23 Feb 2003 10:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbTBWP07>; Sun, 23 Feb 2003 10:26:59 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60638 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268501AbTBWP0U>; Sun, 23 Feb 2003 10:26:20 -0500
Date: Sun, 23 Feb 2003 07:36:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 392] New: unexpected IO-APIC, please file a report at... 
Message-ID: <6680000.1046014563@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=392

           Summary: unexpected IO-APIC, please file a report at...
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: rol@as2917.net
                CC: rol@as2917.net


Distribution: RedHat 8.0
Hardware Environment: P-IV 2.4GHz, with ht flag, though not supported by MB
Asus P4S8X MB
512 MB RAM

Software Environment:

Problem Description:
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
INFO: unexpected IO-APIC, please file a report at
      http://bugzilla.kernel.org
      if your kernel is less than 3 months old.
.... register #02: 02000000
.......     : arbitration: 02

Steps to reproduce:
Just boot and look at messages...

Complete dmesg bellow :

CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.72 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
INFO: unexpected IO-APIC, please file a report at
      http://bugzilla.kernel.org
      if your kernel is less than 3 months old.
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   1   0    1    1    71
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2423.0432 MHz.
..... host bus clock speed is 134.0635 MHz.
Starting migration thread for cpu 0
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf11a0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
    ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 
9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 
9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 
9)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 
9)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 
9)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.94 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:02[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:02[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:02[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20)
00:00:03[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21)
00:00:03[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22)
00:00:03[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23)
00:00:03[D] -> 2-23 -> IRQ 23
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or 
even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting balanced_irq
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
Capability LSM initialized
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD DESKJET 920C
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported SiS chipset (device id: 0648), you might want to try 
agp_try_unsupported=1.
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905 Boomerang 100baseTx at 0x7400. Vers LK1.1.19
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS648    ATA 133 controller
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdb: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
hdd: TDK CDRW4800B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 > hda4
hdb: host protected area => 1
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 >
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
end_request: I/O error, dev hdd, sector 0
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAN3367MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
APIC error on CPU0: 00(40)
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ehci-hcd 00:03.3: Silicon Integrated S SiS7002 USB 2.0
ehci-hcd 00:03.3: irq 23, pci mem e081e000
ehci-hcd 00:03.3: new USB bus registered, assigned bus number 1
PCI: 00:03.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW, 
correcting to 128
ehci-hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ohci-hcd 00:03.0: Silicon Integrated S 7001
ohci-hcd 00:03.0: irq 20, pci mem e0820000
ohci-hcd 00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
ohci-hcd 00:03.1: Silicon Integrated S 7001 (#2)
ohci-hcd 00:03.1: irq 21, pci mem e0822000
ohci-hcd 00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
ohci-hcd 00:03.2: Silicon Integrated S 7001 (#3)
ohci-hcd 00:03.2: irq 22, pci mem e0824000
ohci-hcd 00:03.2: new USB bus registered, assigned bus number 4
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.10:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 
2003 UTC).
ALSA device list:
  #0: Sound Blaster Live! (rev.7) at 0x8000, irq 17
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 384k freed
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 4-0:0: new USB device on port 1, assigned address 2
Adding 2096440k swap on /dev/hda6.  Priority:-1 extents:1
Adding 530104k swap on /dev/hdb1.  Priority:-2 extents:1
Adding 1049576k swap on /dev/sda5.  Priority:-3 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
APIC error on CPU0: 40(40)
Reiserfs journal params: device sd(8,6), size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sd(8,6)) for (sd(8,6))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,70), size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,70)) for (ide0(3,70))
Using r5 hash to sort names
NTFS-fs warning (device ide0(3,1)): parse_options(): Option utf8 is no longer 
supported, using option nls=utf8. Please use option nls=utf8 in the future and 
make sure utf8 is compiled either as a module or into the kernel.
NTFS volume version 3.0.
NTFS-fs warning (device ide0(3,5)): parse_options(): Option utf8 is no longer 
supported, using option nls=utf8. Please use option nls=utf8 in the future and 
make sure utf8 is compiled either as a module or into the kernel.
NTFS volume version 3.0.
eth0: no IPv6 routers present
blk: queue c061181c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0611b10, I/O limit 4095Mb (mask 0xffffffff)
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
tap0: no IPv6 routers present


