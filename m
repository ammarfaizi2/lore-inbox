Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUFCRUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUFCRUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUFCRSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:18:45 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:41698 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265590AbUFCRMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:12:25 -0400
Date: Thu, 3 Jun 2004 10:11:05 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] cpumask 9/10 Remove no longer used obsolete macro emulation
Message-Id: <20040603101105.42c7ceef.pj@sgi.com>
In-Reply-To: <20040603094339.03ddfd42.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask 9/10 Remove no longer used obsolete macro emulation

        Now that the emulation of the obsolete cpumask macros is no
        longer needed, remove it from cpumask.h

 include/linux/cpumask.h |   12 ------------
 1 files changed, 12 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/include/linux/cpumask.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/linux/cpumask.h	2004-06-03 07:04:31.000000000 -0700
+++ 2.6.7-rc2-mm2/include/linux/cpumask.h	2004-06-03 07:08:04.000000000 -0700
@@ -364,16 +364,4 @@
 #define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
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
