Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933629AbWKWM02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbWKWM02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933600AbWKWM02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:26:28 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30886 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S933617AbWKWM01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:26:27 -0500
Date: Thu, 23 Nov 2006 15:23:36 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061123122335.GE20294@2ka.mipt.ru>
References: <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru> <4564BAC8.6020306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4564BAC8.6020306@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 23 Nov 2006 15:23:38 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 01:02:00PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >But in this case it will be impossible to have SIGEV_THREAD and 
> >SIGEV_KEVENT
> >at the same time, it will be just the same as SIGEV_SIGNAL but with
> >different delivery mechanism. Is is what you expect for that?
> 
> Yes, that's expected.  The event if for the queue, not directed to a 
> specific thread.
> 
> If in future we want to think about preferably waking a specific thread 
> we can then think about it.  But I doubt that'll be beneficial.  The 
> thread specific part in the signal handling is only used to implement 
> the SIGEV_THREAD notification.

Ok, so please review patch I sent, if it is ok from design point of
view, I will run some tests here.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
