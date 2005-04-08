Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVDHLvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVDHLvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVDHLvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:51:49 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:19426 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262771AbVDHLuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:50:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=Bw1O6C5kqt9CUQy72xRWVjatdYe8A02jUAYVuZF+yaOht3MB21Sg6I39pwpBbhNJTphTxXc+WB9bJqtWtE1T6L1Dmn6FLj427T3dSV7MDUXtwNSIxzFixTH4XWOiugVrLcIb6tSVJvDqDiNiNYBJSXMwDF3MEum8joscxq/LLp4=
Message-ID: <42567015.4080504@gmail.com>
Date: Fri, 08 Apr 2005 13:50:45 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

along the 2.6.12-rcX-mmX PCI-Express is not usable at all with
mm-patchsets. I posted some days ago the problem taht
the IRQs get not regonized by the kernel also with pci=routeirq nothing
helped.
The problem still the same and some new problems now with 2.6.12-rc2-mm2
in addition.

This computer has an Intel Pentium 4 630 with HT,EIST and EMT64 enabled.
In 2.6.12-rc2 everything works perfect.
So I post my dmesg output maybe you can see some interesting things
there. I hope you'll find the issue or bug..whatever hope that
its possible to sort the problems out.

Thanks in Advanced

Now I post the 2.6.12-rc2-mm2 and after that the 2.6.12-rc2 vanilla
kernel output

2.6.12-rc2-mm2 output:

