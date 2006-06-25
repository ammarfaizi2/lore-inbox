Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWFYKf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWFYKf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFYKf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:35:28 -0400
Received: from mail.charite.de ([160.45.207.131]:20443 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932326AbWFYKf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:35:27 -0400
Date: Sun, 25 Jun 2006 12:35:23 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Problem with 2.6.17-mm2
Message-ID: <20060625103523.GY27143@charite.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nSQp8DZZn7gZbDHt"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nSQp8DZZn7gZbDHt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2.6.17 and 2.6.17.1 work OK, but using -mm2 gives me two oddieties:

1) A lot of "unexpected IRQ trap at vector X" for X=3D[09,07]
2) A problem with the powernow_k8 driver, which makes the kernel puke upon =
modprobe (at the end of my dmes output).

Jun 24 23:26:58 knarzkiste kernel: klogd 1.4.1#18, log source =3D /proc/kms=
g started.
Jun 24 23:26:58 knarzkiste kernel: ay using timer specific routine.. 3186.9=
8 BogoMIPS (lpj=3D6373972)
Jun 24 23:26:58 knarzkiste kernel: Mount-cache hash table entries: 512
Jun 24 23:26:58 knarzkiste kernel: CPU: After generic identify, caps: 078bf=
bff e3d3fbff 00000000 00000000 00000001 00000000 00000001
Jun 24 23:26:58 knarzkiste kernel: CPU: After vendor identify, caps: 078bfb=
ff e3d3fbff 00000000 00000000 00000001 00000000 00000001
Jun 24 23:26:58 knarzkiste kernel: CPU: L1 I Cache: 64K (64 bytes/line), D =
cache 64K (64 bytes/line)
Jun 24 23:26:58 knarzkiste kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jun 24 23:26:58 knarzkiste kernel: CPU: After all inits, caps: 078bfbff e3d=
3fbff 00000000 00000410 00000001 00000000 00000001
Jun 24 23:26:58 knarzkiste kernel: Intel machine check architecture support=
ed.
Jun 24 23:26:58 knarzkiste kernel: Intel machine check reporting enabled on=
 CPU#0.
Jun 24 23:26:58 knarzkiste kernel: Compat vDSO mapped to ffffe000.
Jun 24 23:26:58 knarzkiste kernel: CPU: AMD Turion(tm) 64 Mobile Technology=
 ML-30 stepping 02
