Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSLSOw4>; Thu, 19 Dec 2002 09:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSLSOw4>; Thu, 19 Dec 2002 09:52:56 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:20954 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id <S265844AbSLSOwx>;
	Thu, 19 Dec 2002 09:52:53 -0500
Subject: Re: [PATCH 2.4] : donauboe IrDA driver (resend)
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219024632.GB1746@bougret.hpl.hp.com>
References: <20021219024632.GB1746@bougret.hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ww090+iU6P8r9SC8TKbx"
Organization: iNES Advertising
Message-Id: <1040310314.1225.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-1) 
Date: 19 Dec 2002 17:05:16 +0200
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ww090+iU6P8r9SC8TKbx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hello,

This module does not load all the time for me.
If I do an "modprobe donauboe" it gives something like:

TX: (144,80) (144,84) (144,80) (144,84) (0,00) (0,00) (0,00) (0,00)
[9600]
RRTSRRT 4181
RX: (130,00) (130,00) (130,00) (130,00) (0,80) (0,80) (0,80) (0,80)
TX: (144,80) (144,84) (144,80) (144,84) (0,00) (0,00) (0,00) (0,00)
[115200]
RRTSRRT 4117
RX: (130,00) (130,00) (130,00) (130,00) (0,80) (0,80) (0,80) (0,80)
TX: (128,84) (128,90) (128,84) (128,b4) (0,00) (0,00) (0,00) (0,00)
[4000000]
TSRTSTR 3861
RX: (264,00) (264,20) (0,80) (0,80) (0,80) (0,80) (0,80) (0,80)
TX: (128,84) (128,90) (128,84) (128,b4) (0,00) (0,00) (0,00) (0,00)
[1152000]
TSTST<3>toshoboeprobe(1152000) failed filter test
toshoboe: Register dump:
Interrupts: Tx:203 Rx:0 TxUnder:0 RxOver:0 Sip:0
RX 00 TX 44 RingBase 0f355c00
RING_SIZE 11 IER ff ISR 07
CONFIG1 08 STATUS 00
CONFIG0 4ea0 ENABLE 937c
NEW_PCONFIG 0101 CURR_PCONFIG 0101
MAXLEN 0c04 RXCOUNT 0100
Ring at 0f355c00:
RX: (0,80) (0,80) (0,80) (0,80) (0,80) (0,80) (0,80) (0,80)
TX: (128,00) (128,00) (128,00) (128,00) (0,00) (0,00) (0,00) (0,00)


If I try a few more times it will finally load...

The kernel is 2.4.20.0.pp.9 (RH rawhide kernel - 2.4.20-ac1 based) +
acpi20021205 . I don't know why lspci shows "Toshiba Tecra 8100". The
machine is an Toshiba Satellite Pro 4320.

Output of lspci:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
	Subsystem: Toshiba America Info Systems Toshiba Tecra 8100 Laptop
System Chipset
	Flags: bus master, medium devsel, latency 64
	Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	Memory behind bridge: f0000000-f7ffffff

00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at fff0 [size=3D16]

00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ff80 [size=3D32]

00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Flags: medium devsel, IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem
(rev 01)
	Subsystem: Toshiba America Info Systems Internal V.90 Modem
	Flags: bus master, medium devsel, latency 0, IRQ 3
	Memory at ffefff00 (32-bit, non-prefetchable) [size=3D256]
	I/O ports at 02f8 [size=3D8]
	I/O ports at 1c00 [size=3D256]
	Capabilities: <available only to root>

00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
	Subsystem: Toshiba America Info Systems FIR Port Type-DO
	Flags: slow devsel, IRQ 11
	I/O ports at ff60 [size=3D32]
	Capabilities: <available only to root>

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D14, subordinate=3D14, sec-latency=3D0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D15, subordinate=3D15, sec-latency=3D0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S
Audio Controller] (rev 02)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at efff8000 (32-bit, non-prefetchable) [size=3D32K]
	I/O ports at ff00 [size=3D64]
	I/O ports at fefc [size=3D4]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev
11) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at f0000000 (32-bit, non-prefetchable) [size=3D128M]
	Expansion ROM at 000c0000 [disabled] [size=3D64K]
	Capabilities: <available only to root>


--
Cioby




--=-ww090+iU6P8r9SC8TKbx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+AeAqZ73E6zRGg0URAlMvAJ0YcJTnD8f7lxhcktDytvg6J7dIXwCeMSlo
fgsSvPdkimbGeRQayOkqj4o=
=NCbp
-----END PGP SIGNATURE-----

--=-ww090+iU6P8r9SC8TKbx--

