Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRFWAqQ>; Fri, 22 Jun 2001 20:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbRFWAqG>; Fri, 22 Jun 2001 20:46:06 -0400
Received: from zipperii.zip.com.au ([61.8.0.87]:50961 "EHLO
	zipperii.zip.com.au") by vger.kernel.org with ESMTP
	id <S264963AbRFWApu>; Fri, 22 Jun 2001 20:45:50 -0400
Date: Sat, 23 Jun 2001 10:45:46 +1000
From: raf <raf2@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: bugreport: poll() timeout always takes 10ms too long
Message-ID: <20010623104546.A9007@zipperii.zip.com.au>
In-Reply-To: <20010622115212.A8681@eccles.raf.org> <1yodnnu5.wl@nisaaru.open.nm.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1yodnnu5.wl@nisaaru.open.nm.fujitsu.co.jp>; from tachino@open.nm.fujitsu.co.jp on Fri, Jun 22, 2001 at 01:24:50PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tachino Nobuhiro wrote:

> 
>  Hello,
> 
> At Fri, 22 Jun 2001 11:52:12 +1000,
> raf@raf.org wrote:
> > 
> > [1.] One line summary of the problem:    
> > 
> > poll() timeout always takes 10ms too long
> > 
> > [2.] Full description of the problem/report:
> > 
> > Select() timeouts work fine. A timeout between 10n-9 and 10n ms times
> > out after 10n ms on average. Poll() timeouts between 10n-9 and 10n ms,
> > on the other hand, time out after 10(n+1) ms on average. It's always a
> > jiffy too long. This means it's impossible to set a 10ms timeout using
> > poll() even though it's possible using select(). The programs and their
> > output below [6] demonstrate this. The same behavious occurs with
> > linux-2.2 and linux-2.4.
> 
> 
>   I think this is correct behavior. The Single UNIX Specification
> describes about the timeout parameter of poll() as follows,
> 
> 	If none of the defined events have occurred on any selected
> 	file descriptor, poll() waits at least timeout milliseconds
> 	for an event to occur on any of the selected file descriptors.
> 
>   On the other hand, select(),
> 
> 	If the specified condition is false for all of the specified
> 	file descriptors, select() blocks, up to the specified timeout
> 	interval, until the specified condition is true for at least
> 	one of the specified file descriptors.

ok, it's a correct behaviour.
but having both poll and select
timeout at the time specified
would also be correct behaviour.
better than that, it would be
expected behaviour.

raf

