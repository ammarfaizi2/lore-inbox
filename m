Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVAYRi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVAYRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVAYRi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:38:27 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:38928 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262020AbVAYRiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:38:17 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Michal Ludvig <michal@logix.cz>
In-Reply-To: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t6ebtz95d453ekIuVcWJ"
Date: Tue, 25 Jan 2005 18:38:14 +0100
Message-Id: <1106674694.13913.14.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t6ebtz95d453ekIuVcWJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 10:52 -0500, James Morris wrote:

> I think the generic scatterwalk changes are more important and=20
> fundamental (still to be fully reviewed).
>=20
> I agree with Fruhwirth that the cipher code is starting to become
> ungainly.  I'm not sure these patches are heading in the right direction=20
> from a design point of view, although we do need the functionality. =20
>=20
> Perhaps temporarily drop the multible block changes above until we get th=
e
> generic scatterwalk code in and a cleaned up design to handle cipher mode
> offload.
>=20
> Fruhwirth, do you have any cycles to work on implementing your ideas for=20
> more cleanly reworking Michal's multiblock code?

The changes, I purposed, shouldn't be too hard to implement. I will
build a skeleton for Michael, but I can't test the code, as I don't own
a padlock system, further, I'm sorry to say but, my time is somehow
constrained.. I really gotta start to write my diploma thesis, I'm
delaying this for too long for crypto stuff now.

But before I put that into the my queue, I would like to see some kind
of decision on an async crypto framework. acrypto cames with hardware
support. So, are we heading for hardware support in cryptoapi, hardware
support in acrypto, acrypto instead of cryptoapi, OCF instead of
cryptoapi, or put everything into the kernel and export 3 interface?=20

And how - when there is more than one interface - are these projects
going to reuse code?

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-t6ebtz95d453ekIuVcWJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9oQFW7sr9DEJLk4RAnCsAKCDCmMVxgSfOmX3c+ejPK+kR8ci9QCeI2il
uMV4IBDvKaJZZYqsGAbzQbQ=
=aCtT
-----END PGP SIGNATURE-----

--=-t6ebtz95d453ekIuVcWJ--
