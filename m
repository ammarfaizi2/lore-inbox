Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWAVSTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWAVSTK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAVSTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:19:10 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:38111 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751305AbWAVSTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:19:08 -0500
Date: Sun, 22 Jan 2006 13:18:59 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
In-Reply-To: <20060121225845.71cb7cad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601221316550.30208@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
 <20060121225845.71cb7cad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Jan 2006, Andrew Morton wrote:

> Ariel <askernel2615@dsgml.com> wrote:
>>
>> I have a memory leak in scsi_cmd_cache.
>
> You're no the only one.  Please send the full `dmesg -s 1000000' output so
> we can see which devices and drivers are in use.

I don't actually have any scsi devices, it's being used by sata (and usb I 
guess). That's why I sent to linux-ide.

 	-Ariel

Linux version 2.6.15 (root@cherryberry.dsgml.com) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #4 SMP Thu Jan 12 02:09:21 EST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5630
On node 0 totalpages: 262128
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
   HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f70a0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7040
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=900
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2793.694 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032256k/1048512k available (4203k kernel code, 15600k reserved, 1592k data, 292k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5589.36 BogoMIPS (lpj=2794684)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................
Table [DSDT](id 0005) - 506 Objects with 55 Devices 156 Methods 27 Regions
ACPI Namespace successfully loaded at root c07314bc
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5585.26 BogoMIPS (lpj=2792631)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11174.63 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfba30, last bus=3
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..................................................................
Initialized 27/27 Regions 9/9 Fields 19/19 Buffers 11/16 Packages (515 nodes)
Executing all Device _STA and_INI methods:............................................................
60 Devices found containing: 60 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:03:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 23
pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
   IO window: a000-afff
   MEM window: f7000000-f70fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: 7000-9fff
   MEM window: f0000000-f6ffffff
   PREFETCH window: d0000000-efffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.25 [Flags: R/W].
fuse init (API version 7.3)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ipmi message handler version 38.0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT372N: IDE controller at PCI slot 0000:03:06.0
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 21 (level, low) -> IRQ 17
HPT372N: chipset revision 6
HPT372N: 100% native mode on irq 17
hpt: HPT372N detected, using 372N timing.
FREQ: 85 PLL: 41
HPT37XN: unknown bus timing [44 2].
hpt: no known IDE timings, disabling DMA.
hpt: HPT372N detected, using 372N timing.
FREQ: 164 PLL: 66
HPT37XN: unknown bus timing [69 4].
hpt: no known IDE timings, disabling DMA.
Probing IDE interface ide2...
Probing IDE interface ide3...
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdd: CD-ROM 50X L, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
Probing IDE interface ide3...
ide1 at 0x170-0x177,0x376 on irq 15
hdd: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: combined mode detected (p=1, s=0)
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 312581808 sectors: LBA48
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:207f
ata1: dev 1 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
   Type:   Direct-Access                      ANSI SCSI revision: 05
sata_sil 0000:03:05.0: version 0.9
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 20 (level, low) -> IRQ 18
ata2: SATA max UDMA/100 cmd 0xF8802080 ctl 0xF880208A bmdma 0xF8802000 irq 18
ata3: SATA max UDMA/100 cmd 0xF88020C0 ctl 0xF88020CA bmdma 0xF8802008 irq 18
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:207f
ata3: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6B250S0    Rev: BANC
   Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3 sdb4
sd 0:0:1:0: Attached scsi disk sdb
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdc: drive cache: write back
  sdc: sdc1 sdc2 sdc3
sd 1:0:0:0: Attached scsi disk sdc
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdd: drive cache: write back
  sdd: sdd1 sdd2 sdd3
sd 2:0:0:0: Attached scsi disk sdd
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: Attached scsi generic sg2 type 0
sd 2:0:0:0: Attached scsi generic sg3 type 0
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000bc00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x0000b000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 16, io base 0x0000b400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000b800
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 2
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 3-1: new full speed USB device using uhci_hcd and address 2
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver hiddev
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
I2O subsystem v1.288
i2o: max drivers = 8
I2O Configuration OSM v1.248
I2O Bus Adapter OSM v$Rev$
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
i2c /dev entries driver
it87 0-002d: Detected broken BIOS defaults, disabling PWM interface
it87: Found IT8712F chip at 0x290, revision 5
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  3628.000 MB/sec
raid5: using function: pIII_sse (3628.000 MB/sec)
raid6: int32x1    828 MB/s
raid6: int32x2   1089 MB/s
raid6: int32x4    742 MB/s
raid6: int32x8    550 MB/s
raid6: mmxx1     2242 MB/s
raid6: mmxx2     2851 MB/s
raid6: sse1x1    1511 MB/s
raid6: sse1x2    2093 MB/s
raid6: sse2x1    2421 MB/s
raid6: sse2x2    3062 MB/s
raid6: using algorithm sse2x2 (3062 MB/s)
md: raid6 personality registered as nr 8
md: faulty personality registered as nr 10
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21 2005 UTC).
ACPI: PCI Interrupt 0000:03:07.0[A] -> GSI 22 (level, low) -> IRQ 21
ALSA device list:
   #0: C-Media PCI CMI8738-MC6 (model 55) at 0x9800, irq 21
