Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTABMWq>; Thu, 2 Jan 2003 07:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTABMWq>; Thu, 2 Jan 2003 07:22:46 -0500
Received: from [203.199.93.15] ([203.199.93.15]:52740 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S261495AbTABMWo>; Thu, 2 Jan 2003 07:22:44 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200301021221.RAA22029@WS0005.indiatimes.com>
To: "george anzinger" <george@mvista.com>,
       "arun4linux" <arun4linux@indiatimes.com>,
       "John K Luebs" <jkluebs@luebsphoto.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Re: Re: switching to interrupt contex when no interrupts
Date: Thu, 02 Jan 2003 18:00:02 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I used 

asm volatile ("int 41");

in my code.
My card's irq number is 9.
I get the error message.

Error: suffix or operabds invalid for 'in'

This is the case, if I change the 41 to 0x29 or 29h.

Where can I get some documentation on using asm?


Warm Regards
Arun



"george anzinger" wrote:



george anzinger wrote:
> 
> arun4linux wrote:
> >
> > Hello,
> >
> > <> > interrupt handler.
> > >>Yes. But my requirement is to force my code to run in interrupt context.
> >
> > <> >
> > You will get a better answer from the list if you describe what you are trying to do (in concrete terms), not how you think you might do it.
> >
> > >>My requirement is to simulate a PCI based controller and its behaviour in software. I knew the different type of interrupts and the timings my device produces.
> >
> > I need to simulate this PCI device, its interrupts in sequence and I have to process them in my driver software.
> >
> > Hope this make sense now.
> >
> > Anyway, my requrirement is to simulate the interrupts and process them in the interrupt context.
> >
> > It would be helpful, if anyone could help me how to do it.
> > My idea is to use task queues and bottom halves for this. But I'd like to get clarified on simulating interrupts (rasing the process/task context to interrupt context) and its consequences.
> >
> Why simulate the interrupts when you can just program them?
> On the x86 machine the "int x" instruction generates an
> interrupt to irq "x"+32. You do need to be in kernel land
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
> > > Hello,
> > >
> > > I'd like to force my kernel module to run at interrupt context at some specific points/time and then come back from interrrupt contex after executing that particular portion of code..
> >
> > You seem to be over complexifying what interrupt context is. It is
> > simply a generic term for a context that executes on account of an
> > architecture interrupt. One is forced to run in interrupt context in an
> > interrupt handler.
> >
> > You "run" in interrupt context by calling request_irq attached to the
> > interrupt line that you are interested in installing a handler for.
> >
> > >
> > > Is it possible?
> >
> > Possibility is undefined here because what you said makes no sense.
> >
> > You will get a better answer from the list if you describe what you are
> > trying to do (in concrete terms), not how you think you might do it.
> >
> > Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com
> >
> > Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> --
> George Anzinger george@mvista.com
> High-res-timers:
> http://sourceforge.net/projects/high-res-timers/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/

-- 
George Anzinger george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy the best in Movies at http://www.videos.indiatimes.com

Now bid just 7 Days in Advance and get Huge Discounts on Indian Airlines Flights. So log on to http://indianairlines.indiatimes.com and Bid Now!

