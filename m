Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUHVUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUHVUyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUHVUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:54:15 -0400
Received: from zak.futurequest.net ([69.5.6.152]:54186 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S266319AbUHVUxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:53:53 -0400
Date: Sun, 22 Aug 2004 14:53:46 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Broadcom 4401 problem
Message-ID: <20040822205346.GA17895@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings.

I have a Dell Inspiron 1150 laptop which has a built-in Broadcom 4401
NIC.  I am using Gentoo's 2.6.8.1 kernel and the built-in b44 driver.
It compiles, loads, and I can get basic network traffic through it just
fine.  However, it (the NIC) locks up randomly when I try to do bulk
data transfers (with rsync for example).  I can get it to reset itself
by either taking the interface down and up, or by running "ethtool -A
eth0 rx off tx off".  Both actions appear to cause the NIC to disconnect
and renegotiate with the switch.

What is unusual, to me, is that while the NIC is malfunctioning, it
still can transmit packets.  I have run tcpdump on both the laptop and
the destnation system, and the laptop still transmits the trailing TCP
ACKs and ARPs, however it does not receive any responses.

I have tried to reproduce this with Windows (which is also installed)
but have been unable as of yet to do so.  I am not, however, ruling out
a hardware problem, as the "activity" light on the NIC flickers
constantly even when there is no traffic.

Is this likely a hardware problem, or a problem in the driver?
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKQfa6W+y3GmZgOgRAtAjAJwKdXSJWzWqYkQ3hysMsQBs7bhbdQCZAWxg
ni6Zso6AD6b8MKvW+SXnQxA=
=BPjN
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
