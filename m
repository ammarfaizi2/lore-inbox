Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTAKKcH>; Sat, 11 Jan 2003 05:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTAKKcH>; Sat, 11 Jan 2003 05:32:07 -0500
Received: from tag.witbe.net ([81.88.96.48]:517 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267175AbTAKKcD>;
	Sat, 11 Jan 2003 05:32:03 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [BUG - 2.5.56] bad: scheduling while atomic
Date: Sat, 11 Jan 2003 11:40:48 +0100
Message-ID: <003d01c2b95d$e7a6a370$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Trying 2.5.56 this morning, I ended up with the trace included below.
To get that, I simply added a 
"hdd=ide-scsi"
to the append line of my lilo.conf.
Without it, Linux boots fine, but of course doesn't used my IDE
cdrom writer.

The complete log of the boot process is after the trace. If you
need more infos, please say so.

Regards,
Paul

ide-scsi: abort called for 21
bad: scheduling while atomic!
Call Trace:
 [<c011a473>] schedule+0x301/0x306
 [<c0109b0b>] __down+0x99/0x102
 [<c011a4c8>] default_wake_function+0x0/0x3e
 [<c011deeb>] call_console_drivers+0x5d/0x114
 [<c0109d20>] __down_failed+0x8/0xc
 [<c030517b>] .text.lock.scsi_error+0x2d/0x52
 [<c0304804>] scsi_sleep_done+0x0/0x12
 [<c0330cf0>] idescsi_abort+0x102/0x10c
 [<c03042a1>] scsi_try_to_abort_cmd+0x63/0x7e
 [<c03043c1>] scsi_eh_abort_cmd+0x33/0x64
 [<c0304c02>] scsi_unjam_host+0x9e/0xe8
 [<c0109d2b>] __down_failed_interruptible+0x7/0xc
 [<c0304d27>] scsi_error_handler+0xdb/0x10a
 [<c0304c4c>] scsi_error_handler+0x0/0x10a
 [<c0108c11>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011a473>] schedule+0x301/0x306
 [<c011a5d4>] __wake_up_locked+0x22/0x26
 [<c0109b0b>] __down+0x99/0x102
 [<c011a4c8>] default_wake_function+0x0/0x3e
 [<c011deeb>] call_console_drivers+0x5d/0x114
 [<c0109d20>] __down_failed+0x8/0xc
 [<c030517b>] .text.lock.scsi_error+0x2d/0x52
 [<c0304804>] scsi_sleep_done+0x0/0x12
 [<c0330cf0>] idescsi_abort+0x102/0x10c
 [<c03042a1>] scsi_try_to_abort_cmd+0x63/0x7e
 [<c03043c1>] scsi_eh_abort_cmd+0x33/0x64
 [<c0304c02>] scsi_unjam_host+0x9e/0xe8
 [<c0109d2b>] __down_failed_interruptible+0x7/0xc
 [<c0304d27>] scsi_error_handler+0xdb/0x10a
 [<c0304c4c>] scsi_error_handler+0x0/0x10a
 [<c0108c11>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011a473>] schedule+0x301/0x306
 [<c011a5d4>] __wake_up_locked+0x22/0x26
 [<c0109b0b>] __down+0x99/0x102
 [<c011a4c8>] default_wake_function+0x0/0x3e
 [<c011deeb>] call_console_drivers+0x5d/0x114
 [<c0109d20>] __down_failed+0x8/0xc
 [<c030517b>] .text.lock.scsi_error+0x2d/0x52
 [<c0304804>] scsi_sleep_done+0x0/0x12
 [<c0330cf0>] idescsi_abort+0x102/0x10c
 [<c03042a1>] scsi_try_to_abort_cmd+0x63/0x7e
 [<c03043c1>] scsi_eh_abort_cmd+0x33/0x64
 [<c0304c02>] scsi_unjam_host+0x9e/0xe8
 [<c0109d2b>] __down_failed_interruptible+0x7/0xc
 [<c0304d27>] scsi_error_handler+0xdb/0x10a
 [<c0304c4c>] scsi_error_handler+0x0/0x10a
 [<c0108c11>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011a473>] schedule+0x301/0x306
 [<c011a5d4>] __wake_up_locked+0x22/0x26
 [<c0109b0b>] __down+0x99/0x102
 [<c011a4c8>] default_wake_function+0x0/0x3e
 [<c011deeb>] call_console_drivers+0x5d/0x114
 [<c0109d20>] __down_failed+0x8/0xc
 [<c030517b>] .text.lock.scsi_error+0x2d/0x52
 [<c0304804>] scsi_sleep_done+0x0/0x12
 [<c0330cf0>] idescsi_abort+0x102/0x10c
 [<c03042a1>] scsi_try_to_abort_cmd+0x63/0x7e
 [<c03043c1>] scsi_eh_abort_cmd+0x33/0x64
 [<c0304c02>] scsi_unjam_host+0x9e/0xe8
 [<c0109d2b>] __down_failed_interruptible+0x7/0xc
 [<c0304d27>] scsi_error_handler+0xdb/0x10a
 [<c0304c4c>] scsi_error_handler+0x0/0x10a
 [<c0108c11>] kernel_thread_helper+0x5/0xc


Linux version 2.5.56 (root@donald.as2917.net) (gcc version 3.2 20020903
(Red Hat Linux 8.0 3.2-7)) #1 Sat Jan 11 10:15:57 CET 2003
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=test ro
BOOT_FILE=/boot/vmlinuz-2.5.56 panic=30 hdd=ide-scsi acpi=off
console=ttyS0
ide_setup: hdd=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2423.546 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 513280k/524272k available (3194k kernel code, 10200k reserved,
1155k data, 368k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2423.0502 MHz.
..... host bus clock speed is 134.0638 MHz.
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
ACPI: Subsystem revision 20030109
ACPI: Disabled via command line (acpi=off)
Linux Plug and Play Support v0.93 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
SCSI subsystem driver Revision: 1.00
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1039/0963] at 00:02.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
Capability LSM initialized
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 920C
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported SiS chipset (device id: 0648), you might want to
try agp_try_unsupported=1.
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905 Boomerang 100baseTx at 0x7400. Vers LK1.1.18
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
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
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 > hda4
hdb: host protected area => 1
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63,
UDMA(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 >
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAN3367MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TDK       Model: CDRW4800B         Rev: S7S3
  Type:   CD-ROM                             ANSI SCSI revision: 02
ide-scsi: abort called for 21
bad: scheduling while atomic!

