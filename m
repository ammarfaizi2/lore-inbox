Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbUKOQzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUKOQzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKOQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:55:22 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:51397 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261643AbUKOQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:55:05 -0500
Message-ID: <33583.195.245.190.93.1100537553.squirrel@195.245.190.93>
In-Reply-To: <20041115161159.GA32580@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
    <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
    <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
    <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
    <20041111215122.GA5885@elte.hu>
    <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
    <20041115161159.GA32580@elte.hu>
Date: Mon, 15 Nov 2004 16:52:33 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       alsa-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 15 Nov 2004 16:54:59.0173 (UTC) FILETIME=[D7749950:01C4CB33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
>
> Rui Nuno Capela wrote:
>
>>   1) Almost everytime the P4/SMP box locks up while unloading the ALSA
>> modules e.g.on shutdown. This has been an issue for quite some time on
>> the latest RT patches, not exclusive to RT-V0.7.26-3. Probably it
>> started since the merge into -mm3, but not sure.
>
> hm, the syslog you sent suggests that it's the 2.6.10-rc1-mm3-RT-V0.7.24
> kernel that crashed:
>
>  Nov 11 12:39:46 lambda kernel: EFLAGS: 00010083
> (2.6.10-rc1-mm3-RT-V0.7.24)
>
> not -V0.7.26-3. The particular rmmod crash you got:
>

Yes, but as I said so, I couldn't get any relevent trace on the P4/SMP
box, where the issue means real trouble -- the system just locks up while
serial console's annoyingly quiet about it.

Did you notice about nmi_watchdog=1? As it seems, '/etc/init.d/alsasound
stop' just runs smoothly then.

The dump I sent is in fact taken from my P4/UP desktop, and I thought it
was somewhat related. Indeed, I cannot see it happenning anymore since
running RT-0.7.25-1.

I will try RT-0.7.26-4 later on.

Seeya.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

