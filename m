Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUGHQfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUGHQfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUGHQfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:35:14 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:18119 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264002AbUGHQfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:35:01 -0400
Subject: Re: window tracking firewall involved, was: Re: preliminary
	conclusions regarding window size issues
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "David S. Miller" <davem@redhat.com>
Cc: bert hubert <ahu@ds9a.nl>, jamie@shareable.org, shemminger@osdl.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ALESSANDRO.SUARDI@ORACLE.COM
In-Reply-To: <20040708083708.5f63bc71.davem@redhat.com>
References: <20040707232757.GA14471@outpost.ds9a.nl>
	 <20040708014443.GE17266@mail.shareable.org>
	 <20040708060326.GA22258@outpost.ds9a.nl>
	 <20040708063700.GA23496@outpost.ds9a.nl>
	 <20040708083708.5f63bc71.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8d09E3ns7FktNIp5ICAo"
Message-Id: <1089304497.2588.12.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Jul 2004 18:34:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8d09E3ns7FktNIp5ICAo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-08 at 17:37, David S. Miller wrote:

> > This has now been confirmed with the packages.gentoo.org firewall!
>=20
> It's the netfilter patches added to the gentoo WOLK kernel running
> on packages.gentoo.org
>=20
> Specifically, it's the tcp-window-tracking patch from netfilter's
> patch-o-matic.  There's some bug in there wrt. it's window scaling
> support.
>=20
> I bet if the tcp-window-scaling diff is removed from the kernel running
> there, the problem will totally go away.
>=20
> I note that it is using a very old version of the tcp-window-tracking
> patch, the current version is 2.2 and probably fixes this bug.  The
> gentoo linux-2.4.20-wolk-4.14 kernel is using version 1.7

That bug was probably fixed May 21 2003 according to cvs history.
"Patch updated: window scaling bug fixed, improved, etc. (JK)."
It updates the version to 1.9

As reference, I'm using v2.2 with -bk from 040626 which does use
wscale=3D7 and I don't see any problems connecting to/from machines with
lower or equal wscale. I drop and log all packets tcp-window-tracking
classifies as INVALID.

--=20
/Martin

--=-8d09E3ns7FktNIp5ICAo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7XexWm2vlfa207ERAhsZAKC7uBD+jwCHfMcQH4HXu4gTpMqghACfat5M
BKR138LZyBmozfPJc2s/eq4=
=xXsk
-----END PGP SIGNATURE-----

--=-8d09E3ns7FktNIp5ICAo--
