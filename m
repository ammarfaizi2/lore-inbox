Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUIWCGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUIWCGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 22:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUIWCGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 22:06:49 -0400
Received: from pointblue.com.pl ([81.219.144.6]:17678 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S268138AbUIWCG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 22:06:28 -0400
Message-ID: <41522F91.2010903@pointblue.com.pl>
Date: Thu, 23 Sep 2004 04:06:09 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] compilation fixes for gcc 4.0
References: <4151D086.6040708@pointblue.com.pl>
In-Reply-To: <4151D086.6040708@pointblue.com.pl>
Content-Type: multipart/mixed;
 boundary="------------080704050706090604070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704050706090604070508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2nd patch attached.

Signed-off-by: Grzegorz Jaskiewicz <gj at pointblue.com.pl>

---

--
GJ

--------------080704050706090604070508
Content-Type: text/plain;
 name="3c507.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c507.c.patch"

diff -Naur linux-2.6.8/drivers/net/3c507.c linux-2.6.9-rc2-mm1/drivers/net/3c507.c
--- linux-2.6.8/drivers/net/3c507.c	2004-08-14 07:37:38 +0200
+++ linux-2.6.9-rc2-mm1/drivers/net/3c507.c	2004-09-22 21:15:29 +0200
@@ -294,6 +294,7 @@
 static void hardware_send_packet(struct net_device *dev, void *buf, short length, short pad);
 static void init_82586_mem(struct net_device *dev);
 static struct ethtool_ops netdev_ethtool_ops;
+static void init_rx_bufs(struct net_device *); 
 
 static int io = 0x300;
 static int irq;
@@ -612,7 +613,6 @@
 	}
 
 	if ((status & 0x0070) != 0x0040 && netif_running(dev)) {
-		static void init_rx_bufs(struct net_device *);
 		/* The Rx unit is not ready, it must be hung.  Restart the receiver by
 		   initializing the rx buffers, and issuing an Rx start command. */
 		if (net_debug)

--------------080704050706090604070508--
