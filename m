Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945953AbWGOAsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945953AbWGOAsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945954AbWGOAsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:48:50 -0400
Received: from mail.gmx.net ([213.165.64.21]:48776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945953AbWGOAsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:48:50 -0400
X-Authenticated: #2308221
Date: Sat, 15 Jul 2006 02:48:46 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Mark Lord <lkml@rtr.ca>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: FYI: strange libata EH lines in dmesg once after every bootup
Message-ID: <20060715004845.GA26446@zeus.uziel.local>
References: <20060714230801.GA6645@zeus.uziel.local> <44B8350E.9070409@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <44B8350E.9070409@rtr.ca>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, Mark!

On Fri, Jul 14, 2006 at 08:21:34PM -0400, Mark Lord wrote:
> Christian Trefzer wrote:
> >the following happens every time after bootup, tested with freshly built
> >2.6.18-rc1-mm2:=20
> ..
> >ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> >ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
> >ata1: EH complete
> ..
>=20
> Those are S.M.A.R.T. commands.
>=20
> Either your drive does not support S.M.A.R.T.,
> or you have not enabled it it with smartctl


This drive model surely supports S.M.A.R.T. but maybe support in the
driver is still underway. I just did a=20

# smartctl --device=3Data --smart=3Don --offlineauto=3Doff --saveauto=3Don =
-T permissive /dev/sdb

and this is what I got:

smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF ENABLE/DISABLE COMMANDS SECTION =3D=3D=3D
SMART Enabled.
Error SMART Enable Auto-save failed: Input/output error
Smartctl: SMART Enable Attribute Autosave Failed.

SMART Automatic Offline Testing Disabled.

The funny thing is that I enabled smart on the drives themselves through
some vendor utility, so IMHO this should not be necessary. I'll try to
add the smartctl calls to init scripts and see what I can find.


Thanks a lot!
Chris

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iQIVAwUBRLg7banY3eLOiwZcAQqN7w//QA/LNEqvz1TXNWlMyTMgTLm/Xybk4S1V
tSCS/ia6gJsH3z2a0IXUGrma3VJZKoVZvNgTu+5dEsyVXqFW1mDs+iKeTdEnKiQa
R3cQ54V6jqIq3wxYelSgwSmoIKj0PhwMrvQ2Ga4CFv5TqCX6LiEo6aVk9elTWt2e
orTFQesoUu8Q/NEYVqE2gmY/rqRpa1NqvAMHccEdXRfTUAK9MYuZF825IBb7wfWe
pzFiK1eI7W54o88Gp+PVXFvwon/RtibH8eYicGqVyYPdtX7BHax4xOaHqDNK4bv+
tVqWQF7WlYz94Tp1pIxn2Ud5DgSyQFv+gORNgaaVjRUtc2VVdl69m7gE3Tn0BAVg
z6AY4Tf4HuuqwIVfZU5x/dNPChuAnfSEf7tMDhRgntxThoGxum4ApM/cm14ZDmuo
gQfu5YPIhbj+BWnb6kseWr8mACEd5Hlw3GnLERHGQsKcWO7qCOwhmgGnLaglfOw1
7A2rrc3Wx0pK2g6UBZueCsfOylrEY0Y8gnsgu2pJRvw4VI2yP14y3H3REFuS3AI2
5htUSy7wcOL2casqNQja0/HaEoZzsNjTVCbqI/NgKOGQpEziwpx0nFnW7yGBLfEJ
h7KjJV0kOBKgC+rf6VEI++WdzMEdwzua+Dj/Q8EknQTYC/ueEsRjVcXnUiVVroNw
GTggBrggEn8=
=wWFM
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

