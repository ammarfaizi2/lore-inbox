Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWCCV6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWCCV6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWCCV6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:58:50 -0500
Received: from bay101-f9.bay101.hotmail.com ([64.4.56.19]:48269 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751709AbWCCV6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:58:49 -0500
Message-ID: <BAY101-F9489BB97620F61EBEBF46DFEA0@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
From: "John Treubig" <jtreubig@hotmail.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       albertcc@tw.ibm.com
Subject: CDROM support for Promise 20269
Date: Fri, 03 Mar 2006 15:58:46 -0600
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3a87_3a44_5413"
X-OriginalArrivalTime: 03 Mar 2006 21:58:48.0711 (UTC) FILETIME=[A67F1970:01C63F0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_3a87_3a44_5413
Content-Type: text/plain; format=flowed

I've been working on a problem with Promise 20269 PATA adapter under LibATA 
that if I attach a CDROM drive, I can not see the drive.  The message log 
reports that the driver sees the device, but when I'm fully booted, there's 
no device available.  If I attach it to the motherboard IDE bus, I can 
access it just fine.  I've attached a copy of the boot log and you'll see 
the motherboard CD/DVD and the one attached to the Promise.  I suspect the 
PDC driver isn't handling the CDrom.  I'm currently running 2.6.15.

Best wishes,
John Treubig
VT Miltope


------=_NextPart_000_3a87_3a44_5413
Content-Type: text/plain; name="startup.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="startup.txt"

[   73.368469] serio: i8042 KBD port at 0x60,0x64 irq 1
[   73.369256] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing disabled
[   73.370635] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   73.371770] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   73.373119] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   73.398283] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   73.423414] parport: PnPBIOS parport detected.
[   73.448207] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
[   73.473924] lp0: using parport0 (interrupt-driven).
[   73.499714] Floppy drive(s): fd0 is 1.44M
[   73.539432] FDC 0 is a post-1991 82077
[   73.566083] loop: loaded (max 8 devices)
[   73.591948] r8169 Gigabit Ethernet driver 2.2LK loaded
[   73.618331] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[   73.644798] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC1] -> GSI 16 
(level, high) -> IRQ 16
[   73.673058] eth0: Identified chip type is 'RTL8169s/8110s'.
[   73.673063] eth0: RTL8169 at 0xd080e000, 00:0d:61:7a:f8:1b, IRQ 16
[   73.761222] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   73.788587] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[   73.816777] NFORCE2: IDE controller at PCI slot 0000:00:09.0
[   73.845240] NFORCE2: chipset revision 162
[   73.873659] NFORCE2: not 100% native mode: will probe irqs later
[   73.902703] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
[   73.931482]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, 
hdb:DMA
[   73.960485]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, 
hdd:DMA
[   73.988760] Probing IDE interface ide0...
[   74.251811] hda: TOSHIBA MK4019GAX, ATA DISK drive
[   74.890885] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   74.919036] Probing IDE interface ide1...
[   75.589842] hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
[   75.923408] ide1 at 0x170-0x177,0x376 on irq 15
[   75.951996] hda: max request size: 128KiB
[   76.684039] hda: Host Protected Area detected.
[   76.684040] 	current capacity is 78138047 sectors (40006 MB)
[   76.684042] 	native  capacity is 78140160 sectors (40007 MB)
[   76.767722] hda: Host Protected Area disabled.
[   76.795182] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(33)
[   76.823136] hda: cache flushes supported
[   76.851214]  hda: hda1 hda2 hda3
[   76.885378] ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
[   76.913692] ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC4] -> GSI 19 
(level, high) -> IRQ 17
[   77.152568] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   77.152570]         <Adaptec 29160 Ultra160 SCSI adapter>
[   77.152571]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 
SCBs
[   77.152573]
[   93.666571]   Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Rev: 0230
[   93.696930]   Type:   Direct-Access                      ANSI SCSI 
revision: 03
[   93.726541] scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
[   93.755805]  target0:0:6: Beginning Domain Validation
[   93.787494]  target0:0:6: wide asynchronous.
[   93.818348]  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, 
offset 63)
[   93.853396]  target0:0:6: Ending Domain Validation
[   95.932410] QLogic Fibre Channel HBA Driver
[   95.962527] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   95.992427] ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 
(level, high) -> IRQ 18
[   96.023111] qla2100 0000:01:09.0: Found an ISP2100, irq 18, iobase 
0xd0812000
[   96.054892] qla2100 0000:01:09.0: Configuring PCI space...
[   96.086038] qla2100 0000:01:09.0: Configure NVRAM parameters...
[   96.202033] qla2100 0000:01:09.0: Verifying loaded RISC code...
[   96.395548] qla2100 0000:01:09.0: Waiting for LIP to complete...
[  116.712015] qla2100 0000:01:09.0: Cable is unplugged...
[  116.741540] scsi1 : qla2xxx
[  116.770559] qla2100 0000:01:09.0:
[  116.770560]  QLogic Fibre Channel HBA Driver: 8.01.03-k
[  116.770561]   QLogic QLA2100 -
[  116.770562]   ISP2100: PCI (33 MHz) @ 0000:01:09.0 hdma-, host#=1, 
fw=1.19.25 TP
[  116.883207] ide-scsi is deprecated for cd burning! Use ide-cd and give 
dev=/dev/hdX as device
[  116.912530] scsi2 : SCSI host adapter emulation for IDE ATAPI devices
[  116.941982]   Vendor: SONY      Model: DVD-ROM DDU1621   Rev: S3.5
[  116.972660]   Type:   CD-ROM                             ANSI SCSI 
revision: 00
[  117.002592] libata version 1.20 loaded.
[  117.002623] pata_pdc2027x 0000:01:08.0: version 0.73
[  117.002648] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 
(level, high) -> IRQ 16
[  117.033294] pdc_read_counter: bccrh [7C05] bccrl [7E38]
[  117.063738] pdc_read_counter: bccrhv[7C05] bccrlv[7E38]
[  117.093641] pdc_detect_pll_input_clock: scr[40E20]
[  117.223544] pdc_read_counter: bccrh [7BD2] bccrl [7A41]
[  117.253592] pdc_read_counter: bccrhv[7BD2] bccrlv[7A1A]
[  117.283101] pdc_detect_pll_input_clock: scr[44E20]
[  117.312919] pdc_detect_pll_input_clock: start[1040383544] end[1038711361]
[  117.342897] pdc_detect_pll_input_clock: PLL input clock[16721830]Hz
[  117.372497] pata_pdc2027x 0000:01:08.0: PLL input clock 16721 kHz
[  117.401788] pdc_adjust_pll: pout_required is 133333333
[  117.431253] pdc_adjust_pll: pll_ctl[D58]
[  117.460259] pdc_adjust_pll: F[117] R[13] ratio*1000[7974]
[  117.489060] pdc_adjust_pll: Writing pll_ctl[D75]
[  117.547079] pdc_adjust_pll: pll_ctl[D75]
[  117.574619] ata1: PATA max UDMA/133 cmd 0xD08197C0 ctl 0xD0819FDA bmdma 
0xD0819000 irq 16
[  117.603113] ata2: PATA max UDMA/133 cmd 0xD08195C0 ctl 0xD0819DDA bmdma 
0xD0819008 irq 16
[  117.631054] pdc2027x_cbl_detect: No cable or 80-conductor cable on port 0
[  117.963877] ata1: dev 1 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0407
[  117.963880] ata1: dev 1 ATAPI, max UDMA/33
[  117.991560] pdc2027x_set_piomode: adev->pio_mode[C]
[  118.019059] pdc2027x_set_piomode: Set pio regs...
[  118.046224] pdc2027x_set_piomode: Set pio regs done
[  118.073102] pdc2027x_set_piomode: Set to pio mode[4]
[  118.099550] pdc2027x_set_dmamode: Set udma regs...
[  118.125576] pdc2027x_set_dmamode: Set udma regs done
[  118.151159] pdc2027x_set_dmamode: Set to udma mode[2]
[  118.176467] ata1: dev 1 configured for UDMA/33
[  118.201415] pdc2027x_set_piomode: adev->pio_mode[C]
[  118.225873] pdc2027x_set_piomode: Set pio regs...
[  118.250009] pdc2027x_set_piomode: Set pio regs done
[  118.273955] pdc2027x_set_piomode: Set to pio mode[4]
[  118.297779] pdc2027x_set_dmamode: Set udma regs...
[  118.321415] pdc2027x_set_dmamode: Set udma regs done
[  118.344714] pdc2027x_set_dmamode: Set to udma mode[2]
[  118.367700] scsi3 : pata_pdc2027x
[  118.390701] pdc2027x_cbl_detect: No cable or 80-conductor cable on port 1
[  118.574623] ATA: abnormal status 0x8 on port 0xD08195DF
[  118.598326] ata2: disabling port
[  118.621489] scsi4 : pata_pdc2027x
[  118.643926] ata1(1): WARNING: ATAPI is disabled, device ignored.
[  118.666412] sata_sil 0000:01:0d.0: version 0.9
[  118.666686] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[  118.689054] ACPI: PCI Interrupt 0000:01:0d.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  118.712067] ata3: SATA max UDMA/100 cmd 0xD0814080 ctl 0xD081408A bmdma 
0xD0814000 irq 19
[  118.734881] ata4: SATA max UDMA/100 cmd 0xD08140C0 ctl 0xD08140CA bmdma 
0xD0814008 irq 19
[  118.956931] ata3: no device found (phy stat 00000000)
[  118.979151] scsi5 : sata_sil
[  119.201572] ata4: no device found (phy stat 00000000)
[  119.223810] scsi6 : sata_sil
[  119.246507] SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
[  119.271242] SCSI device sda: drive cache: write back
[  119.294511] SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
[  119.319458] SCSI device sda: drive cache: write back
[  119.342703]  sda: sda1
[  119.365643] sd 0:0:6:0: Attached scsi disk sda
[  119.390260] sr0: scsi-1 drive
[  119.413124] Uniform CD-ROM driver Revision: 3.20
[  119.436363] sr 2:0:0:0: Attached scsi CD-ROM sr0
[  119.436407] sd 0:0:6:0: Attached scsi generic sg0 type 0
[  119.460034] sr 2:0:0:0: Attached scsi generic sg1 type 5
[  119.482764] Fusion MPT base driver 3.03.04
[  119.505782] Copyright (c) 1999-2005 LSI Logic Corporation
[  119.528651] Fusion MPT SPI Host driver 3.03.04
[  119.551238] Fusion MPT FC Host driver 3.03.04
[  119.573627] Fusion MPT SAS Host driver 3.03.04
[  119.596065] Fusion MPT misc device (ioctl) driver 3.03.04
[  119.619025] mptctl: Registered with Fusion MPT base driver
[  119.642394] mptctl: /dev/mptctl @ (major,minor=10,220)
[  119.666435] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
[  119.690689] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 
(level, high) -> IRQ 20
[  119.716056] PCI: Setting latency timer of device 0000:00:02.2 to 64
[  119.716061] ehci_hcd 0000:00:02.2: EHCI Host Controller
[  119.741294] ehci_hcd 0000:00:02.2: debug port 1
[  119.766129] PCI: cache line size of 64 is not supported by device 
0000:00:02.2
[  119.766187] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus 
number 1
[  119.791799] ehci_hcd 0000:00:02.2: irq 20, io mem 0xe0005000
[  119.817600] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[  119.844138] hub 1-0:1.0: USB hub found
[  119.870593] hub 1-0:1.0: 6 ports detected
[  119.997462] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[  119.997835] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
[  120.025134] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 
(level, high) -> IRQ 21
[  120.053279] PCI: Setting latency timer of device 0000:00:02.0 to 64
[  120.053283] ohci_hcd 0000:00:02.0: OHCI Host Controller
[  120.081161] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus 
number 2
[  120.109126] ohci_hcd 0000:00:02.0: irq 21, io mem 0xe0003000
[  120.189210] hub 2-0:1.0: USB hub found
[  120.216954] hub 2-0:1.0: 3 ports detected
[  120.345277] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
[  120.372791] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 
(level, high) -> IRQ 22
[  120.400846] PCI: Setting latency timer of device 0000:00:02.1 to 64
[  120.400850] ohci_hcd 0000:00:02.1: OHCI Host Controller
[  120.428412] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus 
number 3
[  120.456708] ohci_hcd 0000:00:02.1: irq 22, io mem 0xe0004000
[  120.536699] hub 3-0:1.0: USB hub found
[  120.564187] hub 3-0:1.0: 3 ports detected
[  120.691441] USB Universal Host Controller Interface driver v2.3
[  120.719125] usbcore: registered new driver usblp
[  120.746503] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class 
driver
[  120.774538] Initializing USB Mass Storage driver...
[  120.802508] usbcore: registered new driver usb-storage
[  120.830479] USB Mass Storage support registered.
[  120.858452] usbcore: registered new driver usbhid
[  120.886474] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  120.915021] mice: PS/2 mouse device common for all mice
[  120.944028] NET: Registered protocol family 2
[  120.981004] IP route cache hash table entries: 4096 (order: 2, 16384 
bytes)
[  121.010636] TCP established hash table entries: 16384 (order: 4, 65536 
bytes)
[  121.040586] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[  121.070582] TCP: Hash tables configured (established 16384 bind 16384)
[  121.100531] TCP reno registered
[  121.130349] ip_conntrack version 2.4 (2047 buckets, 16376 max) - 212 
bytes per conntrack
[  121.169397] input: AT Translated Set 2 keyboard as /class/input/input0
[  121.216672] ip_tables: (C) 2000-2002 Netfilter core team
[  121.289499] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
[  121.322405] arp_tables: (C) 2002 David S. Miller
[  121.363396] TCP bic registered
[  121.395559] NET: Registered protocol family 1
[  121.427331] NET: Registered protocol family 17
[  121.458822] Using IPI Shortcut mode
[  121.712984] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[  121.911704] VFS: Mounted root (ext2 filesystem) readonly.
[  121.943686] Freeing unused kernel memory: 216k freed
[  126.713867] Adding 1188800k swap on /dev/hda3.  Priority:-1 extents:1 
across:1188800k
[  127.066247] radDIO: module license 'unspecified' taints kernel.
[  127.073618] RAD-DIO driver for NuDAQ PCI-7224 V1.0
[  127.073623] Developed for Miltope Corp. by Radical Systems, Inc.
[  127.073625] http://www.radicalsystems.com
[  127.073627] Copyright (c) 2004, Radical Systems, Inc.
[  127.073629] All rights reserved.
[  127.080370] Probing...
[  127.080391] ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  127.080402] Found Device:
[  127.080404] Name:     0000:01:06.0
[  127.080406] InitFlag: 0x7248
[  127.080407] BusNo:    0x1
[  127.080409] DevFunc:  0x30
[  127.080410] LCRBase:  0x7000
[  127.080412] BaseAddr: 0x7400
[  127.080413] IRQ No:   0x5
[  127.150593] sata_promise 0000:01:0a.0: version 1.03
[  127.150622] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  127.160906] ata5: SATA max UDMA/133 cmd 0xD086A200 ctl 0xD086A238 bmdma 
0x0 irq 19
[  127.160927] ata6: SATA max UDMA/133 cmd 0xD086A280 ctl 0xD086A2B8 bmdma 
0x0 irq 19
[  127.160949] ata7: SATA max UDMA/133 cmd 0xD086A300 ctl 0xD086A338 bmdma 
0x0 irq 19
[  127.160969] ata8: SATA max UDMA/133 cmd 0xD086A380 ctl 0xD086A3B8 bmdma 
0x0 irq 19
[  127.361569] ata5: no device found (phy stat 00000000)
[  127.361573] scsi7 : sata_promise
[  127.827258] ata6: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 
86:1801 87:4003 88:407f
[  127.827264] ata6: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA
[  127.827268] ata6(0): applying bridge limits
[  127.827417] ata6: dev 0 configured for UDMA/100
[  127.827420] scsi8 : sata_promise
[  128.034583] ata7: no device found (phy stat 00000000)
[  128.034587] scsi9 : sata_promise
[  128.241278] ata8: no device found (phy stat 00000000)
[  128.241283] scsi10 : sata_promise
[  128.248126]   Vendor: ATA       Model: ST3120023AS       Rev: 3.01
[  128.248136]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[  128.254990] SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
[  128.255009] SCSI device sdb: drive cache: write back
[  128.261823] SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
[  128.261841] SCSI device sdb: drive cache: write back
[  128.261845]  sdb: unknown partition table
[  128.276051] sd 8:0:0:0: Attached scsi disk sdb
[  128.289641] sd 8:0:0:0: Attached scsi generic sg2 type 0
[  128.710768] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.710985] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.711298] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.711519] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.761180] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.761219] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.761257] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  128.761284] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  129.363382] kjournald starting.  Commit interval 5 seconds
[  129.363459] EXT3 FS on hda1, internal journal
[  129.363465] EXT3-fs: mounted filesystem with ordered data mode.
[  141.165353] r8169: eth0: link down


------=_NextPart_000_3a87_3a44_5413--
