Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVBHOni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVBHOni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBHOni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:43:38 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:38048 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261541AbVBHOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:43:29 -0500
Subject: Re: [PATCH] sys_chroot() hook for additional chroot() jails
	enforcing
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Chris Wright <chrisw@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
In-Reply-To: <20050207143427.B469@build.pdx.osdl.net>
References: <1107814610.3754.260.camel@localhost.localdomain>
	 <20050207143427.B469@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s0auQ+lKUs98ctDdBe0Q"
Date: Tue, 08 Feb 2005 15:42:58 +0100
Message-Id: <1107873778.3754.271.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s0auQ+lKUs98ctDdBe0Q
Content-Type: multipart/mixed; boundary="=-DQhcbBABtNaQr2Gk5r8W"


--=-DQhcbBABtNaQr2Gk5r8W
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 07-02-2005 a las 14:34 -0800, Chris Wright escribi=F3:
> * Lorenzo Hern=E1ndez Garc=EDa-Hierro (lorenzo@gnu.org) wrote:
> > Attached you can find a patch which adds a new hook for the sys_chroot(=
)
> > syscall, and makes us able to add additional enforcing and security
> > checks by using the Linux Security Modules framework (ie. chdir
> > enforcing, etc).
>=20
> If you want to make a change like this, collapse the
> capable(CAP_SYS_CHROOT) check behind this hook, no point having two
> outcalls from same call site.

Right, did it.
New patch attached and also available at:
http://pearls.tuxedo-es.org/patches/sys_chroot_lsm-hook-2.6.11-rc3.patch

>   What logic do you expect to put behind
> the chroot() hook?

For example a chdir() handling function as grsec does, and also any
other check that comes up to mind.

Cheers and again thanks for the comments,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-DQhcbBABtNaQr2Gk5r8W
Content-Disposition: attachment; filename=sys_chroot_lsm-hook-2.6.11-rc3.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=sys_chroot_lsm-hook-2.6.11-rc3.patch;
	charset=iso-8859-1

