Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTFJSF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFJSF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:05:28 -0400
Received: from rdu26-81-149.nc.rr.com ([66.26.81.149]:2944 "EHLO
	max.bungled.net") by vger.kernel.org with ESMTP id S261454AbTFJSFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:05:12 -0400
Date: Tue, 10 Jun 2003 18:18:54 -0400
From: Nathan Conrad <conrad@bungled.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Oleg Drokin <green@namesys.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk
Message-ID: <20030610221854.GA6893@bungled.net>
References: <20030610214436.GA6719@bungled.net> <Pine.SOL.4.30.0306102001430.24343-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306102001430.24343-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oh, ok. I am using DMA on my drives. The problem with this bug is that
it is fairly hard to observe, I've only seen it about once every other
day. I should have also pointed out that I am using ext3.

I thought that it might be taskfile stuff because that was the major
change in the kernel the time right before I started to notice these
problems. There likely is some other source of problems because you
say that there should be no change in behaviour.

-Nathan

On Tue, Jun 10, 2003 at 08:11:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
>=20
> On Tue, 10 Jun 2003, Nathan Conrad wrote:
>=20
> > I've been noticing a similar problem on my laptop. This may, or may
> > not be related, but it did start somewhere within the past week (maybe
> > the IDE taskfile conversion???, to throw out a guess). I wonder if
>=20
> wrt taskfile conversion, if you are using DMA on your IDE disks,
> there shouldn't be any change in behaviour.
>=20
> I will prepare a patch adding old crap and making it selectable
> (default will be taskfile, if you go into problems you can check
> with old code) to easy spotting possible taskfile problems
> and allowing quick judging - taskfile guilty/not guilty.
>=20
> --
> Bartlomiej
>=20
> > Dave Jones is using IDE or SCSI. CONFIG_SMP and CONFIG_PREEMPT are
> > disabled on my machine (Sony Vaio PCG-FXA49 laptop, Athlon4). I'm
> > compiling the kernel with gcc 3.3 (Debian version).
> >
> > Anyway, certain directories get locked up on occasion and when I try
> > to execute 'ls' or read from the directory, the process gets into a
> > locked up state; ^C does not work to kill the process. The only way to
> > make a directory "readable" is to restart the machine. I have not
> > noticed any FS corruption, just the lack of being able to enter the
> > directory.
> >
> >  At the same time, a kernel bug will be displayed:
>=20
> <...>


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5llOzobaRZFwMRIRAm+dAJ4vN1XAj34cgHFafe2G/p8dqkDuuACcC8Ft
X3+LLoaC0729EOUlK+RrzSs=
=Y9Te
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
