Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbUJ2AHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUJ2AHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUJ2AAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:00:34 -0400
Received: from colin2.muc.de ([193.149.48.15]:15110 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263141AbUJ1XrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:47:21 -0400
Date: 29 Oct 2004 01:47:18 +0200
Date: Fri, 29 Oct 2004 01:47:18 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: [PATCH] x86_64: Fix warning in genapic
Message-ID: <20041028234718.GB94390@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Straight forward patch to remove a warning in genapic about
a unused function.

Independently done by Chris Wright too.

Signed-off-by: Andi Kleen <ak@muc.de>

Index: linux/arch/x86_64/kernel/genapic_cluster.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic_cluster.c	2004-10-29 01:16:46.%N +0200
+++ linux/arch/x86_64/kernel/genapic_cluster.c	2004-10-29 01:17:21.%N +0200
@@ -57,14 +57,6 @@
 	apic_write_around(APIC_LDR, val);
 }
 
-static int cluster_cpu_present_to_apicid(int mps_cpu)
-{
-	if ((unsigned)mps_cpu < NR_CPUS)
-		return (int)bios_cpu_apicid[mps_cpu];
-	else
-		return BAD_APICID;
-}
-
 /* Start with all IRQs pointing to boot CPU.  IRQ balancing will shift them. */
 
 static cpumask_t cluster_target_cpus(void)
