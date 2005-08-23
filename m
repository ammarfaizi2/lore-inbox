Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVHWVpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVHWVpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVHWVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:45:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19894 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932446AbVHWVoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:54 -0400
To: torvalds@osdl.org
Subject: [PATCH] (38/43) missing exports on m32r
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gcf-0007Ez-Ev@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missing exports on m32r

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-isa_type/arch/m32r/lib/csum_partial_copy.c RC13-rc6-git13-m32r-exports/arch/m32r/lib/csum_partial_copy.c
--- RC13-rc6-git13-isa_type/arch/m32r/lib/csum_partial_copy.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-m32r-exports/arch/m32r/lib/csum_partial_copy.c	2005-08-21 13:17:36.000000000 -0400
@@ -58,3 +58,4 @@
 	return csum_partial(dst, len-missing, sum);
 }
 EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_partial);
diff -urN RC13-rc6-git13-isa_type/arch/m32r/mm/discontig.c RC13-rc6-git13-m32r-exports/arch/m32r/mm/discontig.c
--- RC13-rc6-git13-isa_type/arch/m32r/mm/discontig.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-m32r-exports/arch/m32r/mm/discontig.c	2005-08-21 13:17:36.000000000 -0400
@@ -12,12 +12,14 @@
 #include <linux/mmzone.h>
 #include <linux/initrd.h>
 #include <linux/nodemask.h>
+#include <linux/module.h>
 
 #include <asm/setup.h>
 
 extern char _end[];
 
 struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 static bootmem_data_t node_bdata[MAX_NUMNODES] __initdata;
 
 pg_data_t m32r_node_data[MAX_NUMNODES];
