Return-Path: <linux-kernel-owner+w=401wt.eu-S1751131AbXAFCni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbXAFCni (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbXAFC2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:28:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47947 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbXAFC1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:53 -0500
Message-Id: <20070106023135.108744000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Tim Chen <tim.c.chen@linux.intel.com>,
       suresh.b.siddha@intel.com, Tim Chen <tim.c.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [patch 14/50] sched: remove __cpuinitdata anotation to cpu_isolated_map
Content-Disposition: inline; filename=sched-remove-__cpuinitdata-anotation-to-cpu_isolated_map.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tim Chen <tim.c.chen@linux.intel.com>

The structure cpu_isolated_map is used not only during initialization. 
Multi-core scheduler configuration changes and exclusive cpusets 
use this during run time.  During setting of sched_mc_power_savings
 policy, this structure is accessed to update sched_domains.

Signed-off-by: Tim Chen <tim.c.chen@intel.com>
Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 kernel/sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/kernel/sched.c
+++ linux-2.6.19.1/kernel/sched.c
@@ -5493,7 +5493,7 @@ static void cpu_attach_domain(struct sch
 }
 
 /* cpus with isolated domains */
-static cpumask_t __cpuinitdata cpu_isolated_map = CPU_MASK_NONE;
+static cpumask_t cpu_isolated_map = CPU_MASK_NONE;
 
 /* Setup the mask of cpus configured for isolated domains */
 static int __init isolated_cpu_setup(char *str)

--
