Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUIIToM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUIIToM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUIITmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:42:53 -0400
Received: from pD958A4C7.dip.t-dialin.net ([217.88.164.199]:61371 "EHLO
	fb04206.mathematik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S263795AbUIITgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:36:15 -0400
Date: Thu, 9 Sep 2004 21:36:13 +0200
From: Andre Noll <noll@mathematik.tu-darmstadt.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Buckingham <peter@pantasys.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] Obvious compile fix for net/ipv4/ipconfig.c
Message-ID: <20040909193613.GD22045@p133>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Peter Buckingham <peter@pantasys.com>,
	"David S. Miller" <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The undeclared variable in ic_bootp_recv was introduced by Peter's
previous IPCONFIG patch (Logical change 1.21935).

Signed-off-by: Andre Noll <noll@mathematik.tu-darmstadt.de>

Index: linux-2.5/net/ipv4/ipconfig.c
===================================================================
RCS file: /var/cvs/repository/linux-2.5/net/ipv4/ipconfig.c,v
retrieving revision 1.41
diff -u -r1.41 ipconfig.c
--- linux-2.5/net/ipv4/ipconfig.c	8 Sep 2004 19:19:17 -0000	1.41
+++ linux-2.5/net/ipv4/ipconfig.c	9 Sep 2004 19:19:38 -0000
@@ -825,7 +825,7 @@
 	struct bootp_pkt *b;
 	struct iphdr *h;
 	struct ic_device *d;
-	int len, ext_len;
+	int len, ext_len, i;
 
 	/* Perform verifications before taking the lock.  */
 	if (skb->pkt_type == PACKET_OTHERHOST)
-- 
Andre Noll, http://www.mathematik.tu-darmstadt.de/~noll
