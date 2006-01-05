Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWAEXdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWAEXdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAEXdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:33:45 -0500
Received: from hs-grafik.net ([80.237.205.72]:38918 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S932267AbWAEXdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:33:40 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Re. 2.6.15-mm1
Date: Fri, 6 Jan 2006 00:33:24 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       reiserfs-dev@namesys.com, Dave Airlie <airlied@linux.ie>,
       "Vladimir V. Saveliev" <vs@namesys.com>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org>
In-Reply-To: <20060105144720.25085afa.akpm@osdl.org>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4461564.jUDLI7GLf4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601060033.34276@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4461564.jUDLI7GLf4
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FzavD+9SRClq0WM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_FzavD+9SRClq0WM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 5. Januar 2006 23:47 schrieb Andrew Morton:
> > Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing
> > 0xe0000000,0x4000000
> > Jan  5 16:22:48 t40 last message repeated 2 times
>
> Is that new?

Umm, no. I just thought it could be related to the X oops.

> hm, it's not clear what oopsed.   Can you get a cleaner copy of this?

Hmm. I just rebooted to 2.6.15-mm1 runlevel one, fired up network and an ss=
hd.=20
So I could ssh back to the oops machine. Well. X is clearer but even more=20
errors are in the logs now ;).
=46irst the X oops:
EDAC PCI- Detected Parity Error on 0000:00:1e.0
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c028b7cf
*pde =3D 372d4067
*pte =3D 00000000
Oops: 0000 [#1]
PREEMPT
last sysfs file: /block/hda/queue/scheduler
Modules linked in: aes_i586 cfq_iosched ehci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<c028b7cf>]    Not tainted VLI
EFLAGS: 00013202   (2.6.15-mm1)
EIP is at agp_collect_device_status+0x14/0xd4
eax: 00000058   ebx: f75c1f08   ecx: 00000000   edx: 00000058
esi: 1f000207   edi: c19a80c0   ebp: c19af428   esp: f75c1ed0
ds: 007b   es: 007b   ss: 0068
Process Xorg (pid: 3843, threadinfo=3Df75c0000 task=3Df7890550)
Stack: <0>00003246 1f000217 1f000207 1f000217 f75c1f08 1f000207 c19a80c0=20
c19af428
       <0>c028b9e9 f75c1f08 00000002 00000000 c19720ec 00000000 1f000217=20
c19af400
       <0>00000032 00000001 c028bfb5 c0297262 c19af400 c02972af 1f000207=20
c029727f
Call Trace:
 [<c028b9e9>] agp_generic_enable+0x72/0x10f
 [<c028bfb5>] agp_enable+0xa/0xb
 [<c0297262>] drm_agp_enable+0x2c/0x49
 [<c02972af>] drm_agp_enable_ioctl+0x30/0x39
 [<c029727f>] drm_agp_enable_ioctl+0x0/0x39
 [<c029311d>] drm_ioctl+0x93/0x1e4
 [<c0163664>] do_ioctl+0x64/0x6d
 [<c01637a9>] vfs_ioctl+0x50/0x1be
 [<c01ae603>] write_unix_file+0x0/0x500
 [<c016394b>] sys_ioctl+0x34/0x51
 [<c0102d0f>] sysenter_past_esp+0x54/0x75
Code: 02 00 00 00 e8 94 66 f9 ff 89 c6 84 c0 74 de 89 f2 0f b6 c2 5b 5e c3 =
55=20
57 56 53 83 ec 10 89 54 24 08 89 4c 24 04 e8 bc ff ff ff <8b> 15 20 00 00 0=
0=20
8b 1d 10 00 00 0
0 0f b6 c0 8d 48 04 8d 6c 24
 <3>[drm:drm_release] *ERROR* Device busy: 1 0
EDAC PCI- Detected Parity Error on 0000:00:1e.0

Additionally every second or so I got these console (and kernel of cource)=
=20
message:
EDAC PCI- Detected Parity Error on 0000:00:1e.0
lspci:
0000:00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O=20
Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Control=
ler=20
(rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM=20
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM=20
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM=20
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) US=
B2=20
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface=
=20
Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Control=
ler=20
(rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)=
=20
SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM=
=20
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)=
=20
AC'97 Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf=
=20
[FireGL 9000] (rev 02)
0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus=20
Controller (rev 01)
0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus=20
Controller (rev 01)
0000:02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Etherne=
t=20
Controller (Mobile) (rev 03)
0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.1=
1ab=20
NIC (rev 01)

=46ull log again attached

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--Boundary-01=_FzavD+9SRClq0WM
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mm1-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mm1-2"

