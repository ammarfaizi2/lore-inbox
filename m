Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279674AbRKIIGZ>; Fri, 9 Nov 2001 03:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279684AbRKIIGO>; Fri, 9 Nov 2001 03:06:14 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59639
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279674AbRKIIGA>; Fri, 9 Nov 2001 03:06:00 -0500
Date: Fri, 9 Nov 2001 00:05:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011109000554.A495@mikef-linux.matchmail.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20011108153749.A14468@mikef-linux.matchmail.com> <Pine.LNX.4.33.0111090924400.2240-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111090924400.2240-100000@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 09:28:09AM +0100, Ingo Molnar wrote:
> 
> On Thu, 8 Nov 2001, Mike Fedyk wrote:
> 
> > It remains to be proven whether the coarser scheduling approach
> > (Ingo's) will actually help when looking at cache properties.... [...]
> 
> have you seen the numbers/measurements i posted in my original email? 3%
> kernel compile speedup on an 'idle' 8-way system, 7% compilation speedup
> with HZ=1024 and background networking load on a 1-way system.
> 

Yep, but it probably won't do as well on my 2x366 celeron system that I use
every day...

Haven't tested, but it looks like there wouldn't be much chance of the third
CPU hog to stay in the caches.  That's pretty much flushing the entire cache
of the previous task with the longer periods of execution.

Now, if the number of sequential jiffies were modified based on the L1/L2
cache sizes that would be interesting...

Also Ingo, if you're worried about your processes staying in the cache, I'd
work on the processor affinity before working on this...  But, then again,
I'm not you, and I don't know how myself... :(

Mike
