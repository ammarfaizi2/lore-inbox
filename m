Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWJHNlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWJHNlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWJHNlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:41:49 -0400
Received: from hentges.net ([81.169.178.128]:44972 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1751152AbWJHNls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:41:48 -0400
Subject: Re: sky2 (was Re: 2.6.18-mm2)
From: Matthias Hentges <oe@hentges.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
In-Reply-To: <1160250529.4575.7.camel@mhcln03>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	 <451C5599.80402@garzik.org> <20060928161956.5262e5d3@freekitty>
	 <1159930628.16765.9.camel@mhcln03>
	 <20061003202643.0e0ceab2@localhost.localdomain>
	 <1160250529.4575.7.camel@mhcln03>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4FPqPrOf/PZbCF96FVDp"
Date: Sun, 08 Oct 2006 15:41:45 +0200
Message-Id: <1160314905.4575.21.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4FPqPrOf/PZbCF96FVDp
Content-Type: multipart/mixed; boundary="=-PTavlHUZzryen5Gvt8cH"


--=-PTavlHUZzryen5Gvt8cH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

I believe I have identified the problem. The freeze only happens when
your debug patch to work around sky2 PCIe error messages is applied.
Without your patch (attached) I get _tons_ of error messages and the NIC
dies every few seconds / minutes (reproduceable!), but the system
recovers just fine from a NIC crash.

I have verified this behavior (works fine w/o debug patch, freezes with
patch applied) with:
- 2.6.19-rc1-git4=20
- 2.6.18-git something=20
- 2.6.18-mm3
 =20
--=20
Matthias 'CoreDump' Hentges=20

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-PTavlHUZzryen5Gvt8cH
Content-Disposition: attachment; filename=sky2-pcie.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=sky2-pcie.patch; charset=ISO-8859-15

LS0tIHNreTIuYy5vcmlnCTIwMDYtMDktMzAgMDE6NTA6MzUuMDAwMDAwMDAwICswMjAwDQorKysg
c2t5Mi5jCTIwMDYtMDktMzAgMDE6NTA6MzguMDAwMDAwMDAwICswMjAwDQpAQCAtMjQ2Myw2ICsy
NDYzLDcgQEANCiANCiAJc2t5Ml93cml0ZTgoaHcsIEIwX0NUU1QsIENTX01SU1RfQ0xSKTsNCiAN
CisjZGVmaW5lIFBFWF9VTkNfRVJSX1NUQVQgMHgxMDQgICAgICAgICAvKiBQQ0kgZXh0ZW5kZWQg
ZXJyb3IgY2FwYWJsaXR5ICovDQogCS8qIGNsZWFyIGFueSBQRVggZXJyb3JzICovDQogCWlmIChw
Y2lfZmluZF9jYXBhYmlsaXR5KGh3LT5wZGV2LCBQQ0lfQ0FQX0lEX0VYUCkpIHsNCiAJCWh3LT5l
cnJfY2FwID0gcGNpX2ZpbmRfZXh0X2NhcGFiaWxpdHkoaHctPnBkZXYsIFBDSV9FWFRfQ0FQX0lE
X0VSUik7DQpAQCAtMjQ3MCw2ICsyNDcxLDE2IEBADQogCQkJc2t5Ml9wY2lfd3JpdGUzMihodywN
CiAJCQkJCSBody0+ZXJyX2NhcCArIFBDSV9FUlJfVU5DT1JfU1RBVFVTLA0KIAkJCQkJIDB4ZmZm
ZmZmZmZVTCk7DQorICAgICAgICAgICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgICAgICAgICAg
cHJpbnRrKEtFUk5fRVJSIFBGWCAicGNpIGV4cHJlc3MgZm91bmQgYnV0IG5vdCBleHRlbmRlZCBl
cnJvciBzdXBwb3J0P1xuIik7DQorICAgICAgICAgICAgICAgDQorICAgICAgICAgICAgICAgaWYg
KGh3LT5lcnJfY2FwICsgUENJX0VSUl9VTkNPUl9TVEFUVVMgIT0gUEVYX1VOQ19FUlJfU1RBVCkg
ew0KKyAgICAgICAgICAgICAgICAgICAgICAgDQorICAgICAgICAgICAgICAgICAgICAgICBwcmlu
dGsoS0VSTl9FUlIgUEZYICJwY2kgZXhwcmVzcyBlcnJvciBzdGF0dXMgcmVnaXN0ZXIgZml4ZWQg
ZnJvbSAlI3ggdG8gJSN4XG4iLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3LT5l
cnJfY2FwLCBQRVhfVU5DX0VSUl9TVEFUIC0gUENJX0VSUl9VTkNPUl9TVEFUVVMpOw0KKyAgICAg
ICAgICAgICAgICAgICAgICAgaHctPmVycl9jYXAgPSBQRVhfVU5DX0VSUl9TVEFUIC0gUENJX0VS
Ul9VTkNPUl9TVEFUVVM7DQorICAgICAgICAgICAgICAgfQ0KKwkJCQkJIA0KIAl9DQogDQogCWh3
LT5wbWRfdHlwZSA9IHNreTJfcmVhZDgoaHcsIEIyX1BNRF9UWVApOw0K


--=-PTavlHUZzryen5Gvt8cH--

--=-4FPqPrOf/PZbCF96FVDp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKQAYAq2P5eLUP5IRAiePAKCQHsUMZyqdf67lZDAKfI/M93BA7QCeMz3M
aQRRZ0XWWYK8YTnBFINoor0=
=6Hi7
-----END PGP SIGNATURE-----

--=-4FPqPrOf/PZbCF96FVDp--

