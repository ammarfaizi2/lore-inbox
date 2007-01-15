Return-Path: <linux-kernel-owner+w=401wt.eu-S1751489AbXAOW3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXAOW3Q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbXAOW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:29:16 -0500
Received: from mx.sileman.pl ([217.173.160.41]:32797 "EHLO mx.sileman.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbXAOW3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:29:14 -0500
From: "ris" <ris@elsat.net.pl>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High CPU usage with sata_nv
Date: Tue, 16 Jan 2007 00:28:43 +0200
Message-Id: <20070115222320.M55059@elsat.net.pl>
In-Reply-To: <20070115182642.GA18374@slug>
References: <20070115164541.M22367@elsat.net.pl> <20070115165432.M87238@elsat.net.pl> <20070115182642.GA18374@slug>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 217.173.173.29 (ris)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
X-SILEMAN-MailScanner-Information: Please contact the ISP for more information
X-SILEMAN-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SILEMAN-MCPCheck: MCP-Clean, MCP-Checker (score=-4.9, required 1,
	BAYES_00 -4.90)
X-SILEMAN-MailScanner-SpamCheck: not spam, SpamAssassin (timed out)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007 18:26:42 +0000, Frederik Deweerdt wrote
> On Mon, Jan 15, 2007 at 06:54:50PM +0200, ris wrote:
> > I have motherboard with nforce 590 SLI (MCP55) chipset.
> > On other systems all its ok.
> > 
> > But i tried a lot o kernels, configurations and always get cpu at 100% when
> > copying files.
> > I use SATA II samsung hard drive.
> > 
> Any dmesg complain? Could you send the hdparm -I <your drive> ?
> Regards,
> Frederik


Ok ....... 

hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       SAMSUNG SP2504C
        Serial Number:      S09QJ13LA07964
        Firmware Revision:  VT100-50
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 4a
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  488397168
        device size with M = 1024*1024:      238475 MBytes
        device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 1
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 udma7
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    Segmented DOWNLOAD_MICROCODE
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        88min for SECURITY ERASE UNIT. 88min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct

and dmesg....



Linux version 2.6.19-gentoo-r4 (root@redips) (gcc version 4.1.1 (Gentoo
4.1.1-r3)) #2 SMP Mon Jan 15 15:14:18 CET 2007
Command line: BOOT_IMAGE=Gentoo root=802
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 261856) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP (v002 Nvidia                                ) @ 0x00000000000f8040
ACPI: XSDT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee30c0
ACPI: FADT (v003 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feed200
ACPI: HPET (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000098) @ 0x000000003feed400
ACPI: MCFG (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feed480
ACPI: MADT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feed340
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x03000000) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 261856) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   261856
On node 0 totalpages: 261759
  DMA zone: 56 pages used for memmap
  DMA zone: 938 pages reserved
  DMA zone: 3005 pages, LIFO batch:0
  DMA32 zone: 3524 pages used for memmap
  DMA32 zone: 254236 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10de8201 base: 0xfefff000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 40000000 (gap: 3ff00000:b0100000)
PERCPU: Allocating 32000 bytes of per cpu data
Built 1 zonelists.  Total pages: 257241
Kernel command line: BOOT_IMAGE=Gentoo root=802
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ 6442000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 1027032k/1047424k available (2217k kernel code, 19760k reserved, 916k
data, 224k init)
Calibrating delay using timer specific routine.. 4826.56 BogoMIPS (lpj=2413284)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Freeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12559544
Detected 12.559 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4821.95 BogoMIPS (lpj=2410976)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 13 cycles, maxerr 590 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 25.000000 MHz WALL HPET GTOD HPET timer.
time.c: Detected 2411.430 MHz processor.
migration_cost=230
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000
PCI: No mmconfig possible on device 00:18
pci_get_subsys() called while pci_devices is still empty
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:0e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LMC1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LSA2] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AMC1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfefff000, IRQs 2, 8, 31
hpet0: 3 32-bit timers, 25000000 Hz
PCI-DMA: Disabling IOMMU.
pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:04.0
  IO window: a000-afff
  MEM window: fb000000-fdffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:12.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:16.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:17.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Setting latency timer of device 0000:00:12.0 to 64
