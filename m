Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUEJMWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUEJMWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbUEJMWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:22:53 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:56317 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264660AbUEJMW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:22:26 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Allen Martin <AMartin@nvidia.com>, cbradney@zip.com.au
In-Reply-To: <200405102137.11468.ross@datscreative.com.au>
References: <200405102137.11468.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-udlyPqpcEtwRtyUwm68I"
Message-Id: <1084191744.2954.6.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 14:22:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-udlyPqpcEtwRtyUwm68I
Content-Type: multipart/mixed; boundary="=-WTNdWQhGYMCW5MhHW1gS"


--=-WTNdWQhGYMCW5MhHW1gS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-10 at 13:37, Ross Dickson wrote:
> Craig Bradney wrote
>=20
> >Well.. 2.6.6 is released.. and THANK YOU Linus and all the patch=20
> > writers.. we have nforce2 fixes in the released kernel now. I'm just=20
> > waiting for a gentoo-dev-sources release now..=20
> >
> >Craig=20
>=20
> MOMENT PLEASE.
> ALMOST complete nforce2 support. Job not done yet.

Damn =3D)

> Unfortunately 2.6.6 still has the old check_timer code which inhibits
> nmi_watchdog=3D1 on all nforce2 from working by having timer_ack=3D1
> when checking io-apic pit routing.
>=20
> It is a hardware issue - NOT A BUGGY BIOS ISSUE inside the integrated=20
> nforce2 interrupt routing.

So it should be in.

> To my understanding IT WILL NEVER BE FIXED BY A BIOS REVISION and=20
> after reading the 8259 datasheets I think it is a mistake within the
> existing code to have the timer_ack on there in the first place.=20

The "breaking" machine could be blacklisted instead.

> I would still like to see Maciej's check_timer patch in the kernel. It wa=
s
> pulled after only a single user mobo complaint was posted yet it helps
> both nforce2 and ibm bios pc's. To my knowledge little effort was made
> by that user to accomodate the patch - it was just outright pulled in spi=
te
> of its benefit to others?

Hummm, and now ppl seem to be forcing 4k stacks that breaks my laptop to
a level of non usability.. =3DP

> Who do we ask to revisit this? Linus? the io-apic.c maintainer? or the on=
e
> user with a complaint?

Perhaps there should be a workaround option, ie like acpi=3Dforce etc.

> That patch that was dropped by Linus? after appearing in 2.6.3-mm3.=20
> For those nforce2 users with problems of clock skew with the timer into p=
in0
> routing, that patch gave a virtual wire timer routing which worked well.

> It also works around serious problems for ibm users who also want it in.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/4421.html

