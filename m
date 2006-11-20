Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966792AbWKTVz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966792AbWKTVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966804AbWKTVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:55:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966737AbWKTVzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:55:25 -0500
Message-ID: <456223AC.5080400@redhat.com>
Date: Mon, 20 Nov 2006 13:52:44 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <45622228.80803@garzik.org>
In-Reply-To: <45622228.80803@garzik.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I think we have lived with relative timeouts for so long, it would be 
> unusual to change now.  select(2), poll(2), epoll_wait(2) all take 
> relative timeouts.

I'm not talking about always using absolute timeouts.

I'm saying the timeout parameter should be a struct timespec* and then 
the flags word could have a flag meaning "this is an absolute timeout". 
  I.e., enable both uses,, even make relative timeouts the default. 
This is what the modern POSIX interfaces do, too, see clock_nanosleep.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
