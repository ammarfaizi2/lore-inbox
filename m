Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVBGWRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVBGWRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVBGWRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:17:34 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:23479 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261227AbVBGWRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:17:16 -0500
Subject: [PATCH] sys_chroot() hook for additional chroot() jails enforcing
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-adkm2rkVMfVdsy50OTcQ"
Date: Mon, 07 Feb 2005 23:16:50 +0100
Message-Id: <1107814610.3754.260.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-adkm2rkVMfVdsy50OTcQ
Content-Type: multipart/mixed; boundary="=-37UDQVEvQZ+UYrf9ShmE"


--=-37UDQVEvQZ+UYrf9ShmE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Attached you can find a patch which adds a new hook for the sys_chroot()
syscall, and makes us able to add additional enforcing and security
checks by using the Linux Security Modules framework (ie. chdir
enforcing, etc).

Current user of the hook is the forthcoming 0.2 revision of vSecurity.

With it, and used within an LSM module, we can achieve the goal of
enforcing and apply some hardening to the sys_chroot() syscall.
Even if chroot jails are broken by design, in terms of security, with a
few changes to their base and some syscalls that it relies with, we can
achieve the goal of preventing some of the already known attacks against
them.

I will make available some patches for other syscalls as well
(sys_fchmod(), sys_chmod(), ...), that will add a few more hooks to the
LSM framework, in the hope that they will be useful.

The patch can be retrieved too from:
http://pearls.tuxedo-es.org/patches/sys_chroot_lsm-hook-2.6.11-rc3.patch

Thanks in advance, and, again, I will appreciate any suggestions on
which hooks are good candidates to be added.
Feel free to edit tuxedo-es.org wiki at http://wiki.tuxedo-es.org/LSM
and put suggestions & comments there.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-37UDQVEvQZ+UYrf9ShmE
Content-Disposition: attachment; filename=sys_chroot_lsm-hook-2.6.11-rc3.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=sys_chroot_lsm-hook-2.6.11-rc3.patch;
	charset=ISO-8859-1

