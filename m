Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbTBWT0h>; Sun, 23 Feb 2003 14:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269160AbTBWT0g>; Sun, 23 Feb 2003 14:26:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58777 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269158AbTBWT00>; Sun, 23 Feb 2003 14:26:26 -0500
Date: Sun, 23 Feb 2003 11:36:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 394] unexpected IO-APIC
Message-ID: <7010000.1046028985@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=394

           Summary: unexpected IO-APIC, please file a report at...
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: henning@skalatan.de


Distribution: Gentoo Linux 1.4 
Hardware Environment: Amd K7 1900+ XP, Epox 8K5A2 Board 
 
Problem Description:  
unexpected IO-APIC, please file a report at... 
 
from dmesg output: 
 
IO APIC #2...... 
.... register #00: 02000000 
.......    : physical APIC id: 02 
.......    : Delivery Type: 0 
.......    : LTS          : 0 
.... register #01: 00178003 
.......     : max redirection entries: 0017 
.......     : PRQ implemented: 1 
.......     : IO APIC version: 0003 
INFO: unexpected IO-APIC, please file a report at 
      http://bugzilla.kernel.org 
      if your kernel is less than 3 months old. 
.... IRQ redirection table: 
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect: 
 00 000 00  1    0    0   0   0    0    0    00 
 01 001 01  0    0    0   0   0    1    1    39 
 02 001 01  0    0    0   0   0    1    1    31 
 03 001 01  0    0    0   0   0    1    1    41 
 04 001 01  0    0    0   0   0    1    1    49 
 05 001 01  0    0    0   0   0    1    1    51 
 06 001 01  0    0    0   0   0    1    1    59 
[...] 
 
Full dmesg output below, if more information are needed please contact me. 
 
Linux version 2.5.62 (root@sonne.local) (gcc version 3.2.1 20021207 (Gentoo
Linux  3.2.1-20021207)) #4 Sun Feb 23 17:07:32 CET 2003 
Video mode to be used for restore is f00 
BIOS-provided physical RAM map: 
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable) 
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved) 
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved) 
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable) 
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS) 
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data) 
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved) 
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved) 
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved) 
511MB LOWMEM available. 
ACPI: have wakeup address 0xc0001000 
found SMP MP-table at 000f5db0 
hm, page 000f5000 reserved twice. 
hm, page 000f6000 reserved twice. 
hm, page 000f1000 reserved twice. 
hm, page 000f2000 reserved twice. 
On node 0 totalpages: 131056 
  DMA zone: 4096 pages, LIFO batch:1 
  Normal zone: 126960 pages, LIFO batch:16 
  HighMem zone: 0 pages, LIFO batch:1 
ACPI: RSDP (v000 VIA694                     ) @ 0x000f77a0 
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3000 
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3040 
ACPI: MADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff7200 
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000 
ACPI: BIOS passes blacklist 
ACPI: Local APIC address 0xfee00000 
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled) 
Processor #0 6:6 APIC version 16 
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1]) 
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0]) 
IOAPIC[0]: Assigned apic_id 2 
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23 
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x0])  ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9]
polarity[0x0] trigger[0x0])  Enabling APIC mode:  Flat.  Using 1 I/O APICs 
Using ACPI (MADT) for SMP configuration information 
Building zonelist for node : 0 
Kernel command line: root=/dev/hdc7 hdb=ide-scsi panic=60 resume=/dev/hdd5 
ide_setup: hdb=ide-scsi 
Initializing CPU#0 
PID hash table entries: 2048 (order 11: 16384 bytes) 
Detected 1603.552 MHz processor. 
Console: colour VGA+ 80x25 
Calibrating delay loop... 3162.11 BogoMIPS 
Memory: 515172k/524224k available (2078k kernel code, 8304k reserved, 480k
data,  320k init, 0k highmem) 
Security Scaffold v1.0.0 initialized 
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes) 
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes) 
Mount-cache hash table entries: 512 (order: 0, 4096 bytes) 
-> /dev 
-> /dev/console 
-> /root 
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line) 
CPU: L2 Cache: 256K (64 bytes/line) 
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000 
Intel machine check architecture supported. 
Intel machine check reporting enabled on CPU#0. 
Machine check exception polling timer started. 
CPU: AMD Athlon(tm) XP 1900+ stepping 02 
Enabling fast FPU save and restore... done. 
Enabling unmasked SIMD FPU exception support... done. 
Checking 'hlt' instruction... OK. 
POSIX conformance testing by UNIFIX 
enabled ExtINT on CPU#0 
ESR value before enabling vector: 00000000 
ESR value after enabling vector: 00000000 
ENABLING IO-APIC IRQs 
init IO_APIC IRQs 
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not  connected. 
..TIMER: vector=0x31 pin1=2 pin2=0 
number of MP IRQ sources: 16. 
number of IO-APIC #2 registers: 24. 
testing the IO APIC....................... 
 
