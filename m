Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965333AbWI1LiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbWI1LiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWI1LiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:38:07 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:45490 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S965322AbWI1LiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:38:04 -0400
Subject: Re: forcedeth - WOL [SOLVED]
From: Martin Filip <bugtraq@smoula.net>
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, Ayaz Abdulla <aabdulla@nvidia.com>,
       stable@kernel.org
In-Reply-To: <20060927203906.f4fc331e.akpm@osdl.org>
References: <1159379441.9024.7.camel@archon.smoula-in.net>
	 <20060927183857.GA2963@atjola.homenet>
	 <1159389486.8902.4.camel@archon.smoula-in.net>
	 <20060927165704.613bf0aa.akpm@osdl.org>
	 <20060928000447.GB2963@atjola.homenet>
	 <20060928004053.GA3521@atjola.homenet>
	 <20060928010133.GB3521@atjola.homenet>
	 <20060927183625.5231e969.akpm@osdl.org>
	 <20060928020438.GC3521@atjola.homenet>
	 <20060928022447.GA3890@atjola.homenet>
	 <20060927203906.f4fc331e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eDe6eLH0S6kGo8iH5UNK"
Date: Thu, 28 Sep 2006 13:37:45 +0200
Message-Id: <1159443465.8961.4.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eDe6eLH0S6kGo8iH5UNK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > > I just took a peek at the code.
> > >=20
> > > The version on bugzilla (last attachment, comment #22), which was
> > > reported to work correctly, has the MAC address reversal hardcoded.
> > > The driver in 2.6.18 has some logic to detect if it should reverse th=
e
> > > MAC address. So it looks like a hardware oddity/bug that the driver
> > > wants to fix but fails. I'll see what happens if I force address
> > > reversal and if I can decipher anything, but probably someone else wi=
ll
> > > have to cast the runes...
> >=20
> > OK, please excuse me wasting your time, it's late over here... I've
> > actually been looking at Linus' git tree (pulled yesterday) while
> > writing that mail, not 2.6.18.
> > 2.6.18 does _not_ contain the address reversal detection.
> > Using the git tree instead of 2.6.18 WOL works as expected, without
> > having to reverse the MAC address.
> >=20
>=20
> hm, OK, thanks.  Ayaz, do you think 5070d3408405ae1941f259acac7a9882045c3=
be4 is
> a suitable thing for 2.6.18.x?
Hi,

you never sleep guys, do you :) I've just tried patch from bugzilla.
(here is version twaked to be usable with 2.6.18
http://www.smoula.net/download/forcedeth.c) and it looks like it's
working correctly with correct ordered MAC.

--=20
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net
www: http://www.smoula.net

 _______________________________=20
< BOFH Excuse #100: IRQ dropout >
 -------------------------------=20
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

--=-eDe6eLH0S6kGo8iH5UNK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Toto je =?UTF-8?Q?digit=C3=A1ln=C4=9B?=
	=?ISO-8859-1?Q?_podepsan=E1?= =?UTF-8?Q?_=C4=8D=C3=A1st?=
	=?ISO-8859-1?Q?_zpr=E1vy?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFG7QJzvp9bBLJ9XMRAhOEAJ43RCO/BwZ5H04pi4TK5FnlO4VfLgCeO6eg
XpZ6Fr6jeGIKzytLDgnvVbc=
=kcri
-----END PGP SIGNATURE-----

--=-eDe6eLH0S6kGo8iH5UNK--

