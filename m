Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVDRTLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVDRTLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDRTLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:11:12 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:30147 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262165AbVDRTKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:10:49 -0400
Subject: [PATCH] TCP ipv4 source port randomization
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UExogpXgkDTMCjxwtGpW"
Date: Mon, 18 Apr 2005 21:04:11 +0200
Message-Id: <1113851051.17341.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UExogpXgkDTMCjxwtGpW
Content-Type: multipart/mixed; boundary="=-N0n9vq1h+wpF0873TjCi"


--=-N0n9vq1h+wpF0873TjCi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

"When source port is generated on the fly for the TCP protocol (ie. with
connect() ) will
be altered so that the source port is generated at random, instead of a sim=
ple
incrementing algorithm."

Ported from grsecurity (http://www.grsecurity.net by Brad Spengler).

Instead of using the PaX & grsecurity-dependent get_random_long() function,=
 we use
the new randomization infrastructure introduced by Arjan van de Ven <arjanv=
@redhat.com>,
providing the helpers get_random_int() and randomize_range().

More information at:
http://people.redhat.com/arjanv/randomize/02-randomize-infrastructure

The patch is also available at:
http://pearls.tuxedo-es.org/patches/security/tcp-rand_src-ports.patch

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-N0n9vq1h+wpF0873TjCi
Content-Disposition: attachment; filename=tcp-rand_src-ports.patch
Content-Type: text/x-patch; name=tcp-rand_src-ports.patch; charset=us-ascii
Content-Transfer-Encoding: base64

DQpXaGVuIHNvdXJjZSBwb3J0IGlzIGdlbmVyYXRlZCBvbiB0aGUgZmx5IGZvciB0aGUgVENQIHBy
b3RvY29sIChpZS4gd2l0aCBjb25uZWN0KCkgKSB3aWxsDQpiZSBhbHRlcmVkIHNvIHRoYXQgdGhl
IHNvdXJjZSBwb3J0IGlzIGdlbmVyYXRlZCBhdCByYW5kb20sIGluc3RlYWQgb2YgYSBzaW1wbGUN
CmluY3JlbWVudGluZyBhbGdvcml0aG0uDQoNClBvcnRlZCBmcm9tIGdyc2VjdXJpdHkgKGh0dHA6
Ly93d3cuZ3JzZWN1cml0eS5uZXQgYnkgQnJhZCBTcGVuZ2xlcikuDQoNCkluc3RlYWQgb2YgdXNp
bmcgdGhlIFBhWCAmIGdyc2VjdXJpdHktZGVwZW5kZW50IGdldF9yYW5kb21fbG9uZygpIGZ1bmN0
aW9uLCB3ZSB1c2UNCnRoZSBuZXcgcmFuZG9taXphdGlvbiBpbmZyYXN0cnVjdHVyZSBpbnRyb2R1
Y2VkIGJ5IEFyamFuIHZhbiBkZSBWZW4gPGFyamFudkByZWRoYXQuY29tPiwNCnByb3ZpZGluZyB0
aGUgaGVscGVycyBnZXRfcmFuZG9tX2ludCgpIGFuZCByYW5kb21pemVfcmFuZ2UoKS4NCg0KTW9y
ZSBpbmZvcm1hdGlvbiBhdDoNCmh0dHA6Ly9wZW9wbGUucmVkaGF0LmNvbS9hcmphbnYvcmFuZG9t
aXplLzAyLXJhbmRvbWl6ZS1pbmZyYXN0cnVjdHVyZQ0KDQpTaWduZWQtb2ZmLWJ5OiBMb3Jlbnpv
IEhlcm5hbmRleiBHYXJjaWEtSGllcnJvIDxsb3JlbnpvQGdudS5vcmc+DQotLS0NCg0KIGxpbnV4
LTIuNi4xMS1sb3JlbnpvL25ldC9pcHY0L3RjcF9pcHY0LmMgfCAgICA1ICsrKysrDQogMSBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtcHVOIG5ldC9pcHY0L3RjcF9pcHY0
LmN+dGNwLXJhbmRfc3JjLXBvcnRzIG5ldC9pcHY0L3RjcF9pcHY0LmMNCi0tLSBsaW51eC0yLjYu
MTEvbmV0L2lwdjQvdGNwX2lwdjQuY350Y3AtcmFuZF9zcmMtcG9ydHMJMjAwNS0wNC0xNyAxNzoz
MToyNy4yMzM0MzgyMDggKzAyMDANCisrKyBsaW51eC0yLjYuMTEtbG9yZW56by9uZXQvaXB2NC90
Y3BfaXB2NC5jCTIwMDUtMDQtMTcgMTc6Mzc6MDMuNTI4MzEzNjE2ICswMjAwDQpAQCAtMjI0LDYg
KzIyNCw5IEBAIHN0YXRpYyBpbnQgdGNwX3Y0X2dldF9wb3J0KHN0cnVjdCBzb2NrICoNCiAJCXNw
aW5fbG9jaygmdGNwX3BvcnRhbGxvY19sb2NrKTsNCiAJCXJvdmVyID0gdGNwX3BvcnRfcm92ZXI7
DQogDQorCQlpZiAoaGlnaCA+IGxvdykNCisJCQlyb3ZlciA9IGxvdyArIChnZXRfcmFuZG9tX2lu
dCgpICUgcmVtYWluaW5nKTsNCisNCiAJCWRvIHsNCiAJCQlyb3ZlcisrOw0KIAkJCWlmIChyb3Zl
ciA8IGxvdyB8fCByb3ZlciA+IGhpZ2gpDQpAQCAtNjY2LDYgKzY2OSw4IEBAIHN0YXRpYyBpbmxp
bmUgaW50IHRjcF92NF9oYXNoX2Nvbm5lY3Qoc3QNCiAJCXN0cnVjdCBobGlzdF9ub2RlICpub2Rl
Ow0KICAJCXN0cnVjdCB0Y3BfdHdfYnVja2V0ICp0dyA9IE5VTEw7DQogDQorIAkJb2Zmc2V0ID0g
Z2V0X3JhbmRvbV9pbnQoKTsNCisNCiAgCQlsb2NhbF9iaF9kaXNhYmxlKCk7DQogCQlmb3IgKGkg
PSAxOyBpIDw9IHJhbmdlOyBpKyspIHsNCiAJCQlwb3J0ID0gbG93ICsgKGkgKyBvZmZzZXQpICUg
cmFuZ2U7DQpfDQo=


--=-N0n9vq1h+wpF0873TjCi--

--=-UExogpXgkDTMCjxwtGpW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZASrDcEopW8rLewRAoH0AJ4z4KbGGbm/zMUv71WC89QA4QITwwCdFbnp
vSpVsfc7jWWG1Lao8VzCusk=
=mgZg
-----END PGP SIGNATURE-----

--=-UExogpXgkDTMCjxwtGpW--

