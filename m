Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUAKXbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUAKXbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:31:16 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:46263 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266018AbUAKXbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:31:12 -0500
Date: Sun, 11 Jan 2004 15:31:04 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: David Brownell <david-b@pacbell.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
Message-ID: <20040111233104.GF23039@one-eyed-alien.net>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk> <4001DB52.7030908@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <4001DB52.7030908@pacbell.net>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2004 at 03:25:06PM -0800, David Brownell wrote:
> Alan Cox wrote:
> >On Sul, 2004-01-11 at 00:23, Matthew Dharm wrote:
> >
> >>Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all tho=
se
> >>down and eliminated them.
> >
> >
> >Not sure. I just worked from tracebacks. I needed it to work rather
> >than having the time to go hunting for specific faults. Plus I'd
> >argue PF_MEMALLOC is a better solution anyway.
>=20
> It certainly seems like a more comprehensive fix for that
> particular class of problems!  :)

Is it really more comprehensive?  As I see it, it will only affect code
executed in the context of the usb-storage thread.  But, what about code
which is invoked in tasklets or other contexts?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm just trying to think of a way to say "up yours" without getting fired.
					-- Stef
User Friendly, 10/8/1998

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAdy4IjReC7bSPZARAmXCAJ9TGk44TuYbl6Y+PHArVUONVIodsACgvSZN
YHzDCzjB3MwuF3pVRsu7tfE=
=IZbK
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
