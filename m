Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSJ1W5s>; Mon, 28 Oct 2002 17:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbSJ1W5s>; Mon, 28 Oct 2002 17:57:48 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:22028 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S261701AbSJ1W5r>; Mon, 28 Oct 2002 17:57:47 -0500
Message-ID: <3DBDC236.60507@ixiacom.com>
Date: Mon, 28 Oct 2002 15:03:18 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] epoll more scalable than poll
References: <Pine.LNX.4.44.0210281449150.966-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 28 Oct 2002, Dan Kegel wrote:
>>Another existing event queue for readiness notification to
>>be delivered via is Ben's AIO completion notification queue,
>>but I haven't heard a definitive story about whether
>>epoll events could be delivered that way.  (The discussion
>>seems to always veer into a discussion of asynchronous
>>poll, which is something else.)
> 
> Yep Dan, Ben proposed that approach that we did not have the time to test.
> The way of returning events of sys_epoll is very efficent, like you can
> see in the scalability page ( pipetest ) that Hanna and her team setup :
> 
> http://lse.sourceforge.net/epoll/index.html

I do like those results.  If, however, the unified approach performs
as well, it might be good to go with it to reduce the number of
interfaces, as Martin suggested.  (Though he was suggesting kqueue as
the preferred interface, not Ben's aio...)
- Dan

