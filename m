Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUEMKyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUEMKyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUEMKyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:54:12 -0400
Received: from imap.gmx.net ([213.165.64.20]:25807 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264088AbUEMKx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:53:29 -0400
X-Authenticated: #4512188
Message-ID: <40A353A0.9060907@gmx.de>
Date: Thu, 13 May 2004 12:53:20 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2, usb ehci warnings/error?
References: <20040513032736.40651f8e.akpm@osdl.org>
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please look at the end of dmesg output.

There appear lines like

usb usb2: string descriptor 0 read error: -108

bug or feature? They weren't there with 2.6.6-mm1. I have no usb2.0 
stuff to actually test. My usb1 stuff seems to work though.

Prakash





My dmesg (start is gone..part of it comes from log.)

May 13 12:46:06 tachyon 00003fff3000 - 0000000040000000 (ACPI data)
May 13 12:46:06 tachyon BIOS-e820: 00000000fec00000 - 00000000fec01000 
(reserved)
May 13 12:46:06 tachyon BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
May 13 12:46:06 tachyon BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
May 13 12:46:06 tachyon 127MB HIGHMEM available.
May 13 12:46:06 tachyon 896MB LOWMEM available.
May 13 12:46:06 tachyon On node 0 totalpages: 262128
May 13 12:46:06 tachyon DMA zone: 4096 pages, LIFO batch:1
May 13 12:46:06 tachyon Normal zone: 225280 pages, LIFO batch:16
May 13 12:46:06 tachyon HighMem zone: 32752 pages, LIFO batch:7
May 13 12:46:06 tachyon DMI 2.2 present.
May 13 12:46:06 tachyon ACPI: RSDP (v000 Nvidia 
            ) @ 0x000f6ba0
May 13 12:46:06 tachyon ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff3000
May 13 12:46:06 tachyon ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff3040

ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff79c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda7 quiet  elevator=cfq hdg=none 
idle=halt acpi_skip_timer_override
ide_setup: hdg=none
using halt in idle threads.
CPU 0 irqstacks, hard=c0478000 soft=c0477000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2205.243 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 1035476k/1048512k available (2425k kernel code, 12128k reserved, 
952k data, 144k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4358.14 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm)  stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 
not connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2204.0682 MHz.
..... host bus clock speed is 400.0851 MHz.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
00:00:01[A] -> 2-23 -> IRQ 23 level high
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
00:00:02[A] -> 2-22 -> IRQ 22 level high
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
00:00:02[B] -> 2-21 -> IRQ 21 level high
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
00:00:02[C] -> 2-20 -> IRQ 20 level high
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
00:01:06[A] -> 2-18 -> IRQ 18 level high
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
00:01:06[B] -> 2-19 -> IRQ 19 level high
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
00:01:06[C] -> 2-16 -> IRQ 16 level high
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
00:01:06[D] -> 2-17 -> IRQ 17 level high
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 001 01  0    0    0   0   0    1    1    31
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    41
  03 001 01  0    0    0   0   0    1    1    49
  04 001 01  0    0    0   0   0    1    1    51
  05 001 01  0    0    0   0   0    1    1    59
  06 001 01  0    0    0   0   0    1    1    61
  07 001 01  0    0    0   0   0    1    1    69
  08 001 01  0    0    0   0   0    1    1    71
  09 001 01  0    1    0   0   0    1    1    79
  0a 001 01  0    0    0   0   0    1    1    81
  0b 001 01  0    0    0   0   0    1    1    89
  0c 001 01  0    0    0   0   0    1    1    91
  0d 001 01  0    0    0   0   0    1    1    99
  0e 001 01  0    0    0   0   0    1    1    A1
  0f 001 01  0    0    0   0   0    1    1    A9
  10 001 01  1    1    0   0   0    1    1    E1
  11 001 01  1    1    0   0   0    1    1    E9
  12 001 01  1    1    0   0   0    1    1    D1
  13 001 01  1    1    0   0   0    1    1    D9
  14 001 01  1    1    0   0   0    1    1    C9
  15 001 01  1    1    0   0   0    1    1    C1
  16 001 01  1    1    0   0   0    1    1    B9
  17 001 01  1    1    0   0   0    1    1    B1
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.10 [Flags: R/W].
udf: registering filesystem
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (52 C)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: NU DVDRW DDW-081, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xF8817080 ctl 0xF881708A bmdma 0xF8817000 
irq 18
ata2: SATA max UDMA/100 cmd 0xF88170C0 ctl 0xF88170CA bmdma 0xF8817008 
irq 18
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 312581808 sectors:  lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
   Vendor: ATA       Model: SAMSUNG SP1614N   Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: dev 0 max request 32MB (lba48)
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write through
  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 155
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5100
Advanced Linux Sound Architecture Driver Version 1.0.4 (Tue Mar 30 
08:19:30 2004 UTC).
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49394 usecs
intel8x0: clocking to 47419
ALSA device list:
   #0: NVidia nForce2 at 0xcc081000, irq 20
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 144k freed
NTFS volume version 3.1.
NTFS-fs error (device sda2): ntfs_check_logfile(): The two restart pages 
in $LogFile do not match.
NTFS-fs warning (device sda2): load_system_files(): Failed to load 
$LogFile.  Will not be able to remount read-write.  Mount in Windows.
NTFS volume version 3.1.
NTFS-fs error (device sda6): ntfs_check_logfile(): The two restart pages 
in $LogFile do not match.
NTFS-fs warning (device sda6): load_system_files(): Failed to load 
$LogFile.  Will not be able to remount read-write.  Mount in Windows.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 22, pci mem f88fc000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 21, pci mem f88fe000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 20, pci mem f8909000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
hub 1-0:1.0: hub_port_status failed (err = -108)
hub 1-0:1.0: connect-debounce failed, port 1 disabled
hub 1-0:1.0: cannot disable port 1 (err = -108)
hub 1-0:1.0: hub_port_status failed (err = -108)
hub 1-0:1.0: hub_port_status failed (err = -108)
hub 1-0:1.0: hub_hub_status failed (err = -108)
hub 1-0:1.0: get_hub_status failed
ohci_hcd 0000:00:02.0: remote wakeup
usb 1-1: new full speed USB device using address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 1 proto 2 vid 0x03F0 pid 0x1004
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb usb2: string descriptor 0 read error: -108
usb 1-2: new full speed USB device using address 3
usb 1-2: USB disconnect, address 3
