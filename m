Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUJRTVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUJRTVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUJRTSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:18:31 -0400
Received: from mail4.utc.com ([192.249.46.193]:45224 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267536AbUJRTSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:18:04 -0400
Message-ID: <417416DF.4050201@cybsft.com>
Date: Mon, 18 Oct 2004 14:17:51 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <41740F19.1080502@cybsft.com> <20041018184943.GB4625@elte.hu>
In-Reply-To: <20041018184943.GB4625@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>i have released the -U5 Real-Time Preemption patch:
>>>
>>> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5
>>>
>>
>>Ingo,
>>
>>*** Warning: "__you_cannot_kmalloc_that_much" 
>>[drivers/scsi/aacraid/aacraid.ko] undefined!
>>
>>This just appeared in U5. I was trying to track this one down just
>>because I saw it, even though I don't need aacraid. I am having a hell
>>of a time tracking down what changed that would cause this, but I
>>figure you will know exactly what changed that would cause it. :)
> 
> 
> i suspect this is due to the size increase of semaphores if
> CONFIG_RWSEM_DEADLOCK_DETECT is enabled. Try lowering
> CONFIG_RWSEM_MAX_OWNERS from the default 64 to 32, does that help?
> 
> 	Ingo
> 
Yes. That does help.

kr
