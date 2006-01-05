Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWAERBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWAERBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWAERBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:01:42 -0500
Received: from hs-grafik.net ([80.237.205.72]:33547 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751167AbWAERBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:01:40 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re. 2.6.15-mm1
Date: Thu, 5 Jan 2006 18:01:28 +0100
User-Agent: KMail/1.8.3
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1597335.Ykr9njC4jY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601051801.29007@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1597335.Ykr9njC4jY
Content-Type: multipart/mixed;
  boundary="Boundary-01=_oDVvDXI4HnIvcLg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_oDVvDXI4HnIvcLg
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

just tried 2.6.15-mm1 on my thinkpad. Various aspects that didn't work / lo=
ok=20
good:
Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
Jan  5 16:22:39 t40 last message repeated 10 times
Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices
All over the place logs like this:
Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer: f7db5502=
=20
Type 07 Len 0
Unknown to me so far..
When X startet, the laptops crashed:
Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]: disable_write_barrie=
r=20
(fs/reiser4/wander.c:233)[zam-1055]:
Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier
Jan  5 16:22:43 t40 kernel:
Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing=20
0xe0000000,0x4000000
Jan  5 16:22:48 t40 last message repeated 2 times
Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at=20
0000:00:00.0.
Jan  5 16:22:48 t40 kernel: c028b7cf
Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev cfq_iosche=
d=20
ehci_hcd uhci_hcd
Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)
Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000=20
c19720ec 00000000 1f000217 c1a79400
Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262=20
c1a79400 c02972af 1f000207 c029727f
Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1 0
Jan  5 16:22:58 t40 kernel: SysRq : Emergency Sync
Jan  5 16:22:58 t40 kernel: <4>reiser4[pdflush(172)]: disable_write_barrier=
=20
(fs/reiser4/wander.c:233)[zam-1055]:
Jan  5 16:22:58 t40 kernel: WARNING: disabling write barrier
Jan  5 16:22:59 t40 kernel:

Dunno why. Sysrq worked, however
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

=2Econfig and full bootlog attached.


regards
Alex
=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--Boundary-01=_oDVvDXI4HnIvcLg
Content-Type: text/plain;
  charset="iso-8859-15";
  name="15-mm1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="15-mm1"

Jan  5 09:16:21 t40 kernel: Memory: 1033264k/1047872k available (3072k kern=
el code, 13804k reserved, 1176k data, 168k init, 130368k highmem)
Jan  5 09:16:21 t40 kernel: Checking if this processor honours the WP bit e=
ven in supervisor mode... Ok.
Jan  5 09:16:21 t40 kernel: Calibrating delay using timer specific routine.=
=2E 3193.38 BogoMIPS (lpj=3D6386778)
Jan  5 09:16:21 t40 kernel: Mount-cache hash table entries: 512
Jan  5 09:16:21 t40 kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Jan  5 09:16:21 t40 kernel: CPU: L2 cache: 1024K
Jan  5 09:16:21 t40 kernel: Intel machine check architecture supported.
Jan  5 09:16:21 t40 kernel: Intel machine check reporting enabled on CPU#0.
Jan  5 09:16:21 t40 kernel: mtrr: v2.0 (20020519)
Jan  5 09:16:21 t40 kernel: CPU: Intel(R) Pentium(R) M processor 1600MHz st=
epping 05
Jan  5 09:16:21 t40 kernel: Enabling fast FPU save and restore... done.
Jan  5 09:16:21 t40 kernel: Enabling unmasked SIMD FPU exception support...=
 done.
Jan  5 09:16:21 t40 kernel: Checking 'hlt' instruction... OK.
Jan  5 09:16:21 t40 kernel: ACPI: setting ELCR to 0200 (from 0820)
Jan  5 09:16:21 t40 kernel: softlockup thread 0 started up.
Jan  5 09:16:21 t40 kernel: NET: Registered protocol family 16
Jan  5 09:16:21 t40 kernel: ACPI: bus type pci registered
Jan  5 09:16:21 t40 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, l=
ast bus=3D8
Jan  5 09:16:21 t40 kernel: PCI: Using configuration type 1
Jan  5 09:16:21 t40 kernel: ACPI: Subsystem revision 20050408
Jan  5 09:16:21 t40 kernel: ACPI: Found ECDT
Jan  5 09:16:21 t40 kernel: ACPI: Interpreter enabled
Jan  5 09:16:21 t40 kernel: ACPI: Using PIC for interrupt routing
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 =
7 9 10 11)
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7=
 9 10 11) *0, disabled.
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7=
 9 10 11) *0, disabled.
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7=
 9 10 11) *0, disabled.
