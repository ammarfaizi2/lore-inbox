Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWDGQpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWDGQpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWDGQpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:45:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:62686 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964812AbWDGQpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:45:47 -0400
X-Authenticated: #342784
From: jensmh@gmx.de
To: Ashok Raj <ashok.raj@intel.com>
Subject: 2.6.16.1 lost cpu, was: 2.6.16-rc5 'lost' cpu
Date: Fri, 7 Apr 2006 18:45:36 +0200
User-Agent: KMail/1.9.1
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0603030954230.28074@montezuma.fsmlabs.com> <20060303103002.A26876@unix-os.sc.intel.com>
In-Reply-To: <20060303103002.A26876@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071845.38371.jensmh@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj writes:
> On Fri, Mar 03, 2006 at 09:54:34AM -0800, Zwane Mwaikambo wrote:
> > 
> >    > > Can you try sending dmesg output too?
> >    >
> >    >  here it is, but this time all 4 cpus are detected. Later I will try
> >    some reboots
> >    > and check if I can reproduce the problem.
> > 
> >    Thanks, i'll wait for those results.

so yesterday was the first time this occured again, now with 2.6.16.1

> Next time it happens, please send dmesg, and also 

Linux version 2.6.16.1 (root@voyager) (gcc version 3.4.6 (Gentoo Hardened 3.4.6, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP PREEMPT Thu Mar 30 08:50:19 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff75000 (usable)
 BIOS-e820: 000000007ff75000 - 000000007ff77000 (ACPI NVS)
 BIOS-e820: 000000007ff77000 - 000000007ff98000 (ACPI data)
 BIOS-e820: 000000007ff98000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 524149
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294773 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000febc0
ACPI: RSDT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd4d4
ACPI: FADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd50c
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xffff373d
ACPI: MADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd580
ACPI: BOOT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd604
ACPI: ASF! (v016 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd62c
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: udev root=/dev/ram0 init=/linuxrc real_root=/dev/hda7
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80800)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04b6000 soft=c04ae000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2792.132 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2072904k/2096596k available (2383k kernel code, 22436k reserved, 1148k data, 208k init, 1179092k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5588.73 BogoMIPS (lpj=2794366)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c04b7000 soft=c04af000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5581.16 BogoMIPS (lpj=2790581)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 2/6 eip 2000
CPU 2 irqstacks, hard=c04b8000 soft=c04b0000
Not responding.
Inquiring remote APIC #6...
... APIC #6 ID: failed
... APIC #6 VERSION: failed
... APIC #6 SPIV: failed
CPU #6 not responding - cannot use it.
Booting processor 2/7 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5581.37 BogoMIPS (lpj=2790687)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Total of 3 processors activated (16751.26 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 3 CPUs: passed.
Brought up 3 CPUs
migration_cost=1000,2000
checking if image is initramfs... it is
Freeing initrd memory: 745k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbdd5, last bus=5
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
pnp: 00:0b: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0b: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:02:1d.0
  IO window: e000-efff
  MEM window: fe300000-fe4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:1f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe100000-fe4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: f9000000-fbffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
nvidiafb: PCI id - 10de018a
nvidiafb: Actual id - 10de018a
nvidiafb: nVidia device/chipset 10DE018A
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog not found
nvidiafb: EDID found from BUS1
nvidiafb: CRTC 0 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 0
Panel size is 1600 x 1200
nvidiafb: MTRR set to ON
nvidiafb: Flat panel dithering disabled
Console: switching to colour frame buffer device 200x75
nvidiafb: PCI nVidia NV18 framebuffer (64MB @ 0xF0000000)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:KBD] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:03:0e.0[A] -> GSI 24 (level, low) -> IRQ 177
e1000: 0000:03:0e.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:0d:56:09:09:fb
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L120AVV207-1, ATA DISK drive
hdb: IC35L120AVV207-1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
hdd: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 234375000 sectors (120000 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
hdb: max request size: 512KiB
hdb: 234375000 sectors (120000 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 < hdb5 >
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:05:0c.0[A] -> GSI 20 (level, low) -> IRQ 193
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]  MMIO=[fbeff800-fbefffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 201, io mem 0xfe500800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 169, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 209, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-2: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O ProcFS OSM v1.316
i2c /dev entries driver
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Mar 30 2006
MC: error reporting device not found:vendor 8086 device 0x2551 (broken BIOS?)
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
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 208k freed
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0001a30000062f2d]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[86ffffffffffff00]
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
scsi0 : SBP-2 IEEE-1394
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: SAMSUNG   Model: SP1614N           Rev: 0.01
  Type:   Direct-Access                      ANSI SCSI revision: 00
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel E7505 Chipset.
agpgart: AGP aperture is 128M @ 0xe8000000
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 51048 usecs
intel8x0: clocking to 48000
cx2388x v4l2 driver version 0.0.5 loaded
ACPI: PCI Interrupt 0000:05:0e.0[A] -> GSI 22 (level, low) -> IRQ 225
CORE cx88[0]: subsystem: 153b:1166, board: Conexant DVB-T reference design [card=19,insmod option]
TV tuner 4 at 0x1fe, Radio tuner -1 at 0x1fe
cx88[0]/0: found at 0000:05:0e.0, rev: 5, irq: 225, latency: 64, mmio: 0xfa000000
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
set_control id=0x980900 reg=0x310110 val=0x00 (mask 0xff)
set_control id=0x980901 reg=0x310110 val=0x3f00 (mask 0xff00)
set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
set_control id=0x980902 reg=0x310114 val=0x5a7f (mask 0xffff)
set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
set_control id=0x980906 reg=0x320598 val=0x40 (mask 0x7f) [shadowed]
cx2388x dvb driver version 0.0.5 loaded
ACPI: PCI Interrupt 0000:05:0e.2[A] -> GSI 22 (level, low) -> IRQ 225
cx88[0]/2: found at 0000:05:0e.2, rev: 5, irq: 225, latency: 64, mmio: 0xf9000000
cx88[0]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 0 (Conexant CX22702 DVB-T)...
microcode: CPU1 updated from revision 0xf to 0x2d, date = 08112004 
microcode: CPU0 updated from revision 0xf to 0x2d, date = 08112004 
microcode: CPU2 updated from revision 0xf to 0x2d, date = 08112004 
Adding 987988k swap on /dev/mapper/swap1.  Priority:-1 extents:1 across:987988k
Adding 987988k swap on /dev/mapper/swap2.  Priority:-2 extents:1 across:987988k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex

> cat /proc/acpi/processor/*
voyager ~ # cat /proc/acpi/processor/*/*
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000]
<not supported>
processor id:            1
acpi id:                 3
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000]
<not supported>
processor id:            2
acpi id:                 4
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000]
<not supported>

> ls /sys/devices/system/cpu
voyager ~ # ls /sys/devices/system/cpu
cpu0  cpu1  cpu2

