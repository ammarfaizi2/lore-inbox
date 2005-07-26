Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVGZM6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVGZM6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVGZM6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:58:10 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:9198 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261731AbVGZM6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:58:08 -0400
Date: Tue, 26 Jul 2005 05:48:28 -0400
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
Message-ID: <20050726094828.GJ7925@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>, johnpol@2ka.mipt.ru,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20050723125427.GA11177@rama> <20050722.230559.123762041.yoshfuji@linux-ipv6.org> <20050723133353.GB11177@rama> <20050724.191505.69244686.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <20050724.191505.69244686.davem@davemloft.net>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 24, 2005 at 07:15:05PM -0700, David S. Miller wrote:
=20
> > I strongly disrecommend increasing NPROTO.  Maybe we should look into
> > reusing NETLINK_FIREWALL (which was an old 2.2.x kernel interface).
>=20
> ip_queue.c still uses NETLINK_FIREWALL so we really can't use
> that.

sorry, I didn't remember that ip_queue reused the 2.2.x netlink number
:(  We should have renamed it to make it clear.

> So instead, as in the patch below, I solved this for now by using
> the NETLINK_SKIP value which was reserved years ago yet never
> made use of.

thanks.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC5gbsXaXGVTD0i/8RAtYtAJ9LdzcNPEEV4Mf6Wdzgo7Z5Tn6UswCdFlS6
jpXJiTFRaAEDNVvc/IoKh1M=
=COO+
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
