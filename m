Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTDYNyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTDYNyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:54:12 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:1265 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263186AbTDYNyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:54:09 -0400
Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Cameron, Steve" <Steve.Cameron@hp.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF1040528C8@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF1040528C8@cceexc23.americas.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZaoWhEelM5VRoz8ALgqB"
Organization: Red Hat, Inc.
Message-Id: <1051279564.1391.18.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 25 Apr 2003 16:06:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZaoWhEelM5VRoz8ALgqB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-04-25 at 15:48, Miller, Mike (OS Dev) wrote:
> I haven't seen any issues (yet) on ia64. I'm running with 5GB RAM.
>=20
> mikem
>=20
> -----Original Message-----
> From: Cameron, Steve=20
> Sent: Friday, April 25, 2003 8:25 AM
> Cc: linux-kernel@vger.kernel.org; Miller, Mike (OS Dev)
> Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4
>=20
>=20
>=20
> Mike Miller wrote:
>=20
> > Changes:
> >	1. Sets the DMA mask to 64 bits. Removes RH's code for the DMA mask.
>=20
> In order for this to work, it depends on pci_alloc_consistent always
> returning memory with physical addresses that fit in 32 bits,=20
> regardless of the DMA mask, since the cciss device's command register=20
> is 32 bits, and the command buffer addresses must fit in there.  If=20
> that's the case, this is fine.  Otherwise, this may fail if pci_alloc_con=
sistent
> returns memory above 4GB.  (on x86, I think this is not a problem, not
> sure of other archs, e.g. alpha, ia64)

Cameron, lots of people told you numerous times that pci_alloc_consitent
is guaranteed to return 32 bit addresses by the API, see
Documentation/DMA-mapping.txt for the API definition.


--=-ZaoWhEelM5VRoz8ALgqB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+qUDMxULwo51rQBIRAru5AJ0bXy81ZuUUctRN7bQIK7lvOTjGowCePOR8
XVelhuNc4TxCoj2yfF4gKos=
=powF
-----END PGP SIGNATURE-----

--=-ZaoWhEelM5VRoz8ALgqB--
