Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUENOcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUENOcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUENOcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:32:06 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:53764 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261369AbUENOZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:25:49 -0400
Date: Fri, 14 May 2004 16:25:35 +0200
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] AES i586 optimized, regparm fixed
Message-ID: <20040514142535.GA8735@ghanima.endorphin.org>
References: <20040514130724.GA8081@ghanima.endorphin.org>
	<Xine.LNX.4.44.0405140945590.20213-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0405140945590.20213-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085408736.2262@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2004 at 09:48:08AM -0400, James Morris wrote:
> On Fri, 14 May 2004, Fruhwirth Clemens wrote:
>=20
> > James, if the patch suits your taste, please take care of forwarding it=
 to
> > Andrew or Linus.
>=20
> There is still the binary license issue, and how to ensure this is built=
=20
> instead of the generic AES module for the right architectures.

It's the standard BSD license. I would really be suprised if that's the
first BSD code in the kernel. The issue should be handled like in the other
case, although I'm not interested in wheter the license text stays or is
purged.

A simple solution for implementation selection would be to add "depends on
!X86 || X86_64" to aes generic. MODULE_ALIAS will take care of the rest.

I have to state that I'm not interested in developing a more complicated
framework for automatic cipher selection. I've always been opposing
configuration wizard and install scripts with
magic-logic-that-will-configure-software-entirely-on-its-own-and-totally-wr=
ong
gimmicks. My aim is to provide a good/working aes-i586 patch.

Regards, Clemens

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFApNbfW7sr9DEJLk4RAuXZAKCTnzKXy7L96ZC5086YvREEGiUElgCeJxrJ
A0SKiJqjN0tGimx/CXJyXy4=
=qX6Y
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
