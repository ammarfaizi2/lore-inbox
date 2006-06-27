Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWF0FAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWF0FAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWF0E7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:59:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32731 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932251AbWF0EkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/4] [Suspend2] Power_off.c header.
Date: Tue, 27 Jun 2006 14:40:13 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044012.14736.81596.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
References: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel/power/power_off.c header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/power_off.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/power_off.c b/kernel/power/power_off.c
new file mode 100644
index 0000000..8f9f425
--- /dev/null
+++ b/kernel/power/power_off.c
@@ -0,0 +1,26 @@
+/*
+ * kernel/power/power_off.c
+ *
+ * Copyright (C) 2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Support for powering down.
+ */
+
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/reboot.h>
+#include "suspend2_common.h"
+#include "suspend2.h"
+#include "ui.h"
+
+unsigned long suspend_powerdown_method = 0; /* 0 - Kernel power off */
+
+extern struct pm_ops *pm_ops;
+
+/* Use suspend_enter from main.c */
+extern int suspend_enter(suspend_state_t state);
+

--
Nigel Cunningham		nigel at suspend2 dot net
