Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262893AbTCTBxu>; Wed, 19 Mar 2003 20:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCTBxu>; Wed, 19 Mar 2003 20:53:50 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:10208
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262893AbTCTBxt>; Wed, 19 Mar 2003 20:53:49 -0500
Date: Wed, 19 Mar 2003 18:04:48 -0800
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Everything gone!
Message-ID: <20030320020448.GC4821@triplehelix.org>
References: <Pine.LNX.4.44.0303191232130.30655-100000@bushido> <200303191155.06980.pollard@admin.navo.hpc.mil> <Pine.LNX.4.53.0303191310570.32397@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303191310570.32397@chaos>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2003 at 01:12:49PM -0500, Richard B. Johnson wrote:
> > > Perhaps:
> > >
> > > telnet target.system 25
> > > enter SMTP commands
> > > quit
> >
> > Normaly that would record the IP of the host doing the telnet.
> > (the first "Recieved: from" line in the log list where the original says
> > "Received: from localhost"....)
>=20
> Yes. I just looked at maillog on that machine and all I had was
> the 'evidence' of me screwing with it to see. Apparently it wasn't
> used for forwarding mail as I thought.

Well, a nice way to do this is: (probably not syntactically correct..)

router# iptables -t nat -A PREROUTING -i lan0 -p tcp ! -s=20
local.netework/12 -d ip.of.lan0 --dport 25 -j DROP

Depending on how your network is set up, this may or may not work... my=20
server box itself is masq'd so this works nicely on my network.

Regards,
Josh

--=20
New PGP public key: 0x27AFC3EE

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+eSG/T2bz5yevw+4RArDMAJ4kLukJGPWjASIgyL5jRMxbNgsMEQCggyoY
Io4q38VDmQyjxPWTXawL81k=
=qKAa
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
