Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVALWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVALWEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVALWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:02:28 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261490AbVALVsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:20 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.Eers4foFN4d7Nfl8@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:50 -0800
Message-Id: <20051121347.WsPtvzM0EMoPIX2y@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][7/18] InfiniBand: make more code static
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:51.0469 (UTC) FILETIME=[5D51ADD0:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/ulp/ipoib/ipoib_main.c	(revision 1456)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_main.c	(revision 1457)
@@ -606,7 +606,7 @@
 	return NETDEV_TX_OK;
 }
 
-struct net_device_stats *ipoib_get_stats(struct net_device *dev)
+static struct net_device_stats *ipoib_get_stats(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
--- linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	(revision 1456)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	(revision 1457)
@@ -44,7 +44,7 @@
 #include "ipoib.h"
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
-int mcast_debug_level;
+static int mcast_debug_level;
 
 module_param(mcast_debug_level, int, 0644);
 MODULE_PARM_DESC(mcast_debug_level,
@@ -623,7 +623,7 @@
 	return 0;
 }
 
-int ipoib_mcast_leave(struct net_device *dev, struct ipoib_mcast *mcast)
+static int ipoib_mcast_leave(struct net_device *dev, struct ipoib_mcast *mcast)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ib_sa_mcmember_rec rec = {
--- linux/drivers/infiniband/ulp/ipoib/ipoib_ib.c	(revision 1456)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_ib.c	(revision 1457)
@@ -357,7 +357,7 @@
 	}
 }
 
-void __ipoib_reap_ah(struct net_device *dev)
+static void __ipoib_reap_ah(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_ah *ah, *tah;
--- linux/drivers/infiniband/core/cache.c	(revision 1456)
+++ linux/drivers/infiniband/core/cache.c	(revision 1457)
@@ -252,7 +252,7 @@
 	}
 }
 
-void ib_cache_setup_one(struct ib_device *device)
+static void ib_cache_setup_one(struct ib_device *device)
 {
 	int p;
 
@@ -295,7 +295,7 @@
 	kfree(device->cache.gid_cache);
 }
 
-void ib_cache_cleanup_one(struct ib_device *device)
+static void ib_cache_cleanup_one(struct ib_device *device)
 {
 	int p;
 
@@ -311,7 +311,7 @@
 	kfree(device->cache.gid_cache);
 }
 
-struct ib_client cache_client = {
+static struct ib_client cache_client = {
 	.name   = "cache",
 	.add    = ib_cache_setup_one,
 	.remove = ib_cache_cleanup_one

