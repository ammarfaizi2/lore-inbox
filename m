Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUIVTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUIVTXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIVTW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:22:59 -0400
Received: from pointblue.com.pl ([81.219.144.6]:47371 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S266758AbUIVTVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:21:00 -0400
Message-ID: <4151D086.6040708@pointblue.com.pl>
Date: Wed, 22 Sep 2004 21:20:38 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] compilation fixes for gcc 4.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Grzegorz Jaskiewicz <gj at pointblue.com.pl>

--- drivers/net/3c507.old.c     2004-09-22 21:14:51 +0200
+++ drivers/net/3c507.c 2004-09-22 21:15:29 +0200
@@ -294,6 +294,7 @@
 static void hardware_send_packet(struct net_device *dev, void *buf, 
short length, short pad);
 static void init_82586_mem(struct net_device *dev);
 static struct ethtool_ops netdev_ethtool_ops;
+static void init_rx_bufs(struct net_device *);

 static int io = 0x300;
 static int irq;
@@ -612,7 +613,6 @@
        }

        if ((status & 0x0070) != 0x0040 && netif_running(dev)) {
-               static void init_rx_bufs(struct net_device *);
                /* The Rx unit is not ready, it must be hung.  Restart 
the receiver by
                   initializing the rx buffers, and issuing an Rx start 
command. */
                if (net_debug)



--
GJ