Bootdata ok (command line is root=/dev/md1 vga=794 quiet)
Linux version 2.6.12-rc2-mm2-md1 (root@ioGL64NX) (gcc-Version 3.4.3
20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 SMP PREEMPT
Fri Apr 8 13:35:42 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @
0x00000000000fafa0
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000503 MSFT 0x00000097) @
0x000000003ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000503 MSFT 0x00000097) @
0x000000003ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x02000503 MSFT 0x00000097) @
0x000000003ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000503 MSFT 0x00000097) @
0x000000003ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x02000503 MSFT 0x00000097) @
0x000000003ffb6c40
ACPI: DSDT (v001  A0144 A0144000 0x00000000 INTL 0x02002026) @
0x0000000000000000
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257968 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bfb00000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/md1 vga=794 quiet console=tty0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 3527.408 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1024964k/1048256k available (3240k kernel code, 22664k reserved,
1218k data, 212k init)
Calibrating delay loop... 6963.20 BogoMIPS (lpj=3481600)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using IO APIC NMI watchdog
activating NMI Watchdog ... done.
Using local APIC timer interrupts.
Detected 13.778 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81003ff35f58
Initializing CPU#1
Calibrating delay loop... 7045.12 BogoMIPS (lpj=3522560)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Synced TSC of CPU 1 difference 107374180328
APIC error on CPU1: 00(40)
Brought up 2 CPUs
time.c: Using PIT/TSC based timekeeping.
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Can't get handler for 0000:00:1b.0
ACPI: Can't get handler for 0000:00:1f.3
ACPI: Can't get handler for 0000:04:00.0
ACPI: Can't get handler for 0000:02:00.0
ACPI: Can't get handler for 0000:01:09.0
ACPI: Can't get handler for 0000:01:0a.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: No ACPI bus support for 00:00
ACPI: No ACPI bus support for 00:01
ACPI: No ACPI bus support for 00:02
ACPI: No ACPI bus support for 00:03
ACPI: No ACPI bus support for 00:04
ACPI: No ACPI bus support for 00:05
ACPI: No ACPI bus support for 00:06
ACPI: No ACPI bus support for 00:07
ACPI: No ACPI bus support for 00:08
ACPI: No ACPI bus support for 00:09
ACPI: No ACPI bus support for 00:0a
ACPI: No ACPI bus support for 00:0b
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:06: ioport range 0x290-0x297 has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
inotify device minor=63
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: No ACPI bus support for pcie00
Allocate Port Service[pcie03]
ACPI: No ACPI bus support for pcie03
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: No ACPI bus support for pcie00
Allocate Port Service[pcie02]
ACPI: No ACPI bus support for pcie02
Allocate Port Service[pcie03]
ACPI: No ACPI bus support for pcie03
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: No ACPI bus support for pcie00
Allocate Port Service[pcie02]
ACPI: No ACPI bus support for pcie02
Allocate Port Service[pcie03]
ACPI: No ACPI bus support for pcie03
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using
5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: No ACPI bus support for vesafb.0
fb1: Virtual frame buffer device, using 1024K of video memory
ACPI: No ACPI bus support for vfb.0
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
io scheduler noop registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: No ACPI bus support for floppy.0
RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ub: sizeof ub_scsi_cmd 88 ub_dev 2672
usbcore: registered new driver ub
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
sk98lin: Network Device Driver v8.15.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
      PrefPort:A  RlmtMode:Check Link State
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 217
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI: No ACPI bus support for 0.0
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 225
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 225
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 1 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata2: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
ata2: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata2: dev 1 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
ata2: dev 1 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP1213C   Rev: SV10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 0:0:0:0
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 0:0:1:0
  Vendor: ATA       Model: SAMSUNG SP1213C   Rev: SV10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 1:0:0:0
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: No ACPI bus support for 1:0:1:0
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 < sdc5 sdc6 >
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 < sdd5 >
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi1, channel 0, id 1, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xd2cff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ACPI: No ACPI bus support for usb1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: No ACPI bus support for 1-0:1.0
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 233, io base 0x00009880
ACPI: No ACPI bus support for usb2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 2-0:1.0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 225, io base 0x00009c00
ACPI: No ACPI bus support for usb3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 3-0:1.0
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 217, io base 0x0000a000
ACPI: No ACPI bus support for usb4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 4-0:1.0
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000a080
ACPI: No ACPI bus support for usb5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 5-0:1.0
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  5116.000 MB/sec
raid5: using function: generic_sse (5116.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0xd2cf4000 irq 169
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
ACPI wakeup devices:
P0P1 P0P3 P0P4 P0P5 P0P6 P0P7 USB1 USB2 USB3 USB4 EUSB MC97
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
usb 3-1: new low speed USB device using uhci_hcd and address 2
md: autorun ...
md: considering sdd5 ...
md:  adding sdd5 ...
md: sdd1 has different UUID to sdd5
md: sdc6 has different UUID to sdd5
md: sdc5 has different UUID to sdd5
md:  adding sdb5 ...
md: sdb1 has different UUID to sdd5
md: sda6 has different UUID to sdd5
md: sda5 has different UUID to sdd5
md: created md3
md: bind<sdb5>
md: bind<sdd5>
md: running: <sdd5><sdb5>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc6 ...
md: sdc5 has different UUID to sdd1
md:  adding sdb1 ...
md:  adding sda6 ...
md: sda5 has different UUID to sdd1
md: created md1
md: bind<sda6>
md: bind<sdb1>
md: bind<sdc6>
md: bind<sdd1>
md: running: <sdd1><sdc6><sdb1><sda6>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdd1
raid0:   comparing sdd1(7325504) with sdd1(7325504)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc6
raid0:   comparing sdc6(7325504) with sdd1(7325504)
raid0:   EQUAL
raid0: looking at sdb1
raid0:   comparing sdb1(7325504) with sdd1(7325504)
raid0:   EQUAL
raid0: looking at sda6
raid0:   comparing sda6(7325504) with sdd1(7325504)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 29302016 blocks.
raid0 : conf->hash_spacing is 29302016 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering sdc5 ...
md:  adding sdc5 ...
md:  adding sda5 ...
md: created md0
md: bind<sda5>
md: bind<sdc5>
md: running: <sdc5><sda5>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdc5
raid0:   comparing sdc5(30001280) with sdc5(30001280)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(30001280) with sdc5(30001280)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 60002560 blocks.
raid0 : conf->hash_spacing is 60002560 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
UDF-fs: No partition found (1)
XFS mounting filesystem md1
ACPI: No ACPI bus support for 3-1
Ending clean XFS mount for filesystem: md1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 212k freed
input: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on
usb-0000:00:1d.1-1
ACPI: No ACPI bus support for 3-1:1.0
input: USB HID v1.10 Device [Logitech HID compliant keyboard] on
usb-0000:00:1d.1-1
ACPI: No ACPI bus support for 3-1:1.1
usb 3-2: new low speed USB device using uhci_hcd and address 3
ACPI: No ACPI bus support for 3-2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:1d.1-2
ACPI: No ACPI bus support for 3-2:1.0

2.6.12-rc2 vanilla kernel:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @
0x00000000000fafa0
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000503 MSFT 0x00000097) @
0x000000003ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000503 MSFT 0x00000097) @
0x000000003ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x02000503 MSFT 0x00000097) @
0x000000003ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000503 MSFT 0x00000097) @
0x000000003ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x02000503 MSFT 0x00000097) @
0x000000003ffb6c40
ACPI: DSDT (v001  A0144 A0144000 0x00000000 INTL 0x02002026) @
0x0000000000000000
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257968 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/md1 vga=794 quiet console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 3527.425 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1024944k/1048256k available (3249k kernel code, 22684k reserved,
1243k data, 208k init)
Calibrating delay loop... 6963.20 BogoMIPS (lpj=3481600)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using IO APIC NMI watchdog
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU0:               Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Booting processor 1/1 rip 6000 rsp ffff81003ff17f58
Initializing CPU#1
Calibrating delay loop... 7045.12 BogoMIPS (lpj=3522560)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Total of 2 processors activated (14008.32 BogoMIPS).
activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#1: NMI appears to be stuck (0)!
Using local APIC timer interrupts.
Detected 13.778 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:06: ioport range 0x290-0x297 has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
inotify device minor=63
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using
5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
fb1: Virtual frame buffer device, using 1024K of video memory
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
io scheduler noop registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ub: sizeof ub_scsi_cmd 88 ub_dev 2680
usbcore: registered new driver ub
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
sk98lin: Network Device Driver v8.15.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
      PrefPort:A  RlmtMode:Check Link State
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 217
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 225
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 225
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 1 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata2: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
ata2: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata2: dev 1 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
ata2: dev 1 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP1213C   Rev: SV10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1213C   Rev: SV10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 234493056 512-byte hdwr sectors (120060 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 < sdc5 sdc6 >
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 < sdd5 >
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi1, channel 0, id 1, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xd2cff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 233, io base 0x00009880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 225, io base 0x00009c00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 217, io base 0x0000a000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000a080
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  5108.000 MB/sec
raid5: using function: generic_sse (5108.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0xd2cf4000 irq 169
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
P0P1 P0P3 P0P4 P0P5 P0P6 P0P7 USB1 USB2 USB3 USB4 EUSB MC97
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
usb 3-1: new low speed USB device using uhci_hcd and address 2
md: autorun ...
md: considering sdd5 ...
md:  adding sdd5 ...
md: sdd1 has different UUID to sdd5
md: sdc6 has different UUID to sdd5
md: sdc5 has different UUID to sdd5
md:  adding sdb5 ...
md: sdb1 has different UUID to sdd5
md: sda6 has different UUID to sdd5
md: sda5 has different UUID to sdd5
md: created md3
md: bind<sdb5>
md: bind<sdd5>
md: running: <sdd5><sdb5>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc6 ...
md: sdc5 has different UUID to sdd1
md:  adding sdb1 ...
md:  adding sda6 ...
md: sda5 has different UUID to sdd1
md: created md1
md: bind<sda6>
md: bind<sdb1>
md: bind<sdc6>
md: bind<sdd1>
md: running: <sdd1><sdc6><sdb1><sda6>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdd1
raid0:   comparing sdd1(7325504) with sdd1(7325504)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc6
raid0:   comparing sdc6(7325504) with sdd1(7325504)
raid0:   EQUAL
raid0: looking at sdb1
raid0:   comparing sdb1(7325504) with sdd1(7325504)
raid0:   EQUAL
raid0: looking at sda6
raid0:   comparing sda6(7325504) with sdd1(7325504)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 29302016 blocks.
raid0 : conf->hash_spacing is 29302016 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering sdc5 ...
md:  adding sdc5 ...
md:  adding sda5 ...
md: created md0
md: bind<sda5>
md: bind<sdc5>
md: running: <sdc5><sda5>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdc5
raid0:   comparing sdc5(30001280) with sdc5(30001280)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(30001280) with sdc5(30001280)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 60002560 blocks.
raid0 : conf->hash_spacing is 60002560 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
UDF-fs: No partition found (1)
XFS mounting filesystem md1
Ending clean XFS mount for filesystem: md1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
input: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on
usb-0000:00:1d.1-1
input: USB HID v1.10 Device [Logitech HID compliant keyboard] on
usb-0000:00:1d.1-1
usb 3-2: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:1d.1-2
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:04:00.0 to 64

