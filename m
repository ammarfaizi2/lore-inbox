Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270976AbTG1AJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTG1AIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:08:19 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:3712 "EHLO
	nevyn.them.org") by vger.kernel.org with ESMTP id S270976AbTG0X4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:56:19 -0400
Date: Sun, 27 Jul 2003 20:11:32 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PCI trouble with 2.6.0-test2
Message-ID: <20030728001132.GA827@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030727221610.GA763@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20030727221610.GA763@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 27, 2003 at 06:16:10PM -0400, Daniel Jacobowitz wrote:
> I can't say offhand what the last 2.5.x kernel to boot on this system was;
> it's been a while since I tried.  2.6.0-test2 definitely doesn't though. 
> The machine is a dual-Pentium3 using an Abit motherboard; nothing
> else particularly fancy.
> 
> Thanks to the wonders of serial console, here's the interesting parts of the
> boot log:

With ACPI disabled at the command line, it does boot, although the
aty128fb error is still there - and is making X have bizarre
striping.  I've attached logs with ACPI on and off in (with PCI
debugging on) in the hopes that someone has an idea.  Nothing jumps out
at me.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nevyn4-acpi.txt"

Linux version 2.6.0-test2-nevyn (root@nevyn) (gcc version 3.3.1 20030722 (Debian prerelease)) #1 SMP Sun Jul 27 18:47:27 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f5610
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIA694                     ) @ 0x000f6f60
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3040
ACPI: MADT (v001 VIA694          00000.00000) @ 0x3fff56c0
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/md0 video=aty128fb:1024x768-16@70 console=ttyS1,115200
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 998.352 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1966.08 BogoMIPS
Memory: 903388k/917504k available (2663k kernel code, 13340k reserved, 985k data, 240k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.97 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3960.83 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 998.0255 MHz.
..... host bus clock speed is 133.0100 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Initializing RT netlink socket
PCI: BIOS32 Service Directory structure at 0xc00faed0
PCI: BIOS32 Service Directory entry at 0xfb340
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address fixup for 0000:00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdbc0
00:09 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:0a slot=02 0:02/deb8 1:05/deb8 2:03/deb8 3:01/deb8
00:0b slot=03 0:02/deb8 1:01/deb8 2:05/deb8 3:03/deb8
00:0c slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:0d slot=05 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:0e slot=06 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:01 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:07 slot=00 0:00/deb8 1:00/deb8 2:03/deb8 3:05/deb8
PCI: Attempting to find IRQ router for 1106:0596
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: IRQ fixup
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI: Allocating resources
PCI: Resource d0000000-d3ffffff (f=1208, d=0, p=0)
PCI: Resource 00009000-0000900f (f=101, d=0, p=0)
PCI: Resource 00009400-0000941f (f=101, d=0, p=0)
PCI: Resource 00009800-0000981f (f=101, d=0, p=0)
PCI: Resource 00009c00-00009cff (f=101, d=0, p=0)
PCI: Resource d9044000-d9044fff (f=204, d=0, p=0)
PCI: Resource 0000a000-0000a0ff (f=101, d=0, p=0)
PCI: Resource d9045000-d90450ff (f=200, d=0, p=0)
PCI: Resource 0000a400-0000a4ff (f=101, d=0, p=0)
PCI: Resource d9046000-d90460ff (f=200, d=0, p=0)
PCI: Resource d9000000-d903ffff (f=200, d=0, p=0)
PCI: Resource 0000a800-0000a807 (f=101, d=0, p=0)
PCI: Resource 0000ac00-0000ac07 (f=101, d=0, p=0)
PCI: Resource d4000000-d7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000b000-0000b0ff (f=101, d=0, p=0)
PCI: Resource d9040000-d9043fff (f=200, d=0, p=0)
PCI: Resource 0000b400-0000b407 (f=101, d=0, p=0)
PCI: Resource 0000b800-0000b803 (f=101, d=0, p=0)
PCI: Resource 0000bc00-0000bc07 (f=101, d=0, p=0)
PCI: Resource 0000c000-0000c003 (f=101, d=0, p=0)
PCI: Resource 0000c400-0000c4ff (f=101, d=0, p=0)
PCI: Sorting device list...
aty128fb: Invalid ROM signature 0
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 RE (PCI) [chip rev 0x2] 16M 128-bit SDR SGRAM (1:1)
fb0: ATY Rage128 frame buffer device on Rage128 RE (PCI)
aty128fb: Rage128 MTRR set to ON
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xa000, 00:A0:CC:D6:AC:E1, IRQ 12.
tulip1:  EEPROM default media type 10baseT-FDX.
tulip1:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip1:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip1:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
tulip1:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
eth1: Macronix 98713 PMAC rev 0 at 0xa400, 00:40:33:A3:12:82, IRQ 12.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 92049U6, ATA DISK drive
hda: IRQ probe failed (0xfffffdba)
hdb: Hewlett-Packard DVD Writer 300, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD800BB-00CAA1, ATA DISK drive
hdc: IRQ probe failed (0xffffbdba)
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 0000:00:0e.0
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 10
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800BB-00CAA1, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 10
hdg: WDC WD800BB-00CAA1, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 10
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39882528 sectors (20420 MB) w/2048KiB Cache, CHS=39566/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 > p3
hdc: max request size: 128KiB
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 < p5 > p2
hde: max request size: 128KiB
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0:<4>hde: dma_timer_expiry: dma status == 0x24
hde: 0 bytes in FIFO
hde: DMA interrupt recovery
hde: lost interrupt
 p1 p2
hdg: max request size: 128KiB
hdg: lost interrupt
hdg: lost interrupt
hdg: lost interrupt
hdg: host protected area => 1
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0:<4>hdg: dma_timer_expiry: dma status == 0x24
hdg: 0 bytes in FIFO
hdg: DMA interrupt recovery
hdg: lost interrupt
 p1 p2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nevyn4-no-acpi.txt"

Linux version 2.6.0-test2-nevyn (root@nevyn) (gcc version 3.3.1 20030722 (Debian prerelease)) #1 SMP Sun Jul 27 18:47:27 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f5610
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: root=/dev/md0 video=aty128fb:1024x768-16@70 console=ttyS1,115200 acpi=off
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 998.506 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1966.08 BogoMIPS
Memory: 903388k/917504k available (2663k kernel code, 13340k reserved, 985k data, 240k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.72 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3960.83 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 998.0262 MHz.
..... host bus clock speed is 133.0101 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Initializing RT netlink socket
PCI: BIOS32 Service Directory structure at 0xc00faed0
PCI: BIOS32 Service Directory entry at 0xfb340
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Disabled via command line (acpi=off)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address fixup for 0000:00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdbc0
00:09 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:0a slot=02 0:02/deb8 1:05/deb8 2:03/deb8 3:01/deb8
00:0b slot=03 0:02/deb8 1:01/deb8 2:05/deb8 3:03/deb8
00:0c slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:0d slot=05 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:0e slot=06 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:01 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:07 slot=00 0:00/deb8 1:00/deb8 2:03/deb8 3:05/deb8
PCI: Attempting to find IRQ router for 1106:0596
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource d0000000-d3ffffff (f=1208, d=0, p=0)
PCI: Resource 00009000-0000900f (f=101, d=0, p=0)
PCI: Resource 00009400-0000941f (f=101, d=0, p=0)
PCI: Resource 00009800-0000981f (f=101, d=0, p=0)
PCI: Resource 00009c00-00009cff (f=101, d=0, p=0)
PCI: Resource d9044000-d9044fff (f=204, d=0, p=0)
PCI: Resource 0000a000-0000a0ff (f=101, d=0, p=0)
PCI: Resource d9045000-d90450ff (f=200, d=0, p=0)
PCI: Resource 0000a400-0000a4ff (f=101, d=0, p=0)
PCI: Resource d9046000-d90460ff (f=200, d=0, p=0)
PCI: Resource d9000000-d903ffff (f=200, d=0, p=0)
PCI: Resource 0000a800-0000a807 (f=101, d=0, p=0)
PCI: Resource 0000ac00-0000ac07 (f=101, d=0, p=0)
PCI: Resource d4000000-d7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000b000-0000b0ff (f=101, d=0, p=0)
PCI: Resource d9040000-d9043fff (f=200, d=0, p=0)
PCI: Resource 0000b400-0000b407 (f=101, d=0, p=0)
PCI: Resource 0000b800-0000b803 (f=101, d=0, p=0)
PCI: Resource 0000bc00-0000bc07 (f=101, d=0, p=0)
PCI: Resource 0000c000-0000c003 (f=101, d=0, p=0)
PCI: Resource 0000c400-0000c4ff (f=101, d=0, p=0)
PCI: Sorting device list...
aty128fb: Invalid ROM signature 0
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 RE (PCI) [chip rev 0x2] 16M 128-bit SDR SGRAM (1:1)
fb0: ATY Rage128 frame buffer device on Rage128 RE (PCI)
aty128fb: Rage128 MTRR set to ON
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xa000, 00:A0:CC:D6:AC:E1, IRQ 12.
tulip1:  EEPROM default media type 10baseT-FDX.
tulip1:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip1:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip1:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
tulip1:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
eth1: Macronix 98713 PMAC rev 0 at 0xa400, 00:40:33:A3:12:82, IRQ 12.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 92049U6, ATA DISK drive
hda: IRQ probe failed (0xffffffba)
hdb: Hewlett-Packard DVD Writer 300, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD800BB-00CAA1, ATA DISK drive
hdc: IRQ probe failed (0xffffbfba)
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 0000:00:0e.0
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 10
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800BB-00CAA1, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 10
hdg: WDC WD800BB-00CAA1, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 10
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39882528 sectors (20420 MB) w/2048KiB Cache, CHS=39566/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 > p3
hdc: max request size: 128KiB
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 < p5 > p2
hde: max request size: 128KiB
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: max request size: 128KiB
hdg: host protected area => 1
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1 p2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DDD6
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 24
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: DVD Writer 300n   Rev: 1.25
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 35860910 512-byte hdwr sectors (18361 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target2/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
Console: switching to colour frame buffer device 128x48
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: VIA Technologies, In USB
uhci-hcd 0000:00:07.2: irq 5, io base 00009400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:07.3: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:07.3: irq 5, io base 00009800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1824.000 MB/sec
   8regs_prefetch:  1464.000 MB/sec
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
   32regs    :   916.000 MB/sec
   32regs_prefetch:   876.000 MB/sec
   pIII_sse  :  1940.000 MB/sec
   pII_mmx   :  2476.000 MB/sec
   p5_mmx    :  2644.000 MB/sec
raid5: using function: pIII_sse (1940.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg2 ...
md:  adding hdg2 ...
md:  adding hde2 ...
md:  adding hdc2 ...
md: created md0
md: bind<hdc2>
md: bind<hde2>
md: bind<hdg2>
md: running: <hdg2><hde2><hdc2>
md0: setting max_sectors to 256, segment boundary to 65535
raid5: device hdg2 operational as raid disk 1
raid5: device hde2 operational as raid disk 2
raid5: device hdc2 operational as raid disk 0
raid5: allocated 3147kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hdc2
 disk 1, o:1, dev:hdg2
 disk 2, o:1, dev:hde2
md: ... autorun DONE.
hub 1-0:0: new USB device on port 1, assigned address 2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 240k freed
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:07.2-1
INIT: version 2.85 booting

--ew6BAiZeqk4r7MaW--
