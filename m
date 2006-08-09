Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWHISlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWHISlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWHISlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:41:37 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:49310 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S1751312AbWHISlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:41:36 -0400
From: Mws <mws@twisted-brains.org>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: ext3 corruption
Date: Wed, 9 Aug 2006 20:41:25 +0200
User-Agent: KMail/1.9.4
Cc: "Michael Loftis" <mloftis@wgops.com>, linux-kernel@vger.kernel.org
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com> <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com> <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
In-Reply-To: <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2991082.R8XoNIMgl5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608092041.31359.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2991082.R8XoNIMgl5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 August 2006 20:28, Molle Bestefich wrote:
> Michael Loftis wrote:
> > > Is there no intelligent ordering of
> > > shutdown events in Linux at all?
> >
> > The kernel doesn't perform those, your distro's init scripts do that.
>=20
> Right.  It's all just "Linux" to me ;-).
>=20
> (Maybe the kernel SHOULD coordinate it somehow,
>  seems like some of the distros are doing a pretty bad job as is.)
>=20
> > And various distros have various success at doing the right thing.  I'v=
e had
> > the best luck with Debian and Ubuntu doing this in the right order.  RH
> > seems to insist on turning off the network then network services such as
> > sshd.
>=20
> Seems things are worse than that.  Seems like it actually kills the
> block device before it has successfully (or forcefully) unmounted the
> filesystems.  Thus the killing must also be before stopping Samba,
> since that's what was (always is) holding the filesystem.
>=20
> It's indeed a redhat, though - Red Hat Linux release 9 (Shrike).
>=20
> > > Samba was serving files to remote computers and had no desire to let
> > > go of the filesystem while still running.  After 5 seconds or so,
> > > Linux just shutdown the MD device with the filesystem still mounted.
> >
> > The kernel probably didn't do this, usually by the time the kernel gets=
 to
> > this point init has already sent kills to everything.  If it hasn't it
> > points to problems with your init scripts, not the kernel.
>=20
> Ok, so LKML is not appropriate for the init script issue.
> Never mind that, I'll just try another distro when time comes.
>=20
> I'd really like to know what the "Block bitmap for group not in group"
> message means (block bitmap is pretty self explanatory, but what's a
> group?).
>=20
> And what will e2fsck do to my dear filesystem if I let it have a go at it?
> -
hi,=20
what i am missing is a kind of information, what type of pc you own/use.

i personally builded a new one the last few days and also encountered
problems with ext3.

i do own a amd64 x2 5000+ with asus m2n32 ws pro motherboard.

i yesterday changed my root partition from ext3 to xfs and my problems
went away. so imho there might be some issues in having 64 bit systems,
dual processor and ext3 in combination.

kernel is 2.6.17

behaviour was like:=20
filesystem became corrupted due to uncommitted transactions, resulting=20
in manually "fsck" checking the partition, loads of errors i did correct, b=
ut
a lot of files got corrupted. i didn't check if the sata attached drives wo=
uld also
fail on ext3 cause i had them already prepared for xfs.

regards
marcel





--nextPart2991082.R8XoNIMgl5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE2ixbPpA+SyJsko8RAvYXAKCXwQK+cUP93sGw6w4T+c038FS7DQCaA4Jg
HwtfoLA3Vt3rI4tAIhmyNP8=
=sSla
-----END PGP SIGNATURE-----

--nextPart2991082.R8XoNIMgl5--
