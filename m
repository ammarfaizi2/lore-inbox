Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933105AbWFZWbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbWFZWbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbWFZWbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:35 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:60394 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933105AbWFZWbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/7] [Suspend2] Pagedir.h
Date: Tue, 27 Jun 2006 08:31:33 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223131.3725.40537.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add pagedir structs and declarations for variables and functions exported
from pagedir.c.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.c b/kernel/power/pageflags.c
new file mode 100644
index 0000000..81f0825
--- /dev/null
+++ b/kernel/power/pageflags.c
@@ -0,0 +1,28 @@
+/*
+ * kernel/power/pageflags.c
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ * 
+ * This file is released under the GPLv2.
+ *
+ * Routines for serialising and relocating pageflags in which we
+ * store our image metadata.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/list.h>
+#include <linux/suspend.h>
+#include "pageflags.h"
+#include "modules.h"
+#include "pagedir.h"
+
+/* Maps used in copying the image back are in builtin.c */
+dyn_pageflags_t pageset1_map;
+dyn_pageflags_t pageset1_copy_map;
+dyn_pageflags_t pageset2_map;
+dyn_pageflags_t in_use_map;
+

--
Nigel Cunningham		nigel at suspend2 dot net
