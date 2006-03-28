Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWC1Top@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWC1Top (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWC1Top
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:44:45 -0500
Received: from xenotime.net ([66.160.160.81]:16020 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751287AbWC1Too (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:44:44 -0500
Date: Tue, 28 Mar 2006 11:46:55 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linux-acpi@vger.kernel.org
Subject: [PATCH -mm] acpi: fix memory_hotplug externs
Message-Id: <20060328114655.05e1933f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Spell CONFIG option correctly so that externs work.
Fixes these warnings:
drivers/acpi/acpi_memhotplug.c:248: warning: implicit declaration of function 'add_memory'
drivers/acpi/acpi_memhotplug.c:312: warning: implicit declaration of function 'remove_memory'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 linsrc/linux-2616-mm2/include/linux/memory_hotplug.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- rddunlap.orig/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
+++ rddunlap/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
@@ -105,7 +105,7 @@ static inline int __remove_pages(struct 
 }
 
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
-	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
+	|| defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
 extern int add_memory(u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
 #endif


---
