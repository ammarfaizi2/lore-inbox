Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161883AbWKJR05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161883AbWKJR05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 12:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWKJR05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 12:26:57 -0500
Received: from systemlinux.org ([83.151.29.59]:65236 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1161883AbWKJR04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 12:26:56 -0500
Date: Fri, 10 Nov 2006 18:26:32 +0100
From: Andre Noll <maan@systemlinux.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 2.6.19-rc5: Bad page state in process 'swapper'
Message-ID: <20061110172632.GG29040@skl-net.de>
References: <20061110121151.GC29040@skl-net.de> <20061110133633.GE29040@skl-net.de> <20061110161005.GF29040@skl-net.de> <200611101735.29828.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <200611101735.29828.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17:35, Andi Kleen wrote:

> If you apply the following debug patch you should get a shorter log.
> Can you post it please?

Yup. I think this contains what you're looking for. Patch was applied on
top of your first one if that matters.

Andre


Linux version 2.6.19-rc5-tt64-6-g088406bc-dirty (maan@congo) (gcc version 3=
=2E3.5 (Debian 1:3.3.5-13)) #47 SMP Fri Nov 10 18:04:24 CET 2006
Command line: vga=3Dnormal ip=3Ddhcp BOOT_IMAGE=3D2.6.19-rc5=20
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fbff0000 (usable)
 BIOS-e820: 00000000fbff0000 - 00000000fbfff000 (ACPI data)
 BIOS-e820: 00000000fbfff000 - 00000000fc000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 1032176) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2097152) 2 entries of 3200 used
end_pfn_map =3D 2097152
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f6b=
c0
ACPI: RSDT (v001 A M I  OEMRSDT  0x01000510 MSFT 0x00000097) @ 0x00000000fb=
ff0000
ACPI: FADT (v001 A M I  OEMFACP  0x01000510 MSFT 0x00000097) @ 0x00000000fb=
ff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x01000510 MSFT 0x00000097) @ 0x00000000fb=
ff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x01000510 MSFT 0x00000097) @ 0x00000000fb=
fff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x01000510 MSFT 0x00000097) @ 0x00000000fb=
ff34e0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x00000000fb=
ff35f0
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x0000000000=
000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-fc000000
Entering add_active_range(0, 256, 1032176) 0 entries of 3200 used
SRAT: Node 1 PXM 1 100000000-200000000
Entering add_active_range(1, 1048576, 2097152) 1 entries of 3200 used
SRAT: Node 0 PXM 0 0-fc000000
Entering add_active_range(0, 0, 159) 2 entries of 3200 used
Entering add_active_range(0, 256, 1032176) 3 entries of 3200 used
NUMA: Using 32 for the hash shift.
Bootmem setup node 0 0000000000000000-00000000fc000000
Bootmem setup node 1 0000000100000000-0000000200000000
Zone PFN ranges:
  DMA           256 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  2097152
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->  1032176
    1:  1048576 ->  2097152
On node 0 totalpages: 1031920
  DMA zone: 52 pages used for memmap
  DMA zone: 1953 pages reserved
  DMA zone: 1835 pages, LIFO batch:0
  DMA32 zone: 14055 pages used for memmap
  DMA32 zone: 1014025 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
On node 1 totalpages: 1048576
  DMA zone: 0 pages used for memmap
  DMA32 zone: 0 pages used for memmap
  Normal zone: 14336 pages used for memmap
  Normal zone: 1034240 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x5008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
IOAPIC[1]: apic_id 3, address 0xfebff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
IOAPIC[2]: apic_id 4, address 0xfebfe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 00000000fbff0000 - 00000000fbfff000
Nosave address range: 00000000fbfff000 - 00000000fc000000
Nosave address range: 00000000fc000000 - 00000000ff780000
Nosave address range: 00000000ff780000 - 0000000100000000
Allocating PCI resources starting at fc400000 (gap: fc000000:3780000)
PERCPU: Allocating 25728 bytes of per cpu data
Built 2 zonelists.  Total pages: 2050100
Kernel command line: vga=3Dnormal ip=3Ddhcp BOOT_IMAGE=3D2.6.19-rc5=20
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Checking aperture...
CPU 0: aperture @ f5cc000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Bad page state in process 'swapper'
page:ffff810003faf480 flags:0x0000000000000000 mapping:0000000000000000 map=
count:1 count:0
Trying to fix it up, but a reboot is needed
Backtrace:

