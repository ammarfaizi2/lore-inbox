Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbUJ0P3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUJ0P3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUJ0P3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:29:04 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:52650 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262465AbUJ0P2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:28:44 -0400
Message-ID: <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
In-Reply-To: <20041027135309.GA8090@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
    <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
    <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
    <20041027001542.GA29295@elte.hu>
    <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
    <20041027135309.GA8090@elte.hu>
Date: Wed, 27 Oct 2004 16:26:03 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 27 Oct 2004 15:28:38.0463 (UTC) FILETIME=[A1A9BCF0:01C4BC39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> Rui Nuno Capela wrote:
>
>> OK. Currently with RT-V0.3.2.
>>
>> So it seems that the jackd -R is no more an issue here.
>
> great.
>
>> However (oh no!:) those jackd -R xruns are still frequent, much
>> frequent than RT-U3, which is my stable RT kernel atm.
>
> -V0.4.1 could help with this problem. There were a number of places
> where the PREEMPT_REALTIME kernel missed reschedules so it could easily
> happen that jackd would sit in the runqueue waiting to be executed and
> the kernel got quickly out of a critical section but then the kernel
> 'forgot' to reschedule for many milliseconds!
>

On RT-V0.4.1, xruns seems slighly reduced, but plenty enough for my taste.

Running jackd -R with 6 fluidsynth instances gives me 0 (zero) xruns on
RT-U3, but more than 20 (twenty) on RT-V0.4.1, under a 5 minute time
frame. It was 30 (thirty something) on RT-V0.4, but overall "feel" is
about the same.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


