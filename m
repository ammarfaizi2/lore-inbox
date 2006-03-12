Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWCLAGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWCLAGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 19:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWCLAGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 19:06:42 -0500
Received: from h41n1c1o1031.bredband.skanova.com ([213.65.32.41]:56520 "EHLO
	nexon.borjesson.homedns.org") by vger.kernel.org with ESMTP
	id S1751334AbWCLAGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 19:06:42 -0500
Date: Sun, 12 Mar 2006 01:06:25 +0100
From: Patrick =?utf-8?Q?B=F6rjesson?= <psycho@rift.ath.cx>
To: linux-kernel@vger.kernel.org
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Message-ID: <20060312000621.GA8911@nexon>
Reply-To: psycho@rift.ath.cx
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <200601281913.50169.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Just to let you know, I've had the same problem on x86-64. It's an
> incredibly rare fault here and I've not been able to reproduce it.
> However, I cannot help but notice that all of the reporters so far
> have been running the binary NVIDIA driver, including myself.
>=20
> I would not be surprised if running without the NVIDIA driver
> eliminated the problem.

Not running either with the NVIDIA driver or with x86-64 on the machine
I'm getting this on, but I get it fairly often (as in: today I've
probably gotten it at least 5-10 times). It seems it's pretty bound by
either high CPU or disk usage, since I've always gotten it while
compiling stuff so far. Although my system doesn't hard lock if I get
this error; I can at least run most commands and ssh into it.

Not sure if everything in the dmesg output is relevant, but one can
never be sure, so I'm pasting the entire one. Flame on if I'm spamming
you ;)

Oh btw. I'm not subscribed to the mailinglist, so if you'd be kind
enough to CC me I'd be grateful.

Hope this helps,
Patrick B=EF=BF=BDrjesson

---------- dmesg output ----------
Linux version 2.6.15-gentoo-r7 (root@scrapheap) (gcc version 3.4.5 (Gentoo =
3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #3 PREEMPT Sat Mar 11 23:46:29 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126972 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e40
ACPI: RSDT (v001 ASUS   A7S333   0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7S333   0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7S333   0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7S333   0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7S333   0x00001000 MSFT 0x0100000b) @ 0x00000000
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=3D/dev/hdc3 udev video=3Dvesafb:ywrap,mtrr,1024x7=
68-16@85 splash=3Dsilent,theme:emergence CONSOLE=3D/dev/tty1 quiet
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1311.863 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514508k/524272k available (2480k kernel code, 9208k reserved, 684k =
data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2627.25 BogoMIPS (lpj=3D52=
54503)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c60)
checking if image is initramfs... it is
Freeing initrd memory: 789k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf19a0, last bus=3D1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Enabling SiS 96x SMBus.
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:01: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:01: ioport range 0xe480-0xe4ff has been reserved
pnp: 00:01: ioport range 0xe600-0xe61f has been reserved
pnp: 00:01: ioport range 0x480-0x48f has been reserved
pnp: 00:0e: ioport range 0x290-0x297 has been reserved
pnp: 00:0e: ioport range 0x500-0x507 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e7000000-e7ffffff
  PREFETCH window: ef700000-febfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1142120887.156:1): initialized
NTFS driver 2.1.25 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected SiS 745 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized drm 1.0.0 20040925
vesafb: unrecognized option mtrr
vesafb: NVidia Corporation, NV17 () Board, Chip Rev A2 (OEM: NVidia)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:ede0
vesafb: pmi: set display start =3D c00cee25, set palette =3D c00ceeaa
vesafb: pmi: ports =3D b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c9=
03 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03=20
vesafb: VBIOS/hardware supports DDC2 transfers
      Display is GTF capable
vesafb: monitor limits: vf =3D 160 Hz, hf =3D 96 kHz, clk =3D 250 MHz
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=3D3750
Console: switching to colour frame buffer device 128x48
fbsplash: console 0 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 0
vesafb: framebuffer at 0xf0000000, mapped to 0xe0880000, using 7500k, total=
 65536k
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKD] -> GSI 5 (level, low) ->=
 IRQ 5
eth0: RealTek RTL-8029 found at 0xa800, IRQ 5, 00:00:21:E4:85:F0.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS745 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 91000D8, ATA DISK drive
hdb: WDC WD400BB-60AUA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6E040L0, ATA DISK drive
hdd: SONY CD-RW CRX225E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 19545120 sectors (10007 MB) w/512KiB Cache, CHS=3D19390/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(1=
00)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 hdb6 >
hdc: max request size: 128KiB
hdc: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(3=
3)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:=20
PCI0 PCI1 PS2K PS2M USB0 USB1 MC97=20
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
kjournald starting.  Commit interval 5 seconds
Adding 999328k swap on /dev/hdc2.  Priority:-1 extents:1 across:999328k
EXT3 FS on hdc3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:02.2[D] -> Link [LNKD] -> GSI 5 (level, low) ->=
 IRQ 5
ohci_hcd 0000:00:02.2: OHCI Host Controller
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.2: irq 5, io mem 0xe6800000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:00:02.3[A] -> Link [LNKH] -> GSI 6 (level, low) ->=
 IRQ 6
ohci_hcd 0000:00:02.3: OHCI Host Controller
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.3: irq 6, io mem 0xe6000000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usb 1-1: new full speed USB device using ohci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.4: new full speed USB device using ohci_hcd and address 3
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
  Vendor: Generic   Model: USB SD Reader     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
  Vendor: Generic   Model: USB CF Reader     Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 0:0:0:1: Attached scsi removable disk sdb
