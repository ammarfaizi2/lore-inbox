Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933099AbWFZWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933099AbWFZWcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933102AbWFZWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:60906 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933099AbWFZWbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:38 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/7] [Suspend2] Return number of zones used.
Date: Tue, 27 Jun 2006 08:31:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223135.3725.11811.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the number of zones used. Used when relocating the pageflags (below).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.c b/kernel/power/pageflags.c
index 81f0825..3781fc8 100644
--- a/kernel/power/pageflags.c
+++ b/kernel/power/pageflags.c
@@ -26,3 +26,14 @@ dyn_pageflags_t pageset1_copy_map;
 dyn_pageflags_t pageset2_map;
 dyn_pageflags_t in_use_map;
 
+static int num_zones(void)
+{
+	int result = 0;
+	struct zone *zone;
+
+	for_each_zone(zone)
+		result++;
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
