Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270538AbTGSVDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 17:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270540AbTGSVDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 17:03:14 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:56723 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S270538AbTGSVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 17:03:10 -0400
Subject: Re: libata driver update posted
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Catalin BOIE <util@deuroconsult.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <3F19A651.2080503@pobox.com>
References: <3F1711C8.6040207@pobox.com>
	 <Pine.LNX.4.53.0307180924020.19703@hosting.rdsbv.ro>
	 <3F17F28C.9050105@pobox.com>
	 <1058542771.13515.1599.camel@workshop.saharacpt.lan>
	 <20030718154322.GB27152@gtf.org> <1058645294.23174.7.camel@nosferatu.lan>
	 <3F19A651.2080503@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O7aIybiZw/kbf7cHT9Kd"
Message-Id: <1058649494.23174.43.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 23:18:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O7aIybiZw/kbf7cHT9Kd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-07-19 at 22:13, Jeff Garzik wrote:
> Martin Schlemmer wrote:
> > On Fri, 2003-07-18 at 17:43, Jeff Garzik wrote:
> >=20
> > Slower this side.  The Maxtor 40GB (ata133) is however just set to
> > udma33, where the Seagate 20GB (ata100) driver is set correctly to
> > udma100.
>=20
> Yeah, that's expected:  Parallel ATA (PATA) requires cable detection to=20
> go beyond UDMA/33, and my driver doesn't do that yet [since I'm=20
> concentrating on SATA].
>=20

Ok, make sense.  Nothing like the ide's 'hdx=3Dfoo' param?

>=20
> > The Seagate start off ok (about 35mb/s), but then after doing some heav=
y
> > disk io, it also just drops to the 20mb/s region.
>=20
> That's definitely interesting.  Is "heavy disk I/O" the hdparm stuff you=20
> described, or something else too?
>=20

Nope, its unpacking, compiling and installing glibc.  Sure, not _that_
extensive, but it does make it work a bit.  Might be some other
weirdness, as I did not try to reproduce it more than twice.

And then something else - gnome did not want to start due to missing
icons.  They are there however, and rebooting to old kernel without
libata worked fine (same kernel, just do not have the patch applied
or the normal ata driver disabled).

I will give it a go some more.  Currently I am having some issues with
getting latest cvs glibc & nptl to play nice, so I will not take it too
serious for now.  If anything obvious might cause it and you want me
to test, ask.  Otherwise I will give it a good run in the next few
weeks and get a more complete report.


Thanks,

--=20

Martin Schlemmer




--=-O7aIybiZw/kbf7cHT9Kd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GbWWqburzKaJYLYRAg+IAJ96aBrsoy8WOcfdYHat9W5OikDfkwCgmWlV
4j8bHoalwqKvvP+IZM4awmc=
=Hbsb
-----END PGP SIGNATURE-----

--=-O7aIybiZw/kbf7cHT9Kd--

