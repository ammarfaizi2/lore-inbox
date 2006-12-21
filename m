Return-Path: <linux-kernel-owner+w=401wt.eu-S965205AbWLUKls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWLUKls (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWLUKls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:41:48 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41456 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965195AbWLUKlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:41:47 -0500
Message-ID: <458A64E5.4050703@garzik.org>
Date: Thu, 21 Dec 2006 05:41:41 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling mechanism.
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru> <20061221103539.GA4099@2ka.mipt.ru>
In-Reply-To: <20061221103539.GA4099@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Thu, Dec 21, 2006 at 12:14:17PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
>> Generic event handling mechanism.
>>
>> Kevent is a generic subsytem which allows to handle event notifications.
>> It supports both level and edge triggered events. It is similar to
>> poll/epoll in some cases, but it is more scalable, it is faster and
>> allows to work with essentially eny kind of events.
>>
>> Events are provided into kernel through control syscall and can be read
>> back through ring buffer or using usual syscalls.
>> Kevent update (i.e. readiness switching) happens directly from internals
>> of the appropriate state machine of the underlying subsytem (like
>> network, filesystem, timer or any other).
>>
>> Homepage:
>> http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent
>>
>> Documentation page:
>> http://linux-net.osdl.org/index.php/Kevent
>>
>> Consider for inclusion.
> 
> Due to this stall kevent inclusion into lighttpd CVS tree is postponed.
> 
> The last version will be released saturday or sunday, and looking into
> overhelming flow of feedback comments on this feature, project will not
> be released to linux-kernel@, after this I will
> complete netchannels support and start kevent based AIO project - mostly
> network AIO with new design, which is based on set of entities, which
> can describe set of tasks which should be performed
> asynchronously (from user point of view, although read and write
> obviously must be done after open and before close), for example syscall

kevent is being considered for inclusion, but there is no need to get 
impatient.  Once kevent code stops getting revised rapidly, Andrew 
Morton can pick it up for -mm, for wide dissemination, testing and 
review.  After that phase, it can be pushed to mainline.

The feeling I get from other kernel hackers is that you are demanding 
inclusion "now! now! now!" rather than giving all stakeholders a chance 
to give input, and let your design sink into the collective brain.

This isn't just an optional feature but a key new addition to the 
kernel.  So we should intentionally take more time and consideration 
than normal.  We don't want to go back and have to change fundamental 
kevent details due to design flaws, we want to get it right.

	Jeff



