Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSGKNj5>; Thu, 11 Jul 2002 09:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317837AbSGKNj5>; Thu, 11 Jul 2002 09:39:57 -0400
Received: from mark.mielke.cc ([216.209.85.42]:53769 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317836AbSGKNj4>;
	Thu, 11 Jul 2002 09:39:56 -0400
Date: Thu, 11 Jul 2002 09:36:20 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Linux <linux-kernel@vger.kernel.org>
Subject: Whoa... (was: Re: HZ, preferably as small as possible)
Message-ID: <20020711093620.A19422@mark.mielke.cc>
References: <3D2CA6E3.CB5BC420@zip.com.au> <Pine.LNX.4.44.0207101559460.5067-100000@hawkeye.luckynet.adm> <20020710160921.H32168@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020710160921.H32168@host110.fsmlabs.com>; from cort@fsmlabs.com on Wed, Jul 10, 2002 at 04:09:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 04:09:21PM -0600, Cort Dougan wrote:
> Yes, please do make it a config option.  10x interrupt overhead makes me
> worry.  It lets users tailor the kernel to their expected load.

All this talk is getting to me.

I thought we recently (1 month ago? 2 months ago?) concluded that
increases in interrupt frequency only affects performance by a very
small amount, but generates an increase in responsiveness. The only
real argument against that I have seen, is the 'power conservation'
argument. The idea was, that the scheduler itself did not execute
on most interrupts. The clock is updated, and that is about all.

I can invent a reason as to why throughput increases, from user space.
The hard drive sends data to the kernel, the kernel handles the
hardware interrupt, grabs the buffer, and returns control to the
active process/thread. It may be some time until the process/thread
that is *reading* the data gets scheduled. Any reduction in the
average time a process/thread will be scheduled to execute, results in
increased throughput.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

