Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSFHTpC>; Sat, 8 Jun 2002 15:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSFHTpB>; Sat, 8 Jun 2002 15:45:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53005
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317435AbSFHTon>; Sat, 8 Jun 2002 15:44:43 -0400
Date: Sat, 8 Jun 2002 12:42:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Matt Simonsen <matt_lists@careercast.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Another -pre
In-Reply-To: <1023146686.1373.18.camel@mattswork>
Message-ID: <Pine.LNX.4.10.10206081241580.1190-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well the HPT302 was not to have more than one channel so the code prevents
the second one from showing up :-/

On 3 Jun 2002, Matt Simonsen wrote:

> On the IDE fixes note, I am using a HighPoint card with the HPT302
> chipset - I can get the primary IDE channel to work perfectly, but the
> secondary doesn't show up. 
> 
> 
> Below is a DMESG:
> 
> Matt
> 
> 
> PS - I'm trying to be helpful and think this is the proper way to do it.
> Please let me know if I am mistaken or need to do something differently.
> 
> 
> 
> 
> Linux version 2.4.19-pre9-ac2 (root@mattswork) (gcc version 2.96
> 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Mon Jun 3 11:57:00 PDT
> 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
>  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fffd000 (usable)
>  BIOS-e820: 000000003fffd000 - 000000003ffff000 (ACPI data)
>  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000f6e50
> hm, page 000f6000 reserved twice.
> hm, page 000f7000 reserved twice.
> hm, page 000f6000 reserved twice.
> hm, page 000f7000 reserved twice.
> On node 0 totalpages: 262141
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 32765 pages.
> Intel MultiProcessor Specification v1.1
>     Virtual Wire compatibility mode.
> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
> Processor #1 Pentium(tm) Pro APIC version 17
> Processor #0 Pentium(tm) Pro APIC version 17
> I/O APIC #2 Version 17 at 0xFEC00000.
> Processors: 2
> Kernel command line: auto BOOT_IMAGE=linux-2.4.19p9 ro root=806
> BOOT_FILE=/boot/vmlinuz-2.4.19.pre9-ac hda=ide-scsi
> ide_setup: hda=ide-scsi
> Initializing CPU#0
> Detected 451.034 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 897.84 BogoMIPS
> Memory: 1030600k/1048564k available (1823k kernel code, 17576k reserved,
> 549k data, 288k init, 131060k highmem)
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
> Mount cache hash table entries: 16384 (order: 5, 131072 bytes)
> Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> CPU0: Intel Pentium III (Katmai) stepping 03
> per-CPU timeslice cutoff: 1461.42 usecs.
> task migration cache decay timeout: 10 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Booting processor 1/0 eip 2000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 901.12 BogoMIPS
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> Intel machine check reporting enabled on CPU#1.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> CPU1: Intel Pentium III (Katmai) stepping 03
> Total of 2 processors activated (1798.96 BogoMIPS).
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-13, 2-20, 2-21, 2-22,
> 2-23 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> number of MP IRQ sources: 15.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> 
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .... register #01: 00170011
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 003 03  0    0    0   0   0    1    1    39
>  02 003 03  0    0    0   0   0    1    1    31
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 003 03  0    0    0   0   0    1    1    51
>  07 003 03  0    0    0   0   0    1    1    59
>  08 003 03  0    0    0   0   0    1    1    61
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 003 03  0    0    0   0   0    1    1    69
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 003 03  0    0    0   0   0    1    1    71
>  0f 003 03  0    0    0   0   0    1    1    79
>  10 003 03  1    1    0   1   0    1    1    81
>  11 003 03  1    1    0   1   0    1    1    89
>  12 003 03  1    1    0   1   0    1    1    91
>  13 003 03  1    1    0   1   0    1    1    99
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:18
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:19
> IRQ10 -> 0:17
> IRQ11 -> 0:16
> IRQ12 -> 0:12
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 451.0322 MHz.
> ..... host bus clock speed is 100.2291 MHz.
> cpu: 0, clocks: 1002291, slice: 334097
> CPU0<T0:1002288,T1:668176,D:15,S:334097,C:1002291>
> cpu: 1, clocks: 1002291, slice: 334097
> CPU1<T0:1002288,T1:334080,D:14,S:334097,C:1002291>
> checking TSC synchronization across CPUs: passed.
> migration_task 0 on cpu=0
> migration_task 1 on cpu=1
> PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
> Limiting direct PCI/PCI transfers.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> allocated 32 pages and 32 bhs reserved for the highmem bounces
> Journalled Block Device driver loaded
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> block: 1024 slots per queue, batch=256
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 21
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> HPT302: IDE controller on PCI bus 00 dev 60
> HPT302: chipset revision 1
> HPT302: not 100% native mode: will probe irqs later
> HPT37X: using 33MHz PCI clock
>     ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:DMA, hdf:pio
> hda: Hewlett-Packard CD-Writer Plus 8100, ATAPI CD/DVD-ROM drive
> hde: WDC WD400BB-00CFC0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide2 at 0xb000-0xb007,0xa802 on irq 11
> hde: host protected area => 1
> hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
> UDMA(100)
> Partition check:
>  hde: [PTBL] [4865/255/63] hde1
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> Linux Tulip driver version 0.9.15-pre11 (May 11, 2002)
> eth0: Macronix 98715 PMAC rev 32 at 0xd000, 00:80:C6:F7:82:05, IRQ 9.
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: Detected Intel 440BX chipset
> agpgart: AGP aperture is 64M @ 0xe4000000
> [drm] Initialized tdfx 1.0.0 20010216 on minor 0
> [drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
> [drm] Initialized radeon 1.1.1 20010405 on minor 1
> SCSI subsystem driver Revision: 1.00
> scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
> scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
> scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host
> Adapter
> scsi0:   Firmware Version: 5.06I, I/O Address: 0xB400, IRQ Channel:
> 10/Level
> scsi0:   PCI Bus: 0, Device: 11, Address: 0xDE800000, Host Adapter SCSI
> ID: 7
> scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
> scsi0:   Synchronous Negotiation: Ultra, Wide Negotiation: Enabled
> scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
> scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
> scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
> scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
> scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
> scsi0:   SCSI Bus Termination: Both Enabled, SCAM: Enabled, Level 1
> scsi0: *** BusLogic BT-958 Initialized Successfully ***
> scsi0 : BusLogic BT-958
>   Vendor: SEAGATE   Model: ST318451LW        Rev: 0003
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>   Vendor: SEAGATE   Model: ST39103LW         Rev: 0001
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi0: Target 0: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset
> 15
> scsi0: Target 14: Queue Depth 28, Wide Synchronous at 40.0 MB/sec,
> offset 15
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
>         <Adaptec 2902/04/10/15/20/30C SCSI adapter>
>         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
> 
>   Vendor: SEAGATE   Model: DAT    06240-XXX  Rev: 8110
>   Type:   Sequential-Access                  ANSI SCSI revision: 03
> (scsi1:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
> scsi2 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: HP        Model: CD-Writer+ 8100   Rev: 1.0g
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g
> segs 16
> Attached scsi tape st0 at scsi1, channel 0, id 4, lun 0
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi disk sdb at scsi0, channel 0, id 14, lun 0
> SCSI device sda: 35843671 512-byte hdwr sectors (18352 MB)
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
> SCSI device sdb: 17783240 512-byte hdwr sectors (9105 MB)
>  sdb: sdb1 sdb2
> Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.12
> usb.c: registered new driver hub
> uhci.c: USB Universal Host Controller Interface driver v1.1
> uhci.c: USB UHCI at I/O 0xd400, IRQ 9
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb.c: registered new driver hid
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> mice: PS/2 mouse device common for all mice
> md: raid0 personality registered as nr 2
> md: raid1 personality registered as nr 3
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 288k freed
> scsi0: Tagged Queuing now active for Target 0
> Adding Swap: 2048248k swap-space (priority -1)
> 
> On Mon, 2002-06-03 at 17:15, Alan Cox wrote:
> > On Mon, 2002-06-03 at 15:55, Marcelo Tosatti wrote:
> > > On Mon, 3 Jun 2002, Pawel Kot wrote:
> > > 
> > > > On Mon, 3 Jun 2002, Marcelo Tosatti wrote:
> > > >
> > > > > Due to some missing network fixes and -ac merge, I'll release another -pre
> > > > > later today.
> > > > >
> > > > > -rc should be out by the end of the week.
> > > >
> > > > Would you please consider merging some IDE updates before releasing
> > > > 2.4.19? Current version remains unusable for me.
> > > > See http://marc.theaimsgroup.com/?l=linux-kernel&m=102277249800423&w=2
> > > > and followers for more detailes.
> > > 
> > > Andre,
> > > 
> > > Have you looked into this problem ?
> > 
> > With the current code I've got these items on my list I class as
> > problematic.
> > 
> > 1 Weird corruption report with AMD chipset in PIO mode
> > 1 NULL pointer crash report on SiS chipset
> > 2 Intel 845G issues (PIO only, incorrect BIOS setup)
> > 1 set of requested Promise changes 
> > 
> > The 845G and Promise ones are present in both. The AMD one is utterly
> > weird and I'm still looking at the SiS one.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

