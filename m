Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVBHQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVBHQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVBHQQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:16:00 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:49099 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261573AbVBHQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:15:03 -0500
Subject: [PATCH] New sys_chmod() hook for the LSM framework
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+YdP7z6PBrYZghRwHwKV"
Date: Tue, 08 Feb 2005 17:14:35 +0100
Message-Id: <1107879275.3754.279.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+YdP7z6PBrYZghRwHwKV
Content-Type: multipart/mixed; boundary="=-oFF48iPDxCwcLZTBfb3U"


--=-oFF48iPDxCwcLZTBfb3U
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

As commented yesterday, I was going to release a few more hooks for some
*critical* syscalls, this one adds a hook to sys_chmod(), and makes us
able to apply checks and logics before releasing the operation to
sys_chmod().

The main goal is to provide a simple way to handle chmod() calls and
apply security restrictions & checks to them, and also add add auditing
capabilities (ie.: log chmod() calls in chroot()'ed environments, etc).

Patch attached and available at:
http://pearls.tuxedo-es.org/patches/sys_chmod_lsm-hook-2.6.11-rc3.patch

I would like to see this merged, Chris should decide :)

An user of this will be, as commented in my past emails, vSecurity 0.2
release, and any other LSM module that wants to have control over
chmod()'ing.

I will make available another hook for sys_fchmod() ASAP.

Cheers and thanks in advance,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-oFF48iPDxCwcLZTBfb3U
Content-Disposition: attachment; filename=sys_chmod_lsm-hook-2.6.11-rc3.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=sys_chmod_lsm-hook-2.6.11-rc3.patch;
	charset=ISO-8859-1

