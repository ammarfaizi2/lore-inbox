Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUC0WxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUC0WxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:53:18 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:45207 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261913AbUC0WxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:53:06 -0500
Date: Sat, 27 Mar 2004 14:52:58 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org, Linux SCSI list <linux-scsi@vger.kernel.org>,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>
Subject: Re: Can't eject jaz disk on 2.6
Message-ID: <20040327225258.GB5203@one-eyed-alien.net>
Mail-Followup-To: Wakko Warner <wakko@animx.eu.org>,
	linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	USB Storage List <usb-storage@lists.one-eyed-alien.net>
References: <20040327075918.A2232@animx.eu.org> <20040327224222.GA5203@one-eyed-alien.net> <20040327180018.A4269@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20040327180018.A4269@animx.eu.org>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 27, 2004 at 06:00:18PM -0500, Wakko Warner wrote:
> > > I've used 2.6.0 to 2.6.4 on a computer with a jaz drive.
> > > Using eject 2.0.13, I'm unable to eject the disk.  I have tested on 2=
.4.24
> > > and it does eject.
> >=20
> > Over on the usb-storage list, we've just become aware of a similar prob=
lem.
>=20
> What was it with?

The device in question there was an Iomega USB Zip 100 drive.

> > Are you using SCSI or IDE?
>=20
> SCSI.  I thought all JAZ disks were scsi?

I wasn't sure.  USB is emulated through the SCSI layer, tho.  I would
recommend we take this discussion to the linux-scsi mailing list.

> > We've actually recorded the SCSI layer sending us a PREVENT_MEDIUM_REMO=
VAL,
> > then a START_STOP (to actually eject), and then an ALLOW_MEDIUM_REMOVAL.
> > So, nothing gets ejected.  This is under 2.6.
>=20
> I have noticed that when I attempt to eject, it spins the disk backup,
> spins down and that's it.

The user of the Zip 100 actually sent us logs showing this behavior.  We
assume it's coming from the SCSI system, as usb-storage doesn't contain
anything remotely resembling this....

Repeated uses of the 'eject' command generated the same sequence in his
test scenario, but his Zip 100 actually ejected the media on the second
try.  I think that's a device-dependent behavior, tho.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I say, what are all those naked people doing?
					-- Big client to Stef
User Friendly, 12/14/1997

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAZgXKIjReC7bSPZARAvxOAJ9SQmLIiWeiwlYFT10hTBXs4kovyACeNZM8
19Y4H8CW7EbJE/DqE2JELbI=
=yCb+
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
