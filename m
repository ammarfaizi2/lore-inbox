Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269716AbUICRhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269716AbUICRhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269680AbUICRdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:33:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11907 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269611AbUICRdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:33:19 -0400
Date: Fri, 3 Sep 2004 10:33:15 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20040903173318.15276.75455.31180@sam.engr.sgi.com>
Subject: [PATCH] Cpusets - Dont export proc_cpuset_operations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove gratuitous EXPORT_SYMBOL of proc_cpuset_operations.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1.orig/kernel/cpuset.c	2004-09-03 09:02:29.000000000 -0700
+++ 2.6.9-rc1/kernel/cpuset.c	2004-09-03 09:02:34.000000000 -0700
@@ -1500,4 +1500,3 @@ struct file_operations proc_cpuset_opera
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-EXPORT_SYMBOL(proc_cpuset_operations);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
