Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUBBTC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUBBTC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:02:27 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:9863 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265763AbUBBTCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:02:24 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040202003922.3180E2C078@lists.samba.org>
References: <20040202003922.3180E2C078@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-87JFjVIm0sdwxOqfwguw"
Message-Id: <1075748550.6931.10.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 21:02:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-87JFjVIm0sdwxOqfwguw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-02 at 02:10, Rusty Russell wrote:
> In message <1075674718.27454.17.camel@nosferatu.lan> you write:
> > A quick question on module-init-tools/udev and module auto-loading ...
> > lets say I have a module called 'foo', that I want the kernel to
> > auto-load.
>=20
> The *idea* of udev et al is that the kernel finds the devices,
> /sbin/hotplug loads the driver etc.
>=20

Right.

> This does not cover the class of things which are entirely created by
> the driver (eg. dummy devices, socket families), so cannot be
> "detected".  Many of these (eg. socket families) can be handled by
> explicit request_module() in the core and MODULE_ALIAS in the driver.
> Some of them cannot at the moment: the first the kernel knows of them
> is an attempt to open the device.  Some variant of devfs would solve
> this.
>=20

I guess there will be cries of murder if 'somebody' suggested that if
a node in /dev is opened, but not there, the kernel can call
'modprobe -q /dev/foo' to load whatever alias there might have been?

Understand me correctly, I do not want devfs back.  I am just checking
if we could do something for similar behaviour.  I know it has not
_really_ hit the lists, but I have already had complaints about this
not being supported anymore.  I think the complaints will start even
more if raminitfs eventually hits functionality (as /dev will then be
then consisting only of loaded drivers (if I am not mistaken).

Once again I do not say we should give in to it, but it _does_ make
things easier.  So if there is a lightweight way to do this, then
great - and this is what I was trying to get discussion directed to.

> > Then a distant related issue - anybody thought about dynamic major
> > numbers of 2.7/2.8 (?) and the 'alias char-major-<whatever>-* whatever'
> > type modprobe rules (as the whole fact of them being dynamic, will make
> > that alias type worthless ...)?
>=20
> Yes.  This could be changed to probe by device name, not number
> though.  And most names can't be dynamic: /dev/null has certain, fixed
> semantics.
>=20
> The "I found this hardware, who will drive it?" mechanism of udev, and
> the "User asked for this, who will supply it?" mechanism of kmod have
> some overlap, but I think both will end up being required.
>=20

Ok, was just wondering.


Thanks,

--=20
Martin Schlemmer

--=-87JFjVIm0sdwxOqfwguw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHp7FqburzKaJYLYRAtQ0AJ9iJpLMNii+KWral0oN7oxyklAoOwCeMfHx
G1JT5LY4VLBm32ukyzKneVc=
=CFY8
-----END PGP SIGNATURE-----

--=-87JFjVIm0sdwxOqfwguw--