Call Trace:
 [<ffffffff8014f171>] bad_page+0x71/0x9f
 [<ffffffff8014f652>] __free_pages_ok+0x78/0xf9
 [<ffffffff805cd843>] free_all_bootmem_core+0xce/0x1c2
 [<ffffffff805cad64>] numa_free_all_bootmem+0x39/0x78
 [<ffffffff805ca63c>] mem_init+0x59/0x16c
 [<ffffffff805bb75c>] start_kernel+0x165/0x1e7
 [<ffffffff805bb195>] x86_64_start_kernel+0x12b/0x130

Memory: 8122880k/8388608k available (3184k kernel code, 199740k reserved, 1=
490k data, 2612k init)
Calibrating delay using timer specific routine.. 4784.73 BogoMIPS (lpj=3D95=
69474)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
Freeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12447577
Detected 12.447 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4780.06 BogoMIPS (lpj=3D95=
60127)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 250 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -8 cycles, maxerr 1201 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2389.928 MHz processor.
migration_cost=3D549
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:03:06.0
PCI: Firmware left 0000:03:08.0 e100 interrupts enabled, disabling
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
AMD768 RNG detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:06.0
  IO window: a000-bfff
  MEM window: fc900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
  IO window: 9000-9fff
  MEM window: fc600000-fc8fffff
  PREFETCH window: ff500000-ff5fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
microcode: CPU0 not a capable Intel processor
microcode: CPU1 not a capable Intel processor
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
ipmi message handler version 39.0
ipmi device interface
IPMI System Interface driver.
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver initialized
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4
Copyright (c) 1999-2006 Intel Corporation.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 18
eth0: 0000:03:08.0, 00:E0:81:2E:78:F7, IRQ 18.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xd0a6c714).
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
tg3.c:v3.68 (November 02, 2006)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 24
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 1=
0/100/1000BaseT Ethernet 00:e0:81:2e:79:26
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]=20
eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 25
eth2: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 1=
0/100/1000BaseT Ethernet 00:e0:81:2e:79:27
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]=20
eth2: dma_rwctrl[769f4000] dma_mask[64-bit]
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 24 (level, low) -> IRQ 24
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=3D7, PCI-X 67-100Mhz, 512=
 SCBs

scsi 0:0:0:0: Direct-Access     FUJITSU  MAT3073NP        0105 PQ: 0 ANSI: 3
 target0:0:0: asynchronous
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW PCO=
MP (6.25 ns, offset 127)
 target0:0:0: Ending Domain Validation
scsi 0:0:1:0: Direct-Access     FUJITSU  MAT3073NP        0105 PQ: 0 ANSI: 3
 target0:0:1: asynchronous
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous
 target0:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW PCO=
MP (6.25 ns, offset 127)
 target0:0:1: Ending Domain Validation
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 25 (level, low) -> IRQ 25
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=3D7, PCI-X 67-100Mhz, 512=
 SCBs

