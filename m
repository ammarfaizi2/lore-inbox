Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbUJ0Rr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbUJ0Rr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUJ0Ro6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:44:58 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:51082 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262548AbUJ0RmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:42:24 -0400
Message-ID: <32865.192.168.1.5.1098898770.squirrel@192.168.1.5>
In-Reply-To: <1098891035.1448.21.camel@krustophenia.net>
References: <20041019124605.GA28896@elte.hu> 
    <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> 
    <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> 
    <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> 
    <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> 
    <5225.195.245.190.94.1098880980.squirrel@195.245.190.94> 
    <20041027135309.GA8090@elte.hu> 
    <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
    <1098891035.1448.21.camel@krustophenia.net>
Date: Wed, 27 Oct 2004 18:39:30 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
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
X-OriginalArrivalTime: 27 Oct 2004 17:42:22.0837 (UTC) FILETIME=[50900A50:01C4BC4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Lee Revell
> On Wed, 2004-10-27 at 16:26 +0100, Rui Nuno Capela wrote:
>> On RT-V0.4.1, xruns seems slighly reduced, but plenty enough for my
>> taste.
>>
>
> Have you tried making ksoftirqd SCHED_OTHER?  This drastically reduced
> xruns on my system with an earlier version.
>
> Lee
>

Hmm... ksoftirqd/0 (or also ksoftirqd/1 on 2cpu SMP) are already
SCHED_OTHER by default, at least on both of my boxes that are running
RT-V0.4.1 now.

Should I try the other way around? Lets see... 'chrt -p -f 90 `pidof
ksoftirwd/0`',... yes, apparentely the xrun rate seems to decrease into
half, but IMHO not conclusive enough, thought.

CU
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

