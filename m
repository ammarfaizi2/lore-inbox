Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUHZV0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUHZV0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbUHZVZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:25:57 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:18601 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269657AbUHZVJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:09:31 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <57730000.1093554054@flay>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org>
	 <45010000.1093553046@flay>
	 <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>
	 <57730000.1093554054@flay>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c14bBX2vCs/ZAYJFr6ee"
Date: Thu, 26 Aug 2004 23:09:07 +0200
Message-Id: <1093554547.13881.55.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c14bBX2vCs/ZAYJFr6ee
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 14:00 -0700 schrieb Martin J. Bligh:

> > "It's a feature".
> >=20
> > The S_ISDIR/S_ISREG tests show real information: it shows not only user
> > intent ("you should consider this a file, even if it has attributes"), =
but
> > also whether it is a directory or a container.
> >=20
> > And there's a real technical difference there: the streams contained
> > within a file are bound to that file. The files contained within a
> > directory are _independent_ of that directory. Big difference. HUGE
> > difference.
> >=20
> > So it's not confusing. If it tests as a file, you think of it as a file=
. =20
> > It may have attributes aka named streams associated with it, and you ma=
y
> > be able to open those attributes by treating the file as a directory, b=
ut
> > that doesn't really change the fact that it's a file.
> >=20
> > The _big_ difference is that when you can make the compound object _loo=
k_=20
> > like a directory, that means that you can now manage the attributes wit=
h=20
> > standard tools. They are still attributes, though.
>=20
> I think what you're saying is that they'd both return positive, right?

No. A file is still a file and S_ISREG will thus return false.
The application should just try to open it as a directory if it wants to
access the assiociated embedded attribute files. If the open fails,
well, it knows that the filesystem (or Linux version, whatever) doesn't
support this feature.


--=-c14bBX2vCs/ZAYJFr6ee
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLlFzZCYBcts5dM0RAiA9AKCISYg9TLy0K3f80r0kl/zZ+RXsTQCghu2h
RbkLsuBUPit/G6UyNlW7lIo=
=5zQ2
-----END PGP SIGNATURE-----

--=-c14bBX2vCs/ZAYJFr6ee--

