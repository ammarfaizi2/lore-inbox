Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWFZQ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWFZQ4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWFZQyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:40 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52358 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750931AbWFZQyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 7/9] [Suspend2] Extent state to the start.
Date: Tue, 27 Jun 2006 02:54:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165427.11065.77307.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reset an extent state to the start of the data.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index 8cbb48a..248e4de 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -249,3 +249,14 @@ unsigned long suspend_extent_state_next(
 	return state->current_offset;
 }
 
+/* suspend_extent_state_goto_start
+ *
+ * Find the first valid value in a group of chains.
+ */
+void suspend_extent_state_goto_start(struct extent_iterate_state *state)
+{
+	state->current_chain = -1;
+	state->current_extent = NULL;
+	state->current_offset = 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
