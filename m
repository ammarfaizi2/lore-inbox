Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUHYRVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUHYRVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUHYRVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:21:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4589 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268142AbUHYRVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:21:46 -0400
Date: Wed, 25 Aug 2004 10:21:44 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20040825172147.28782.29339.20446@sam.engr.sgi.com>
Subject: [PATCH] Cpusets - CONFIG_CPUSETS depends on SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's silly, pointless, and untested to offer CONFIG_CPUSETS for
non-SMP configurations.  Make CPUSETS depend on SMP (even though
it doesn't really).

Applies to 2.6.8.1-mm4.  Builds, boots and unit tests on ia64 sn2_defconfig.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.8.1-mm4/init/Kconfig
===================================================================
--- 2.6.8.1-mm4.orig/init/Kconfig	2004-08-25 02:44:08.000000000 -0700
+++ 2.6.8.1-mm4/init/Kconfig	2004-08-25 02:44:21.000000000 -0700
@@ -270,6 +270,7 @@ config EPOLL
 
 config CPUSETS
 	bool "Cpuset support"
+	depends on SMP
 	help
 	  This options will let you create and manage CPUSET's which
 	  allow dynamically partitioning a system into sets of CPUs and

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
