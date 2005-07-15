Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbVGODKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbVGODKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbVGODKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:10:12 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:48027 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S263199AbVGODKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:10:07 -0400
Date: Fri, 15 Jul 2005 13:09:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ppc64-dev@ozlabs.org, anton@samba.org
Subject: RFC: IOMMU bypass
Message-Id: <20050715130933.492ac904.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__15_Jul_2005_13_09_33_+1000_lhGdeSRhtOrbsAyZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__15_Jul_2005_13_09_33_+1000_lhGdeSRhtOrbsAyZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

We (Anton Blanchard and others) have been trying to figure out the best
(or any) way to allow for IOMMU bypass when setting up DMA mappings on
particular devices.  Our current idea is to hang a structure of pointers
to DMA mapping operations off the struct device and inherit it from the
device's parent.  This would allow for per-bus (rather than per-bus_type)
mapping operations and also allow a driver to override the bus's
operations for a particular device.

Does this make sense?  Comments (hopefully consructive) please.

Is there a better/simpler/more sensible way to do this?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__15_Jul_2005_13_09_33_+1000_lhGdeSRhtOrbsAyZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1yj2FdBgD/zoJvwRAgMTAJ0btOq2iCBeK5uji9vrozhPekPVJwCbBV66
wXW0lpYsIaL1CIRvKQCzmIs=
=jBlQ
-----END PGP SIGNATURE-----

--Signature=_Fri__15_Jul_2005_13_09_33_+1000_lhGdeSRhtOrbsAyZ--
