Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266734AbSIROTt>; Wed, 18 Sep 2002 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266743AbSIROTt>; Wed, 18 Sep 2002 10:19:49 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:39872 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S266734AbSIROTq>; Wed, 18 Sep 2002 10:19:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Athlon/via problems continued
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 18 Sep 2002 10:24:46 -0400
In-Reply-To: <1032354632.23252.14.camel@venus>
Message-ID: <x7admfgytt.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks:  Here are a couple portions of boot messages and a bug()
trigger from 2.5.36.  I am not sure what is important so forgive me
for extraneous info.

Sep 18 08:40:10 itchy kernel: Linux version 2.5.36 (kirk@itchy) (gcc version 2.95.4 20011002 (Debian prerelease)) #0 Wed Sep 18 08:28:42 EDT 2002
Sep 18 08:40:10 itchy kernel: Video mode to be used for restore is f01
Sep 18 08:40:10 itchy kernel: BIOS-provided physical RAM map:
Sep 18 08:40:10 itchy kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Sep 18 08:40:10 itchy kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 18 08:40:10 itchy kernel:  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
Sep 18 08:40:10 itchy kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep 18 08:40:10 itchy kernel: 512MB LOWMEM available.
Sep 18 08:40:10 itchy kernel: On node 0 totalpages: 131072
Sep 18 08:40:10 itchy kernel:   DMA zone: 4096 pages
Sep 18 08:40:10 itchy kernel:   Normal zone: 126976 pages
Sep 18 08:40:10 itchy kernel:   HighMem zone: 0 pages
Sep 18 08:40:10 itchy kernel: Kernel command line: BOOT_IMAGE=old ro root=301
Sep 18 08:40:10 itchy kernel: Initializing CPU#0
Sep 18 08:40:10 itchy kernel: Detected 1737.233 MHz processor.
Sep 18 08:40:10 itchy kernel: Console: colour VGA+ 80x50
Sep 18 08:40:10 itchy kernel: Calibrating delay loop... 3424.25 BogoMIPS
Sep 18 08:40:10 itchy kernel: Memory: 516800k/524288k available (1097k kernel code, 7104k reserved, 404k data, 224k init, 0k highmem)
Sep 18 08:40:10 itchy kernel: Security Scaffold v1.0.0 initialized
Sep 18 08:40:10 itchy kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Sep 18 08:40:10 itchy kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Sep 18 08:40:10 itchy kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep 18 08:40:10 itchy kernel: CPU: Before vendor init, caps: 0383f9ff c1c3f9ff 00000000, vendor = 2
Sep 18 08:40:10 itchy kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep 18 08:40:10 itchy kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 18 08:40:10 itchy kernel: CPU: After vendor init, caps: 0383f9ff c1c3f9ff 00000000 00000000
Sep 18 08:40:10 itchy kernel: Intel machine check architecture supported.
Sep 18 08:40:10 itchy kernel: Intel machine check reporting enabled on CPU#0.
Sep 18 08:40:10 itchy kernel: Machine check exception polling timer started.
Sep 18 08:40:10 itchy kernel: CPU:     After generic, caps: 0383f9ff c1c3f9ff 00000000 00000000
Sep 18 08:40:10 itchy kernel: CPU:             Common caps: 0383f9ff c1c3f9ff 00000000 00000000
Sep 18 08:40:10 itchy kernel: CPU: AMD Athlon(tm) XP 2100+ stepping 02
Sep 18 08:40:10 itchy kernel: Enabling fast FPU save and restore... done.
Sep 18 08:40:10 itchy kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 18 08:40:10 itchy kernel: Checking 'hlt' instruction... OK.
Sep 18 08:40:10 itchy kernel: POSIX conformance testing by UNIFIX
Sep 18 08:40:10 itchy kernel: Linux NET4.0 for Linux 2.4
Sep 18 08:40:10 itchy kernel: Based upon Swansea University Computer Society NET3.039
Sep 18 08:40:10 itchy kernel: Initializing RT netlink socket
Sep 18 08:40:10 itchy kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=1
Sep 18 08:40:10 itchy kernel: PCI: Using configuration type 1
Sep 18 08:40:10 itchy kernel: PCI: Probing PCI hardware
Sep 18 08:40:10 itchy kernel: PCI: Probing PCI hardware (bus 00)
Sep 18 08:40:10 itchy kernel: PCI: Using IRQ router default [1106/3099] at 00:00.0
Sep 18 08:40:10 itchy kernel: Starting kswapd
Sep 18 08:40:10 itchy kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Sep 18 08:40:10 itchy kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Sep 18 08:40:10 itchy kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Sep 18 08:40:10 itchy kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Sep 18 08:40:10 itchy kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Sep 18 08:40:10 itchy kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Sep 18 08:40:10 itchy kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Sep 18 08:40:10 itchy kernel: aio_setup: sizeof(struct page) = 40
Sep 18 08:40:10 itchy kernel: Journalled Block Device driver loaded
Sep 18 08:40:10 itchy kernel: Capability LSM initialized
Sep 18 08:40:10 itchy kernel: block: 256 slots per queue, batch=32
Sep 18 08:40:10 itchy kernel: Floppy drive(s): fd0 is 1.44M
Sep 18 08:40:10 itchy kernel: FDC 0 is a post-1991 82077
Sep 18 08:40:10 itchy kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Sep 18 08:40:10 itchy kernel: 00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.18
Sep 18 08:40:10 itchy kernel: phy=0, phyx=24, mii_status=0x782d
Sep 18 08:40:10 itchy kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 18 08:40:10 itchy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 18 08:40:10 itchy kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Sep 18 08:40:10 itchy kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
Sep 18 08:40:10 itchy kernel: VP_IDE: chipset revision 6
Sep 18 08:40:10 itchy kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 18 08:40:10 itchy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 18 08:40:10 itchy kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep 18 08:40:10 itchy kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
Sep 18 08:40:10 itchy kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:pio
Sep 18 08:40:10 itchy kernel: hda: FUJITSU MPG3409AT E, ATA DISK drive
Sep 18 08:40:10 itchy kernel: hda: DMA disabled
Sep 18 08:40:10 itchy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 18 08:40:10 itchy kernel: hdc: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
Sep 18 08:40:10 itchy kernel: hdc: DMA disabled
Sep 18 08:40:10 itchy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 18 08:40:10 itchy kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Sep 18 08:40:10 itchy kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
Sep 18 08:40:10 itchy kernel: PCI: Unable to reserve I/O region #5:10@d400 for device 00:11.1
Sep 18 08:40:10 itchy kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 18 08:40:10 itchy kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep 18 08:40:10 itchy kernel: VP_IDE: port 0x01f0 already claimed by ide0
Sep 18 08:40:10 itchy kernel: VP_IDE: port 0x0170 already claimed by ide1
Sep 18 08:40:10 itchy kernel: VP_IDE: neither IDE port enabled (BIOS)
Sep 18 08:40:10 itchy kernel: hda: host protected area => 1
Sep 18 08:40:10 itchy kernel: hda: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=4983/255/63, UDMA(100)
Sep 18 08:40:10 itchy kernel:  hda: hda1 hda2 hda3 hda4
Sep 18 08:40:10 itchy kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Sep 18 08:40:10 itchy kernel: Uniform CD-ROM driver Revision: 3.12
Sep 18 08:40:10 itchy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 18 08:40:10 itchy kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep 18 08:40:10 itchy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 18 08:40:10 itchy kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep 18 08:40:10 itchy kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Sep 18 08:40:10 itchy kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Sep 18 08:40:10 itchy kernel: TCP: Hash tables configured (established 131072 bind 65536)
Sep 18 08:40:10 itchy kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep 18 08:40:10 itchy kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 08:40:10 itchy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 18 08:40:10 itchy kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 18 08:40:10 itchy kernel: Freeing unused kernel memory: 224k freed
Sep 18 08:40:10 itchy kernel: Adding 136544k swap on /dev/hda2.  Priority:-1 extents:1
Sep 18 08:40:10 itchy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Sep 18 08:40:10 itchy kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 08:40:10 itchy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Sep 18 08:40:10 itchy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 18 08:40:10 itchy kernel: kjournald starting.  Commit interval 5 seconds
Sep 18 08:40:10 itchy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
Sep 18 08:40:10 itchy kernel: EXT3-fs: mounted filesystem with ordered data mode.

