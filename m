Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314559AbSEXRMk>; Fri, 24 May 2002 13:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317198AbSEXRMj>; Fri, 24 May 2002 13:12:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44275 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314559AbSEXRMh>;
	Fri, 24 May 2002 13:12:37 -0400
Message-ID: <3CEE7445.3B45DC44@mvista.com>
Date: Fri, 24 May 2002 10:11:33 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: tasklet scheduled after end of rmmod
In-Reply-To: <7wptzlllek.fsf@avalon.france.sdesigns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Michon wrote:
> 
> Hi,
> 
> as far as I understand nothing prevents a scheduled tasklet to have
> Linux jump to its routine, when the routine is in a module being
> rmmod'd. How should I take care of this?
> 
> Are timers safe regarding this (I mean, we can consider the timer
> function won't be called as soon as del_timer() has returned)?

No, but  del_timer_sync() is.  See comments in
.../kernel/timer.c

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
