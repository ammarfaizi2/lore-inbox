Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVISHB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVISHB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVISHB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:01:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10672 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932342AbVISHB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:01:27 -0400
Date: Mon, 19 Sep 2005 12:30:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919070045.GB9466@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <20050919051024.GA8653@in.ibm.com> <1127107887.3958.9.camel@linux-hp.sh.intel.com> <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost> <20050919062336.GA9466@in.ibm.com> <1127111379.5272.5.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127111379.5272.5.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 04:29:39PM +1000, Nick Piggin wrote:
> It seems to me that it would be much nicer to just go with Nigel's
> first fix. That is, rather than clutter up all idle routines with
> this.

I felt it to be more of a hack to get things working (do we really
want the idle thread to be rescheduled at that point?). Plus the fact
that it can cause the idle thread to call schedule() before the cpu_is_offline 
check made me uncomfortable (maybe it is just fine).

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
