Return-Path: <linux-kernel-owner+w=401wt.eu-S1161295AbXAMF7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbXAMF7W (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 00:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbXAMF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 00:59:22 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:49638 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161291AbXAMF7U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 00:59:20 -0500
From: Faik Uygur <faik@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci_softreset prevents acpi_power_off
Date: Sat, 13 Jan 2007 07:59:40 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
References: <200701111231.26819.faik@pardus.org.tr> <45A831EA.50601@gmail.com>
In-Reply-To: <45A831EA.50601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701130759.40780.faik@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

13 Oca 2007 Cts 03:12 tarihinde, Tejun Heo şunları yazmıştı: 
> Hello,

Hello,

Thanks for the response.

> [...]
> Does everything else work okay?  
> Can you access devices attached to 
> ahci?  

Yes. While the machine is on, there seems to be no problem at all. Everything 
works great.

> What happens when you try to shutdown?  

Does not shutdown and freezes.

Hand copied last messages seen on console:

Synchronizing SCSI cache for disk sda:
ACPI: PCI Interrupt for device 0000:06:08.0 disabled
Power down.
acpi_power_off called
  hwsleep-0285 [01] enter_sleep_state    : Entering sleep state [S5]

> If possible, please post  
> dmesg of shutting down.  

Following is the netcat output. Please ask if you need anything else.

Regards,
- Faik

Linux version 2.6.20-rc4 (root@pardus) (gcc version 3.4.6) #58 SMP Sat Jan 13 
07:38:22 EET 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 
000000000009f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 
00000000000a0000 type: 2
copy_e820_map() start: 00000000000d8000 size: 0000000000028000 end: 
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fd90000 end: 
000000001fe90000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fe90000 size: 000000000000d000 end: 
000000001fe9d000 type: 3
copy_e820_map() start: 000000001fe9d000 size: 0000000000063000 end: 
000000001ff00000 type: 4
copy_e820_map() start: 000000001ff00000 size: 0000000000100000 end: 
0000000020000000 type: 2
copy_e820_map() start: 00000000e0000000 size: 0000000010006000 end: 
00000000f0006000 type: 2
copy_e820_map() start: 00000000f0008000 size: 0000000000004000 end: 
00000000f000c000 type: 2
copy_e820_map() start: 00000000fed20000 size: 0000000000070000 end: 
00000000fed90000 type: 2
copy_e820_map() start: 00000000ff000000 size: 0000000001000000 end: 
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fe90000 (usable)
 BIOS-e820: 000000001fe90000 - 000000001fe9d000 (ACPI data)
 BIOS-e820: 000000001fe9d000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
510MB LOWMEM available.
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   130704
  HighMem    130704 ->   130704
early_node_map[1] active PFN ranges
    0:        0 ->   130704
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1729.118 MHz processor.
Built 1 zonelists.  Total pages: 129045
Kernel command line: root=/dev/sda1 mudur=language:tr init=/bin/bash 
netconsole=4444@192.168.1.8/eth0,9353@192.168.1.3/00:13:02:50:5C:2B
netconsole: local port 4444
netconsole: local IP 192.168.1.8
netconsole: interface eth0
netconsole: remote port 9353
netconsole: remote IP 192.168.1.3
netconsole: remote ethernet address 00:13:02:50:5c:2b
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1064 kB
 per task-struct memory footprint: 1200 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 510196k/522816k available (1638k kernel code, 12096k reserved, 750k 
data, 180k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfe90000   ( 510 MB)
      .init : 0xc035b000 - 0xc0388000   ( 180 kB)
      .data : 0xc029989d - 0xc03553b8   ( 750 kB)
      .text : 0xc0100000 - 0xc029989d   (1638 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3461.31 BogoMIPS 
(lpj=1730655)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 8k freed
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 000A) - 649 Objects with 60 Devices 190 Methods 21 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 10 Objects with 3 Devices 4 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 11 Objects with 3 Devices 5 Methods 0 Regions
Parsing all Control Methods:
hda: MATSHITAUJ-832D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
st: Version 20061107, fixed bufsize 32768, s/g segs 256
SCSI Media Changer driver v0.25
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 19
ahci 0000:00:1f.2: PORTS_IMPL is zero, forcing 0xf
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part
ata1: SATA max UDMA/133 cmd 0xE081C500 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xE081C580 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xE081C600 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xE081C680 ctl 0x0 bmdma 0x0 irq 19
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 0)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2080B 0000 PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda1, internal journal
Synchronizing SCSI cache for disk sda:
