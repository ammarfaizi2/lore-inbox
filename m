Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319557AbSH3Mct>; Fri, 30 Aug 2002 08:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319558AbSH3Mct>; Fri, 30 Aug 2002 08:32:49 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:33299 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319557AbSH3Mcs>; Fri, 30 Aug 2002 08:32:48 -0400
Message-ID: <3D6F66C3.9714C351@aitel.hist.no>
Date: Fri, 30 Aug 2002 14:36:19 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: "Pering, Trevor" <trevor.pering@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <C81D8E612E5DD6119653009027AE9D3EE091D0@FMSMSX36> <3D6F2704.A78F0A0@aitel.hist.no> <20020830135347.A26909@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Fri, Aug 30, 2002 at 10:04:20AM +0200, Helge Hafting wrote:
>  > An MHz carries more meaning - it is a measurable frequency.
> 
> It's equally meaningless (in fact, less meaningful).
> - By your definition my 900MHz VIA C3 is faster than my 800MHz Athlon.
>   (Clue: It isn't).
I never said such a thing!
You are right that MHz is useless for telling which 
processor is the fastest.  But this discussion wasn't about
comparing performance.

It was about:
Should we tell the kernel to run a cpu at "500MHz", or
"50% of max" in order to (save power|avoid overheating|whatever).

In this case MHz is useful - because that's what the manufacturer
specifies.  That's what you program into cpu or
motherboard registers, and MHz is what you can measure with an
oscilloscope in order to verify correct operation of the driver.

Percentages don't buy you anything if you replace
the cpu with a different one.  The other cpu may of course
have different MHz ratings for "full speed" and "power save|cold
running"
but the percentages may very well be different too.
Some runs cool at 80%, some at 60%...

finally - "full speed" is ill-defined.  Some AMD chips have different
speed ratings for different operating temperatures.

So, I think MHz is the better choice for setting up 
speed policies for cooling and power saving.

> - With trickery like AMD's quantispeed ratings, MHz really is a totally
>   meaningless number when relating to performance of a CPU.
> - A MHz rating is only meaningful across the same vendor/family of CPUs.

This is all fine for the purpose of comparing cpu's, but this
isn't about such comparisons.  I would never compare an
intel and an amd chip based on frequency, I'd look at how
well they perform what I want them to do.

> Getting cpufreq's policy interface into something CPU agnostic therefore
> precludes MHz ratings AFAICS.
Why?  It is not as if cpufreq is being used to tell who
has the faster machine...

Helge Hafting
