Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUBCXDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUBCXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:03:18 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:30600 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266169AbUBCXDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:03:15 -0500
Subject: Re: [ANNOUNCE] udev 016 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1075843712.7473.60.camel@nosferatu.lan>
References: <20040203201359.GB19476@kroah.com>
	 <1075843712.7473.60.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ytucyVbZdnneM8/4jC7m"
Message-Id: <1075849413.11322.6.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 01:03:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ytucyVbZdnneM8/4jC7m
Content-Type: multipart/mixed; boundary="=-ifVfywCxR0+pou2FJFIg"


--=-ifVfywCxR0+pou2FJFIg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 23:28, Martin Schlemmer wrote:
> On Tue, 2004-02-03 at 22:13, Greg KH wrote:
>=20
> Except if I miss something major, udevsend and udevd still do not
> work:
>=20

Skip that, it does work if SEQNUM is set :P

Anyhow, is it _really_ needed for SEQNUM to be set?  What about
the attached patch?

Then, order I have not really checked yet, but there are two things
that bother me:

1) latency is even higher than before (btw Greg, is there going to be
more sysfs/whatever fixes to get udev even faster, or is this the
limit?)

2) events gets missing.  If you for example use udevsend in the
initscript that populate /dev (/udev), the amount of nodes/links
created is off with about 10-50 (once about 250) entries.


Thanks,


--=20
Martin Schlemmer

--=-ifVfywCxR0+pou2FJFIg
Content-Disposition: attachment; filename=udev-016-udevsend-missing-seqnum.patch
Content-Type: text/x-patch; name=udev-016-udevsend-missing-seqnum.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHVkZXYtMDE2L3VkZXZzZW5kLmMJMjAwNC0wMi0wNCAwMDo1NToyMy41MjI0MjgzMTIgKzAy
MDANCisrKyB1ZGV2LTAxNi5zZXFudW0vdWRldnNlbmQuYwkyMDA0LTAyLTA0IDAwOjU3OjM3Ljg5
ODAwMDEyMCArMDIwMA0KQEAgLTE0OSwxMCArMTQ5LDE0IEBADQogDQogCXNlcW51bSA9IGdldF9z
ZXFudW0oKTsNCiAJaWYgKHNlcW51bSA9PSBOVUxMKSB7DQorI2lmIDANCiAJCWRiZygibm8gc2Vx
bnVtIik7DQogCQlnb3RvIGV4aXQ7DQorI2VuZGlmDQorCQlzZXEgPSAxOw0KKwl9IGVsc2Ugew0K
KwkJc2VxID0gYXRvaShzZXFudW0pOw0KIAl9DQotCXNlcSA9IGF0b2koc2VxbnVtKTsNCiANCiAJ
c29jayA9IHNvY2tldChBRl9MT0NBTCwgU09DS19TVFJFQU0sIDApOw0KIAlpZiAoc29jayA9PSAt
MSkgew0K

--=-ifVfywCxR0+pou2FJFIg--

--=-ytucyVbZdnneM8/4jC7m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAICjFqburzKaJYLYRAkwkAJ0cXgp53g7p5c3d9eN25W0HZo2P9gCeOQTs
TFptpxsaE8TvTSQVNmRN0zc=
=Cob5
-----END PGP SIGNATURE-----

--=-ytucyVbZdnneM8/4jC7m--

