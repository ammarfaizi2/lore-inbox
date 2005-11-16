Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVKPBXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVKPBXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVKPBXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:23:02 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8888 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965137AbVKPBXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:23:00 -0500
Date: Tue, 15 Nov 2005 17:22:54 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Simon Derr <Simon.Derr@bull.net>, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>
Message-Id: <20051116012254.6470.89326.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset export symbols gpl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export the more useful cpuset routines for use by gpl modules.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    5 +++++
 1 files changed, 5 insertions(+)

--- 2.6.14-mm2.orig/kernel/cpuset.c	2005-11-15 16:05:12.717155260 -0800
+++ 2.6.14-mm2/kernel/cpuset.c	2005-11-15 16:14:25.425450732 -0800
@@ -1945,6 +1945,7 @@ cpumask_t cpuset_cpus_allowed(const stru
 
 	return mask;
 }
+EXPORT_SYMBOL_GPL(cpuset_cpus_allowed);
 
 void cpuset_init_current_mems_allowed(void)
 {
@@ -1980,6 +1981,7 @@ done:
 	if (need_to_refresh)
 		refresh_mems();
 }
+EXPORT_SYMBOL_GPL(cpuset_update_current_mems_allowed);
 
 /**
  * cpuset_zonelist_valid_mems_allowed - check zonelist vs. curremt mems_allowed
@@ -1999,6 +2001,7 @@ int cpuset_zonelist_valid_mems_allowed(s
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cpuset_zonelist_valid_mems_allowed);
 
 /*
  * nearest_exclusive_ancestor() - Returns the nearest mem_exclusive
@@ -2079,6 +2082,7 @@ int cpuset_zone_allowed(struct zone *z, 
 	up(&callback_sem);
 	return allowed;
 }
+EXPORT_SYMBOL_GPL(cpuset_zone_allowed);
 
 /**
  * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
@@ -2121,6 +2125,7 @@ done:
 
 	return overlap;
 }
+EXPORT_SYMBOL_GPL(cpuset_excl_nodes_overlap);
 
 /*
  * Collection of memory_pressure is suppressed unless

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
