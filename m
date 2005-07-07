Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVGGOBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVGGOBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVGGNxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:53:48 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:37798 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S261555AbVGGNxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:53:25 -0400
Date: Thu, 7 Jul 2005 16:53:16 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
In-Reply-To: <20050707174158.A4318@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0507071650030.363@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
 <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru>
 <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru>
 <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi> <20050707174158.A4318@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Thu, 07 Jul 2005 16:53:17 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Ivan Kokshaysky wrote:

> On Thu, Jul 07, 2005 at 03:47:58PM +0300, Tero Roponen wrote:
> > I just tested the patch, but it didn't help. It still hangs.
>
> Well, the code in setup-bus.c does actually know about host
> bridges, so the patch was just no-op...
>
> Tero (and others), can you post dmesg from working kernel and,
> if possible, from 2.6.13-rc2 captured from serial console?
>
> Ivan.
>

Below is my dmesg from 2.6.12. Unfortunately, I don't have
another machine available, so I can't use serial console.

-
Tero Roponen

Linux version 2.6.12 (terrop@laptop) (gcc version 4.0.0 20050525 (Red Hat 4.0.0-9)) #2 Sat Jun 18 11:03:55 EEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003fd0000 (usable)
 BIOS-e820: 0000000003fd0000 - 0000000003fdf000 (ACPI data)
 BIOS-e820: 0000000003fdf000 - 0000000003fe0000 (ACPI NVS)
 BIOS-e820: 0000000003fe0000 - 0000000004000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
63MB LOWMEM available.
On node 0 totalpages: 16336
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 12240 pages, LIFO batch:3
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
Allocating PCI resources starting at 04000000 (gap: 04000000:fbfe0000)
Built 1 zonelists
Kernel command line:
Initializing CPU#0
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 265.384 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 61404k/65344k available (1856k kernel code, 3456k reserved, 683k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 521.21 BogoMIPS (lpj=260608)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd880, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:03.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:06.0
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x15e0-0x15ef has been reserved
pnp: 00:0a: ioport range 0xef00-0xefaf could not be reserved
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:02.0
neofb: mapped io at c4800000
Autodetected internal display
Panel is a 800x600 color TFT display
neofb: mapped framebuffer at c4a80000
neofb v0.4.2: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
Console: switching to colour frame buffer device 100x37
fb0: MagicGraph 128XD frame buffer device
Real Time Clock Driver v1.12
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:06.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: IBM-DPLA-25120, ATA DISK drive
hdb: SANYO CRD-S372B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 10009440 sectors (5124 MB) w/468KiB Cache, CHS=10592/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 > hda4
mice: PS/2 mouse device common for all mice
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
input: PS/2 Generic Mouse on isa0060/serio1
hdb: ATAPI 24X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:03.0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0092]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.0, mfunc 0xfba97543, devctl 0x62
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0092]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.1, mfunc 0xfba97543, devctl 0x62
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000010
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
ReiserFS: hda8: using ordered data mode
ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda8: checking transaction log (hda8)
ReiserFS: hda8: Using tea hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x200-0x207 0x220-0x22f 0x378-0x37f
cs: IO port probe 0x100-0x4ff: excluding 0x200-0x207 0x220-0x22f 0x378-0x37f
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: Xircom: port 0x300, irq 3, hwaddr 00:80:C7:72:21:6B
Adding 131064k swap on /usr/SWAPFILE.  Priority:-1 extents:206
eth0: switching to 10Base2 port
eth0: MII selected
eth0: media 10Base2, silicon revision 4
eth0: MII selected
eth0: media 10Base2, silicon revision 4
eth0: MII selected
eth0: media 10Base2, silicon revision 4
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