Jun 24 23:26:58 knarzkiste kernel: Checking 'hlt' instruction... OK.
Jun 24 23:26:58 knarzkiste kernel: SMP alternatives: switching to UP code
Jun 24 23:26:58 knarzkiste kernel: Freeing SMP alternatives: 0k freed
Jun 24 23:26:58 knarzkiste kernel: ACPI: Core revision 20060608
Jun 24 23:26:58 knarzkiste kernel: ENABLING IO-APIC IRQs
Jun 24 23:26:58 knarzkiste kernel: ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D=
2 apic2=3D-1 pin2=3D-1
Jun 24 23:26:58 knarzkiste kernel: ..MP-BIOS bug: 8254 timer not connected =
to IO-APIC
Jun 24 23:26:58 knarzkiste kernel: ...trying to set up timer as Virtual Wir=
e IRQ... works.
Jun 24 23:26:58 knarzkiste kernel: NET: Registered protocol family 16
Jun 24 23:26:58 knarzkiste kernel: ACPI: bus type pci registered
Jun 24 23:26:58 knarzkiste kernel: PCI: BIOS Bug: MCFG area at e0000000 is =
not E820-reserved
Jun 24 23:26:58 knarzkiste kernel: PCI: Not using MMCONFIG.
Jun 24 23:26:58 knarzkiste kernel: PCI: PCI BIOS revision 2.10 entry at 0xf=
0031, last bus=3D1
Jun 24 23:26:58 knarzkiste kernel: Setting up standard PCI resources
Jun 24 23:26:58 knarzkiste kernel: ACPI: Interpreter enabled
Jun 24 23:26:58 knarzkiste kernel: ACPI: Using IOAPIC for interrupt routing
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jun 24 23:26:58 knarzkiste kernel: PCI: Probing PCI hardware (bus 00)
Jun 24 23:26:58 knarzkiste kernel: PCI: Ignoring BAR0-3 of IDE controller 0=
000:00:14.1
Jun 24 23:26:58 knarzkiste kernel: Boot video device is 0000:01:05.0
Jun 24 23:26:58 knarzkiste kernel: PCI: Transparent bridge - 0000:00:14.4
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_=
=2EPCI0._PRT]
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_=
=2EPCI0.P0P1._PRT]
Jun 24 23:26:58 knarzkiste kernel: ACPI: Embedded Controller [EC] (gpe 6) i=
nterrupt mode.
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 7, desc: c037bc00, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 07
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_=
=2EPCI0.POP2._PRT]
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 5 =
6 7 10 11 12 14 15) *0, disabled.
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 =
6 7 *10 11 12 14 15)
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *5=
 6 7 10 11 12 14 15)
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 =
6 7 10 *11 12 14 15)
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 5 =
*6 7 10 11 12 14 15)
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 5 =
6 *7 10 11 12 14 15)
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs *5=
 6 7 10 11 12 14 15)
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 5 =
6 7 10 11 12 14 15) *0, disabled.
Jun 24 23:26:58 knarzkiste kernel: Linux Plug and Play Support v0.97 (c) Ad=
am Belay
Jun 24 23:26:58 knarzkiste kernel: pnp: PnP ACPI init
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: irq 9, desc: c037bc80, depth: 1, count: =
0, unhandled: 0
Jun 24 23:26:58 knarzkiste kernel: ->handle_irq():  c013d360, handle_bad_ir=
q+0x0/0x270
Jun 24 23:26:58 knarzkiste kernel: ->chip(): c037f980, 0xc037f980
Jun 24 23:26:58 knarzkiste kernel: ->action(): 00000000
Jun 24 23:26:58 knarzkiste kernel:   IRQ_DISABLED set
Jun 24 23:26:58 knarzkiste kernel: unexpected IRQ trap at vector 09
Jun 24 23:26:58 knarzkiste kernel: pnp: PnP ACPI: found 11 devices
Jun 24 23:26:58 knarzkiste kernel: PCI: Using ACPI for IRQ routing
Jun 24 23:26:58 knarzkiste kernel: PCI: If a device doesn't work, try "pci=
=3Drouteirq".  If it helps, post a report
Jun 24 23:26:58 knarzkiste kernel: PCI: Device 0000:02:03.0 not found by BI=
OS
Jun 24 23:26:58 knarzkiste kernel: PCI: Device 0000:02:04.0 not found by BI=
OS
Jun 24 23:26:58 knarzkiste kernel: PCI: Device 0000:02:04.1 not found by BI=
OS
Jun 24 23:26:58 knarzkiste kernel: PCI: Device 0000:02:04.2 not found by BI=
OS
Jun 24 23:26:58 knarzkiste kernel: PCI: Device 0000:02:09.0 not found by BI=
OS
Jun 24 23:26:58 knarzkiste kernel: PCI: Bridge: 0000:00:01.0
Jun 24 23:26:58 knarzkiste kernel:   IO window: d000-dfff
Jun 24 23:26:58 knarzkiste kernel:   MEM window: fbe00000-fbefffff
Jun 24 23:26:58 knarzkiste kernel:   PREFETCH window: f0000000-faffffff
Jun 24 23:26:58 knarzkiste kernel: PCI: Bus 3, cardbus bridge: 0000:02:04.0
Jun 24 23:26:58 knarzkiste kernel:   IO window: 0000e000-0000e0ff
Jun 24 23:26:58 knarzkiste kernel:   IO window: 0000e400-0000e4ff
Jun 24 23:26:58 knarzkiste kernel:   PREFETCH window: 30000000-31ffffff
Jun 24 23:26:58 knarzkiste kernel:   MEM window: 36000000-37ffffff
Jun 24 23:26:58 knarzkiste kernel: PCI: Bus 7, cardbus bridge: 0000:02:04.1
Jun 24 23:26:58 knarzkiste kernel:   IO window: 0000ec00-0000ecff
Jun 24 23:26:58 knarzkiste kernel:   IO window: 00001000-000010ff
Jun 24 23:26:58 knarzkiste kernel:   PREFETCH window: 32000000-33ffffff
Jun 24 23:26:58 knarzkiste kernel:   MEM window: 38000000-39ffffff
Jun 24 23:26:58 knarzkiste kernel: PCI: Bridge: 0000:00:14.4
Jun 24 23:26:58 knarzkiste kernel:   IO window: e000-efff
Jun 24 23:26:58 knarzkiste kernel:   MEM window: fbf00000-fbffffff
Jun 24 23:26:58 knarzkiste kernel:   PREFETCH window: 30000000-34ffffff
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> G=
SI 19 (level, low) -> IRQ 16
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.1[B] -> G=
SI 20 (level, low) -> IRQ 17
Jun 24 23:26:58 knarzkiste kernel: NET: Registered protocol family 2
Jun 24 23:26:58 knarzkiste kernel: IP route cache hash table entries: 4096 =
(order: 2, 16384 bytes)
Jun 24 23:26:58 knarzkiste kernel: TCP established hash table entries: 1638=
4 (order: 4, 65536 bytes)
Jun 24 23:26:58 knarzkiste kernel: TCP bind hash table entries: 8192 (order=
: 3, 32768 bytes)
Jun 24 23:26:58 knarzkiste kernel: TCP: Hash tables configured (established=
 16384 bind 8192)