Here is the pci/ide portion of the next run with pci=boisirq specified
on the command line.

Sep 18 09:24:24 itchy kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=1
Sep 18 09:24:24 itchy kernel: PCI: Using configuration type 1
Sep 18 09:24:24 itchy kernel: PCI: Probing PCI hardware
Sep 18 09:24:24 itchy kernel: PCI: Probing PCI hardware (bus 00)
Sep 18 09:24:24 itchy kernel: PCI: Using IRQ router default [1106/3099] at 00:00.0
Sep 18 09:24:24 itchy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 18 09:24:24 itchy kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Sep 18 09:24:24 itchy kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1.
Sep 18 09:24:24 itchy kernel: VP_IDE: chipset revision 6
Sep 18 09:24:24 itchy kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 18 09:24:24 itchy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 18 09:24:24 itchy kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep 18 09:24:24 itchy kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
Sep 18 09:24:24 itchy kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:pio
Sep 18 09:24:24 itchy kernel: hda: FUJITSU MPG3409AT E, ATA DISK drive
Sep 18 09:24:24 itchy kernel: hda: DMA disabled
Sep 18 09:24:24 itchy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 18 09:24:24 itchy kernel: hdc: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
Sep 18 09:24:24 itchy kernel: hdc: DMA disabled
Sep 18 09:24:24 itchy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 18 09:24:24 itchy kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Sep 18 09:24:24 itchy kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1.
Sep 18 09:24:24 itchy kernel: PCI: Unable to reserve I/O region #5:10@d400 for device 00:11.1
Sep 18 09:24:24 itchy kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 18 09:24:24 itchy kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep 18 09:24:24 itchy kernel: VP_IDE: port 0x01f0 already claimed by ide0
Sep 18 09:24:24 itchy kernel: VP_IDE: port 0x0170 already claimed by ide1
Sep 18 09:24:24 itchy kernel: VP_IDE: neither IDE port enabled (BIOS)
Sep 18 09:24:24 itchy kernel: hda: host protected area => 1
Sep 18 09:24:24 itchy kernel: hda: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=4983/255/63, UDMA(100)
Sep 18 09:24:24 itchy kernel:  hda: hda1 hda2 hda3 hda4
Sep 18 09:24:24 itchy kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Sep 18 09:24:24 itchy kernel: Uniform CD-ROM driver Revision: 3.12
Sep 18 09:24:24 itchy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
I don't understand why the vpide would allow the standard ide to keep
the ports 0x1f0 if the vpide could handle the controller better for
the via chip set.  I also don't understand why the DMA was turned
off.  Interestingly when I ran hdparm -vi it showed DMA as being
enabled.

