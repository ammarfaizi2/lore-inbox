Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262552AbTCIRfd>; Sun, 9 Mar 2003 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262553AbTCIRfd>; Sun, 9 Mar 2003 12:35:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41896 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262552AbTCIRfX> convert rfc822-to-8bit; Sun, 9 Mar 2003 12:35:23 -0500
Date: Sun, 09 Mar 2003 09:45:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Tomasz Torcz, BG" <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
Message-ID: <14500000.1047231917@[10.10.2.4]>
In-Reply-To: <20030306192050.GA1414@irc.pl>
References: <20030306192050.GA1414@irc.pl>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look for akpm's latest -mm tree release notes - the patch is embedded
in there.

M.


--On Thursday, March 06, 2003 20:20:50 +0100 "Tomasz Torcz, BG" <zdzichu@irc.pl> wrote:

> Hi, 
> 
> I left my computer unattended, when I got back, the BUG was
> on screen. I was unable to start XFree86 after that, so this seems
> serious ;). I found bug after 1 day and 2 hours of uptime (system
> was left alone 4 earlier; XFree was not running).
> 
> 1) output of ver_linux
> 
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux mother 2.5.64 #9 ¶ro mar 5 14:03:36 CET 2003 i686 unknown
> 
> Gnu C                  2.95.3
> Gnu make               3.79.1
> util-linux             2.11l
> mount                  2.11l
> module-init-tools      0.9.10
> e2fsprogs              1.32
> jfsutils               1.1.1
> reiserfsprogs          3.6.3
> xfsprogs               2.0.3
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.9
> Net-tools              1.60
> Kbd                    1.06
> Sh-utils               2.0
> Modules Loaded         jfs
> 
> 2) Related to:
> 
> My wild guess (based on vtund process in oops-dump): bad interaction
> of net and sysfs layer. (Is this possible?)
> 
> 3). I don't know how to reproduce.
> 
> 4). Enviromnent:
> 
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 6
> model name      : Celeron (Mendocino)
> stepping        : 5
> cpu MHz         : 368.277
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 mmx fxsr
> bogomips        : 720.89
> 
> Modules:
> jfs 155464 1 - Live 0xc8942000
> 
> 
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 02f8-02ff : serial
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> 5000-500f : VIA Technologies, In VT82C686 [Apollo Sup
> 6000-607f : VIA Technologies, In VT82C686 [Apollo Sup
> d000-d00f : VIA Technologies, In VT82C586/B/686A/B PI
>   d000-d007 : ide0
>   d008-d00f : ide1
> d400-d41f : VIA Technologies, In USB
> d800-d81f : VIA Technologies, In USB (#2)
> dc00-dcff : VIA Technologies, In VT82C686 AC97 Audio
> e000-e003 : VIA Technologies, In VT82C686 AC97 Audio
> e400-e403 : VIA Technologies, In VT82C686 AC97 Audio
> e800-e8ff : Realtek Semiconducto RTL-8139/8139C/8139C
>   e800-e8ff : 8139too
> ec00-ec3f : Ensoniq ES1370 [AudioPCI]
>   ec00-ec3f : Ensoniq AudioPCI
> 
> 00000000-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-07feffff : System RAM
>   00100000-00361f26 : Kernel code
>   00361f27-00484243 : Kernel data
> 07ff0000-07ff2fff : ACPI Non-volatile Storage
> 07ff3000-07ffffff : ACPI Tables
> e0000000-e3ffffff : VIA Technologies, In VT82C693A/694x [Apol
> e4000000-e7ffffff : PCI Bus #01
>   e4000000-e4003fff : Matrox Graphics, Inc MGA G550 AGP
>   e5000000-e57fffff : Matrox Graphics, Inc MGA G550 AGP
> e8000000-e9ffffff : PCI Bus #01
>   e8000000-e9ffffff : Matrox Graphics, Inc MGA G550 AGP
> ea000000-ea0000ff : Realtek Semiconducto RTL-8139/8139C/8139C
>   ea000000-ea0000ff : 8139too
> ffff0000-ffffffff : reserved
> 
> Full dmesg from system start, with BUG() output at the end:
> 
> 
> Linux version 2.5.64 (zdzichu@mother) (gcc version 2.95.3 20010315 (release)) #9 ¶ro mar 5 14:03:36 CET 2003
> Video mode to be used for restore is f00
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
>  BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
>  BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 127MB LOWMEM available.
> On node 0 totalpages: 32752
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 28656 pages, LIFO batch:6
>   HighMem zone: 0 pages, LIFO batch:1
> ACPI: RSDP (v000 VIA693                     ) @ 0x000f70c0
> ACPI: RSDT (v001 AWARD  AWRDACPI 16944.11825) @ 0x07ff3000
> ACPI: FADT (v001 AWARD  AWRDACPI 16944.11825) @ 0x07ff3040
> ACPI: DSDT (v001 VIA693 AWRDACPI 00000.04096) @ 0x00000000
> ACPI: BIOS passes blacklist
> ACPI: MADT not present
> Building zonelist for node : 0
> Kernel command line: auto BOOT_IMAGE=linux2_5fb root=303 video=matrox:1024x768-16@75 root=/dev/ide/host0/bus0/target0/lun0/part3
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> Initializing CPU#0
> PID hash table entries: 512 (order 9: 4096 bytes)
> Detected 368.178 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 720.89 BogoMIPS
> Memory: 125148k/131008k available (2439k kernel code, 5328k reserved, 1160k data, 136k init, 0k highmem)
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Failed to register 'sysfs' in sysfs
> -> /dev
> -> /dev/console
> -> /root
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 128K
> CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: Intel Celeron (Mendocino) stepping 05
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 368.0238 MHz.
> ..... host bus clock speed is 66.0952 MHz.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> mtrr: v2.0 (20020519)
> PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
> PCI: Using configuration type 1
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec pool[0]:   1 bvecs: 242 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 242 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 242 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 242 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 121 entries (1536 bytes)
> biovec pool[5]: 256 bvecs:  60 entries (3072 bytes)
> ACPI: Subsystem revision 20030228
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
> block request queues:
>  128 requests per read queue
>  128 requests per write queue
>  8 requests per batch
>  enter congestion at 15
>  exit congestion at 17
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
> Enabling SEP on CPU 0
> aio_setup: sizeof(struct page) = 40
> Journalled Block Device driver loaded
> Coda Kernel/Venus communications, v5.3.15, coda@cs.cmu.edu
> devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x1
> udf: registering filesystem
> Initializing Cryptographic API
> PCI: Disabling Via external APIC routing
> ACPI: Power Button (FF) [PWRF]
> ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
> tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: cpp_daisy: aa5500ff(08)
> parport0: assign_addrs: aa5500ff(08)
> parport0: cpp_daisy: aa5500ff(08)
> parport0: assign_addrs: aa5500ff(08)
> parport_pc: Via 686A parallel port: io=0x378
> pty: 256 Unix98 ptys configured
> lp0: using parport0 (polling).
> Real Time Clock Driver v1.11
> Non-volatile memory driver v1.2
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected VIA Apollo Pro 133 chipset
> agpgart: Maximum main memory to use for agp memory: 94M
> agpgart: AGP aperture is 64M @ 0xe0000000
> [drm] Initialized mga 3.1.0 20021029 on minor 0
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> 8139too Fast Ethernet driver 0.9.26
> eth0: RealTek RTL8139 Fast Ethernet at 0xc8829000, 00:06:4f:00:e8:99, IRQ 12
> eth0:  Identified 8139 chip type 'RTL-8139C'
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:07.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: ST38421A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: 8X4X32, ATAPI CD/DVD-ROM drive
> hdd: ST32532A, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 16498944 sectors (8447 MB) w/256KiB Cache, CHS=16368/16/63, UDMA(66)
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdd: task_no_data_intr: error=0x04 { DriveStatusError }
> hdd: 4995648 sectors (2558 MB) w/128KiB Cache, CHS=4956/16/63, UDMA(33)
>  /dev/ide/host0/bus1/target1/lun0: p1 p2
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
> i2c-proc.o version 2.7.0 (20021208)
> Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 2003 UTC).
> request_module: failed /sbin/modprobe -- snd-card-0. error = -16
> ALSA device list:
>   #0: Ensoniq AudioPCI ENS1370 at 0xec00, irq 10
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> ip_conntrack version 2.1 (1023 buckets, 8184 max) - 304 bytes per conntrack
> ip_tables: (C) 2000-2002 Netfilter core team
> Initializing IPsec netlink socket
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> IPv6 v0.8 for NET4.0
> IPv6 over IPv4 tunneling driver
> NET4: Ethernet Bridge 008 for NET4.0
> Bridge firewalling registered
> ACPI: (supports S0 S1 S4 S4bios S5)
> UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-25
> UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
> UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048 byte sectors)
> UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte 32768. Assuming open disc. Skipping validity check
> UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block 256, tag 18 != 256
> UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block found
> UDF-fs: No partition found (1)
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device ide0(3,3), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (ide0(3,3)) for (ide0(3,3))
> reiserfs: replayed 29 transactions in 8 seconds
> Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 136k freed
> blk: queue c04d113c, I/O limit 4095Mb (mask 0xffffffff)
> hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdc: drive_cmd: error=0x04Aborted Command 
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,65), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> Disabled Privacy Extensions on device c04413a0(lo)
> eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Adding 251488k swap on /dev/ide/host0/bus1/target1/lun0/part2.  Priority:1 extents:1
> Adding 134756k swap on /swap.  Priority:1 extents:3064
> __ipv6_regen_rndid(): too short regeneration interval; timer diabled for eth0.
> agpgart: Putting AGP V2 device at 00:00.0 into 2x mode
> agpgart: Putting AGP V2 device at 01:00.0 into 2x mode
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISO 9660 Extensions: RRIP_1991A
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> tcpdump uses obsolete (PF_INET,SOCK_PACKET)
> eth0: Promiscuous mode enabled.
> device eth0 entered promiscuous mode
> device eth0 left promiscuous mode
> eth0: Promiscuous mode enabled.
> device eth0 entered promiscuous mode
> device eth0 left promiscuous mode
> jfs: version magic '2.5.63 PENTIUMII gcc-2.95' should be '2.5.64 PENTIUMII gcc-2.95'
> jfs: version magic '2.5.63 PENTIUMII gcc-2.95' should be '2.5.64 PENTIUMII gcc-2.95'
> jfs: version magic '2.5.63 PENTIUMII gcc-2.95' should be '2.5.64 PENTIUMII gcc-2.95'
> jfs: version magic '2.5.63 PENTIUMII gcc-2.95' should be '2.5.64 PENTIUMII gcc-2.95'
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> mtrr: MTRR 2 not used
> mtrr: MTRR 2 not used
> mtrr: MTRR 2 not used
> ------------[ cut here ]------------
> kernel BUG at include/linux/dcache.h:266!
> invalid operand: 0000
> CPU:    0
> EIP:    0060:[<c0167938>]    Not tainted
> EFLAGS: 00010246
> EIP is at sysfs_remove_dir+0x18/0x116
> eax: 00000000   ebx: c72dd9bc   ecx: c72dd82c   edx: 00000000
> esi: c756af20   edi: c7fea560   ebp: c7720b40   esp: c7357f14
> ds: 007b   es: 007b   ss: 0068
> Process vtund (pid: 105, threadinfo=c7356000 task=c7a092e0)
> Stack: c72dd9bc c72dd82c c7fea560 c7720b40 c72dd82c c0217af7 c72dd9bc c72dd9bc 
>        c0217b0f c72dd9bc c72dd82c c02e5205 c72dd9bc c72dd82c c72dd800 c7fea560 
>        c7720b40 c72dd9bc c02819d8 c72dd82c c72dd82c c5162660 c771f8a0 c0142864 
> Call Trace:
>  [<c0217af7>] kobject_del+0xb/0x18
>  [<c0217b0f>] kobject_unregister+0xb/0x18
>  [<c02e5205>] unregister_netdevice+0x20d/0x230
>  [<c02819d8>] tun_chr_close+0x9c/0xb0
>  [<c0142864>] __fput+0x30/0xc4
>  [<c0142833>] fput+0x13/0x14
>  [<c0141615>] filp_close+0x59/0x64
>  [<c0141667>] sys_close+0x47/0x58
>  [<c0108c9b>] syscall_call+0x7/0xb
> 
> Code: 0f 0b 0a 01 20 4c 37 c0 ff 06 80 4e 04 08 85 f6 0f 84 e2 00 
> 
> My gzipped .config attached.
> 
> 
> I hope this will help o squash the bug. I can do further testing
> on this system, if asked.
>  
> -- 
> Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
> zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


