Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWBWArH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWBWArH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWBWArH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:47:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:15749 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751611AbWBWArF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:47:05 -0500
Subject: Re: [dm-devel] Re: [PATCH] User-configurable HDIO_GETGEO for dm
	volumes
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Alasdair G Kergon <agk@redhat.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060222223240.GI31641@agk.surrey.redhat.com>
References: <43F38D83.3040702@us.ibm.com>
	 <20060217151650.GC12173@agk.surrey.redhat.com>
	 <43F6718E.2000908@us.ibm.com>
	 <20060222223240.GI31641@agk.surrey.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GTv5dv728OERUgSpHGy5"
Date: Wed, 22 Feb 2006 16:46:57 -0800
Message-Id: <1140655617.3300.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GTv5dv728OERUgSpHGy5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Looks good and tests ok, with one issue: I still have a preference for
returning -ENOTTY over 0/0/0 when dm doesn't know the geometry.  That
said, most programs will see the zero cylinder count and make a guess,
so it probably doesn't matter.

If you're happy with it, I say put it in.  Thanks for the cleanup, by
the way!

--Darrick

On Wed, 2006-02-22 at 22:32 +0000, Alasdair G Kergon wrote:
> On Fri, Feb 17, 2006 at 04:59:58PM -0800, Darrick J. Wong wrote:
> > Here's the third revision, with the geometry pushed into mapped_device=20
> > as well as fixes for the problems that you pointed out wrt string=20
> > passing, lack of warning messages, etc.  Thanks for all the great feedb=
ack!
> =20
> Almost there now: how does the version below look?
> Corresponding userspace changes are in device-mapper CVS.
>=20
> Alasdair

--=-GTv5dv728OERUgSpHGy5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD/QYBa6vRYYgWQuURAlf6AJwNhR0VXufdv6531tObm6ykrdCfEQCgnJGv
W3kVAjEUCAZ2SM1k/RTgDSM=
=mVId
-----END PGP SIGNATURE-----

--=-GTv5dv728OERUgSpHGy5--

