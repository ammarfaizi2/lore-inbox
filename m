Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUGYKOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUGYKOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 06:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUGYKOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 06:14:41 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:4023 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263847AbUGYKOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 06:14:38 -0400
Message-ID: <410387FE.30201@kolivas.org>
Date: Sun, 25 Jul 2004 20:14:22 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6.8-rc1-mm1] ipv6/route.c gcc-341 fix inline
References: <410381B4.1080302@kolivas.org>
In-Reply-To: <410381B4.1080302@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig864F71F740D9E0AB6C752DD6"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig864F71F740D9E0AB6C752DD6
Content-Type: multipart/mixed;
 boundary="------------030205030304060202090207"

This is a multi-part message in MIME format.
--------------030205030304060202090207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Fixes the inline error when compiling net/ipv6/route.c with gcc-3.4.1

oops. Missing a hunk.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--------------030205030304060202090207
Content-Type: text/plain;
 name="gcc341-fix-ipv6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc341-fix-ipv6"

Index: linux-2.6.8-rc1-mm1/net/ipv6/route.c
===================================================================
--- linux-2.6.8-rc1-mm1.orig/net/ipv6/route.c	2004-07-25 19:51:31.174800809 +1000
+++ linux-2.6.8-rc1-mm1/net/ipv6/route.c	2004-07-25 20:11:03.881562316 +1000
@@ -584,7 +584,7 @@
 /* Protected by rt6_lock.  */
 static struct dst_entry *ndisc_dst_gc_list;
 static int ipv6_get_mtu(struct net_device *dev);
-static inline unsigned int ipv6_advmss(unsigned int mtu);
+static unsigned int ipv6_advmss(unsigned int mtu);
 
 struct dst_entry *ndisc_dst_alloc(struct net_device *dev, 
 				  struct neighbour *neigh,
@@ -692,7 +692,7 @@
 	return mtu;
 }
 
-static inline unsigned int ipv6_advmss(unsigned int mtu)
+static unsigned int ipv6_advmss(unsigned int mtu)
 {
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 

--------------030205030304060202090207--

--------------enig864F71F740D9E0AB6C752DD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBA4gBZUg7+tp6mRURAp7ZAKCR7KaR5gEFmrT9shNFPCXF2hES4QCeKNrU
BiLIFQWbHLFeO5I4lG6Up8M=
=jQHn
-----END PGP SIGNATURE-----

--------------enig864F71F740D9E0AB6C752DD6--
