Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUBCEzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUBCEzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:55:11 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:1928 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265800AbUBCEzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:55:06 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203010224.4CF742C261@lists.samba.org>
References: <20040203010224.4CF742C261@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4miKPi6ysPpuCzwAtpNb"
Message-Id: <1075784114.6931.138.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 06:55:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4miKPi6ysPpuCzwAtpNb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 02:55, Rusty Russell wrote:
> In message <1075748550.6931.10.camel@nosferatu.lan> you write:
> > > This does not cover the class of things which are entirely created by
> > > the driver (eg. dummy devices, socket families), so cannot be
> > > "detected".  Many of these (eg. socket families) can be handled by
> > > explicit request_module() in the core and MODULE_ALIAS in the driver.
> > > Some of them cannot at the moment: the first the kernel knows of them
> > > is an attempt to open the device.  Some variant of devfs would solve
> > > this.
> > >=20
> >=20
> > I guess there will be cries of murder if 'somebody' suggested that if
> > a node in /dev is opened, but not there, the kernel can call
> > 'modprobe -q /dev/foo' to load whatever alias there might have been?
>=20
> I think it's an excellent idea, although ideally we would have this
> mechanism in userspace as much as possible.  Anything from some
> special hack to block -ENOENT on directory lookups and notify an fd,
> to some exotic overlay filesystem.
>=20

I was thinking of just delaying the failure or such, depending on the
modprobe outcome.  Should not be much if any overhead, although I have
not looked at the code.


--=20
Martin Schlemmer

--=-4miKPi6ysPpuCzwAtpNb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHymyqburzKaJYLYRAttZAJsGDHN/rbgVSATGMuGKzGJBSgw/zgCeKVVC
bnagnrDTxvEkFXHqQyy9UJM=
=cquk
-----END PGP SIGNATURE-----

--=-4miKPi6ysPpuCzwAtpNb--

