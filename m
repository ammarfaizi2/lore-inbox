Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSGYBgh>; Wed, 24 Jul 2002 21:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSGYBgh>; Wed, 24 Jul 2002 21:36:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47095 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318291AbSGYBgh>;
	Wed, 24 Jul 2002 21:36:37 -0400
Message-ID: <3D3F56C6.B045E8A@mvista.com>
Date: Wed, 24 Jul 2002 18:39:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] updated low-latency zap_page_range
References: <Pine.LNX.4.44.0207241820170.5944-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 24 Jul 2002, Robert Love wrote:
> >
> >       if (preempt_count() == 1 && need_resched())
> >
> > Then we get "if (0 && ..)" which should hopefully be evaluated away.
> 
> I think preempt_count() is not unconditionally 0 for non-preemptible
> kernels, so I don't think this is a compile-time constant.
> 
> That may be a bug in preempt_count(), of course.
> 
Didn't we just put bh_count and irq_count in the same
word???
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
