Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTKEU6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 15:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTKEU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 15:58:18 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:5897 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263117AbTKEU6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 15:58:15 -0500
Date: Wed, 5 Nov 2003 12:58:13 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031105125813.A5648@one-eyed-alien.net>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20031105204522.GA11431@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031105204522.GA11431@work.bitmover.com>; from lm@bitmover.com on Wed, Nov 05, 2003 at 12:45:22PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Out of curiosity, what were the changed lines?

Matt

On Wed, Nov 05, 2003 at 12:45:22PM -0800, Larry McVoy wrote:
> Somebody has modified the CVS tree on kernel.bkbits.net directly.  Dave l=
ooked
> at the machine and it looked like someone may have been trying to break i=
n and
> do it. =20
>=20
> We've fixed the file in question, the conversion is done back here at Bit=
Mover
> and after we transfer the files we check them and make sure they are OK a=
nd=20
> this file got flagged. =20
>=20
> The CVS tree is fine, you might want to remove and update exit.c to make =
sure
> you have the current version in your tree however.
>=20
> The problem file is kernel/exit.c which has a few extra entries like so:
>=20
>     revision 1.121
>     date: 2003/11/04 16:44:19;  author: davem;  state: Exp;  lines: +58 -0
>     Oops, I worked on the  the wrong file, fixed again.
>     ----------------------------
>     revision 1.120
>     date: 2003/11/04 16:42:00;  author: davem;  state: Exp;  lines: +0 -58
>     *** empty log message ***
>     ----------------------------
>     revision 1.119
>     date: 2003/11/04 16:22:47;  author: davem;  state: Exp;  lines: +2 -0
>     *** empty log message ***
>     ----------------------------
>     revision 1.118
>     date: 2003/10/27 19:50:03;  author: torvalds;  state: Exp;  lines: +1=
1 -5
>     Fix ZOMBIE race with self-reaping threads.
>=20
>     exit_notify() used to leave a window open when a thread
>     died that made the thread visible as a ZOMBIE even though
>     the thread reaped itself. This closes that window by marking
>     the thread DEAD within the tasklist_lock.
>=20
>     (Logical change 1.14141)
>     ----------------------------
>=20
> Notice how the top 3 do not have the (Logical change X.YZ) at the end?
> That is a pointer so you can figure out the changeset boundaries and
> it is added back here during the conversion process.  The file here is
> fine which leads me to believe that someone modified the file either on
> kernel.bkbits.net or managed to get in through the pserver.  Dave swears
> up and down that it wasn't him so if anyone can step forward and claim
> responsibility that would be nice.
>=20
> It's not a big deal, we catch stuff like this, but it's annoying to the=
=20
> CVS users.
> --=20
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.=
com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Oh great modem, why hast thou forsaken me?
					-- Dust Puppy
User Friendly, 3/2/1998

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/qWRlIjReC7bSPZARAmi7AJ4gOh7m6VdZlxf+0MwQJUZBLf5lzQCgt5jd
mfKDX/8F5Kz9b+mfvsJjGKY=
=gT3l
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