IO APIC #2...... 
.... register #00: 02000000 
.......    : physical APIC id: 02 
.......    : Delivery Type: 0 
.......    : LTS          : 0 
.... register #01: 00178003 
.......     : max redirection entries: 0017 
.......     : PRQ implemented: 1 
.......     : IO APIC version: 0003 
INFO: unexpected IO-APIC, please file a report at 
      http://bugzilla.kernel.org 
      if your kernel is less than 3 months old. 
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
 14 000 00  1    0    0   0   0    0    0    00 
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
IRQ9 -> 0:9 
IRQ10 -> 0:10 
IRQ11 -> 0:11 
IRQ12 -> 0:12 
IRQ13 -> 0:13 
IRQ14 -> 0:14 
IRQ15 -> 0:15 
.................................... done. 
Using local APIC timer interrupts. 
calibrating APIC timer ... 
..... CPU clock speed is 1603.0333 MHz. 
..... host bus clock speed is 267.0222 MHz. 
Linux NET4.0 for Linux 2.4 
Based upon Swansea University Computer Society NET3.039 
Initializing RT netlink socket 
mtrr: v2.0 (20020519) 
PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1 
PCI: Using configuration type 1 
BIO: pool of 256 setup, 14Kb (56 bytes/bio) 
biovec pool[0]:   1 bvecs: 256 entries (12 bytes) 
biovec pool[1]:   4 bvecs: 256 entries (48 bytes) 
biovec pool[2]:  16 bvecs: 256 entries (192 bytes) 
biovec pool[3]:  64 bvecs: 256 entries (768 bytes) 
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes) 
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes) 
ACPI: Subsystem revision 20030122 
    ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15 
ACPI: Interpreter enabled 
ACPI: Using IOAPIC for interrupt routing 
ACPI: PCI Root Bridge [PCI0] (00:00) 
PCI: Probing PCI hardware (bus 00) 
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT] 
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15) 
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15) 
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15) 
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15) 
ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled) 
ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled) 
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled) 
ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled) 
block request queues: 
 128 requests per read queue 
 128 requests per write queue 
 8 requests per batch 
 enter congestion at 15 
 exit congestion at 17 
drivers/usb/core/usb.c: registered new driver usbfs 
drivers/usb/core/usb.c: registered new driver hub 
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0 
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0 
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0 
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0 
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16) 
00:00:08[A] -> 2-16 -> IRQ 16 
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17) 
00:00:08[B] -> 2-17 -> IRQ 17 
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18) 
00:00:08[C] -> 2-18 -> IRQ 18 
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19) 
00:00:08[D] -> 2-19 -> IRQ 19 
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
Pin 2-18 already programmed 
Pin 2-19 already programmed 
Pin 2-16 already programmed 
Pin 2-17 already programmed 
Pin 2-19 already programmed 
Pin 2-16 already programmed 
Pin 2-17 already programmed 
Pin 2-18 already programmed 
Pin 2-17 already programmed 
Pin 2-18 already programmed 
Pin 2-19 already programmed 
Pin 2-16 already programmed 
Pin 2-16 already programmed 
Pin 2-17 already programmed 
Pin 2-18 already programmed 
Pin 2-19 already programmed 
ACPI: No IRQ known for interrupt pin A of device 00:10.0<4>ACPI: No IRQ
known for  interrupt pin B of device 00:10.1<4>ACPI: No IRQ known for
interrupt pin C of device  00:10.2<4>ACPI: No IRQ known for interrupt pin D
of device 00:10.3<4>ACPI: No  IRQ known for interrupt pin A of device
00:11.1 - using IRQ 255 
PCI: Using ACPI for IRQ routing 
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'  Enabling SEP on CPU 0 
Total HugeTLB memory allocated, 0 
aio_setup: sizeof(struct page) = 40 
VFS: Disk quotas dquot_6.5.1 
Journalled Block Device driver loaded 
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au) 
devfs: boot_options: 0x1 
Installing knfsd (copyright (C) 1996 okir@monad.swb.de). 
Capability LSM initialized 
Initializing Cryptographic API 
ACPI: Power Button (FF) [PWRF] 
ACPI: Sleep Button (CM) [SLPB] 
ACPI: Fan [FAN] (on) 
ACPI: Processor [CPU0] (supports C1) 
ACPI: Thermal Zone [THRM] (58 C) 
pty: 256 Unix98 ptys configured 
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0 
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is
60  seconds). 
Floppy drive(s): fd0 is 1.44M 
FDC 0 is a post-1991 82077 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2 
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
VP_IDE: IDE controller at PCI slot 00:11.1 
ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255 
VP_IDE: chipset revision 6 
VP_IDE: not 100% native mode: will probe irqs later 
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1 
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA 
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA 
hda: Pioneer DVD-ROM ATAPIModel DVD-114 0125, ATAPI CD/DVD-ROM drive 
hdb: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive 
hda: DMA disabled 
hdb: DMA disabled 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
hdc: MAXTOR 6L080J4, ATA DISK drive 
hdd: MAXTOR 6L080J4, ATA DISK drive 
hdc: DMA disabled 
hdd: DMA disabled 
ide1 at 0x170-0x177,0x376 on irq 15 
hdc: host protected area => 1 
hdc: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, 
UDMA(133) 
 /dev/ide/host0/bus1/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 > 
