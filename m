Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUGYJsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUGYJsE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 05:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUGYJsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 05:48:03 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:42190 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263772AbUGYJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 05:47:52 -0400
Message-ID: <410381B4.1080302@kolivas.org>
Date: Sun, 25 Jul 2004 19:47:32 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6.8-rc1-mm1] ipv6/route.c gcc-341 fix inline
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCC963F1699E3AD15064F126F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC963F1699E3AD15064F126F
Content-Type: multipart/mixed;
 boundary="------------020700010600030504020901"

This is a multi-part message in MIME format.
--------------020700010600030504020901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes the inline error when compiling net/ipv6/route.c with gcc-3.4.1

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--------------020700010600030504020901
Content-Type: text/plain;
 name="gcc341-fix-ipv6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc341-fix-ipv6"

Index: linux-2.6.8-rc1-mm1/net/ipv6/route.c
===================================================================
--- linux-2.6.8-rc1-mm1.orig/net/ipv6/route.c	2004-07-25 19:32:32.554804276 +1000
+++ linux-2.6.8-rc1-mm1/net/ipv6/route.c	2004-07-25 19:42:22.899856237 +1000
@@ -584,7 +584,7 @@
 /* Protected by rt6_lock.  */
 static struct dst_entry *ndisc_dst_gc_list;
 static int ipv6_get_mtu(struct net_device *dev);
-static inline unsigned int ipv6_advmss(unsigned int mtu);
+static unsigned int ipv6_advmss(unsigned int mtu);
 
 struct dst_entry *ndisc_dst_alloc(struct net_device *dev, 
 				  struct neighbour *neigh,

--------------020700010600030504020901--

--------------enigCC963F1699E3AD15064F126F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBA4G2ZUg7+tp6mRURAhKQAJ9VTR3ha2/ZnzqGWtz3dLsu8yz8/gCfYvj/
Ur/xjz1l4kAKYUbCMLhEB/4=
=IeO9
-----END PGP SIGNATURE-----

--------------enigCC963F1699E3AD15064F126F--
