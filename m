Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVLTFF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVLTFF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 00:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVLTFF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 00:05:58 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:39054 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1750797AbVLTFF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 00:05:58 -0500
Date: Mon, 19 Dec 2005 21:05:23 -0800
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Wakko Warner <wakko@animx.eu.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220050523.GA26960@one-eyed-alien.net>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Wakko Warner <wakko@animx.eu.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1135047119.8407.24.camel@leatherman> <20051220035122.GA7233@animx.eu.org> <1135050558.8407.36.camel@leatherman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1135050558.8407.36.camel@leatherman>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2005 at 07:49:18PM -0800, john stultz wrote:
> On Mon, 2005-12-19 at 22:51 -0500, Wakko Warner wrote:
> > john stultz wrote:
> > > All,
> > > 	I'm getting a little tired of my roommates not knowing how to safely
> > > eject their usb-flash disks from my system and I'd personally like it=
 if
> >=20
> > What exactly is ejecting flash media?
> >=20
> > I have USB hard disks, USB Flash sticks, USB DVD-RAM, and an Ipod.  The=
 only
> > one that even needs eject is the DVDRam.  IIRC, ALLOW_MEDIUM_MREMOVAL i=
s for
> > CD-Rom (and possibly tape).  If the device is not in use, there's no re=
ason
> > it cannot be unplugged then.  (Not in use as in not mounted, and noone's
> > accessing the raw device).
>=20
> Again, I'm not much of a SCSI person, so you might be right here.
> However, ejecting scsi devices, like firewire or usb disks, tends to
> spin the devices down. This, to my understanding, allows for safe
> removal (ipods stop flashing the "do not remove" message).=20

It turns out that a lot of USB devices look for ALLOW_MEDIUM_REMOVAL for
various purposes, including flushing internal buffer-cache.  Several CF
readers do this, some "fixed" flash drives do this, etc.

Also, things like the iPod and others (and this group overlaps with the
aforementioned types of devices) give the user a visible indication that
_this_particular_ unit is ready to be removed.

> On USB flash disks, I'd hope umounting the device would suffice in
> flushing out any writes, but it seems quite a bit of writing can go on
> when the eject command is issued. It might be I'm just being paranoid,
> but I've always ejected flash drives as well just to be sure.

The eject shouldn't flush anything from the kernel-level, but it won't
complete until the device's internal buffers are flushed.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

E:  You run this ship with Windows?!  YOU IDIOT!
L:  Give me a break, it came bundled with the computer!
					-- ESR and Lan Solaris
User Friendly, 12/8/1998

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDp5ETHL9iwnUZqnkRAgHoAJ9ECvYGDNMq/Uv8NK85Zp3gOpIL7ACgo55n
3z0nE1qAGK0SPfdGlaryvZ4=
=Utwy
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
