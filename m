Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVAXBIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVAXBIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 20:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVAXBIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 20:08:43 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:11929 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261410AbVAXBI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 20:08:29 -0500
Message-ID: <41F44AC2.1080609@kolivas.org>
Date: Mon, 24 Jan 2005 12:09:22 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org> <877jm3ljo9.fsf@sulphur.joq.us>
In-Reply-To: <877jm3ljo9.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>There are two things that the SCHED_ISO you tried is not that
>>SCHED_FIFO is - As you mentioned there is no priority support, and it
>>is RR, not FIFO. I am not sure whether it is one and or the other
>>responsible. Both can be added to SCHED_ISO. I haven't looked at jackd
>>code but it should be trivial to change SCHED_FIFO to SCHED_RR to see
>>if RR with priority support is enough or not. 
> 
> 
> Sure, that's easy.  I didn't do it because I assumed it would not
> matter.  Since the RR scheduling quantum is considerably longer than
> the basic 1.45msec audio cycle, it should work exactly the same.  I'll
> cobble together a JACK version to try that for you.

If you already know the audio cycle is much less than 10ms then there 
isn't much point trying it.

>>Second the patch I sent you is fine for testing; I was hoping you
>>would try it. What you can't do with it is spawn lots of userspace
>>apps safely SCHED_ISO with it - it will crash, but it not take down
>>your hard disk. I've had significantly better results with that
>>patch so far. Then we cn take it from there.
> 
> 
> Sorry.  I took you literally when you said it was not yet ready to
> try.  This would be the isoprio3 patch you posted?

Yes it is.

> Do I have to use 2.6.11-rc1-mm2, or will it work with 2.6.11-rc1?

It was for mm2, but should patch on an iso2 patched kernel.

Thanks!

Con
