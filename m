Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVHRKlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVHRKlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVHRKlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:41:39 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:17637 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932170AbVHRKli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:41:38 -0400
Date: Thu, 18 Aug 2005 12:41:32 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
Message-ID: <20050818104131.GH12313@vanheusden.com>
References: <20050818100151.GF12313@vanheusden.com>
	<20050818100536.GB16751@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20050818100536.GB16751@wohnheim.fh-wedel.de>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Fri Aug 19 10:38:19 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > What about a zero-copy read-interface?
> > An ioctl (or something) which enables the kernel to do dma directly to
> > the userspace. Of course this should be limited to the root-user or a
> > user with special capabilities (rights) since if a drive screws up, data
> > from a different sector (or so) might end up in the proces' memory. Of
> > course copying a sector from kernel- to userspace can be done pretty
> > fast but i.m.h.o. all possible speedimprovements should be made unless
> > unclean.
> Just use mmap().  Unlike your proposal, it cooperates with the page
> cache.

Doesn't that one also use copying? I've also heard that using mmap is
expensive due to pagefaulting. I've found, for example, that copying a
1.3GB file using read/write instead of mmap & memcpy is seconds faster.


Folkert van Heusden

--=20
Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkMEZds8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuu6MAn3uJ+a25
/GcuewtEvfAPK1+PZJqUAJ4h+bHncmBlAaHc9qKianNQluLGIw==
=krUL
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
