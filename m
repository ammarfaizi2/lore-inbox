Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUAFBiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUAFBiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:38:04 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:18375 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263775AbUAFBhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:37:47 -0500
Message-ID: <3FFA1149.5030009@cyberone.com.au>
Date: Tue, 06 Jan 2004 12:37:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Con Kolivas <kernel@kolivas.org>,
       Tim Connors <tconnors+linuxkernel1073186591@astro.swin.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>	<200401041242.47410.kernel@kolivas.org>	<slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>	<200401041658.57796.kernel@kolivas.org> <m2ptdxq3vf.fsf@telia.com>
In-Reply-To: <m2ptdxq3vf.fsf@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Osterlund wrote:

>Con Kolivas <kernel@kolivas.org> writes:
>
>
>>On Sun, 4 Jan 2004 14:32, Tim Connors wrote:
>>
>>>>Not quite. The scheduler retains high priority for X for longer so it's
>>>>no new dynamic adjustment of any sort, just better cpu usage by X (which
>>>>is why it's smoother now at nice 0 than previously).
>>>>
>>>>
>>>>>If either the scheduler or xterm was a bit smarter or
>>>>>used different thresholds, the problem would go away. It would also
>>>>>explain why there are people who cannot reproduce it. Perhaps a
>>>>>somewhat faster or slower system makes the problem go away. Honnestly,
>>>>>it's the first time that I notice that my xterms are jump-scrolling, it
>>>>>was so much fluid anyway.
>>>>>
>>>>Very thorough but not a scheduler problem as far as I'm concerned. Can
>>>>you not disable smooth scrolling and force jump scrolling?
>>>>
>>>AFAIK the definition of jump scrolling is that if xterm is falling
>>>behind, it jumps. Jump scrolling is enabled by default.
>>>
>>>What this slowness means is that xterm is getting CPU at just the
>>>right moments that it isn't falling behind, so it doesn't jump - which
>>>means X gets all the CPU to redraw, which means your ls/dmesg anything
>>>else that reads from disk[1] doesn't get any CPU.
>>>
>>>Xterm is already functioning as designed - you can't force jump
>>>scrolling to jump more - it is at the mercy of how it gets
>>>scheduled. If there is nothing more in the pipe to draw, it has to
>>>draw.
>>>
>>>These bloody interactive changes to make X more responsive are at the
>>>expense of anything that does *real* work.
>>>
>>Harsh words considering it is the timing sensitive nature of xterm that relies 
>>on X running out of steam in the old scheduler design to appear smooth.
>>
>
>But the scheduler is also far from fair in this situation. If I run
>

snip a good analysis...

... but fairness is not about a set of numbers the scheduler gives to
each process, its about the amount of CPU time processes are given.

In this case I don't know if I find it objectionable that X and xterm
are considered interactive and perl considered a CPU hog. What is the
actual problem?


