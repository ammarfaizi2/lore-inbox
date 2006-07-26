Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWGZUV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWGZUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWGZUV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:21:26 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:8401 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1161031AbWGZUVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:21:25 -0400
Message-ID: <44C7CED0.5020509@cfl.rr.com>
Date: Wed, 26 Jul 2006 16:21:36 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, David Miller <davem@davemloft.net>,
       johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru> <20060726100431.GA7518@infradead.org> <20060726.031247.98341392.davem@davemloft.net> <20060726101539.GA8711@infradead.org>
In-Reply-To: <20060726101539.GA8711@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jul 2006 20:21:36.0574 (UTC) FILETIME=[182B5DE0:01C6B0F1]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14592.000
X-TM-AS-Result: No--2.100000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>> Networking and disk AIO have significantly different needs.
>>
>> Therefore, I really don't see it as reasonable to expect
>> a merge of these two things.  It doesn't make any sense.
> 
> I'm not sure about that.  The current aio interface isn't exactly nice
> for disk I/O either.  I'm more than happy to have a discussion about
> that aspect.
> 


I agree that it makes perfect sense for a merger because aio and 
networking have very similar needs.  In both cases, the caller hands the 
kernel a buffer and wants the kernel to either fill it or consume it, 
and to be able to do so asynchronously.  You also want to maximize 
performance in both cases by taking advantage of zero copy IO.

I wonder though, why do you say the current aio interface isn't nice for 
disk IO?  It seems to work rather nicely to me, and is much better than 
the posix aio interface.

