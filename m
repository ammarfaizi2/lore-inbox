Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCAAiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCAAiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVCAAg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:36:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22027 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261162AbVCAAfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:35:43 -0500
Date: Tue, 1 Mar 2005 01:35:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: petkan@users.sourceforge.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/net/pegasus.c: make some code static
Message-ID: <20050301003541.GA4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/net/pegasus.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/usb/net/pegasus.c.old	2005-02-28 23:26:58.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/net/pegasus.c	2005-02-28 23:27:45.000000000 +0100
@@ -956,7 +956,8 @@
 	return 0;
 }
 
-void pegasus_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+static void pegasus_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
 {
 	pegasus_t *pegasus = netdev_priv(dev);
 	strncpy(info->driver, driver_name, sizeof (info->driver) - 1);
@@ -1156,10 +1157,10 @@
 }
 
 
-struct workqueue_struct *pegasus_workqueue = NULL;
+static struct workqueue_struct *pegasus_workqueue = NULL;
 #define CARRIER_CHECK_DELAY (2 * HZ)
 
-void check_carrier(void *data)
+static void check_carrier(void *data)
 {
 	pegasus_t *pegasus = data;
 	set_carrier(pegasus->net);

