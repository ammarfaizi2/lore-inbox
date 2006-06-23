Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWFWQtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWFWQtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWFWQtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:49:46 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:7514 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751776AbWFWQtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:49:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QnBqPpzgtKvxjXFOA7FhQbVbB3yFNzpC1DpGUI0YOGZOT3Cex8qbQ+X8jogGP+csm3ZOPuKmTo3K7LuRw+VXMRDQpY+EYiGBdAHyV33xxMqKSatu3DGHCgIZQQlJroBB+3Jy9PlxYTGSkSS8Z2g8eA4FwkY9il8D1YXN/dEMdQY=  ;
Message-ID: <20060623164945.73399.qmail@web31809.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 09:49:45 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lets use 19+1 chars.  This helps display properly
kernel threads (e.g. SATA translation threads) which bear
the address of the STP/SATA bridge where the SATA disk is
connected. Those are 16+1 chars long.  Currently (15+1) the last
character is not displayed as it is used by the '\0'.

The array is 4 byte aligned so we add another 4 bytes to it.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 include/linux/sched.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 18f12cb..3fc11bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -154,7 +154,7 @@ #define set_current_state(state_value)
        set_mb(current->state, (state_value))
 
 /* Task command name length */
-#define TASK_COMM_LEN 16
+#define TASK_COMM_LEN 20
 
 /*
  * Scheduling policies
-- 
1.4.0.g470d


