Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132007AbQLMV4h>; Wed, 13 Dec 2000 16:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132022AbQLMV41>; Wed, 13 Dec 2000 16:56:27 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:49036 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S132007AbQLMV4P>; Wed, 13 Dec 2000 16:56:15 -0500
Date: Wed, 13 Dec 2000 16:25:12 -0500
From: Pete Toscano <pete@research.netsol.com>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux ipv6 questions.  bugs?
Message-ID: <20001213162512.N1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: kuznet@ms2.inr.ac.ru, linux-kernel@vger.redhat.com
In-Reply-To: <20001213144558.L1139@tesla.admin.cto.netsol.com> <200012132027.XAA15957@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012132027.XAA15957@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Dec 13, 2000 at 11:27:00PM +0300
X-Uptime: 4:10pm  up 1 day,  4:52,  7 users,  load average: 0.09, 0.07, 0.01
X-Married: 395 days, 20 hours, 25 minutes, and 29 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, 13 Dec 2000, kuznet@ms2.inr.ac.ru wrote:

> Hello!
>=20
> > 0.  whenever i ping6 the loopback interface (::1/128), all echo requests
> > seem to be dropped and i get no echo replies.  is this correct?
=20
> Your guess? 8) Of course, it is incorrect. I even have no idea
> how it is possible to put system into such sad state.

well, just power it on, it seems.  but then again, this is just a guess.
=3D;]

> Though... probably, you forgot to up loopback.

doesn't look it:

[root@nsv6 /root]# ifconfig lo
lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:7952  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
[root@nsv6 /root]# ping6 ::1
PING ::1(::1) from ::1 : 56 data bytes

--- ::1 ping statistics ---
156 packets transmitted, 0 packets received, 100% packet loss

=2E..and this is right after boot.

> > the destination mac address is set to the linux box's mac address and
> > the source mac address is set to 0:0:0:0:0:0.
>=20
> I think it is consequence of above. When loopback interface is missing,
> networking does not work.
>=20
>=20
> > other way around?  this would explain why the openbsd box doesn't
> > respond to the linux box's n.s. until it starts looking at all the
> > packets in promisc mode, right?
>=20
> Rather it means that openbsd is buggy, its stack accepts packets
> not destined to it. It cannot react to those strange packets, which
> you have just described.

that may very well be, but shouldn't the neighbor solisitation packets
from the linux box have the source mac address set to its mac address
and the destination mac address set to 0:0:0:0:0:0 and not the other way
around?

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6N+k4H/Abp5AIJzYRAlOqAKDN0g70ki0c2A6FVddEla31TCBEpgCfQT8R
yVUHTzXyPUCu2UR+thp8zkQ=
=IlpG
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