Now, I run a chron job every twenty minutes to attempt to start
setiathome incase it has been stopped for some reason.  This is
usually the point where the box takes a trip south, as in solid lock
up.  I managed to get a bug() dump for once.  If I need to supply more
info please let me know what else is necessary.

Sep 18 09:40:59 itchy kernel: kernel BUG at page_alloc.c:184!
Sep 18 09:40:59 itchy kernel: invalid operand: 0000
Sep 18 09:40:59 itchy kernel: CPU:    0
Sep 18 09:40:59 itchy kernel: EIP:    0060:[rmqueue+646/784]    Not tainted
Sep 18 09:40:59 itchy kernel: EFLAGS: 00010202
Sep 18 09:40:59 itchy kernel: eax: 01010024   ebx: c14d5228   ecx: 00000000   edx: 01010024
Sep 18 09:40:59 itchy kernel: esi: c0269b60   edi: c0269b60   ebp: 00000001   esp: df14be40
Sep 18 09:40:59 itchy kernel: ds: 0068   es: 0068   ss: 0068
Sep 18 09:40:59 itchy kernel: Process setiathome (pid: 215, threadinfo=df14a000 task=df37e200)
Sep 18 09:40:59 itchy kernel: Stack: 000001ff 00000000 c0269d40 410a5000 00000000 c0107160 00001000 0001deda 
Sep 18 09:40:59 itchy kernel:        00000286 c0269b98 c0129d82 c0269b60 00000000 000001d2 c10028b8 deb8c294 
Sep 18 09:40:59 itchy kernel:        410a5000 c0269b60 00000000 000001d2 1eedb067 c0129b46 00104025 c01208e6 
Sep 18 09:40:59 itchy kernel: Call Trace: [common_interrupt+24/32] [__alloc_pages+82/480] [_alloc_pages+22/32] [do_anonymous_page+70/352] [do_no_page+52/528] 
Sep 18 09:40:59 itchy kernel:    [handle_mm_fault+97/224] [do_page_fault+279/1028] [do_page_fault+0/1028] [update_process_times+37/48] [update_wall_time+11/64] [timer_bh+36/624] 
Sep 18 09:40:59 itchy kernel:    [bh_action+19/32] [tasklet_hi_action+61/112] [do_softirq+90/176] [do_IRQ+200/224] [error_code+45/56] 
Sep 18 09:40:59 itchy kernel: 
Sep 18 09:40:59 itchy kernel: Code: 0f 0b b8 00 c0 bd 21 c0 89 f6 8b 03 a8 40 74 0a 0f 0b b9 00 

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
