Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271700AbTGXPvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271701AbTGXPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:51:05 -0400
Received: from D70c6.pppool.de ([80.184.112.198]:52869 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S271700AbTGXPuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:50:46 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Daniel Egger <degger@fhm.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <3F1EF7DB.2010805@namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-11LU1xTdjT5qufgNnzxo"
Message-Id: <1059062380.29238.260.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 17:59:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-11LU1xTdjT5qufgNnzxo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2003-07-23 um 23.02 schrieb Hans Reiser:

> In brief, V4 is way faster than V3, and the wandering logs are indeed=20
> twice as fast as fixed location logs when performing writes in large=20
> batches.

How do the wandering logs compare to the "wandering" logs of the log
structured filesystem JFFS2? Does this mean I can achieve an implicit
wear leveling for flash memory?=20

> We are able to perform all filesystem operations fully atomically,
> while getting dramatic performance improvements.  (Other attempts at
> introducing transactions into filesystems are said to have failed for
> performance reasons.)

How failsafe is it to switch off the power several times? When the
filesystem really works atomically I should have either the old or the
new version but no mixture. Does it still need to fsck or is the
transaction replay done at mount time? In case one still needs fsck,
what's the probability of needing user interaction? How long does it
need to get a filesystem back into a consistent state after a powerloss
(approx. per MB/GB)?

Background: I'm doing systems on compactflash cards and need a reliable
filesystem for it. At the moment I'm using a compressed JFFS2 over the
mtd emulation driver for block devices which works quite well but has a
few catches...

--=20
Servus,
       Daniel

--=-11LU1xTdjT5qufgNnzxo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/IAJschlzsq9KoIYRAvC8AJ9lp8blC1AHYohR0l96uQS7WILJ/wCdFeMi
WA1IXOnx+5fdJJ+NruOuJuA=
=OhEi
-----END PGP SIGNATURE-----

--=-11LU1xTdjT5qufgNnzxo--

