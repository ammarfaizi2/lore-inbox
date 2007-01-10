Return-Path: <linux-kernel-owner+w=401wt.eu-S964852AbXAJLLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbXAJLLp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbXAJLLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:11:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:42429 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964849AbXAJLLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:11:43 -0500
Message-ID: <45A4C9DE.8020605@garzik.org>
Date: Wed, 10 Jan 2007 06:11:26 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jamal Hadi Salim <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [take32 0/10] kevent: Generic event handling mechanism.
References: <11684170003907@2ka.mipt.ru>
In-Reply-To: <11684170003907@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Generic event handling mechanism.
> 
> Kevent is a generic subsytem which allows to handle event notifications.
> It supports both level and edge triggered events. It is similar to
> poll/epoll in some cases, but it is more scalable, it is faster and
> allows to work with essentially eny kind of events.
> 
> Events are provided into kernel through control syscall and can be read
> back through ring buffer or using usual syscalls.
> Kevent update (i.e. readiness switching) happens directly from internals
> of the appropriate state machine of the underlying subsytem (like
> network, filesystem, timer or any other).
> 
> Homepage:
> http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent
> 
> Documentation page:
> http://linux-net.osdl.org/index.php/Kevent
> 
> Consider for inclusion.
> 
> With this release I start 3 days resending timeout - i.e. each third day 
> I will send either new version (if something new was requested and agreed 
> to be implemented) or resending with back counter started from three. When 
> back counter hits zero after three resendings I consider there is no interest 
> in subsystem and I will stop further sending. 
> 
> I really doubt it is a good way to tell the world about my work, and I bet you 
> all tired from those pathos words, but I really would like to get some feedback,
> since I want to start to work on network AIO, but sending mails into 
> unfeedbackable 'destination' really does not motivate me for that.
> 
> Thanks for understanding and your time.

Once the rate of change slows, Andrew should IMO definitely pick this up.

If you wanted to make this process automatic, create a git branch that 
Andrew and others can pull.

I like the direction so far, and think it should be in -mm for wider 
testing and review.

	Jeff



