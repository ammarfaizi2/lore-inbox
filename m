Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSJWQbd>; Wed, 23 Oct 2002 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265071AbSJWQbd>; Wed, 23 Oct 2002 12:31:33 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:7669 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265065AbSJWQbc>; Wed, 23 Oct 2002 12:31:32 -0400
Message-ID: <3DB6D332.9000709@kegel.com>
Date: Wed, 23 Oct 2002 09:49:54 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: "Charles 'Buck' Krasic" <krasic@acm.org>,
       Mark Mielke <mark@mark.mielke.cc>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210221231330.1563-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
 > On 22 Oct 2002, Charles 'Buck' Krasic wrote:
 >
 >> So maybe epoll's moment of utility is only transient.  It should have
 >> been in the kernel a long time ago.  Is it too late now that AIO is
 >> imminent?
 >
 > This is not my call actually. But beside comparing actual performance
 > between AIO and sys_epoll, one of the advantages that the patch had is
 > ... it has a very little "intrusion" in the original code by plugging
 > in the existing architecture.

epoll has another benefit: it works with read() and write().  That
makes it easier to use with existing libraries like OpenSSL
without having to recode them to use aio_read() and aio_write().

Furthermore, epoll is nice because it delivers one-shot readiness change
notification (I used to think that was a drawback, but coding
nonblocking OpenSSL apps has convinced me otherwise).
I may be confused, but I suspect the async poll being proposed by
Ben only delivers absolute readiness, not changes in readiness.

I think epoll is worth having, even if Ben's AIO already handled
networking properly.
- Dan

