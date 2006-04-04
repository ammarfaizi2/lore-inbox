Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWDDOPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWDDOPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDDOPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:15:14 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:35495 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932210AbWDDOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:15:12 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Issues with uli526x networking module
Date: Tue, 4 Apr 2006 16:15:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <200601260900.57951.prakash@punnoor.de> <200603281930.53859.prakash@punnoor.de> <200603290747.38402.ncunningham@cyclades.com>
In-Reply-To: <200603290747.38402.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1201403.fFoqaPSsLl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604041615.10749.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1201403.fFoqaPSsLl
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag M=E4rz 28 2006 23:47 schrieb Nigel Cunningham:
> Hi.
>
> On Wednesday 29 March 2006 03:30, Prakash Punnoor wrote:
> > Hi, I am just wondering whether you found out what the issue is with the
> > link problem. If you have some patch ready (even if it is hackish) I
> > would be happy to use it.
> >
> > Anyways, I know you are busy with swsusp2. ;-)
> >
> > Cheers,
>
> Yes, I do have a patch. It is hackish at the moment because as you've
> rightly guessed, I haven't gotten around to finishing it. It also doesn't
> work perfectly - I sometimes need to rmmod and insmod after booting a new
> kernel to get the link to come up. But, apart from that, it works fine.

Thx for sharing it. Unfortunately it doesn't help me. (I am not using suspe=
nd=20
or anything on that machine as it is supposed to be running 24/7.) After=20
pulling out the LAN cable and putting it back in. network is dead. The driv=
er=20
(even unpatched) sees the cable is back in, but obviously wrongly=20
reinitializes(?) the nic: Ie, kernel says after pluggin cable back in:

uli526x: eth0 NIC Link is Up 100 Mbps Full duplex

but network is dead.

I have to do:

ifconfig eth0 down
modprobe -r uli526x
modprobe uli526x
ifconfig eth0 up
dhclient

And then it works again.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1201403.fFoqaPSsLl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMn9uxU2n/+9+t5gRAp3HAKDRdZbU1aDoiO8aMtDvzsxIA+GvlACgvO6R
IPSJ8tka5Y9qz2bDslYiIUU=
=BGN+
-----END PGP SIGNATURE-----

--nextPart1201403.fFoqaPSsLl--
