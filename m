Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266773AbUFYPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266773AbUFYPzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbUFYPzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:55:55 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:60917 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S266773AbUFYPzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:55:32 -0400
Subject: [PATCH/RFC] b44 and sundance watchdog changes.
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: Donald Becker <becker@scyld.com>, "David S. Miller" <davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c/VfRdWSx/pyF2Gbjcat"
Message-Id: <1088178930.23713.27.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 17:55:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c/VfRdWSx/pyF2Gbjcat
Content-Type: multipart/mixed; boundary="=-GcWDQ+Ttnsy/No5XbijE"


--=-GcWDQ+Ttnsy/No5XbijE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I experimented some with the watchdog timers in these drivers because i
had some problems with em.

sundance.c:
I first raised this to 8 (and had no problems with it) but since too
many watchdog 'resets' breaks the hardware to the point where you have
to actually shutdown the machine for a while, i thought, better safe
than sorry.

b44.c:
My first try was to raise the timer to 10, but i actually got a failure,
so i increased it again by a 5s increment.

This was tested while transfering ~20 gigs of data via nfs.
The only problem that i experienced during this time is 2x:
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.

There was no messages at all from the sundance driver, it worked
perfectly.

Comments? suggestions?

PS. Sorry, couldn't find anyone listed in maintainers, so module authors
was added to CC =3DP

CC me since i'm not subscribed.
DS.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-GcWDQ+Ttnsy/No5XbijE
Content-Disposition: inline; filename=b44.diff
Content-Type: text/x-patch; name=b44.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L2I0NC5jLm9sZAkyMDA0LTA2LTI1IDA1OjE0OjIzLjAwMDAw
MDAwMCArMDIwMA0KKysrIGxpbnV4L2RyaXZlcnMvbmV0L2I0NC5jCTIwMDQtMDYtMjUgMTU6Mzg6
MjIuMDAwMDAwMDAwICswMjAwDQpAQCAtNDMsNyArNDMsNyBAQA0KIC8qIGxlbmd0aCBvZiB0aW1l
IGJlZm9yZSB3ZSBkZWNpZGUgdGhlIGhhcmR3YXJlIGlzIGJvcmtlZCwNCiAgKiBhbmQgZGV2LT50
eF90aW1lb3V0KCkgc2hvdWxkIGJlIGNhbGxlZCB0byBmaXggdGhlIHByb2JsZW0NCiAgKi8NCi0j
ZGVmaW5lIEI0NF9UWF9USU1FT1VUCQkJKDUgKiBIWikNCisjZGVmaW5lIEI0NF9UWF9USU1FT1VU
CQkJKDE1ICogSFopDQogDQogLyogaGFyZHdhcmUgbWluaW11bSBhbmQgbWF4aW11bSBmb3IgYSBz
aW5nbGUgZnJhbWUncyBkYXRhIHBheWxvYWQgKi8NCiAjZGVmaW5lIEI0NF9NSU5fTVRVCQkJNjAN
Cg==

--=-GcWDQ+Ttnsy/No5XbijE
Content-Disposition: inline; filename=sundance.diff
Content-Type: text/x-patch; name=sundance.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L3N1bmRhbmNlLmMub2xkCTIwMDQtMDYtMjUgMDU6MTQ6MTMu
MDAwMDAwMDAwICswMjAwDQorKysgbGludXgvZHJpdmVycy9uZXQvc3VuZGFuY2UuYwkyMDA0LTA2
LTI1IDA1OjE0OjQ5LjAwMDAwMDAwMCArMDIwMA0KQEAgLTE0NSw3ICsxNDUsNyBAQA0KIA0KIC8q
IE9wZXJhdGlvbmFsIHBhcmFtZXRlcnMgdGhhdCB1c3VhbGx5IGFyZSBub3QgY2hhbmdlZC4gKi8N
CiAvKiBUaW1lIGluIGppZmZpZXMgYmVmb3JlIGNvbmNsdWRpbmcgdGhlIHRyYW5zbWl0dGVyIGlz
IGh1bmcuICovDQotI2RlZmluZSBUWF9USU1FT1VUICAoNCpIWikNCisjZGVmaW5lIFRYX1RJTUVP
VVQgICgxMCpIWikNCiAjZGVmaW5lIFBLVF9CVUZfU1oJCTE1MzYJLyogU2l6ZSBvZiBlYWNoIHRl
bXBvcmFyeSBSeCBidWZmZXIuKi8NCiANCiAjaWZuZGVmIF9fS0VSTkVMX18NCg==

--=-GcWDQ+Ttnsy/No5XbijE--

--=-c/VfRdWSx/pyF2Gbjcat
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3Ery7F3Euyc51N8RAueuAKCdbxY8+XBo3cDiTCWEk5pn9vx2mQCgiELv
6qp/3d1oiPhLG5wymtKNKzg=
=F0vT
-----END PGP SIGNATURE-----

--=-c/VfRdWSx/pyF2Gbjcat--

