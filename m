Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbRCBUXZ>; Fri, 2 Mar 2001 15:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRCBUXG>; Fri, 2 Mar 2001 15:23:06 -0500
Received: from colorfullife.com ([216.156.138.34]:59141 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129473AbRCBUXD>;
	Fri, 2 Mar 2001 15:23:03 -0500
Message-ID: <3AA00143.47E8368E@colorfullife.com>
Date: Fri, 02 Mar 2001 21:23:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Neelam Saboo <neelam_saboo@usa.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Re: paging behavior in Linux]
In-Reply-To: <20010302194303.14346.qmail@www0a.netaddress.usa.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neelam Saboo wrote:
> 
> hi,
> 
> After I installed a newer version of Kernel (2.4.2) and enable DMA option in
> hardware configuration, the behavior changes.
> I can see performance improvements when another thread is used. Also, i can
> see timing overlaps between two threads. i.e. when one thread is blocked on a
> page fault, other thread keeps working.
> Now, how can this behavior be explained , given the earlier argument.
> Is it that, a newer version of kernel has fixed the problem of the semaphore
> ?
>
No, that change won't happen until 2.5

I can only guess:
the other thread keeps working until it causes a page fault - with both
2.4.1 and 2.4.2.

I haven't followed the threads about the mm changes closely, but I
assume that the swapout behaviour changed, and that your worker thread
now runs without causing page faults.

--
	Manfred
