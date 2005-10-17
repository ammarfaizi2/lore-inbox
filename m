Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVJQQoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVJQQoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVJQQoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:44:08 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:20007 "EHLO
	mail39-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750806AbVJQQoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:44:06 -0400
X-BigFish: V
Message-ID: <4353D60E.70901@am.sony.com>
Date: Mon, 17 Oct 2005 09:49:18 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com> <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu> <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org> <Pine.LNX.4.61.0510171511010.1386@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0510171511010.1386@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Mon, 17 Oct 2005, Andrew Morton wrote:
>>That being said, I'll confess that I've largely ignored this discussion in
>>the hope that things would get sorted out.  Seems that this won't be
>>happening and as Roman's opinions carry weight I do intend to solicit a
>>(brief!) summary of his objections from him when the patch comes round
>>again.  Sorry.
> 
> 
> It's rather simple:
> - "timer API" vs "timeout API": I got absolutely no acknowlegement that 
> this might be a little confusing and in consequence "process timer" may be 
> a better name.

I agree with Thomas on this one.  Maybe "timer" and "timeout" are too 
close, but I think they are the most descriptive names.
  - timeout is something used for a timeout.  Timeouts only actually
  expire infrequently, so they have a host of attributes associated
  with that characteristic.
  - timer is something used to time something.  They almost always
  expire as part of their normal behaviour.  In the ktimer code they
  have a host of attributes related to this characteristic.

Thomas answered the suggestion to use "process timer" as an alternative 
name, but I didn't see a reply after that from Roman (I may have missed it.)

> - I pointed out various (IMO) unnecessary complexities, which were rather 
> quickly brushed off e.g. with a need for further (not closer specified) 
> cleanups.

This is rather vague.  It is rather easy to raise hypothetical
issues.  From what I've seen, Thomas has gone to great lengths to
address specific issues raised.  For example, he actually compiled
code on 4 different platforms to get the REAL size of the assembly
fragments, in order to address your concern about CONJECTURED size
problems.

> - resolution handling: at what resolution should/does the kernel work and 
> what do we report to user space. The spec allows multiple interpretations 
> and I have a hard time to get at least one coherent interpretation out of 
> Thomas.

Huh?  I thought Thomas' last answer was pretty clear.

> 
> Maybe I'm the only one who found Thomas answers a little superficial, but 
> as this is a central kernel subsystem I think it deserves a closer look 
> and everytime I tried to poke a little deeper I got nothing.

No one minds poking deep.  But frankly, I find hypothetical arguments
to be less useful than reality-backed ones.  I would rather not hear
reasoning about a resolution issue - I'd like to numbers, if possible,
about the degradation of performance, if that's the issue.  If
it's confusion about the API, then maybe we just need clear statements
that "X API provides resolution at Y level (from one of: hardware, tick, 
something else).

Regards,
  -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

