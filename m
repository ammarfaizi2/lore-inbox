Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHAEqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHAEqx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 00:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUHAEqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 00:46:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:32195 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265196AbUHAEqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 00:46:51 -0400
Date: Sat, 31 Jul 2004 21:45:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: colpatch@us.ibm.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Create cpu_sibling_map for PPC64
Message-Id: <20040731214512.36123c10.akpm@osdl.org>
In-Reply-To: <1091049554.19459.33.camel@arrakis>
References: <1091049554.19459.33.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> In light of some proposed changes in the sched_domains code, I coded up
>  this little ditty that simply creates and populates a cpu_sibling_map
>  for PPC64 machines.

err, did you compile it?

--- 25-power4/arch/ppc64/kernel/smp.c~create-cpu_sibling_map-for-ppc64-fix	2004-07-31 21:43:18.620845384 -0700
+++ 25-power4-akpm/arch/ppc64/kernel/smp.c	2004-07-31 21:43:21.258444408 -0700
@@ -64,7 +64,7 @@ cpumask_t cpu_possible_map = CPU_MASK_NO
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t cpu_available_map = CPU_MASK_NONE;
 cpumask_t cpu_present_at_boot = CPU_MASK_NONE;
-cpumask_t cpu_sibling_map[NR_CPUS] = { [0 .. NR_CPUS-1] = CPU_MASK_NONE };
+cpumask_t cpu_sibling_map[NR_CPUS] = { [0 ... NR_CPUS-1] = CPU_MASK_NONE };
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
_

