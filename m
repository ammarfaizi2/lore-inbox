Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbUAWDP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266503AbUAWDP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:15:28 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:53742 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264485AbUAWDPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:15:20 -0500
Date: Fri, 23 Jan 2004 16:18:07 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Export console functions for use	by	Software	Suspend	nice
 display
In-reply-to: <1074827229.12773.198.camel@laptop-linux>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Jacobowitz <dan@debian.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074827886.12771.203.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-3C3JpT6UEIczfXRHM+eJ";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074757083.1943.37.camel@laptop-linux>
 <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
 <1074796577.12771.81.camel@laptop-linux>
 <20040122203529.GB13377@nevyn.them.org> <1074826188.976.185.camel@gaston>
 <1074827229.12773.198.camel@laptop-linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3C3JpT6UEIczfXRHM+eJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry to reply to myself.

I don't think I worded that last message right... I didn't mean that
locking isn't an issue at all, just that we don't have to worry about
another process writing to the console while we are.

Nigel

On Sat, 2004-01-24 at 05:07, Nigel Cunningham wrote:
> Hi.
>=20
> On Fri, 2004-01-23 at 15:49, Benjamin Herrenschmidt wrote:
> > Also, by using write instead of blasting the low level code,
> > you will not have to worry about locking issues. (The way
> > you tap the low level stuff should require at least the console
> > semaphore held, write to /dev/console don't)
> >=20
> > Ben
>=20
> Locking is not an issue. This is suspend-to-disk. Everything else is
> stopped while we're working.
>=20
> By the way, am I understanding the suggestion correctly? Do you
> (collective) mean getting a fd for /dev/console from within kernel code
> and using that? I've been looking at the way printk works and wondering
> if con->write is equivalent (once I find the right console to write to)?
>=20
> Regards,
>=20
> Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-3C3JpT6UEIczfXRHM+eJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEJJuVfpQGcyBBWkRAl1gAJ9uDE6g+qj+DDSQmMKkBMgERdfWeACfeCZ2
OLSjSQeboroXS42pMf4rUaU=
=CjAn
-----END PGP SIGNATURE-----

--=-3C3JpT6UEIczfXRHM+eJ--