hdd: host protected area => 1 
hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, 
UDMA(133) 
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 > 
hda: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33) 
Uniform CD-ROM driver Revision: 3.12 
end_request: I/O error, dev hda, sector 0 
scsi HBA driver  didn't set a release method, please fix the template 
mice: PS/2 mouse device common for all mice 
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1 
serio: i8042 AUX port at 0x60,0x64 irq 12 
input: AT Set 2 keyboard on isa0060/serio0 
serio: i8042 KBD port at 0x60,0x64 irq 1 
NET4: Linux TCP/IP 1.0 for NET4.0 
IP: routing cache hash table of 4096 buckets, 32Kbytes 
TCP: Hash tables configured (established 32768 bind 65536) 
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
ACPI: (supports S0 S1 S3 S4 S5) 
Resume Machine: resuming from /dev/hdd5 
Resuming from device ide1(22,69) 
Resume Machine: This is normal swap space 
found reiserfs format "3.6" with standard journal 
Reiserfs journal params: device ide1(22,7), size 8192, journal first block
18, max  trans len 1024, max batch 900, max commit age 30, max trans age 30 
reiserfs: checking transaction log (ide1(22,7)) for (ide1(22,7))  Using r5
hash to sort names 
VFS: Mounted root (reiserfs filesystem) readonly. 
Mounted devfs on /dev 
Freeing unused kernel memory: 320k freed 
Adding 514040k swap on /dev/hdd5.  Priority:-1 extents:1 
Real Time Clock Driver v1.11 
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html 
00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd000. Vers LK1.1.19 
scsi0 : SCSI host adapter emulation for IDE ATAPI devices 
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.03 
  Type:   CD-ROM                             ANSI SCSI revision: 02 
found reiserfs format "3.6" with standard journal 
Reiserfs journal params: device ide1(22,8), size 8192, journal first block
18, max  trans len 1024, max batch 900, max commit age 30, max trans age 30 
reiserfs: checking transaction log (ide1(22,8)) for (ide1(22,8))  Using r5
hash to sort names 
found reiserfs format "3.5" with standard journal 
Reiserfs journal params: device ide1(22,72), size 8192, journal first block
18, max  trans len 1024, max batch 900, max commit age 30, max trans age 30 
reiserfs: checking transaction log (ide1(22,72)) for (ide1(22,72))  Using
r5 hash to sort names 
reiserfs: using 3.5.x disk format 
found reiserfs format "3.6" with standard journal 
Reiserfs journal params: device ide1(22,9), size 8192, journal first block
18, max  trans len 1024, max batch 900, max commit age 30, max trans age 30 
reiserfs: checking transaction log (ide1(22,9)) for (ide1(22,9))  Using r5
hash to sort names 
blk: queue c03ed374, I/O limit 4095Mb (mask 0xffffffff) 
blk: queue c03ed654, I/O limit 4095Mb (mask 0xffffffff) 
end_request: I/O error, dev hda, sector 0 
end_request: I/O error, dev hda, sector 0 
Linux agpgart interface v0.100 (c) Dave Jones 
[drm:drm_init] *ERROR* Cannot initialize the agpgart module. 
Uninitialised timer! 
This is just a warning.  Your computer is OK 
function=0x00000000, data=0x0 
Call Trace: [<c01281a1>]  [<c012848a>]  [<e0b5d370>]  [<e0b620af>]  
[<e0b2b236>]  [<e0b66fb8>]  [<e0b70b40>]  [<c013438d>]  [<c010951f>]


