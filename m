Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWFZQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWFZQzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWFZQyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:46 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49286 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750914AbWFZQyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/9] [Suspend2] Extents header.
Date: Tue, 27 Jun 2006 02:54:08 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165406.11065.85091.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the header of the extents.c. Extents are used to record the storage
that is used - both swap_entry_ts and sector offsets in devices.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
new file mode 100644
index 0000000..4027bb1
--- /dev/null
+++ b/kernel/power/extent.c
@@ -0,0 +1,19 @@
+/* 
+ * kernel/power/extent.c
+ * 
+ * (C) 2003-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * These functions encapsulate the manipulation of storage metadata. For
+ * pageflags, we use dynamically allocated bitmaps.
+ */
+
+#include <linux/module.h>
+#include <linux/suspend.h>
+#include "modules.h"
+#include "extent.h"
+#include "ui.h"
+
+int suspend_extents_allocated = 0;
+

--
Nigel Cunningham		nigel at suspend2 dot net
