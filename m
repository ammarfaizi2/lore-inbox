Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbULTIUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbULTIUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULTITm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:19:42 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:5801 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261327AbULTILC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:11:02 -0500
Date: Mon, 20 Dec 2004 00:09:51 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220080951.GA24728@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de> <20041219205104.5054a156@lembas.zaitcev.lan> <41C65EA0.7020805@osdl.org> <20041220062055.GA22120@one-eyed-alien.net> <20041219223723.3e861fc5@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20041219223723.3e861fc5@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 19, 2004 at 10:37:23PM -0800, Pete Zaitcev wrote:
> On Sun, 19 Dec 2004 22:20:55 -0800, Matthew Dharm <mdharm-kernel@one-eyed=
-alien.net> wrote:
>=20
> > I can tell you that this has turned into the single largest source of b=
ug
> > reports/complaints about usb-storage.  Something has to be done.  I just
> > don't know what.
>=20
> Is it that bad, really? Honestly, I could not imagine users can be so dum=
b.

'There are more things in Heaven and Earth, Horatio...."

Yes, users can be so dumb.  Commonly, the exchange goes like this:

USER: My device used to work in 2.6.7, and now it's busted.
US: Please turn on debugging and send us the logs.
USER: (sends dmesg which shows ub in use)
US: Turn off CONFIG_BLK_DEV_UB
USER: It works!  You should make it more clear that UB breaks things...

And that's the optimal case.  Often times they cut the dmesg so we can't
see what's wrong.  And this usually takes 3 days for the entire exchange.

> The option defaults to off. There is a warning in the Kconfig. And yet th=
ey
> first enable it and then complain about it. I don't know what to do about
> it, either.

The best idea I have is to hide CONFIG_BLK_DEV_UB behind
CONFIG_EXPERIMENTAL.

The next-best idea I have is to make UB print out some sort of warning
message at startup.

Neither of these ideas is very good, I'll admit.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A:  The most ironic oxymoron wins ...
DP: "Microsoft Works"
A:  Uh, okay, you win.
					-- A.J. & Dust Puppy
User Friendly, 1/18/1998

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBxojPIjReC7bSPZARAkcMAKC7z7RNYoTNQ8bWWrq+Q41nXptwmACeM0Ae
ociUVCTqOuwXTbSfQYB+52U=
=/IhF
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