u32 classifier
     Perfomance counters on
     OLD policer on 
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.4 (8191 buckets, 65528 max) - 216 bytes per conntrack
input: AT Translated Set 2 keyboard as /class/input/input2
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
ip_tables: (C) 2000-2002 Netfilter core team
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: sdb2 has different UUID to sdd1
md:  adding sdb1 ...
md: sda2 has different UUID to sdd1
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 4203kB for md0
raid5: raid level 5 set md0 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
  --- rd:4 wd:4 fd:0
  disk 0, o:1, dev:sda1
  disk 1, o:1, dev:sdb1
  disk 2, o:1, dev:sdc1
  disk 3, o:1, dev:sdd1
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 292k freed
ACPI: PCI Interrupt 0000:03:04.1[A] -> GSI 17 (level, low) -> IRQ 22
ieee1394: Initialized config rom entry `ip1394'
cx2388x v4l2 driver version 0.0.5 loaded
ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 18 (level, low) -> IRQ 16
CORE cx88[0]: subsystem: 7063:3000, board: pcHDTV HD3000 HDTV [card=22,autodetected]
TV tuner 52 at 0x1fe, Radio tuner -1 at 0x1fe
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
cx2388x dvb driver version 0.0.5 loaded
cx88[0]/0: found at 0000:03:02.0, rev: 5, irq: 16, latency: 32, mmio: 0xf2000000
tuner 1-0061: chip found @ 0xc2 (cx88[0])
tuner 1-0061: type set to 52 (Thomson DDT 7610 (ATSC/NTSC))
tda9887 1-0043: chip found @ 0x86 (cx88[0])
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
ACPI: PCI Interrupt 0000:03:03.0[A] -> <6>ACPI: PCI Interrupt 0000:03:02.2[A] -> GSI 18 (level, low) -> IRQ 16
cx88[0]/2: found at 0000:03:02.2, rev: 5, irq: 16, latency: 32, mmio: 0xf3000000
cx88[0]/2: cx2388x based dvb card
GSI 19 (level, low) -> IRQ 20
CORE cx88[1]: subsystem: 7063:3000, board: pcHDTV HD3000 HDTV [card=22,autodetected]
TV tuner 52 at 0x1fe, Radio tuner -1 at 0x1fe
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 0 (Oren OR51132 VSB/QAM Frontend)...
tuner 2-0061: chip found @ 0xc2 (cx88[1])
tuner 2-0061: type set to 52 (Thomson DDT 7610 (ATSC/NTSC))
tda9887 2-0043: chip found @ 0x86 (cx88[1])
cx88[1]/0: found at 0000:03:03.0, rev: 5, irq: 20, latency: 32, mmio: 0xf4000000
cx88[1]/0: registered device video1 [v4l2]
cx88[1]/0: registered device vbi1
cx88[1]/0: registered device radio1
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 17 (level, low) -> IRQ 22
bttv0: Bt878 (rev 2) at 0000:03:04.0, irq: 22, latency: 32, mmio: 0xe0000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
ACPI: PCI Interrupt 0000:03:03.2[A] -> GSI 19 (level, low) -> IRQ 20
cx88[1]/2: found at 0000:03:03.2, rev: 5, irq: 20, latency: 32, mmio: 0xf5000000
cx88[1]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[1]).
DVB: registering frontend 1 (Oren OR51132 VSB/QAM Frontend)...
tuner 3-0061: chip found @ 0xc2 (bt878 #0 [sw])
tveeprom 3-0050: Hauppauge model 61371, rev B223, serial# 2041163
tveeprom 3-0050: tuner model is Philips FM1236 (idx 23, type 2)
tveeprom 3-0050: TV standards NTSC(M) (eeprom 0x08)
tveeprom 3-0050: audio processor is MSP3430 (idx 7)
tveeprom 3-0050: has radio
bttv0: using tuner=2
tuner 3-0061: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp3400 3-0040: chip=MSP3430G-A1 +nicam +simple +simpler +radio mode=simpler
msp3400 3-0040: msp34xxg daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv0: registered device video2
bttv0: registered device vbi2
bttv0: registered device radio2
bttv0: PLL: 28636363 => 35468950 .. ok
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:0a.0[A] -> GSI 19 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:03:0a.0, from 10 to 4
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[f6001000-f60017ff]  Max Packet=[2048]
cx2388x blackbird driver version 0.0.5 loaded
   Vendor: Generic   Model: STORAGE DEVICE    Rev: 0113
   Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sde: 32000 512-byte hdwr sectors (16 MB)
sde: Write Protect is off
sde: Mode Sense: 02 00 00 00
sde: assuming drive cache: write through
SCSI device sde: 32000 512-byte hdwr sectors (16 MB)
sde: Write Protect is off
sde: Mode Sense: 02 00 00 00
sde: assuming drive cache: write through
  sde: sde1
sd 3:0:0:0: Attached scsi removable disk sde
sd 3:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00502c0000093e5a]
eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Adding 2096632k swap on /dev/sda3.  Priority:1 extents:1 across:2096632k
Adding 2096632k swap on /dev/sdb3.  Priority:2 extents:1 across:2096632k
Adding 2096632k swap on /dev/sdc2.  Priority:2 extents:1 across:2096632k
Adding 2096632k swap on /dev/sdd2.  Priority:2 extents:1 across:2096632k
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
