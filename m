Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVGZHd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVGZHd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVGZHd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:33:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46487 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261834AbVGZHdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:33:25 -0400
Date: Tue, 26 Jul 2005 09:33:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [RFC] fix compilation in mcp-core.c
Message-ID: <20050726073308.GA28837@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had to do this to get mcp-core to compile, but it feels wrong. Where
do I get device_unregister_wait?
								Pavel


diff --git a/drivers/misc/mcp-core.c b/drivers/misc/mcp-core.c
--- a/drivers/misc/mcp-core.c
+++ b/drivers/misc/mcp-core.c
@@ -198,7 +198,7 @@ int mcp_host_register(struct mcp *mcp, s
 
 void mcp_host_unregister(struct mcp *mcp)
 {
-	device_unregister_wait(&mcp->attached_device);
+	device_unregister(&mcp->attached_device);
 }
 
 int mcp_driver_register(struct mcp_driver *mcpdrv)

-- 
teflon -- maybe it is a trademark, but it should not be.
