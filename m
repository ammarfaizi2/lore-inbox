Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132115AbRASWcq>; Fri, 19 Jan 2001 17:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136706AbRASWcf>; Fri, 19 Jan 2001 17:32:35 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:31198 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132115AbRASWcY>; Fri, 19 Jan 2001 17:32:24 -0500
Message-ID: <3A68C053.8D7EC521@Home.net>
Date: Fri, 19 Jan 2001 17:31:47 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: 2.4.1-pre8: Wierd lockup with /proc based functions (?)
In-Reply-To: <3A67EE07.B136B34E@Home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can this be confirmed?

Shawn Starr wrote:

> Just a while ago, my system just started acting funny. I couldn't use w,
> top, ps, and then some of my X applications started to freeze too.
> I couldn't even kill those hung processes because they'd hang too. So
> When i tried to restart ctrl+alt+del, it did not kill the hung processes
> and i had to hard restart.
>
> I dont know what triggered it but here's my dmesg and motherboard
> information:
>
> Motherboard: AcerOPEN AP53/AX - Latest flash bios: R3.A0 (1997)
> RAM: 64MB EDO: Kingston, 60ns
> Chipset: 430HX
> Parallel port: SPP/ECP/EPP
> COM ports: 16C550
> AMI Bios
> RTC & Battery: Dallas DS12887A - Ds12B887 compatable
> (512KB?) Pipeline burst cache
>
> *NOTE: This Pentium 200Mhz oddly has USB support (disabled right now).
> It has first generation USB. 2 ports.
>
> Inspecting /boot/System.map
> Loaded 15061 symbols from /boot/System.map.
> Symbols match kernel version 2.4.1.
> Error opening /dev/kmem
> Error adding kernel module table entry.
> Linux version 2.4.1-pre8 (root@coredump) (gcc version 2.95.2 19991024
> (release)) #1 Wed Jan 17 16:52:06 EST 2001)
> BIOS-provided physical RAM map:
> BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
> BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
> BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
> BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
> BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
> BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
> BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
> On node 0 totalpages: 16384
> zone(0): 4096 pages.
> zone(1): 12288 pages.
> zone(2): 0 pages.
> Kernel command line: BOOT_IMAGE=newlinux ro root=301 hdc=scsi
> ide_setup: hdc=scsi
> Initializing CPU#0
> Detected 199.433 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 398.13 BogoMIPS
> Memory: 61976k/65536k available (1122k kernel code, 3172k reserved, 400k
> data, 220k init, 0k highmem)
> Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
> CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
> Intel Pentium with F0 0F bug - workaround enabled.
> CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
> CPU: After generic, caps: 000001bf 00000000 00000000 00000000
> CPU: Common caps: 000001bf 00000000 00000000 00000000
> CPU: Intel Pentium 75 - 200 stepping 0c
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=0
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 0 of device 00:09.0
>    got res[10000000:10ffffff] for resource 0 of ATI Technologies Inc 3D
> Rage I/II 215GT [Mach64 GT]
> Limiting direct PCI/PCI transfers.
> Activating ISA DMA hang workarounds.
> isapnp: Scanning for Pnp cards...
> isapnp: Calling quirk for 01:00
> isapnp: SB audio device quirk - increasing port range
> isapnp: Calling quirk for 01:02
> isapnp: AWE32 quirk - adding two ports
> isapnp: Card 'Creative SB32 PnP'
> isapnp: 1 Plug & Play card detected total
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd v1.8
> parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
> parport0: cpp_daisy: aa5500ff(98)
> parport0: assign_addrs: aa5500ff(98)
> parport0: Printer, HEWLETT-PACKARD DESKJET
> pty: 256 Unix98 ptys configured
> lp0: using parport0 (polling).
> block: queued sectors max/low 41104kB/30828kB, 128 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PIIX3: IDE controller on PCI bus 00 dev 39
> PIIX3: chipset revision 0
> PIIX3: not 100%% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> hda: FUJITSU MPE3064AT, ATA DISK drive
> hdb: WDC AC32500H, ATA DISK drive
> hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=788/255/63, (U)DMA
> hdb: Disabling (U)DMA for WDC AC32500H
> hdb: 4999680 sectors (2560 MB) w/128KiB Cache, CHS=620/128/63
> ide-cd: passing drive hdc to ide-scsi emulation.
> Partition check:
>  hda: hda1 hda2
>  hdb: hdb1 hdb2
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10d
> 3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others.
> http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
> See Documentation/networking/vortex.txt
> eth0: 3Com PCI 3c900 Cyclone 10Mbps TPO at 0xe880,  00:50:da:80:b5:74,
> IRQ 9
>   product code 'WQ' rev 00.4 date 11-10-99
>   8K byte-wide RAM 5:3 Rx:Tx split, 10baseT interface.
>   Enabling bus-master transmits and whole-frame receives.
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0H
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
> sb: Creative SB32 PnP detected
> sb: ISAPnP reports 'Creative SB32 PnP' at i/o 0x220, irq 5, dma 1, 5
> <Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
> <Sound Blaster 16> at 0x330 irq 5 dma 0,0
> sb: 1 Soundblaster PnP card(s) found.
> ISAPnP reports AWE32 WaveTable at i/o 0x620
> <SoundBlaster EMU8000 (RAM0k)>
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 4096)
> ip_tables: (c)2000 Netfilter core team
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> reiserfs: checking transaction log (device 03:01) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 220k freed
> Adding Swap: 64252k swap-space (priority -1)
> eth0: using default media 10baseT
>
> Shawn.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
