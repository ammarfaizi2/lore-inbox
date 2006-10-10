Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWJJV4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWJJV4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWJJVrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:47:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26299 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030496AbWJJVrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:08 -0400
To: torvalds@osdl.org
Subject: [PATCH] passing pointer to setup_timer() should be via unsigned long
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPRL-0007Nk-Av@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:47:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/mmc/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 6d02434..9a7d39b 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1329,7 +1329,7 @@ static int __devinit sdhci_probe_slot(st
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
-	setup_timer(&host->timer, sdhci_timeout_timer, (long)host);
+	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
 
 	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
 		host->slot_descr, host);
-- 
1.4.2.GIT


