Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263207AbUJ2KDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUJ2KDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbUJ2KDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:03:41 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64167 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263207AbUJ2KDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:03:24 -0400
Subject: [PATCH 1/3] net: generic netdev_ioaddr
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: davem@davemloft.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <1099044244.9566.0.camel@localhost>
References: <1099044244.9566.0.camel@localhost>
Date: Fri, 29 Oct 2004 13:04:38 +0300
Message-Id: <1099044278.9566.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a generic netdev_ioaddr in include/linux/netdevice.h.
It is pulled from driver/net/natsemi.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 netdevice.h |    5 +++++
 1 files changed, 5 insertions(+)

Index: 2.6.10-rc1-mm1/include/linux/netdevice.h
===================================================================
--- 2.6.10-rc1-mm1.orig/include/linux/netdevice.h	2004-10-29 11:07:56.000000000 +0300
+++ 2.6.10-rc1-mm1/include/linux/netdevice.h	2004-10-29 11:37:56.000000000 +0300
@@ -500,6 +500,11 @@
 				& ~NETDEV_ALIGN_CONST);
 }
 
+static inline void __iomem *netdev_ioaddr(struct net_device *dev)
+{
+	return (void __iomem *) dev->base_addr;
+}
+
 #define SET_MODULE_OWNER(dev) do { } while (0)
 /* Set the sysfs physical device reference for the network logical device
  * if set prior to registration will cause a symlink during initialization.


