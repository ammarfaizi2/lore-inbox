Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265806AbUFIPw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUFIPw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUFIPw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:52:58 -0400
Received: from holomorphy.com ([207.189.100.168]:19845 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265806AbUFIPww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:52:52 -0400
Date: Wed, 9 Jun 2004 08:52:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Maas <peter@7pt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609155249.GP1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Maas <peter@7pt.net>, linux-kernel@vger.kernel.org
References: <001c01c44e37$1114f350$3205a8c0@pixl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c01c44e37$1114f350$3205a8c0@pixl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 10:33:08AM -0500, Peter Maas wrote:
> K8 Numa broken...
> 
>   LD      arch/x86_64/mm/hugetlbpage.o
>   CC      arch/x86_64/mm/numa.o
> arch/x86_64/mm/numa.c: In function `numa_initmem_init':
> arch/x86_64/mm/numa.c:185: error: incompatible types in assignment
> make[1]: *** [arch/x86_64/mm/numa.o] Error 1

Index: mm1-2.6.7-rc3/arch/x86_64/mm/numa.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/x86_64/mm/numa.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/x86_64/mm/numa.c	2004-06-09 08:52:40.000000000 -0700
@@ -182,7 +182,7 @@
 	numnodes = 1;
 	for (i = 0; i < NR_CPUS; i++)
 		cpu_to_node[i] = 0;
-	node_to_cpumask[0] = 1;
+	node_to_cpumask[0] = cpumask_of_cpu(0);
 	setup_node_bootmem(0, start_pfn<<PAGE_SHIFT, end_pfn<<PAGE_SHIFT);
 }
 
