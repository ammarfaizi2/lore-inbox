Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUHGT2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUHGT2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUHGT2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:28:22 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:45709 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264278AbUHGT1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:27:41 -0400
Message-ID: <41152B61.90702@blue-labs.org>
Date: Sat, 07 Aug 2004 15:20:01 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: hda: dma_timer_expiry: dma status == 0x24
Content-Type: multipart/mixed;
 boundary="------------020303080803080004080605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020303080803080004080605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My desktop is experiencing issues with DMA lately.  This has been going 
on with the 2.6.8-rcX releases IIRC.  I'm currently on rc3.  The 
hardware is all brand new.

Scott ~ # hdparm -i /dev/hda

/dev/hda:

 Model=SAMSUNG SP1614N, FwRev=TM100-23, SerialNo=0642J1FW704776
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: (null):

Scott ~ # lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] 
Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800 South]
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:00:08.0 RAID bus controller: Promise Technology, Inc. PDC20378 
(FastTrak 378/SATA 378) (rev 02)
0000:00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875J 
(rev 04)
0000:00:0a.0 Ethernet controller: 3Com Corporation 3c940 
10/100/1000Base-T [Marvell] (rev 12)
0000:00:0c.0 Communication controller: Conexant HCF 56k Data/Fax Modem 
(rev 08)
0000:00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX 
(rev 20)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce 
FX 5200] (rev a1)


hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hdd: irq timeout: status=0x80 { Busy }
hdd: irq timeout: error=0x00
hdd: DMA disabled
hdd: ATAPI reset complete
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt




--------------020303080803080004080605
Content-Type: text/plain;
 name="dmesg.lastboot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.lastboot"

Bootdata ok (command line is root=/dev/hda3 console=ttyS0,115200n8 console=tty0 serial=0,115200n8 ro noexec=on)
Linux version 2.6.8-rc3 (root@Scott) (gcc version 3.4.1 (Gentoo Linux 3.4.1, ssp-3.4-2, pie-8.7.6.3)) #1 Tue Aug 3 19:44:16 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Looks like a VIA chipset. Disabling IOMMU. Overwrite with "iommu=allowed"
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x00000000000fa870
ACPI: XSDT (v001 A M I  OEMXSDT  0x09000323 MSFT 0x00000097) @ 0x000000001ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x09000323 MSFT 0x00000097) @ 0x000000001ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x09000323 MSFT 0x00000097) @ 0x000000001ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x09000323 MSFT 0x00000097) @ 0x000000001ff40040
ACPI: DSDT (v001  SK8V_ SK8V_013 0x00000013 MSFT 0x0100000d) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda3 console=ttyS0,115200n8 console=tty0 serial=0,115200n8 ro noexec=on
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2200.182 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 506728k/523456k available (4335k kernel code, 15988k reserved, 2255k data, 192k init)
Calibrating delay loop... 4308.99 BogoMIPS
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Opteron(tm) Processor 148 stepping 08
Using local APIC NMI watchdog using perfctr0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.501 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 169
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 177
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xc1 -> IRQ 20 Mode:1 Active:1)
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xd1 -> IRQ 22 Mode:1 Active:1)
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
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
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B9
 12 001 01  1    1    0   1   0    1    1    B1
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   1   0    1    1    C1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D1
 17 0F2 02  1    0    0   0   0    0    2    13
Using vector-based indexing
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
IRQ169 -> 0:16
IRQ185 -> 0:17
IRQ177 -> 0:18
IRQ193 -> 0:20
IRQ201 -> 0:21
IRQ209 -> 0:22
.................................... done.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
udf: registering filesystem
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 5 to 9
PCI: Via IRQ fixup for 0000:00:10.1, from 5 to 9
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 9
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 9
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
IOAPIC[0]: Set PCI routing entry (1-4 -> 0x49 -> IRQ 4 Mode:0 Active:0)
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 177
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 177
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xb000, 00:A0:CC:56:CB:FB, IRQ 177.
netconsole: not configured, aborting
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SP1614N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DRU-700A, ATAPI CD/DVD-ROM drive
hdd: 4X4X32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:09.0 to 64
sym0: <875> rev 0x4 at pci 0000:00:09.0 irq 169
sym0: Symbios NVRAM, ID 15, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCAN FOR LUNS disabled for targets 1.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: UMAX      Model: Astra 2400S       Rev: V1.1
  Type:   Scanner                            ANSI SCSI revision: 02
