Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSIJCC3>; Mon, 9 Sep 2002 22:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318971AbSIJCC3>; Mon, 9 Sep 2002 22:02:29 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:1286 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S318730AbSIJCC2>; Mon, 9 Sep 2002 22:02:28 -0400
Date: Mon, 9 Sep 2002 19:07:09 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020909190709.E16183@one-eyed-alien.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20020909221727.GF7433@kroah.com> <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Sep 09, 2002 at 05:17:40PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus, normally I would agree with you on this, but...

(1) We can't always handle it.  The current code implements a heuristic,
which is not always correct.  When it gets it wrong....

(2) show_trace() was proving ineffective in bringing the bad commands to
light so they might be fixed

(3) Given that we think we've fixed all of these bad initiators, the BUG()
really is something that should never happen.

Matt

On Mon, Sep 09, 2002 at 05:17:40PM -0700, Linus Torvalds wrote:
>=20
> Greg, please don't do this
>=20
> > ChangeSet@1.614, 2002-09-05 08:33:20-07:00, greg@kroah.com
> >   USB: storage driver: replace show_trace() with BUG()
>=20
> that BUG() thing is _way_ out of line, and has killed a few of my machine=
s=20
> several times for no good reason. It actively hurts debuggability, becaus=
e=20
> the machine is totally dead after it, and the whole and ONLY point of=20
> BUG() messages is to help debugging and make it clear that we can't handl=
e=20
> something.
>=20
> In this case, we _can_ handle it, and we're much better off with a machin=
e=20
> that works and that you can look up the messages with than killing it.
>=20
> Rule of thumb: BUG() is only good for something that never happens and=20
> that we really have no other option for (ie state is so corrupt that=20
> continuing is deadly).
>=20
> 		Linus
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I need a computer?
					-- Customer
User Friendly, 2/19/1998

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9fVPNIjReC7bSPZARAilVAKCXVEmeYSYYN7NEZl1aECHTCgEz4QCdFf5V
kXOCp2Jzw0JGJUAlsU5iaTc=
=XhvW
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
