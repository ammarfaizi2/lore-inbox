Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJYNlS>; Fri, 25 Oct 2002 09:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJYNlR>; Fri, 25 Oct 2002 09:41:17 -0400
Received: from relay.snowman.net ([63.80.4.38]:30215 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S261406AbSJYNlQ>;
	Fri, 25 Oct 2002 09:41:16 -0400
Date: Fri, 25 Oct 2002 09:47:23 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Stephen Satchell <list@fluent2.pyramid.net>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
Message-ID: <20021025134723.GZ15886@ns>
Mail-Followup-To: Stephen Satchell <list@fluent2.pyramid.net>,
	hps@intermeta.de, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1021023105535.13301A-100000@chaos.analogic.com> <Pine.LNX.4.44.0210231346500.26808-100000@innerfire.net> <5.1.0.14.0.20021024210320.01db0750@fluent2.pyramid.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eSbLxR/uY7u5MyMV"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20021024210320.01db0750@fluent2.pyramid.net>
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 09:41:59 up 82 days, 16:18, 11 users,  load average: 0.12, 0.21, 0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eSbLxR/uY7u5MyMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Satchell (list@fluent2.pyramid.net) wrote:
> I've also been experimenting with the traffic limiting capabilities, as o=
ne=20
> co-locate provider offers discounts for guaranteed lower bandwidth=20
> utilization, so by limiting the bandwidth using IPTABLES I should be able=
=20
> to cut my co-lo costs to 1/3 of what they would be with "unlimited"=20
> bandwidth.

http://www.lartc.org ; When talking about traffic shaping with Linux
you're really talking about tc from the iproute2 package.  I'd recommend
you check out that URL if you havn't already and that you strongly
consider using HTB for your traffic shaping needs, it's alot easier to
use and makes alot more sense than CBQ.

> I've worked with the PIX, and I don't see what I'm missing in features=20
> between the PIX and Linux/IPTABLES.  I'm sure there is something.  Please=
=20
> amplify on your comments.

Eh, it depends on how you look at it, but...  The cisco includes support
for checking out high-level protocols, such as HTTP.  Basically you can
set things up inside the PIX based on what URL is being requested and
such.  That's why the PIX is more than just a packet filter.  Personally
I still characterize my Linux box running iptables as a firewall.  If
you want to do the same kind of thing the PIX is doing on port 80 you'd
need to run squid or something similar to it and set it up as a reverse
proxy with associated access rules and whatnot.  Things like deny
anything with cmd.exe in it, etc.

	Stephen

--eSbLxR/uY7u5MyMV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uUtrrzgMPqB3kigRAsFcAKCANdPOD4v+erBzLiCN3NuGU8HZvQCdH7oA
DTEdJJwPbDgiAuPiIpZPm8E=
=iWGW
-----END PGP SIGNATURE-----

--eSbLxR/uY7u5MyMV--
