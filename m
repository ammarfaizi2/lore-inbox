Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVLJIT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVLJIT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVLJITg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:36 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:63192 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964964AbVLJITA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:00 -0500
Date: Sat, 10 Dec 2005 00:18:54 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081854.12303.88315.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 02/10] Cpuset: minor spacing initializer fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Four trivial cpuset fixes: remove extra spaces, remove
useless initializers, mark one __read_mostly.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-07 19:17:14.783189624 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-07 19:18:14.776048770 -0800
@@ -54,7 +54,7 @@
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 
-#define CPUSET_SUPER_MAGIC 		0x27e0eb
+#define CPUSET_SUPER_MAGIC		0x27e0eb
 
 /* See "Frequency meter" comments, below. */
 
@@ -154,9 +154,6 @@ static struct cpuset top_cpuset = {
 	.count = ATOMIC_INIT(0),
 	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
 	.children = LIST_HEAD_INIT(top_cpuset.children),
-	.parent = NULL,
-	.dentry = NULL,
-	.mems_generation = 0,
 };
 
 static struct vfsmount *cpuset_mount;
@@ -1341,7 +1338,7 @@ static int cpuset_create_file(struct den
 
 /*
  *	cpuset_create_dir - create a directory for an object.
- *	cs: 	the cpuset we create the directory for.
+ *	cs:	the cpuset we create the directory for.
  *		It must have a valid ->parent field
  *		And we are going to fill its ->dentry field.
  *	name:	The name to give to the cpuset directory. Will be copied.
@@ -2049,7 +2046,7 @@ done:
  * cpuset file 'memory_pressure_enabled' in the root cpuset.
  */
 
-int cpuset_memory_pressure_enabled;
+int cpuset_memory_pressure_enabled __read_mostly;
 
 /**
  * cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
