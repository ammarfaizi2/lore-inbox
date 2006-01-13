Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWAMTxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWAMTxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbWAMTv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:59284 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422888AbWAMTue convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:34 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add MCP bus_type probe and remove methods
In-Reply-To: <11371818103670@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818102735@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add MCP bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 413b486e18587fd53c9954252e6648f9450c734e
tree de5bb0cea40571fb97d93b54746cf21f214df971
parent 4866b124a1ded3b94b0cea0bd543f46ffa9a3943
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:39:56 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:08 -0800

 drivers/mfd/mcp-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 55ba230..75f401d 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
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