Jan  5 09:16:21 t40 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 09:16:21 t40 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan  5 09:16:21 t40 kernel: PCI: Probing PCI hardware (bus 00)
Jan  5 09:16:21 t40 kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment i=
s 0
Jan  5 09:16:21 t40 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:=
1f.1
Jan  5 09:16:21 t40 kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan  5 09:16:21 t40 kernel: ACPI: Embedded Controller [EC] (gpe 28)
Jan  5 09:16:21 t40 kernel: ACPI: Power Resource [PUBS] (on)
Jan  5 16:21:04 t40 irattach: got SIGTERM or SIGINT=20
Jan  5 16:21:04 t40 irattach: Stopping device irda0
Jan  5 16:21:05 t40 irattach: exiting ...=20
Jan  5 16:21:36 t40 kernel: Kernel logging (proc) stopped.
Jan  5 16:21:36 t40 kernel: Kernel log daemon terminating.
Jan  5 16:21:36 t40 exiting on signal 15
Jan  5 09:16:22 t40 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan  5 09:16:22 t40 kernel: pnp: PnP ACPI init
Jan  5 09:16:22 t40 kernel: pnp: PnP ACPI: found 12 devices
Jan  5 09:16:22 t40 kernel: SCSI subsystem initialized
Jan  5 09:16:22 t40 kernel: usbcore: registered new driver usbfs
Jan  5 09:16:22 t40 kernel: usbcore: registered new driver hub
Jan  5 09:16:22 t40 kernel: PCI: Using ACPI for IRQ routing
Jan  5 09:16:22 t40 kernel: PCI: If a device doesn't work, try "pci=3Droute=
irq".  If it helps, post a report
Jan  5 09:16:22 t40 kernel: NET: Registered protocol family 23
Jan  5 09:16:22 t40 kernel: Bluetooth: Core ver 2.7
Jan  5 09:16:22 t40 kernel: NET: Registered protocol family 31
Jan  5 09:16:22 t40 kernel: Bluetooth: HCI device and connection manager in=
itialized
Jan  5 09:16:22 t40 kernel: Bluetooth: HCI socket layer initialized
Jan  5 09:16:22 t40 kernel: Simple Boot Flag at 0x35 set to 0x1
Jan  5 09:16:22 t40 kernel: Machine check exception polling timer started.
Jan  5 09:16:22 t40 kernel: highmem bounce pool size: 64 pages
Jan  5 09:16:22 t40 kernel: inotify device minor=3D63
Jan  5 09:16:22 t40 kernel: Initializing Cryptographic API
Jan  5 09:16:22 t40 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ =
11
Jan  5 09:16:22 t40 kernel: PCI: setting IRQ 11 as level-triggered
Jan  5 09:16:22 t40 kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 09:16:22 t40 kernel: radeonfb: Retreived PLL infos from BIOS
Jan  5 09:16:22 t40 kernel: radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) M=
emory=3D252.00 Mhz, System=3D200.00 MHz
Jan  5 09:16:22 t40 kernel: radeonfb: PLL min 20000 max 35000
Jan  5 09:16:22 t40 kernel: Non-DDC laptop panel detected
Jan  5 09:16:22 t40 kernel: radeonfb: Monitor 1 type LCD found
Jan  5 09:16:22 t40 kernel: radeonfb: Monitor 2 type no found
Jan  5 09:16:22 t40 kernel: radeonfb: panel ID string: SXGA+ Single (85MHz)=
   =20
