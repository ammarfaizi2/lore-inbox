Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317914AbSGKVl1>; Thu, 11 Jul 2002 17:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317915AbSGKVl0>; Thu, 11 Jul 2002 17:41:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20985 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317914AbSGKVlZ>;
	Thu, 11 Jul 2002 17:41:25 -0400
Message-ID: <3D2DFC08.445B2723@mvista.com>
Date: Thu, 11 Jul 2002 14:43:36 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mbs <mbs@mc.com>, dank@kegel.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as
References: <E17SlUl-0001ai-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > First blush is HELL YES!  The issue is accounting.  When you
> > ask how long a program ran, you are looking at the
> > accounting that happens on a tick.  This is where one of two
> 
> Thats also an implementation issue. Note that the current code is also
> wildly inaccurate. Mr Shannon says we are good to at best 50 run/sleep
> changes a second.  I've got "100% busy" workloads that are 99% asleep.
> 
> Tracking cpu usage at task switch works a lot better for newer processors
> which as well as having rdtsc also have performance counters. In fact you
> can do much more interesting things on modern PC class platforms like
> scheduling using pre-emption interrupts based on instructions executed,
> memory accesses and more.
> 
Oh, I agree.  Hardware could make all this a lot easier.  
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
