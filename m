Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUAYWr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbUAYWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:47:29 -0500
Received: from jam.adverticum.net ([195.228.75.77]:34703 "EHLO
	jam.adverticum.net") by vger.kernel.org with ESMTP id S265340AbUAYWr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:47:28 -0500
From: "Jecs Attila" <welder@coder.hu>
To: jgarzik@pobox.com
Reply-To: "Jecs Attila" <welder@coder.hu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: PrimPosta
Subject: [PATCH] tulip driver compiler warning
Message-Id: <20040125224627.0E216BFFCE@jam.adverticum.net>
Date: Sun, 25 Jan 2004 23:46:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will hopefully remove the compiler warning when compiling the new 
driver option of the tulip driver in 2.6.2-rc1-mm3. 
 
fix-tulip-driver-compiler-warning.patch 
 
--- drivers/net/tulip/tulip_core.c.orig	2004-01-25 23:19:53.000000000 
+0100 
+++ drivers/net/tulip/tulip_core.c	2004-01-25 23:20:17.000000000 
+0100 
@@ -253,7 +253,9 @@ static void tulip_down(struct net_device 
 static struct net_device_stats *tulip_get_stats(struct net_device 
*dev); 
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int 
cmd); 
 static void set_rx_mode(struct net_device *dev); 
+#ifdef CONFIG_NET_POLL_CONTROLLER 
 static void poll_tulip(struct net_device *dev); 
+#endif 
  
 static void tulip_set_power_state (struct tulip_private *tp, 
 				   int sleep, int snooze) 
 
