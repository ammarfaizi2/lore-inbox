Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267499AbUHEEwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267499AbUHEEwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267546AbUHEEuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:50:54 -0400
Received: from holomorphy.com ([207.189.100.168]:961 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267516AbUHEEty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:49:54 -0400
Date: Wed, 4 Aug 2004 21:49:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [8/13] define cache_decay_ticks
Message-ID: <20040805044950.GZ2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805044839.GY2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:48:39PM -0700, William Lee Irwin III wrote:
> num_context_patch2 is never defined, only declared. However, these
> declarations generate an undefined symbol reference. So remove it.

cache_decay_ticks needs to be defined in order for the kernel to link.
This placeholder is inaccurate, however, other, more grave SMP issues
need to be addressed first.

Index: mm2-2.6.8-rc2/arch/sparc/kernel/smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/smp.c
@@ -45,6 +45,7 @@
 volatile int __cpu_number_map[NR_CPUS];
 volatile int __cpu_logical_map[NR_CPUS];
 cycles_t cacheflush_time = 0; /* XXX */
+unsigned long cache_decay_ticks = 100;
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
