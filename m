Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbSLLA6F>; Wed, 11 Dec 2002 19:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbSLLA6E>; Wed, 11 Dec 2002 19:58:04 -0500
Received: from mail.copper.net ([65.247.64.20]:51208 "EHLO bert.copper.net")
	by vger.kernel.org with ESMTP id <S267395AbSLLA6A>;
	Wed, 11 Dec 2002 19:58:00 -0500
Subject: orinoco_cs not working in 2.5.51
From: Thomas Molina <tmolina@copper.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-kN3fETBD+I0I/QjF6Fge"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 18:56:44 -0600
Message-Id: <1039654621.1410.4.camel@lap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kN3fETBD+I0I/QjF6Fge
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After building 2.5.51 I am still unable to unable to load and configure
drivers for an eth0 wireless interface on my Presario 12XL325 laptop. 
The
SMC2632W card works on all 2.4 kernels and 2.5 kernels through  2.5.47
as
previously documented in messages to this list.  Nothing after 47 will
load and configure the eth0 device.

Mindful of the unsettled nature of module loading in latter 2.5
versions,
I do a build with modular components and a build with everything built
in.
Rusty Russell's latest module init tools work well with both 2.4 and 2.5
kernels, so I'm skeptical that module loading problems are the cause of
my
problem.

I've included a copy of my dmesg output, together with /proc/interrupts,
and /proc/ioports for the run in question.  The output shows orinoco_cs
does a RequestIRQ and gets a resource in use messsage.  Running the
dhclient program gives an eth0; no such device message.




--=-kN3fETBD+I0I/QjF6Fge
Content-Disposition: attachment; filename=dmesg.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg.txt; charset=UTF-8

Linux version 2.5.51-tm1 (tmolina@lap) (gcc version 3.2 20020903 (Red Hat L=
inux 8.0 3.2-7)) #1 Wed Dec 11 11:55:28 CST 2002
Video mode to be used for restore is 318
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000077f0000 (usable)
 BIOS-e820: 00000000077f0000 - 00000000077ffc00 (ACPI data)
 BIOS-e820: 00000000077ffc00 - 0000000007800000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
119MB LOWMEM available.
On node 0 totalpages: 30704
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 26608 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ro root=3D/dev/hda5 vga=3D792 pci=3Dusepirqmask
Initializing CPU#0
Detected 647.340 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1265.66 BogoMIPS
Memory: 117444k/122816k available (2268k kernel code, 4820k reserved, 853k =
data, 140k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfd83e, last bus=3D1
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 228 entries (12 bytes)
biovec pool[1]:   4 bvecs: 228 entries (48 bytes)
biovec pool[2]:  16 bvecs: 228 entries (192 bytes)
biovec pool[3]:  64 bvecs: 228 entries (768 bytes)
biovec pool[4]: 128 bvecs: 114 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  57 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 9 of bridge 00:07.4 [8080:808f]
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
aio_setup: sizeof(struct page) =3D 40
[c1176040] eventpoll: successfully initialized.
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=3D0x378
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
i2c-philips-par.o: i2c Philips parallel port adapter module version 2.6.4 (=
20020719)
i2c-philips-par.o: attaching to parport0
i2c-dev.o: Registered 'Philips Parallel port adapter' as minor 0
i2c-elv.o: i2c ELV parallel port adapter module version 2.6.4 (20020719)
i2c-velleman.o: i2c Velleman K8000 adapter module version 2.6.4 (20020719)
i2c-velleman.o: Port 0x378 already in use.
i2c-algo-pcf.o: i2c pcf8584 algorithm module version 2.6.4 (20020719)
i2c-elektor.o: i2c pcf8584-isa adapter module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
vesafb: framebuffer at 0xf5000000, mapped to 0xc8000000, size 8192k
vesafb: mode is 1024x768x32, linelength=3D4096, pages=3D1
vesafb: protected mode interface info at c000:6812
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:8:8:8, shift=3D0:16:8:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
parport0: no more devices allowed
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Linux agpgart interface v1.0 (c) Dave Jones
agpgart: Unsupported VIA chipset (device id: 0601), you might want to try a=
gp_try_unsupported=3D1.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_pci.c 0.13a (Jean Tourrilhes <jt@hpl.hp.com>)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-220, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area =3D> 1
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=3D38760/16/63, UDMA(3=
3)
 hda: hda1 hda2 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
Console: switching to colour frame buffer device 128x48
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.0
PCI: Found IRQ 11 for device 00:07.2
uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 11, io base 00001400
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
Yenta IRQ list 0018, PCI irq9
Socket status: 30000010
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
scx200_acb: NatSemi SCx200 ACCESS.bus Driver
i2c-proc.o version 2.6.4 (20020719)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48=
:18 2002 UTC).
no UART detected at 0xffff
ALSA sound/drivers/mtpav.c:592: MTVAP port 0x378 is busy
ALSA sound/drivers/mpu401/mpu401.c:68: specify port
PCI: Found IRQ 9 for device 00:07.5
PCI: Setting latency timer of device 00:07.5 to 64
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: VIA 82C686A/B at 0x1000, irq 9
oprofile: using timer interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Adding 113360k swap on /dev/hda6.  Priority:-1 extents:1
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfff=
ff
orinoco_cs: RequestIRQ: Resource in use
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, In VT82C686 AC97 Audio=20
  1000-10ff : VIA686A
1400-141f : VIA Technologies, In USB
  1400-141f : uhci-hcd
1420-142f : VIA Technologies, In VT82C586B PIPC Bus M
  1420-1427 : ide0
  1428-142f : ide1
1430-1433 : VIA Technologies, In VT82C686 AC97 Audio=20
1434-1437 : VIA Technologies, In VT82C686 AC97 Audio=20
1438-143f : Conexant HSF 56k Data/Fax Mod
1800-18ff : PCI CardBus #02
1c00-1cff : PCI CardBus #02
8000-80ff : VIA Technologies, In VT82C686 [Apollo Sup
           CPU0      =20
  0:     167131          XT-PIC  timer
  1:        409          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  Texas Instruments PCI1410 PC card Card, VI=
A686A
 11:          0          XT-PIC  uhci-hcd
 12:         27          XT-PIC  i8042
 14:       2722          XT-PIC  ide0
 15:         10          XT-PIC  ide1
NMI:          0=20
ERR:          0

--=-kN3fETBD+I0I/QjF6Fge--