sd 0:0:0:1: Attached scsi generic sg1 type 0
  Vendor: Generic   Model: USB SM Reader     Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 0:0:0:2: Attached scsi removable disk sdc
sd 0:0:0:2: Attached scsi generic sg2 type 0
  Vendor: Generic   Model: USB MS Reader     Rev: 1.03
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 0:0:0:3: Attached scsi removable disk sdd
sd 0:0:0:3: Attached scsi generic sg3 type 0
usb-storage: device scan complete
------------[ cut here ]------------
kernel BUG at mm/rmap.c:486!
invalid operand: 0000 [#1]
PREEMPT=20
Modules linked in: ehci_hcd ohci_hcd
CPU:    0
EIP:    0060:[<c0152fd0>]    Not tainted VLI
EFLAGS: 00010286   (2.6.15-gentoo-r7)=20
EIP is at page_remove_rmap+0x30/0x40
eax: ffffffff   ebx: cbb07b8c   ecx: 0001dac2   edx: c13b5840
esi: b7ee3000   edi: c13b5840   ebp: c8f5be30   esp: c8f5bd8c
ds: 007b   es: 007b   ss: 0068
Process i686-pc-linux-g (pid: 5448, threadinfo=3Dc8f5a000 task=3Dde1f1ab0)
Stack: 00003ff4 cbb07b8c c014c0b6 c13b5840 b7ee3000 1dac2025 1dac2025 00000=
000=20
       fffffffb defc31e0 b7fbc000 d3448b80 b7fbc000 c8f5be30 c014c265 c0449=
0b4=20
       df6f738c d3448b7c b7ed3000 b7fbc000 c8f5be30 00000000 b7fbbfff d3448=
b7c=20
Call Trace:
 [<c014c0b6>] zap_pte_range+0x156/0x250
 [<c014c265>] unmap_page_range+0xb5/0x140
 [<c014c3df>] unmap_vmas+0xef/0x1f0
 [<c01511c7>] exit_mmap+0x77/0x110
 [<c01165d7>] mmput+0x37/0xb0
 [<c011b38b>] do_exit+0xeb/0x440
 [<c011b754>] do_group_exit+0x34/0xa0
 [<c0125657>] get_signal_to_deliver+0x217/0x360
 [<c010307e>] do_signal+0x6e/0x150
 [<c014d0e5>] do_wp_page+0x1e5/0x2e0
 [<c0167c5c>] vfs_lstat+0x1c/0x70
 [<c0113607>] do_page_fault+0x2a7/0x5a8
 [<c0113360>] do_page_fault+0x0/0x5a8
 [<c0103197>] do_notify_resume+0x37/0x3c
 [<c0103356>] work_notifysig+0x13/0x19
Code: 24 0c 83 42 08 ff 0f 98 c0 84 c0 74 1a 8b 42 08 40 78 18 c7 44 24 04 =
ff ff ff ff c7 04 24 10 00 00 00 e8 44 ef fe ff 83 c4 08 c3 <0f> 0b e6 01 e=
f 1f 38 c0 eb de 8d b6 00 00 00 00 83 ec 2c 89 5c=20
 <1>Fixing recursive fault but reboot is needed!
scheduling while atomic: i686-pc-linux-g/0x00000002/5448
 [<c036a1a7>] schedule+0x587/0x660
 [<c0103356>] work_notifysig+0x13/0x19
 [<c0152fe5>] try_to_unmap_one+0x5/0x230
 [<c011b52a>] do_exit+0x28a/0x440
 [<c01190b7>] printk+0x17/0x20
 [<c0103ff0>] do_invalid_op+0x0/0xb0
 [<c0103c65>] die+0x185/0x190
 [<c0104092>] do_invalid_op+0xa2/0xb0
 [<c0152fd0>] page_remove_rmap+0x30/0x40
 [<c0176bd5>] dput+0x55/0x290
 [<c016d37e>] __link_path_walk+0xbce/0xf70
 [<c0140ab4>] bad_range+0x34/0x50
 [<c01034ef>] error_code+0x4f/0x54
 [<c0152fd0>] page_remove_rmap+0x30/0x40
 [<c014c0b6>] zap_pte_range+0x156/0x250
 [<c014c265>] unmap_page_range+0xb5/0x140
 [<c014c3df>] unmap_vmas+0xef/0x1f0
 [<c01511c7>] exit_mmap+0x77/0x110
 [<c01165d7>] mmput+0x37/0xb0
 [<c011b38b>] do_exit+0xeb/0x440
 [<c011b754>] do_group_exit+0x34/0xa0
 [<c0125657>] get_signal_to_deliver+0x217/0x360
 [<c010307e>] do_signal+0x6e/0x150
 [<c014d0e5>] do_wp_page+0x1e5/0x2e0
 [<c0167c5c>] vfs_lstat+0x1c/0x70
 [<c0113607>] do_page_fault+0x2a7/0x5a8
 [<c0113360>] do_page_fault+0x0/0x5a8
 [<c0103197>] do_notify_resume+0x37/0x3c
 [<c0103356>] work_notifysig+0x13/0x19

--=20
/  ()  The ASCII Ribbon Campaign - against HTML Email
\  /\   and proprietary formats.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEE2X9zbh2ByF5Kl0RAq4LAKCJPqLcRPKsdicI+M0AgQ6+OkpIkgCgxkWP
2WJWGLAbCHA0QWdf9jLzFCE=
=e+jR
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