scsi(0:0:1:0): Beginning Domain Validation
scsi(0:0:1:0): Ending Domain Validation
3ware 9000 Storage Controller device driver for Linux v2.26.02.001.
libata version 1.02 loaded.
sata_promise version 1.00
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0xFFFFFF0000067200 ctl 0xFFFFFF0000067238 bmdma 0x0 irq 177
ata2: SATA max UDMA/133 cmd 0xFFFFFF0000067280 ctl 0xFFFFFF00000672B8 bmdma 0x0 irq 177
ata1: no device found (phy stat 00000000)
scsi1 : sata_promise
ata2: no device found (phy stat 00000000)
scsi2 : sata_promise
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193
sata_via(0000:00:0f.0): routed to hard irq line 11
ata3: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 193
ata4: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 193
ata3: no device found (phy stat 00000000)
scsi3 : sata_via
ata4: no device found (phy stat 00000000)
scsi4 : sata_via
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 6
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[169]  MMIO=[fde00000-fde007ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ieee1394: Loaded AMDTP driver
ieee1394: Loaded CMP driver
ehci_hcd: block sizes: qh 192 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh 7 uframes 256/512/1024
ehci_hcd 0000:00:10.4: capability 0001 at 68
ehci_hcd 0000:00:10.4: irq 201, pci mem ffffff00000a4000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:10.4: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:10.4: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: VIA Technologies, Inc. USB 2.0
usb usb1: Manufacturer: Linux 2.6.8-rc3 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.4
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS2T++ Logitech TouchPad 3 on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
ehci_hcd 0000:00:10.4: GetStatus port 1 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
hub 1-0:1.0: port 1 not reset yet, waiting 50ms
ehci_hcd 0000:00:10.4: port 1 full speed --> companion
ehci_hcd 0000:00:10.4: GetStatus port 1 status 003801 POWER OWNER sig=j  CONNECT
ehci_hcd 0000:00:10.4: GetStatus port 6 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
hub 1-0:1.0: port 6 not reset yet, waiting 50ms
ehci_hcd 0000:00:10.4: port 6 full speed --> companion
ehci_hcd 0000:00:10.4: GetStatus port 6 status 003001 POWER OWNER sig=se0  CONNECT
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800005eb58e]
Driver for 1-wire Dallas network protocol.
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
ALSA device list:
  #0: VIA 823x rev60 at 0xc800, irq 209