Jan  5 09:16:22 t40 kernel: radeonfb: detected LVDS panel size from BIOS: 1=
400x1050
Jan  5 09:16:22 t40 kernel: radeondb: BIOS provided dividers will be used
Jan  5 09:16:22 t40 kernel: radeonfb: Dynamic Clock Power Management enabled
Jan  5 09:16:22 t40 kernel: Console: switching to colour frame buffer devic=
e 175x65
Jan  5 09:16:22 t40 kernel: radeonfb (0000:01:00.0): ATI Radeon Lf=20
Jan  5 09:16:22 t40 kernel: ACPI: AC Adapter [AC] (on-line)
Jan  5 09:16:22 t40 kernel: ACPI: Battery Slot [BAT0] (battery present)
Jan  5 09:16:22 t40 kernel: ACPI: Power Button (FF) [PWRF]
Jan  5 16:22:34 t40 syslogd 1.4.1#18: restart.
Jan  5 16:22:34 t40 kernel: klogd 1.4.1#18, log source =3D /proc/kmsg start=
ed.
Jan  5 16:22:36 t40 kernel: Cannot open map file: /boot/System.map-2.6.15-m=
m1.
Jan  5 16:22:36 t40 kernel: No module symbols loaded - kernel modules not e=
nabled.=20
Jan  5 16:22:36 t40 kernel: Linux version 2.6.15-mm1 (root@t40) (gcc versio=
n 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 PREEMPT Thu Jan 5 15:49:=
14 CET 2006
Jan  5 16:22:36 t40 kernel: BIOS-provided physical RAM map:
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 0000000000000000 - 000000000009f000=
 (usable)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000=
 (reserved)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000=
 (reserved)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 0000000000100000 - 000000003ff50000=
 (usable)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 000000003ff50000 - 000000003ff67000=
 (ACPI data)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 000000003ff67000 - 000000003ff79000=
 (ACPI NVS)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 000000003ff80000 - 0000000040000000=
 (reserved)
Jan  5 16:22:36 t40 kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000=
 (reserved)
Jan  5 16:22:36 t40 kernel: 127MB HIGHMEM available.
Jan  5 16:22:36 t40 kernel: 896MB LOWMEM available.
Jan  5 16:22:36 t40 kernel: DMI present.
Jan  5 16:22:37 t40 kernel: ACPI: PM-Timer IO Port: 0x1008
Jan  5 16:22:37 t40 kernel: Allocating PCI resources starting at 50000000 (=
gap: 40000000:bf800000)
Jan  5 16:22:37 t40 kernel: Detected 1594.926 MHz processor.
Jan  5 16:22:37 t40 kernel: Built 1 zonelists
Jan  5 16:22:37 t40 kernel: Enabling fast FPU save and restore... done.
Jan  5 16:22:38 t40 kernel: Enabling unmasked SIMD FPU exception support...=
 done.
Jan  5 16:22:38 t40 kernel: Initializing CPU#0
Jan  5 16:22:38 t40 kernel: Kernel command line: BOOT_IMAGE=3DLinux-acpi ro=
 root=3D306 quiet
Jan  5 16:22:38 t40 kernel: PID hash table entries: 4096 (order: 12, 65536 =
bytes)
Jan  5 16:22:38 t40 kernel: Console: colour VGA+ 80x25
Jan  5 16:22:38 t40 kernel: Dentry cache hash table entries: 131072 (order:=
 7, 524288 bytes)
Jan  5 16:22:38 t40 kernel: Inode-cache hash table entries: 65536 (order: 6=
, 262144 bytes)
Jan  5 16:22:38 t40 kernel: Memory: 1033444k/1047872k available (3244k kern=
el code, 13852k reserved, 1024k data, 180k init, 130368k highmem)
Jan  5 16:22:38 t40 kernel: Checking if this processor honours the WP bit e=
ven in supervisor mode... Ok.
Jan  5 16:22:38 t40 kernel: Calibrating delay using timer specific routine.=
=2E 3191.68 BogoMIPS (lpj=3D6383360)
Jan  5 16:22:38 t40 kernel: Mount-cache hash table entries: 512
Jan  5 16:22:38 t40 kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Jan  5 16:22:38 t40 kernel: CPU: L2 cache: 1024K
Jan  5 16:22:38 t40 kernel: Intel machine check architecture supported.
Jan  5 16:22:38 t40 kernel: Intel machine check reporting enabled on CPU#0.
Jan  5 16:22:38 t40 kernel: mtrr: v2.0 (20020519)
Jan  5 16:22:38 t40 kernel: CPU: Intel(R) Pentium(R) M processor 1600MHz st=
epping 05
Jan  5 16:22:38 t40 kernel: Checking 'hlt' instruction... OK.
Jan  5 16:22:38 t40 kernel: ACPI: setting ELCR to 0200 (from 0820)
Jan  5 16:22:38 t40 kernel: NET: Registered protocol family 16
Jan  5 16:22:38 t40 kernel: ACPI: bus type pci registered
Jan  5 16:22:38 t40 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, l=
ast bus=3D8
Jan  5 16:22:38 t40 kernel: PCI: Using configuration type 1
Jan  5 16:22:38 t40 kernel: ACPI: Subsystem revision 20051216
Jan  5 16:22:38 t40 kernel: ACPI: Found ECDT
Jan  5 16:22:38 t40 kernel: ACPI: Interpreter enabled
Jan  5 16:22:38 t40 kernel: ACPI: Using PIC for interrupt routing
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 =
7 9 10 11)
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7=
 9 10 11) *0, disabled.
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7=
 9 10 11) *0, disabled.
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7=
 9 10 11) *0, disabled.
Jan  5 16:22:38 t40 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7=
 9 10 *11)
