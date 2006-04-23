Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWDWTWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWDWTWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 15:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWDWTWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 15:22:53 -0400
Received: from iucha.net ([209.98.146.184]:35290 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S1751442AbWDWTWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 15:22:53 -0400
Date: Sun, 23 Apr 2006 14:22:52 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060423192251.GD8896@iucha.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.11+cvs20060403
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 2.6.17-rc[12] I get the following oops:

Linux version 2.6.17-rc2 (florin@hera) (gcc version 4.1.0 (Debian 4.1.0-1+b=
1)) #1 Sun Apr 23 00:04:42 CDT 2006
[snip]
Intel ISA PCIC probe:=20
  Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
setup_irq: irq handler mismatch
 <c012f9dd> setup_irq+0xd3/0xe6   <d9449159> i365_count_irq+0x0/0x22 [i8236=
5]
 <c012fa5f> request_irq+0x6f/0x8b   <d944f2af> test_irq+0x27/0xc7 [i82365]
 <d9449159> i365_count_irq+0x0/0x22 [i82365]   <d944f8ea> add_pcic+0x59b/0x=
81c [i82365]
 <c0104dbb> do_IRQ+0x46/0x4e   <c011007b> machine_kexec+0x8f/0xbc
 <c01d282e> vsnprintf+0x455/0x490   <c01d2889> sprintf+0x20/0x23
 <c0211304> pnp_convert_id+0x74/0x79   <c020be49> compare_pnp_id+0x40/0x97
 <d9449113> i365_get_pair+0x25/0x3b [i82365]   <d944f1f5> add_socket+0x61/0=
xf4 [i82365]
 <d944fe19> init_i82365+0x2ae/0x41b [i82365]   <c0129b4e> sys_init_module+0=
x12b6/0x141d
 <c01029a3> sysenter_past_esp+0x54/0x75 =20
setup_irq: irq handler mismatch
 <c012f9dd> setup_irq+0xd3/0xe6   <d9449159> i365_count_irq+0x0/0x22 [i8236=
5]
 <c012fa5f> request_irq+0x6f/0x8b   <d944f2af> test_irq+0x27/0xc7 [i82365]
 <d9449159> i365_count_irq+0x0/0x22 [i82365]   <d944f8ea> add_pcic+0x59b/0x=
81c [i82365]
 <c0104dbb> do_IRQ+0x46/0x4e   <c011007b> machine_kexec+0x8f/0xbc
 <c01d282e> vsnprintf+0x455/0x490   <c01d2889> sprintf+0x20/0x23
 <c0211304> pnp_convert_id+0x74/0x79   <c020be49> compare_pnp_id+0x40/0x97
 <d9449113> i365_get_pair+0x25/0x3b [i82365]   <d944f1f5> add_socket+0x61/0=
xf4 [i82365]
 <d944fe19> init_i82365+0x2ae/0x41b [i82365]   <c0129b4e> sys_init_module+0=
x12b6/0x141d
 <c01029a3> sysenter_past_esp+0x54/0x75 =20
setup_irq: irq handler mismatch
 <c012f9dd> setup_irq+0xd3/0xe6   <d9449159> i365_count_irq+0x0/0x22 [i8236=
5]
 <c012fa5f> request_irq+0x6f/0x8b   <d944f2af> test_irq+0x27/0xc7 [i82365]
 <d9449159> i365_count_irq+0x0/0x22 [i82365]   <d944f8ea> add_pcic+0x59b/0x=
81c [i82365]
 <c0104dbb> do_IRQ+0x46/0x4e   <c011007b> machine_kexec+0x8f/0xbc
 <c01d282e> vsnprintf+0x455/0x490   <c01d2889> sprintf+0x20/0x23
 <c0211304> pnp_convert_id+0x74/0x79   <c020be49> compare_pnp_id+0x40/0x97
 <d9449113> i365_get_pair+0x25/0x3b [i82365]   <d944f1f5> add_socket+0x61/0=
xf4 [i82365]
 <d944fe19> init_i82365+0x2ae/0x41b [i82365]   <c0129b4e> sys_init_module+0=
x12b6/0x141d
 <c01029a3> sysenter_past_esp+0x54/0x75 =20
setup_irq: irq handler mismatch
 <c012f9dd> setup_irq+0xd3/0xe6   <d9449159> i365_count_irq+0x0/0x22 [i8236=
5]
 <c012fa5f> request_irq+0x6f/0x8b   <d944f2af> test_irq+0x27/0xc7 [i82365]
 <d9449159> i365_count_irq+0x0/0x22 [i82365]   <d944f8ea> add_pcic+0x59b/0x=
81c [i82365]
 <c0104dbb> do_IRQ+0x46/0x4e   <c011007b> machine_kexec+0x8f/0xbc
 <c01d282e> vsnprintf+0x455/0x490   <c01d2889> sprintf+0x20/0x23
 <c0211304> pnp_convert_id+0x74/0x79   <c020be49> compare_pnp_id+0x40/0x97
 <d9449113> i365_get_pair+0x25/0x3b [i82365]   <d944f1f5> add_socket+0x61/0=
xf4 [i82365]
 <d944fe19> init_i82365+0x2ae/0x41b [i82365]   <c0129b4e> sys_init_module+0=
x12b6/0x141d
 <c01029a3> sysenter_past_esp+0x54/0x75 =20
setup_irq: irq handler mismatch
 <c012f9dd> setup_irq+0xd3/0xe6   <d9449159> i365_count_irq+0x0/0x22 [i8236=
5]
 <c012fa5f> request_irq+0x6f/0x8b   <d944f2af> test_irq+0x27/0xc7 [i82365]
Losing some ticks... checking if CPU frequency changed.
 <d9449159> i365_count_irq+0x0/0x22 [i82365]   <d944f8ea> add_pcic+0x59b/0x=
81c [i82365]
 <c0104dbb> do_IRQ+0x46/0x4e   <c011007b> machine_kexec+0x8f/0xbc
 <c01d282e> vsnprintf+0x455/0x490   <c01d2889> sprintf+0x20/0x23
 <c0211304> pnp_convert_id+0x74/0x79   <c020be49> compare_pnp_id+0x40/0x97
 <d9449113> i365_get_pair+0x25/0x3b [i82365]   <d944f1f5> add_socket+0x61/0=
xf4 [i82365]
 <d944fe19> init_i82365+0x2ae/0x41b [i82365]   <c0129b4e> sys_init_module+0=
x12b6/0x141d
 <c01029a3> sysenter_past_esp+0x54/0x75 =20
    ISA irqs (scanned) =3D 3,4,5,7,10 polling interval =3D 1000 ms
cs: IO port probe 0x100-0x4ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.

I get a similar oops on 2.6.17-rc2 compiled with gcc-4.1 and on
2.6.17-rc1 compiled with gcc-4.0.3 . 2.6.16 does not oops.

This is a Toshiba 2805-S401 laptop, with the following PCI devices:

0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Hos=
t bridge (rev 03)
	Subsystem: Toshiba America Info Systems Toshiba Tecra 8100 Laptop System C=
hipset
	Flags: bus master, medium devsel, latency 64
	Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [a0] AGP version 1.0

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP =
bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	Memory behind bridge: f0000000-f7ffffff
	Prefetchable memory behind bridge: 20000000-200fffff

0000:00:05.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

0000:00:05.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev =
01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at fff0 [size=3D16]

0000:00:05.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev=
 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ff80 [size=3D32]

0000:00:05.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Flags: medium devsel, IRQ 9

0000:00:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro=
 100] (rev 09)
	Subsystem: Intel Corporation EtherExpress PRO/100+ MiniPCI
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at effff000 (32-bit, non-prefetchable) [size=3D4K]
	I/O ports at ff40 [size=3D64]
	Memory at effc0000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at efe00000 [disabled] [size=3D1M]
	Capabilities: [dc] Power Management version 2

0000:00:08.1 Serial controller: Xircom Mini-PCI K56Flex Modem (prog-if 02 [=
16550])
	Subsystem: Intel Corporation: Unknown device 2411
	Flags: medium devsel, IRQ 11
	I/O ports at ff38 [size=3D8]
	Memory at efdff000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2

0000:00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E=
 Audio Controller]
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at efdf0000 (32-bit, non-prefetchable) [size=3D32K]
	I/O ports at fec0 [size=3D64]
	I/O ports at febc [size=3D4]
	Capabilities: [50] Power Management version 1

0000:01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (re=
v 11) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems 86C584 SuperSavage/IXC Toshiba
	Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
	Memory at f0000000 (32-bit, non-prefetchable) [size=3D128M]
	Expansion ROM at 20000000 [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 1
	Capabilities: [80] AGP version 1.0

the PCMCIA controller was set up in the BIOS to be Intel PCIC compatible as
Linux does not support the native ToPIC 9x controller.

florin

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFES9QLND0rFCN2b1sRAkotAJ9HGrqLlr3oHhvNws7+vNfSVl5F+ACeKW80
1MW/0+AgCCpibiTnnbNnhjs=
=d56l
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
