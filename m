Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbTA0IPx>; Mon, 27 Jan 2003 03:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbTA0IPx>; Mon, 27 Jan 2003 03:15:53 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4576
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267144AbTA0IPw>; Mon, 27 Jan 2003 03:15:52 -0500
Date: Mon, 27 Jan 2003 00:24:53 -0800
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, dilinger@voxel.net
Subject: Re: 2.5.59-mm6
Message-ID: <20030127082452.GA18747@ludicrus.ath.cx>
References: <20030126231015.6ad982e4.akpm@digeo.com> <pan.2003.01.27.08.17.50.697367@voxel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <pan.2003.01.27.08.17.50.697367@voxel.net>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2003 at 03:17:54AM -0500, Andres Salomon wrote:
> This one boots for me (with devfs enabled).  I got some rather interesting
> stack dumps, however, during boot.

I'm experiencing similar problems without devfs...

> Warning! Detected 2173 micro-second gap between interrupts.
>   Compensating for 1 lost ticks.
> Call Trace:
>  [<c010b8a8>] handle_IRQ_event+0x38/0x60
>  [<c010bade>] do_IRQ+0xae/0x160
>  [<c0105000>] _stext+0x0/0x30
>  [<c010a150>] common_interrupt+0x18/0x20
>  [<c0105000>] _stext+0x0/0x30

Each of these warnings reproduces for each input device on my system=20
(there are 3 now, so if i disconnect, say, my USB mouse, there will be=20
only 2.)

In other news (this happened in -mm5, not sure if this happened to=20
others or not:)

Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin=20
is 60 seconds).
Uninitialised timer!
This is just a warning.  Your computer is OK
function=3D0xc0216100, data=3D0x0
Call Trace:
 [<c0121ce1>] check_timer_failed+0x61/0x70
 [<c0216100>] hangcheck_fire+0x0/0xc0
 [<c0121e5f>] mod_timer+0x2f/0x180
 [<c0105075>] init+0x35/0x160
 [<c0105040>] init+0x0/0x160
 [<c010713d>] kernel_thread_helper+0x5/0x18

No visible problems though, at all.

-Josh

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+NOzU6TRUxq22Mx4RAgfSAJsHDnUZJqqdxGKs3RJAWMt7RvXuIgCgrRAy
ofr8unF4SZY503A5QkhPDSM=
=SpBs
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
