Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWA2Q5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWA2Q5D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 11:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWA2Q5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 11:57:02 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7646 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751081AbWA2Q5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 11:57:00 -0500
Date: Sun, 29 Jan 2006 17:56:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060129165645.GF1764@elf.ucw.cz>
References: <20060126015132.A8521@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060126015132.A8521@unix-os.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 26-01-06 01:51:33, Siddha, Suresh B wrote:
> Appended patch adds a new sched domain for representing multi-core with
> shared caches between cores. Consider a dual package system, each package
> containing two cores and with last level cache shared between cores with in a
> package. If there are two runnable processes, with this appended patch
> those two processes will be scheduled on different packages.
> 
> On such system, with this patch we have observed 8% perf improvement with 
> specJBB(2 warehouse) benchmark and 35% improvement with CFP2000 rate(with
> 2 users).
> 
> This new domain will come into play only on multi-core systems with shared
> caches. On other systems, this sched domain will be removed by
> domain degeneration code. This new domain can be also used for implementing
> power savings policy (see OLS 2005 CMP kernel scheduler paper for more
> details.. I will post another patch for power savings policy soon)

Could we all do it with single CONFIG_SCHED_SMT or CONFIG_NUMA or
something like that? No need for zillion options...
								Pavel

-- 
Thanks, Sharp!
