Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbULTHox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbULTHox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbULTHoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:44:24 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:45222 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261463AbULTGWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:22:12 -0500
Date: Sun, 19 Dec 2004 22:20:55 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220062055.GA22120@one-eyed-alien.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Pete Zaitcev <zaitcev@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de> <20041219205104.5054a156@lembas.zaitcev.lan> <41C65EA0.7020805@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <41C65EA0.7020805@osdl.org>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 19, 2004 at 09:09:52PM -0800, Randy.Dunlap wrote:
> Pete Zaitcev wrote:
> >On Mon, 20 Dec 2004 02:35:42 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> >
> >
> >>What about a dependency of BLK_DEV_UB on USB_STORAGE=3Dn ?
> >
> >
> >I have them both as 'm' in my configuration, works like a charm.
>=20
> ub can work like that, but it makes it darned difficult to
> use usb-storage like that.  ub wants to bind to the devices,
> not usb-storage, and if ub is unloaded, usb-storage doesn't
> bind to them.  at least that's been my experience with it.

Enabling CONFIG_BLK_DEV_UB actually disables usb-storage from attaching to
certain devices, regardless of what's loaded or not.

I, personally, don't like this.  But I wasn't consulted on that particular
feature.  I'm given to understand that some bad things can happen when two
drivers can bind to the same device, but I haven't had time to experiment
with it.

I can tell you that this has turned into the single largest source of bug
reports/complaints about usb-storage.  Something has to be done.  I just
don't know what.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  They kicked your ass, didn't they?
S:  They were cheating!
					-- The Chief and Stef
User Friendly, 11/19/1997

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBxm9HIjReC7bSPZARAn3dAJ9bnwqnUYKOEQjmyRsFN8qm0J+OQwCg1RlV
DWANElc3iinMFuzm9inUT68=
=RlUZ
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
