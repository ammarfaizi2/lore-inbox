Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbTIVRLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbTIVRLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:11:41 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:25842 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263242AbTIVRLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:11:40 -0400
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	 <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	 <20030922162602.GB27209@mail.jlokier.co.uk>
	 <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NZztW7ncGQAYBRFExUg7"
Organization: Red Hat, Inc.
Message-Id: <1064250691.6235.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 22 Sep 2003 19:11:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NZztW7ncGQAYBRFExUg7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-22 at 18:33, Alan Cox wrote:
\
> > I've also seen much DOS code that didn't have extra delays for
> > keyboard I/Os.  What sort of breakage did you observe with the
> > keyboard?
>=20
> DEC laptops hang is the well known example of that one.
>=20
> I'm *for* making this change to udelay, it just has to start up with a
> suitably pessimal udelay assumption until calibrated.

or we make udelay() do the port 80 access in the uncalibrated case....

The first person to complain about the extra branch miss in udelay for
this will get laughed at by me ;)


--=-NZztW7ncGQAYBRFExUg7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/by1DxULwo51rQBIRAg46AJ9v/ZPlZb6JF2YsDA19S7QaPLIbjACghVYT
OYXI/eAqwzL2oKCIagBlc6s=
=8GdQ
-----END PGP SIGNATURE-----

--=-NZztW7ncGQAYBRFExUg7--