Jan  5 16:22:38 t40 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan  5 16:22:38 t40 kernel: PCI quirk: region 1000-107f claimed by ICH4 ACP=
I/GPIO/TCO
Jan  5 16:22:38 t40 kernel: PCI quirk: region 1180-11bf claimed by ICH4 GPIO
Jan  5 16:22:38 t40 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:=
1f.1
Jan  5 16:22:38 t40 kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan  5 16:22:38 t40 kernel: ACPI: Embedded Controller [EC] (gpe 28) interru=
pt mode.
Jan  5 16:22:38 t40 kernel: ACPI: Power Resource [PUBS] (on)
Jan  5 16:22:38 t40 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
Jan  5 16:22:38 t40 irattach: executing: 'echo t40 > /proc/sys/net/irda/dev=
name'
Jan  5 16:22:38 t40 irattach: Starting device irda0
Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
Jan  5 16:22:39 t40 last message repeated 10 times
Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices
Jan  5 16:22:39 t40 kernel: SCSI subsystem initialized
Jan  5 16:22:39 t40 kernel: usbcore: registered new driver usbfs
Jan  5 16:22:39 t40 kernel: usbcore: registered new driver hub
Jan  5 16:22:39 t40 kernel: PCI: Using ACPI for IRQ routing
Jan  5 16:22:39 t40 kernel: PCI: If a device doesn't work, try "pci=3Droute=
irq".  If it helps, post a report
Jan  5 16:22:39 t40 kernel: NET: Registered protocol family 23
Jan  5 16:22:39 t40 kernel: Bluetooth: Core ver 2.8
Jan  5 16:22:39 t40 kernel: NET: Registered protocol family 31
Jan  5 16:22:39 t40 kernel: Bluetooth: HCI device and connection manager in=
itialized
Jan  5 16:22:39 t40 kernel: Bluetooth: HCI socket layer initialized
Jan  5 16:22:39 t40 kernel: PCI: Bridge: 0000:00:01.0
Jan  5 16:22:39 t40 kernel:   IO window: 3000-3fff
Jan  5 16:22:39 t40 kernel:   MEM window: c0100000-c01fffff
Jan  5 16:22:39 t40 kernel:   PREFETCH window: e0000000-e7ffffff
Jan  5 16:22:39 t40 kernel: PCI: Bus 3, cardbus bridge: 0000:02:00.0
Jan  5 16:22:39 t40 kernel:   IO window: 00004000-000040ff
Jan  5 16:22:39 t40 kernel:   IO window: 00004400-000044ff
Jan  5 16:22:39 t40 kernel:   PREFETCH window: e8000000-e9ffffff
Jan  5 16:22:39 t40 kernel:   MEM window: c2000000-c3ffffff
Jan  5 16:22:39 t40 kernel: PCI: Bus 7, cardbus bridge: 0000:02:00.1
Jan  5 16:22:39 t40 kernel:   IO window: 00004800-000048ff
Jan  5 16:22:39 t40 kernel:   IO window: 00004c00-00004cff
Jan  5 16:22:39 t40 kernel:   PREFETCH window: ea000000-ebffffff
Jan  5 16:22:39 t40 kernel:   MEM window: c4000000-c5ffffff
Jan  5 16:22:39 t40 kernel: PCI: Bridge: 0000:00:1e.0
Jan  5 16:22:39 t40 kernel:   IO window: 4000-8fff
Jan  5 16:22:39 t40 kernel:   MEM window: c0200000-cfffffff
Jan  5 16:22:39 t40 kernel:   PREFETCH window: e8000000-efffffff
Jan  5 16:22:39 t40 kernel: **** SET: Misaligned resource pointer: c19d3502=
 Type 07 Len 0
Jan  5 16:22:39 t40 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ =
11
Jan  5 16:22:39 t40 kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:39 t40 kernel: **** SET: Misaligned resource pointer: c19d3502=
 Type 07 Len 0
Jan  5 16:22:39 t40 kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Jan  5 16:22:39 t40 kernel: ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LN=
KB] -> GSI 5 (level, low) -> IRQ 5
Jan  5 16:22:39 t40 kernel: Simple Boot Flag at 0x35 set to 0x1
Jan  5 16:22:39 t40 kernel: Machine check exception polling timer started.
Jan  5 16:22:39 t40 kernel: highmem bounce pool size: 64 pages
Jan  5 16:22:39 t40 kernel: Loading Reiser4. See www.namesys.com for a desc=
ription of Reiser4.
Jan  5 16:22:40 t40 kernel: Initializing Cryptographic API
Jan  5 16:22:40 t40 kernel: io scheduler noop registered
Jan  5 16:22:40 t40 kernel: io scheduler anticipatory registered
Jan  5 16:22:40 t40 kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:40 t40 kernel: radeonfb: Retrieved PLL infos from BIOS
Jan  5 16:22:40 t40 kernel: radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) M=
emory=3D252.00 Mhz, System=3D200.00 MHz
Jan  5 16:22:40 t40 kernel: radeonfb: PLL min 20000 max 35000
Jan  5 16:22:40 t40 kernel: Non-DDC laptop panel detected
Jan  5 16:22:40 t40 kernel: radeonfb: Monitor 1 type LCD found
Jan  5 16:22:40 t40 kernel: radeonfb: Monitor 2 type no found
Jan  5 16:22:40 t40 kernel: radeonfb: panel ID string: SXGA+ Single (85MHz)=
   =20
Jan  5 16:22:40 t40 kernel: radeonfb: detected LVDS panel size from BIOS: 1=
400x1050
Jan  5 16:22:40 t40 kernel: radeondb: BIOS provided dividers will be used
Jan  5 16:22:40 t40 kernel: Time: tsc clocksource has been installed.
Jan  5 16:22:40 t40 kernel: radeonfb: Dynamic Clock Power Management enabled
Jan  5 16:22:40 t40 kernel: Console: switching to colour frame buffer devic=
e 175x65
Jan  5 16:22:40 t40 kernel: radeonfb (0000:01:00.0): ATI Radeon Lf=20
Jan  5 16:22:40 t40 kernel: ACPI: AC Adapter [AC] (on-line)
Jan  5 16:22:40 t40 kernel: ACPI: Battery Slot [BAT0] (battery present)
Jan  5 16:22:40 t40 kernel: ACPI: Power Button (FF) [PWRF]
Jan  5 16:22:40 t40 kernel: ACPI: Lid Switch [LID]
Jan  5 16:22:40 t40 kernel: ACPI: Sleep Button (CM) [SLPB]
Jan  5 16:22:40 t40 kernel: ACPI: Video Device [VID] (multi-head: yes  rom:=
 no  post: no)
