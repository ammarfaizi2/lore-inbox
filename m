Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWFZQxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWFZQxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWFZQxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42886 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750839AbWFZQxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/11] [Suspend2] Modules.c header.
Date: Tue, 27 Jun 2006 02:53:05 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165303.10957.10587.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header of modules.c file, which contains routines specifically related to
the interaction between Suspend2's core code and the modules that implement
encryption, compression, i/o and the like.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
new file mode 100644
index 0000000..f337208
--- /dev/null
+++ b/kernel/power/modules.c
@@ -0,0 +1,18 @@
+/*
+ * kernel/power/modules.c
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include "suspend2.h"
+#include "modules.h"
+#include "ui.h"
+
+struct list_head suspend_filters, suspend_writers, suspend_modules;
+struct suspend_module_ops *suspend_active_writer;
+static int suspend_num_filters;
+int suspend_num_writers, suspend_num_modules;
+       

--
Nigel Cunningham		nigel at suspend2 dot net
