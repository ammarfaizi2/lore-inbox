Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbQKRVYe>; Sat, 18 Nov 2000 16:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130681AbQKRVYY>; Sat, 18 Nov 2000 16:24:24 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:39625 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S130663AbQKRVYP>; Sat, 18 Nov 2000 16:24:15 -0500
Date: Sat, 18 Nov 2000 15:54:41 -0500
From: Pete Toscano <pete@research.netsol.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2.18pre21 and ipv6 problems/questions
Message-ID: <20001118155441.T11099@tesla.admin.cto.netsol.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="V7BlxAaPrdhzdIM1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:37pm  up 12 days,  3:13,  8 users,  load average: 0.20, 0.14, 0.10
X-Married: 370 days, 19 hours, 52 minutes, and 33 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V7BlxAaPrdhzdIM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

i'm trying to set up an ipv6 machine.  i got a setup script from
freenet6 complete with an ipv6 address and the ipv6 and ipv4 addresses
of my tunnel endpoint.  i'm seeing some strange behavior, so i have a
few questions.  most of these are probably ubd (user brain damage), but
i'd like to have these verified if possibe =3D).

0. basically, how complete/correct is the ipv6 implementation on
2.2.18pre21?  should i even bother or is it fairly stable and correct?

1. how come i can ping6 ::1 just fine as long as the sit0 device is
down, but as soon as it comes up, i can't?

2. i understand that the sit devices are pseudo devices on top of (well,
in my case) eth0.  afaict, sit0 represents my side of an ipv6-in-ipv4
tunnel and sit1 is the other side of it.  ipv6 packets destined for
removte ipv6 networks should be routed to the like-scoped ipv6 address
of the sit1 device, right?

3. aliased interfaces are in ipv4-only construct right?  i shouldn't be
able to create an alias interface with only an ipv6 address, da?

4. should i be able to delete an address i add to an interface?  when i
"ifconfig add" an ipv6 address to an interface and then try to "ifconfig
del" it, i get "SIOCDIFADDR: Invalid argument".  i've tried to del with
and without the /prefixlen and neither has worked.

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--V7BlxAaPrdhzdIM1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6FuyRH/Abp5AIJzYRAkgRAJ9VK3KX9RMoORgLn4oLQj8OaNsc4gCgtOBM
QMTBAfMpfz6urHw6AXTvfdI=
=niWb
-----END PGP SIGNATURE-----

--V7BlxAaPrdhzdIM1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
