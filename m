Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUAXIDN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 03:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266886AbUAXIDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 03:03:13 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:32897 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S266885AbUAXIDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 03:03:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.2-rc1-mm2] drivers/net/tulip/tulip_core.c
Cc: akpm@osdl.org, jgarzik@pobox.com, tulip-users@lists.sourceforge.net
Message-Id: <20040124080217.ED53113A354@mrhankey.megahappy.net>
Date: Sat, 24 Jan 2004 00:02:17 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a warning if CONFIG_NET_POLL_CONTROLLER is NOT set.

--- drivers/net/tulip/tulip_core.c.orig 2004-01-23 23:53:17.484261904 -0800
+++ drivers/net/tulip/tulip_core.c      2004-01-23 23:53:53.675759960 -0800
@@ -253,7 +253,9 @@
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void poll_tulip(struct net_device *dev);
+#endif
  
  
 static void tulip_set_power_state (struct tulip_private *tp,

--
Bryan Whitehead
driver@megahappy.net
