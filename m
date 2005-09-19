Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVISFLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVISFLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVISFLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:11:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43693 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932298AbVISFLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:11:04 -0400
Date: Mon, 19 Sep 2005 10:40:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919051024.GA8653@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 12:48:38PM +0800, Li, Shaohua wrote:
> I guess Nigel's point is cpu_idle is preempted before take_cpu_down. If
> the preempt occurs after the cpu_is_offline check, when the cpu (after

How can that happen? Idle task is running at max priority (MAX_RT_PRIO-1)
and with SCHED_FIFO policy at this point. If that is indeed happening,
then we need to modify sched_idle_next not to allow that.

> sched_idle_next) goes into idle again, nobody can wake it up. Nigel,
> isn't it?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
