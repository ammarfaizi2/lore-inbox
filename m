Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVHIQON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVHIQON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVHIQON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:14:13 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:38064 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S964847AbVHIQOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:14:11 -0400
From: Mws <mws@twisted-brains.org>
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.13-rc6 Marvell/Yukon networking problems
Date: Tue, 9 Aug 2005 18:14:20 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1294785.ThaWMUlV6L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508091814.29876.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1294785.ThaWMUlV6L
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi there,

due to non supporting Marvell Network drivers for the=20
i have to use the syskonnect sk98lin driver from their homepage. even if th=
ese drivers are open-source they=20
were rejected by kernel net maintainers until now. there is a skge driver t=
hat is integrated into mainline kernel,=20
but that is not able to support this driver.

2.6.13 - rc 1 is fine and working properly.
since -rc2 i got problems with having a rejected irq 153.=20
problem still exists with latest rc6 kernel. complete vanilla except for th=
e sysconnect drivers.

anyone i can provide with infos of the adapters? even testing shouldn't be =
a problem at all.

regards
marcel


lspci output=20

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gig=
abit Ethernet Controller (rev 15)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet C=
ontroller (Asus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR+ <PERR-
        Latency: 0, cache line size 04
        Interrupt: pin A routed to IRQ 137
        Region 0: Memory at d7dfc000 (64-bit, non-prefetchable) [size=3D16K]
        Region 2: I/O ports at b800 [size=3D256]
        Expansion ROM at c0100000 [disabled] [size=3D128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] #10 [0011]

0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gig=
abit Ethernet Controller (rev 15)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet C=
ontroller (Asus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR+ <PERR-
        Latency: 0, cache line size 04
        Interrupt: pin A routed to IRQ 137
        Region 0: Memory at d7efc000 (64-bit, non-prefetchable) [size=3D16K]
        Region 2: I/O ports at c800 [size=3D256]
        Expansion ROM at c0000000 [disabled] [size=3D128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] #10 [0011]




Linux version 2.6.13-rc6 (root@myhost) (gcc version 3.4.4 (Gentoo 3.4.4, ss=
p-3.4.4-1.0, pie-8.7.8)) #1 SMP Tue Aug 9 13:56:55 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffb0000 (usable)
 BIOS-e820: 00000000bffb0000 - 00000000bffbe000 (ACPI data)
 BIOS-e820: 00000000bffbe000 - 00000000bfff0000 (ACPI NVS)
 BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 786352
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 556976 pages, LIFO batch:31
DMI 2.3 present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: Premium      APIC at: 0xFEE00000
Processor #0 15:3 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at c0000000 (gap: c0000000:3fb00000)
Built 1 zonelists
Kernel command line: root=3D/dev/hda3 vga=3D2 gentoo=3Dnodevfs
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3412.864 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x43
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3111836k/3145408k available (4417k kernel code, 32364k reserved, 17=
94k data, 216k init, 2227904k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6834.40 BogoMIPS (lpj=3D13=
668808)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000=
441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004=
41d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
Total of 1 processors activated (6834.40 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D5
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:05:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1b.0[A] -> IRQ 137
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 193
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 161
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:1d.3[D] -> IRQ 137
PCI->APIC IRQ transform: 0000:00:1d.7[A] -> IRQ 193
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:1f.2[B] -> IRQ 161
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 161
PCI->APIC IRQ transform: 0000:05:00.0[A] -> IRQ 137
PCI->APIC IRQ transform: 0000:03:00.0[A] -> IRQ 137
PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 137
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:01:03.0[A] -> IRQ 177
PCI->APIC IRQ transform: 0000:01:04.0[A] -> IRQ 193
PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 185
PCI->APIC IRQ transform: 0000:01:0a.0[A] -> IRQ 177
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: d7f00000-d7ffffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: c000-cfff
  MEM window: d7e00000-d7efffff
  PREFETCH window: c0000000-c00fffff
PCI: Bridge: 0000:00:1c.2
  IO window: b000-bfff
  MEM window: d7d00000-d7dfffff
  PREFETCH window: c0100000-c01fffff
PCI: Bridge: 0000:00:1e.0
  IO window: 9000-afff
  MEM window: d7c00000-d7cfffff
  PREFETCH window: c0200000-c02fffff
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: No IRQ known for interrupt pin C of device 0000:00:1c.2. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
SGI XFS with large block numbers, no debug enabled
Initializing Cryptographic API
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:01.0 to 64
pcie_portdrv_probe->Dev[2585:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pcie_portdrv_probe->Dev[2660:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:1c.1 to 64
pcie_portdrv_probe->Dev[2662:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
PCI: No IRQ known for interrupt pin C of device 0000:00:1c.2. Probably bugg=
y MP table.
PCI: Setting latency timer of device 0000:00:1c.2 to 64
pcie_portdrv_probe->Dev[2664:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: ST3160023A, ATA DISK drive
hdb: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
IT8212: IDE controller at PCI slot 0000:01:04.0
IT8212: chipset revision 19
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 193
    ide1: BM-DMA at 0x9800-0x9807, BIOS settings: hdc:pio, hdd:pio
    ide2: BM-DMA at 0x9808-0x980f, BIOS settings: hde:pio, hdf:pio
Probing IDE interface ide1...
Probing IDE interface ide2...
hde: ST380011A, ATA DISK drive
ide2 at 0x9c00-0x9c07,0x9882 on irq 193
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19457/255/63, UDM=
A(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hde: max request size: 1024KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D16383/255/63, UDMA=
(100)
hde: cache flushes supported
 hde: hde1 hde2 hde3
hdb: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
libata version 1.11 loaded.
ahci version 1.01
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA m=
ode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xF880ED00 ctl 0x0 bmdma 0x0 irq 161
ata2: SATA max UDMA/133 cmd 0xF880ED80 ctl 0x0 bmdma 0x0 irq 161
ata3: SATA max UDMA/133 cmd 0xF880EE00 ctl 0x0 bmdma 0x0 irq 161
ata4: SATA max UDMA/133 cmd 0xF880EE80 ctl 0x0 bmdma 0x0 irq 161
ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:=
007f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:=
007f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
007f
ata3: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
007f
ata4: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : ahci
  Vendor: ATA       Model: WDC WD1600JD-98H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD1600JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_sil version 0.9
ata5: SATA max UDMA/100 cmd 0xF8816880 ctl 0xF881688A bmdma 0xF8816800 irq =
185
ata6: SATA max UDMA/100 cmd 0xF88168C0 ctl 0xF88168CA bmdma 0xF8816808 irq =
185
ata7: SATA max UDMA/100 cmd 0xF8816A80 ctl 0xF8816A8A bmdma 0xF8816A00 irq =
185
ata8: SATA max UDMA/100 cmd 0xF8816AC0 ctl 0xF8816ACA bmdma 0xF8816A08 irq =
185
ata5: no device found (phy stat 00000000)
scsi4 : sata_sil
ata6: no device found (phy stat 00000000)
scsi5 : sata_sil
ata7: no device found (phy stat 00000000)
scsi6 : sata_sil
ata8: no device found (phy stat 00000000)
scsi7 : sata_sil
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[177]  MMIO=3D[d7cff000-d7cf=
f7ff]  Max Packet=3D[4096]
usbmon: debugs is not available
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 193, io mem 0xd7bff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.3
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 193, io base 0x00007880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 161, io base 0x00007c00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 153, io base 0x00008000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 137, io base 0x00008080
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 2-2: new full speed USB device using uhci_hcd and address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
I2O subsystem v1.288
i2o: max drivers =3D 8
I2O Configuration OSM v1.248
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
i2c /dev entries driver
i2c-sis96x version 1.0.0
input: AT Translated Set 2 keyboard on isa0060/serio0
usb 2-2.1: new full speed USB device using uhci_hcd and address 3
usb 2-2.1: not running at top speed; connect to a high speed hub
scsi8 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0180000aa3eef]
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
i2c_adapter i2c-0: detect fail: unknown manuf, 0xff
pc87360: PC8736x not detected, module not inserted.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:1=
3 2005 UTC).
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0xd7bf4000 irq 137
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/=
projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 4
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 216k freed
cdrom: open failed.
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0119
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sde at scsi8, channel 0, id 0, lun 0
Attached scsi generic sg4 at scsi8, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
ReiserFS: hde3: found reiserfs format "3.6" with standard journal
ReiserFS: hde3: using ordered data mode
ReiserFS: hde3: journal params: device hde3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde3: checking transaction log (hde3)
ReiserFS: hde3: Using r5 hash to sort names
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
ReiserFS: sdd1: found reiserfs format "3.6" with standard journal
ReiserFS: sdd1: using ordered data mode
ReiserFS: sdd1: journal params: device sdd1, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdd1: checking transaction log (sdd1)
ReiserFS: sdd1: Using r5 hash to sort names
XFS mounting filesystem sdd2
Ending clean XFS mount for filesystem: sdd2
XFS mounting filesystem sdd3
Ending clean XFS mount for filesystem: sdd3
irq 153: nobody cared (try booting with the "irqpoll" option)
 [<c013d60f>] __report_bad_irq+0x2a/0x8d
 [<c013ce84>] handle_IRQ_event+0x39/0x6d
 [<c013d72a>] note_interrupt+0x9e/0xf8
 [<c013cff4>] __do_IRQ+0x13c/0x148
 [<c010542d>] do_IRQ+0x19/0x24
 [<c010389a>] common_interrupt+0x1a/0x20
 [<c0100eec>] mwait_idle+0x25/0x4a
 [<c0100d77>] cpu_idle+0x5d/0x6b
 [<c07148f1>] start_kernel+0x157/0x170
 [<c071432e>] unknown_bootoption+0x0/0x1e0
handlers:
[<c0401d42>] (usb_hcd_irq+0x0/0x7a)
Disabling IRQ #153

--nextPart1294785.ThaWMUlV6L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+NZlPpA+SyJsko8RAlK+AKDyMhNrpHXNUlmlQUMXEHisNblrtQCdEfgc
nhPwvQQa/ihyqXykeE/n588=
=BN0O
-----END PGP SIGNATURE-----

--nextPart1294785.ThaWMUlV6L--
