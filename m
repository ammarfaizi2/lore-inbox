Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUJFD7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUJFD7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUJFD7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:59:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266878AbUJFD7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:59:21 -0400
Message-ID: <41636D8B.8020401@pobox.com>
Date: Tue, 05 Oct 2004 23:59:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrea Arcangeli <andrea@novell.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com> <416369F9.7050205@yahoo.com.au>
In-Reply-To: <416369F9.7050205@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Jeff Garzik wrote:
> 
>> Andrea Arcangeli wrote:
>>
>>> So I disagree with your claim that preempt risks to hide inefficient
>>> code, there are many other (probably easier) ways to detect inefficient
>>> code than to check the latencies.
>>
>>
>>
>>
>> You're ignoring the argument :)
>>
>> If users and developers are presented with the _impression_ that long 
>> latency code paths don't exist, then nobody is motivated to profile 
>> them (with any tool), much less fix them.
>>
> 
> But even without preempt you'd still have to profile the latency.

You're making my point for me.  If the bandaid (preempt) is not active, 
then the system can be accurated profiled.  If preempt is active, then 
it is potentially hiding trouble spots.

The moral of the story is not to use preempt, as it
* potentially hides long latency code paths
* potentially introduces bugs, as we've seen with net stack and many 
other pieces of code
* is simply not needed, if all code paths are fixed

	Jeff


