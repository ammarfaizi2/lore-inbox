Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSBMU1I>; Wed, 13 Feb 2002 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSBMU07>; Wed, 13 Feb 2002 15:26:59 -0500
Received: from hal.astro.umn.edu ([128.101.221.100]:15273 "EHLO astro.umn.edu")
	by vger.kernel.org with ESMTP id <S288855AbSBMU0v>;
	Wed, 13 Feb 2002 15:26:51 -0500
Date: Wed, 13 Feb 2002 14:26:46 -0600
From: kelley eicher <carde@astro.umn.edu>
To: Rik Faith <faith@alephnull.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi abort 0x2002 and eth0: too much work on a dual amd 760mpx system
Message-ID: <20020213142646.F12947@astro.umn.edu>
In-Reply-To: <15466.45319.699865.592862@photon.alephnull.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15466.45319.699865.592862@photon.alephnull.com>; from faith@alephnull.com on Wed, Feb 13, 2002 at 01:31:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

rik-

i have done extensive cpu load + i/o testing on the 760mp machine. it handl=
es
perfectly under very high cpu activity. one thing i should mention though is
that neither of these chipsets, amd 760mp and amd760mpx, work with multi-
processor specification 1.4 under linux. i had several problems using m.p.s.
1.4 on the 760mp in dual processor mode and the 760mpx wouldn't even boot
with m.p.s. 1.4 enabled.

as an fyi to anyone listening, the 760mpx crashed while loading any smp lin=
ux
kernel during apic timer calibration.

so my suggestion rik, if you haven't done this already, is to change the
multi- processor specification in your bios from 1.4 to 1.1.

-kelley


On Wed, Feb 13, 2002 at 01:31:35PM -0500, Rik Faith wrote:
> I'm seeing possibly related problems with a 760MP board (Tyan Tiger MP)
> and 3ware adapters.  I can very reproduce the problem if I run two
> instances of burnK7 (from cpuburn: http://users.ev1.net/~redelm/) and
> then do an I/O operation.  Due to what I think is a bug in the 3ware
> code, however, my machine locks hard during the SCSI reset.  Could you
> try burnK7 (the idea is to load the CPUs -- not to heat them up) and see
> if your problem gets worse?
>=20
> I was hoping to "fix" my problem by getting a AMD-760MPX MB from Asus,
> but I'm no longer sure that's a good idea.  I'm currently running Linux
> with maxcpus=3D1 on the boot prompt -- the system seems very stable when
> only one CPU is being used -- have you tried that?
>=20
> The general problem may be that an interrupt gets lost, but I'd like to
> get more evidence that leads to that conclusion.  Thanks, Rik.
>=20
>=20
> BTW, I use:
>     while :; do date; strace fdisk -l /dev/sda; uptime; echo; sleep 5; do=
ne
>=20
> and then look for a stall at "read(4," when I start the second burnK7.
> If I kill both burnK7's quick enough, the 3ware card will recover --
> otherwise, the machine locks.

--=20

 >> kelley j eicher
<<  UNIX architect
 >> Univ. of MN Astronomy Dept.
<<  ph: (612) 626-2067 or (612) 624-3589
 >> fx: (612) 626-2029
<<  office: 385 physics
 >> carde at astro dot umn dot edu

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8aswGF3O5KT+A1xQRAmE3AJ9k1JR5eFollJvFIIAwgmdgg1uCbACcDl3q
adVQoTOt/c0TQJdLqhdpcdY=
=a4lY
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
