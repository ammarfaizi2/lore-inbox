Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbUJ1XCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbUJ1XCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUJ1XCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:02:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33553 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263022AbUJ1XBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:01:04 -0400
Date: Fri, 29 Oct 2004 01:00:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ralf@linux-mips.org
Cc: linux-hams@vger.kernel.org, davem@davemloft.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] : remove an unused function
Message-ID: <20041028230032.GU3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from net/ax25/ax25_route.c


diffstat output:
 net/ax25/ax25_route.c |   16 ----------------
 1 files changed, 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/net/ax25/ax25_route.c.old	2004-10-28 23:50:25.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/ax25/ax25_route.c	2004-10-28 23:50:41.000000000 +0200
@@ -41,22 +41,6 @@
 
 static ax25_route *ax25_get_route(ax25_address *, struct net_device *);
 
- -/*
- - * small macro to drop non-digipeated digipeaters and reverse path
- - */
- -static inline void ax25_route_invert(ax25_digi *in, ax25_digi *out)
- -{
- -	int k;
- -
- -	for (k = 0; k < in->ndigi; k++)
- -		if (!in->repeated[k])
- -			break;
- -
- -	in->ndigi = k;
- -
- -	ax25_digi_invert(in, out);
- -}
- -
 void ax25_rt_device_down(struct net_device *dev)
 {
 	ax25_route *s, *t, *ax25_rt;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXoQmfzqmE8StAARAqLLAKCZRsBxw7oCIFnvPVFFZ6ss4QRuOgCfcu4e
++CuY/BJjph1Fr/xntu1j/o=
=5M44
-----END PGP SIGNATURE-----
