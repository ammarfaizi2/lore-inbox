Return-Path: <linux-kernel-owner+w=401wt.eu-S1422683AbXAETGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbXAETGY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbXAETGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:06:24 -0500
Received: from xenotime.net ([66.160.160.81]:59123 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422684AbXAETGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:06:23 -0500
Date: Fri, 5 Jan 2007 11:06:28 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, kernel@bardioc.dyndns.org
Subject: [PATCH] sysrq: showBlockedTasks is sysrq-X
Message-Id: <20070105110628.5f1e487d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

SysRq showBlockedTasks is not done via B or T, it's done via X,
so put that in the Help message.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/sysrq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2620-rc3g4.orig/drivers/char/sysrq.c
+++ linux-2620-rc3g4/drivers/char/sysrq.c
@@ -215,7 +215,7 @@ static void sysrq_handle_showstate_block
 }
 static struct sysrq_key_op sysrq_showstate_blocked_op = {
 	.handler	= sysrq_handle_showstate_blocked,
-	.help_msg	= "showBlockedTasks",
+	.help_msg	= "showBlockedTasks(X)",
 	.action_msg	= "Show Blocked State",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };


---
~Randy
