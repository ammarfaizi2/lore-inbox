Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbTLHDUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbTLHDUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:20:16 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:38026
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S265317AbTLHDT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:19:28 -0500
Date: Sun, 7 Dec 2003 19:21:28 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 Oops
Message-ID: <20031208032127.GA14638@nasledov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just encountered an Oops on my IBM ThinkPad T21 with 2.6.0-test11. I
suspect that it has something to do with my battery being so low that it would
not even give a reading. I had to copy down the oops and by the time I
rebooted the machine, it had charged enough and booted successfuly. Here is
the text of the oops:

EIP:	0060:[<c0119179>]	Not tainted
EFLAGS:	00010002
EIP is at schedule+0xf9/0x590
eax: 00000001	ebx: c03acc20	ecx: c03acc40	edx: 28b4a89a
esi: 00000000	edi: cfe38800	ebp: c0425cfc	esp: c0425cb8
ds: 008b	es: 007b	ss: 0068
Process swapper (pid: 0, threadinfo=c0424000 task=c03acc20)
Stack: c036bae0 c0424000 00000246 00000001 c0425d24 c02ae50d 00000000 00000000
       00000000 c0425d10 00000246 0bb0fbdc 3465a476 00000005 fffbb5e4 c0425d10
       cfe38800 00000002 c0125123 c0425d10 fffbb5ef 00004103 c0465d68 c0465d68
Call Trace:
 [<c02ae50d>] pci_read+0x35/0x50
 [<c0125123>] schedule_timeout+0x63/0xc0
 [<c01250b0>] process_timeout+0x0/0x10
 [<c0208579>] pci_set_power_state+0xd9/0x180
 [<d10ac5cb>] acpi_set_WOL+0x8b/0xa0 [3c59x]
 [<d10aa5c8>] vortex_error+0x228/0x3c0 [3c59x]
 [<d108bd9e>] cs_interrupt+0x15e/0x190 [cs46xx]
 [<c010ad19>] handle_IRQ_event+0x49/0x80
 [<c010b08f>] do_IRQ+0x8f/0x130
 [<c01094f8>] common_interrupt+0x18/0x20
 [<c010af6d>] enable_irq+0x3d/0xd0
 [<c02c3b58>] __netdev_watchdog_up+0x38/0x70
 [<d10a9c69>] vortex_timer+0xd9/0x580 [3c59x]
 [<d10a9b90>] vortex_timer+0x0/0x580 [3c59x]
 [<c0124dfb>] run_timer_softirq+0xcb/0x1c0
 [<c0124fe0>] do_timer+0xe0/0xf0
 [<c0120995>] do_softirq+0x59/0xa0
 [<c010b0fb>] do_IRQ+0xfb/0x130
 [<c01094f8>] common_interrupt+0x18/0x20
 [<c0114e10>] apm_bios_call_simple+0x70/0xd0
 [<c0114fc3>] apm_do_idle+0x23/0x80
 [<c01150f3>] apm_cpu_idle+0xa3/0x140
 [<c0105000>] rest_init+0x0/0x60
 [<c0107044>] cpu_idle+0x34/0x40
 [<c042670d>] start_kernel+0x14d/0x160
 [<c0426470>] unknown_bootoption+0x0/0x120

Code: ff 0e 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

Here is an lspci:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:03.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus (rev 20)
00:03.1 Communication controller: 3Com Corporation Mini PCI 56k Winmodem (rev 20)
00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13)

I've attached the .config file and an example of a successful boot.
-- 
Misha Nasledov
misha@nasledov.com

--qDbXVdCdHGoSgWSk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.6.0-test11.gz"
Content-Transfer-Encoding: base64

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

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="DMESG-2.6"

Linux version 2.6.0-test11 (root@aurora.alkaid.org) (gcc version 3.3.2 (Debian)) #1 Wed Nov 26 19:07:33 PST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 idebus=66 video=vesa:mtrr vga=0x317
ide_setup: idebus=66
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 796.590 MHz processor.
Console: colour dummy device 80x25
Memory: 255120k/262080k available (2406k kernel code, 6232k reserved, 805k data, 224k init, 0k highmem)
Calibrating delay loop... 1572.86 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7210
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb1ef, dseg 0x400
pnp: 00:00: ioport range 0x15e8-0x15ef has been reserved
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x103f has been reserved
pnp: 00:0b: ioport range 0x1040-0x104f has been reserved
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 0000:00:07.3 [1000:103f]
PCI: Address space collision on region 8 of bridge 0000:00:07.3 [1040:105f]
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
vesafb: framebuffer at 0xf0000000, mapped to 0xd0800000, size 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:8704
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
speedstep-smi: signature:0x47534943, command:0x008200b2, event:0x00c000b3, perf_level:0x07d00000.
speedstep-smi: could not detect low and high frequencies by SMI call.
cpufreq: change to 0 MHz succeded
cpufreq: change to 4 MHz succeded
speedstep-smi: workaround worked.
cpufreq: currently at high speed setting - 800 MHz
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4019GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 128x48
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:05.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 06b8, PCI irq11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 06b8, PCI irq11
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00001c20
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding 498952k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
PCI: Found IRQ 11 for device 0000:00:05.0
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Crystal 4280/46xx + AC97 Audio, version 1.28.32, 18:57:43 Nov 26 2003
cs46xx: Card found at 0xe8100000 and 0xe8000000, IRQ 11
cs46xx: Thinkpad 600X/A20/T20 (1014:0153) at 0xe8100000/0xe8000000, IRQ 11
ac97_codec: AC97 Audio codec, id: CRY20 (Cirrus Logic CS4297A rev B)
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:03.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1800. Vers LK1.1.19
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Disabled Privacy Extensions on device c03ea200(lo)
eth0: no IPv6 routers present
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.

--qDbXVdCdHGoSgWSk--