Jun 24 23:26:58 knarzkiste kernel: TCP reno registered
Jun 24 23:26:58 knarzkiste kernel: Initializing Cryptographic API
Jun 24 23:26:58 knarzkiste kernel: io scheduler noop registered
Jun 24 23:26:58 knarzkiste kernel: io scheduler anticipatory registered
Jun 24 23:26:58 knarzkiste kernel: io scheduler deadline registered
Jun 24 23:26:58 knarzkiste kernel: io scheduler cfq registered (default)
Jun 24 23:26:58 knarzkiste kernel: vesafb: framebuffer at 0xf0000000, mappe=
d to 0xdc880000, using 3072k, total 65536k
Jun 24 23:26:58 knarzkiste kernel: vesafb: mode is 1024x768x16, linelength=
=3D2048, pages=3D41
Jun 24 23:26:58 knarzkiste kernel: vesafb: protected mode interface info at=
 c000:52f9
Jun 24 23:26:58 knarzkiste kernel: vesafb: pmi: set display start =3D c00c5=
367, set palette =3D c00c53a1
Jun 24 23:26:58 knarzkiste kernel: vesafb: pmi: ports =3D d810 d816 d854 d8=
38 d83c d85c d800 d804 d8b0 d8b2 d8b4
Jun 24 23:26:58 knarzkiste kernel: vesafb: scrolling: ywrap using protected=
 mode interface, yres_virtual=3D1536
Jun 24 23:26:58 knarzkiste kernel: vesafb: Truecolor: size=3D0:5:6:5, shift=
=3D0:11:5:0
Jun 24 23:26:58 knarzkiste kernel: Console: switching to colour frame buffe=
r device 128x48
Jun 24 23:26:58 knarzkiste kernel: fb0: VESA VGA frame buffer device
Jun 24 23:26:58 knarzkiste kernel: lp: driver loaded but no devices found
Jun 24 23:26:58 knarzkiste kernel: RAMDISK driver initialized: 16 RAM disks=
 of 8192K size 1024 blocksize
Jun 24 23:26:58 knarzkiste kernel: Uniform Multi-Platform E-IDE driver Revi=
sion: 7.00alpha2
Jun 24 23:26:58 knarzkiste kernel: ide: Assuming 33MHz system bus speed for=
 PIO modes; override with idebus=3Dxx