ZGlmZiAtTnVyIGxpbnV4LTIuNi4xMS1yYzMvZnMvb3Blbi5jIGxpbnV4LTIuNi4xMS1yYzMuY2hy
b290LWxzbS9mcy9vcGVuLmMNCi0tLSBsaW51eC0yLjYuMTEtcmMzL2ZzL29wZW4uYwkyMDA1LTAy
LTA2IDIxOjQwOjQwLjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNi4xMS1yYzMuY2hyb290
LWxzbS9mcy9vcGVuLmMJMjAwNS0wMi0wOCAxNToyOTo0MC41NDQ2MTE5MTIgKzAxMDANCkBAIC01
NzgsOSArNTc4LDkgQEANCiAJZXJyb3IgPSBwZXJtaXNzaW9uKG5kLmRlbnRyeS0+ZF9pbm9kZSxN
QVlfRVhFQywmbmQpOw0KIAlpZiAoZXJyb3IpDQogCQlnb3RvIGRwdXRfYW5kX291dDsNCi0NCi0J
ZXJyb3IgPSAtRVBFUk07DQotCWlmICghY2FwYWJsZShDQVBfU1lTX0NIUk9PVCkpDQorCQkNCisJ
ZXJyb3IgPSBzZWN1cml0eV9jaHJvb3QoJm5kKTsNCisJaWYgKGVycm9yKQ0KIAkJZ290byBkcHV0
X2FuZF9vdXQ7DQogDQogCXNldF9mc19yb290KGN1cnJlbnQtPmZzLCBuZC5tbnQsIG5kLmRlbnRy
eSk7DQpkaWZmIC1OdXIgbGludXgtMi42LjExLXJjMy9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5Lmgg
bGludXgtMi42LjExLXJjMy5jaHJvb3QtbHNtL2luY2x1ZGUvbGludXgvc2VjdXJpdHkuaA0KLS0t
IGxpbnV4LTIuNi4xMS1yYzMvaW5jbHVkZS9saW51eC9zZWN1cml0eS5oCTIwMDUtMDItMDYgMjE6
NDA6MjcuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjExLXJjMy5jaHJvb3QtbHNtL2lu
Y2x1ZGUvbGludXgvc2VjdXJpdHkuaAkyMDA1LTAyLTA4IDE1OjMwOjU0LjQzNDM3ODk2MCArMDEw
MA0KQEAgLTEwMDgsNiArMTAwOCwxMCBAQA0KICAqCUB0cyBjb250YWlucyBuZXcgdGltZQ0KICAq
CUB0eiBjb250YWlucyBuZXcgdGltZXpvbmUNCiAgKglSZXR1cm4gMCBpZiBwZXJtaXNzaW9uIGlz
IGdyYW50ZWQuDQorICogQGNocm9vdDoNCisgKglDaGVjayBwZXJtaXNzaW9uIHRvIGNoYW5nZSB0
aGUgY3VycmVudCByb290IGJ5IHN5c19jaHJvb3QoKSBzeXNjYWxsLg0KKyAqCUBuZCBjb250YWlu
cyB0aGUgbmFtZWlkYXRhIHN0cnVjdCBwYXNzZWQgYnkgc3lzX2Nocm9vdCgpDQorICoJUmV0dXJu
IDAgaWYgcGVybWlzc2lvbiBpcyBncmFudGVkLg0KICAqIEB2bV9lbm91Z2hfbWVtb3J5Og0KICAq
CUNoZWNrIHBlcm1pc3Npb25zIGZvciBhbGxvY2F0aW5nIGEgbmV3IHZpcnR1YWwgbWFwcGluZy4N
CiAgKiAgICAgIEBwYWdlcyBjb250YWlucyB0aGUgbnVtYmVyIG9mIHBhZ2VzLg0KQEAgLTEwNDAs
NiArMTA0NCw3IEBADQogCWludCAoKmFjY3QpIChzdHJ1Y3QgZmlsZSAqIGZpbGUpOw0KIAlpbnQg
KCpzeXNjdGwpIChzdHJ1Y3QgY3RsX3RhYmxlICogdGFibGUsIGludCBvcCk7DQogCWludCAoKmNh
cGFibGUpIChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiB0c2ssIGludCBjYXApOw0KKwlpbnQgKCpjaHJv
b3QpIChzdHJ1Y3QgbmFtZWlkYXRhICogbmQpOw0KIAlpbnQgKCpxdW90YWN0bCkgKGludCBjbWRz
LCBpbnQgdHlwZSwgaW50IGlkLCBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKiBzYik7DQogCWludCAoKnF1
b3RhX29uKSAoc3RydWN0IGRlbnRyeSAqIGRlbnRyeSk7DQogCWludCAoKnN5c2xvZykgKGludCB0
eXBlKTsNCkBAIC0xMzA0LDYgKzEzMDksMTAgQEANCiAJcmV0dXJuIHNlY3VyaXR5X29wcy0+c2V0
dGltZSh0cywgdHopOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludCBzZWN1cml0eV9jaHJvb3Qo
c3RydWN0IG5hbWVpZGF0YSAqbmQpDQorew0KKwlyZXR1cm4gc2VjdXJpdHlfb3BzLT5jaHJvb3Qo
bmQpOw0KK30NCiANCiBzdGF0aWMgaW5saW5lIGludCBzZWN1cml0eV92bV9lbm91Z2hfbWVtb3J5
KGxvbmcgcGFnZXMpDQogew0KQEAgLTE5ODYsNiArMTk5NSwxNCBAQA0KIAlyZXR1cm4gY2FwX3Nl
dHRpbWUodHMsIHR6KTsNCiB9DQogDQorc3RhdGljIGlubGluZSBpbnQgc2VjdXJpdHlfY2hyb290
KHN0cnVjdCBuYW1laWRhdGEgKm5kKQ0KK3sNCisJaWYgKCFjYXBhYmxlKENBUF9TWVNfQ0hST09U
KSkNCisJCXJldHVybiAtRVBFUk07DQorCQ0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGlu
bGluZSBpbnQgc2VjdXJpdHlfdm1fZW5vdWdoX21lbW9yeShsb25nIHBhZ2VzKQ0KIHsNCiAJcmV0
dXJuIGNhcF92bV9lbm91Z2hfbWVtb3J5KHBhZ2VzKTsNCmRpZmYgLU51ciBsaW51eC0yLjYuMTEt
cmMzL3NlY3VyaXR5L2R1bW15LmMgbGludXgtMi42LjExLXJjMy5jaHJvb3QtbHNtL3NlY3VyaXR5
L2R1bW15LmMNCi0tLSBsaW51eC0yLjYuMTEtcmMzL3NlY3VyaXR5L2R1bW15LmMJMjAwNS0wMi0w
NiAyMTo0MDo1Ny4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYuMTEtcmMzLmNocm9vdC1s
c20vc2VjdXJpdHkvZHVtbXkuYwkyMDA1LTAyLTA4IDE1OjI5OjU1LjAzNDQwOTEyOCArMDEwMA0K
QEAgLTEwMSw2ICsxMDEsMTQgQEANCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyBpbnQgZHVt
bXlfY2hyb290KHN0cnVjdCBuYW1laWRhdGEgKm5kKQ0KK3sNCisJaWYgKCFjYXBhYmxlKENBUF9T
WVNfQ0hST09UKSkNCisJCXJldHVybiAtRVBFUk07DQorCQ0KKwlyZXR1cm4gMDsNCit9DQorDQog
c3RhdGljIGludCBkdW1teV9zZXR0aW1lKHN0cnVjdCB0aW1lc3BlYyAqdHMsIHN0cnVjdCB0aW1l
em9uZSAqdHopDQogew0KIAlpZiAoIWNhcGFibGUoQ0FQX1NZU19USU1FKSkNCkBAIC04NTgsNiAr
ODY2LDcgQEANCiAJc2V0X3RvX2R1bW15X2lmX251bGwob3BzLCBzeXNjdGwpOw0KIAlzZXRfdG9f
ZHVtbXlfaWZfbnVsbChvcHMsIHN5c2xvZyk7DQogCXNldF90b19kdW1teV9pZl9udWxsKG9wcywg
c2V0dGltZSk7DQorCXNldF90b19kdW1teV9pZl9udWxsKG9wcywgY2hyb290KTsNCiAJc2V0X3Rv
X2R1bW15X2lmX251bGwob3BzLCB2bV9lbm91Z2hfbWVtb3J5KTsNCiAJc2V0X3RvX2R1bW15X2lm
X251bGwob3BzLCBicHJtX2FsbG9jX3NlY3VyaXR5KTsNCiAJc2V0X3RvX2R1bW15X2lmX251bGwo
b3BzLCBicHJtX2ZyZWVfc2VjdXJpdHkpOw0K


--=-DQhcbBABtNaQr2Gk5r8W--

--=-s0auQ+lKUs98ctDdBe0Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCCM/yDcEopW8rLewRAkewAKCDH+gaAhiTb0NwqsGqD8jNwylOCACghYaw
n6gZ0J9aG3Q89SEzh2wXOy8=
=OZ9c
-----END PGP SIGNATURE-----

--=-s0auQ+lKUs98ctDdBe0Q--