3ware Storage Controller device driver for Linux v1.26.02.001.
3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
SCSI device sda: 143638992 512-byte hdwr sectors (73543 MB)
sda: Write Protect is off
sda: Mode Sense: b3 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 143638992 512-byte hdwr sectors (73543 MB)
sda: Write Protect is off
sda: Mode Sense: b3 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 143638992 512-byte hdwr sectors (73543 MB)
sdb: Write Protect is off
sdb: Mode Sense: b3 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 143638992 512-byte hdwr sectors (73543 MB)
sdb: Write Protect is off
sdb: Mode Sense: b3 00 00 08
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 0:0:1:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
Fusion MPT base driver 3.04.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.02
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:00.0: OHCI Host Controller
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:03:00.0: irq 19, io mem 0xfeafc000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:00.1: OHCI Host Controller
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:03:00.1: irq 19, io mem 0xfeafd000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v3.0
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
/.amd_mnt/huangho/export/kwaid0/home/maan/scm/torvalds/linux-2.6/drivers/us=
b/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
md: raid0 personality registered for level 0
md: multipath personality registered for level -4
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
CCID: Registered CCID 3 (ccid3)
CCID: Registered CCID 2 (ccid2)
SCTP: Hash tables configured (established 65536 bind 65536)
powernow-k8: Found 2 AMD Opteron(tm) Processor 250 processors (version 2.00=
=2E00)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
PM: Writing back config space on device 0000:02:09.0 at offset b (was 16481=
4e4, writing 164414e4)
PM: Writing back config space on device 0000:02:09.0 at offset 3 (was 80400=
0, writing 804010)
PM: Writing back config space on device 0000:02:09.0 at offset 2 (was 20000=
00, writing 2000003)
PM: Writing back config space on device 0000:02:09.0 at offset 1 (was 2b000=
00, writing 2b00146)
PM: Writing back config space on device 0000:02:09.1 at offset b (was 16481=
4e4, writing 164414e4)
PM: Writing back config space on device 0000:02:09.1 at offset 3 (was 80400=
0, writing 804010)
PM: Writing back config space on device 0000:02:09.1 at offset 2 (was 20000=
00, writing 2000003)
PM: Writing back config space on device 0000:02:09.1 at offset 1 (was 2b000=
00, writing 2b00106)
Sending DHCP requests .<6>tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
=2E, OK
IP-Config: Got DHCP answer from 192.168.1.254, my address is 192.168.1.120
PM: Writing back config space on device 0000:02:09.1 at offset b (was 16481=
4e4, writing 164414e4)
PM: Writing back config space on device 0000:02:09.1 at offset 3 (was 80400=
0, writing 804010)
PM: Writing back config space on device 0000:02:09.1 at offset 2 (was 20000=
00, writing 2000003)
PM: Writing back config space on device 0000:02:09.1 at offset 1 (was 2b000=
00, writing 2b00106)
IP-Config: Complete:
      device=3Deth1, addr=3D192.168.1.120, mask=3D255.255.0.0, gw=3D192.168=
=2E1.254,
     host=3Dnode120, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.1.254, rootserver=3D192.168.1.254, rootpath=3D
Freeing unused kernel memory: 2612k freed
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
md: md0 stopped.
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
md: bind<sda2>
md: bind<sdb2>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb2
raid0:   comparing sdb2(55038592) with sdb2(55038592)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(55038592) with sdb2(55038592)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 110077184 blocks.
raid0 : conf->hash_spacing is 110077184 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
md: md0 stopped.
md: unbind<sdb2>
md: export_rdev(sdb2)
md: unbind<sda2>
md: export_rdev(sda2)
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
program parted is using a deprecated SCSI ioctl, please convert it to SG_IO
md: bind<sda2>
md: bind<sdb2>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb2
raid0:   comparing sdb2(55038592) with sdb2(55038592)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(55038592) with sdb2(55038592)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 110077184 blocks.
raid0 : conf->hash_spacing is 110077184 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
Adding 16779852k swap on /dev/sda1.  Priority:42 extents:1 across:16779852k
Adding 16779852k swap on /dev/sdb1.  Priority:42 extents:1 across:16779852k
warning: process `sensors' used the removed sysctl system call with 7.2.1.
warning: process `sensors' used the removed sysctl system call with 7.2.1.
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFVLZIWto1QDEAkw8RAjSDAKCOOa6FTYuj/JcYZnKLHC8q/uaBHgCeOTNm
82q99Xwe6HNN1DIq/qivunc=
=jAlh
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
