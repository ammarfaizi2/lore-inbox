Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbUKZWBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbUKZWBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbUKZV4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:56:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49861 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263931AbUKZTxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:53:15 -0500
Date: Thu, 25 Nov 2004 07:26:49 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041125062649.GB29278@vagabond>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 24, 2004 at 14:05:51 +0100, Miklos Szeredi wrote:
> > http://lkml.org/lkml/2004/7/26/68
> >=20
> > discusses a userspace filesystem (implemented as a userspace nfs server=
=20
> > mounted on a loopback nfs mount), the problem, a solution (exactly your=
=20
> > suggestion), and a more generic solution.
>=20
> Thanks for the pointer, very interesting read.
>=20
> However, I don't like the idea that the userspace filesystem must
> cooperate with the kernel in this regard.  With this you lose one of
> the advantages of doing filesystem in userspace: namely that you can
> be sure, that anything you do cannot bring the system down.
>=20
> And I firmly believe that this can be done without having to special
> case filesystem serving processes.
>=20
> There are already "strange" filesystems in the kernel which cannot
> really get rid of dirty data.  I'm thinking of tmpfs and ramfs.
> Neither of them are prone to deadlock, though both of them are "worse
> off" than a userspace filesystem, in the sense that they have not even
> the remotest chance of getting rid of the dirty data.
>=20
> Of course, implementing this is probably not trivial.  But I don't see
> it as a theoretical problem as Linus does.=20
>=20
> Is there something which I'm missing here?

But they KNOW that they won't be able to get rid of the dirty data. But
fuse does not.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBpXspRel1vVwhjGURAmNGAKCiEPKHXCf14IcMMmIAx37UAZyd3gCbBy1c
FEBkMx3dJDNmOZrWOJExExc=
=a0sp
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
