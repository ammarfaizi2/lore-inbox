Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTKNTWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTKNTWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:22:13 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:61704 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S264496AbTKNTWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:22:11 -0500
Date: Fri, 14 Nov 2003 20:21:36 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 / EXT3-fs warning...ext3_unlink: Deleting nonexistent file
Message-ID: <20031114192136.GB5594@paradigm.rfc822.org>
References: <20031114174254.GA5594@paradigm.rfc822.org> <20031114105724.D11847@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20031114105724.D11847@schatzie.adilger.int>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2003 at 10:57:24AM -0700, Andreas Dilger wrote:
> On Nov 14, 2003  18:42 +0100, Florian Lohoff wrote:
> > i seem to have experienced some ext3 inconsistencys - After some reboots
> > today i was wondering why cron wasnt running and discovered that
> > starting cron failed because /var/run/crond.pid could not be written.
> > ls did not show and file under that name. touch showed i/o error on that
> > file although other file in that directory could be touched.
> >=20
> > When i tried to rm crond.pid this showed up:
> >=20
> > EXT3-fs warning (device hda8): ext3_unlink: Deleting nonexistent file (=
107669), 0
> >=20
> > After that i could touch the file again and crond did not refuse to sta=
rt anymore.
>=20
> This sounds like the htree "get back deleted entry on directory split" bug
> that was fixed months ago in 2.6 htree, but not in any 2.4 patches.  Did
> you test htree on this system under 2.4 recently?

Nope - I have turned dir_index on on the /tmp filesystem - nowhere else.=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/tStAUaz2rXW+gJcRAmtkAJ95kAV3KkIbdBIRGHcd2CfBEEv2ZQCdFctQ
rB2ph+XlBeZOREw/i2mLNmE=
=Jb3b
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
