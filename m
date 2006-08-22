Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWHVOgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWHVOgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWHVOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:36:13 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:65493 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932272AbWHVOgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:36:12 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Aug 2006 07:35:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Christoph Hellwig <hch@infradead.org>
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       tglx@linutronix.de
Subject: Re: [take9 2/2] kevent: poll/select() notifications. Timer notifications.
In-Reply-To: <20060816133014.GB32499@infradead.org>
Message-ID: <Pine.LNX.4.64.0608220730030.14814@alien.or.mcafeemobile.com>
References: <1155536496588@2ka.mipt.ru> <11555364962857@2ka.mipt.ru>
 <20060816133014.GB32499@infradead.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Christoph Hellwig wrote:

> On Mon, Aug 14, 2006 at 10:21:36AM +0400, Evgeniy Polyakov wrote:
>>
>> poll/select() notifications. Timer notifications.
>>
>> This patch includes generic poll/select and timer notifications.
>>
>> kevent_poll works simialr to epoll and has the same issues (callback
>> is invoked not from internal state machine of the caller, but through
>> process awake).
>
> I'm not a big fan of duplicating code over and over.  kevent is a candidate
> for a generic event devlivery mechanisms which is a _very_ good thing.  But
> starting that system by duplicating existing functionality is not very nice.
>
> What speaks against a patch the recplaces the epoll core by something that
> build on kevent while still supporting the epoll interface as a compatibility
> shim?

Sorry, I'm catching up with a huge post-vacation backlog, so I didn't have 
the time to look at the source code. But, if kevent performance is same or 
better, and the external epoll interface is fully supported, than I think 
the shim layer idea is a good one. Provided the shim being smaller than 
eventpoll.c :)



- Davide


