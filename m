Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314511AbSD1VSu>; Sun, 28 Apr 2002 17:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314513AbSD1VSt>; Sun, 28 Apr 2002 17:18:49 -0400
Received: from [195.39.17.254] ([195.39.17.254]:47761 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314511AbSD1VSr>;
	Sun, 28 Apr 2002 17:18:47 -0400
Date: Sun, 28 Apr 2002 21:50:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <devel@brodo.de>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] 2.5.10+ acpi0419 breakage
Message-ID: <20020428215046.A275@elf.ucw.cz>
In-Reply-To: <20020428110630.GA702@elf.ucw.cz> <02042822313402.00870@sonnenschein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On athlon desktop:
> >
> > ....
> > ide: unexpected interrupt 1 15
> > ide1 at 0x170-0x177,0x376 on irq 15
> > ide: unexpected interrupt 0 14
> > ...
> > hcd.c: new USB bus registered, assigned bus number 1
> > [hang]
> >
> > acpi=off fixes it.
> IOAPIC enabled or present? Please wait for the next acpi-release, ACPI + 
> IOAPICs does not work at the moment. If not, please see comments for Toshiba 
> below:

I don't know. How can I find out if it has IOAPIC.

> > On toshiba notebook, boot is broken *only after cold boot*. I can boot
> > successfully from warm boot.
> Strange. Could you please send me a dmesg?

Linux version 2.5.10 (pavel@amd) (gcc version 2.95.4 20011002 (Debian prerelease)) #16 Sun Apr 28 21:07:45 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003fe0000 (usable)
 BIOS-e820: 0000000003fe0000 - 0000000003ff0000 (ACPI data)
 BIOS-e820: 0000000003ff0000 - 0000000004000000 (reserved)
 BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
 BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
 BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
63MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 16128
zone(0): 4096 pages.
zone(1): 12032 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 TOSHIB                     ) @ 0x000f0160
ACPI: RSDT (v001 TOSHIB 750      00151.02068) @ 0x03fe0000
ACPI: FADT (v001 TOSHIB 750      00151.02068) @ 0x03fe0054
Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, contact pavel@ucw.cz
Toshiba with broken S1 detected.
Kernel command line: auto BOOT_IMAGE=test root=301 ramdisk=0 except=setfont mem=63M
Initializing CPU#0
Detected 299.945 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 598.01 BogoMIPS
Memory: 60680k/64512k available (1690k kernel code, 3444k reserved, 635k data, 248k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0187f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0187f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
ACPI: Bus Driver revision 20020419
ACPI: Core Subsystem revision 20020419
PCI: PCI BIOS revision 2.10 entry at 0xfedcd, last bus=21
PCI: Using configuration type 1
 tbxface-0100 [04] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...................................................................................................................................................................................
179 Control Methods found and parsed (518 nodes total)
ACPI Namespace successfully loaded at root c039eb58
ACPI: Vendor "TOSHIB" System "4030    " Revision 0x19991112 has a known ACPI BIOS problem.
ACPI: Reason: Implicit Return. This is a recoverable error
evxfevnt-0076 [05] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:..  uteval-0430 [15] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [22] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [29] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [36] Ut_execute_STA        : No object was returned from _STA
..............  uteval-0430 [80] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [88] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [96] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [104] Ut_execute_STA        : No object was returned from _STA
.  uteval-0430 [112] Ut_execute_STA        : No object was returned from _STA
...  uteval-0430 [120] Ut_execute_STA        : No object was returned from _STA
....................
46 Devices found containing: 36 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:....................................
 Initialized 2/6 Regions 0/0 Fields 10/10 Buffers 24/24 Packages (518 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
Software suspend => we can do S4.ACPI: PCI Interrupt Link [LNKE]
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing hardware on bus (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
      00:00:02[A] -> \_SB_.LNKA[0]
      00:00:02[B] -> \_SB_.LNKB[0]
      00:00:0A[A] -> \_SB_.LNKC[0]
      00:00:04[A] -> \_SB_.LNKA[0]
      00:00:07[A] -> \_SB_.LNKE[0]
      00:00:09[A] -> \_SB_.LNKD[0]
      00:00:0C[A] -> \_SB_.LNKB[0]
      00:00:05[D] -> \_SB_.LNKD[0]
      00:00:06[A] -> \_SB_.LNKC[0]
      00:00:06[B] -> \_SB_.LNKD[0]
ACPI: Power Resource [PIHD] (on)
ACPI: Power Resource [PMHD] (on)
pci_root-0490 [280] acpi_pci_bind         : Device 00:00:02.00 not present in PCI namespace
pci_root-0490 [281] acpi_pci_bind         : Device 00:00:02.01 not present in PCI namespace
pci_root-0490 [282] acpi_pci_bind         : Device 00:00:09.00 not present in PCI namespace
pci_root-0490 [290] acpi_pci_bind         : Device 00:00:06.01 not present in PCI namespace
ACPI: Power Resource [PFAN] (off)
PCI: Probing PCI hardware
PCI: Bus (00:00) already probed
PCI: Using ACPI for IRQ routing
acpi_bus-0288 [296] acpi_bus_get_device   : Error getting context for object [c3eef698]
pci_root-0201 [295] acpi_pci_get_link_for_: Invalid IRQ router
acpi_bus-0288 [296] acpi_bus_get_device   : Error getting context for object [c3eee168]
pci_root-0201 [295] acpi_pci_get_link_for_: Invalid IRQ router
 rsutils-0153 [312] Rs_get_crs_method_data: No object was returned from _CRS
acpi_pci_link-0180 [310] acpi_pci_link_get_curr: Error evaluating _CRS
acpi_bus-0288 [311] acpi_bus_get_device   : Error getting context for object [c3eefd58]
pci_root-0201 [310] acpi_pci_get_link_for_: Invalid IRQ router
acpi_bus-0288 [311] acpi_bus_get_device   : Error getting context for object [c3eefa58]
pci_root-0201 [310] acpi_pci_get_link_for_: Invalid IRQ router
acpi_bus-0288 [311] acpi_bus_get_device   : Error getting context for object [c3eef698]
pci_root-0201 [310] acpi_pci_get_link_for_: Invalid IRQ router
acpi_bus-0288 [311] acpi_bus_get_device   : Error getting context for object [c3eee168]
pci_root-0201 [310] acpi_pci_get_link_for_: Invalid IRQ router
 rsutils-0153 [327] Rs_get_crs_method_data: No object was returned from _CRS
acpi_pci_link-0180 [325] acpi_pci_link_get_curr: Error evaluating _CRS
acpi_bus-0288 [326] acpi_bus_get_device   : Error getting context for object [c3eefd58]
pci_root-0201 [325] acpi_pci_get_link_for_: Invalid IRQ router
acpi_bus-0288 [326] acpi_bus_get_device   : Error getting context for object [c3eefa58]
pci_root-0201 [325] acpi_pci_get_link_for_: Invalid IRQ router
PCI: Cannot allocate resource region 4 of device 00:05.1
Limiting direct PCI/PCI transfers.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Coda Kernel/Venus communications, v5.3.15, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (69 C)
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Toshiba System Managment Mode driver v1.11 26/9/2001
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: 256 slots per queue, batch=32
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
loop: loaded (max 8 devices)
pcnet32.c:v1.28 04.03.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 27M
agpgart: no supported devices found.
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Intel Corp. 82371AB PIIX4 IDE: IDE controller on PCI slot 00:05.1
Intel Corp. 82371AB PIIX4 IDE: chipset revision 1
Intel Corp. 82371AB PIIX4 IDE: not 100% native mode: will probe irqs later
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:05.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DKLA-24320, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-1802D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
hda: 8452080 sectors (4327 MB) w/460KiB Cache, CHS=8944/15/63, UDMA(33)
ide: unexpected interrupt 1 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [526/255/63] hda1 hda2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: 
  Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 4,5,7,10 polling interval = 1000 ms
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.0 (504 buckets, 4032 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.48 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 248k freed
Unable to find swap-space signature
VFS: Disk change detected on device fd(2,0)
end_request: I/O error, dev 02:00, sector 0
cs: IO port probe 0x0310-0x0380: excluding 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x0d0000-0x0dffff: clean.
eth0: NE2000 Compatible: io 0x320, irq 5, hw_addr 00:80:C8:80:1E:1C


> > It says
> > ide: unexpected interrupt 1 15
> > Unable to handle NULL pointer dereference
> > EIP=somewhere in __ide_end_request. acpi=off does not fix this one.
> Could you please try the pciirq.9.acpi.diff or -even better- pciirq.12, 
> available at
> http://www.brodo.de/english/pub/acpi/pci_irq/
> 
> The assignation of non-dynamic IRQs is somewhat broken (by me :-( in 
> acpi-20020419, I suspect your systems are affected by that bug. Sorry for 
> that.

Will try if I have time.
									Pavel
-- 
When do you have heart between your knees?
