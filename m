Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVIMFFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVIMFFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVIMFFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:05:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28873 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751130AbVIMFFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:05:22 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.14-rc1] Correct xircom_cb use of CONFIG_NET_POLL_CONTROLLER
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Sep 2005 15:05:13 +1000
Message-ID: <21546.1126587913@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xircom_cb.c does #if CONFIG_NET_POLL_CONTROLLER instead of #ifdef,
resulting in drivers/net/tulip/xircom_cb.c:120:5: warning:
"CONFIG_NET_POLL_CONTROLLER" is not defined.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

 xircom_cb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/net/tulip/xircom_cb.c
===================================================================
--- linux.orig/drivers/net/tulip/xircom_cb.c	2005-09-13 15:01:30.667784502 +1000
+++ linux/drivers/net/tulip/xircom_cb.c	2005-09-13 15:02:02.246401717 +1000
@@ -117,7 +117,7 @@ static int xircom_open(struct net_device
 static int xircom_close(struct net_device *dev);
 static void xircom_up(struct xircom_private *card);
 static struct net_device_stats *xircom_get_stats(struct net_device *dev);
-#if CONFIG_NET_POLL_CONTROLLER
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void xircom_poll_controller(struct net_device *dev);
 #endif
 

