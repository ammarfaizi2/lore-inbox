Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUHZOd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUHZOd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbUHZOal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:30:41 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:57751 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269020AbUHZOYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:24:53 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Rik van Riel <riel@redhat.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TsGvMzc4KIKWJlKTpFxp"
Date: Thu, 26 Aug 2004 16:24:37 +0200
Message-Id: <1093530277.11694.54.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TsGvMzc4KIKWJlKTpFxp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 10:12 -0400 schrieb Rik van Riel:

> > I think Hans is not planning turning old "file is a stream of bytes"
> > into eight-stream octopus. One stream will remain as a 'main' one,
> > which contains actual data. Others will keep metadata, etc...
>=20
> This is exactly what the Samba people want, though.=20
>=20
> Office suites can store a document with embedded images
> and spread sheets "easily" by putting the text, the
> images and spread sheets all in different file streams.

Ouch.

I think Hans' idea is (I don't know if it is a good idea nor if it is
doable, but at least it sounds interesting) to have special compound
files where you can do something like this:

cp text.txt test.compound/test.txt
cp image.jpg test.compound/image.jpg

And if you read test.compound (the main stream) you get a special format
that contains all the components. You can copy that single stream of
bytes to another (reiser4) fs and then access test.compound/test.txt
again.

The only thing I'm worrying about with this approach is what happens if
someone tries to simultaneously open test.compound and
test.compound/test.txt.

Hans has an example somewhere where he does something like that
with /etc/passwd.


--=-TsGvMzc4KIKWJlKTpFxp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLfKlZCYBcts5dM0RAjcVAJ91DBMsVN4vu4ifyEA8PRoDvoD2fQCfdxOV
S+wBykV6HHVnExb4aGVwb8k=
=UKaF
-----END PGP SIGNATURE-----

--=-TsGvMzc4KIKWJlKTpFxp--

