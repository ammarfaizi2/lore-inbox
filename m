Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbSKDXsY>; Mon, 4 Nov 2002 18:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbSKDXsY>; Mon, 4 Nov 2002 18:48:24 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:5248 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262977AbSKDXsR>; Mon, 4 Nov 2002 18:48:17 -0500
Date: Tue, 5 Nov 2002 10:54:08 +1100
From: CaT <cat@zip.com.au>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021104235408.GA627@zip.com.au>
References: <20021104025458.GA3088@zip.com.au> <20021104161504.GA316@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104161504.GA316@neo.rr.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 04:15:04PM +0000, Adam Belay wrote:
> On Mon, Nov 04, 2002 at 01:54:59PM +1100, CaT wrote:
> Instead of adding your PnP BIOS to the black list, I may know a way to 
> support it completely even though it is broken.

Woo! :)

> To prove this idea could you please do the following:
> 
> 1.) apply patch 1 (attached below) to a clean kernel (2.5.45).  Compile the 
> kernel with PnP BIOS support and list the last few messages that start with 
> "pnp!!!:" before it panics.  You probably will want to have kernel debugging
> off so it doesn't scroll the messages off the screen.

This is all that I could get:

PNP!!!: Node number: 0xa EISA ID: PNP0c02
pnp: 00:0a: iport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: iport range 0x8000-0x803f has been reserved
pnp: 00:0a: iport range 0x2180-0x218f has been reserved
PNP!!!: Node number: 0xc EISA ID: PNP0c02
PNP!!!: Node number: 0xd EISA ID: PNP0c02
PNP!!!: Node number: 0xe EISA ID: PNP0700
PNP!!!: Node number: 0x10 EISA ID: PNP0400
general protection fault: 0040
...

> 2.) Apply patch 2 (attached below) to a clean kernel (2.5.45).  Compile the 
> kernel with PnP BIOS support.  It should start up completely without a panic.
> 
> This is not a complete fix however.  Anyway attach a copy of the output from 
> dmesg.

No worries.

Linux version 2.5.45 (root@theirongiant) (gcc version 2.95.4 20011002 (Debian prerelease)) #8 Tue Nov 5 10:43:27 EST 2002
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e5c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6ba0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00007) @ 0x0fff9dcb
ACPI: FADT (v001 GATEWA SOLO5300 01540.00007) @ 0x0ffffb8c
ACPI: DSDT (v001 GATEWA SOLO5300 01540.00007) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=l ro root=305 video=vesa:ywrap,mtrr
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 701.649 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1388.54 BogoMIPS
Memory: 255644k/262080k available (1883k kernel code, 5740k reserved, 797k data, 112k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
pnp: the driver 'system' has been registered
PCI: PCI BIOS revision 2.10 entry at 0xfd96e, last bus=1
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20021022
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:............................................................................................................
Table [DSDT] - 559 Objects with 50 Devices 108 Methods 27 Regions
ACPI Namespace successfully loaded at root c03f2a1c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:...........[ACPI Debug] String: MOON_2 Status
........[ACPI Debug] String: ISA_INI
[ACPI Debug] String: LPT Decode Enabled At Boot
[ACPI Debug] Integer: 0000000000000378
[ACPI Debug] String: COM1 Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F8
[ACPI Debug] String: FDC Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F0
[ACPI Debug] String: General-Purpose Decode #12 Enabled At Boot
[ACPI Debug] Integer: 000000000000FE00
[ACPI Debug] String: General-Purpose Decode #13 Enabled At Boot
[ACPI Debug] Integer: 0000000000000398
..........................
45 Devices found containing: 45 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:......................................................................................
Initialized 21/27 Regions 4/4 Fields 30/31 Buffers 31/35 Packages (559 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[ACPI Debug] String: MOON_2 Status
[ACPI Debug] String: MOON_2 Status
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.00 not present in PCI namespace
ACPI: Embedded Controller [EC0] (gpe 9)
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6b40
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x843d, dseg 0xf0000
PNP!!!: Node number: 0x0 EISA ID: PNP0c02
pnp: pnp: match found with the PnP device '00:00' and the driver 'system'
PNP!!!: Node number: 0x1 EISA ID: PNP0c01
pnp: pnp: match found with the PnP device '00:01' and the driver 'system'
PNP!!!: Node number: 0x2 EISA ID: PNP0200
PNP!!!: Node number: 0x3 EISA ID: PNP0000
PNP!!!: Node number: 0x4 EISA ID: PNP0100
PNP!!!: Node number: 0x5 EISA ID: PNP0b00
PNP!!!: Node number: 0x6 EISA ID: PNP0303
PNP!!!: Node number: 0x7 EISA ID: PNP0c04
PNP!!!: Node number: 0x8 EISA ID: PNP0800
PNP!!!: Node number: 0x9 EISA ID: PNP0a03
PNP!!!: Node number: 0xa EISA ID: PNP0c02
pnp: pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x2180-0x218f has been reserved
PNP!!!: Node number: 0xc EISA ID: PNP0c02
pnp: pnp: match found with the PnP device '00:0c' and the driver 'system'
PNP!!!: Node number: 0xd EISA ID: PNP0c02
pnp: pnp: match found with the PnP device '00:0d' and the driver 'system'
PNP!!!: Node number: 0xe EISA ID: PNP0700
PNP!!!: Node number: 0x10 EISA ID: PNP0400
PNP!!!: Node number: 0x13 EISA ID: PNP0f13
PNP!!!: Node number: 0x14 EISA ID: PNP0501
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Registering system device pic0
Registering system device rtc0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
slab: reap timer started for cpu 0
Starting kswapd
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Limiting direct PCI/PCI transfers.
evregion-0323: *** Error: Handler for [Embedded_control] returned AE_BAD_PARAMETER
 dswexec-0404 [16] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_BAD_PARAMETER
 acpi_ac-0091 [07] acpi_ac_get_state     : Error reading AC Adapter state
evregion-0323: *** Error: Handler for [Embedded_control] returned AE_BAD_PARAMETER
 dswexec-0404 [17] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_BAD_PARAMETER
evregion-0323: *** Error: Handler for [Embedded_control] returned AE_BAD_PARAMETER
 dswexec-0404 [17] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_BAD_PARAMETER
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 00:0d.1 (0000 -> 0003)
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (4445,211,32902,9233)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:14' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'parport_pc' has been registered
pnp: pnp: match found with the PnP device '00:10' and the driver 'parport_pc'
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
[c129e040] eventpoll: driver installed.
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xec000000
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1048-0x104f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK2016GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 39070080 sectors (20004 MB), CHS=2584/240/63, UDMA(33)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 > hda4
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:08.0 (0000 -> 0002)
PCI: Enabling device 00:08.1 (0000 -> 0002)
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
register interface 'event' with class 'input
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000006
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000006
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding 257000k swap on /dev/hda11.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100+ Mini PCI
  Mem:0xe8020000  IRQ:10  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

> If my theory is correct I will have a fix out soon.

Here's hoping. :)

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
