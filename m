Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272783AbTHENkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272784AbTHENkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:40:01 -0400
Received: from [24.241.190.29] ([24.241.190.29]:48019 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S272783AbTHENjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:39:51 -0400
Date: Tue, 5 Aug 2003 09:39:40 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
Message-ID: <20030805133940.GN13456@rdlg.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030805122354.GL13456@rdlg.net> <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UOYwgDhKKQYesrzQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UOYwgDhKKQYesrzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Zwane Mwaikambo (zwane@arm.linux.org.uk):

> On Tue, 5 Aug 2003, Robert L. Harris wrote:
>=20
> > Unable to handle kernel paging request at virtual address 8011c560
> >  printing eip:
> > 8011c560
> > *pde =3D 00000000
> > Oops: 0000
> > CPU:    1
> > EIP:    0010:[<8011c560>]    Not tainted
> > EFLAGS: 00010286
> > eax: 8011c560   ebx: c037f754   ecx: 00000040   edx: c0357980
> > esi: 00000040   edi: c037f740   ebp: c037ef40   esp: c1e19f28
> > ds: 0018   es: 0018   ss: 0018
> > Process swapper (pid: 0, stackpage=3Dc1e19000)
> > Stack: c011c47d 00000001 c0358180 00000001 fffffffe 00000040 c011c1ff c=
0358180=20
> >        c037ef40 c0351800 00000000 c1e19f74 00000046 c0108bdb c0105400 c=
1e18000=20
> >        c0105400 00000040 c02f5b44 00000000 c010ae78 c0105400 c1e18000 c=
1e18000=20
> > Call Trace: [<c011c47d>] [<c011c1ff>] [<c0108bdb>] [<c0105400>] [<c0105=
400>]=20
> >    [<c010ae78>] [<c0105400>] [<c0105400>] [<c010542c>] [<c01054a2>] [<c=
0117e7f>]=20
> >    [<c0117d8e>]=20
> >=20
> > Code:  Bad EIP value.
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
>=20
> Could have been someone removing a module without unregistering an=20
> interrupt handler. But that's just guessing.
>=20
> > Can someone please tell me what this means or how to figure it out?  The
> > machine is offline for the next 12 hours unfortunately due to lack of
> > remote help.  I do have similar machines with the same kernel/hardware
> > if I need to run any commands against this output.  I don't have access
> > to any specific files on the machine though.
>=20
> You don't specify which kernel this is, it appears to be 2.4 something.=
=20
> Please run this through ksymoops (man ksymoops)
>=20
> --=20
> function.linuxpower.ca


This is 2.4.18 with the 2.6.5 i2c modules.  The only modules enabled are
for the i2c and everything else is compiled in static.  There was no-one
on the box the times when it went down and no messages about modules=20
being messed with either.  I have about 30 of the servers out in the
wild all 99.9% identicle and there is only 1 having this issue which is
why my first thought it hardware.

This week I'm upgrading the puppies to 2.4.21-ac4 with the 2.8 i2c.

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--UOYwgDhKKQYesrzQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/L7Oc8+1vMONE2jsRAjR+AJ0Sq8/CsML+iIGdJEB+dM/yt2QEywCgoMYo
V81iubi1IA0Y46RoZ3znq/U=
=vBD4
-----END PGP SIGNATURE-----

--UOYwgDhKKQYesrzQ--
