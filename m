Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933151AbWFZXgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbWFZXgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933112AbWFZWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:46 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28063 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933119AbWFZWeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:17 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/9] [Suspend2] Pagedir.c header.
Date: Tue, 27 Jun 2006 08:34:16 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223414.3963.25082.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the header for pagedir functions - that is, functions specifically
related to the image metadata.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
new file mode 100644
index 0000000..1e0995e
--- /dev/null
+++ b/kernel/power/pagedir.c
@@ -0,0 +1,33 @@
+/*
+ * kernel/power/pagedir.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for handling pagesets.
+ * Note that pbes aren't actually stored as such. They're stored as
+ * bitmaps and extents.
+ */
+
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <linux/hardirq.h>
+#include <linux/sched.h>
+
+#include "pageflags.h"
+#include "ui.h"
+#include "pagedir.h"
+
+int extra_pagedir_pages_allocated;
+
+struct extras {
+	struct page *page;
+	int order;
+	struct extras *next;
+} *extras_list;
+

--
Nigel Cunningham		nigel at suspend2 dot net
