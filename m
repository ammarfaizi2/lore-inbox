Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCOOoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCOOoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVCOOoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:44:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39183 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261284AbVCOOoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:44:10 -0500
Date: Tue, 15 Mar 2005 15:44:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/inetpeer.c: make a struct static
Message-ID: <20050315144408.GL3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/net/ipv4/inetpeer.c.old	2005-03-15 13:29:32.000000000 +0100
+++ linux-2.6.11-mm3-full/net/ipv4/inetpeer.c	2005-03-15 13:30:13.000000000 +0100
@@ -92,9 +92,9 @@
 int inet_peer_minttl = 120 * HZ;	/* TTL under high load: 120 sec */
 int inet_peer_maxttl = 10 * 60 * HZ;	/* usual time to live: 10 min */
 
+static struct inet_peer *inet_peer_unused_head;
 /* Exported for inet_putpeer inline function.  */
-struct inet_peer *inet_peer_unused_head,
-		**inet_peer_unused_tailp = &inet_peer_unused_head;
+struct inet_peer **inet_peer_unused_tailp = &inet_peer_unused_head;
 DEFINE_SPINLOCK(inet_peer_unused_lock);
 #define PEER_MAX_CLEANUP_WORK 30
 

