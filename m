Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbULAHRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbULAHRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 02:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbULAHRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 02:17:35 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:10939 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261244AbULAHR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 02:17:28 -0500
Date: Wed, 1 Dec 2004 08:16:27 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041201071627.GB25969@vagabond>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2004 at 22:13:27 +0100, Miklos Szeredi wrote:
>=20
> > you're describing the deadlock here: all memory is full, no process=20
> > which allocates memory can make any progress.
>=20
> Yes they, can: the allocation will fail, function will return -ENOMEM,
> malloc will return NULL, pagefault will fail with OOM.  This is
> progress, though not the best sort.  It is most certainly _not_ a
> deadlock.

Allocation won't fail! There's overcommit! Pagefault won't OOM, because
it will wait for the pages to get laundered. And the pages won't get
laundered untill the pagefault suceeds. (Yes, I know that you are going
to mark the pages as dirty again so the pagefault won't wait for them,
but you have to mention it.)

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBrW/LRel1vVwhjGURAoIQAJ97SAq6zu0gCYbOu1g1upfGfv2S7QCg6NOV
ynvlmTN1INo2PFiJ6wmjQwA=
=2pAd
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
