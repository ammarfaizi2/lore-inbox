Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUA1Rjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUA1Rjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:39:55 -0500
Received: from pool-162-84-168-72.ny5030.east.verizon.net ([162.84.168.72]:2755
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S266034AbUA1Rjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:39:52 -0500
Subject: Re: [2.6.2-rc1-mm3] Badness in interruptible_sleep_on.
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, XFS List <linux-xfs@oss.sgi.com>
In-Reply-To: <1075140703.2291.8.camel@blaze.homeip.net>
References: <1075140703.2291.8.camel@blaze.homeip.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RxMUEWcBDmmM7M+Z9p49"
Message-Id: <1075311607.3551.3.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (Slackware Linux)
Date: Wed, 28 Jan 2004 12:40:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RxMUEWcBDmmM7M+Z9p49
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-26 at 13:11, Paul Blazejowski wrote:
> Hello Andrew,
>=20
> I see these panics related to pagebuf from XFS on:
>=20
> Linux blaze 2.6.2-rc1-mm3 #1 Sun Jan 25 18:24:01 EST 2004 i686 AMD
> Athlon(tm) XP 3200+ AuthenticAMD GNU/Linux
>=20
> Code snip:
>=20
> Badness in interruptible_sleep_on at kernel/sched.c:2242
> Call Trace:
>  [<c011cb93>] interruptible_sleep_on+0x103/0x110
>  [<c011c740>] default_wake_function+0x0/0x20
>  [<c0209db0>] pagebuf_daemon+0x0/0x260
>  [<c0209ff4>] pagebuf_daemon+0x244/0x260
>=20
> ret_from_fork+0x6/0x14
>  [<c0209d80>] pagebuf_daemon_wakeup+0x0/0x30
>  [<c0209db0>] <6>hda: 58633344 sectors (30020 MB) w/2048KiB Cache,
> CHS=3D58168/16/63, UDMA(100)
>  hda: hda1
> pagebuf_daemon+0x0/0x260
>  [<c0108e49>] kernel_thread_helper+0x5/0xc
>=20
> Also this creeps in:
>=20
> atkbd.c: Unknown key released (translated set 2, code 0x7a on
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> request_module: failed /sbin/modprobe -- block-major-11-0. error =3D 256

Hello folks,

Just to add the same happens under 2.6.2-rc2-mm1 kernel i just compiled.

Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [<c011cc13>] interruptible_sleep_on+0x103/0x110
 [<c011c7c0>] default_wake_function+0x0/0x20
 [<c0209ef0>] pagebuf_daemon+0x0/0x260
 [<c020a134>] pagebuf_daemon+0x244/0x260

ret_from_fork+0x6/0x14
 [<c0209ec0>] pagebuf_daemon_wakeup+0x0/0x30
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3D58168/16/63,
UDMA(100)
 hda: hda1
 [<c0209ef0>] pagebuf_daemon+0x0/0x260
 [<c0108e49>] kernel_thread_helper+0x5/0xc

Regards,

Paul B.

--=-RxMUEWcBDmmM7M+Z9p49
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAF/P3v0+bfGBjm98RAl4oAJ9TgwJzIqnWk1lho4H2/UN9lesAJwCfZKDP
zqld3HqW6ZyvLf4p6MYnVLw=
=U0t/
-----END PGP SIGNATURE-----

--=-RxMUEWcBDmmM7M+Z9p49--
