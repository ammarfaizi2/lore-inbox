Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVIMQBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVIMQBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVIMQBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:01:50 -0400
Received: from serv01.siteground.net ([70.85.91.68]:63696 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964826AbVIMQBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:01:49 -0400
Date: Tue, 13 Sep 2005 09:01:41 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 5/11] mm: Bigrefs -- add_getcpuptr
Message-ID: <20050913160141.GG3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reintroduce __get_cpu_ptr for bigrefs

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>


Index: alloc_percpu-2.6.13-rc6/include/linux/percpu.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/percpu.h	2005-08-15 15:31:35.770020000 -0400
+++ alloc_percpu-2.6.13-rc6/include/linux/percpu.h	2005-08-15 17:12:57.745572000 -0400
@@ -59,4 +59,5 @@
 		   __alignof__(type), gfpflags)));			\
 })
 
+#define __get_cpu_ptr(ptr) per_cpu_ptr(ptr, smp_processor_id())
 #endif /* __LINUX_PERCPU_H */
