Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVEURcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVEURcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 13:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVEURcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 13:32:47 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:25352 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261758AbVEURcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 13:32:25 -0400
Message-ID: <428F70AE.1050108@rainbow-software.org>
Date: Sat, 21 May 2005 19:32:30 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: Gregor Jasny <gjasny@web.de>, linux-kernel@vger.kernel.org
Subject: Re: What happened to Cyrix 6x86 support in 2.6?
References: <200505211625.56664.gjasny@web.de> <20050521180749.73298593.diegocg@gmail.com>
In-Reply-To: <20050521180749.73298593.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Sat, 21 May 2005 16:25:56 +0200,
> Gregor Jasny <gjasny@web.de> escribió:
> 
> 
>>But when I boot a Linux 2.6 kernel with CONFIG_M586=y it recognizes only a 486.
> 
> 
> Seems to work well here, same config.
>
> processor       : 0
> vendor_id       : CyrixInstead
> cpu family      : 6
> model           : 2
> model name      : 6x86MX 3x Core/Bus Clock
> stepping        : 7
> cpu MHz         : 200.512

6x86MX is newer than 6x86L - and also more "stantard one". IIRC, the 
CPUID instruction can be disabled on some Cyrix CPUs. 6x86 without CPUID 
might look like a 486. So maybe something is wrong with this.
I have Cyrix MII (newer 6x86MX renamed) and it works fine too.

Linux version 2.6.12-rc3-pentium (root@pentium) (gcc version 3.3.5) #8 
Sat May 14 20:02:42 CEST 2005
...
CPU: After generic identify, caps: 0080a135 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0080a135 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After all inits, caps: 0080a135 00000000 00000000 00000004 00000000 
00000000 00000000
CPU: Cyrix M II 3x Core/Bus Clock stepping 04


> Linux version 2.6.12-rc4-mm2 (diego@estel) (gcc versión 3.3.5 (Debian 1:3.3.5-12)) #14 Sat May 21 17:46:33 CEST 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 32MB LOWMEM available.
> On node 0 totalpages: 8192
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 4096 pages, LIFO batch:1
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.0 present.
> Allocating PCI resources starting at 02000000 (gap: 02000000:fdff0000)
> Built 1 zonelists
> No local APIC present or hardware disabled
> mapped APIC to ffffd000 (01041000)
> Initializing CPU#0
> Kernel command line: profile=2 ro root=/dev/hda1
> kernel profiling enabled (shift: 2)
> CPU 0 irqstacks, hard=c0325000 soft=c0324000
> PID hash table entries: 256 (order: 8, 4096 bytes)
> Detected 200.512 MHz processor.
> Using tsc for high-res timesource
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 27992k/32768k available (1513k kernel code, 4344k reserved, 480k data, 172k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 401.53 BogoMIPS (lpj=200766)
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 0080a135 00000000 00000000 00000000 00000000 00000000 00000000
> CPU: After vendor identify, caps: 0080a135 00000000 00000000 00000000 00000000 00000000 00000000
> CPU: After all inits, caps: 0080a135 00000000 00000000 00000004 00000000 00000000 00000000
> CPU: Cyrix 6x86MX 3x Core/Bus Clock stepping 07
> Checking 'hlt' instruction... OK.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=0
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00fc070
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc098, dseg 0xf0000
> PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:01.1
> PCI: Cannot allocate resource region 4 of device 0000:00:01.1
> pnp: the driver 'system' has been registered
> pnp: match found with the PnP device '00:07' and the driver 'system'
> pnp: match found with the PnP device '00:09' and the driver 'system'
> pnp: 00:09: ioport range 0x208-0x20f has been reserved
> IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
> isapnp: Scanning for PnP cards...
> pnp: Calling quirk for 01:01.03
> pnp: CMI8330 quirk - fixing interrupts and dma
> isapnp: Card 'CMI8330. Audio Adapter'
> isapnp: 1 Plug & Play card detected total
> lp: driver loaded but no devices found
> Real Time Clock Driver v1.12
> Non-volatile memory driver v1.2
> ppdev: user-space parallel port driver
> pnp: the driver 'i8042 kbd' has been registered
> pnp: match found with the PnP device '00:04' and the driver 'i8042 kbd'
> pnp: the driver 'i8042 aux' has been registered
> PNP: PS/2 controller doesn't have AUX irq; using default 0xc
> PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
> pnp: the driver 'serial' has been registered
> pnp: match found with the PnP device '00:0a' and the driver 'serial'
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> pnp: the driver 'parport_pc' has been registered
> pnp: match found with the PnP device '00:0c' and the driver 'parport_pc'
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP]
> lp0: using parport0 (interrupt-driven).
> lp0: console ready
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:0f.0: 3Com PCI 3c905 Boomerang 100baseTx at 0x6000. Vers LK1.1.19
> eth0: Dropping NETIF_F_SG since no checksum feature.
> PPP generic driver version 2.4.2
> PPP BSD Compression module registered
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SIS5513: IDE controller at PCI slot 0000:00:01.1
> SIS5513: chipset revision 193
> SIS5513: not 100% native mode: will probe irqs later
> SIS5513: SiS5571 ATA 16 controller
>     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: ST32122A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> Probing IDE interface ide1...
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hda: max request size: 128KiB
> hda: 4124736 sectors (2111 MB) w/128KiB Cache, CHS=4092/16/63
> hda: cache flushes not supported
>  hda: hda1 hda2
> mice: PS/2 mouse device common for all mice
> oprofile: using timer interrupt.
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> ip_conntrack version 2.1 (256 buckets, 2048 max) - 212 bytes per conntrack
> ip_tables: (C) 2000-2002 Netfilter core team
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 172k freed
> kjournald starting.  Commit interval 5 seconds
> Adding 96760k swap on /dev/hda2.  Priority:-1 extents:1
> EXT3-fs warning: checktime reached, running e2fsck is recommended
> EXT3 FS on hda1, internal journal
> ttyS1: LSR safety check engaged!
> ttyS1: LSR safety check engaged!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ondrej Zary
