Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUJFB20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUJFB20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUJFB20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:28:26 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:49554 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266615AbUJFB2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:28:24 -0400
Message-ID: <41634A34.20500@yahoo.com.au>
Date: Wed, 06 Oct 2004 11:28:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com>
In-Reply-To: <4163465F.6070309@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Roland Dreier wrote:
> 
>>     Jeff> I strongly recommend disabling kernel preemption.  It is a
>>     Jeff> hack that hides bugs.
>>
>> Why do you say that?  Preempt seems to be the cleanest way to low
>> latency, and if anything it exposes locking bugs and races rather than
>> hiding anything.
> 
> 
> Clean?  Hardly.  It breaks up code paths that were never written to be 
> broken up.

But lots of things change. Unserialising the kernel broke code paths.

>  The proper fix is to locate and fix high latency code paths. 
>  Preempt does nothing but hide those high latency code paths, and 
> discourage people from seeking a better solution.
> 
> Fix the drivers, rather than bandaid over them with preempt.
> 
> If all code paths in the kernel were low latency, then you would not 
> need preempt at all.
> 

When you say low latency, you mean small lock hold times, *and*
cond_rescheds placed everywhere - it is this second requirement
that isn't the cleanest way of doign things.

With preempt, sure you still need small lock hold times. No big
deal.
