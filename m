Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUFICdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUFICdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 22:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUFICdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 22:33:18 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:62604 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265508AbUFICdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 22:33:13 -0400
Date: Tue, 8 Jun 2004 20:33:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] tiny patch to kill warning in drivers/ide/ide.c
Message-ID: <20040609023308.GC24042@schnapps.adilger.int>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
References: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 09, 2004  03:38 +0200, Jesper Juhl wrote:
> drivers/ide/ide.c: In function `ide_unregister_subdriver':
> drivers/ide/ide.c:2216: warning: implicit declaration of function `pnpide=
_init'
>=20
> I added a simple declaration of pnpide_init to drivers/ide/ide.c
>=20
> Here's a patch against 2.6.7-rc3 - please consider including it (or if
> that's not the way to do it, then don't) :)

Better to add the declaration into a header like linux/ide.h that is
included into both ide.c and ide-pnp.c so that when/if pnpide_init()
ever changes its prototype you will get a warning during compilation.

The only good reason to have declarations within .c files is for forward
declarations of functions only used in the same file.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--m51xatjYGsM+13rf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAxnbkpIg59Q01vtYRAn6OAJ0eCiDJUjHSkzo+idkYA5inQ1k/XACePYbV
Sxtjoht4t2NCEZpmT66naxs=
=NRLz
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
