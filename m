Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTE1EVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTE1EVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:21:55 -0400
Received: from iucha.net ([209.98.146.184]:45131 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264495AbTE1EVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:21:54 -0400
Date: Tue, 27 May 2003 23:35:08 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs bug exposed by cdev changes
Message-ID: <20030528043508.GQ3359@iucha.net>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20030528003105.GD27916@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Content-Disposition: inline
In-Reply-To: <20030528003105.GD27916@parcelfarce.linux.theplanet.co.uk>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2003 at 01:31:05AM +0100, viro@parcelfarce.linux.theplanet.=
co.uk wrote:
> 	Patch follows.  It had fixed ALSA-triggered memory corruption here -
> what happens in vanilla 2.5.70 is that clear_inode() is not called when
> procfs character device inodes are freed.  That leaves a freed inode on
> a cyclic list, with obvious unpleasantness following when we try to trave=
rse
> it (e.g. when unregistering a device).
>=20
> 	Please, apply.  Folks who'd seen oopsen/memory corruption after
> ALSA access - please, check if that fixes all problems.

It works fine. The ALSA loads, plays and unloads without a problem.

Thank you,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+1Dx8NLPgdTuQ3+QRAvNiAJ4srN5QEkdOOFyEM+W4s878hkIv4QCfXD+T
2rEVti16WtiC82rQK9adMgo=
=bxjL
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
