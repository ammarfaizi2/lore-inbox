Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTH3Fic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 01:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTH3Fib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 01:38:31 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:61705 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261464AbTH3Fia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 01:38:30 -0400
Date: Sat, 30 Aug 2003 15:37:58 +1000
To: Linus Torvalds <torvalds@osdl.org>, shemminger@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [COSA] free_netdev typo
Message-ID: <20030830053758.GA24332@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The free_netdev fixes in 2.6.0-test4 broke drivers/net/wan/cosa.c.
This patch fixes it.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/net/wan/cosa.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/net/wan/cosa.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 cosa.c
--- kernel-source-2.5/drivers/net/wan/cosa.c	22 Aug 2003 23:51:01 -0000	1.1.1.8
+++ kernel-source-2.5/drivers/net/wan/cosa.c	30 Aug 2003 05:32:28 -0000
@@ -632,7 +632,7 @@
 {
 	sppp_detach(chan->pppdev.dev);
 	unregister_netdev(chan->pppdev.dev);
-	free_netdev(chan->ppp.dev);
+	free_netdev(chan->pppdev.dev);
 }
 
 static int cosa_sppp_open(struct net_device *d)

--ZPt4rx8FFjLCG7dd--
