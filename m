Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTLYV7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTLYV7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 16:59:48 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:32224 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264371AbTLYV7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 16:59:45 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Andreas Jellinghaus <aj@dungeon.inka.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <176520000.1072385840@[10.10.2.4]>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur>
	 <20031223163904.A8589@infradead.org>
	 <pan.2003.12.25.17.47.43.603779@dungeon.inka.de>
	 <20031225184553.A25397@infradead.org>
	 <1072381287.7638.52.camel@nosferatu.lan> <176520000.1072385840@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m/9Qe6RunSpriESjXlNI"
Message-Id: <1072389557.7638.98.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 00:02:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m/9Qe6RunSpriESjXlNI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-25 at 22:57, Martin J. Bligh wrote:
> >> > On Tue, 23 Dec 2003 16:47:44 +0000, Christoph Hellwig wrote:
> >> > > I disagree. For fully static devices like the mem devices the udev
> >> > > indirection is completely superflous.
> >> >=20
> >> > If sysfs does not contain data on mem devices, we will need makedev.
> >> >=20
> >> > devfs did replace makedev. until udev can create all devices,
> >> > it would need to re-introduce makedev.
> >>=20
> >> So what?
> >>=20
> >=20
> > So maybe suggest an solution rather than shooting one down all the
> > time (which do seem logical, and is only apposed by one person currentl=
y
> > - namely you =3D).
>=20
> Nah, most of us just trust Christoph to fight the good fight for us ;-)
>=20

heh =3D)

> I for one certainly agree with him that for static stuff, we don't need=20
> (or want) udev. For inherently hotplug stuff like USB cameras, or large=20
> SCSI raid arrays, it's nice, but not for basic things like mem devices=20
> and the disk devices I'm booting from - it's just added complexity.
>=20

Well, its inclusion do not mean you have to use it - you have to
physically walk all the classes in /sys to get udev to create the nodes,
as they are already there when booted.  And as the code is only a few
lines for each device, it is not much overhead to get:

1) a full sysfs tree of all physical and 'virtual' (?) devices.

2) Optional feature to generate /dev with one simple script for those
   that want it, which should be the less complex option at initramfs
   time.

> If it works as is, don't screw with it.
>=20

With an already populated /dev, sure :/


Thanks,

--=20
Martin Schlemmer

--=-m/9Qe6RunSpriESjXlNI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6121qburzKaJYLYRArxGAJ4zPsuK3DgyOO8BCbMnSi/N+aXPDgCeKB5y
tovyCcgbGtYB/ZMFoMKU39s=
=N28O
-----END PGP SIGNATURE-----

--=-m/9Qe6RunSpriESjXlNI--

