Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUHDVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUHDVpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHDVpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:45:03 -0400
Received: from zlynx.org ([199.45.143.209]:55304 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S267443AbUHDVoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:44:20 -0400
Subject: 2.6.8-rc2-mm2, staircase sched and ESD
From: Zan Lynx <zlynx@acm.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qlnvKCgiFixtwtHqZl+u"
Message-Id: <1091655857.3088.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 04 Aug 2004 15:44:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qlnvKCgiFixtwtHqZl+u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The 2.6.8-rc2-mm2 kernel has the staircase scheduler, right?  Well, I am
seeing an odd thing.  At least, I think it is odd.

I'm running Fedora Core 2 and playing music with Rhythmbox.  When I
watch top sorted by priority, I see esd slowly increase its priority
until it reaches 38, then it goes back to 20.  ESD is only using 1-2%
CPU.

This is causing a problem because doing just about anything in X, like
bring up a new window or drag a window causes the sound to just stop.

Why does ESD's priority keep climbing?

Oh yes, this does not happen if I change /proc/sys/fs/interactive to 0.=20
When it is 0, X's priority climbs faster than ESDs and does not cause
the problem.
--=20
Zan Lynx <zlynx@acm.org>

--=-qlnvKCgiFixtwtHqZl+u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEVixG8fHaOLTWwgRAv2sAKCLAZDs7IPpm54PyNXxrYKpuz384ACgrPtF
gK1VBAuI6bUM99S29TX2TOI=
=REcl
-----END PGP SIGNATURE-----

--=-qlnvKCgiFixtwtHqZl+u--

