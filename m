Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSIBD4L>; Sun, 1 Sep 2002 23:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSIBD4L>; Sun, 1 Sep 2002 23:56:11 -0400
Received: from mercury.it.wmich.edu ([141.218.1.92]:33195 "EHLO
	mercury.localmail") by vger.kernel.org with ESMTP
	id <S318218AbSIBD4K>; Sun, 1 Sep 2002 23:56:10 -0400
Message-ID: <3D72E267.6090502@wmich.edu>
Date: Mon, 02 Sep 2002 00:00:39 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
References: <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 1 Sep 2002, Ed Sweetman wrote:
> 
> 
>>Wouldn't the majority (to an undeniable extent) of the "responsiveness"
>>of desktop usage be on X's code? if we are talking about that.  The
>>problem with finding a benchmark is that first you have to have a
>>definition of what you're benchmarking.  The "system responsiveness"
>>term is far too vague. When there's a definition to the term there can
>>be a benchmark made to measure it.
> 
> 
> Agreed. Things like system responsiveness are fairly complex
> though and in many cases the average numbers measured by
> benchmarks don't mean anything to users.
> 
> I wish we had a way to measure this stuff, but I'll happily
> philosophise with you guys until we come up with a useful
> definition of something we could measure...
> 
> 
>>I mean, besides making the kernel with as low latency as possible, what
>>is bad about the responsiveness in the kernel?  If there's any lag in
>>responsiveness that i see it's always something X related, particularly
>>Xfree86.
> 
> 
> "low latency" != responsiveness
> 
> Any latency which is below the point the user can notice
> is effectively zero, so whether the 10000 wakeups/minute
> that the user doesn't notice are 2ms or 5ms don't really
> matter.

true.  But the latency that's N low multiplied by many processes can 
equal latencies that are in the range users can notice in a single app 
that maybe getting bullied by the others.  Lowering latencies cant be a 
bad thing unless they create unelegent code or introduce bugs.  That's 
all i meant by mentioning latency.

> What does matter are the wakeups that make the user's
> mp3 skip, even if these don't influence the statistics
> at all because there's only 1 every few minutes, or none,
> if the VM is balanced right ;)
> 
> Another responsiveness thing is how fast you can swap in
> Mozilla when the user comes in in the morning. More of a
> throughput than a latency thing in this case ... but you
> still have to make sure the mp3 doesn't skip while mozilla
> is being loaded.

Maybe i'm weird then because I've never had that happen.  The only time 
i've had my mp3s skip is when i purposely did things that would do that 
(saturate via bonnie or dbench).  I can see this occuring during 
swapping when dma is not used, but this just adds to the fact that it's 
no easy matter to define the problem.

> regards,
> 
> Rik

I dont experience audio cutouts with anything i do, even the really 
abusive things to the computer.  I've only had it cut out when using 
bonnie or dbench and that's something you should expect. So what i see 
as responsiveness is switching windows on the same desktop and switching 
between virtual desktops.  I see responsiveness as the time between i do 
something and the time it takes to redraw it. Using a G450, I expect a 
certain level of hardware performance and half a second or so to redraw 
a screen is not what i call responsive for a Tbird system. This is of 
course all X related because i dont see much or any problem with the 
console and with the kernel. At least nothing compared to X latencies.

the common user wants to see desktop performance equal to mac osX and 
windows and they come to linux which uses X and dont see that.  The 
problem is Xfree86 is a crossplatform network oriented windowing system 
and you get the same argument with it that people have with gcc.  The 
purpose of xfree86 and gcc is kind of the same and not the same as these 
other propriatary systems / compilers such as OSX or icc.  It's tough 
luck for us all but this is something that the xpert mailing list could 
better handle since what we're looking for is a tool that measures the 
performance of X under real workloads and where problem areas are.

Both the kernel and the programs used are involved when talking "system 
responsiveness" but in this case i think the kernel has been fine tuned 
much more strictly and thoroughly than xfree86 has.  I'd like to know if 
that's due to lack of man/woman power or if they're being restricted by 
compliance to aspects of X that maybe need to change as use has changed.

