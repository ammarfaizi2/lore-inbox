Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTANNfV>; Tue, 14 Jan 2003 08:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTANNfV>; Tue, 14 Jan 2003 08:35:21 -0500
Received: from services.cam.org ([198.73.180.252]:20558 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S263366AbTANNfG>;
	Tue, 14 Jan 2003 08:35:06 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Greg KH <greg@kroah.com>
Subject: Re: usb mouse and 2.5.56bk
Date: Tue, 14 Jan 2003 08:44:17 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200212141215.49449.tomlins@cam.org> <200301122242.01033.tomlins@cam.org> <20030114012319.GD10764@kroah.com>
In-Reply-To: <20030114012319.GD10764@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_T5IPEB44YYGUZCHYZ6E1"
Message-Id: <200301140844.17839.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_T5IPEB44YYGUZCHYZ6E1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On January 13, 2003 08:23 pm, Greg KH wrote:
> On Sun, Jan 12, 2003 at 10:42:01PM -0500, Ed Tomlinson wrote:
> > Greg,
> >
> > Something strange with 2.5.56.  My usb mouse is no longer working
> > after boot.  I can get it to work by repluging it.  Here is my
> > dmesg ang the init.d/local that should make sure the modules needed
> > are loaded.  Before tring to replug I unloaded and reloaded hid and
> > psmouse to see if this would fix things (it did not).
> >
> > I suspect the changeset below:
> >
> > ChangeSet@1.889.19.1, 2003-01-09 10:29:40-08:00, greg@kroah.com
> >
> > which got added just before .56 - I have been tracking bk fairly
> > closely and all was working up to the version of 55bk built at 8am
> > on the 9th.
>
> Hm, that single changeset only modified the ehci driver, which should
> not bother your USB mouse at all, unless it's a USB 2.0 mouse :)
>
> It looks like from your logs that the usb core saw a bunch of devices.
> What does /proc/bus/usb/devices look like after booting, when your mous=
e
> is not working?  The log also shows that a usb mouse was found by the
> hid driver and bound to it, so I don't know why it wouldn't be working.

I used tar on my sysfs mount point (this did not work cleanly...) and hav=
e
attached the tar and the dmesg log from the boot.  The last message in
the log, which is from hid, was produced after the tar, when I replugged
the mouse.

Kernel is now 2.5.58.

Ed Tomlinson

--------------Boundary-00=_T5IPEB44YYGUZCHYZ6E1
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="58.log"
Content-Disposition: attachment; filename="58.log"
Content-Transfer-Encoding: quoted-printable

Linux version 2.5.58 (ed@oscar) (gcc version 2.95.4 20011002 (Debian prer=
elease)) #2 Tue Jan 14 08:25:03 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3DLinux ro root=3D2103 console=3Dtty0 con=
sole=3DttyS0,38400 vga=3Dask idebus=3D33 profile=3D1
ide_setup: idebus=3D33
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 400.830 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 790.52 BogoMIPS
Memory: 513264k/524224k available (1323k kernel code, 10200k reserved, 77=
8k data, 80k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Enabling new style K6 write allocation for 511 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.94 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc160
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc188, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
aio_setup: sizeof(struct page) =3D 40
Journalled Block Device driver loaded
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA MVP3 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 12
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide3 at 0xb400-0xb407,0xb802 on irq 12
hda: host protected area =3D> 1
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=3D26853/16/63, UDMA(=
33)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hde: host protected area =3D> 1
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=3D77557/16/63, UDMA=
(100)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: host protected area =3D> 1
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=3D77557/16/63, UDMA=
(100)
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driv=
er v2.0
uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 10, io base 0000a400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecate=
d.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,3), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide2(33,3)) for (ide2(33,3))
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
hub 1-1:0: USB hub found
hub 1-1:0: 4 ports detected
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 4
hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 4, assigned address 5
reiserfs: replayed 33 transactions in 2 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 80k freed
Adding 393552k swap on /dev/hda1.  Priority:1 extents:1
Adding 393584k swap on /dev/hde1.  Priority:1 extents:1
Adding 393584k swap on /dev/hdg1.  Priority:1 extents:1
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 9, want irq 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) bloc=
k.
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xc000, 00:C0:F0:32:30:70, IRQ 9.
via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 9 for device 00:08.0
IRQ routing conflict for 00:08.0, have irq 11, want irq 9
eth1: VIA VT86C100A Rhine at 0xed120000, 00:80:c8:f9:ee:ba, IRQ 11.
eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 000=
0.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
IPv4 over IPv4 tunneling driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Module parport cannot be unloaded due to unsafe usage in include/linux/mo=
dule.h:424
Module parport_pc cannot be unloaded due to unsafe usage in include/linux=
/module.h:424
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,5), size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30
reiserfs: checking transaction log (ide0(3,5)) for (ide0(3,5))
reiserfs: replayed 15 transactions in 1 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,5), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide2(33,5)) for (ide2(33,5))
reiserfs: replayed 8 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide3(34,3), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide3(34,3)) for (ide3(34,3))
reiserfs: replayed 27 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide3(34,5), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide3(34,5)) for (ide3(34,5))
reiserfs: replayed 1 transactions in 0 seconds
Using r5 hash to sort names
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
ip_tables: (C) 2000-2002 Netfilter core team
Module ip_tables cannot be unloaded due to unsafe usage in include/linux/=
module.h:424
Module tulip cannot be unloaded due to unsafe usage in include/linux/modu=
le.h:424
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntr=
ack
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
soundcore: Unknown symbol errno
cs46xx: Unknown symbol unregister_sound_midi
cs46xx: Unknown symbol unregister_sound_mixer
cs46xx: Unknown symbol register_sound_dsp
cs46xx: Unknown symbol unregister_sound_dsp
cs46xx: Unknown symbol register_sound_mixer
cs46xx: Unknown symbol register_sound_midi
lp0: using parport0 (polling).
Module af_packet cannot be unloaded due to unsafe usage in include/linux/=
module.h:424
Module ppp_async cannot be unloaded due to unsafe usage in include/linux/=
module.h:424
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Module bsd_comp cannot be unloaded due to unsafe usage in include/linux/m=
odule.h:424
PPP Deflate Compression module registered
Module ppp_deflate cannot be unloaded due to unsafe usage in include/linu=
x/module.h:424
Module ipchains cannot be unloaded due to unsafe usage in include/linux/m=
odule.h:424
usb 1-2: USB disconnect, address 3
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 6
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Optical] =
on usb-00:07.2-2

