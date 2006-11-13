Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753734AbWKMJUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbWKMJUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbWKMJUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:20:10 -0500
Received: from agnus.ngi.it ([88.149.128.9]:16039 "EHLO agnus.ngi.it")
	by vger.kernel.org with ESMTP id S1753734AbWKMJUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:20:07 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
Date: Mon, 13 Nov 2006 10:17:38 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
References: <200611051536.35333.cova@ferrara.linux.it> <454F2E0F.3010804@gmail.com> <200611061418.07470.cova@ferrara.linux.it>
In-Reply-To: <200611061418.07470.cova@ferrara.linux.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611131017.51676.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 14:18, lunedì 6 novembre 2006, Fabio Coatti ha scritto:
> Alle 13:43, lunedì 6 novembre 2006, Tejun Heo ha scritto:
> > >> (320073 MB)
> > >> Nov  5 13:26:37 kefk sdc: Write Protect is off
> > >
> > > And why doesn't -mm report the same conflict?  I assume the .config is
> > > the same?
> >
> > Also, please post full dmesg of both kernels.

I've finally saved the dmesg from 2.6.19-rc5-mm1, the one that hangs at boot, 
not detecting two sata disks:

BIOS data check successful
Linux version 2.6.19-rc5-mm1 (root@kefk) (gcc version 4.1.1 (Gentoo 4.1.1-r1)) 
#2 SMP PREEMPT Sun Nov 12 20:17:00 CET 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 
000000000009f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 
00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000003fef0000 end: 
000000003fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000003fff0000 size: 0000000000003000 end: 
000000003fff3000 type: 4
copy_e820_map() start: 000000003fff3000 size: 000000000000d000 end: 
0000000040000000 type: 3
copy_e820_map() start: 00000000fec00000 size: 0000000001400000 end: 
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5cd0
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262128
early_node_map[1] active PFN ranges
    0:        0 ->   262128
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2806.502 MHz processor.
Built 1 zonelists.  Total pages: 260081
Kernel command line: BOOT_IMAGE=2.6.19-rc5-mm1s ro root=821 
console=ttyS0,38400
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Clock event device pit configured with caps set: 07
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034388k/1048512k available (2712k kernel code, 13556k reserved, 1300k 
data, 212k init, 131008k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc04f1000 - 0xc0526000   ( 212 kB)
      .data : 0xc03a63ef - 0xc04eb634   (1300 kB)
      .text : 0xc0100000 - 0xc03a63ef   (2712 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5615.03 BogoMIPS 
(lpj=2807516)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5611.95 BogoMIPS 
(lpj=2805977)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11226.98 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 2 CPUs
migration_cost=88
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbb20, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
Generic PHY: Registered new driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0b: ioport range 0x400-0x4bf could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f8000000-f9ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:03.0
  IO window: a000-afff
  MEM window: fc000000-fc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 8000-9fff
  MEM window: fa000000-fbffffff
  PREFETCH window: 50000000-500fffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
KEVENT subsystem has been successfully registered.
KEVENT: Added callbacks for type 2.
KEVENT: Added callbacks for type 3.
Kevent poll()/select() subsystem has been initialized.
KEVENT: Added callbacks for type 0.
highmem bounce pool size: 64 pages
JFS: nTxBlock = 8082, nTxLock = 64661
SGI XFS with ACLs, no debug enabled
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Transitioning device [FAN] to D3
ACPI: Transitioning device [FAN] to D3
ACPI: Fan [FAN] (off)
ACPI: Invalid passive threshold
ACPI: Thermal Zone [THRM] (55 C)
[drm] Initialized drm 1.1.0 20060810
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
LXT970: Registered new driver
LXT971: Registered new driver
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
hdc: TEAC DV-W58G, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 22 (level, low) -> IRQ 16
ahc_pci:3:6:0: Host Adapter Bios disabled.  Using default SCSI device 
parameters
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

scsi 0:0:2:0: Scanner           Nikon    COOLSCANIII      1.31 PQ: 0 ANSI: 2
 target0:0:2: Beginning Domain Validation
 target0:0:2: Ending Domain Validation
scsi 0:0:3:0: CD-ROM            PLEXTOR  CD-ROM PX-40TS   1.01 PQ: 0 ANSI: 2
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
scsi 0:0:2:0: Attached scsi generic sg0 type 6
sr 0:0:3:0: Attached scsi generic sg1 type 5
ata_piix 0000:00:1f.2: MAP [ P0 P1 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
ata_piix: probe of 0000:00:1f.2 failed with error -16
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 18
ata1: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A bmdma 0xF8804000 irq 18
ata2: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA bmdma 0xF8804008 irq 18
scsi1 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/100
scsi2 : sata_sil
ata2: SATA link down (SStatus 0 SControl 310)
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6V320F0   VA11 PQ: 0 ANSI: 5
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg2 type 0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.1 Nov 10 2006
EDAC i82875p: i82875p init one
EDAC MC0: Giving out device to i82875p_edac i82875p: DEV 0000:00:00.0
input: AT Translated Set 2 keyboard as /class/input/input0
TCP bic registered
TCP westwood registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Time: tsc clocksource has been installed.
logips2pp: Detected unknown logitech mouse model 127
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
VFS: Cannot open root device "821" or unknown-block(8,33)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(8,33)
 


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
