Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVGCKxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVGCKxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 06:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGCKxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 06:53:00 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:59016 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261268AbVGCKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 06:52:53 -0400
Subject: RE: [PATCH] ich6m-pciid-piix.patch
From: Erik Slagter <erik@slagter.name>
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F5043A5782@orsmsx410>
References: <26CEE2C804D7BE47BC4686CDE863D0F5043A5782@orsmsx410>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9U87uiTZY3feCAs3gMDa"
Date: Sun, 03 Jul 2005 12:55:59 +0200
Message-Id: <1120388159.4300.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9U87uiTZY3feCAs3gMDa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-07-02 at 17:23 -0700, Gaston, Jason D wrote:

>>> Please do not apply this patch.  The ICH6M SATA DID is all ready
>>> being used in the SATA ata_piix.c and ahci.c drivers.  Adding the
>>> ICH6M SATA DID to the PATA piix.c driver will conflict.  This patch
>>> would add the ICH6M >SATA controller DID 0x2653 to the PATA
>>> piix.c driver.

> > That's why you either enable piix support from the standard ide driver
> > xor from libsata. The comments in the configure script even mention thi=
s
> > fact!

> You need to have support for both at the same time if you want to run in
> enhanced mode and have full access to your PATA and SATA controllers and
> drives.

Hmmm. I guess this would be in the (imho unlikely) situation where you
have both PATA and SATA drives connected to the ICH6M.

I do see the problem, though. It's a "works for me(r)" solution ;-)

> I suggest you try to place your BIOS in Enhanced mode for the SATA/PATA
> controllers so that you have both the PATA and SATA DID's and
> controllers showing up.  Then your PATA drive will show up as an IDE
> device and use the piix driver.

Bzzzt! Nice theory, but in practise, MANY bioses (including mine) don't
offer the choice to put the controller in whatever mode. Add to that,
that if you only have pata drives attached, it doesn't make much sense
to drive it with libata.

I'd be happy to drive my ICH6M with libata, but it just doesn't work
well. No smart&hdparm (the corresponding patch freezes the kernel every
now and then) support, drives show up as scsi drives..., no atapi
(unless #defined, but also not yet bugfree).

Well anyway, this is just my $0.02 I guess it won't make it into the
kernel, but you never know how might be able to use it.

--=-9U87uiTZY3feCAs3gMDa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCx8Q/JgD/6j32wUYRAl7+AJ9OyBsnSFMQvV0iOttb5cNqrp5+qQCfccRo
Pj/g45LFdGGPtFEc+PLwJ1Q=
=t2PA
-----END PGP SIGNATURE-----

--=-9U87uiTZY3feCAs3gMDa--
