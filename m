Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUDDMAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 08:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUDDMAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 08:00:55 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:55522 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262347AbUDDMAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 08:00:52 -0400
Date: Sun, 4 Apr 2004 14:00:51 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040404120051.GF27362@lug-owl.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <20040404101241.A10158@flint.arm.linux.org.uk> <20040404111712.GE27362@lug-owl.de> <20040404122958.A14991@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KUZuYByudWJZmlfy"
Content-Disposition: inline
In-Reply-To: <20040404122958.A14991@flint.arm.linux.org.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KUZuYByudWJZmlfy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-04-04 12:29:58 +0100, Russell King <rmk+lkml@arm.linux.org.uk>
wrote in message <20040404122958.A14991@flint.arm.linux.org.uk>:
> On Sun, Apr 04, 2004 at 01:17:12PM +0200, Jan-Benedict Glaw wrote:
> So we just need the VAX people to confirm that the new driver works
> for them, and then for _someone_ to remove the old driver (either
> the MIPS or the VAX people.)

Let me do some surgery :)

Interrupt setup is a bit tricky on the VAXen. First, they actually have
separated RX and TX IRQ and these aren't static. IRQ probing needs to be
redone (at least can't be easily copied) since the new dz_init() is
basically a complete new rewrite...

> > While at it, I've already implemented some SERIO changes. That'll allow
> > the dz.c driver to announce that it waits for LK-style keyboard on one
> > port and VSXXX-style mouse/digitizer on the 2nd port...
>=20
> Which dz.c ? 8)

Old ./drivers/char/dz.c + VAX changes + SERIO changes, that is :)  I
guess best practice is that VAX people first merge up with MIPS folks,
then we snatch the old driver together and have a beer...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--KUZuYByudWJZmlfy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAb/jzHb1edYOZ4bsRAsAWAJ9tKmndQDMffUMVjxuCie3+JDATAACeOqaW
xSYttut1VuBJXGlsS2/qPb4=
=8F3N
-----END PGP SIGNATURE-----

--KUZuYByudWJZmlfy--
