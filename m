Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVI3DTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVI3DTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 23:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVI3DTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 23:19:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24987 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751366AbVI3DTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 23:19:44 -0400
Date: Fri, 30 Sep 2005 04:19:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] volatile unsigned short f(...) doesn't make sense
Message-ID: <20050930031943.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/drivers/net/bmac.c current/drivers/net/bmac.c
--- RC14-rc2-git6-base/drivers/net/bmac.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/net/bmac.c	2005-09-29 22:55:03.000000000 -0400
@@ -218,7 +218,7 @@
 
 
 static inline
-volatile unsigned short bmread(struct net_device *dev, unsigned long reg_offset )
+unsigned short bmread(struct net_device *dev, unsigned long reg_offset )
 {
 	return in_le16((void __iomem *)dev->base_addr + reg_offset);
 }
