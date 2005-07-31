Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVGaNfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVGaNfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVGaNfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:35:55 -0400
Received: from hermes.domdv.de ([193.102.202.1]:49668 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261749AbVGaNfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:35:52 -0400
Message-ID: <42ECD3B2.1080409@domdv.de>
Date: Sun, 31 Jul 2005 15:35:46 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: 2.6.13-rc4-mm1
References: <20050731020552.72623ad4.akpm@osdl.org>
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------010200060403080305010505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200060403080305010505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/

Andrew,
the good news is I can access pcmcia devices with rc4-mm1 which I
couldn't with at least rc3-mm1 on my x86_64 laptop. There is at least
one more problem with yenta_socket. Please see the attached dmesg output
and look for:

Badness in __release_resource at kernel/resource.c:184

This happens when accessing pcmcia from an initrd to read keys from a
pcmcia flash disk and removing the pcmcia modules afterwards.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------010200060403080305010505
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Bootdata ok (command line is BOOT_IMAGE=2.6.13rc4mm hdb=none hdc=cdrom hdd=none elevator=cfq psmouse.rate=20 report_lost_ticks iommu=off root=/dev/ram0 init=/linuxrc rw)
Linux version 2.6.13-rc4-mm1-gringo (root@gringo) (gcc version 3.4.4) #1 PREEMPT Sun Jul 31 15:11:12 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
 BIOS-e820: 000000003ff70000 - 000000003ff7a000 (ACPI data)
 BIOS-e820: 000000003ff7a000 - 000000003ff80000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f6a60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000003ff73fde
ACPI: FADT (v002 AMDK8  PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x000000003ff79e56
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x000000003ff79eda
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000003ff79fb0
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 262000
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257904 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bffe0000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.13rc4mm hdb=none hdc=cdrom hdd=none elevator=cfq psmouse.rate=20 report_lost_ticks iommu=off root=/dev/ram0 init=/linuxrc rw
ide_setup: hdb=none
ide_setup: hdc=cdrom
ide_setup: hdd=none
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1801.073 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x50
time.c: Lost 3 timer tick(s)! rip start_kernel+0xfd/0x1f0)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1023708k/1048000k available (3160k kernel code, 23596k reserved, 1340k data, 176k init)
Calibrating delay using timer specific routine.. 3606.48 BogoMIPS (lpj=1803241)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
time.c: Lost 85 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
Using local APIC timer interrupts.
Detected 12.507 MHz APIC timer.
time.c: Lost 56 timer tick(s)! rip setup_boot_APIC_clock+0x112/0x120)
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *10, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *11, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 12 14 15) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: Embedded Controller [EC] (gpe 11)
time.c: Lost 7 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 7 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
time.c: Lost 8 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c1000000-c1ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
  IO window: 00002000-00002fff
  IO window: 00003000-00003fff
  PREFETCH window: 40000000-41ffffff
  MEM window: 42000000-43ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0b.1
  IO window: 00004000-00004fff
  IO window: 00005000-00005fff
  PREFETCH window: 44000000-45ffffff
  MEM window: 46000000-47ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Enabling device 0000:00:0b.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0b.1[B] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:0b.1 to 64
NET: Registered protocol family 23
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
pnp: 00:05: ioport range 0x600-0x60f has been reserved
pnp: 00:05: ioport range 0x1c0-0x1cf has been reserved
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0xfe10-0xfe11 could not be reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
time.c: Lost 7 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
ACPI: AC Adapter [AC] (on-line)
time.c: Lost 8 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1])
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
ACPI: Thermal Zone [THRS] (49 C)
time.c: Lost 18 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
time.c: Lost 17 timer tick(s)! rip acpi_os_write_port+0x1a/0x38)
ACPI: Thermal Zone [THRC] (58 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xd0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 22 (level, low) -> IRQ 18
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xffffc20000022400, 00:0a:e4:a2:b0:49, IRQ 18
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1c80-0x1c87, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c88-0x1c8f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard on isa0060/serio0
time.c: Lost 2 timer tick(s)! rip i8042_command+0x1b1/0x1f0)
hda: WDC WD800VE-00HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
time.c: Lost 2 timer tick(s)! rip release_console_sem+0x16f/0x210)
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-L532A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:0b.2[C] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[c0005800-c0005fff]  Max Packet=[2048]
usbmon: debugs is not available
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.3)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x2
RAMDISK: Compressed image found at block 0
VFS: Mounted root (minix filesystem).
Freeing unused kernel memory: 176k freed
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:00:0b.0 [1025:006e]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000811
ACPI: PCI Interrupt 0000:00:0b.1[B] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:00:0b.1 [1025:006e]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000810
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xd8000-0xdffff 0xe4000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae4045210338d]
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xd8000-0xdffff 0xe4000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x600fffff
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Probing IDE interface ide2...
hde: 16MB CTS, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 17
hde: max request size: 128KiB
hde: 32000 sectors (16 MB) w/4KiB Cache, CHS=500/2/32
hde: cache flushes not supported
 hde: hde1
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1
Badness in __release_resource at kernel/resource.c:184

Call Trace:<ffffffff80135dc0>{release_resource+64} <ffffffff88019fb4>{:yenta_socket:yenta_close+164}
       <ffffffff802773ec>{pci_device_remove+44} <ffffffff802e457b>{__device_release_driver+107}
       <ffffffff802e46e3>{driver_detach+195} <ffffffff802e4004>{bus_remove_driver+148}
       <ffffffff802e499d>{driver_unregister+13} <ffffffff80277242>{pci_unregister_driver+18}
       <ffffffff8014bb9f>{sys_delete_module+479} <ffffffff8010e329>{error_exit+0}
       <ffffffff8010da36>{system_call+126} 
ACPI: PCI interrupt for device 0000:00:0b.1 disabled
ACPI: PCI interrupt for device 0000:00:0b.0 disabled

--------------010200060403080305010505--
