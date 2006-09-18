Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWIRAxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWIRAxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWIRAxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:53:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965188AbWIRAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:53:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O6+ZA9Vyg5H9SBLylVExAioyTixpZOP/BxxUUHY6KO2CupAgRuS5UpNOYlTjWMXT6zady5dUhyLsOUtLtUe7nh2feCmf6pcEa458W4d96QZKRpzHnYDckqsmFVYrt5Tkz2tx9vUwhMHMKgQ0g4KXoL+mvF36UtlH95fPSnVVDG0=
Message-ID: <6b4e42d10609171753m1836aaf3y52788c84a52d5e6a@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:53:42 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: kmalloc to kzalloc patches for drivers/mfd
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by compiling.

Signed off by Om Narasimhan <om.turyx@gmail.com>

 drivers/mfd/mcp-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 75f401d..b4ed57e 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -200,9 +200,8 @@ struct mcp *mcp_host_alloc(struct device
 {
 	struct mcp *mcp;

-	mcp = kmalloc(sizeof(struct mcp) + size, GFP_KERNEL);
+	mcp = kzalloc(sizeof(struct mcp) + size, GFP_KERNEL);
 	if (mcp) {
-		memset(mcp, 0, sizeof(struct mcp) + size);
 		spin_lock_init(&mcp->lock);
 		mcp->attached_device.parent = parent;
 		mcp->attached_device.bus = &mcp_bus_type;
