Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTLCApX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTLCApX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:45:23 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:18826 "EHLO
	catnet.kabel.utwente.nl") by vger.kernel.org with ESMTP
	id S264439AbTLCApU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:45:20 -0500
Date: Wed, 3 Dec 2003 01:45:19 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.4.23 masquerading broken?
Message-ID: <20031203004518.GL615@gaast.net>
References: <20031202165653.GJ615@gaast.net> <3FCCCB02.5070203@trash.net> <20031202173358.GK615@gaast.net> <3FCD20F1.6090800@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline
In-Reply-To: <3FCD20F1.6090800@trash.net>
X-Operating-System: Linux 2.4.23 on a i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patrick McHardy (kaber@trash.net) wrote:
> It may be related to using advances routing features ..
> Can you give information about the specific IPs ? Is it local traffic ?
>=20
It happens when a packet to a host outside 130.89.*.* is routed through
the eth1 (130.89.203.37) interface. That happens with any traffic not
=66rom .9.11 or .9.13. .9.11 and .9.13 don't have any problems, their
traffic is routed to the other Internet interface without any problems.

Also, traffic to 130.89.*.* from any host is routed to eth1 correctly
and "even" works.

So, in short:

192.168.9.10 -=3D> 130.89.1.1 works, through eth1
192.168.9.11 -=3D> 130.89.1.1 works, through eth1
192.168.9.10 -=3D> www.google.com doesn't work
192.168.9.11 -=3D> www.google.com works, through hensema (which is what I w=
ant)

Also, trying to ping www.google.com through eth1 (hensema is the default
interface) from the bugging machine directly works.

I hope this clarifies something... If not, I can do some more testing
tomorrow.


Greetings,

Wilmer van der Gaast.

--=20
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE/zTIeeYWXmuMwQFERArivAKCQNREsKcLv/l31Oycd/IkZKXYGNACg4j5b
CZf0WYfXAxYP25RLQOOQExY=
=okAz
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--
