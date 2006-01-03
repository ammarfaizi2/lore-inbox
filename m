Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWACVR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWACVR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWACVR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:26 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:10434 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964868AbWACVQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:16:50 -0500
Subject: [PATCH] set_page_count complex args
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:16:45 -0500
Message-Id: <1136323005.21485.15.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avishay Traeger <atraeger@cs.sunysb.edu>

Fix set_page_count() macro to handle complex arguments.

Signed-off-by: Avishay Traeger <atraeger@cs.sunysb.edu>
---

--- linux-2.6.15/include/linux/mm.h.orig	2006-01-03 15:47:32.000000000 -0500
+++ linux-2.6.15/include/linux/mm.h	2006-01-03 15:47:51.000000000 -0500
@@ -308,7 +308,7 @@ struct page {
  */
 #define get_page_testone(p)	atomic_inc_and_test(&(p)->_count)
 
-#define set_page_count(p,v) 	atomic_set(&(p)->_count, v - 1)
+#define set_page_count(p,v) 	atomic_set(&(p)->_count, (v) - 1)
 #define __put_page(p)		atomic_dec(&(p)->_count)
 
 extern void FASTCALL(__page_cache_release(struct page *));


