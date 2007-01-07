Return-Path: <linux-kernel-owner+w=401wt.eu-S965249AbXAGXhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbXAGXhN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 18:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbXAGXhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 18:37:13 -0500
Received: from ozlabs.org ([203.10.76.45]:53105 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965249AbXAGXhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 18:37:12 -0500
Subject: Re: [PATCH] increment pos before looking for the next cap in
	__pci_find_next_ht_cap
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Robert Hancock <hancockr@shaw.ca>
Cc: Brice Goglin <brice@myri.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <459EE61B.2070408@shaw.ca>
References: <fa.HKQ/+MClSV6hJeIdmFjKhgngCZQ@ifi.uio.no>
	 <459EE61B.2070408@shaw.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zm3zXnTP2MBgZy1S9fKc"
Date: Mon, 08 Jan 2007 10:37:10 +1100
Message-Id: <1168213030.28389.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zm3zXnTP2MBgZy1S9fKc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-05 at 17:58 -0600, Robert Hancock wrote:
> Brice Goglin wrote:
> > Hi,
> >=20
> > While testing 2.6.20-rc3 on a machine with some CK804 chipsets, we
> > noticed that quirk_nvidia_ck804_msi_ht_cap() was not detecting HT
> > MSI capabilities anymore. It is actually caused by the MSI mapping
> > on the root chipset being the 2nd HT capability in the chain.
> > pci_find_ht_capability() does not seem to find anything but the
> > first HT cap correctly, because it forgets to increment the position
> > before looking for the next cap. The following patch seems to fix it.
> >=20
> > At least, this prooves that having a ttl is good idea since the
> > machine would have been stucked in an infinite loop if we didn't
> > have a ttl :)
> >=20
> > The patch should go in 2.6.20 since this quirk was working fine in 2.6.=
19.
>=20
> Yes, I saw this on my A8N-SLI Deluxe board as well. This is a regression=20
> since MSI is being disabled on the PCI Express slots when it wasn't befor=
e..
>=20

Guilty as charged :/

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zm3zXnTP2MBgZy1S9fKc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFoYQmdSjSd0sB4dIRAtbkAJ9NHTEAuJUM/R/zpbB2NNbavTTZMgCdHl1a
C01CYfjI3W9oZ71bjmptvnM=
=9mZK
-----END PGP SIGNATURE-----

--=-zm3zXnTP2MBgZy1S9fKc--