--------------Boundary-00=_T5IPEB44YYGUZCHYZ6E1
Content-Type: application/x-tgz;
  name="sysfs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sysfs.tar.gz"

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
/fwXxKfzf5aHf23mX+Ty3yDu5j8+f7blvy3yv6TK/P43iI/n/0x3/23y3zzx+98g6ua/fP7F+fim
szVAzX//Wyy/F5h/CJ/M/3m+/be5/WeF3/8HUTf/rINt1T/WbP/3fLX/e1mf//y+BfzJy3h1ytnT
z9X8780/3ev8s838k13mnz79XM3/3vyTl0mnx2g2/3Q1/6IqH5x/9TJZnXLy9HM1/5r57/P2fzv/
fNf5u/0/Rd38473OP9nMP95l/vHTz9X81/Nf3JwdVP5Tyn+C+Hj+h5T/5PKfIOrmv3z+xc18Ohu8
7yYTbnH9Z1n6+T+Iuvl/GJ/v5fqPP+afJ5Xf/wSx5fa/x+t/1uv/9b8Esm3+yYvkZd7RMZo9/l+t
/0yL9JOf/+p/BEhXZ5qsTvUJp2v+W+ffVQrUZv5J2Xj+7U7X/LfMP+3sGM3nn1SNbv9POVXz33b7
7+wYzeZfbuafNLn9P+HkzL92/qvPbFfHaDP/5bvvOP8nnpz53//5b7H/x/+J9d9BbJv/8k71665+
C9D89p8WWdz08V/L0zX/LfOP9zn/tNH8n3Kq5l/3/f+iy98CtLj/L/z+J4xP5n846/9W24CZfwB1
81+HaZ3d+7fKf/Lisd//fx7+tT1r86+ff4fHaJH/5OVj6386CX+PzH/L/JOv95X/bG7/+cPrP++H
v23P2vy3zH+/9/9Z1W7+7v+b2Tr/Do/R5v6/eGz9bye//Dky/9r5px3e+lvNv4h3vv2nTztf86+b
f6fHaD7/uNz98d8Tz9X86+7/93j7Lze3/6zR/b/bf0tb5t/pMZrPf3n73/3x/9NOzvxr5t9d9r/S
4vaf7n77f+K5mv+9+Xf5u/+VFrf/asef/55+cua/nv/15Pqn4WDW7cLvWy36fyv9/2Hcm/8zXATU
fP55bv+nMO7Pv/tfAraZv/U/YXw0/4O4/vP2/t/+D4F8PP9DuP7ztv85L13/E0Td/K8Hs+vpbP7T
9bCbL4VG1/9l1fr6T/v/hlE3/5vRbDy47O5uoMX6r0r/bxi189/stNDZMZrf/xdx7PrfIB6Y/ypn
Oe7iGM33/0iysti2/ndyHXd3aub/8PyrLo7Rav7ZY/Pv5NTM/+P5H8D637vH//Z/DKNu/qtb13mH
x2iz/0ua1ub/dzf+7k7P/GvnP+zwGK3mX7/++27+3Z2e+dfO/6zDY7SZf1K//u9u/t2dnvnXzn/Q
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

--------------Boundary-00=_T5IPEB44YYGUZCHYZ6E1--

