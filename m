Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUATTk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUATTk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:40:28 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:64392 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S265765AbUATTkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:40:13 -0500
Subject: [PATCH][2.4] Miniscule block and kstat optimisation
From: Alan Swanson <swanson@ukfsn.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dBuOEwBaBEDFNJccKssW"
Message-Id: <1074627841.31306.18.camel@zeus.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 19:44:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dBuOEwBaBEDFNJccKssW
Content-Type: multipart/mixed; boundary="=-Y36PQ+hjdLz5eZeGcUSz"


--=-Y36PQ+hjdLz5eZeGcUSz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Involving a (very) tiny speed-up in ll_rw_blk, by shifting the
calculation to proc, and saving memory from a now unused array.

It's basically a very small subset of my diskio patch for /proc/stat in
the 2.4 kernel.

Can someone pass this to Marcelo as there are no real maintainers for
the files touched. I've tried submitting directly but without response.

--=20
Alan.

"One must never be purposelessnessnesslessness."

--=-Y36PQ+hjdLz5eZeGcUSz
Content-Disposition: attachment; filename=kstat.diff
Content-Type: text/x-patch; name=kstat.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXIgbGludXgtMi40LjIzLXByZTMvZHJpdmVycy9ibG9jay9sbF9yd19ibGsuYyBsaW51
eC0yLjQuMjMtcHJlMy1rc3RhdC9kcml2ZXJzL2Jsb2NrL2xsX3J3X2Jsay5jDQotLS0gbGludXgt
Mi40LjIzLXByZTMvZHJpdmVycy9ibG9jay9sbF9yd19ibGsuYwkyMDAzLTExLTI4IDIxOjI3OjI1
LjAwMDAwMDAwMCArMDAwMA0KKysrIGxpbnV4LTIuNC4yMy1wcmUzLWtzdGF0L2RyaXZlcnMvYmxv
Y2svbGxfcndfYmxrLmMJMjAwMy0xMi0zMSAxNTo1Mjo0OC4wMDAwMDAwMDAgKzAwMDANCkBAIC03
MDEsNyArNzAxLDYgQEANCiAJaWYgKChpbmRleCA+PSBES19NQVhfRElTSykgfHwgKG1ham9yID49
IERLX01BWF9NQUpPUikpDQogCQlyZXR1cm47DQogDQotCWtzdGF0LmRrX2RyaXZlW21ham9yXVtp
bmRleF0gKz0gbmV3X2lvOw0KIAlpZiAocncgPT0gUkVBRCkgew0KIAkJa3N0YXQuZGtfZHJpdmVf
cmlvW21ham9yXVtpbmRleF0gKz0gbmV3X2lvOw0KIAkJa3N0YXQuZGtfZHJpdmVfcmJsa1ttYWpv
cl1baW5kZXhdICs9IG5yX3NlY3RvcnM7DQpkaWZmIC11ciBsaW51eC0yLjQuMjMtcHJlMy9mcy9w
cm9jL3Byb2NfbWlzYy5jIGxpbnV4LTIuNC4yMy1wcmUzLWtzdGF0L2ZzL3Byb2MvcHJvY19taXNj
LmMNCi0tLSBsaW51eC0yLjQuMjMtcHJlMy9mcy9wcm9jL3Byb2NfbWlzYy5jCTIwMDMtMTEtMjgg
MjE6Mjc6MjguMDAwMDAwMDAwICswMDAwDQorKysgbGludXgtMi40LjIzLXByZTMta3N0YXQvZnMv
cHJvYy9wcm9jX21pc2MuYwkyMDAzLTEyLTMxIDE1OjUyOjQ4LjAwMDAwMDAwMCArMDAwMA0KQEAg
LTM1NywxNCArMzU3LDE2IEBADQogDQogCWZvciAobWFqb3IgPSAwOyBtYWpvciA8IERLX01BWF9N
QUpPUjsgbWFqb3IrKykgew0KIAkJZm9yIChkaXNrID0gMDsgZGlzayA8IERLX01BWF9ESVNLOyBk
aXNrKyspIHsNCi0JCQlpbnQgYWN0aXZlID0ga3N0YXQuZGtfZHJpdmVbbWFqb3JdW2Rpc2tdICsN
CisJCQlpbnQgYWN0aXZlID0ga3N0YXQuZGtfZHJpdmVfcmlvW21ham9yXVtkaXNrXSArDQorCQkJ
CWtzdGF0LmRrX2RyaXZlX3dpb1ttYWpvcl1bZGlza10gKw0KIAkJCQlrc3RhdC5ka19kcml2ZV9y
YmxrW21ham9yXVtkaXNrXSArDQogCQkJCWtzdGF0LmRrX2RyaXZlX3dibGtbbWFqb3JdW2Rpc2td
Ow0KIAkJCWlmIChhY3RpdmUpDQogCQkJCXByb2Nfc3ByaW50ZihwYWdlLCAmb2ZmLCAmbGVuLA0K
IAkJCQkJIigldSwldSk6KCV1LCV1LCV1LCV1LCV1KSAiLA0KIAkJCQkJbWFqb3IsIGRpc2ssDQot
CQkJCQlrc3RhdC5ka19kcml2ZVttYWpvcl1bZGlza10sDQorCQkJCQlrc3RhdC5ka19kcml2ZV9y
aW9bbWFqb3JdW2Rpc2tdICsNCisJCQkJCWtzdGF0LmRrX2RyaXZlX3dpb1ttYWpvcl1bZGlza10s
DQogCQkJCQlrc3RhdC5ka19kcml2ZV9yaW9bbWFqb3JdW2Rpc2tdLA0KIAkJCQkJa3N0YXQuZGtf
ZHJpdmVfcmJsa1ttYWpvcl1bZGlza10sDQogCQkJCQlrc3RhdC5ka19kcml2ZV93aW9bbWFqb3Jd
W2Rpc2tdLA0KZGlmZiAtdXIgbGludXgtMi40LjIzLXByZTMvaW5jbHVkZS9saW51eC9rZXJuZWxf
c3RhdC5oIGxpbnV4LTIuNC4yMy1wcmUzLWtzdGF0L2luY2x1ZGUvbGludXgva2VybmVsX3N0YXQu
aA0KLS0tIGxpbnV4LTIuNC4yMy1wcmUzL2luY2x1ZGUvbGludXgva2VybmVsX3N0YXQuaAkyMDAz
LTA2LTEzIDIyOjE1OjEzLjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNC4yMy1wcmUzLWtz
dGF0L2luY2x1ZGUvbGludXgva2VybmVsX3N0YXQuaAkyMDAzLTEyLTMxIDE1OjUyOjQ4LjAwMDAw
MDAwMCArMDAwMA0KQEAgLTE5LDcgKzE5LDYgQEANCiAJdW5zaWduZWQgaW50IHBlcl9jcHVfdXNl
cltOUl9DUFVTXSwNCiAJICAgICAgICAgICAgIHBlcl9jcHVfbmljZVtOUl9DUFVTXSwNCiAJICAg
ICAgICAgICAgIHBlcl9jcHVfc3lzdGVtW05SX0NQVVNdOw0KLQl1bnNpZ25lZCBpbnQgZGtfZHJp
dmVbREtfTUFYX01BSk9SXVtES19NQVhfRElTS107DQogCXVuc2lnbmVkIGludCBka19kcml2ZV9y
aW9bREtfTUFYX01BSk9SXVtES19NQVhfRElTS107DQogCXVuc2lnbmVkIGludCBka19kcml2ZV93
aW9bREtfTUFYX01BSk9SXVtES19NQVhfRElTS107DQogCXVuc2lnbmVkIGludCBka19kcml2ZV9y
YmxrW0RLX01BWF9NQUpPUl1bREtfTUFYX0RJU0tdOw0K

--=-Y36PQ+hjdLz5eZeGcUSz--

--=-dBuOEwBaBEDFNJccKssW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBADYUBagoW53DrKMIRAsELAJ9f0W1GY0JPLsag1PHYYee+na5VJQCfR+6U
0c55ukPlp5a6iOAhMNUKeYE=
=oK9e
-----END PGP SIGNATURE-----

--=-dBuOEwBaBEDFNJccKssW--
