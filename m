Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVKVIw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVKVIw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVKVIw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:52:57 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:63971 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S1751274AbVKVIw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:52:56 -0500
Date: Tue, 22 Nov 2005 08:52:34 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, blaisorblade@yahoo.it,
       davej@codemonkey.org.uk, davej@redhat.com
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051122085234.GA2487@inskipp.digriz.org.uk>
References: <20051121181722.GA2599@inskipp.digriz.org.uk> <Pine.LNX.4.63.0511220102330.18504@deepthought.mydomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511220102330.18504@deepthought.mydomain>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morning Ken,

Ken Moffat <zarniwhoop@ntlworld.com> [20051122 01:21:18 +0000]:
>
> On Mon, 21 Nov 2005, Alexander Clouter wrote:
>=20
> >The use of the 'ignore_nice' sysfs file is confusing to anyone using it.=
=20
> >This removes the sysfs file 'ignore_nice' and in its place creates a=20
> >'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes=
=20
> >are not counted towards the 'business' calculation.
> >
> >WARNING: this obvious breaks any userland tools that expected ignore_nic=
e'=20
> >to exist, to draw attention to this fact it was concluded on the mailing=
=20
> >list that the entry should be removed altogether so the userland app=20
> >breaks and so the author can build simple to detect workaround.  Having=
=20
> >said that it seems currently very few tools even make use of this=20
> >functionality; all I could find was a Gentoo Wiki entry.
> >
> >Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>
> >
>=20
>  Great.  I get to rewrite my initscript for the ondemand governor to=20
> test for yet another kernel version, and write a 0 to yet another sysfs=
=20
> file, just so that any compile I start in an xterm on my desktop box can=
=20
> make the processor work for its living.
>=20
>  Just what have you cpufreq guys got against nice'd processes ?  It's=20
> enough to drive a man to powernowd ;)
>=20
Con complained about that one too, rightly so.  If you look more recently y=
ou=20
will see that the default is actually now '0' so nice'd processes do count=
=20
towards the business calculation....I guess I could submit *another* more o=
r=20
less duplicate patch to really confuse things to rename the sysfs entry aga=
in=20
and it to expect a huge prime number to ignore nice'd processes ;)

Guess you can go back to your initscript and remove that entry :P

Cheers

Alex

> Ken
> --
>  das eine Mal als Trag=F6die, das andere Mal als Farce


--=20
 _________________________________
< Absence makes the heart forget. >
 ---------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDgtxSNv5Ugh/sRBYRAqi5AJ9p3hqSrlroe3tmk8ZeOd07l1jlhwCfYyfz
Yi63N0XzWFRJb6O/3xXmgcs=
=rS9R
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
