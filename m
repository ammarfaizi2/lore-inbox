Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757082AbWKVVFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082AbWKVVFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbWKVVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:05:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757059AbWKVVFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:05:37 -0500
Message-ID: <4564BAC8.6020306@redhat.com>
Date: Wed, 22 Nov 2006 13:02:00 -0800
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
References: <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru>
In-Reply-To: <20061122104416.GD11480@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> But in this case it will be impossible to have SIGEV_THREAD and SIGEV_KEVENT
> at the same time, it will be just the same as SIGEV_SIGNAL but with
> different delivery mechanism. Is is what you expect for that?

Yes, that's expected.  The event if for the queue, not directed to a 
specific thread.

If in future we want to think about preferably waking a specific thread 
we can then think about it.  But I doubt that'll be beneficial.  The 
thread specific part in the signal handling is only used to implement 
the SIGEV_THREAD notification.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
