Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVDXMvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVDXMvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVDXMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 08:51:46 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:223 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262324AbVDXMvV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 08:51:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qn2uWWnmHAXeBeHunZSIbjGue/OyNSJksANEWZdWqGbTud91draExs544eOWwd6fdHasknmIqrIYlqQODgfmluD70pWokCrft7awGrzsjvYGNzTYyy77CUa3bvafEIgsGutR2yL0WlWRY4Ye1M1hw2UuTDLCRSCTeDAiGJoUW3c=
Message-ID: <63f5296805042405516fe75d72@mail.gmail.com>
Date: Sun, 24 Apr 2005 14:51:21 +0200
From: Marcello Maggioni <hayarms@gmail.com>
Reply-To: Marcello Maggioni <hayarms@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sometimes the kernel misses my DVD recorder drive
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all :)

Sometimes happens that , at boottime, the kernel misses my HDC drive
that is a NEC 3500AG DVD+R9 recorder .

This happens more often when (before boot) there is a disc in it or in
the HDD drive (that is an LG GSA-4082B DVD-RAM recorder drive)

This is the message at boottime :

VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: MAXTOR 6L060J3, ATA DISK drive
hdb: QUANTUM FIREBALLP AS30.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
...

and the NEC drive is missed .

This happens on kernel 2.6.11.x and I haven't tried with other ones.

My system is Athlon 2400+ on ABit KV7 mobo (KT600) , the IDE channels
configuration is shown in the DMESG .

Here the complete DMESG message (when the HDC drive is probed correctly) :

Linux version 2.6.11 (root@melchior) (gcc version 3.4.3-20050110
(Gentoo Linux 3.4.3.20050110-r2, ssp-3.4.3.20050110-0, pie-8.7.7)) #3
Sat Apr 23 19:30:42 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
510MB LOWMEM available.
found SMP MP-table at 000f5d00
On node 0 totalpages: 130800
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126704 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 KT600                                 ) @ 0x000f77a0
ACPI: RSDT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fef3000
ACPI: FADT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fef3040
ACPI: MADT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fef7c00
ACPI: DSDT (v001 KT600  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 1ff00000 (gap: 1ff00000:ded00000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 video=vesafb:ywrap,pmipal,1024x768-16@85
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c039a000 soft=c0399000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2029.130 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515304k/523200k available (1765k kernel code, 7332k reserved,
716k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4014.08 BogoMIPS (lpj=2007040)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
0000000000000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
00000000 00000000 00000000
CPU: AMD Athlon(tm) XP stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaf50, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 *12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *11
ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
ACPI: PCI Interrupt Link [ALKD] (IRQs *23)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x5000-0x500f has been reserved
inotify device minor=63
Real Time Clock Driver v1.12
vesafb: NVidia Corporation, NV20 Board, Chip Rev A3 (OEM: NVidia)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:bbc0
vesafb: pmi: set display start = c00cbc05, set palette = c00cbc8a
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc
3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
vesafb: hardware supports DCC2 transfers
vesafb: monitor limits: vf = 160 Hz, hf = 92 kHz, clk = 160 MHz
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
Console: switching to colour frame buffer device 128x48
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 3072k,
total 65536k
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (45 C)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 169
eth0: VIA Rhine II at 0xe8002000, 00:50:8d:57:48:4a, IRQ 169.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 11, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 177
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: MAXTOR 6L060J3, ATA DISK drive
hdb: QUANTUM FIREBALLP AS30.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 117266688 sectors (60040 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 128KiB
hdb: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=58168/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 185
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 185, pci mem 0xe8001000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 185
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 185, io base 0xd000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 185
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller(#2)
uhci_hcd 0000:00:10.1: irq 185, io base 0xd400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 185
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller(#3)
uhci_hcd 0000:00:10.2: irq 185, io base 0xd800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 185
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller(#4)
uhci_hcd 0000:00:10.3: irq 185, io base 0xdc00
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (4087 buckets, 32696 max) - 212 bytes per conntrack
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
SLPB PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 LAN0
ACPI: (supports S0 S1 S4 S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18,max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 586332k swap on /dev/hda9.  Priority:-1 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first
block 18,max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first
block 18,max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first
block 18,max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with journal data mode.
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:11.5 to 64
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 128M @ 0xd0000000
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 209
eth1: RealTek RTL8139 at 0xe0f70000, 00:e0:7d:d5:0c:ed, IRQ 209
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1


Thanks

Bye

Marcello
