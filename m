Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263675AbUDVHIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUDVHIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUDVHIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:08:35 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:60839 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263675AbUDVHIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:08:25 -0400
Date: Thu, 22 Apr 2004 00:07:45 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 12 of 17] cpumask v4 - Remove obsolete emulation from
 cpumask.h
Message-Id: <20040422000745.5032a91f.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask12-rm-old-cpumask-emul - Remove obsolete cpumask emulation from cpumask.h
        Now that the emulation of the obsolete cpumask macros is no
        longer needed, remove it from cpumask.h

Index: 2.6.5.bitmap/include/linux/cpumask.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/cpumask.h	2004-04-07 21:34:10.000000000 -0700
+++ 2.6.5.bitmap/include/linux/cpumask.h	2004-04-07 21:57:34.000000000 -0700
@@ -315,16 +315,4 @@
 #define for_each_online_cpu(cpu)     \
 			for_each_cpu_mask(cpu, cpu_online_map)
 
-/* Begin obsolete cpumask operator emulation */
-#define cpu_isset_const(a,b) cpu_isset(a,b)
-#define cpumask_const_t cpumask_t
-#define cpus_coerce(m) (cpus_addr(m)[0])
-#define cpus_coerce_const cpus_coerce
-#define cpus_promote(x) ({ cpumask_t m; m.bits[0] = x; m; })
-#define cpus_weight_const cpus_weight
-#define first_cpu_const first_cpu
-#define mk_cpumask_const(x) x
-#define next_cpu_const next_cpu
-/* End of obsolete cpumask operator emulation */
-
 #endif /* __LINUX_CPUMASK_H */

%diffstat
 cpumask.h |   12 ------------
 1 files changed, 12 deletions(-)



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
