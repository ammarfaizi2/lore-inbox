Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVDGMUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVDGMUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVDGMUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:20:47 -0400
Received: from ns.schottelius.org ([213.146.113.242]:27657 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262437AbVDGMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:20:10 -0400
Date: Thu, 7 Apr 2005 14:22:17 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: PMTU, MSS and "fragmentation needed" problem with linux?
Message-ID: <20050407122217.GE5211@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

[I hope this is the correct list, if not, please tell me where to ask]

The following scenario:

Linux-client <-- Ethernet --> Linux-router <-- PPPoE --> Internet.
Linux-client has MTU=3D=3D1500, so the MSS is 1460.
Linux-router has MTU=3D=3D1500 on eth0 and MTU=3D1492 on ppp0.
The MSS is set to 1452 via pppoe command line.

My question: May the MSS on ppp0 be 1460? Imho not, as

RFC 879 defines the MSS as MTU-40, which would be 1452.
But tcpdump says 1460 on ppp0.
On another box the MTU is set to 1460 and I still see packets
with MSS 1460. Is this correct?
Should not the Linux-router send the client a packet ICMP type 3,
subtype 4, Frag needed, but DF-Bit set?

I ask htis, because of a problem I  have on the first box:
If the clients have a mtu of 1500, theycannot connect
to some servers and get timeouts.

The firewall was tested with iptables of (only MASQUERADE on), so that
all icmp packets are allowed.

Thank you for any hint!

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQIVAwUBQlUl97OTBMvCUbrlAQKn5g/+IH3W32vJfIaZW4T59XXCw2l2gsO+Pndj
UsqzRLInRLnwDQbQFBM5bHoEzNLHUsuxE2QPu9G2Ww+XpJVjQVBI/+EnjDi9HYly
jTSplI/YbbyedlW9K8E1n29MMVkew9ylIBKcQ+QNQaBeixVLOz6JaU3URScwV++W
qbsYsoEEqQ3p5+c4aosXZvig7G2jpOgi4/L6rOBW8FcGsp5uXIjGTaG7XFS1DCrN
sm4+kwP8dWItCd8Q0CHxA2l5Ahr8Kz9PrVYW+piiWWyUZ+N3SWxMeivTWZe0IIY+
tobLoufYjb+4PgHPo2vOyKpJBPR+DaZ3rLIlfvuVioQ7Tx6ZY+CRkHDEaQsWa3tU
u4b+Z1bETOBG3/fB4If37NFq8QR4ZGdYLp3gpprvBI+nhiFh7xqk/JpaY2fXf4RI
lIYVTs46EWnaJkVVmQHiP6KVq71PRU79/Lm2jHJIyEah320vVWzitNennoIWDJ/Z
yzSFpA6FRADsLSwY4wqYnD1THvDKhCDR0jBBjE9V71Z5BDtWb/3A3W3fHcN04WMW
OKH9MoKq47iI2UEmBYJpC7S6zMFinNulNKaAI+1QNq+K9fb6VjAAV7n/ezm2Py88
Gei+Zg++reiePDsDgAJH3J1PF9YD0i9hlvisFgO8ZzdYH15SdSH7cv3S6I+PbYMe
5BnrwaTaxQE=
=6TeK
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
