Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSH3WjN>; Fri, 30 Aug 2002 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSH3WjN>; Fri, 30 Aug 2002 18:39:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43004 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314548AbSH3WjL>;
	Fri, 30 Aug 2002 18:39:11 -0400
Message-ID: <3D6FF4F4.ECBEDF68@mvista.com>
Date: Fri, 30 Aug 2002 15:43:00 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Dave Jones <davej@suse.de>, "Pering, Trevor" <trevor.pering@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <C81D8E612E5DD6119653009027AE9D3EE091D0@FMSMSX36> <3D6F2704.A78F0A0@aitel.hist.no> <20020830135347.A26909@suse.de> <3D6F66C3.9714C351@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Dave Jones wrote:
> >
> > On Fri, Aug 30, 2002 at 10:04:20AM +0200, Helge Hafting wrote:
> >  > An MHz carries more meaning - it is a measurable frequency.
> >
> > It's equally meaningless (in fact, less meaningful).
> > - By your definition my 900MHz VIA C3 is faster than my 800MHz Athlon.
> >   (Clue: It isn't).
> I never said such a thing!
> You are right that MHz is useless for telling which
> processor is the fastest.  But this discussion wasn't about
> comparing performance.
> 
> It was about:
> Should we tell the kernel to run a cpu at "500MHz", or
> "50% of max" in order to (save power|avoid overheating|whatever).
> 
> In this case MHz is useful - because that's what the manufacturer
> specifies.  That's what you program into cpu or
> motherboard registers, and MHz is what you can measure with an
> oscilloscope in order to verify correct operation of the driver.
> 
> Percentages don't buy you anything if you replace
> the cpu with a different one.  The other cpu may of course
> have different MHz ratings for "full speed" and "power save|cold
> running"
> but the percentages may very well be different too.
> Some runs cool at 80%, some at 60%...
> 
> finally - "full speed" is ill-defined.  Some AMD chips have different
> speed ratings for different operating temperatures.
> 
> So, I think MHz is the better choice for setting up
> speed policies for cooling and power saving.

If cooling and power saving is what is wanted, why not talk
in terms of degrees or watts?  Or are you really trying to
say something like "it is ok to run this much slower to
conserve power/temp/battery".

I really think we need to push down the power/temp to Mhz
conversion to the lowest level.  At the user level we should
only be expressing what we want and/or are willing to give
up for it.  From this point of view, if you are talking
frequency you are already out of the box.

-g
> 
> > - With trickery like AMD's quantispeed ratings, MHz really is a totally
> >   meaningless number when relating to performance of a CPU.
> > - A MHz rating is only meaningful across the same vendor/family of CPUs.
> 
> This is all fine for the purpose of comparing cpu's, but this
> isn't about such comparisons.  I would never compare an
> intel and an amd chip based on frequency, I'd look at how
> well they perform what I want them to do.
> 
> > Getting cpufreq's policy interface into something CPU agnostic therefore
> > precludes MHz ratings AFAICS.
> Why?  It is not as if cpufreq is being used to tell who
> has the faster machine...
> 
> Helge Hafting
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
