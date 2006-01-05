Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWAEOkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWAEOkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWAEOkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:40:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45071 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751372AbWAEOkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:40:01 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 20/29] Add MCP bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:39:56 +0000
Message-ID: <20060105142951.13.20@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/mfd/mcp-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/mfd/mcp-core.c linux/drivers/mfd/mcp-core.c
--- linus/drivers/mfd/mcp-core.c	Mon Nov  7 19:57:44 2005
+++ linux/drivers/mfd/mcp-core.c	Sun Nov 13 16:31:11 2005
@@ -77,6 +77,8 @@ static int mcp_bus_resume(struct device 
 static struct bus_type mcp_bus_type = {
 	.name		= "mcp",
 	.match		= mcp_bus_match,
+	.probe		= mcp_bus_probe,
+	.remove		= mcp_bus_remove,
 	.suspend	= mcp_bus_suspend,
 	.resume		= mcp_bus_resume,
 };
@@ -227,8 +229,6 @@ EXPORT_SYMBOL(mcp_host_unregister);
 int mcp_driver_register(struct mcp_driver *mcpdrv)
 {
 	mcpdrv->drv.bus = &mcp_bus_type;
-	mcpdrv->drv.probe = mcp_bus_probe;
-	mcpdrv->drv.remove = mcp_bus_remove;
 	return driver_register(&mcpdrv->drv);
 }
 EXPORT_SYMBOL(mcp_driver_register);
