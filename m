Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263504AbTCNVCw>; Fri, 14 Mar 2003 16:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263508AbTCNVCw>; Fri, 14 Mar 2003 16:02:52 -0500
Received: from B568c.pppool.de ([213.7.86.140]:38804 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S263504AbTCNVCo>; Fri, 14 Mar 2003 16:02:44 -0500
Subject: 2.5.64-ac3: Crash in ide_init_queue
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ynMGuXDms+gAc1bFHDLq"
Organization: 
Message-Id: <1047676410.7452.34.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Mar 2003 22:13:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ynMGuXDms+gAc1bFHDLq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

my new motherboard with KT400 chipset oopses in ide_init_queue on bootup
with the follow output:

Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010282
EIP is at 0x0
eax: c044af44   ebx: c044aff0   ecx:  00000000   edx: 00000000
esi: c044b000   edi: c044af44   ebp:  c151dee8   esp: c151ded0
ds: 007b   es: 007b  ss: 0068
Process swapper (pid: 1, threadinfo=3Dc151c000 task=3Ddff8e040)
Stack: c0263dff c044aff0 00000001 c03cd660 c044aff0 c1527ef4 c151df30 c0264=
006
       c044aff0 c0262b10
Call Trace:
 [<c0263dff>] ide_init_queue+0x9f/0xb0
 [<c0264006>] init_irq+0x1f6/0x3d0
 [<c0262b10>] ide_intr+0x0/0x180
 [<c0264658>] hwif_init+0xe8/0x290
 [<c0264924>] ideprobe_init+0xf4/0x110
 [<c02209d1>] driver_register+0x31/0x40
 [<c010507d>] init+0x3d/0x160
 [<c0105040>] init+0x0/0x160
 [<c010740d>] kernel_thread_helper+0x5/0x18

Code:  Bad EIP value.

The system doesn't have a harddrive, both channels are enabled,
the second bus has a TOSHIBA Combo DVD/CD-R SD-R1002 conntected
as master device. Disabling the secondary channel channel fixes=20
the problem.

Should I bugzill it?

--=20
Servus,
       Daniel

--=-ynMGuXDms+gAc1bFHDLq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ckX5chlzsq9KoIYRAo2VAKDUHoqyG6dpsgYrto7cnEn9+rGd/ACfbO8n
kZzY5XRXjFpfdecEK8DzPXM=
=Z1T9
-----END PGP SIGNATURE-----

--=-ynMGuXDms+gAc1bFHDLq--

