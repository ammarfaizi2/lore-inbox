Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSKXQlZ>; Sun, 24 Nov 2002 11:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKXQlZ>; Sun, 24 Nov 2002 11:41:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23027 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261456AbSKXQlY>;
	Sun, 24 Nov 2002 11:41:24 -0500
Message-ID: <3DE102C3.4975BF4F@mvista.com>
Date: Sun, 24 Nov 2002 08:48:03 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arun4linux <arun4linux@indiatimes.com>,
       John K Luebs <jkluebs@luebsphoto.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: switching to interrupt contex when no interrupts
References: <200211231948.BAA22590@WS0005.indiatimes.com> <3DE09E60.407FE8D6@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> arun4linux wrote:
> >
> > Hello,
> >
> > <<One is forced to run in interrupt context in an
> > interrupt handler.
> > >>Yes. But my requirement is to force my code to run in interrupt context.
> >
> > <<Possibility is undefined here because what you said makes no sense.
> >
> > You will get a better answer from the list if you describe what you are trying to do (in concrete terms), not how you think you might do it.
> >
> > >>My requirement is to simulate a PCI based controller and its behaviour in software. I knew the different type of interrupts and the timings my device produces.
> >
> > I need to simulate this PCI device, its interrupts in sequence and I have to process them in my driver software.
> >
> >   Hope this make sense now.
> >
> >   Anyway, my requrirement is to simulate the interrupts and process them in the interrupt context.
> >
> >   It would be helpful, if anyone could help me how to do it.
> >   My idea is to use task queues and bottom halves for this. But I'd like to get clarified on simulating interrupts (rasing the process/task context to interrupt context) and its consequences.
> >
> Why simulate the interrupts when you can just program them?
> On the x86 machine the "int x" instruction generates an
> interrupt to irq "x"+32.  You do need to be in kernel land
> to do this, but then I assume that is not a problem.

Uh, make that "x"-32, i.e. "int 34" give irq 2.

-g
> 
> -g
> 
> >
> > Thanks & Warm Regards
> > Arun
> >
> > "John K Luebs" wrote:
> >
> > On Sat, Nov 23, 2002 at 07:37:33AM +0530, arun4linux wrote:
> > &gt; Hello,
> > &gt;
> > &gt; I'd like to force my kernel module to run at interrupt context at some specific points/time and then come back from interrrupt contex after executing that particular portion of code..
> >
> > You seem to be over complexifying what interrupt context is. It is
> > simply a generic term for a context that executes on account of an
> > architecture interrupt. One is forced to run in interrupt context in an
> > interrupt handler.
> >
> > You "run" in interrupt context by calling request_irq attached to the
> > interrupt line that you are interested in installing a handler for.
> >
> > &gt;
> > &gt; Is it possible?
> >
> > Possibility is undefined here because what you said makes no sense.
> >
> > You will get a better answer from the list if you describe what you are
> > trying to do (in concrete terms), not how you think you might do it.
> >
> > Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com
> >
> >  Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> --
> George Anzinger   george@mvista.com
> High-res-timers:
> http://sourceforge.net/projects/high-res-timers/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
