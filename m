Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUHNTyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUHNTyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUHNTxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:53:04 -0400
Received: from zero.voxel.net ([209.123.232.253]:3970 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S264857AbUHNTjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:39:11 -0400
Subject: [PATCH] don't delete debian directory in official debian builds
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DtDVg5rJ2IQCYBWpIqnR"
Date: Sat, 14 Aug 2004 15:39:03 -0400
Message-Id: <1092512343.3971.23.camel@spiral.internal>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DtDVg5rJ2IQCYBWpIqnR
Content-Type: multipart/mixed; boundary="=-TneH1qn04hfs9/VOt977"


--=-TneH1qn04hfs9/VOt977
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Somewhere along the 2.6 series, there was a change made that causes
distclean to automatically delete the debian/ subdirectory from the top
of the kernel tree.  This causes grief for the official debian kernel
packages; the debian directory shouldn't be deleted in the packages.
Please apply the attached patch; it causes the debian/ subdirectory to
only be deleted if there's no debian/official.

An even better solution would be to mark the debian directory as being
created by the kernel (touch debian/linus), and only delete it if the
kernel created it.


--=20
Andres Salomon <dilinger@voxel.net>

--=-TneH1qn04hfs9/VOt977
Content-Disposition: attachment; filename=dont-delete-debian.patch
Content-Type: application/x-shellscript; name=dont-delete-debian.patch
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaCAtZQojIyBkb250LWRlbGV0ZS1kZWJpYW4uZHBhdGNoIGJ5IEFuZHJlcyBTYWxv
bW9uIDxkaWxpbmdlckB2b3hlbC5uZXQ+CiMjCiMjIEFsbCBsaW5lcyBiZWdpbm5pbmcgd2l0aCBg
IyMgRFA6JyBhcmUgYSBkZXNjcmlwdGlvbiBvZiB0aGUgcGF0Y2guCiMjIERQOiBEZXNjcmlwdGlv
bjogZG9uJ3QgZGVsZXRlIGRlYmlhbiBkaXJlY3RvcnkgaWYgZGViaWFuL29mZmljaWFsIGV4aXN0
cwojIyBEUDogUGF0Y2ggYXV0aG9yOiBBbmRyZXMgU2Fsb21vbgojIyBEUDogVXBzdHJlYW0gc3Rh
dHVzOiB1bnN1Ym1pdHRlZAoKLiAkKGRpcm5hbWUgJDApL0RQQVRDSAoKQERQQVRDSEAKLS0tIG9y
aWcvc2NyaXB0cy9wYWNrYWdlL01ha2VmaWxlCTIwMDQtMDgtMTQgMTQ6NTk6NDQuMDAwMDAwMDAw
IC0wNDAwCisrKyBtb2Qvc2NyaXB0cy9wYWNrYWdlL01ha2VmaWxlCTIwMDQtMDgtMTQgMTU6MDA6
NTUuMDAwMDAwMDAwIC0wNDAwCkBAIC03Nyw3ICs3Nyw3IEBACiAJJChNQUtFKQogCSQoQ09ORklH
X1NIRUxMKSAkKHNyY3RyZWUpL3NjcmlwdHMvcGFja2FnZS9idWlsZGRlYgogCi1jbGVhbi1ydWxl
ICs9ICYmIHJtIC1yZiAkKG9ianRyZWUpL2RlYmlhbi8KK2NsZWFuLXJ1bGUgKz0gJiYgdGVzdCAt
ZiAkKG9ianRyZWUpL2RlYmlhbi9vZmZpY2lhbCB8fCBybSAtcmYgJChvYmp0cmVlKS9kZWJpYW4v
CiAKIAogIyBIZWxwIHRleHQgZGlzcGxheWVkIHdoZW4gZXhlY3V0aW5nICdtYWtlIGhlbHAnCg==


--=-TneH1qn04hfs9/VOt977--

--=-DtDVg5rJ2IQCYBWpIqnR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBHmpW78o9R9NraMQRAvRzAKDAK9fEWuQOapg1RfcOnQv8abdFlQCfZMWo
ha+6G1VydjItUZbQdDSGRwM=
=NRLR
-----END PGP SIGNATURE-----

--=-DtDVg5rJ2IQCYBWpIqnR--

