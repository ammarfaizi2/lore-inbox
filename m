Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTKHAdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTKGWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:04 -0500
Received: from smtp2.clb.oleane.net ([213.56.31.18]:42467 "EHLO
	smtp2.clb.oleane.net") by vger.kernel.org with ESMTP
	id S263950AbTKGIvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 03:51:01 -0500
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual
	content is read (only directory structure)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031107082439.GB504@suse.de>
References: <20031105084002.GX1477@suse.de>
	 <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
	 <20031107082439.GB504@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CbHSyOhnXxCmM/2GyR7a"
Organization: Adresse personnelle
Message-Id: <1068195038.21576.1.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Nov 2003 09:50:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CbHSyOhnXxCmM/2GyR7a
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 07/11/2003 =E0 09:24, Jens Axboe a =E9crit :
> On Wed, Nov 05 2003, Alan Stern wrote:

> > In any case, it quite likely _does_ point to a driver bug.  But since
> > sddr09_read_data() was handed this sg entry and didn't change it, if th=
ere
> > is such a bug it must lie in a higher-level driver.  Maybe the scsi lay=
er,=20
> > maybe the block layer, maybe the memory-management system, maybe the fi=
le=20
> > system.  That was my original point.
>=20
> Well, the sg entry looks perfectly valid. And that was my original
> point :-). And that is why I said it looks like a driver bug, not in
> upper layers. How much memory did the system that crashed have? If the
> system has highmem, try testing with scsi_calculate_bounce_limit()
> unconditionally returning BLK_BOUNCE_HIGH.

The system has 1 GiB of memory, ie just enough to make stuff like
radeonfb fail

Cheers,

--=20
Nicolas Mailhot

--=-CbHSyOhnXxCmM/2GyR7a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/q1zdI2bVKDsp8g0RAjZ2AJ9hTmXjfxCk2rZM7gGaCDfdUvEQSQCfcHXg
aegkZJ4Nu8yOdqbRSWJtAfk=
=58fz
-----END PGP SIGNATURE-----

--=-CbHSyOhnXxCmM/2GyR7a--