PCI: Setting latency timer of device 0000:00:16.0 to 64
PCI: Setting latency timer of device 0000:00:17.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:12.0 to 64
pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:12.0:pcie00]
Allocate Port Service[0000:00:12.0:pcie03]
PCI: Setting latency timer of device 0000:00:16.0 to 64
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:16.0:pcie00]
Allocate Port Service[0000:00:16.0:pcie03]
PCI: Setting latency timer of device 0000:00:17.0 to 64
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:17.0:pcie00]
Allocate Port Service[0000:00:17.0:pcie03]
Real Time Clock Driver v1.12ac
hpet_resources: 0xfefff000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
sata_nv 0000:00:0d.0: version 3.2
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [APSI] -> GSI 23 (level, low) ->
IRQ 23
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 23
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 23
scsi0 : sata_nv
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 1
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x977
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0d.1[B] -> Link [APSJ] -> GSI 22 (level, low) ->
IRQ 22
PCI: Setting latency timer of device 0000:00:0d.1 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xCC00 irq 22
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xCC08 irq 22
scsi2 : sata_nv
ata3: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x9E7
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x967
ACPI: PCI Interrupt Link [ASA2] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0d.2[C] -> Link [ASA2] -> GSI 21 (level, low) ->
IRQ 21
PCI: Setting latency timer of device 0000:00:0d.2 to 64
ata5: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xB800 irq 21
ata6: SATA max UDMA/133 cmd 0xC000 ctl 0xBC02 bmdma 0xB808 irq 21
scsi4 : sata_nv
ata5: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC807
scsi5 : sata_nv
ata6: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC007
pata_amd 0000:00:0c.0: version 0.2.4
PCI: Setting latency timer of device 0000:00:0c.0 to 64
ata7: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF400 irq 14
ata8: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF408 irq 15
scsi6 : pata_amd
ATA: abnormal status 0x7F on port 0x1F7
ATA: abnormal status 0x7F on port 0x1F7
ata7.01: ATAPI, max UDMA/33
ata7.01: configured for UDMA/33
scsi7 : pata_amd
ata8: port disabled. ignoring.
ata8: reset failed, giving up
scsi 6:0:1:0: CD-ROM            LITE-ON  DVDRW SOHW-832S  CG5J PQ: 0 ANSI: 5
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ processors
(version 2.00.00)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 224k freed
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [APCL] -> GSI 20 (level, low) ->
IRQ 20
PCI: Setting latency timer of device 0000:00:0a.1 to 64
ehci_hcd 0000:00:0a.1: EHCI Host Controller
ehci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0a.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0a.1
ehci_hcd 0000:00:0a.1: irq 20, io mem 0xfe02e000
ehci_hcd 0000:00:0a.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCF] -> GSI 23 (level, low) ->
IRQ 23
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ohci_hcd 0000:00:0a.0: OHCI Host Controller
ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0a.0: irq 23, io mem 0xfe02f000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [APCH] -> GSI 22 (level, low) ->
IRQ 22
PCI: Setting latency timer of device 0000:00:10.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01043:8223 bound to 0000:00:10.0
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0e.1[B] -> Link [AAZA] -> GSI 21 (level, low) ->
IRQ 21
PCI: Setting latency timer of device 0000:00:0e.1 to 64
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 6:0:1:0: Attached scsi CD-ROM sr0
usb 2-1: new low speed USB device using ohci_hcd and address 2
hda_codec: Unknown model for AD1988, trying auto-probe from BIOS...
nvidia: module license 'NVIDIA' taints kernel.
usb 2-1: configuration #1 chosen from 1 choice
input: A4Tech PS/2+USB Mouse as /class/input/input0
input: USB HID v1.10 Mouse [A4Tech PS/2+USB Mouse] on usb-0000:00:0a.0-1
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level, low) ->
IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  1.0-9746  Fri Dec 15 10:19:35
PST 2006
usb 2-2: new low speed USB device using ohci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: MOSART Semi. Wireless Keyboard & Mouse as /class/input/input1
input: USB HID v1.10 Keyboard [MOSART Semi. Wireless Keyboard & Mouse] on
usb-0000:00:0a.0-2
input: MOSART Semi. Wireless Keyboard & Mouse as /class/input/input2
input,hiddev96: USB HID v1.10 Mouse [MOSART Semi. Wireless Keyboard & Mouse]
on usb-0000:00:0a.0-2
usb 2-4: new full speed USB device using ohci_hcd and address 4
usb 2-4: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0
proto 2 vid 0x03F0 pid 0x1504
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
NTFS driver 2.1.27 [Flags: R/O MODULE].
NTFS volume version 3.1.
Adding 995988k swap on /dev/sda8.  Priority:-1 extents:1 across:995988k
eth0: no IPv6 routers present



