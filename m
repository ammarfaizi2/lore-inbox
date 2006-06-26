Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933237AbWFZWhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933237AbWFZWhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWFZWh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:27 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:55199 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933226AbWFZWhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/32] [Suspend2] Reset block io stats.
Date: Tue, 27 Jun 2006 08:37:16 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223715.4376.24653.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple helper which resets the statistics to zero at the start of a cycle.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 94f1946..51e02ef 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -128,3 +128,19 @@ static struct suspend_bdev_info *suspend
 
 int suspend_header_bytes_used = 0;
 
+/*
+ * suspend_reset_io_stats
+ *
+ * Description:	Reset all our sanity-checking statistics.
+ */
+static void suspend_reset_io_stats(void)
+{
+	int i;
+	
+	max_outstanding_io = 0;
+	maxinfopages = 0;
+	
+	for (i = 0; i < 8; i++)
+		nr_schedule_calls[i] = 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
