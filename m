Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132121AbRDCCZC>; Mon, 2 Apr 2001 22:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132224AbRDCCYx>; Mon, 2 Apr 2001 22:24:53 -0400
Received: from mail.valinux.com ([198.186.202.175]:33036 "EHLO mail.valinux.com") by vger.kernel.org with ESMTP id <S132121AbRDCCYk>; Mon, 2 Apr 2001 22:24:40 -0400
Date: Mon, 2 Apr 2001 20:23:43 -0600
From: Don Dugger <n0ano@valinux.com>
To: xcp <xcp@brewt.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is pci=biosirq
Message-ID: <20010402202343.A8531@tlaloc.n0ano.com>
References: <Pine.LNX.4.30.0103311833040.8695-100000@stinky.brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0103311833040.8695-100000@stinky.brewt.org>; from xcp@brewt.org on Sat, Mar 31, 2001 at 06:37:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error message idicates that the MPS table doesn't provide interrupt
routing information for that PCI slot.  I ran into the same problem
on my K6 machine.  I was able to fix it in the BIOS.  In the BIOS setup
go to the `Advaned' page.  Look under `Installed O/S'.  It probably
says something silly like `Win95' or `Win98/Win2000'.  Change it to
`Other' and your problem should go away.

On Sat, Mar 31, 2001 at 06:37:41PM -0800, xcp wrote:
> I have an ALi chipset motherboard that seems to function normally.  K6-2
> 450, 256mb ram, 20gb ide fujitsu hard disk.  Every time I boot up I get
> this unsettling message about PCI: No IRQ known for interrupt pin A of
> device 00:0f.0. Please try using pci=biosirq.
> 
> It turns out that 00:0f.0 is my ALi ide controller:  00:0f.0 IDE
> interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
> 
> Is this normal, or what should I do to "fix" it?  Changing plug and play
> OS in the bios has no effect.
> 
> dmesg and lspci follow:
> 
> Linux version 2.4.3 (root@coffee) (gcc version 2.95.3 20010315 (release))
> #2 Sat Mar 31 17:50:50 PST 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
>  BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
>  BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> On node 0 totalpages: 65532
> zone(0): 4096 pages.
> zone(1): 61436 pages.
> zone(2): 0 pages.
> Kernel command line:
> Initializing CPU#0
> Detected 451.019 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 901.12 BogoMIPS
> Memory: 255860k/262128k available (826k kernel code, 5880k reserved, 271k
> data, 176k init, 0k highmem)
> Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
> CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
> CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
> CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
> CPU: Common caps: 008021bf 808029bf 00000000 00000002
> CPU: AMD-K6(tm) 3D processor stepping 0c
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: AMD K6
> PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd v1.8
> pty: 512 Unix98 ptys configured
> block: queued sectors max/low 170010kB/56670kB, 512 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 78
> PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using
> pci=biosirq.
> ALI15X3: chipset revision 193
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:pio
> hda: FUJITSU MPF3204AT, ATA DISK drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> hdc: RICOH CD-R/RW MP7040A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=2491/255/63, UDMA(33)
> Partition check:
>  hda: hda1 hda2 < hda5 hda6 > hda3 hda4
> Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> PPP generic driver version 2.4.1
> PPP Deflate Compression module registered
> PPP BSD Compression module registered
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> ip_tables: (c)2000 Netfilter core team
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> cryptoapi: Registered sha1 (0)
> cryptoapi: Registered rijndael-ecb (0)
> cryptoapi: Registered rijndael-cbc (65536)
> cryptoapi: Registered aes-ecb (0)
> cryptoapi: Registered aes-cbc (65536)
> cryptoapi: Registered blowfish-ecb (0)
> cryptoapi: Registered blowfish-cbc (65536)
> cryptoapi: Registered des-ecb (0)
> cryptoapi: Registered des-cbc (65536)
> cryptoapi: Registered des_ede3-ecb (0)
> cryptoapi: Registered des_ede3-cbc (65536)
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 176k freed
> Adding Swap: 128516k swap-space (priority -1)
> PCI: Found IRQ 3 for device 00:09.0
> 3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
> http://www.scyld.com/network/vortex.html
> See Documentation/networking/vortex.txt
> eth0: 3Com PCI 3c900 Boomerang 10baseT at 0xb800,  00:60:97:c7:a6:82, IRQ
> 3
>   product code 4843 rev 00.0 date 09-07-00
>   8K word-wide RAM 3:5 Rx:Tx split, autoselect/10baseT interface.
>   Enabling bus-master transmits and whole-frame receives.
> eth0: scatter/gather enabled. h/w checksums disabled
> Real Time Clock Driver v1.10d
> inserting floppy driver for 2.4.3
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> hdc: set_drive_speed_status: status=0x40 { DriveReady }
> hdc: ATAPI 20X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> usb.c: registered new driver hub
> PCI: Found IRQ 7 for device 00:02.0
> PCI: Setting latency timer of device 00:02.0 to 64
> usb-ohci.c: USB OHCI at membase 0xd084f000, IRQ 7
> usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> es1370: version v0.34 time 17:48:44 Mar 31 2001
> PCI: Found IRQ 10 for device 00:0a.0
> es1370: found adapter at io 0xb400 irq 10
> es1370: features: joystick on, line in, mic impedance 0
> gameport0: NS558 ISA at 0x200 size 8 speed 1125 kHz
> js0: Joystick device for input0
> event0: Event device for input0
> input0: Gravis Xterminator Digital on gameport0.0
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 203M
> agpgart: Detected Ali M1541 chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> [drm] AGP 0.99 on ALi M1541 @ 0xe0000000 64MB
> [drm] Initialized tdfx 1.0.0 20000928 on minor 63
> eth0: first available media type: 10baseT
> 
> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
> 00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
> 00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
> 00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
> [Aladdin IV] (rev c3)
> 00:09.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
> 00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
> 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
> 01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
> 01)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
