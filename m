Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280159AbRKEDa1>; Sun, 4 Nov 2001 22:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280161AbRKEDaT>; Sun, 4 Nov 2001 22:30:19 -0500
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:47628 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S280159AbRKEDaK>; Sun, 4 Nov 2001 22:30:10 -0500
Subject: Re: Via Onboard Audio - Round #2
From: Sean Middleditch <elanthis@awesomeplay.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE54731.FC9437CE@mandrakesoft.com>
In-Reply-To: <1004849558.457.15.camel@stargrazer> 
	<3BE4CC20.5FFEC4B5@mandrakesoft.com> <1004851818.457.24.camel@stargrazer> 
	<3BE54731.FC9437CE@mandrakesoft.com>
Content-Type: multipart/mixed; boundary="=-IOJ0IEuKdvRyL6wmBAM6"
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 04 Nov 2001 22:34:35 -0500
Message-Id: <1004931275.2104.0.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IOJ0IEuKdvRyL6wmBAM6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Aye, made the changes, here is the output.

On Sun, 2001-11-04 at 08:48, Jeff Garzik wrote:
> Sean Middleditch wrote:
> > drivers can handle it.  This is a limitation and/or problem with Linux
> > and it's Via Audio driver.  How can I get around this, or do I need to
> > reinstall WindowsXP to use the audio?
> 
> This has absolutely nothing to do with the audio driver.
> 
> Linux is having trouble with your PCI IRQ routing table that is
> presented by your BIOS to Linux.
> 
> Can you provide 'dmesg -s 16384' output, after changing line 7 of
> arch/i386/kernel/pci-i386.h thusly:
> -#undef DEBUG
> +#define DEBUG 1
> 
> This will show me your PCI IRQ routing table.
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 


--=-IOJ0IEuKdvRyL6wmBAM6
Content-Description: requested output
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Linux version 2.4.13 (root@novalayer) (gcc version 2.95.4 20011006 (Debian =
prerelease)) #4 Sun Nov 4 16:43:12 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: root=3D/dev/hda3 ro
Initializing CPU#0
Detected 896.925 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1789.13 BogoMIPS
Memory: 236636k/245760k available (772k kernel code, 8668k reserved, 224k d=
ata, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff c1c7fbff 00000000, vendor =3D 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c7fbff 00000000 00000000
CPU: AMD Mobile AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 896.8749 MHz.
..... host bus clock speed is 199.3054 MHz.
cpu: 0, clocks: 1993054, slice: 996527
CPU0<T0:1993040,T1:996512,D:1,S:996527,C:1993054>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00f6d90
PCI: BIOS32 Service Directory entry at 0xfd690
PCI: BIOS probe returned s=3D00 hw=3D01 ver=3D02.10 l=3D01
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf50
00:09 slot=3D00 0:55/0010 1:57/0200 2:00/def8 3:00/def8
00:0b slot=3D00 0:56/0800 1:00/def8 2:00/def8 3:00/def8
00:0a slot=3D00 0:56/0800 1:00/def8 2:00/def8 3:00/def8
00:13 slot=3D00 0:55/0010 1:00/def8 2:00/def8 3:00/def8
00:00 slot=3D00 0:56/0020 1:00/def8 2:00/def8 3:00/def8
00:07 slot=3D00 0:55/0010 1:56/0800 2:56/0020 3:57/0200
00:01 slot=3D00 0:56/0020 1:00/def8 2:00/def8 3:00/def8
PCI: Attempting to find IRQ router for 1106:0596
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: IRQ fixup
00:0a.0: ignoring bogus IRQ 255
IRQ for 00:0a.0:0 -> PIRQ 56, mask 0800, excl 0000 -> newirq=3D0 ... failed
PCI: Allocating resources
PCI: Resource ec000000-efffffff (f=3D1208, d=3D0, p=3D0)
PCI: Resource 00001840-0000184f (f=3D101, d=3D0, p=3D0)
PCI: Resource 00001800-0000181f (f=3D101, d=3D0, p=3D0)
PCI: Resource 00001000-000010ff (f=3D101, d=3D0, p=3D0)
PCI: Resource 00001854-00001857 (f=3D105, d=3D0, p=3D0)
PCI: Resource 00001850-00001853 (f=3D101, d=3D0, p=3D0)
PCI: Resource e8000000-e800ffff (f=3D200, d=3D0, p=3D0)
PCI: Resource 00001858-0000185f (f=3D109, d=3D0, p=3D0)
PCI: Resource ffbfe000-ffbfefff (f=3D200, d=3D0, p=3D0)
PCI: Resource 00001400-000014ff (f=3D101, d=3D0, p=3D0)
PCI: Resource e8010000-e80100ff (f=3D200, d=3D0, p=3D0)
PCI: Resource e8100000-e817ffff (f=3D200, d=3D0, p=3D0)
PCI: Resource f0000000-f7ffffff (f=3D1208, d=3D0, p=3D0)
PCI: Sorting device list...
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.119 (20011009) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SH=
ARE_IRQ SERIAL_PCI enabled
block: 128 slots per queue, batch=3D16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3308 blocks [1 disk] into ram disk... |=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08done.
Freeing initrd memory: 3308k freed
VFS: Mounted root (cramfs filesystem).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK2017GAP, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB), CHS=3D38760/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [2432/255/63] p1 p2 p3
cramfs: wrong magic
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=3D2
Freeing unused kernel memory: 204k freed
spurious 8259A interrupt: IRQ7.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 530136k swap-space (priority -1)
Real Time Clock Driver v1.10e
8139too Fast Ethernet driver 0.9.20
IRQ for 00:0b.0:0 -> PIRQ 56, mask 0800, excl 0000 -> newirq=3D11 -> assign=
ing IRQ 11 ... OK
PCI: Assigned IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf881000, 00:02:a5:a1:03:ee, IRQ 1=
1
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
IRQ for 00:07.2:3 -> PIRQ 57, mask 0200, excl 0000 -> newirq=3D9 -> assigni=
ng IRQ 9 ... OK
PCI: Assigned IRQ 9 for device 00:07.2
uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Intel PCIC probe: not found.
hub.c: USB new device connect on bus1/2, assigned device number 2
ds: no socket drivers loaded!
usb.c: USB device 2 (vend/prod 0x46d/0xc00e) is not claimed by any active d=
river.
mice: PS/2 mouse device common for all mice
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech Logitech] on usb1:2.0
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb-uhci.c: $Revision: 1.268 $ time 17:06:18 Nov  4 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
Via 686a audio driver 1.1.14b
IRQ for 00:07.5:2 -> PIRQ 56, mask 0020, excl 0000 -> newirq=3D5 -> got IRQ=
 11
PCI: Found IRQ 11 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00:0b.0
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: timeout while reading AC97 codec (0x800000)
ac97_codec: AC97  codec, id: 0x4144:0x5361 (Unknown)
via82cxxx: board #1 at 0x1000, IRQ 5

--=-IOJ0IEuKdvRyL6wmBAM6--

