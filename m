Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSD1RfM>; Sun, 28 Apr 2002 13:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSD1RfL>; Sun, 28 Apr 2002 13:35:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55534 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311871AbSD1RfK>;
	Sun, 28 Apr 2002 13:35:10 -0400
Message-ID: <3CCC32B5.1DF5EA5A@mvista.com>
Date: Sun, 28 Apr 2002 10:34:45 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <E171kjK-0003oh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > so, what?  We will have a timer interrupt prior to the slice end, and
> > will have to make this decision all over again.  However, the real rub
> 
> Only on unusual occasions.
> 
> > is that we have to keep track of elapsed time and account for that (i.e.
> > shorten the remaining slice) not only in the timer interrupt, but each
> 
> We do anyway

Yes, but now we do all this in the timer tick, not in schedule().  This
occures much less often.  
> 
> Alan

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
