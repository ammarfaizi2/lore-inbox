Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUJaLfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUJaLfx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUJaLfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:35:11 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:34257 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261538AbUJaKg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:36:56 -0500
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
	initramfs image updates [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20041030234318.GI9592@mars.ravnborg.org>
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041026221216.GA30918@mars.ravnborg.org>
	 <1098824849.12420.60.camel@nosferatu.lan>
	 <20041026231514.GA3285@mars.ravnborg.org>
	 <1098902645.12420.75.camel@nosferatu.lan>
	 <20041030234318.GI9592@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-urRKzmnguulszVJy98fl"
Date: Sun, 31 Oct 2004 12:36:40 +0200
Message-Id: <1099219000.11924.9.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-urRKzmnguulszVJy98fl
Content-Type: multipart/mixed; boundary="=-3/pyQQ+zE+V8dALtVE+F"


--=-3/pyQQ+zE+V8dALtVE+F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-31 at 01:43 +0200, Sam Ravnborg wrote:
> On Wed, Oct 27, 2004 at 08:44:05PM +0200, Martin Schlemmer [c] wrote:
> > >=20
> >=20
> > How about below?  Works as expected.  I am open to suggestions short of
> > coding a util to print numeric mtimes besides find, but for the life of
> > me could not think of another way ...
>=20
> Looks good.
> Please send me a version that is not whitespace damaged and with a
> proper changelog.
> The changelog shall be descriptive in itself without relying on context
> from privious patch or comments in a mail.
>=20

Unfortunately evolution 2.0 seems to have some issues, and the
whitespace damage is one of them.  Anyhow, here is the patch attached,
with a changelog.  Hope that is OK.

----

  Add a comment to gen_initramfs_list.sh output that contains the
  numeric mtime of the last modified file in the source directory,
  or the mtime of the source list.  This should cause the initramfs
  image to be rebuild if a file in the source directory changed, or
  the source list (if that was used rather than a directory as source).


Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

--=20
Martin Schlemmer


--=-3/pyQQ+zE+V8dALtVE+F
Content-Disposition: attachment; filename=initramfs_list-regen-on-mtime-v1.patch
Content-Type: text/x-patch; name=initramfs_list-regen-on-mtime-v1.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS5vcmlnL3NjcmlwdHMvZ2VuX2luaXRy
YW1mc19saXN0LnNoIGxpbnV4LTIuNi45L3NjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0LnNoDQot
LS0gbGludXgtMi42Ljkub3JpZy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaAkyMDA0LTEw
LTI3IDIwOjA2OjQ3LjA0Mzk5OTQ0OCArMDIwMA0KKysrIGxpbnV4LTIuNi45L3NjcmlwdHMvZ2Vu
X2luaXRyYW1mc19saXN0LnNoCTIwMDQtMTAtMjcgMjA6MzQ6MzkuMTIxODA0OTg0ICswMjAwDQpA
QCAtMzcsNiArMzcsMTggQEAgZmlsZXR5cGUoKSB7DQogCXJldHVybiAwDQogfQ0KIA0KK3ByaW50
X210aW1lKCkgew0KKwlsb2NhbCBhcmd2MT0iJDEiDQorCWxvY2FsIG15X210aW1lPSIwIg0KKw0K
KwlpZiBbIC1lICIke2FyZ3YxfSIgXTsgdGhlbg0KKwkJbXlfbXRpbWU9JChmaW5kICIke2FyZ3Yx
fSIgLXByaW50ZiAiJVRAXG4iIHwgc29ydCAtciB8IGhlYWQgLW4gMSkNCisJZmkNCisJDQorCWVj
aG8gIiMgTGFzdCBtb2RpZmllZDogJHtteV9tdGltZX0iDQorCWVjaG8NCit9DQorDQogcGFyc2Uo
KSB7DQogCWxvY2FsIGxvY2F0aW9uPSIkMSINCiAJbG9jYWwgbmFtZT0iJHtsb2NhdGlvbi8ke3Ny
Y2Rpcn0vL30iDQpAQCAtNzcsMTYgKzg5LDE5IEBAIHBhcnNlKCkgew0KIAlyZXR1cm4gMA0KIH0N
CiANCi1pZiBbIC16ICQxIF07IHRoZW4NCitpZiBbIC16ICIkMSIgXTsgdGhlbg0KIAlzaW1wbGVf
aW5pdHJhbWZzDQotZWxpZiBbIC1mICQxIF07IHRoZW4NCi0JY2F0ICQxDQotZWxpZiBbIC1kICQx
IF07IHRoZW4NCitlbGlmIFsgLWYgIiQxIiBdOyB0aGVuDQorCXByaW50X210aW1lICIkMSINCisJ
Y2F0ICIkMSINCitlbGlmIFsgLWQgIiQxIiBdOyB0aGVuDQogCXNyY2Rpcj0kKGVjaG8gIiQxIiB8
IHNlZCAtZSAnczovLyo6LzpnJykNCiAJZGlybGlzdD0kKGZpbmQgIiR7c3JjZGlyfSIgLXByaW50
ZiAiJXAgJW0gJVUgJUdcbiIgMj4vZGV2L251bGwpDQogDQogCSMgSWYgJGRpcmxpc3QgaXMgb25s
eSBvbmUgbGluZSwgdGhlbiB0aGUgZGlyZWN0b3J5IGlzIGVtcHR5DQogCWlmIFsgICIkKGVjaG8g
IiR7ZGlybGlzdH0iIHwgd2MgLWwpIiAtZ3QgMSBdOyB0aGVuDQorCQlwcmludF9tdGltZSAiJDEi
DQorCQkNCiAJCWVjaG8gIiR7ZGlybGlzdH0iIHwgXA0KIAkJd2hpbGUgcmVhZCB4OyBkbw0KIAkJ
CXBhcnNlICR7eH0NCg==


--=-3/pyQQ+zE+V8dALtVE+F--

--=-urRKzmnguulszVJy98fl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBhMA3qburzKaJYLYRAsjkAJ4lV3iNRfI4G5/wlINTiqXl8Vi+yACfVV+a
4kvK3D7paUqbDpi8SLFKrcc=
=iqw4
-----END PGP SIGNATURE-----

--=-urRKzmnguulszVJy98fl--

