Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757101AbWKVW1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbWKVW1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757103AbWKVW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:27:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49027 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757099AbWKVW1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:27:41 -0500
Message-ID: <4564CE00.9030904@redhat.com>
Date: Wed, 22 Nov 2006 14:24:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru>
In-Reply-To: <20061122121516.GA7229@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Wed, Nov 22, 2006 at 03:09:34PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
>> Ok, to solve the problem in the way which should be good for both I
>> decided to implement additional syscall which will allow to mark any
>> event as ready and thus wake up appropriate threads. If userspace will
>> request zero events to be marked as ready, syscall will just
>> interrupt/wakeup one of the listeners parked in syscall.

I'll wait for the new code drop to comment.


> Btw, what about putting aditional multiplexer into add/remove/modify
> switch? There will be logical 'ready' addon?

Is it needed?  Usually this is done with a *_wait call with a timeout of 
zero.  That code path might have to be optimized but it should already 
be there.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
