Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSE2A7t>; Tue, 28 May 2002 20:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSE2A7s>; Tue, 28 May 2002 20:59:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31735 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S313087AbSE2A7r>;
	Tue, 28 May 2002 20:59:47 -0400
Message-ID: <3CF427E4.79042F@mvista.com>
Date: Tue, 28 May 2002 17:59:16 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Whitwell <keith@tungstengraphics.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.18: DRM + cmpxchg issues
In-Reply-To: <3CF33C10.1090302@tungstengraphics.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Whitwell wrote:
> 
> Adam,
> 
> I expect the answer is that we need to dig out the old one.
> 
> Previously I don't think the full cmpxchg semantics werere required unless the
> box is smp -- there's no case where atomic operations are required for
> hardware interaction, for example.  ...
> 
> Probably this changed with preempt, though, so we need one even on UP boxes...
> 
I can not think of any reason to need a lock or atomic
operation because of preempt.  Even the management of the
preempt on/off flags at most requires memory barriers, even
in SMP boxen.  Do you have an example?
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
