Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbUJZDLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUJZDLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUJZDLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:11:31 -0400
Received: from relay02.pair.com ([209.68.5.16]:49935 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262154AbUJZDLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:11:06 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417DC046.1020806@cybsft.com>
Date: Mon, 25 Oct 2004 22:11:02 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>	 <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>	 <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>	 <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu>	 <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>	 <20041025141628.GA14282@elte.hu>	 <33313.192.168.1.5.1098733224.squirrel@192.168.1.5> <1098759671.9166.10.camel@krustophenia.net>
In-Reply-To: <1098759671.9166.10.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2004-10-25 at 20:40 +0100, Rui Nuno Capela wrote:
> 
>>OTOH, jackd -R xruns are awfully back, even thought I (re)prioritize the
>>relevant IRQ thread handlers to be always higher than jackd's.
> 
> 
> Actually they should be lower, except the soundcard.  I was only able to
> get the xrun free behavior of T3 by setting all IRQ threads except the
> soundcard to SCHED_OTHER.  Especially important was setting ksoftirqd to
> SCHED_OTHER, this actually may have been the only one necessary.
> 
> The relative priorities of jackd and the soundcard irq do not matter as
> these two should never contend (aka they are never both runnable at the
> same time).
> 
> Lee 
> 
> 
Not being familiar with jack, does it use rtc?

kr