Jan  5 16:22:40 t40 kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Jan  5 16:22:40 t40 kernel: ACPI: Processor [CPU] (supports 8 throttling st=
ates)
Jan  5 16:22:40 t40 kernel: ACPI: Thermal Zone [THM0] (56 C)
Jan  5 16:22:40 t40 kernel: ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
Jan  5 16:22:40 t40 kernel: ibm_acpi: http://ibm-acpi.sf.net/
Jan  5 16:22:40 t40 kernel: lp: driver loaded but no devices found
Jan  5 16:22:40 t40 kernel: Real Time Clock Driver v1.12
Jan  5 16:22:40 t40 kernel: Non-volatile memory driver v1.2
Jan  5 16:22:40 t40 kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jan  5 16:22:40 t40 kernel: agpgart: Detected an Intel 855PM Chipset.
Jan  5 16:22:40 t40 kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Jan  5 16:22:40 t40 kernel: [drm] Initialized drm 1.0.1 20051102
Jan  5 16:22:40 t40 kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:40 t40 kernel: [drm] Initialized radeon 1.21.0 20051229 on min=
or 0
Jan  5 16:22:40 t40 kernel: PNP: No PS/2 controller found. Probing ports di=
rectly.
Jan  5 16:22:40 t40 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan  5 16:22:40 t40 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  5 16:22:40 t40 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 2 p=
orts, IRQ sharing enabled
Jan  5 16:22:40 t40 kernel: serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a=
 NS16550A
Jan  5 16:22:40 t40 kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LN=
KB] -> GSI 5 (level, low) -> IRQ 5
Jan  5 16:22:40 t40 kernel: ACPI: PCI interrupt for device 0000:00:1f.6 dis=
abled
Jan  5 16:22:40 t40 kernel: parport0: PC-style at 0x3bc (0x7bc) [PCSPP,TRIS=
TATE]
Jan  5 16:22:40 t40 kernel: parport0: irq 7 detected
Jan  5 16:22:40 t40 kernel: Time: pit clocksource has been installed.
Jan  5 16:22:40 t40 kernel: lp0: using parport0 (polling).
Jan  5 16:22:40 t40 kernel: RAMDISK driver initialized: 16 RAM disks of 409=
6K size 1024 blocksize
Jan  5 16:22:40 t40 kernel: loop: loaded (max 8 devices)
Jan  5 16:22:40 t40 kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@s=
use.de) and petero2@telia.com
Jan  5 16:22:40 t40 kernel: Intel(R) PRO/1000 Network Driver - version 6.1.=
16-k2-NAPI
Jan  5 16:22:40 t40 kernel: Copyright (c) 1999-2005 Intel Corporation.
Jan  5 16:22:40 t40 kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:40 t40 kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Net=
work Connection
Jan  5 16:22:40 t40 kernel: tun: Universal TUN/TAP device driver, 1.6
Jan  5 16:22:40 t40 kernel: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualco=
mm.com>
Jan  5 16:22:40 t40 kernel: Uniform Multi-Platform E-IDE driver Revision: 7=
=2E00alpha2
Jan  5 16:22:40 t40 kernel: ide: Assuming 33MHz system bus speed for PIO mo=
des; override with idebus=3Dxx
Jan  5 16:22:40 t40 kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Jan  5 16:22:40 t40 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Jan  5 16:22:40 t40 kernel: **** SET: Misaligned resource pointer: c1a1bc02=
 Type 07 Len 0
