Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUJ0AbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUJ0AbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbUJ0AbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:31:20 -0400
Received: from pop.gmx.de ([213.165.64.20]:29586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261518AbUJ0Aah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:30:37 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Neighbour table overflow.
Date: Wed, 27 Oct 2004 02:30:32 +0200
User-Agent: KMail/1.7
Cc: earny@net4u.de, linux-kernel@vger.kernel.org
References: <200410261939.33541.dominik.karall@gmx.net> <200410270011.28818.dominik.karall@gmx.net> <20041026160642.605f7fd7.davem@davemloft.net>
In-Reply-To: <20041026160642.605f7fd7.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2038980.5ceDjSAWoH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410270230.34966.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2038980.5ceDjSAWoH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 27 October 2004 01:06, David S. Miller wrote:
> On Wed, 27 Oct 2004 00:11:26 +0200
>
> Dominik Karall <dominik.karall@gmx.net> wrote:
> > On Tuesday 26 October 2004 23:52, Ernst Herzberg wrote:
> > > On Tuesday 26 October 2004 19:39, Dominik Karall wrote:
> > > > can anybody explain why i get thousands of "Neighbour table
> > > > overflow." messages? i didn't get such ones with older kernels
> > > > (~2.6.6).
> > >
> > > Do you set a default gateway?
> >
> > yes, default gateway is set to our server.
>
> Do you use a large subnet mask?  For example /16 or /8 or
> something like that?
>
> If so, you will need to bump up the neighbour table garbage
> collection thresholds under /proc/sys/net/ipv4/neight/default/
> Specifically gc_thresh1, gc_thresh2, and gc_thresh3
>
> You probably have a huge number of machines on your subnet.

the subnet mask is set to 255.255.0.0, and there are machines from 172.16.0=
=2E1=20
to 172.16.1.254. but not all ips are reserved. there are "only" about 100=20
machines in the network.
i will try to change the values of gc_thresh*, maybe it helps. thx!

dominik

--nextPart2038980.5ceDjSAWoH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQX7sKgvcoSHvsHMnAQJXqgP/eFTl/SzsI83Q/WgZmlaJ9xPCXsSxFbQm
2UmR4cHDZti6mOzKeAOI/O91S+xTkFvdYmVgm+k+TAaUpy6OHa1Lx84y9H7uMa7P
7afLf9+qQ00pi+uUp9srhihpiwt1yEYRWuvc9NaZhYfl9EJdeQmGNy6M7tlSwV07
mxTCNjVqBBU=
=Z8MD
-----END PGP SIGNATURE-----

--nextPart2038980.5ceDjSAWoH--