ZGlmZiAtTnVyIGxpbnV4LTIuNi4xMS1yYzMvZnMvb3Blbi5jIGxpbnV4LTIuNi4xMS1yYzMuY2hy
b290LWxzbS9mcy9vcGVuLmMNCi0tLSBsaW51eC0yLjYuMTEtcmMzL2ZzL29wZW4uYwkyMDA1LTAy
LTA2IDIxOjQwOjQwLjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNi4xMS1yYzMuY2hyb290
LWxzbS9mcy9vcGVuLmMJMjAwNS0wMi0wNyAyMTo0Mjo0NS4wMDAwMDAwMDAgKzAxMDANCkBAIC01
ODIsNiArNTgyLDEwIEBADQogCWVycm9yID0gLUVQRVJNOw0KIAlpZiAoIWNhcGFibGUoQ0FQX1NZ
U19DSFJPT1QpKQ0KIAkJZ290byBkcHV0X2FuZF9vdXQ7DQorCQkNCisJZXJyb3IgPSBzZWN1cml0
eV9jaHJvb3QoJm5kKTsNCisJaWYgKGVycm9yKQ0KKwkJZ290byBkcHV0X2FuZF9vdXQ7DQogDQog
CXNldF9mc19yb290KGN1cnJlbnQtPmZzLCBuZC5tbnQsIG5kLmRlbnRyeSk7DQogCXNldF9mc19h
bHRyb290KCk7DQpkaWZmIC1OdXIgbGludXgtMi42LjExLXJjMy9pbmNsdWRlL2xpbnV4L3NlY3Vy
aXR5LmggbGludXgtMi42LjExLXJjMy5jaHJvb3QtbHNtL2luY2x1ZGUvbGludXgvc2VjdXJpdHku
aA0KLS0tIGxpbnV4LTIuNi4xMS1yYzMvaW5jbHVkZS9saW51eC9zZWN1cml0eS5oCTIwMDUtMDIt
MDYgMjE6NDA6MjcuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjExLXJjMy5jaHJvb3Qt
bHNtL2luY2x1ZGUvbGludXgvc2VjdXJpdHkuaAkyMDA1LTAyLTA3IDIxOjEwOjA1LjAwMDAwMDAw
MCArMDEwMA0KQEAgLTEwMDgsNiArMTAwOCwxMCBAQA0KICAqCUB0cyBjb250YWlucyBuZXcgdGlt
ZQ0KICAqCUB0eiBjb250YWlucyBuZXcgdGltZXpvbmUNCiAgKglSZXR1cm4gMCBpZiBwZXJtaXNz
aW9uIGlzIGdyYW50ZWQuDQorICogQGNocm9vdDoNCisgKglDaGVjayBwZXJtaXNzaW9uIHRvIGNo
YW5nZSB0aGUgY3VycmVudCByb290IGJ5IHN5c19jaHJvb3QoKSBzeXNjYWxsLg0KKyAqCUBuZCBj
b250YWlucyB0aGUgbmFtZWlkYXRhIHN0cnVjdCBwYXNzZWQgYnkgc3lzX2Nocm9vdCgpDQorICoJ
UmV0dXJuIDAgaWYgcGVybWlzc2lvbiBpcyBncmFudGVkLg0KICAqIEB2bV9lbm91Z2hfbWVtb3J5
Og0KICAqCUNoZWNrIHBlcm1pc3Npb25zIGZvciBhbGxvY2F0aW5nIGEgbmV3IHZpcnR1YWwgbWFw
cGluZy4NCiAgKiAgICAgIEBwYWdlcyBjb250YWlucyB0aGUgbnVtYmVyIG9mIHBhZ2VzLg0KQEAg
LTEwNDAsNiArMTA0NCw3IEBADQogCWludCAoKmFjY3QpIChzdHJ1Y3QgZmlsZSAqIGZpbGUpOw0K
IAlpbnQgKCpzeXNjdGwpIChzdHJ1Y3QgY3RsX3RhYmxlICogdGFibGUsIGludCBvcCk7DQogCWlu
dCAoKmNhcGFibGUpIChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiB0c2ssIGludCBjYXApOw0KKwlpbnQg
KCpjaHJvb3QpIChzdHJ1Y3QgbmFtZWlkYXRhICogbmQpOw0KIAlpbnQgKCpxdW90YWN0bCkgKGlu
dCBjbWRzLCBpbnQgdHlwZSwgaW50IGlkLCBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKiBzYik7DQogCWlu
dCAoKnF1b3RhX29uKSAoc3RydWN0IGRlbnRyeSAqIGRlbnRyeSk7DQogCWludCAoKnN5c2xvZykg
KGludCB0eXBlKTsNCkBAIC0xMzA0LDYgKzEzMDksMTAgQEANCiAJcmV0dXJuIHNlY3VyaXR5X29w
cy0+c2V0dGltZSh0cywgdHopOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludCBzZWN1cml0eV9j
aHJvb3Qoc3RydWN0IG5hbWVpZGF0YSAqbmQpDQorew0KKwlyZXR1cm4gc2VjdXJpdHlfb3BzLT5j
aHJvb3QobmQpOw0KK30NCiANCiBzdGF0aWMgaW5saW5lIGludCBzZWN1cml0eV92bV9lbm91Z2hf
bWVtb3J5KGxvbmcgcGFnZXMpDQogew0KQEAgLTE5ODYsNiArMTk5NSwxMSBAQA0KIAlyZXR1cm4g
Y2FwX3NldHRpbWUodHMsIHR6KTsNCiB9DQogDQorc3RhdGljIGlubGluZSBpbnQgc2VjdXJpdHlf
Y2hyb290KHN0cnVjdCBuYW1laWRhdGEgKm5kKQ0KK3sNCisJcmV0dXJuIDA7DQorfQ0KKw0KIHN0
YXRpYyBpbmxpbmUgaW50IHNlY3VyaXR5X3ZtX2Vub3VnaF9tZW1vcnkobG9uZyBwYWdlcykNCiB7
DQogCXJldHVybiBjYXBfdm1fZW5vdWdoX21lbW9yeShwYWdlcyk7DQpkaWZmIC1OdXIgbGludXgt
Mi42LjExLXJjMy9zZWN1cml0eS9kdW1teS5jIGxpbnV4LTIuNi4xMS1yYzMuY2hyb290LWxzbS9z
ZWN1cml0eS9kdW1teS5jDQotLS0gbGludXgtMi42LjExLXJjMy9zZWN1cml0eS9kdW1teS5jCTIw
MDUtMDItMDYgMjE6NDA6NTcuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjExLXJjMy5j
aHJvb3QtbHNtL3NlY3VyaXR5L2R1bW15LmMJMjAwNS0wMi0wNyAyMToxMjowMS4wMDAwMDAwMDAg
KzAxMDANCkBAIC0xMDEsNiArMTAxLDExIEBADQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0aWMg
aW50IGR1bW15X2Nocm9vdChzdHJ1Y3QgbmFtZWlkYXRhICpuZCkNCit7DQorCXJldHVybiAwOw0K
K30NCisNCiBzdGF0aWMgaW50IGR1bW15X3NldHRpbWUoc3RydWN0IHRpbWVzcGVjICp0cywgc3Ry
dWN0IHRpbWV6b25lICp0eikNCiB7DQogCWlmICghY2FwYWJsZShDQVBfU1lTX1RJTUUpKQ0KQEAg
LTg1OCw2ICs4NjMsNyBAQA0KIAlzZXRfdG9fZHVtbXlfaWZfbnVsbChvcHMsIHN5c2N0bCk7DQog
CXNldF90b19kdW1teV9pZl9udWxsKG9wcywgc3lzbG9nKTsNCiAJc2V0X3RvX2R1bW15X2lmX251
bGwob3BzLCBzZXR0aW1lKTsNCisJc2V0X3RvX2R1bW15X2lmX251bGwob3BzLCBjaHJvb3QpOw0K
IAlzZXRfdG9fZHVtbXlfaWZfbnVsbChvcHMsIHZtX2Vub3VnaF9tZW1vcnkpOw0KIAlzZXRfdG9f
ZHVtbXlfaWZfbnVsbChvcHMsIGJwcm1fYWxsb2Nfc2VjdXJpdHkpOw0KIAlzZXRfdG9fZHVtbXlf
aWZfbnVsbChvcHMsIGJwcm1fZnJlZV9zZWN1cml0eSk7DQo=


--=-37UDQVEvQZ+UYrf9ShmE--

--=-adkm2rkVMfVdsy50OTcQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB+jSDcEopW8rLewRAvAfAJ0WemgK9MMEEpIPP3JDftEotQfTvgCeJjLE
m07Wf+U/nw4jwf1iMKiPdm0=
=gBSw
-----END PGP SIGNATURE-----

--=-adkm2rkVMfVdsy50OTcQ--