Jun 24 23:26:58 knarzkiste kernel: ATIIXP: IDE controller at PCI slot 0000:=
00:14.1
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.1[A] -> G=
SI 16 (level, low) -> IRQ 18
Jun 24 23:26:58 knarzkiste kernel: ATIIXP: chipset revision 0
Jun 24 23:26:58 knarzkiste kernel: ATIIXP: not 100%% native mode: will prob=
e irqs later
Jun 24 23:26:58 knarzkiste kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS =
settings: hda:DMA, hdb:pio
Jun 24 23:26:58 knarzkiste kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS =
settings: hdc:DMA, hdd:pio
Jun 24 23:26:58 knarzkiste kernel: Probing IDE interface ide0...
Jun 24 23:26:58 knarzkiste kernel: hda: WDC WD600VE-00HDT0, ATA DISK drive
Jun 24 23:26:58 knarzkiste kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 24 23:26:58 knarzkiste kernel: Probing IDE interface ide1...
Jun 24 23:26:58 knarzkiste kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 24 23:26:58 knarzkiste kernel: hda: max request size: 128KiB
Jun 24 23:26:58 knarzkiste kernel: hda: 117210240 sectors (60011 MB) w/8192=
KiB Cache, CHS=3D65535/16/63, UDMA(100)
Jun 24 23:26:58 knarzkiste kernel: hda: cache flushes supported
Jun 24 23:26:58 knarzkiste kernel:  hda: hda1 hda2 < hda5 >
Jun 24 23:26:58 knarzkiste kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f=
03:PS2M] at 0x60,0x64 irq 1,12
Jun 24 23:26:58 knarzkiste kernel: i8042.c: Detected active multiplexing co=
ntroller, rev 1.1.
Jun 24 23:26:58 knarzkiste kernel: serio: i8042 AUX0 port at 0x60,0x64 irq =
12
Jun 24 23:26:58 knarzkiste kernel: serio: i8042 AUX1 port at 0x60,0x64 irq =
12
Jun 24 23:26:58 knarzkiste kernel: serio: i8042 AUX2 port at 0x60,0x64 irq =
12
Jun 24 23:26:58 knarzkiste kernel: serio: i8042 AUX3 port at 0x60,0x64 irq =
12
Jun 24 23:26:58 knarzkiste kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 24 23:26:58 knarzkiste kernel: mice: PS/2 mouse device common for all m=
ice
Jun 24 23:26:58 knarzkiste kernel: TCP bic registered
Jun 24 23:26:58 knarzkiste kernel: Using IPI Shortcut mode
Jun 24 23:26:58 knarzkiste kernel: ACPI: (supports S0 S1 S3<6>Time: tsc clo=
cksource has been installed.
Jun 24 23:26:58 knarzkiste kernel:  S4 S5)
Jun 24 23:26:58 knarzkiste kernel: Freeing unused kernel memory: 196k freed
Jun 24 23:26:58 knarzkiste kernel: XFS mounting filesystem hda1
Jun 24 23:26:58 knarzkiste kernel: Ending clean XFS mount for filesystem: h=
da1
Jun 24 23:26:58 knarzkiste kernel: input: AT Translated Set 2 keyboard as /=
class/input/input0
Jun 24 23:26:58 knarzkiste kernel: NET: Registered protocol family 1
Jun 24 23:26:58 knarzkiste kernel: hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW=
 drive, 2048kB Cache
Jun 24 23:26:58 knarzkiste kernel: Uniform CD-ROM driver Revision: 3.20
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:09.0[A] -> G=
SI 22 (level, low) -> IRQ 19
Jun 24 23:26:58 knarzkiste kernel: rt2500 1.1.0 CVS 2005/07/10 http://rt2x0=
0.serialmonkey.com
Jun 24 23:26:58 knarzkiste kernel: 8139too Fast Ethernet driver 0.9.27
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:03.0[A] -> G=
SI 18 (level, low) -> IRQ 20
Jun 24 23:26:58 knarzkiste kernel: eth0: RealTek RTL8139 at 0xdc80ec00, 00:=
10:dc:e8:c8:4f, IRQ 20
Jun 24 23:26:58 knarzkiste kernel: eth0:  Identified 8139 chip type 'RTL-81=
01'
Jun 24 23:26:58 knarzkiste kernel: Yenta: CardBus bridge found at 0000:02:0=
4.0 [1462:0131]
Jun 24 23:26:58 knarzkiste kernel: Synaptics Touchpad, model: 1, fw: 5.9, i=
d: 0x116eb1, caps: 0xa04713/0x0
Jun 24 23:26:58 knarzkiste kernel: input: SynPS/2 Synaptics TouchPad as /cl=
ass/input/input1
Jun 24 23:26:58 knarzkiste kernel: psmouse.c: TouchPad at isa0060/serio2/in=
put0 lost sync at byte 1
Jun 24 23:26:58 knarzkiste kernel: Yenta: ISA IRQ mask 0x0cb8, PCI irq 16
Jun 24 23:26:58 knarzkiste kernel: Socket status: 30000810
Jun 24 23:26:58 knarzkiste kernel: pcmcia: parent PCI bridge I/O window: 0x=
e000 - 0xefff
Jun 24 23:26:58 knarzkiste kernel: piix4_smbus 0000:00:14.0: Found 0000:00:=
14.0 device
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0xe000-0xefff: clean.
Jun 24 23:26:58 knarzkiste kernel: pcmcia: parent PCI bridge Memory window:=
 0xfbf00000 - 0xfbffffff