Jan  5 16:22:40 t40 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ =
11
Jan  5 16:22:40 t40 kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LN=
KC] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:40 t40 kernel: ICH4: chipset revision 1
Jan  5 16:22:40 t40 kernel: ICH4: not 100%% native mode: will probe irqs la=
ter
Jan  5 16:22:40 t40 kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS setting=
s: hda:DMA, hdb:pio
Jan  5 16:22:40 t40 kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS setting=
s: hdc:DMA, hdd:pio
Jan  5 16:22:40 t40 kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Jan  5 16:22:40 t40 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan  5 16:22:40 t40 kernel: hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
Jan  5 16:22:40 t40 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan  5 16:22:40 t40 kernel: hda: max request size: 128KiB
Jan  5 16:22:41 t40 kernel: hda: 78140160 sectors (40007 MB) w/7898KiB Cach=
e, CHS=3D65535/16/63, UDMA(100)
Jan  5 16:22:41 t40 kernel: hda: cache flushes not supported
Jan  5 16:22:41 t40 kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
Jan  5 16:22:41 t40 kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Ca=
che, UDMA(33)
Jan  5 16:22:41 t40 kernel: Uniform CD-ROM driver Revision: 3.20
Jan  5 16:22:41 t40 kernel: QLogic Fibre Channel HBA Driver
Jan  5 16:22:41 t40 kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:41 t40 kernel: Yenta: CardBus bridge found at 0000:02:00.0 [10=
14:0512]
Jan  5 16:22:41 t40 kernel: Yenta: Using INTVAL to route CSC interrupts to =
PCI
Jan  5 16:22:41 t40 kernel: Yenta: Routing CardBus interrupts to PCI
Jan  5 16:22:41 t40 kernel: Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022=
, devctl 0x64
Jan  5 16:22:41 t40 kernel: Yenta: ISA IRQ mask 0x04d8, PCI irq 11
Jan  5 16:22:41 t40 kernel: Socket status: 30000006
Jan  5 16:22:41 t40 kernel: pcmcia: parent PCI bridge I/O window: 0x4000 - =
0x8fff
Jan  5 16:22:41 t40 kernel: pcmcia: parent PCI bridge Memory window: 0xc020=
0000 - 0xcfffffff
Jan  5 16:22:41 t40 kernel: pcmcia: parent PCI bridge Memory window: 0xe800=
0000 - 0xefffffff
Jan  5 16:22:41 t40 kernel: ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LN=
KB] -> GSI 5 (level, low) -> IRQ 5
Jan  5 16:22:41 t40 kernel: Yenta: CardBus bridge found at 0000:02:00.1 [10=
14:0512]
Jan  5 16:22:41 t40 kernel: Yenta: Using INTVAL to route CSC interrupts to =
PCI
Jan  5 16:22:41 t40 kernel: Yenta: Routing CardBus interrupts to PCI
Jan  5 16:22:41 t40 kernel: Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022=
, devctl 0x64
Jan  5 16:22:41 t40 kernel: Yenta: ISA IRQ mask 0x04d8, PCI irq 5
Jan  5 16:22:41 t40 kernel: Socket status: 30000006
Jan  5 16:22:41 t40 kernel: pcmcia: parent PCI bridge I/O window: 0x4000 - =
0x8fff
Jan  5 16:22:41 t40 kernel: pcmcia: parent PCI bridge Memory window: 0xc020=
0000 - 0xcfffffff
Jan  5 16:22:41 t40 kernel: pcmcia: parent PCI bridge Memory window: 0xe800=
0000 - 0xefffffff
Jan  5 16:22:41 t40 kernel: usbmon: debugfs is not available
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver usblp
Jan  5 16:22:41 t40 kernel: drivers/usb/class/usblp.c: v0.13: USB Printer D=
evice Class driver
Jan  5 16:22:41 t40 kernel: Initializing USB Mass Storage driver...
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver usb-storage
Jan  5 16:22:41 t40 kernel: USB Mass Storage support registered.
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver hiddev
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver usbhid
Jan  5 16:22:41 t40 kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core=
 driver
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver usbserial
Jan  5 16:22:41 t40 kernel: drivers/usb/serial/usb-serial.c: USB Serial Dri=
ver core
Jan  5 16:22:41 t40 kernel: drivers/usb/serial/usb-serial.c: USB Serial sup=
port registered for Handspring Visor / Palm OS
Jan  5 16:22:41 t40 kernel: drivers/usb/serial/usb-serial.c: USB Serial sup=
port registered for Sony Clie 3.5
Jan  5 16:22:41 t40 kernel: drivers/usb/serial/usb-serial.c: USB Serial sup=
port registered for Sony Clie 5.0
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver visor
Jan  5 16:22:41 t40 kernel: drivers/usb/serial/visor.c: USB HandSpring Viso=
r / Palm OS driver
Jan  5 16:22:41 t40 kernel: mice: PS/2 mouse device common for all mice
Jan  5 16:22:41 t40 kernel: input: AT Translated Set 2 keyboard as /class/i=
nput/input0
Jan  5 16:22:41 t40 kernel: input: PC Speaker as /class/input/input1
Jan  5 16:22:41 t40 kernel: device-mapper: 4.5.0-ioctl (2005-10-04) initial=
ised: dm-devel@redhat.com
Jan  5 16:22:41 t40 kernel: Bluetooth: HCI USB driver ver 2.9
Jan  5 16:22:41 t40 kernel: usbcore: registered new driver hci_usb
Jan  5 16:22:41 t40 kernel: MC: drivers/edac/edac_mc.c version edac_mc  Ver=
: 2.0.0 Jan  5 2006
Jan  5 16:22:41 t40 kernel: Advanced Linux Sound Architecture Driver Versio=
n 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
Jan  5 16:22:41 t40 kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LN=
KB] -> GSI 5 (level, low) -> IRQ 5
Jan  5 16:22:42 t40 kernel: Time: acpi_pm clocksource has been installed.
Jan  5 16:22:42 t40 kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c=
6ab1, caps: 0x884793/0x0
Jan  5 16:22:42 t40 kernel: serio: Synaptics pass-through port at isa0060/s=
erio1/input0
Jan  5 16:22:42 t40 kernel: input: SynPS/2 Synaptics TouchPad as /class/inp=
ut/input2
Jan  5 16:22:42 t40 kernel: intel8x0_measure_ac97_clock: measured 55368 use=
cs
Jan  5 16:22:42 t40 kernel: intel8x0: clocking to 48000
Jan  5 16:22:42 t40 kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LN=
KB] -> GSI 5 (level, low) -> IRQ 5
Jan  5 16:22:42 t40 kernel: ALSA device list:
Jan  5 16:22:42 t40 kernel:   #0: Intel 82801DB-ICH4 with AD1981B at 0xc000=
0c00, irq 5
Jan  5 16:22:42 t40 kernel:   #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 5
Jan  5 16:22:42 t40 kernel: NET: Registered protocol family 2
Jan  5 16:22:42 t40 kernel: IP route cache hash table entries: 65536 (order=
: 6, 262144 bytes)
Jan  5 16:22:42 t40 kernel: TCP established hash table entries: 262144 (ord=
er: 8, 1048576 bytes)
Jan  5 16:22:42 t40 kernel: TCP bind hash table entries: 65536 (order: 6, 2=
62144 bytes)
Jan  5 16:22:42 t40 kernel: TCP: Hash tables configured (established 262144=
 bind 65536)
