Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUJPL5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUJPL5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUJPL5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:57:17 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:44884 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268703AbUJPL5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:57:15 -0400
Message-ID: <32789.192.168.1.5.1097927739.squirrel@192.168.1.5>
In-Reply-To: <20041016111244.GA4808@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
    <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
    <1097888438.6737.63.camel@krustophenia.net>
    <1097894120.31747.1.camel@krustophenia.net>
    <20041016064205.GA30371@elte.hu>
    <1097917325.1424.13.camel@krustophenia.net>
    <20041016103608.GA3548@elte.hu>
    <32787.192.168.1.5.1097924629.squirrel@192.168.1.5>
    <20041016111244.GA4808@elte.hu>
Date: Sat, 16 Oct 2004 12:55:39 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Daniel Walker" <dwalker@mvista.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Andrew Morton" <akpm@osdl.org>, "Adam Heath" <doogie@debian.org>,
       "Lorenzo Allegrucci" <l_allegrucci@yahoo.it>,
       "Andrew Rodland" <arodland@entermail.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 16 Oct 2004 11:57:14.0353 (UTC) FILETIME=[46CCE610:01C4B377]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

>
> Rui Nuno Capela wrote:
>
>> Ingo Molnar wrote:
>> >
>> > it seems that SMP + PREEMPT_TIMING is not stable though, somehow the
>> > latency printk's cause a crash sooner or later. I'm still debugging
>> > this problem. Without PREEMPT_TIMING the SMP kernel is stable.
>> >
>>
>> How true!
>>
>> My first successful SMP/HT PREEMPT_REALTIME has been achieved, by just
>> turning off PREEMPT_TIMING. So you won't get any latency trace dumps
>> from here ;)

OOPS. I think I've made a terrible mistake. It seems that
SMP+PREEMPT_REALTIME is NOT solved after all in my P4/HT box, even with
PREEMPT_TIMING not set.

As one may check from the .config.gz I've sent just about minutes ago,
PREEMPT_REALTIME wasn't being set, and the RT label was bogus.

So sorry to mislead you all. I should have known, it was too good to be
true :(

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

