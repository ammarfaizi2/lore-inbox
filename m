Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUIHABc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUIHABc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268781AbUIHABc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:01:32 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:55010 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268786AbUIHABJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:01:09 -0400
Message-ID: <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
In-Reply-To: <1094598822.16954.219.camel@krustophenia.net>
References: <20040903120957.00665413@mango.fruits.de> 
    <20040904195141.GA6208@elte.hu>  <20040905140249.GA23502@elte.hu> 
    <1094597710.16954.207.camel@krustophenia.net>
    <1094598822.16954.219.camel@krustophenia.net>
Date: Wed, 8 Sep 2004 00:58:13 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Florian Schmidt" <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Sep 2004 00:01:08.0186 (UTC) FILETIME=[F1459BA0:01C49536]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lee Revell wrote:
>> Ingo, here is a report from a user (Rui) of a problem that seems to
>> have been introduced in Q5.
>
> Ugh, I got Rui's address wrong in the first post, please use the one
> above for any followups.  Sorry.
>

>Rui Nuno Capela wrote:
>>
>> I'm having some trouble with latest VP patches on my P4 HT/SMP box. The
>> trouble is that since Q5 that I can't get my machine to boot reliably,
>> if at all. It goes almost all through the init scripts to drop dead on
>> the beach, so to speak. It just freezes completely somewhere before the
>> login prompts.
>>
>> This only happens if the kernel is configured for SMP/SMT
>> (HyperThreading). The very same kernel configured and built for UP
>> boots and runs fine. As I said before this was introduced on the Q5
>> patch, and the same showstopper is present on latest R6. Only with Q3
>> I'm still happy, altought only with softirq-preempt=0 AND
>> hardirq-preempt=0.
>>
>> The "offending" box is a SUSE 9.1 based one, P4 2.80C HT on a ASUS
>> P4P800 mobo, 1GB DDR.
>>
>
> I posted the above report to LKML and cc'ed you and Ingo.  None of the
> LKML testers are reporting this problem, it sounds very similar to the
> problems others have had with SMP/HT but those were thought to all be
> solved.
>

Thanks Lee. Yes I was pretty excited with those reports too (I've been
lurking on LKML :), but I just seem to be unlucky. That's why I've been
trying one by one of the patches, from Q5 to R6 and tweaking the available
options as much as I know and time permitted.

OK, could just someone with a P4 HT/SMP box hand me their working kernel
.config file for me to try? That could be a good starting point, if not a
plain baseline.

>
> Has any version worked with softirq or hardirq preemption enabled?  What
> are the symptoms if you boot Q3 with either of the above enabled?
>

On this box in question, softirq and hardirq-preempt options had NEVER
lead to a stable SMP/HT system, ever since my first rehearsal with VP,
which I think was around O3. UP is quite different, it works and always
worked, as advertised :) FWIW, R6 is pumping hard on my laptop :)

Q3-SMP doesn't pass the KDE 3.3 startup splash if I set softirq=1 or
hardirq=1. The system just hangs. I still keep softirq-preempt=0 and
hardirq-preempt=0 as my Q3-SMP kernel bootloader parameters though.

Hope this gets cleared out. All I can do is offering my best efforts to
dig this out, provided someone give me some hunch ;)

Thank you all.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


