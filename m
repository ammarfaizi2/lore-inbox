Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbVICIVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbVICIVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbVICIVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:21:23 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:64440 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1161181AbVICIVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:21:23 -0400
Date: Sat, 3 Sep 2005 10:39:58 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@davemloft.net>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: [PATCH 1/2] nfnetlink: make needlessly global functions static
Message-ID: <20050903083958.GC4415@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@davemloft.net>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Netdev List <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, bunk@stusta.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: multipart/mixed; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave, please apply the appended patch.

Thanks,
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="53-fnnetlink-static.patch"
Content-Transfer-Encoding: quoted-printable

[NETFILTER] make needlessly global functions static

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit a2c9c9a399f2069f31d608d142da8d5d82609b0d
tree 63cce7c2cc4d738a2604c54d87961b4a32ab3aac
parent 0905251a08bf51d5e2d1996c21fcdc5acfbbde13
author Adrian Bunk <bunk@stusta.de> Sa, 03 Sep 2005 10:34:27 +0200
committer Harald Welte <laforge@netfilter.org> Sa, 03 Sep 2005 10:34:27 +02=
00

 net/netfilter/nfnetlink.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -344,14 +344,14 @@ static void nfnetlink_rcv(struct sock *s
 	} while(nfnl && nfnl->sk_receive_queue.qlen);
 }
=20
-void __exit nfnetlink_exit(void)
+static void __exit nfnetlink_exit(void)
 {
 	printk("Removing netfilter NETLINK layer.\n");
 	sock_release(nfnl->sk_socket);
 	return;
 }
=20
-int __init nfnetlink_init(void)
+static int __init nfnetlink_init(void)
 {
 	printk("Netfilter messages via NETLINK v%s.\n", nfversion);
=20

--aT9PWwzfKXlsBJM1--

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGWFeXaXGVTD0i/8RAkzhAKCxO8alliDnPIYxiPpwfdFJIrrNswCfVkeg
5kiciSG2KPOBgPyto9+ZcXU=
=6crz
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
