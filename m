Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282881AbRK0JHg>; Tue, 27 Nov 2001 04:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282886AbRK0JH1>; Tue, 27 Nov 2001 04:07:27 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:63908 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S282881AbRK0JHN>;
	Tue, 27 Nov 2001 04:07:13 -0500
Date: Tue, 27 Nov 2001 11:10:22 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
Message-ID: <20011127111022.B881@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Didier Moens <Didier.Moens@dmb001.rug.ac.be>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> <3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy> <3C02BF41.1010303@xs4all.be> <20011127101148.C5778@crystal.2d3d.co.za> <3C034CAE.2090103@dmb.rug.ac.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C034CAE.2090103@dmb.rug.ac.be>; from Didier.Moens@dmb001.rug.ac.be on Tue, Nov 27, 2001 at 09:19:58 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.16 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 10:49am  up  1:35,  5 users,  load average: 1.17, 0.98, 0.59
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Didier!

I misunderstood. I thought you have an on-board 830M video card :P

So you have an 830M motherboard, with a Radeon display card?

> >
> >
> >     VideoRam "65536"
> >
>=20
> Are you sure about this ? I only have 32 MB.

As I said, I misunderstood. I thought you were using the i810 display driver
and I wanted to see what happens if you force the GART module to allocate
some additional system memory.

> Should this be tested with both patches ? I'm getting several=20
> suggestions about this problem : the possible permutations are=20
> augmenting, and I have some work to do too ... :)

If you have a Radeon display card and an 830M motherboard chipset, it might
be that the agpgart module is trying to use the 830M display chipset code.
that would definitely cause problems.

Before applying any patches, make sure that you have selected the following

[*]   Intel 440LX/BX/GX and I815/I830M/I840/I850 support

(i.e. CONFIG_AGP_INTEL=3Dy)

when compiling the kernel, but NOT!!!!! the following:

[ ]   Intel I810/I815/I830M (on-board) support

(i.e. CONFIG_AGP_I810=3Dn)

If the agpgart module then crashes when you load it, there is a bug and you
should send me/kernel mailinglist the oops.

As for display problems, you should ask on the dri-devel mailinglist which
is the proper place to post display driver bugs. (If it we're the i810
display driver I could help you)

--=20

Regards
 Abraham

Don't drink when you drive -- you might hit a bump and spill it.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A1h+zNXhP0RCUqMRAsmvAJ9oW8MO7E6vKsrqVOXmfPd7lYEJOACfdc+2
JiFZHltwhOrRZD8D4P/teM0=
=57FB
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
