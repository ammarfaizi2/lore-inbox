Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUEFTC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUEFTC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUEFS7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:59:47 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:23119 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262347AbUEFSt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:59 -0400
Date: Thu, 6 May 2004 11:49:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 14/15] mask8-rm-old-cpumask-emul
Message-Id: <20040506114918.5065af67.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mask8-rm-old-cpumask-emul
        Now that the emulation of the obsolete cpumask macros is no
        longer needed, remove it from cpumask.h

Index: 2.6.6-rc3-mm2-bitmapv5/include/linux/cpumask.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/linux/cpumask.h	2004-05-06 03:29:48.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/linux/cpumask.h	2004-05-06 03:30:05.000000000 -0700
@@ -320,16 +320,4 @@
 #define cpu_present(cpu)                cpu_isset(cpu, cpu_present_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
 
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

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
