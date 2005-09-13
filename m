Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVIMOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVIMOXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVIMOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:23:04 -0400
Received: from ext-nj2ut-5.online-age.net ([64.14.54.234]:6769 "EHLO
	ext-nj2ut-5.online-age.net") by vger.kernel.org with ESMTP
	id S932332AbVIMOXC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:23:02 -0400
Date: Tue, 13 Sep 2005 09:22:51 -0500
From: Rich Coe <Richard.Coe@med.ge.com>
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.13.1 (and 2.6.13) missing Fusion mpt devices
Message-ID: <20050913092251.1bb0a871@godzilla>
Organization: CSE
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cannot boot with Fusion-mpt attached scsi
I think it's because of this:
> PCI: Cannot allocate resource region 3 of device 0000:02:05.0
> PCI: Cannot allocate resource region 1 of device 0000:02:05.1
> PCI: Cannot allocate resource region 3 of device 0000:02:05.1

I'm still trying to track down what the error means and how to fix it. 
Thanks.

-- 
Rich Coe		richard.coe@med.ge.com
General Electric Healthcare Technologies
Global Software Platforms, Computer Technology Team


Linux version 2.6.13.1 (coe@bones) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #2 SMP Tue Sep 13 08:15:58 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff5000 (usable)
 BIOS-e820: 000000007fff5000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0xf808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x03] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 3, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=smp13 ro root=/dev/sda2 selinux=0 apm=off acpi=on apic=on rhgb kdb=on console=ttyS0,38400n8 console=tty0
APIC Verbosity level on not recognised use apic=verbose or apic=debug<7>mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3200.625 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073256k/2097108k available (2255k kernel code, 22584k reserved, 938k data, 232k init, 1179604k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6406.64 BogoMIPS (lpj=12813280)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6400.71 BogoMIPS (lpj=12801430)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 6400.80 BogoMIPS (lpj=12801603)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 6400.87 BogoMIPS (lpj=12801740)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
Total of 4 processors activated (25609.02 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1222k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.20 entry at 0xeb153, last bus=64
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 3 of device 0000:02:05.0
PCI: Cannot allocate resource region 1 of device 0000:02:05.1
PCI: Cannot allocate resource region 3 of device 0000:02:05.1
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x400-0x41f has been reserved
pnp: 00:0b: ioport range 0x420-0x43f has been reserved
pnp: 00:0b: ioport range 0x440-0x45f has been reserved
pnp: 00:0b: ioport range 0x460-0x47f could not be reserved
pnp: 00:0b: ioport range 0x480-0x48f has been reserved
pnp: 00:0b: ioport range 0xf800-0xf81f could not be reserved
pnp: 00:0b: ioport range 0xf820-0xf83f has been reserved
pnp: 00:0b: ioport range 0xf840-0xf85f has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #1:100000@d0e00000 for 0000:02:05.1
PCI: Failed to allocate mem resource #3:100000@d0e00000 for 0000:02:05.1
PCI: Bridge: 0000:01:00.0
  IO window: 4000-4fff
  MEM window: d0c00000-d0dfffff
  PREFETCH window: 80000000-801fffff
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: 4000-4fff
  MEM window: d0300000-d0ffffff
  PREFETCH window: 80000000-801fffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: d1000000-d30fffff
  PREFETCH window: c0000000-d00fffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: d0100000-d02fffff
  PREFETCH window: 80200000-802fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1126602839.244:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: CPU2 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI: CPU3 (power states: C1[C1])
ACPI: Processor [CPU3] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x54e0-0x54e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x54e8-0x54ef, BIOS settings: hdc:DMA, hdd:pio
hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(44)
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
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 232k freed
SCSI subsystem initialized
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0x5810 ctl 0x582A bmdma 0x54F0 irq 177
ata2: SATA max UDMA/133 cmd 0x5818 ctl 0x582E bmdma 0x54F8 irq 177
ata1: SATA port has no device.
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
md: raid0 personality registered as nr 2
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
input: PS/2 Generic Mouse on isa0060/serio1
SGI XFS Quota Management subsystem
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Kernel panic - not syncing: Attempted to kill init!

