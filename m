Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933360AbWFZWpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360AbWFZWpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWFZWmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:24 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50359 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933345AbWFZWmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:12 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 19/28] [Suspend2] Swapwriter memory needed.
Date: Tue, 27 Jun 2006 08:42:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224209.4975.65210.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the number of pages needed by the swapwriter itself. This doesn't
include the block i/o code, which has its own routine.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index ba1761b..f2940ea 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -805,3 +805,17 @@ out:
 	return 0;
 }
 
+/*
+ * workspace_size
+ *
+ * Description:
+ * Returns the number of bytes of RAM needed for this
+ * code to do its work. (Used when calculating whether
+ * we have enough memory to be able to suspend & resume).
+ *
+ */
+static unsigned long swapwriter_memory_needed(void)
+{
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
