Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUHFIMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUHFIMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUHFIMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:12:35 -0400
Received: from holomorphy.com ([207.189.100.168]:58057 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265462AbUHFILW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:11:22 -0400
Date: Fri, 6 Aug 2004 01:11:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: alpha signal race fixes
Message-ID: <20040806081116.GX17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040806075219.GW17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806075219.GW17188@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 12:52:19AM -0700, William Lee Irwin III wrote:
> It appears alpha needs an update here also. The rampant variable
> renaming made my eyes bleed, so I omitted that from here. Anyhow, the
> test app works after I apply this, so I must have done something right.

And one more alpha fix for the profiling consolidation:


Index: mm1-2.6.8-rc3/arch/alpha/kernel/irq.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/alpha/kernel/irq.c	2004-08-05 07:09:23.000000000 -0700
+++ mm1-2.6.8-rc3/arch/alpha/kernel/irq.c	2004-08-05 23:41:24.000000000 -0700
@@ -329,9 +329,6 @@
 void
 init_irq_proc (void)
 {
-#ifdef CONFIG_SMP
-	struct proc_dir_entry *entry;
-#endif
 	int i;
 
 	/* create /proc/irq */
