Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269620AbUICKBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269620AbUICKBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUICJ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:57:23 -0400
Received: from gsecone.com ([61.95.227.64]:61825 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S269617AbUICJxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:53:49 -0400
Subject: [2.6.8+][TRIVIAL] linux/mm.h compilation fix
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: akpm@digeo.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1094204918.5476.35.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 15:18:39 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial compilation fix when shared memory is not enabled.

Signed-off-by: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>

--- linux-2.6.9-rc1-mm2/include/linux/mm.h	2004-09-03 13:01:52.000000000 +0530
+++ linux-2.6.9-rc1-mm2-nvk/include/linux/mm.h	2004-09-03 15:20:59.000000000 +0530
@@ -528,7 +528,7 @@
 int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #else
 #define shmem_nopage filemap_nopage
-#define shmem_lock(a, b) /* always in memory, no need to lock */
+#define shmem_lock(a, b, c) /* always in memory, no need to lock */
 #define shmem_set_policy(a, b) (0)
 #define shmem_get_policy(a, b) (NULL)
 #endif


