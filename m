Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbULNItK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbULNItK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 03:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbULNItK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 03:49:10 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:45012 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261452AbULNIr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 03:47:58 -0500
Message-ID: <58442.195.245.190.94.1103014076.squirrel@195.245.190.94>
In-Reply-To: <41BE6F48.3030006@cybsft.com>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>	
    <1102897004.31218.8.camel@cmn37.stanford.edu>	
    <20041213064719.GA3681@elte.hu>
    <1102985171.10967.713.camel@cmn37.stanford.edu>
    <41BE6F48.3030006@cybsft.com>
Date: Tue, 14 Dec 2004 08:47:56 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: "Fernando Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Ingo Molnar" <mingo@elte.hu>, mark_h_johnson@raytheon.com,
       "Amit Shah" <amit.shah@codito.com>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       emann@mrv.com, "Gunther Persoons" <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>, "Shane Shrybman" <shrybman@aei.ca>,
       "Esben Nielsen" <simlo@phys.au.dk>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 14 Dec 2004 08:47:56.0980 (UTC) FILETIME=[9BA68F40:01C4E1B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Fernando Lopez-Lezcano wrote:
>> On Sun, 2004-12-12 at 22:47, Ingo Molnar wrote:
>>
>>>* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
>>>
>>>
>>>>Something that just happened to me: running 0.7.32-14
>>>>(PREEMPT_DESKTOP) and trying to install 0.7.32-19 from a custom built
>>>>rpm package completely hangs the machine (p4 laptop - I tried twice).
>>>>No clues left behind. If I boot into 0.7.32-9 I can install 0.7.32-19
>>>>with no problems.
>>>
>>>does 0.7.32-19 work better if you reverse (patch -R) the loop.h and
>>>loop.c bits (see below)?
>>
>>
>> Running 0.7.32-19 (no changes) I managed to install 0.7.32-20 with no
>> problems... probably a problem in -14 that was somehow fixed in later
>> releases.
>>
>> -- Fernando
>
> Possibly. I have had the occasional problem with running make install
> locking one of my systems. Rebooting and running make install again
> works fine in my case. It is by no means a regular occurrence, even
> installing 2 or 3 new kernels daily on 3 different machines.
>

Isn't this tightly related to mkinitrd sometimes hanging while on mount -o
loop, that I've been reporting a couple of times before? It used to hang
on any other time I do a new kernel install, but latetly it seems to be OK
(RT-V0.9.32-19 and -20).
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