ZGlmZiAtTnVyIGxpbnV4LTIuNi4xMS1yYzMvZnMvb3Blbi5jIGxpbnV4LTIuNi4xMS1yYzMuY2ht
L2ZzL29wZW4uYw0KLS0tIGxpbnV4LTIuNi4xMS1yYzMvZnMvb3Blbi5jCTIwMDUtMDItMDYgMjE6
NDA6NDAuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjExLXJjMy5jaG0vZnMvb3Blbi5j
CTIwMDUtMDItMDggMTY6MTA6MDkuOTAxMjkzNTYwICswMTAwDQpAQCAtNjUwLDYgKzY1MCwxMSBA
QA0KIAlkb3duKCZpbm9kZS0+aV9zZW0pOw0KIAlpZiAobW9kZSA9PSAobW9kZV90KSAtMSkNCiAJ
CW1vZGUgPSBpbm9kZS0+aV9tb2RlOw0KKwkJDQorCWVycm9yID0gc2VjdXJpdHlfY2htb2QoJm5k
LCBpbm9kZSwgbW9kZSk7DQorCWlmIChlcnJvcikNCisJCWdvdG8gZHB1dF9hbmRfb3V0OwkNCisJ
DQogCW5ld2F0dHJzLmlhX21vZGUgPSAobW9kZSAmIFNfSUFMTFVHTykgfCAoaW5vZGUtPmlfbW9k
ZSAmIH5TX0lBTExVR08pOw0KIAluZXdhdHRycy5pYV92YWxpZCA9IEFUVFJfTU9ERSB8IEFUVFJf
Q1RJTUU7DQogCWVycm9yID0gbm90aWZ5X2NoYW5nZShuZC5kZW50cnksICZuZXdhdHRycyk7DQpk
aWZmIC1OdXIgbGludXgtMi42LjExLXJjMy9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5LmggbGludXgt
Mi42LjExLXJjMy5jaG0vaW5jbHVkZS9saW51eC9zZWN1cml0eS5oDQotLS0gbGludXgtMi42LjEx
LXJjMy9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5LmgJMjAwNS0wMi0wNiAyMTo0MDoyNy4wMDAwMDAw
MDAgKzAxMDANCisrKyBsaW51eC0yLjYuMTEtcmMzLmNobS9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5
LmgJMjAwNS0wMi0wOCAxNjoxMDozNy42NzAwNzIwNjQgKzAxMDANCkBAIC0xMDA4LDYgKzEwMDgs
MTIgQEANCiAgKglAdHMgY29udGFpbnMgbmV3IHRpbWUNCiAgKglAdHogY29udGFpbnMgbmV3IHRp
bWV6b25lDQogICoJUmV0dXJuIDAgaWYgcGVybWlzc2lvbiBpcyBncmFudGVkLg0KKyAqIEBjaG1v
ZDoNCisgKglDaGVjayBwZXJtaXNzaW9uIGJlZm9yZSBjaGFuZ2luZyBmaWxlIG1vZGVzIGJ5IHN5
c19jaG1vZCgpLg0KKyAqCUBuZCBjb250YWlucyB0aGUgbmFtZWlkYXRhIHN0cnVjdC4NCisgKglA
aW5vZGUgY29udGFpbnMgdGhlIGlub2RlIHN0cnVjdC4NCisgKglAbW9kZSBjb250YWlucyB0aGUg
bW9kZSB2YWx1ZS4NCisgKglSZXR1cm4gMCBpZiBwZXJtaXNzaW9uIGlzIGdyYW50ZWQuDQogICog
QHZtX2Vub3VnaF9tZW1vcnk6DQogICoJQ2hlY2sgcGVybWlzc2lvbnMgZm9yIGFsbG9jYXRpbmcg
YSBuZXcgdmlydHVhbCBtYXBwaW5nLg0KICAqICAgICAgQHBhZ2VzIGNvbnRhaW5zIHRoZSBudW1i
ZXIgb2YgcGFnZXMuDQpAQCAtMTA0NCw2ICsxMDUwLDcgQEANCiAJaW50ICgqcXVvdGFfb24pIChz
dHJ1Y3QgZGVudHJ5ICogZGVudHJ5KTsNCiAJaW50ICgqc3lzbG9nKSAoaW50IHR5cGUpOw0KIAlp
bnQgKCpzZXR0aW1lKSAoc3RydWN0IHRpbWVzcGVjICp0cywgc3RydWN0IHRpbWV6b25lICp0eik7
DQorCWludCAoKmNobW9kKSAoc3RydWN0IG5hbWVpZGF0YSAqbmQsIHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIG1vZGVfdCBtb2RlKTsNCiAJaW50ICgqdm1fZW5vdWdoX21lbW9yeSkgKGxvbmcgcGFnZXMp
Ow0KIA0KIAlpbnQgKCpicHJtX2FsbG9jX3NlY3VyaXR5KSAoc3RydWN0IGxpbnV4X2JpbnBybSAq
IGJwcm0pOw0KQEAgLTEzMDQsNiArMTMxMSwxMCBAQA0KIAlyZXR1cm4gc2VjdXJpdHlfb3BzLT5z
ZXR0aW1lKHRzLCB0eik7DQogfQ0KIA0KK3N0YXRpYyBpbmxpbmUgaW50IHNlY3VyaXR5X2NobW9k
KHN0cnVjdCBuYW1laWRhdGEgKm5kLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLCBtb2RlX3QgbW9kZSkN
Cit7DQorCXJldHVybiBzZWN1cml0eV9vcHMtPmNobW9kKG5kLCBpbm9kZSwgbW9kZSk7DQorfQ0K
IA0KIHN0YXRpYyBpbmxpbmUgaW50IHNlY3VyaXR5X3ZtX2Vub3VnaF9tZW1vcnkobG9uZyBwYWdl
cykNCiB7DQpAQCAtMTk4Niw2ICsxOTk3LDExIEBADQogCXJldHVybiBjYXBfc2V0dGltZSh0cywg
dHopOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludCBzZWN1cml0eV9jaG1vZChzdHJ1Y3QgbmFt
ZWlkYXRhICpuZCwgc3RydWN0IGlub2RlICppbm9kZSwgbW9kZV90IG1vZGUpDQorew0KKwlyZXR1
cm4gMDsNCit9DQorDQogc3RhdGljIGlubGluZSBpbnQgc2VjdXJpdHlfdm1fZW5vdWdoX21lbW9y
eShsb25nIHBhZ2VzKQ0KIHsNCiAJcmV0dXJuIGNhcF92bV9lbm91Z2hfbWVtb3J5KHBhZ2VzKTsN
CmRpZmYgLU51ciBsaW51eC0yLjYuMTEtcmMzL3NlY3VyaXR5L2R1bW15LmMgbGludXgtMi42LjEx
LXJjMy5jaG0vc2VjdXJpdHkvZHVtbXkuYw0KLS0tIGxpbnV4LTIuNi4xMS1yYzMvc2VjdXJpdHkv
ZHVtbXkuYwkyMDA1LTAyLTA2IDIxOjQwOjU3LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIu
Ni4xMS1yYzMuY2htL3NlY3VyaXR5L2R1bW15LmMJMjAwNS0wMi0wOCAxNTo1ODoyNi4wMDAwMDAw
MDAgKzAxMDANCkBAIC0xMDgsNiArMTA4LDExIEBADQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0
aWMgaW50IGR1bW15X2NobW9kKHN0cnVjdCBuYW1laWRhdGEgKm5kLCBzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBtb2RlX3QgbW9kZSkNCit7DQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgaW50IGR1
bW15X3ZtX2Vub3VnaF9tZW1vcnkobG9uZyBwYWdlcykNCiB7DQogCWludCBjYXBfc3lzX2FkbWlu
ID0gMDsNCkBAIC04NTgsNiArODYzLDcgQEANCiAJc2V0X3RvX2R1bW15X2lmX251bGwob3BzLCBz
eXNjdGwpOw0KIAlzZXRfdG9fZHVtbXlfaWZfbnVsbChvcHMsIHN5c2xvZyk7DQogCXNldF90b19k
dW1teV9pZl9udWxsKG9wcywgc2V0dGltZSk7DQorCXNldF90b19kdW1teV9pZl9udWxsKG9wcywg
Y2htb2QpOw0KIAlzZXRfdG9fZHVtbXlfaWZfbnVsbChvcHMsIHZtX2Vub3VnaF9tZW1vcnkpOw0K
IAlzZXRfdG9fZHVtbXlfaWZfbnVsbChvcHMsIGJwcm1fYWxsb2Nfc2VjdXJpdHkpOw0KIAlzZXRf
dG9fZHVtbXlfaWZfbnVsbChvcHMsIGJwcm1fZnJlZV9zZWN1cml0eSk7DQo=


--=-oFF48iPDxCwcLZTBfb3U--

--=-+YdP7z6PBrYZghRwHwKV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCCOVrDcEopW8rLewRArzwAKDiHiuVAgGBP1XZ/xgZxmq9w076QgCg4bQO
TKRvzkwpJdcYqG4xIJVNECw=
=5e2Q
-----END PGP SIGNATURE-----

--=-+YdP7z6PBrYZghRwHwKV--

