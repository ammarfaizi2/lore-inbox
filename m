Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130894AbQLMUQv>; Wed, 13 Dec 2000 15:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130984AbQLMUQl>; Wed, 13 Dec 2000 15:16:41 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:34956 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S130894AbQLMUQ3>; Wed, 13 Dec 2000 15:16:29 -0500
Date: Wed, 13 Dec 2000 14:45:58 -0500
From: Pete Toscano <pete@research.netsol.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: linux ipv6 questions.  bugs?
Message-ID: <20001213144558.L1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 2:24pm  up 1 day,  3:07,  7 users,  load average: 0.10, 0.09, 0.08
X-Married: 395 days, 18 hours, 39 minutes, and 59 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i'm using test12 with ipv6 enabled.  i'm seeing something strange, but i
can't tell if it's a linux or openbsd bug.

i have two boxes, one's running 2.4.0-test12 and the other's running
openbsd 2.8 (the same problem was seen with this machine using 2.7 too).
they are on a little ipv6 network, with a 125 bit prefix length.

i have two question, one short, one longer.  i'll start with the short
one:

0.  whenever i ping6 the loopback interface (::1/128), all echo requests
seem to be dropped and i get no echo replies.  is this correct?  on the
openbsd box, i can ping6 ::1 just fine.

1.  i can only ping6 the ipv6 address of the openbsd machine once i put
the openbsd box's ethernet interface into promisc mode (with tcpdump).
after that (and even once the openbsd box's eth is back in non-promisc
mode), i can ping6 the openbsd box fine.  looking at a packet capture,
i see the neighbor solicitation packets from the linux box, but i
noticed something strange;  in the ethernet header of the n.s. packets,
the destination mac address is set to the linux box's mac address and
the source mac address is set to 0:0:0:0:0:0.  shouldn't this be the
other way around?  this would explain why the openbsd box doesn't
respond to the linux box's n.s. until it starts looking at all the
packets in promisc mode, right?

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6N9H2H/Abp5AIJzYRAjBgAKDQcQW8gNWVfee3rsRXfNnD/VQFgQCgwqL5
UQV8cIbn2lbHKpFANI3TFvc=
=OGxe
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
