Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRDWVZv>; Mon, 23 Apr 2001 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRDWVZo>; Mon, 23 Apr 2001 17:25:44 -0400
Received: from rhdv.cistron.nl ([195.64.71.178]:45572 "EHLO rhdv.cistron.nl")
	by vger.kernel.org with ESMTP id <S132301AbRDWVZa>;
	Mon, 23 Apr 2001 17:25:30 -0400
Content-Type: text/plain; charset=US-ASCII
X-KMail-Redirect-From: Robert H. de Vries <rhdv@rhdv.cistron.nl>
Subject: Re: high-res-timers start code.
From: "Robert H. de Vries" <rhdv@rhdv.cistron.nl> (by way of Robert H. de
	Vries <rhdv@rhdv.cistron.nl>)
Date: Mon, 23 Apr 2001 23:25:32 +0200
To: high-res-timers-discourse@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01042323253201.18984@calvin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 23 April 2001 22:43, George Anzinger wrote:
> "Robert H. de Vries" wrote:
> > On Monday 23 April 2001 19:45, you wrote:
> > > By the way, is the user land stuff the same for all "arch"s?
> >
> > Not if you plan to handle the CPU cycle counter in user space. That is at
> > least what I would propose.
>
> Just got interesting, lets let the world look in.
>
> What did you have in mind here?  I suspect that on some archs the cycle
> counter is not available to user code.  I know that on parisc it is
> optionally available (kernel can set a bit to make it available), but by
> it self it is only good for intervals.  You need to peg some value to a
> CLOCK to use it to get timeofday, for instance.
>
> On the other hand, if there is an area of memory that both users and
> system can read but only system can write, one might put the soft clock
> there.  This would allow gettimeofday (with the cycle counter) to work
> without a system call.  To the best of my knowledge the system does not
> have such an area as yet.

It obviously is an architecture dependent thing. I know of two archtictures
which have such a counter: your standard pentium and up and the SGI systems
from at least the Indy and up. I wouldn't be surprised if most CPU's have
such a counter. If you look at some of the architecture specific code for the
gettimeofday code you would quickly find out which architectures have such a
feature. I have some code for the intel in my user space library. For the SGI
I also have some code, but only for IRIX. I guess for Linux we could do
similar code.

	Robert

-- 
Robert de Vries
rhdv@rhdv.cistron.nl
