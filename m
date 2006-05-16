Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWEPOwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWEPOwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEPOwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:52:00 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1037 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751151AbWEPOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:51:58 -0400
Message-ID: <4469E709.7080501@onelan.co.uk>
Date: Tue, 16 May 2006 15:51:53 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Dev <linux-kernel@vger.kernel.org>
Subject: broadcom 5752 in HP dc7600U works on 2.6.13 but does not working
 on 2.6.16
Content-Type: multipart/mixed;
 boundary="------------070707060206090308010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070707060206090308010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Under FC4's build of 2.6.13 the broadcom 5752 works well. But when the
I use the FC4 build of 2.6.16 it no long works.

The hardware is an HP dc7600U, P4 2.8GHz CPU, 512MB memory
SATA disk.

mii-tool correctly reports the state of the eth0. Removing and inserting the
cable is reported as expected. But DHCP or static IP configuration does not
work under 2.6.16.

In dmesg output on 2.6.16 I see this message:
ADDRCONF(NETDEV_UP): eth0: link is not ready

I have recompiled the 2.6.13 version of tg3.c for 2.6.16 and that does 
not fix
the problem.

Looking at /proc/interrupts I see that a lot of difference between .13 
and .16 kernels.
Is this related to the problem?

Attached are the output of dmesg and /proc/interrupts on 2.6.13 and 
2.6.16 kernels
as well as lspci output.

Barry


--------------070707060206090308010102
Content-Type: text/plain;
 name="dmesg-2.6.13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.13.txt"

Linux version 2.6.13-1.1526_FC4 (bhcompile@hs20-bc1-6.build.redhat.com) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 Wed Sep 28 19:15:10 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f7cf300 (usable)
 BIOS-e820: 000000001f7cf300 - 0000000020000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
503MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 128975
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124879 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.4 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000e8c10
ACPI: RSDT (v001 COMPAQ CPQ0968  0x20050518  0x00000000) @ 0x1f7df340
ACPI: FADT (v001 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df3ec
ACPI: MADT (v001 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df460
ACPI: ASF! (v032 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df4e4
ACPI: MCFG (v001 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df547
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf808
Allocating PCI resources starting at 20000000 (gap: 20000000:d0000000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 acpi=ht quiet
Initializing CPU#0
CPU 0 irqstacks, hard=c04e7000 soft=c04e6000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2793.550 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 504688k/515900k available (3084k kernel code, 10612k reserved, 704k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5592.94 BogoMIPS (lpj=11185890)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000080 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 1791k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.20 entry at 0xec51b, last bus=63
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/27b8] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1c.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1c.1
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:3f:00.0
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: e0500000-e07fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: e1000000-e31fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Found IRQ 10 for device 0000:00:1c.1
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:3f:00.0
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1147790248.720:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 54AD4C348BA3456
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pcie_portdrv_probe->Dev[27d0:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
PCI: Found IRQ 10 for device 0000:00:1c.1
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:3f:00.0
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1c.1
PCI: Sharing IRQ 10 with 0000:3f:00.0
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST GCR-8240N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 6, 458752 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 176k freed
SCSI subsystem initialized
libata version 1.12 loaded.
ata_piix version 1.04
PCI: Found IRQ 5 for device 0000:00:1f.2
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x10D8 ctl 0x10F2 bmdma 0x10B0 irq 5
ata2: SATA max UDMA/133 cmd 0x10E0 ctl 0x10F6 bmdma 0x10B8 irq 5
ata1: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4023 85:3069 86:3401 87:4023 88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
ATA: abnormal status 0x7F on port 0x10E7
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: ST380819AS        Rev: 3.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
FDC 0 is a post-1991 82077
tg3.c:v3.37 (August 25, 2005)
PCI: Found IRQ 10 for device 0000:3f:00.0
PCI: Sharing IRQ 10 with 0000:00:1c.1
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Setting latency timer of device 0000:3f:00.0 to 64
eth0: Tigon3 [partno(BCM95752) rev 6001 PHY(5752)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:14:c2:56:72:c9
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
PCI: Found IRQ 11 for device 0000:00:1b.0
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hw_random hardware driver 1.0.0 loaded
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001
Linux video capture interface: v1.00
cx88_dvb: Unknown symbol vp3054_i2c_remove
cx88_dvb: Unknown symbol nxt200x_attach
cx88_dvb: Unknown symbol zl10353_attach
cx88_dvb: Unknown symbol cx24123_attach
cx88_dvb: Unknown symbol vp3054_i2c_probe
cx8800: Unknown symbol v4l_compat_ioctl32
PCI: Found IRQ 5 for device 0000:00:1d.7
PCI: Sharing IRQ 5 with 0000:00:1d.0
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xe04c4000
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 5 for device 0000:00:1d.0
PCI: Sharing IRQ 5 with 0000:00:1d.7
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 5, io base 0x00001000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:05:09.0
PCI: Sharing IRQ 11 with 0000:05:09.2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001020
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1b.0
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001040
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.3
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 11, io base 0x00001060
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2097144k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
cx88_dvb: Unknown symbol vp3054_i2c_remove
cx88_dvb: Unknown symbol nxt200x_attach
cx88_dvb: Unknown symbol zl10353_attach
cx88_dvb: Unknown symbol cx24123_attach
cx88_dvb: Unknown symbol vp3054_i2c_probe
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0475600(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

--------------070707060206090308010102
Content-Type: text/plain;
 name="dmesg-2.6.16.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.16.txt"

Linux version 2.6.16-1.2096_FC4 (bhcompile@hs20-bc1-4.build.redhat.com) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Wed Apr 19 15:27:46 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f7cf300 (usable)
 BIOS-e820: 000000001f7cf300 - 0000000020000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
503MB LOWMEM available.
found SMP MP-table at 000fe700
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 128975
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 124879 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.4 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000e8c10
ACPI: RSDT (v001 COMPAQ CPQ0968  0x20050518  0x00000000) @ 0x1f7df340
ACPI: FADT (v001 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df3ec
ACPI: MADT (v001 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df460
ACPI: ASF! (v032 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df4e4
ACPI: MCFG (v001 COMPAQ LAKEPORT 0x00000001  0x00000000) @ 0x1f7df547
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID:              APIC at: 0xFEE00000
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 30000000 (gap: 20000000:d0000000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 acpi=ht quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c040a000 soft=c040b000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2793.649 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505692k/515900k available (2131k kernel code, 9720k reserved, 754k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5597.77 BogoMIPS (lpj=11195556)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 01
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=-1 pin1=-1 apic2=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
checking if image is initramfs... it is
Freeing initrd memory: 1756k freed
HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.20 entry at 0xec51b, last bus=63
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/27b8] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1b.0[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:1c.1[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:1d.3[D] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:1d.7[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:1f.2[B] -> IRQ 19
PCI: using PPB 0000:00:1c.1[A] to get irq 16
PCI->APIC IRQ transform: 0000:3f:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:05:09.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:05:09.2[A] -> IRQ 18
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: e0500000-e07fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: e1000000-e31fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1147789692.852:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key FD06BDCFDB15BAC1
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pcie_portdrv_probe->Dev[27d0:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST GCR-8240N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 200k freed
Write protecting the kernel read-only data: 346k
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x10D8 ctl 0x10F2 bmdma 0x10B0 irq 19
ata2: SATA max UDMA/133 cmd 0x10E0 ctl 0x10F6 bmdma 0x10B8 irq 19
ata1: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4023 85:3069 86:3401 87:4023 88:203f
ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0x10E7
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: ST380819AS        Rev: 3.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
FDC 0 is a post-1991 82077
tg3.c:v3.49 (Feb 2, 2006)
PCI: Setting latency timer of device 0000:3f:00.0 to 64
eth0: Tigon3 [partno(BCM95752) rev 6001 PHY(5752)] (PCI Express) 10/100/1000BaseT Ethernet 00:14:c2:56:72:c9
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hw_random hardware driver 1.0.0 loaded
Linux video capture interface: v1.00
cx2388x dvb driver version 0.0.5 loaded
CORE cx88[0]: subsystem: 17de:08a6, board: KWorld/VStream XPert DVB-T [card=14,autodetected]
TV tuner 4 at 0x1fe, Radio tuner -1 at 0x1fe
input: cx88 IR (KWorld/VStream XPert D as /class/input/input2
cx88[0]/2: found at 0000:05:09.2, rev: 5, irq: 18, latency: 32, mmio: 0xe2000000
cx88[0]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 0 (Zarlink MT352 DVB-T)...
cx2388x v4l2 driver version 0.0.5 loaded
cx88[0]/0: found at 0000:05:09.0, rev: 5, irq: 18, latency: 32, mmio: 0xe1000000
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
set_control id=0x980900 reg=0x310110 val=0x00 (mask 0xff)
set_control id=0x980901 reg=0x310110 val=0x3f00 (mask 0xff00)
set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
set_control id=0x980902 reg=0x310114 val=0x5a7f (mask 0xffff)
set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
set_control id=0x980906 reg=0x320598 val=0x40 (mask 0x7f) [shadowed]
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xe04c4000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 18, io base 0x00001020
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 21, io base 0x00001040
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 22, io base 0x00001060
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2097144k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2097144k
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver

--------------070707060206090308010102
Content-Type: text/plain;
 name="interrupts.2.6.13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts.2.6.13.txt"

           CPU0       
  0:      18405          XT-PIC  timer
  1:        123          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       2899          XT-PIC  libata, ehci_hcd:usb1, uhci_hcd:usb2
  8:          1          XT-PIC  rtc
 10:        130          XT-PIC  eth0
 11:         60          XT-PIC  HDA Intel, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 12:        102          XT-PIC  i8042
 14:        361          XT-PIC  ide0
NMI:          0 
ERR:          0

--------------070707060206090308010102
Content-Type: text/plain;
 name="interrupts.2.6.16.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts.2.6.16.txt"

           CPU0       
  0:      50458  local-APIC-edge  timer
  1:        124    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 12:        106    IO-APIC-edge  i8042
 14:        362    IO-APIC-edge  ide0
 16:          0   IO-APIC-level  eth0
 18:          0   IO-APIC-level  cx88[0], cx88[0], uhci_hcd:usb3
 19:       2961   IO-APIC-level  libata
 20:          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
 21:         99   IO-APIC-level  HDA Intel, uhci_hcd:usb4
 22:          0   IO-APIC-level  uhci_hcd:usb5
NMI:          0 
LOC:      50420 
ERR:          0
MIS:          0

--------------070707060206090308010102
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Integrated Graphics Controller (rev 02)
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01)
05:09.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder (rev 05)
05:09.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder [MPEG Port] (rev 05)
3f:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5752 Gigabit Ethernet PCI Express (rev 01)

--------------070707060206090308010102
Content-Type: text/plain;
 name="mii-tool.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mii-tool.txt"

eth0: negotiated 100baseTx-FD, link ok

--------------070707060206090308010102--
