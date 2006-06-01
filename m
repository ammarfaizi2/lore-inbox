Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWFAOUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWFAOUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWFAOUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:20:10 -0400
Received: from mx197.abrisite.fr ([85.31.209.197]:34828 "EHLO mail.abrisite.fr")
	by vger.kernel.org with ESMTP id S1750963AbWFAOUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:20:08 -0400
From: cyril canovas <cyril@egnx.com>
Organization: Egnx
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: BAD RAM SIZE DETECTION ON DELL POWER EDGE SC420
Date: Thu, 1 Jun 2006 16:21:07 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606011621.07881.cyril@egnx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux can't manage to detect 4Go Ram but detects 3495616 kB of Ram, on a Dell 
Power Edge SC420 Bios Release A02

cat /proc/meminfo 

MemTotal:      3495616 kB
MemFree:       1650692 kB
Buffers:         18700 kB
Cached:        1602352 kB
SwapCached:          0 kB
Active:        1360888 kB
Inactive:       402900 kB
HighTotal:     2611760 kB
HighFree:       821656 kB
LowTotal:       883856 kB
LowFree:        829036 kB
SwapTotal:     4192956 kB
SwapFree:      4192956 kB
Dirty:             432 kB
Writeback:           0 kB
Mapped:        1292284 kB
Slab:            28568 kB
CommitLimit:   5940764 kB
Committed_AS:   504284 kB
PageTables:       3520 kB
VmallocTotal:   114680 kB
VmallocUsed:     10512 kB
VmallocChunk:   103868 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB


dmesg

Linux version 2.6.16-gentoo-r7 (root@localhost) (version gcc 3.4.5 (Gentoo 
3.4.5
-r1, ssp-3.4.5-1.0, pie-8.7.9)) #8 SMP PREEMPT Fri May 19 13:39:55 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d768cc00 (usable)
 BIOS-e820: 00000000d768cc00 - 00000000d768ec00 (ACPI NVS)
 BIOS-e820: 00000000d768ec00 - 00000000d7690c00 (ACPI data)
 BIOS-e820: 00000000d7690c00 - 00000000d8000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2550MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 882316
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 652940 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fec00
ACPI: RSDT (v001 DELL    PESC420 0x00000007 ASL  0x00000061) @ 0x000fcc76
ACPI: FADT (v001 DELL    PESC420 0x00000007 ASL  0x00000061) @ 0x000fccb2
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffd1800
ACPI: MADT (v001 DELL    PESC420 0x00000007 ASL  0x00000061) @ 0x000fcd26
ACPI: BOOT (v001 DELL    PESC420 0x00000007 ASL  0x00000061) @ 0x000fcdb8
ACPI: MCFG (v001 DELL    PESC420 0x00000007 ASL  0x00000061) @ 0x000fcde0
ACPI: HPET (v001 DELL    PESC420 0x00000007 ASL  0x00000061) @ 0x000fce1e
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x07] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x05] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:0ec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/sda4
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3494548k/3529264k available (3122k kernel code, 33596k reserved, 1041k 
d
ata, 332k init, 2611760k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Using HPET for gettimeofday
Detected 2793.100 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 5592.08 BogoMIPS 
(lpj=11184160)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000 
0000441d
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 
0
0000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00100000 00000000 00000180 0000441d 
0000000
0 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 01
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5586.11 BogoMIPS 
(lpj=11172223)
CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000 
0000441d
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 0000441d 
0
0000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00100000 00000000 00000180 0000441d 
0000000
0 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 01
Total of 2 processors activated (11178.19 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=4000
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb32b, last bus=4
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dfe00000-dfefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: dfd00000-dfdfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: dfc00000-dfcfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x7a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1149169952.328:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
vesafb: Intel Corporation, Intel(r)CopperRiver Graphics Controller, Hardware 
Ver
sion 0.0 (OEM: Intel(r)CopperRiver Graphics Chip Accelerated VGA BIOS)
vesafb: VBE version: 3.0
vesafb: VBIOS/hardware supports DDC2 transfers
vesafb: no monitor limits have been set
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 100x37
vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 7872k, total 
7872
k
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
Floppy drive(s): fd0 is 1.44M
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4-NAPI
Copyright (c) 1999-2005 Intel Corporation.
tg3.c:v3.49 (Feb 2, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCI Express) 
10/100/1000Base
T Ethernet 00:13:20:55:c2:12
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 169
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: GCR-8483B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
iscsi: registered transport (tcp)
GDT-HA: Storage RAID Controller Driver. Version: 3.04
GDT-HA: Found 0 PCI Storage RAID Controllers
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 217
ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 217
ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 217
ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 217
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 
88:007f
ata1: dev 0 ATA-7, max UDMA/133, 156250000 sectors: LBA
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 
88:007f
ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: SATA link down (SStatus 0)
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L160M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
ieee1394: Initialized config rom entry `ip1394'
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 225, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver libusual
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 5
Cannot allocate resource for EISA slot 6
EISA: Detected 0 cards.
 dcdbas: Dell Systems Management Base Driver (version 5.6.0-2)
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 332k freed
Adding 4192956k swap on /dev/sda3.  Priority:-1 extents:1 across:4192956k
EXT3 FS on sda4, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 225, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 233, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 50, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 58, io base 0x0000ff20
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon[8215]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[8215]: Module vmmon: initialized
/dev/vmnet: open called by PID 8262 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
/dev/vmnet: open called by PID 8971 (vmware-vmx)
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened
/dev/vmmon[8983]: host clock rate change request 0 -> 19
/dev/vmmon[8983]: host clock rate change request 19 -> 83
device eth0 left promiscuous mode
bridge-eth0: disabled promiscuous mode
/dev/vmnet: open called by PID 8984 (vmware-vmx)
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened

-- 
SARL EGNX 
323 Chemin de l'oratoire
BP 116
13120 Gardanne

Site internet www.egnx.com
Tél 04 42 12 69 02
Fax 01 41 30 88 95
Mob 06 20 58 63 69

Email cyril@egnx.com
ICQ 39077836

Mr Canovas Cyril
Responsable Technique
