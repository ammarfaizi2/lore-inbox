Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVHHWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVHHWbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVHHWbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:21 -0400
Received: from coderock.org ([193.77.147.115]:40579 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932305AbVHHWbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:09 -0400
Message-Id: <20050808223054.376836000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:50 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 14/16] net/tms380tr: replace direct assignment with set_current_state()
Content-Disposition: inline; filename=set_current_state-drivers_net_tokenring_tms380tr.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use set_current_state() instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 tms380tr.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/net/tokenring/tms380tr.c
===================================================================
--- quilt.orig/drivers/net/tokenring/tms380tr.c
+++ quilt/drivers/net/tokenring/tms380tr.c
@@ -1244,7 +1244,7 @@ void tms380tr_wait(unsigned long time)
 	
 	tmp = jiffies + time/(1000000/HZ);
 	do {
-  		current->state 		= TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		tmp = schedule_timeout(tmp);
 	} while(time_after(tmp, jiffies));
 #else

--