Linux version 2.6.15-mm1 (root@t40) (gcc version 4.0.3 20051201 (prerelease=
) (Debian 4.0.2-5)) #1 PREEMPT Thu Jan 5 15:49:14 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff50000 (usable)
 BIOS-e820: 000000003ff50000 - 000000003ff67000 (ACPI data)
 BIOS-e820: 000000003ff67000 - 000000003ff79000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 261968
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32592 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6d70
ACPI: XSDT (v001 IBM    TP-1R    0x00003160  LTP 0x00000000) @ 0x3ff5a6cd
ACPI: FADT (v003 IBM    TP-1R    0x00003160 IBM  0x00000001) @ 0x3ff5a800
ACPI: SSDT (v001 IBM    TP-1R    0x00003160 MSFT 0x0100000e) @ 0x3ff5a9b4
ACPI: ECDT (v001 IBM    TP-1R    0x00003160 IBM  0x00000001) @ 0x3ff66ebc
ACPI: TCPA (v001 IBM    TP-1R    0x00003160 PTL  0x00000001) @ 0x3ff66f0e
ACPI: BOOT (v001 IBM    TP-1R    0x00003160  LTP 0x00000001) @ 0x3ff66fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00003160 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
Detected 1594.846 MHz processor.
Built 1 zonelists
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: BOOT_IMAGE=3DLinux-acpi ro root=3D306 quiet 1
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033444k/1047872k available (3244k kernel code, 13852k reserved, 10=
24k data, 180k init, 130368k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3191.67 BogoMIPS (lpj=3D63=
83342)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 0000=
0180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000=
180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0820)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=3D8
PCI: Using configuration type 1
ACPI: Subsystem revision 20051216
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0a03
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0800
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c04
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0b00
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0303
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for IBM0057
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__PRS failure for PNP0501
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for IBM0071
pnp: PnP ACPI: found 0 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
NET: Registered protocol family 23
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: c0100000-c01fffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: ea000000-ebffffff
  MEM window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-8fff
  MEM window: c0200000-cfffffff
  PREFETCH window: e8000000-efffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
**** SET: Misaligned resource pointer: c19d5502 Type 07 Len 0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
**** SET: Misaligned resource pointer: c19d5502 Type 07 Len 0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Loading Reiser4. See www.namesys.com for a description of Reiser4.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D252.00 Mhz, System=
=3D200.00 MHz
radeonfb: PLL min 20000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)   =20
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
Time: tsc clocksource has been installed.
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 175x65
radeonfb (0000:01:00.0): ATI Radeon Lf=20
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (56 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: dock device not present
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
[drm] Initialized radeon 1.21.0 20051229 on minor 0
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a NS16550A
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
parport0: PC-style at 0x3bc (0x7bc) [PCSPP,TRISTATE]
parport0: irq 7 detected
Time: pit clocksource has been installed.
lp0: using parport0 (polling).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
**** SET: Misaligned resource pointer: c1984c02 Type 07 Len 0
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -=
> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATCS05-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=3D65535/16/63, UDMA(1=
00)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
QLogic Fibre Channel HBA Driver
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x04d8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x04d8, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
usbmon: debugfs is not available
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspri=
ng Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Cli=
e 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Cli=
e 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Jan  5 2006
EDAC PCI- Detected Parity Error on 0000:00:1e.0
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:5=
7:20 2006 UTC).
EDAC PCI- Detected Parity Error on 0000:00:1e.0
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Time: acpi_pm clocksource has been installed.
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
intel8x0_measure_ac97_clock: measured 55464 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
  #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 5
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Using IPI Shortcut mode
swsusp: Resume From Partition /dev/hda5
PM: Checking swsusp image.
PM: Resume from disk failed.
ACPI wakeup devices:=20
 LID SLPB PCI0 UART PCI1 USB0 USB1 AC9M=20
