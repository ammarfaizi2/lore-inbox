Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVCPTPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVCPTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVCPTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:15:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13508 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261363AbVCPTNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:13:46 -0500
Date: Wed, 16 Mar 2005 11:12:30 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: trivial@rustcorp.com.au
Cc: Simon Derr <Simon.Derr@bull.net>, Martin Hicks <mort@sgi.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050316191234.25203.12688.sendpatchset@sam.engr.sgi.com>
Subject: [Trivial Patch] cpusets docs - a couple typos
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following fixes a couple of trivial typos in the cpusets
Documentation file, that is now in Linus's bk tree.

Thanks to Martin Hicks <mort@sgi.com> for noticing these.

Signed-off-by: Paul Jackson <pj@sgi.com>

===================================================================
--- 2.6.12-pj.orig/Documentation/cpusets.txt	2005-03-16 01:04:48.000000000 -0800
+++ 2.6.12-pj/Documentation/cpusets.txt	2005-03-16 11:07:35.000000000 -0800
@@ -130,7 +130,7 @@ Cpusets extends these two mechanisms as 
 The implementation of cpusets requires a few, simple hooks
 into the rest of the kernel, none in performance critical paths:
 
- - in main/init.c, to initialize the root cpuset at system boot.
+ - in init/main.c, to initialize the root cpuset at system boot.
  - in fork and exit, to attach and detach a task from its cpuset.
  - in sched_setaffinity, to mask the requested CPUs by what's
    allowed in that tasks cpuset.
@@ -138,7 +138,7 @@ into the rest of the kernel, none in per
    the CPUs allowed by their cpuset, if possible.
  - in the mbind and set_mempolicy system calls, to mask the requested
    Memory Nodes by what's allowed in that tasks cpuset.
- - in page_alloc, to restrict memory to allowed nodes.
+ - in page_alloc.c, to restrict memory to allowed nodes.
  - in vmscan.c, to restrict page recovery to the current cpuset.
 
 In addition a new file system, of type "cpuset" may be mounted,

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
