Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTA0IhG>; Mon, 27 Jan 2003 03:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTA0IhG>; Mon, 27 Jan 2003 03:37:06 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:11488
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267154AbTA0IhE>; Mon, 27 Jan 2003 03:37:04 -0500
Date: Mon, 27 Jan 2003 00:46:04 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm6
Message-ID: <20030127084604.GA19453@ludicrus.ath.cx>
References: <20030126231015.6ad982e4.akpm@digeo.com> <pan.2003.01.27.08.17.50.697367@voxel.net> <20030127082452.GA18747@ludicrus.ath.cx> <20030127004059.5717e8e3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20030127004059.5717e8e3.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2003 at 12:40:59AM -0800, Andrew Morton wrote:
[snip]

> This is debug stuff - it tells us which drivers are disabling interrupts =
for
> more than one or two clock ticks.  Please send the full trace so we can b=
ug
> the maintainers into fixing the drivers up.
>=20

Sure:

------
Warning! Detected 30879 micro-second gap between interrupts.
  Compensating for 29 lost ticks.
Call Trace:
 [<c010a948>] handle_IRQ_event+0x38/0x60
 [<c010ab77>] do_IRQ+0x97/0x120
 [<c010957c>] common_interrupt+0x18/0x20
 [<c02601f4>] i8042_command+0x94/0xc0
 [<c02602b6>] i8042_aux_write+0x36/0x70
 [<c025e1cd>] atkbd_sendbyte+0x7d/0x80
 [<c025e2b1>] atkbd_command+0xe1/0xf0
 [<c025e64b>] atkbd_probe+0x12b/0x180
 [<c025e96a>] atkbd_connect+0x25a/0x2b0
 [<c025fb93>] serio_find_dev+0x53/0x60
 [<c0105075>] init+0x35/0x160
 [<c0105040>] init+0x0/0x160
 [<c010713d>] kernel_thread_helper+0x5/0x18

Warning! Detected 113343 micro-second gap between interrupts.
  Compensating for 112 lost ticks.
Call Trace:
 [<c010a948>] handle_IRQ_event+0x38/0x60
 [<c010ab77>] do_IRQ+0x97/0x120
 [<c010957c>] common_interrupt+0x18/0x20
 [<c02601f4>] i8042_command+0x94/0xc0
 [<c0260436>] i8042_close+0x46/0x90
 [<c025ff81>] serio_close+0x11/0x20
 [<c025e989>] atkbd_connect+0x279/0x2b0
 [<c025fb93>] serio_find_dev+0x53/0x60
 [<c0105075>] init+0x35/0x160
 [<c0105040>] init+0x0/0x160
 [<c010713d>] kernel_thread_helper+0x5/0x18

Warning! Detected 30145 micro-second gap between interrupts.
  Compensating for 29 lost ticks.
Call Trace:
 [<c010a948>] handle_IRQ_event+0x38/0x60
 [<c010ab77>] do_IRQ+0x97/0x120
 [<c010957c>] common_interrupt+0x18/0x20
 [<c02601f4>] i8042_command+0x94/0xc0
 [<c0260436>] i8042_close+0x46/0x90
 [<c025ff81>] serio_close+0x11/0x20
 [<c025fa7e>] psmouse_connect+0x19e/0x1c0
 [<c025fb93>] serio_find_dev+0x53/0x60
 [<c0105075>] init+0x35/0x160
 [<c0105040>] init+0x0/0x160
 [<c010713d>] kernel_thread_helper+0x5/0x18
---
>> Each of these warnings reproduces for each input device on my system
>> (there are 3 now, so if i disconnect, say, my USB mouse, there will be
>> only 2.)

A closer look tells me that this isn't quite true. Sorry..

Regards
Josh

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+NPHM6TRUxq22Mx4RArwPAKCCKBUOo/SsvCTL/OYE1VKwFX9fJgCfciw3
ebcwfeToJ06CvEHtO7lWEAc=
=5NFs
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