Jun 24 23:26:58 knarzkiste kernel: pcmcia: parent PCI bridge Memory window:=
 0x30000000 - 0x34ffffff
Jun 24 23:26:58 knarzkiste kernel: Yenta: CardBus bridge found at 0000:02:0=
4.1 [1462:0131]
Jun 24 23:26:58 knarzkiste kernel: Yenta: ISA IRQ mask 0x0cb8, PCI irq 17
Jun 24 23:26:58 knarzkiste kernel: Socket status: 30000006
Jun 24 23:26:58 knarzkiste kernel: pcmcia: parent PCI bridge I/O window: 0x=
e000 - 0xefff
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0xe000-0xefff: clean.
Jun 24 23:26:58 knarzkiste kernel: usbcore: registered new driver usbfs
Jun 24 23:26:58 knarzkiste kernel: usbcore: registered new driver hub
Jun 24 23:26:58 knarzkiste kernel: pcmcia: parent PCI bridge Memory window:=
 0xfbf00000 - 0xfbffffff
Jun 24 23:26:58 knarzkiste kernel: pcmcia: parent PCI bridge Memory window:=
 0x30000000 - 0x34ffffff
Jun 24 23:26:58 knarzkiste kernel: Linux agpgart interface v0.101 (c) Dave =
Jones
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.2[A] -> G=
SI 19 (level, low) -> IRQ 16
Jun 24 23:26:58 knarzkiste kernel: ehci_hcd 0000:00:13.2: EHCI Host Control=
ler
Jun 24 23:26:58 knarzkiste kernel: ehci_hcd 0000:00:13.2: new USB bus regis=
tered, assigned bus number 1
Jun 24 23:26:58 knarzkiste kernel: ehci_hcd 0000:00:13.2: irq 16, io mem 0x=
fbdff000
Jun 24 23:26:58 knarzkiste kernel: ehci_hcd 0000:00:13.2: USB 2.0 started, =
EHCI 1.00, driver 10 Dec 2004
Jun 24 23:26:58 knarzkiste kernel: usb usb1: new device found, idVendor=3D0=
000, idProduct=3D0000
Jun 24 23:26:58 knarzkiste kernel: usb usb1: new device strings: Mfr=3D3, P=
roduct=3D2, SerialNumber=3D1
Jun 24 23:26:58 knarzkiste kernel: usb usb1: Product: EHCI Host Controller
Jun 24 23:26:58 knarzkiste kernel: usb usb1: Manufacturer: Linux 2.6.17-mm2=
 ehci_hcd
Jun 24 23:26:58 knarzkiste kernel: usb usb1: SerialNumber: 0000:00:13.2
Jun 24 23:26:58 knarzkiste kernel: usb usb1: configuration #1 chosen from 1=
 choice
Jun 24 23:26:58 knarzkiste kernel: hub 1-0:1.0: USB hub found
Jun 24 23:26:58 knarzkiste kernel: hub 1-0:1.0: 8 ports detected
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd: 2006 May 24 USB 1.1 'Open' Hos=
t Controller (OHCI) Driver (PCI)
Jun 24 23:26:58 knarzkiste kernel: hda: cache flushes supported
Jun 24 23:26:58 knarzkiste kernel: pccard: PCMCIA card inserted into slot 0
Jun 24 23:26:58 knarzkiste kernel: ts: Compaq touchscreen protocol output
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.0[A] -> G=
SI 19 (level, low) -> IRQ 16
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd 0000:00:13.0: OHCI Host Control=
ler
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd 0000:00:13.0: new USB bus regis=
tered, assigned bus number 2
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd 0000:00:13.0: irq 16, io mem 0x=
fbdfd000
Jun 24 23:26:58 knarzkiste kernel: usb usb2: new device found, idVendor=3D0=
000, idProduct=3D0000
Jun 24 23:26:58 knarzkiste kernel: usb usb2: new device strings: Mfr=3D3, P=
roduct=3D2, SerialNumber=3D1
Jun 24 23:26:58 knarzkiste kernel: usb usb2: Product: OHCI Host Controller
Jun 24 23:26:58 knarzkiste kernel: usb usb2: Manufacturer: Linux 2.6.17-mm2=
 ohci_hcd
Jun 24 23:26:58 knarzkiste kernel: usb usb2: SerialNumber: 0000:00:13.0
Jun 24 23:26:58 knarzkiste kernel: usb usb2: configuration #1 chosen from 1=
 choice