Rediffed it against 2.6.6
But i don't see how the virtual wire mode was done, i just rediffed the
patch that i found.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-WTNdWQhGYMCW5MhHW1gS
Content-Disposition: attachment; filename=io-apic.patch
Content-Type: text/x-patch; name=io-apic.patch; charset=iso-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jLm9yaWcJMjAwNC0wNS0xMCAxNDow
ODowMC4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC9hcmNoL2kzODYva2VybmVsL2lvX2FwaWMu
YwkyMDA0LTA1LTEwIDE0OjEyOjE3LjAwMDAwMDAwMCArMDIwMA0KQEAgLTIxNTksNiArMjE1OSwx
MCBAQA0KIHsNCiAJaW50IHBpbjEsIHBpbjI7DQogCWludCB2ZWN0b3I7DQorCXVuc2lnbmVkIGlu
dCB2ZXI7DQorDQorCXZlciA9IGFwaWNfcmVhZChBUElDX0xWUik7DQorCXZlciA9IEdFVF9BUElD
X1ZFUlNJT04odmVyKTsNCiANCiAJLyoNCiAJICogZ2V0L3NldCB0aGUgdGltZXIgSVJRIHZlY3Rv
cjoNCkBAIC0yMTcyLDExICsyMTc2LDE1IEBADQogCSAqIG1vZGUgZm9yIHRoZSA4MjU5QSB3aGVu
ZXZlciBpbnRlcnJ1cHRzIGFyZSByb3V0ZWQNCiAJICogdGhyb3VnaCBJL08gQVBJQ3MuICBBbHNv
IElSUTAgaGFzIHRvIGJlIGVuYWJsZWQgaW4NCiAJICogdGhlIDgyNTlBIHdoaWNoIGltcGxpZXMg
dGhlIHZpcnR1YWwgd2lyZSBoYXMgdG8gYmUNCi0JICogZGlzYWJsZWQgaW4gdGhlIGxvY2FsIEFQ
SUMuDQorCSAqIGRpc2FibGVkIGluIHRoZSBsb2NhbCBBUElDLiBGaW5hbGx5IHRpbWVyIGludGVy
cnVwdHMNCisJICogbmVlZCB0byBiZSBhY2tub3dsZWRnZWQgbWFudWFsbHkgaW4gdGhlIDgyNTlB
IGZvcg0KKwkgKiBkb19zbG93X3RpbWVvZmZzZXQoKSBhbmQgZm9yIHRoZSBpODI0ODlEWCB3aGVu
IHVzaW5nDQorCSAqIHRoZSBOTUkgd2F0Y2hkb2cuDQogCSAqLw0KIAlhcGljX3dyaXRlX2Fyb3Vu
ZChBUElDX0xWVDAsIEFQSUNfTFZUX01BU0tFRCB8IEFQSUNfRE1fRVhUSU5UKTsNCiAJaW5pdF84
MjU5QSgxKTsNCi0JdGltZXJfYWNrID0gMTsNCisJdGltZXJfYWNrID0gIWNwdV9oYXNfdHNjOw0K
Kwl0aW1lcl9hY2sgfD0gbm1pX3dhdGNoZG9nID09IE5NSV9JT19BUElDICYmICFBUElDX0lOVEVH
UkFURUQodmVyKTsNCiAJZW5hYmxlXzgyNTlBX2lycSgwKTsNCiANCiAJcGluMSA9IGZpbmRfaXNh
X2lycV9waW4oMCwgbXBfSU5UKTsNCkBAIC0yMTk0LDcgKzIyMDIsOCBAQA0KIAkJCQlkaXNhYmxl
XzgyNTlBX2lycSgwKTsNCiAJCQkJc2V0dXBfbm1pKCk7DQogCQkJCWVuYWJsZV84MjU5QV9pcnEo
MCk7DQotCQkJCWNoZWNrX25taV93YXRjaGRvZygpOw0KKwkJCQlpZiAoY2hlY2tfbm1pX3dhdGNo
ZG9nKCkgPCAwKQ0KKwkJCQkJdGltZXJfYWNrID0gIWNwdV9oYXNfdHNjOw0KIAkJCX0NCiAJCQly
ZXR1cm47DQogCQl9DQpAQCAtMjIxNyw3ICsyMjI2LDggQEANCiAJCQkJYWRkX3Bpbl90b19pcnEo
MCwgMCwgcGluMik7DQogCQkJaWYgKG5taV93YXRjaGRvZyA9PSBOTUlfSU9fQVBJQykgew0KIAkJ
CQlzZXR1cF9ubWkoKTsNCi0JCQkJY2hlY2tfbm1pX3dhdGNoZG9nKCk7DQorCQkJCWlmIChjaGVj
a19ubWlfd2F0Y2hkb2coKSA8IDApDQorCQkJCQl0aW1lcl9hY2sgPSAhY3B1X2hhc190c2M7DQog
CQkJfQ0KIAkJCXJldHVybjsNCiAJCX0NCg==

--=-WTNdWQhGYMCW5MhHW1gS--

--=-udlyPqpcEtwRtyUwm68I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAn3P/7F3Euyc51N8RAqvuAJ46kdyeUrBXnhgkyfgvy4exb79vHwCfe814
rfL53/r20GIbP2wcYN7JXrQ=
=1FbL
-----END PGP SIGNATURE-----

--=-udlyPqpcEtwRtyUwm68I--

