Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUC2XPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUC2XPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:15:20 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:42156 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263199AbUC2XPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:15:13 -0500
Date: Mon, 29 Mar 2004 15:15:08 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [patch] datafab fix and unusual devices
Message-ID: <20040329231508.GH28472@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, greg@kroah.com,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	USB Storage List <usb-storage@lists.one-eyed-alien.net>
References: <UTC200403292244.i2TMi9f11131.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <UTC200403292244.i2TMi9f11131.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2004 at 12:44:09AM +0200, Andries.Brouwer@cwi.nl wrote:
> datafab.c has an often-seen bug: the SCSI READ_CAPACITY command
> does not need the number of sectors but the last sector.

The first part of the patch (which fixes this bug) certainly looks good to
me for 2.6 -- we need to check that 2.4 doesn't also have the problem.

> I just tried the CF and SM parts of a 5-in-1 card reader.
> The CF part works with US_PR_DATAFAB when the bug mentioned is fixed.
> The SM part works with US_PR_SDDR55.
> (Revision Number is 17.08 - that in case the 0000-ffff
> should prove to be too optimistic.)
>=20
> We still must discuss what setup to use for readers like this -
> I have several of them - that require different drivers for
> different LUNs. As it is now one has to compile usb-storage
> twice, once with CONFIG_USB_STORAGE_DATAFAB defined and once
> without, and remove one usb-storage.ko and insert the other
> to go from CF to SM. (And that hangs with 2.6.4 so a reboot
> is required..)

The second part of your patch I don't like (it seems to violate the
'principal of least suprise' to me).... but I'm also ready and willing to
consider a beter alternative.  What do you suggest?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAaK37IjReC7bSPZARAtPaAKCxoHySzf1OrfffEVYbaa0I36SIsgCeLSJG
LGDROEryberCNWVFNPvkyko=
=6Z//
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
