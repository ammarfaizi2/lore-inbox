Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVFTLtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVFTLtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFTLtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:49:47 -0400
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:2975 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261201AbVFTLto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:49:44 -0400
Subject: Re: [linux-usb-devel] usbnet ethernet duplex issue?
From: David Hollis <dhollis@davehollis.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <dbrownell@users.sourceforge.net>
In-Reply-To: <20050617192715.GK27572@waste.org>
References: <20050617192715.GK27572@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CUUSbnz5WkV3Hr987zjb"
Date: Mon, 20 Jun 2005 07:47:56 -0400
Message-Id: <1119268076.19570.7.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CUUSbnz5WkV3Hr987zjb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-17 at 12:27 -0700, Matt Mackall wrote:=20
> I'm experimenting with a Netgear FA-120 USB 2.0 to Ethernet device and
> seeing some strange behavior.
>=20
> If I run a 100MB transfer (TCP, via nc and dd) over out LAN, with the
> Netgear on the sending end, I get about 10MB/s, as expected.
> Receiving, I get ~5MB/s. If I do simultaneous send and receive, the
> throughput is a few K per second at best.
>=20
> If I do the same transfers between a pair of isolated laptops, with
> the Netgear on one end and Intel e100 or e1000 on the other, I see about
> 500-900K per second in either direction.
>=20
> There are no errors detected by the usbnet driver and ethtool reports
> that the device is autonegotiating, full duplex. Setting autoneg off
> and duplex to half lets the isolated transfers go at wirespeed.
>=20
> So the question is, what's up with duplex? Everything I can find about
> the hardware (including the ASIX datasheet) claims it's full-duplex
> capable but aside from the error counters, it's really behaving like a
> half-duplex device.
>=20

First off, I hope you are testing with 2.6.12 or so.  There are some
patches to handle the auto-negotiation that went in 2.6.11 or 2.6.12 and
they SHOULD be handling those cases better though it is certainly
possible that they don't work as well as they should.  In some of my
testing, I was finding that I only really got the LPA from
autonegotiation on the first connect.  Subsequent ones always returned
the same values, even if I connected into a 10mb hub or the like.  I
haven't been able to determine if that is a shortcoming in the device or
not.=20

--=20
David Hollis <dhollis@davehollis.com>

--=-CUUSbnz5WkV3Hr987zjb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCtqzsxasLqOyGHncRAnkKAJ4+KYYrf8kjdCYTz8WPd4LgwHT43wCeLb9u
z+JIh3cptL4F5RT/P3GRalI=
=q7zU
-----END PGP SIGNATURE-----

--=-CUUSbnz5WkV3Hr987zjb--

