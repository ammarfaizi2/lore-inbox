Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUALHjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 02:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUALHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 02:39:17 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:35769 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266072AbUALHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 02:39:15 -0500
Date: Sun, 11 Jan 2004 23:39:05 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: David Brownell <david-b@pacbell.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
Message-ID: <20040112073905.GA8580@one-eyed-alien.net>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk> <4001DB52.7030908@pacbell.net> <20040111233104.GF23039@one-eyed-alien.net> <40021E8E.3010709@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <40021E8E.3010709@pacbell.net>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2004 at 08:11:58PM -0800, David Brownell wrote:
>=20
> >>>	 Plus I'd
> >>>argue PF_MEMALLOC is a better solution anyway.
> >>
> >>It certainly seems like a more comprehensive fix for that
> >>particular class of problems!  :)
> >
> >
> >Is it really more comprehensive?  As I see it, it will only affect code
> >executed in the context of the usb-storage thread.  But, what about code
> >which is invoked in tasklets or other contexts?
>=20
> Isn't it true that only that thread is allowed to
> submit usb-storage i/o requests?

That's very true.

What I'm concerned about is the downstream effects of a usb_submit_urb() or
the corresponding scatter-gather equivalents.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You should try to see the techs say "three piece suit".
					-- The Chief
User Friendly, 11/23/1997

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAk8ZIjReC7bSPZARAuCqAKDDTBRL/5R6dzZj4r2SvB6SfI2S9wCgicKE
v8rAAPFP6ZIb58Em9nhUCis=
=jF5K
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
