Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUDAV5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUDAV0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:26:53 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:19251 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263180AbUDAVMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:50 -0500
Date: Thu, 1 Apr 2004 13:12:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 10/23] mask v2 - Remove obsolete cpumask emulation
Message-Id: <20040401131204.77d0264e.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_10_of_23 - Remove obsolete cpumask emulation from cpumask.h
	Now that the emulation of the obsolete cpumask macros is no
	longer needed, remove it from cpumask.h

Diffstat Patch_10_of_23:
 cpumask.h                      |   12 ------------
 1 files changed, 12 deletions(-)

===================================================================
--- 2.6.4.orig/include/linux/cpumask.h	2004-04-01 09:35:15.000000000 -0800
+++ 2.6.4/include/linux/cpumask.h	2004-04-01 09:40:07.000000000 -0800
@@ -155,16 +155,4 @@
 #define for_each_online_cpu(cpu)     \
 			for_each_cpu_mask(cpu, cpu_online_map)
 
-/* Begin obsolete cpumask operator emulation */
-#define cpu_isset_const(a,b) cpu_isset(a,b)
-#define cpumask_const_t cpumask_t
-#define cpus_coerce(m) (cpus_addr(m)[0])
-#define cpus_coerce_const cpus_coerce
-#define cpus_promote(x) ({ cpumask_t m; m._m[0] = x; m; })
-#define cpus_weight_const cpus_weight
-#define first_cpu_const first_cpu
-#define mk_cpumask_const(x) x
-#define next_cpu_const next_cpu
-/* End of obsolete cpumask operator emulation */
-
 #endif /* __LINUX_CPUMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
