Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270384AbUJUKbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbUJUKbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270687AbUJUK1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:27:50 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:58741 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S270640AbUJUK1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:27:30 -0400
Message-ID: <14882.195.245.190.93.1098354393.squirrel@195.245.190.93>
In-Reply-To: <20041021091850.GA29183@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
    <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
    <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
    <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
    <20041020094508.GA29080@elte.hu>
    <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
    <20041021091850.GA29183@elte.hu>
Date: Thu, 21 Oct 2004 11:26:33 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 21 Oct 2004 10:27:26.0610 (UTC) FILETIME=[8F854F20:01C4B758]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>>    One of the signs that there's real trouble in here can be seen on
>> the following complete dmesg output (which was even a miracle to be
>> captured at all). This shows the complete bootstrap and init sequences
>> and at the end one fatal crash while plugging an USB flash memory
>> stick (usb-storage). This has been already reported earlier yesterday,
>> but I just want to make it here, as the evidence-at-hand.
>>
>>    After this precise occurence, the system becomes very flaky,
>> unreliable and often ends up freezing to death.
>
> for the sake of testing could you disable CONFIG_USB and see whether the
> instability is truly directly related to the USB crash, as you suspect?
> Such a kernel crash can often destabilize other parts of the kernel.
>

Just tested with CONFIG_USB off, and can't test the usb-storage crash, of
course. However, jackd  is still freezing to death. No console, nor syslog
output can be found. The system just dies sometime after some jack client
is launched. Will try further.

I'm on the way to test Thomas Gleixner's patch...

BBL
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

