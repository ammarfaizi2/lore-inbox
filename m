Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270449AbTGaQY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTGaQY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:24:26 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2965 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S270449AbTGaQYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:24:24 -0400
Date: Thu, 31 Jul 2003 18:24:23 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731162423.GC1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local> <20030731150758.GE6410@mail.jlokier.co.uk> <Pine.LNX.4.53.0307311126530.770@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VEG93Z8xfWyRDB6c"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307311126530.770@chaos>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VEG93Z8xfWyRDB6c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 11:50:27 -0400, Richard B. Johnson <root@chaos.analogic.=
com>
wrote in message <Pine.LNX.4.53.0307311126530.770@chaos>:
> On Thu, 31 Jul 2003, Jamie Lokier wrote:
> > Willy Tarreau wrote:

> The bad op-code for the i386 is cmpxchg. This is what triggers
> the trap. This can be emulated, although the emulation is
> not SMP compatible. You worry about this when somebody makes
> a dual '386 machine ;^).  Also, the best performing emulation
> for any op-codes should be done within the kernel. That way,
> the invalid-opcode trap works just like the math emulator. You
> don't need the overhead of calling a user-mode handler. If
> this is emulation is implimented, then one should also emulate
> BSWAP and XADD. This makes '486 code compatible with '386
> machines.

Thanks for this fine explanation! Maybe I'd take the 2.4.x emulator
kernel patch and bring it in line with 2.6.x?

However, that doesn't release gcc's developers from providing a solution
to the initial problem (i386 and i486 compiled libs/programs
incompatible) from the task to work on libstdc++ :->

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--VEG93Z8xfWyRDB6c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KUK3Hb1edYOZ4bsRAux6AJ0SZ8iBdXeiH19lNPtCXaIVMOlbOQCeM7yy
SB/n8LJHiKnCN4gFb/3jwWM=
=r/1I
-----END PGP SIGNATURE-----

--VEG93Z8xfWyRDB6c--
