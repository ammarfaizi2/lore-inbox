Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVHHWb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVHHWb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVHHWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:46 -0400
Received: from coderock.org ([193.77.147.115]:45187 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932305AbVHHWbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:21 -0400
Message-Id: <20050808223047.611059000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:49 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 13/16] net/stir4200: replace direct assignment with set_current_state()
Content-Disposition: inline; filename=set_current_state-drivers_net_irda_stir4200.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use set_current_state() instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 stir4200.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/net/irda/stir4200.c
===================================================================
--- quilt.orig/drivers/net/irda/stir4200.c
+++ quilt/drivers/net/irda/stir4200.c
@@ -679,7 +679,7 @@ static void turnaround_delay(const struc
 
 	ticks = us / (1000000 / HZ);
 	if (ticks > 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1 + ticks);
 	} else
 		udelay(us);

--
