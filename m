Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVISGyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVISGyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVISGyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:54:35 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:19870 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932339AbVISGye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:54:34 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Li Shaohua <shaohua.li@intel.com>, vatsa@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1127111784.5272.10.camel@npiggin-nld.site>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
	 <1127111830.4087.3.camel@linux-hp.sh.intel.com>
	 <1127111784.5272.10.camel@npiggin-nld.site>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127112869.9696.107.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 19 Sep 2005 16:54:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-09-19 at 16:36, Nick Piggin wrote:
> On Mon, 2005-09-19 at 14:37 +0800, Shaohua Li wrote:
> > On Mon, 2005-09-19 at 11:53 +0530, Srivatsa Vaddagiri wrote:
> 
> > > default_idle should be fine as it is. IOW it should not cause __cpu_die to 
> > > timeout.
> > Why default_idle should be fine? it can be preempted before the
> > 'local_irq_disable' check. Even with Nigel's patch, there is a very
> > small window at safe_halt (after 'sti' but before 'hlt').
> > 
> 
> Ah, actually I have a patch which makes all CPU idle threads
> run with preempt disabled and only enable preempt when scheduling.
> Would that help?

Sounds to me like it should, but I'm not claiming any expertise in this
area. Going off your other posts, you're thinking of this plus my
original patch?

Regards,

Nigel 