u32 classifier
    Perfomance counters on
    input device check on 
    Actions configured 
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP: Hash tables configured (established 32768 bind 4681)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
NET: Registered protocol family 4
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
SCTP: Hash tables configured (established 16384 bind 2340)
sctp_init_sock(sk: 000001001f9910a8)
powernow-k8: Power state transitions not supported
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 201, io base 000000000000b400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb2: Manufacturer: Linux 2.6.8-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
ehci_hcd 0000:00:10.4: GetStatus port 1 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
uhci_hcd 0000:00:10.1: irq 201, io base 000000000000b800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
usb usb3: Manufacturer: Linux 2.6.8-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:10.4: port 1 full speed --> companion
ehci_hcd 0000:00:10.4: GetStatus port 1 status 003801 POWER OWNER sig=j  CONNECT
ehci_hcd 0000:00:10.4: GetStatus port 6 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
uhci_hcd 0000:00:10.2: irq 201, io base 000000000000c000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: detected 2 ports
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
usb usb4: Manufacturer: Linux 2.6.8-rc3 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: irq 201, io base 000000000000c400
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: detected 2 ports
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: default language 0x0409
usb usb5: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
usb usb5: Manufacturer: Linux 2.6.8-rc3 uhci_hcd
usb usb5: SerialNumber: 0000:00:10.3
usb usb5: hotplug
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
hub 1-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
hub 1-0:1.0: port 6 not reset yet, waiting 50ms
ehci_hcd 0000:00:10.4: port 6 full speed --> companion
ehci_hcd 0000:00:10.4: GetStatus port 6 status 003001 POWER OWNER sig=se0  CONNECT
uhci_hcd 0000:00:10.0: port 1 portsc 009b
hub 2-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 2-1: new full speed USB device using address 2
usb 2-1: skipped 1 descriptor after interface
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
hub 2-1:1.0: usb_probe_interface
hub 2-1:1.0: usb_probe_interface - got id
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
hub 2-1:1.0: standalone hub
hub 2-1:1.0: individual port power switching
hub 2-1:1.0: individual port over-current protection
hub 2-1:1.0: power on to power good time: 100ms
hub 2-1:1.0: local power source is good
hub 2-1:1.0: enabling power on all ports
uhci_hcd 0000:00:10.0: port 2 portsc 018a
hub 2-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.1: port 1 portsc 018a
hub 3-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.1: port 2 portsc 008a
hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:10.2: port 1 portsc 018a
hub 4-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.2: port 2 portsc 009b
hub 4-0:1.0: port 2, status 0101, change 0003, 12 Mb/s
hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
usb 4-2: new full speed USB device using address 2
usb 4-2: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-2: default language 0x0409
usb 4-2: Product: EZ USB/Ethernet Converter
usb 4-2: Manufacturer: SMC, Inc
usb 4-2: SerialNumber: 0001
usb 4-2: hotplug
usb 4-2: adding 4-2:1.0 (config #1, interface 0)
usb 4-2:1.0: hotplug
uhci_hcd 0000:00:10.3: port 1 portsc 018a
hub 5-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
drivers/usb/net/pegasus.c: v0.5.12 (2003/06/06):Pegasus/Pegasus II USB Ethernet driver
pegasus 4-2:1.0: usb_probe_interface
pegasus 4-2:1.0: usb_probe_interface - got id
eth3: SMC 202 USB Ethernet
usbcore: registered new driver pegasus
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.3: port 2 portsc 018a
hub 5-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.1: suspend_hc
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 2-1:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 2-1:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
usb 2-1.1: new low speed USB device using address 3
usb 2-1.1: skipped 1 descriptor after interface
usb 2-1.1: new device strings: Mfr=3, Product=1, SerialNumber=2
usb 2-1.1: default language 0x0409
usb 2-1.1: Product: Back-UPS ES 350 FW:1.e2.D USB FW:e2
usb 2-1.1: Manufacturer: APC
usb 2-1.1: SerialNumber: AB0303246275  
usb 2-1.1: hotplug
usb 2-1.1: adding 2-1.1:1.0 (config #1, interface 0)
usb 2-1.1:1.0: hotplug
usbhid 2-1.1:1.0: usb_probe_interface
usbhid 2-1.1:1.0: usb_probe_interface - got id
uhci_hcd 0000:00:10.3: suspend_hc
drivers/usb/core/file.c: looking for a minor, starting at 0
hiddev0: USB HID v1.10 Device [APC Back-UPS ES 350 FW:1.e2.D USB FW:e2] on usb-0000:00:10.0-1.1
hub 2-1:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
hub 2-1:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
hub 2-1:1.0: port 2 not reset yet, waiting 10ms
usb 2-1.2: new low speed USB device using address 4
usb 2-1.2: skipped 1 descriptor after interface
usb 2-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1.2: default language 0x0409
usb 2-1.2: Product: USB Receiver
usb 2-1.2: Manufacturer: Logitech
usb 2-1.2: hotplug
usb 2-1.2: adding 2-1.2:1.0 (config #1, interface 0)
usb 2-1.2:1.0: hotplug
usbhid 2-1.2:1.0: usb_probe_interface
usbhid 2-1.2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1.2
hub 2-1:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 2-1:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
hub 2-1:1.0: port 3 not reset yet, waiting 10ms
usb 2-1.3: new full speed USB device using address 5
usb 2-1.3: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.3: hotplug
usb 2-1.3: adding 2-1.3:1.0 (config #1, interface 0)
usb 2-1.3:1.0: hotplug
usbcore: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
ov511 2-1.3:1.0: usb_probe_interface
ov511 2-1.3:1.0: usb_probe_interface - got id
drivers/usb/media/ov511.c: USB OV511 video device found
drivers/usb/media/ov511.c: model: AverMedia InterCam Elite
drivers/usb/media/ov511.c: Sensor is an OV7610
drivers/usb/media/ov511.c: Device at usb-0000:00:10.0-1.3 registered to minor 0
hub 2-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
hub 2-1:1.0: debounce: port 4: total 100ms stable 100ms status 0x101
hub 2-1:1.0: port 4 not reset yet, waiting 10ms
usb 2-1.4: new full speed USB device using address 6
usb 2-1.4: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 2-1.4: default language 0x0409
usb 2-1.4: Product: Camera
usb 2-1.4: hotplug
usb 2-1.4: adding 2-1.4:1.0 (config #1, interface 0)
usb 2-1.4:1.0: hotplug
Disabled Privacy Extensions on device ffffffff806da5c0(lo)
cable: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2044 buckets, 16352 max) - 480 bytes per conntrack
intranet: Setting full-duplex based on MII#1 link partner capability of 45e1.

--------------020303080803080004080605
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------020303080803080004080605--
