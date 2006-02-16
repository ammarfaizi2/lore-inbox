Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWBPXRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWBPXRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWBPXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:17:35 -0500
Received: from sipsolutions.net ([66.160.135.76]:41231 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932483AbWBPXRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:17:34 -0500
Subject: quad g5 powermac: soft lockup when starting gparted
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AI16m+zOlrwZfhBvdgn/"
Date: Fri, 17 Feb 2006 00:16:18 +0100
Message-Id: <1140131778.10320.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AI16m+zOlrwZfhBvdgn/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

There's a weird problem here. When I start gparted as a normal user, and
my swap partition is not in use, it locks up and I get the following
after a while:

BUG: soft lockup detected on CPU#0!
NIP: C000000000351218 LR: C0000000002076AC CTR: C000000000207620
REGS: c00000000595b9b0 TRAP: 0901   Not tainted  (2.6.16-rc3-johill)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 88000484  XER: 20000000
TASK =3D c00000000290f040[8812] 'gksu' THREAD: c000000005958000 CPU: 0
GPR00: 0000000080000001 C00000000595BC30 C000000000562B60 C000000004BC7818=20
GPR04: 9000000000009032 C0000000003901D8 C0000000003901D8 0000000000000020=20
GPR08: C000000000419880 C000000000419880 C000000000419880 0000000000000000=20
GPR12: 100000000000D032 C00000000041E980=20
NIP [C000000000351218] .lock_kernel+0x58/0x88
LR [C0000000002076AC] .tty_read+0x8c/0x13c
Call Trace:
[C00000000595BC30] [C0000000002076A4] .tty_read+0x84/0x13c (unreliable)
[C00000000595BCF0] [C000000000094C48] .vfs_read+0xd0/0x1b0
[C00000000595BD90] [C000000000095910] .sys_read+0x4c/0x8c
[C00000000595BE30] [C0000000000086F8] syscall_exit+0x0/0x40
Instruction dump:
e91e8000 7d0a4378 800d0008 7d205028 2c090000 40820010 7c00512d 40a2fff0=20
4c00012c 2fa90000 41be0020 7d094378 <7c210b78> 80090000 2fa00000 40befff4=20


The strange thing is that it does not happen when the swap partition is
in use (though empty) or when I start gparted as root.

johannes

--=-AI16m+zOlrwZfhBvdgn/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAQ/UHwaVg1VMiehFYAQI+qA//Y93am7DtIJs5R4tE076fGo0Xq4P1gfEH
mTdbAR+S36h3FpC0G0AjLztVODsBUan/MDLqpd0npDki9ehHb1Y31FjYWw1TCrhd
SzW3VtO3wWFyudCqG2zNlL6v+hDKL6BVy0LDh9qk4eErqc/UUl7QDu1a3eEEyMmY
tAGfbA6kUU/9qknhgr8b/oazlGKAqPA5zWOtmgV+TvkyLoCUSOS7XdjUr7sgIZ3h
K3xZ1I8X1McPX/vGd9OTWLtV8WiReG35CuJXcVrmXq/zgTew9c36wE00G8ughS8F
UcM0ihOBFoL61/y8XzCk0ludAf8LMKl4ksvfyTS50rGS0kWnAErlkd20GhUH8CLg
cUYf+W/6NJlc7kDdUICq9EmvmpOvHQyAbDqZrgVfF1JOi6DvhNm+GmBKtk0KDd+B
SwiKDTOiicc/FK7ilJJd8baFJpbGZbnolZvr/GDgJeXLvYPpQ5FjOfhAk8GWjdtQ
R83EwAfonrOidVF4yU9IMposj371s0o82ih0+PW99ny87M4fBwCMrPnRhcXNEyy6
JAc2nfdJXC6G1VQ9u7bIhVQtTOakz8y49QJ5wxCGHGvU114CfXToPasIh4SrHlvA
2H6Ag+dCV7/nD0nukdPp+Bh/36nEv408sDYOey66SN69Wjp+t/MAlflPpVAPhFPm
me5l8vBizn0=
=iI+H
-----END PGP SIGNATURE-----

--=-AI16m+zOlrwZfhBvdgn/--

