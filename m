Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUDEVRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUDEVOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:14:36 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:36480 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263211AbUDEVLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:11:40 -0400
Date: Mon, 5 Apr 2004 23:11:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, davej@redhat.com
Subject: Cleanup cpufreq.c
Message-ID: <20040405211130.GA3587@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This removes useless goto. Please apply,
							Pavel

Index: linux/drivers/cpufreq/cpufreq.c
===================================================================
--- linux.orig/drivers/cpufreq/cpufreq.c	2004-04-05 22:47:33.000000000 +0200
+++ linux/drivers/cpufreq/cpufreq.c	2004-03-11 18:16:08.000000000 +0100
@@ -509,14 +509,10 @@
 	 */
 		ret = cpufreq_driver->target(cpu_policy, cpu_policy->cur, CPUFREQ_RELATION_H);
 
-	if (ret) {
+	if (ret)
 		printk(KERN_ERR "cpufreq: resume failed in ->setpolicy/target step on CPU %u\n", cpu_policy->cpu);
-		goto out;
-	}
-
  out:
 	cpufreq_cpu_put(cpu_policy);
-
 	return ret;
 }
 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