Jan  5 16:22:42 t40 kernel: TCP reno registered
Jan  5 16:22:42 t40 kernel: TCP bic registered
Jan  5 16:22:42 t40 kernel: Initializing IPsec netlink socket
Jan  5 16:22:42 t40 kernel: NET: Registered protocol family 1
Jan  5 16:22:42 t40 kernel: NET: Registered protocol family 17
Jan  5 16:22:42 t40 kernel: NET: Registered protocol family 15
Jan  5 16:22:42 t40 kernel: IrCOMM protocol (Dag Brattli)
Jan  5 16:22:42 t40 kernel: Bluetooth: L2CAP ver 2.8
Jan  5 16:22:42 t40 kernel: Bluetooth: L2CAP socket layer initialized
Jan  5 16:22:42 t40 kernel: Bluetooth: SCO (Voice Link) ver 0.5
Jan  5 16:22:42 t40 kernel: Bluetooth: SCO socket layer initialized
Jan  5 16:22:42 t40 kernel: Bluetooth: RFCOMM socket layer initialized
Jan  5 16:22:42 t40 kernel: Bluetooth: RFCOMM TTY layer initialized
Jan  5 16:22:42 t40 kernel: Bluetooth: RFCOMM ver 1.6
Jan  5 16:22:42 t40 kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Jan  5 16:22:42 t40 kernel: Bluetooth: BNEP filters: protocol multicast
Jan  5 16:22:42 t40 kernel: Bluetooth: HIDP (Human Interface Emulation) ver=
 1.1
Jan  5 16:22:42 t40 kernel: Using IPI Shortcut mode
Jan  5 16:22:42 t40 kernel: ACPI wakeup devices:=20
Jan  5 16:22:42 t40 kernel:  LID SLPB PCI0 UART PCI1 USB0 USB1 AC9M=20
Jan  5 16:22:42 t40 kernel: ACPI: (supports S0 S3 S4 S5)
Jan  5 16:22:42 t40 kernel: VFS: Mounted root (reiser4 filesystem) readonly.
Jan  5 16:22:42 t40 kernel: Freeing unused kernel memory: 180k freed
Jan  5 16:22:42 t40 kernel: Adding 498920k swap on /dev/hda5.  Priority:-1 =
extents:1 across:498920k
Jan  5 16:22:42 t40 kernel: IBM TrackPoint firmware: 0x0e, buttons: 3/3
Jan  5 16:22:42 t40 kernel: input: TPPS/2 IBM TrackPoint as /class/input/in=
put3
Jan  5 16:22:42 t40 kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Jan  5 16:22:42 t40 kernel: kjournald starting.  Commit interval 5 seconds
Jan  5 16:22:42 t40 kernel: kjournald starting.  Commit interval 600 seconds
Jan  5 16:22:42 t40 kernel: EXT3 FS on hda7, internal journal
Jan  5 16:22:42 t40 kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Jan  5 16:22:42 t40 kernel: USB Universal Host Controller Interface driver =
v3.0
Jan  5 16:22:42 t40 kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LN=
KA] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:42 t40 kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jan  5 16:22:42 t40 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, =
assigned bus number 1
Jan  5 16:22:42 t40 kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x000018=
00
Jan  5 16:22:42 t40 kernel: usb usb1: configuration #1 chosen from 1 choice
Jan  5 16:22:42 t40 kernel: hub 1-0:1.0: USB hub found
Jan  5 16:22:42 t40 kernel: hub 1-0:1.0: 2 ports detected
Jan  5 16:22:42 t40 kernel: **** SET: Misaligned resource pointer: c1b1a2c2=
 Type 07 Len 0
Jan  5 16:22:42 t40 kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ =
11
Jan  5 16:22:42 t40 kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LN=
KD] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:42 t40 kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jan  5 16:22:42 t40 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, =
assigned bus number 2
Jan  5 16:22:42 t40 kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 0x000018=
20
Jan  5 16:22:42 t40 kernel: usb usb2: configuration #1 chosen from 1 choice
Jan  5 16:22:42 t40 kernel: hub 2-0:1.0: USB hub found
Jan  5 16:22:42 t40 kernel: hub 2-0:1.0: 2 ports detected
Jan  5 16:22:43 t40 kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LN=
KC] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:43 t40 kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jan  5 16:22:43 t40 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, =
assigned bus number 3
Jan  5 16:22:43 t40 kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x000018=
40
Jan  5 16:22:43 t40 kernel: usb usb3: configuration #1 chosen from 1 choice
Jan  5 16:22:43 t40 kernel: hub 3-0:1.0: USB hub found
Jan  5 16:22:43 t40 kernel: hub 3-0:1.0: 2 ports detected
Jan  5 16:22:43 t40 kernel: usb 3-1: new full speed USB device using uhci_h=
cd and address 2
Jan  5 16:22:43 t40 kernel: usb 3-1: configuration #1 chosen from 1 choice
Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer: f7db5502=
 Type 07 Len 0