ACPI: (supports S0 S3 S4 S5)
EDAC PCI- Detected Parity Error on 0000:00:1e.0
VFS: Mounted root (reiser4 filesystem) readonly.
=46reeing unused kernel memory: 180k freed
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
Adding 498920k swap on /dev/hda5.  Priority:-1 extents:1 across:498920k
EDAC PCI- Detected Parity Error on 0000:00:1e.0
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input3
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
**** SET: Misaligned resource pointer: f7f24602 Type 07 Len 0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 3
EDAC PCI- Detected Parity Error on 0000:00:1e.0
usb 2-2: configuration #1 chosen from 1 choice
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
**** SET: Misaligned resource pointer: c1b1a3c2 Type 07 Len 0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hci_usb_probe: Can't set isoc interface settings
hub 2-1:1.0: hub_port_status failed (err =3D -71)
hub 2-1:1.0: hub_port_status failed (err =3D -71)
hub 2-1:1.0: hub_port_status failed (err =3D -71)
hub 2-1:1.0: hub_port_status failed (err =3D -71)
usb 3-1: USB disconnect, address 2
EDAC PCI- Detected Parity Error on 0000:00:1e.0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 2-1: USB disconnect, address 2
usb 2-2: USB disconnect, address 3
usb 4-3: new high speed USB device using ehci_hcd and address 2
usb 4-3: configuration #1 chosen from 1 choice
hub 4-3:1.0: USB hub found
hub 4-3:1.0: 4 ports detected
EDAC PCI- Detected Parity Error on 0000:00:1e.0
usb 4-4: new high speed USB device using ehci_hcd and address 3
usb 4-4: configuration #1 chosen from 1 choice
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usb 4-3.1: new high speed USB device using ehci_hcd and address 5
usb 4-3.1: configuration #1 chosen from 1 choice
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usb 4-3.3: new low speed USB device using ehci_hcd and address 6
EDAC PCI- Detected Parity Error on 0000:00:1e.0
usb 4-3.3: configuration #1 chosen from 1 choice
input: Microsoft Microsoft IntelliMouse=AE Explorer as /class/input/input4
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-0000:00:1d.7-3.3
usb 4-3.4: new full speed USB device using ehci_hcd and address 7
usb 4-3.4: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 7 if 0 alt=
 0 proto 2 vid 0x03F0 pid 0x6004
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: configuration #1 chosen from 1 choice
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
  Vendor: TOSHIBA   Model: MK3017GAP         Rev:  0 0
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 58605120 512-byte hdwr sectors (30006 MB)
sda: Write Protect is off
sda: Mode Sense: 33 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 58605120 512-byte hdwr sectors (30006 MB)
sda: Write Protect is off
sda: Mode Sense: 33 00 00 00
sda: assuming drive cache: write through
 sda:<2>EDAC PCI- Detected Parity Error on 0000:00:1e.0
 sda1
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
usb-storage: device scan complete
  Vendor: USB 2.0   Model: Storage Device    Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 08 00 00 00
sdb: assuming drive cache: write through
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 08 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2
sd 2:0:0:0: Attached scsi disk sdb
sd 2:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect =
breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html=
 for details.
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
io scheduler cfq registered
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c028b7cf
*pde =3D 372d4067
*pte =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
last sysfs file: /block/hda/queue/scheduler
Modules linked in: aes_i586 cfq_iosched ehci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<c028b7cf>]    Not tainted VLI
EFLAGS: 00013202   (2.6.15-mm1)=20
EIP is at agp_collect_device_status+0x14/0xd4
eax: 00000058   ebx: f75c1f08   ecx: 00000000   edx: 00000058
esi: 1f000207   edi: c19a80c0   ebp: c19af428   esp: f75c1ed0
ds: 007b   es: 007b   ss: 0068
Process Xorg (pid: 3843, threadinfo=3Df75c0000 task=3Df7890550)
Stack: <0>00003246 1f000217 1f000207 1f000217 f75c1f08 1f000207 c19a80c0 c1=
9af428=20
       <0>c028b9e9 f75c1f08 00000002 00000000 c19720ec 00000000 1f000217 c1=
9af400=20
       <0>00000032 00000001 c028bfb5 c0297262 c19af400 c02972af 1f000207 c0=
29727f=20
Call Trace:
 [<c028b9e9>] agp_generic_enable+0x72/0x10f
 [<c028bfb5>] agp_enable+0xa/0xb
 [<c0297262>] drm_agp_enable+0x2c/0x49
 [<c02972af>] drm_agp_enable_ioctl+0x30/0x39
 [<c029727f>] drm_agp_enable_ioctl+0x0/0x39
 [<c029311d>] drm_ioctl+0x93/0x1e4
 [<c0163664>] do_ioctl+0x64/0x6d
 [<c01637a9>] vfs_ioctl+0x50/0x1be
 [<c01ae603>] write_unix_file+0x0/0x500
 [<c016394b>] sys_ioctl+0x34/0x51
 [<c0102d0f>] sysenter_past_esp+0x54/0x75
Code: 02 00 00 00 e8 94 66 f9 ff 89 c6 84 c0 74 de 89 f2 0f b6 c2 5b 5e c3 =
55 57 56 53 83 ec 10 89 54 24 08 89 4c 24 04 e8 bc ff ff ff <8b> 15 20 00 0=
0 00 8b 1d 10 00 00 00 0f b6 c0 8d 48 04 8d 6c 24=20
 <3>[drm:drm_release] *ERROR* Device busy: 1 0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0
EDAC PCI- Detected Parity Error on 0000:00:1e.0

--Boundary-01=_FzavD+9SRClq0WM--

--nextPart4461564.jUDLI7GLf4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDvazO/aHb+2190pERAkArAJ9R1vLutn+37rsgmCJh/i81cwFIfwCgjz5q
oD1IzFC1tZh8h/3kuqnV3e0=
=nC1T
-----END PGP SIGNATURE-----

--nextPart4461564.jUDLI7GLf4--
