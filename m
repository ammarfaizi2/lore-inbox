Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284983AbRLKN4o>; Tue, 11 Dec 2001 08:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRLKN4f>; Tue, 11 Dec 2001 08:56:35 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:53121 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S284983AbRLKN4V>;
	Tue, 11 Dec 2001 08:56:21 -0500
Date: Tue, 11 Dec 2001 15:59:22 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211155922.B1863@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <3C151F7B.44125B1@zip.com.au>, <3C151F7B.44125B1@zip.com.au>; <20011211011158.A4801@athlon.random> <3C15B0B3.1399043B@zip.com.au> <20011211144223.E4801@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211144223.E4801@athlon.random>; from andrea@suse.de on Tue, Dec 11, 2001 at 14:42:23 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 3:46pm  up 1 day,  6:27,  5 users,  load average: 0.00, 0.00, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrea!

> > > > In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_ot=
hers().
> > > > So we're madly trying to swap pages out and finding that there's no=
 swap
> > > > space.  I beleive that when we find there's no swap left we should =
move
> > > > the page onto the active list so we don't keep rescanning it pointl=
essly.
> > >=20
> > > yes, however I think the swap-flood with no swap isn't a very
> > > interesting case to optimize.
> >=20
> > Running swapless is a valid configuration, and the kernel is doing
>=20
> I'm not saying it's not valid or non interesting.
>=20
> It's the mix "I'm running out of memory and I'm swapless" that is the
> case not interesting to optimize.
>=20
> If you're swapless it means you've enough memory and that you're not
> running out of swap. Otherwise _you_ (not the kernel) are wrong not
> having swap.

The problem is that your VM is unnecesarily eating up memory and then wants
swap. That is unacceptable. Having 90% of your memory in buffers/cache and
then the OOM killer kicks in because nothing is free is what we're moaning
about.

--=20

Regards
 Abraham

Did you hear about the model who sat on a broken bottle and cut a nice figu=
re?

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--gj572EiMnwbLXET9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FhE6zNXhP0RCUqMRAns7AJsGxGbvfBQWYhczukfxAXnvvUva8wCfTtDq
p/ghaIxiJDCJFI/RadFFTb4=
=V6PV
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
