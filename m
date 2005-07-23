Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVGWTWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVGWTWS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVGWTWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:22:18 -0400
Received: from [81.92.212.1] ([81.92.212.1]:8975 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S261360AbVGWTWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:22:15 -0400
Subject: [BUG] Tulip for ULi M5263: No packets transmitted
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Content-Type: multipart/mixed; boundary="=-jsgurhOIa1qmdXg5aEBp"
Date: Sat, 23 Jul 2005 20:22:04 +0100
Message-Id: <1122146524.7275.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: smtp.zmail.pt, Sat, 23 Jul 2005 20:20:20 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jsgurhOIa1qmdXg5aEBp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,
the tulip driver isn't work out for my ULi M5263 network adapter.
The driver loads and the interface receives packets but it won't
transmit any. Running a packet capture on it shows no outbound packets,
so I guess the driver thinks the card is screwed up and can't transmit.

I have a 939 AX8-M Motherboard with integrated ULi M5263 network adapter
and the kernel version is 2.6.12.3.
Another person with the same motherboard and problem was able to get the
adapter running with ULi's GPL driver for 2.6.8 (haven't tryed that yet)
but since the kernel driver's code explitly refers the M5262/3, I guess
it's supposed to be supported.

On dmesg, the following messages apear when the driver is loaded:
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip0:  Index #1 - Media 10baseT (#0) described by a <unknown> (128)
block.
tulip0:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.
tulip0:  Index #3 - Media 10base2 (#1) described by a 21140 non-MII (0)
block.
tulip0:  Index #4 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.
tulip0:  Index #5 - Media 100baseTx-FDX (#5) described by a 21140
non-MII (0) block.
tulip0:  MII transceiver #31 config 0000 status 7849 advertising 01e1.

When the interface is configured, the following message apears in dmesg:
eth0:  Invalid media table selection 128.

A full copy of dmesg is attached. 
Thanks for your attention.

-- 
        Ricardo

--=-jsgurhOIa1qmdXg5aEBp
Content-Disposition: attachment; filename=dmesg-2.6.12.3.txt
Content-Type: text/plain; name=dmesg-2.6.12.3.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.12.3 (raxx7@ezquiel) (gcc version 3.3.6 (Debian 1:3.3.6-7)) #1 Sun Jul 17 23:26:55 WEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e50
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000510 MSFT 0x00000097) @ 0x3ffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x05000510 MSFT 0x00000097) @ 0x3ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x05000510 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000510 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  939A8 939A8133 0x00000133 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bf7c0000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 single
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1799.791 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 903724k/917504k available (1533k kernel code, 13204k reserved, 719k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3579.90 BogoMIPS (lpj=1789952)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000010 00000001 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................
Table [DSDT](id F004) - 481 Objects with 47 Devices 152 Methods 10 Regions
ACPI Namespace successfully loaded at root c037d760
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 2568k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 3F [_GPE] 8 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.................................................................................................
Initialized 9/10 Regions 25/25 Fields 45/45 Buffers 18/19 Packages (490 nodes)
Executing all Device _STA and_INI methods:...................................................
51 Devices found containing: 51 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:02.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 *5 6 7 10 11 12 14 15)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1122147208.417:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
ACPI wakeup devices: 
 HTT PS2K PS2M UAR1 AC97 MC97  LAN USB0 USB1 USB2 UB20 
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2568KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0e.0
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALI15X3: chipset revision 199
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6B200P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
hdd: WDC WD200BB-00AUA1, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 398297088 sectors (203928 MB) w/8192KiB Cache, CHS=24792/255/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdd: max request size: 128KiB
hdd: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdd: cache flushes not supported
 hdd: hdd1 hdd2
SGI XFS with ACLs, security attributes, realtime, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
NET: Registered protocol family 10
Disabled Privacy Extensions on device c030b5a0(lo)
IPv6 over IPv4 tunneling driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
NET: Registered protocol family 8
NET: Registered protocol family 20
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Floppy drive(s): fd0 is 1.44M
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
i2c /dev entries driver
ali15x3_smbus 0000:00:03.1: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr
ali15x3_smbus 0000:00:03.1: ALI15X3 not detected, module not inserted.
acpi_processor-0484 [06] acpi_processor_get_inf: Error getting cpuindex for acpiid 0x2
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0xa (1300 mV)
cpu_init done, current fid 0xa, vid 0x6
ts: Compaq touchscreen protocol output
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem hdd2
Ending clean XFS mount for filesystem: hdd2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ali1563: SMBus control = 0403
ali1563_probe: Returning 0
ali1535_smbus 0000:00:03.1: ALI1535_smb region uninitialized - upgrade BIOS?
ali1535_smbus 0000:00:03.1: ALI1535 not detected, module not inserted.
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  Index #1 - Media 10baseT (#0) described by a <unknown> (128) block.
tulip0:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #3 - Media 10base2 (#1) described by a 21140 non-MII (0) block.
tulip0:  Index #4 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
tulip0:  Index #5 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
tulip0:  MII transceiver #31 config 0000 status 7849 advertising 01e1.
eth0: ULi M5261/M5263 rev 64 at f884cc00, 00:0B:6A:D1:FC:B9, IRQ 17.
SCSI subsystem initialized
libata version 1.11 loaded.
ACPI: PCI Interrupt 0000:00:0e.1[A] -> GSI 19 (level, low) -> IRQ 19
ata1: SATA max UDMA/133 cmd 0xF80 ctl 0xF02 bmdma 0xE000 irq 19
ata2: SATA max UDMA/133 cmd 0xE80 ctl 0xE02 bmdma 0xE008 irq 19
ata1: no device found (phy stat 00000000)
scsi0 : sata_uli
ata2: no device found (phy stat 00000000)
scsi1 : sata_uli
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.0: irq 20, io mem 0xfebfe000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:0f.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:0f.1: ALi Corporation USB 1.1 Controller (#2)
ohci_hcd 0000:00:0f.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0f.1: irq 21, io mem 0xfebfd000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:0f.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:0f.2: ALi Corporation USB 1.1 Controller (#3)
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:0f.2: irq 22, io mem 0xfebfc000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 2-1: new full speed USB device using ohci_hcd and address 2
speedtch: Unknown symbol udsl_put_instance
speedtch: Unknown symbol udsl_instance_disconnect
speedtch: Unknown symbol udsl_instance_setup
speedtch: Unknown symbol udsl_get_instance
ACPI: PCI Interrupt 0000:00:0f.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:0f.3: ALi Corporation USB 2.0 Controller
ehci_hcd 0000:00:0f.3: debug port 1
usbcore: registered new driver speedtch
ehci_hcd 0000:00:0f.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:0f.3: irq 23, io mem 0xfebff800
ehci_hcd 0000:00:0f.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 8 ports detected
usb 2-1: found stage 1 firmware speedtch-1.bin.4.00
usb 2-1: USB disconnect, address 2
 2-1: found stage 2 firmware speedtch-2.bin.4.00
usb 2-1: new full speed USB device using ohci_hcd and address 3
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 18
usb 2-1: found stage 1 firmware speedtch-1.bin.4.00
usb 2-1: found stage 2 firmware speedtch-2.bin.4.00
gameport: EMU10K1 is pci0000:02:06.1/gameport0, io 0xdc00, speed 1147kHz
USB Universal Host Controller Interface driver v2.2
eth0:  Invalid media table selection 128.
ADSL line is synchronising
eth0: no IPv6 routers present
ADSL line is up (2048 Kib/s down | 128 Kib/s up)
Disabled Privacy Extensions on device f6725400(tun6to4)

--=-jsgurhOIa1qmdXg5aEBp--