Jan  5 16:22:43 t40 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ =
11
Jan  5 16:22:43 t40 kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LN=
KH] -> GSI 11 (level, low) -> IRQ 11
Jan  5 16:22:43 t40 kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jan  5 16:22:43 t40 kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jan  5 16:22:43 t40 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, =
assigned bus number 4
Jan  5 16:22:43 t40 kernel: ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
Jan  5 16:22:43 t40 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.=
00, driver 10 Dec 2004
Jan  5 16:22:43 t40 kernel: usb usb4: configuration #1 chosen from 1 choice
Jan  5 16:22:43 t40 kernel: hub 4-0:1.0: USB hub found
Jan  5 16:22:43 t40 kernel: hub 4-0:1.0: 6 ports detected
Jan  5 16:22:43 t40 kernel: usb 3-1: USB disconnect, address 2
Jan  5 16:22:43 t40 kernel: usb 3-1: new full speed USB device using uhci_h=
cd and address 3
Jan  5 16:22:43 t40 kernel: usb 3-1: configuration #1 chosen from 1 choice
Jan  5 16:22:43 t40 kernel: pcmcia: Detected deprecated PCMCIA ioctl usage.
Jan  5 16:22:43 t40 kernel: pcmcia: This interface will soon be removed fro=
m the kernel; please expect breakage unless you upgrade to new tools.
Jan  5 16:22:43 t40 kernel: pcmcia: see http://www.kernel.org/pub/linux/uti=
ls/kernel/pcmcia/pcmcia.html for details.
Jan  5 16:22:43 t40 kernel: io scheduler cfq registered
Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]: disable_write_barrie=
r (fs/reiser4/wander.c:233)[zam-1055]:
Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier
Jan  5 16:22:43 t40 kernel:=20
Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing 0x=
e0000000,0x4000000
Jan  5 16:22:48 t40 last message repeated 2 times
Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at 0=
000:00:00.0.
Jan  5 16:22:48 t40 kernel: c028b7cf
Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev cfq_iosche=
d ehci_hcd uhci_hcd
Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)=20
Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000 c=
19720ec 00000000 1f000217 c1a79400=20
Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262 c=
1a79400 c02972af 1f000207 c029727f=20
Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1 0
Jan  5 16:22:58 t40 kernel: SysRq : Emergency Sync
Jan  5 16:22:58 t40 kernel: <4>reiser4[pdflush(172)]: disable_write_barrier=
 (fs/reiser4/wander.c:233)[zam-1055]:
Jan  5 16:22:58 t40 kernel: WARNING: disabling write barrier
Jan  5 16:22:59 t40 kernel:=20

--Boundary-01=_oDVvDXI4HnIvcLg
Content-Type: text/plain;
  charset="iso-8859-15";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-mm1
# Thu Jan  5 15:33:23 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_DOUBLEFAULT=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_SERIAL_PCI=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_PM_DEBUG=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda5"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=y
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
# CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=y
# CONFIG_IRNET is not set
CONFIG_IRCOMM=y
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_VIA_FIR=m
CONFIG_BT=y
CONFIG_BT_L2CAP=y
CONFIG_BT_SCO=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=y
CONFIG_BT_HCIUSB_SCO=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=y
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SAS_CLASS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
# CONFIG_HOSTAP is not set
# CONFIG_ACX is not set
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_MPPE is not set
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_WISTRON_BTNS is not set
CONFIG_INPUT_UINPUT=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
CONFIG_TCG_TPM=m
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_I810=m
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
CONFIG_SPI_ARCH_HAS_MASTER=y
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_DEVICE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_IP is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
# CONFIG_USB_ACECAD is not set
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
# CONFIG_USB_ITMTOUCH is not set
CONFIG_USB_EGALAX=m
# CONFIG_USB_YEALINK is not set
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_AIRPRIME is not set
# CONFIG_USB_SERIAL_ANYDATA is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP2101 is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_HP4X is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
# CONFIG_USB_GOTEMP is not set
CONFIG_USB_PHIDGETKIT=m
CONFIG_USB_PHIDGETSERVO=m
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
# CONFIG_MMC_BULKTRANSFER is not set
# CONFIG_MMC_WBSD is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# EDAC - error detection and reporting (RAS)
#
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_POLL=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_REISER4_FS=y
# CONFIG_REISER4_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Page alloc debug is incompatible with Software Suspend on i386
#
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_AES is not set
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--Boundary-01=_oDVvDXI4HnIvcLg--

--nextPart1597335.Ykr9njC4jY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDvVDo/aHb+2190pERAnyyAJwNng4So3m1jIFsSf0Im+fQTgBvHwCeKeH3
DY6B7hjSl1YpWQnFeoCSyQA=
=kO+I
-----END PGP SIGNATURE-----

--nextPart1597335.Ykr9njC4jY--