Jun 24 23:26:58 knarzkiste kernel: hub 2-0:1.0: USB hub found
Jun 24 23:26:58 knarzkiste kernel: hub 2-0:1.0: 4 ports detected
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.1[A] -> G=
SI 19 (level, low) -> IRQ 16
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd 0000:00:13.1: OHCI Host Control=
ler
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd 0000:00:13.1: new USB bus regis=
tered, assigned bus number 3
Jun 24 23:26:58 knarzkiste kernel: ohci_hcd 0000:00:13.1: irq 16, io mem 0x=
fbdfe000
Jun 24 23:26:58 knarzkiste kernel: usb usb3: new device found, idVendor=3D0=
000, idProduct=3D0000
Jun 24 23:26:58 knarzkiste kernel: usb usb3: new device strings: Mfr=3D3, P=
roduct=3D2, SerialNumber=3D1
Jun 24 23:26:58 knarzkiste kernel: usb usb3: Product: OHCI Host Controller
Jun 24 23:26:58 knarzkiste kernel: usb usb3: Manufacturer: Linux 2.6.17-mm2=
 ohci_hcd
Jun 24 23:26:58 knarzkiste kernel: usb usb3: SerialNumber: 0000:00:13.1
Jun 24 23:26:58 knarzkiste kernel: usb usb3: configuration #1 chosen from 1=
 choice
Jun 24 23:26:58 knarzkiste kernel: hub 3-0:1.0: USB hub found
Jun 24 23:26:58 knarzkiste kernel: hub 3-0:1.0: 4 ports detected
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.5[B] -> G=
SI 17 (level, low) -> IRQ 22
Jun 24 23:26:58 knarzkiste kernel: cs: memory probe 0xfbf00000-0xfbffffff: =
excluding 0xfbf00000-0xfbf0ffff 0xfbff0000-0xfbffffff
Jun 24 23:26:58 knarzkiste kernel: pcmcia: registering new device pcmcia0.0
Jun 24 23:26:58 knarzkiste kernel: usb 3-1: new low speed USB device using =
ohci_hcd and address 2
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0x100-0x4ff: excluding=
 0x408-0x40f 0x4d0-0x4d7
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0x800-0x8ff: clean.
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0xc00-0xcff: excluding=
 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0xa00-0xaff: clean.
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0x100-0x4ff: excluding=
 0x408-0x40f 0x4d0-0x4d7
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0x800-0x8ff: clean.
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0xc00-0xcff: excluding=
 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
Jun 24 23:26:58 knarzkiste kernel: cs: IO port probe 0xa00-0xaff: clean.
Jun 24 23:26:58 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.6[B] -> G=
SI 17 (level, low) -> IRQ 22
Jun 24 23:26:58 knarzkiste kernel: usb 3-1: new device found, idVendor=3D04=
6d, idProduct=3Dc00c
Jun 24 23:26:58 knarzkiste kernel: usb 3-1: new device strings: Mfr=3D1, Pr=
oduct=3D2, SerialNumber=3D0
Jun 24 23:26:58 knarzkiste kernel: usb 3-1: Product: USB Optical Mouse
Jun 24 23:26:58 knarzkiste kernel: usb 3-1: Manufacturer: Logitech
Jun 24 23:26:58 knarzkiste kernel: usb 3-1: configuration #1 chosen from 1 =
choice
Jun 24 23:26:58 knarzkiste kernel: Serial: 8250/16550 driver $Revision: 1.9=
0 $ 4 ports, IRQ sharing enabled
Jun 24 23:26:58 knarzkiste kernel: input: Logitech USB Optical Mouse as /cl=
ass/input/input2
Jun 24 23:26:58 knarzkiste kernel: usbcore: registered new driver usbmouse
Jun 24 23:26:58 knarzkiste kernel: drivers/usb/input/usbmouse.c: v1.6:USB H=
ID Boot Protocol mouse driver
Jun 24 23:26:58 knarzkiste kernel: usbcore: registered new driver hiddev
Jun 24 23:26:58 knarzkiste kernel: usbcore: registered new driver usbhid
Jun 24 23:26:58 knarzkiste kernel: drivers/usb/input/hid-core.c: v2.6:USB H=
ID core driver
Jun 24 23:26:58 knarzkiste kernel: hda: cache flushes supported
Jun 24 23:26:58 knarzkiste kernel: Adding 1349420k swap on /dev/hda5.  Prio=
rity:-1 extents:1 across:1349420k
Jun 24 23:26:58 knarzkiste kernel: Linux video capture interface: v2.00
Jun 24 23:26:58 knarzkiste kernel: saa7130/34: v4l2 driver version 0.2.14 l=
oaded
Jun 24 23:26:58 knarzkiste kernel: pcmcia: Detected deprecated PCMCIA ioctl=
 usage from process: discover.
