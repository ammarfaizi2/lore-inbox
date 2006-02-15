Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423047AbWBOIzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423047AbWBOIzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423050AbWBOIy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:54:59 -0500
Received: from [218.25.172.144] ([218.25.172.144]:61194 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1423047AbWBOIy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:54:58 -0500
Date: Wed, 15 Feb 2006 16:54:56 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] make sysctl_overcommit_memory enumeration sensible
Message-ID: <20060215085456.GA2481@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see system admins often confused when they sysctl vm.overcommit_memory.
This patch makes overcommit_memory enumeration sensible.

0 - no overcommit
1 - always overcommit
2 - heuristic overcommit (default)

I don't feel this would break any userspace scripts. If it seems OK, I'll
update the documents.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 18a5689..e50f5ad 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -10,9 +10,9 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
-#define OVERCOMMIT_GUESS		0
+#define OVERCOMMIT_NEVER		0
 #define OVERCOMMIT_ALWAYS		1
-#define OVERCOMMIT_NEVER		2
+#define OVERCOMMIT_GUESS		2
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern atomic_t vm_committed_space;

-- 
Coywolf Qi Hunt
