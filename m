Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUBBTNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUBBTNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:13:40 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:11143 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265799AbUBBTNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:13:37 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20040202052100.GA21753@kroah.com>
References: <1075674718.27454.17.camel@nosferatu.lan>
	 <20040202052100.GA21753@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v/cqRKiWTHzc1afvDdSb"
Message-Id: <1075749221.6931.23.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 21:13:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v/cqRKiWTHzc1afvDdSb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-02 at 07:21, Greg KH wrote:
> On Mon, Feb 02, 2004 at 12:31:58AM +0200, Martin Schlemmer wrote:
> > Hi
> >=20
> > A quick question on module-init-tools/udev and module auto-loading ...
> > lets say I have a module called 'foo', that I want the kernel to
> > auto-load.
>=20
> Wait, stop right there.  When do you want the module autoloaded?
>=20
> If you want it loaded when the device is plugged in, then great, the
> hotplug scripts will do that.
>=20
> If you want the module loaded when you try to access the /dev node, then
> see the FAQ about udev for that :)
>=20

Whoa, stop the horses :)  I do not want to start another devfs/udev
argument 8)

As I said - this feature _does_ work of autoloading the module _if_
the device node and alias exists.  If the node is deleted however it
does not.  So this tells me there functionality is half way there,
and I was wondering if it could be completed without too much extra
overhead.

You can check the mail to Rusty for more what I mean (hopefully it
comes through correctly).

> > Then a distant related issue - anybody thought about dynamic major
> > numbers of 2.7/2.8 (?) and the 'alias char-major-<whatever>-* whatever'
> > type modprobe rules (as the whole fact of them being dynamic, will make
> > that alias type worthless ...)?
>=20
> Yes, it will make the char-major-* stuff worthless, however the distro
> I use has not used that style of alias for years, why would yours?  :)
>=20
> Rusty had it correct in that you need to try to load for the type of
> module:
> 	alias eth1 tulip
> 	alias usb-controller usb-ohci
> and so on.  That's the much better way.
>=20

Stupid question - is there a complete list of all these aliases?


Thanks,

--=20
Martin Schlemmer

--=-v/cqRKiWTHzc1afvDdSb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHqFlqburzKaJYLYRAkWEAKCRB7pn7eLakClrJDoFt32QY2U2pQCfRE7A
IfWN/ihxf01PN58BR8FLAcs=
=DrGS
-----END PGP SIGNATURE-----

--=-v/cqRKiWTHzc1afvDdSb--