Jun 24 23:26:58 knarzkiste kernel: pcmcia: This interface will soon be remo=
ved from the kernel; please expect breakage unless you upgrade to new tools.
Jun 24 23:26:58 knarzkiste kernel: pcmcia: see http://www.kernel.org/pub/li=
nux/utils/kernel/pcmcia/pcmcia.html for details.
Jun 24 23:26:58 knarzkiste kernel: NET: Registered protocol family 17
Jun 24 23:26:59 knarzkiste kernel: ACPI: Battery Slot [BAT1] (battery prese=
nt)
Jun 24 23:26:59 knarzkiste kernel: ACPI: AC Adapter [ADP1] (on-line)
Jun 24 23:26:59 knarzkiste kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] =
C3[C3])
Jun 24 23:26:59 knarzkiste kernel: ACPI: Power Button (FF) [PWRF]
Jun 24 23:26:59 knarzkiste kernel: ACPI: Lid Switch [LID0]
Jun 24 23:26:59 knarzkiste kernel: ACPI: Sleep Button (CM) [SLPB]
Jun 24 23:26:59 knarzkiste kernel: ACPI: Power Button (CM) [PWRB]
Jun 24 23:26:59 knarzkiste kernel: Time: acpi_pm clocksource has been insta=
lled.
Jun 24 23:26:59 knarzkiste kernel: ACPI: Thermal Zone [THRM] (59 C)
Jun 24 23:27:06 knarzkiste /usr/sbin/gpm[4159]: Detected EXPS/2 protocol mo=
use.
Jun 24 23:27:08 knarzkiste smartd[4227]: smartd version 5.36 [i686-pc-linux=
-gnu] Copyright (C) 2002-6 Bruce Allen
Jun 24 23:27:08 knarzkiste smartd[4227]: Home page is http://smartmontools.=
sourceforge.net/
Jun 24 23:27:08 knarzkiste smartd[4227]: Opened configuration file /etc/sma=
rtd.conf
Jun 24 23:27:08 knarzkiste smartd[4227]: Configuration file /etc/smartd.con=
f parsed.
Jun 24 23:27:08 knarzkiste smartd[4227]: Device: /dev/hda, opened
Jun 24 23:27:08 knarzkiste smartd[4227]: Device: /dev/hda, not found in sma=
rtd database.
Jun 24 23:27:08 knarzkiste smartd[4227]: Device: /dev/hda, enabled SMART At=
tribute Autosave.
Jun 24 23:27:08 knarzkiste smartd[4227]: Device: /dev/hda, enabled SMART Au=
tomatic Offline Testing.
Jun 24 23:27:08 knarzkiste smartd[4227]: Device: /dev/hda, is SMART capable=
=2E Adding to "monitor" list.
Jun 24 23:27:08 knarzkiste smartd[4227]: Monitoring 1 ATA and 0 SCSI devices
Jun 24 23:27:08 knarzkiste smartd[4229]: smartd has fork()ed into backgroun=
d mode. New PID=3D4229.
Jun 24 23:27:09 knarzkiste sshd[4237]: Server listening on 0.0.0.0 port 222=
22.
Jun 24 23:27:09 knarzkiste smartd[4229]: file /var/run/smartd.pid written c=
ontaining PID 4229
Jun 24 23:27:11 knarzkiste ntpd[4340]: ntpd 4.2.0a@1:4.2.0a+stable-8-r Sun =
Jun 18 14:43:31 UTC 2006 (1)
Jun 24 23:27:11 knarzkiste ntpd[4340]: Listening on interface wildcard, 0.0=
=2E0.0#123
Jun 24 23:27:11 knarzkiste ntpd[4340]: Listening on interface lo, 127.0.0.1=
#123
Jun 24 23:27:11 knarzkiste ntpd[4340]: Listening on interface eth1, 192.168=
=2E1.106#123
Jun 24 23:27:11 knarzkiste ntpd[4340]: kernel time sync status 0040
Jun 24 23:27:11 knarzkiste ntpd[4340]: frequency initialized 11.703 PPM fro=
m /var/lib/ntp/ntp.drift
Jun 24 23:27:12 knarzkiste kernel: powernow-k8: Found 1 AMD Turion(tm) 64 M=
obile Technology ML-30 processors (version 2.00.00)
Jun 24 23:27:12 knarzkiste kernel: int3: 0000 [#1]
Jun 24 23:27:12 knarzkiste kernel: 4K_STACKS PREEMPT
Jun 24 23:27:12 knarzkiste kernel: last sysfs file: /block/hda/hda1/size
Jun 24 23:27:12 knarzkiste kernel: Modules linked in: powernow_k8 freq_tabl=
e thermal fan button processor ac battery af_packet eeprom saa7134_dvb dvb_=
pll mt352 saa7134 compat_ioctl32 ir_kbd_i2c ir_common videodev v4l1_compat =
v4l2_common video_buf_dvb dvb_core video_buf nxt200x tda1004x usbhid usbmou=
se 8250_pci 8250 serial_core pcmcia firmware_class snd_atiixp_modem snd_ati=
ixp snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd tsdev ohci_hcd ehci_h=
cd soundcore evdev ati_agp agpgart usbcore snd_page_alloc i2c_piix4 yenta_s=
ocket rsrc_nonstatic 8139too rt2500 ide_cd pcmcia_core psmouse cdrom unix
Jun 24 23:27:12 knarzkiste kernel: CPU:    0
Jun 24 23:27:12 knarzkiste kernel: EIP:    0060:[<c0398c21>]    Not tainted=
 VLI
Jun 24 23:27:12 knarzkiste kernel: EFLAGS: 00000292   (2.6.17-mm2 #1)
Jun 24 23:27:12 knarzkiste kernel: EIP is at cpufreq_register_driver+0x1/0x=
140
Jun 24 23:27:12 knarzkiste kernel: eax: dcd6a1e0   ebx: db438800   ecx: db5=
0b000   edx: d6d79000
Jun 24 23:27:12 knarzkiste kernel: esi: dcd6a280   edi: dcd6a280   ebp: dcd=
59ac4   esp: d6d79ec8
Jun 24 23:27:12 knarzkiste kernel: ds: 007b   es: 007b   ss: 0068
Jun 24 23:27:12 knarzkiste kernel: Process modprobe (pid: 4348, ti=3Dd6d790=
00 task=3Dd6d08aa0 task.ti=3Dd6d79000)
Jun 24 23:27:12 knarzkiste kernel: Stack: c01389ff dcd6a2c8 c030c2b7 dcd6a2=
8c d6e0e000 daa7b9e0 00000000 dcd6a28c
Jun 24 23:27:12 knarzkiste kernel:        dcc38dc0 dcd6a2c8 dcd6a280 000000=
00 00000000 00000000 00000000 00000000
Jun 24 23:27:12 knarzkiste kernel:        00000000 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000
Jun 24 23:27:12 knarzkiste kernel: Call Trace:
Jun 24 23:27:12 knarzkiste kernel:  <c01389ff> sys_init_module+0x15f/0x1840=
  <c015c440> __kmalloc+0x0/0x60
Jun 24 23:27:12 knarzkiste kernel:  <c0102f75> sysenter_past_esp+0x56/0x79
Jun 24 23:27:12 knarzkiste kernel: Code: cc cc cc cc cc cc cc cc cc cc cc c=
c cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc c=
c cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc cc
Jun 24 23:27:12 knarzkiste kernel: EIP: [<c0398c21>] cpufreq_register_drive=
r+0x1/0x140 SS:ESP 0068:d6d79ec8
Jun 24 23:27:12 knarzkiste powersaved: Cannot load cpufreq governors - No c=
pufreq driver available
Jun 24 23:27:12 knarzkiste powersaved: Starting powersaved with ACPI support
Jun 24 23:27:15 knarzkiste kernel:  <6>[drm] Initialized drm 1.0.1 20051102

--=20
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universit=E4tsmedizin Berlin            Tel.  +49 (0)30-450 570-1=
55
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de

--nSQp8DZZn7gZbDHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEnmbrtMpsh5D4mn0RAiS1AJ9c9yr5NSRNSRcMvhiALbxgWlpukACfaE12
noaBJaouncFtOIfCbcW9xeE=
=ElDY
-----END PGP SIGNATURE-----

--nSQp8DZZn7gZbDHt--
