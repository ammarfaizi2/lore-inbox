Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUIPB3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUIPB3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUIPB3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:29:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10961 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267367AbUIPB3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:29:47 -0400
Date: Wed, 15 Sep 2004 18:29:12 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
Subject: [Patch] cpusets: document proc status allowed fields
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document the /proc/<pid>/status fields added in an
earlier cpuset patch for Cpus_allowed and Mems_allowed.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm4/Documentation/cpusets.txt
===================================================================
--- 2.6.9-rc1-mm4.orig/Documentation/cpusets.txt	2004-09-08 15:09:56.000000000 -0700
+++ 2.6.9-rc1-mm4/Documentation/cpusets.txt	2004-09-12 00:29:01.000000000 -0700
@@ -151,6 +151,14 @@ Each task under /proc has an added file 
 the cpuset name, as the path relative to the root of the cpuset file
 system.
 
+The /proc/<pid>/status file for each task has two added lines,
+displaying the tasks cpus_allowed (on which CPUs it may be scheduled)
+and mems_allowed (on which Memory Nodes it may obtain memory),
+in the format seen in the following example:
+
+  Cpus_allowed:   ffffffff,ffffffff,ffffffff,ffffffff
+  Mems_allowed:   ffffffff,ffffffff
+
 Each cpuset is represented by a directory in the cpuset file system
 containing the following files describing that cpuset:
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
