Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271116AbTG1Vba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271069AbTG1Vba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:31:30 -0400
Received: from mx02.qsc.de ([213.148.130.14]:17900 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S271116AbTG1V3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:29:51 -0400
Date: Mon, 28 Jul 2003 23:29:39 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-ID: <20030728212939.GB6798@gmx.de>
Reply-To: Johoho <johoho@hojo-net.de>
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu> <20030728114041.2c8ce156.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20030728114041.2c8ce156.akpm@osdl.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test2-O10 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2003 at 11:40:41AM -0700, Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > I am, however, able to get 'xmms' to skip.  The reason is that the CPU =
is being
> >  scheduled quite adequately, but I/O is *NOT*.
> >=20
> > ...
> >  I'm guessing that the anticipatory scheduler is the culprit here.  Soo=
n as I figure
> >  out the incantations to use the deadline scheduler, I'll report back..=
=2E.
>=20
> Try decreasing the expiry times in /sys/block/hda/queue/iosched:
>=20
> read_batch_expire
> read_expire
> write_batch_expire
> write_expire

I noticed that when bringing a huge application out of swap (mozilla,
openoffice, also tested the gimp with 50 images open) that dividing
everything by 2 in those 4 files I get a decent process fork. Without
this tuning the fork (xterm) waits till the application is back up.

--=20
Regards,

Wiktor Wodecki

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JZXD6SNaNRgsl4MRAjXxAKDCrMeY2YQD91GLGT2ZEJDw59p8QgCfc2mw
bD+BhI97ahHKZPA6NGKkUPg=
=BbaG
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
