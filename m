Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVJUX4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVJUX4Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 19:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVJUX4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 19:56:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965197AbVJUX4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 19:56:23 -0400
Date: Fri, 21 Oct 2005 16:56:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: Dave Jones <davej@redhat.com>, Mark Langsdorf <mark.langsdorf@amd.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] typo fix in last cpufreq powernow patch
Message-ID: <20051021235608.GS5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure how it slipped by, but here's a trivial typo fix for powernow.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -175,7 +175,7 @@ static int write_new_fid(struct powernow
 		wrmsr(MSR_FIDVID_CTL, lo, data->plllock * PLL_LOCK_CONVERSION);
 		if (i++ > 100) {
 			printk(KERN_ERR PFX "internal error - pending bit very stuck - no further pstate changes possible\n");
-			retrun 1;
+			return 1;
 		}			
 	} while (query_current_values_with_pending_wait(data));
 
