Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUFOSW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUFOSW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbUFOSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:21:15 -0400
Received: from smtp.rol.ru ([194.67.21.9]:4968 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S265815AbUFOSUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:20:06 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Eugene Crosser <crosser@rol.ru>
To: Petter Larsen <pla@morecom.no>
Cc: ext3 <ext3-users@redhat.com>, ext3@philwhite.org, Nicolas.Kowalski@imag.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <1087322976.1874.36.camel@pla.lokal.lan>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g63ZQZyeOs9RjsKZWJub"
Organization: Sovintel
Date: Tue, 15 Jun 2004 22:20:02 +0400
Message-Id: <1087323602.16701.42.camel@ariel.sovam.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g63ZQZyeOs9RjsKZWJub
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 at 20:09 +0200, Petter Larsen wrote:

> Can anybody of you acknowledge or not if mode data=3Djournal in ext3 is
> safe to use in Linux kernel 2.6.x?
>=20
> Wee need to have a very consistent and integrity for our filesystem, and
> it would then be desired to journal both data and metadata.
>=20
> But if this mode can corrupt the filesystem as both Phil White and
> Nicolas Kowalski has experienced, it may be more advised to use mode
> data=3Dordered instead.
>=20
> Data integrity is much more important for us than speed.

I ran ext3 with data=3Djournal on 2.6.6smp for about a week on a heavily
loaded system (I mean it).  I did not ever experience filesystem
corruption (related to the fs code).  I did, however, hit complete
system lockup once.  It *may* have been unrelated to the fs code.

(If you use quota, it *will* lock.  The author is working on a fix.
Above, I am referring to a lockup with quota off).

Eugene

--=-g63ZQZyeOs9RjsKZWJub
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzz3StQFsU5rTNjcRAljRAJ9RkneRNyFM8ylFi9zy7OJIhWtT6gCghrkh
q0kZj4j9sf8WOSi0F443jKI=
=oviV
-----END PGP SIGNATURE-----

--=-g63ZQZyeOs9RjsKZWJub--

