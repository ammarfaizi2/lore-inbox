Return-Path: <linux-kernel-owner+willy=40w.ods.org-S320867AbUKBFWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S320867AbUKBFWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274667AbUKAW3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:29:21 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:37223 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S276276AbUKAUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:01:49 -0500
Message-ID: <32784.192.168.1.5.1099339206.squirrel@192.168.1.5>
Date: Mon, 1 Nov 2004 20:00:06 -0000 (WET)
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: tglx@linutronix.de
Cc: "Ingo Molnar" <mingo@elte.hu>, "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Paul Davis" <paul@linuxaudiosystems.com>,
       "LKML" <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "jackit-devel" <jackit-devel@lists.sourceforge.net>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <20041031120721.GA19450@elte.hu>    
    <20041031124828.GA22008@elte.hu>    
    <1099227269.1459.45.camel@krustophenia.net>    
    <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>    
    <20041031162059.1a3dd9eb@mango.fruits.de>    
    <20041031165913.2d0ad21e@mango.fruits.de>    
    <20041031200621.212ee044@mango.fruits.de>   
    <20041101134235.GA18009@elte.hu>  <20041101135358.GA19718@elte.hu>   
    <20041101140630.GA20448@elte.hu>    
    <32917.192.168.1.5.1099328648.squirrel@192.168.1.5>   
    <1099328912.3337.40.camel@thomas>
In-Reply-To: <1099328912.3337.40.camel@thomas>
X-OriginalArrivalTime: 01 Nov 2004 20:01:39.0305 (UTC) FILETIME=[99789D90:01C4C04D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Rui Nuno Capela wrote:
>> Ingo Molnar wrote:
>> >
>> > I've uploaded -V0.6.5 to the usual place:
>> >
>> >   http://redhat.com/~mingo/realtime-preempt/
>> >
>>
>> Build error:
>>
>> kernel/built-in.o(.text+0x308a): In function `show_state':
>> : undefined reference to `show_all_locks'
>> kernel/built-in.o(.text+0x30bc): In function `show_state':
>> : undefined reference to `show_all_locks'
>> make: *** [.tmp_vmlinux1] Error 1
>
> You have lock debugging disabled.
>

OK. Applied Thomas' corrective patch and now a debug-stripped RT-V0.6.5
has been built fine on both of my machines.

But I'm afraid to have bad news.

My (now infamous:) jackd-R + 9*fluidsynth test is being abruptly killed by
jack_watchdog. Annoyingly always. On both of my configurations, laptop
(P4/UP) and desktop (P4/SMT), and in any other circunstance, jackd -R
can't survive for long. It just stalls after a while.

To be sincere, this happened once while testing with RT-V0.6.4, but only
after too many successful test runs.

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

