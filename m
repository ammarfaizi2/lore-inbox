Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267958AbTBVXFt>; Sat, 22 Feb 2003 18:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTBVXFt>; Sat, 22 Feb 2003 18:05:49 -0500
Received: from bitmover.com ([192.132.92.2]:32428 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267958AbTBVXFs>;
	Sat, 22 Feb 2003 18:05:48 -0500
Date: Sat, 22 Feb 2003 15:15:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222231552.GA31268@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2080000.1045947731@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 01:02:12PM -0800, Martin J. Bligh wrote:
> > How much do you want to bet that more than 95% of their server revenue
> > comes from 4CPU or less boxes?  I wouldn't be surprised if it is more
> > like 99.5%.  And you can configure yourself a pretty nice quad xeon box
> > for $25K.  Yeah, there is some profit in there but nowhere near the huge
> > margins you are counting on to make your case.
> 
> OK, so now you've slid from talking about PCs to 2-way to 4-way ...
> perhaps because your original arguement was fatally flawed.

Nice attempt at deflection but it won't work.  Your position is that
there is no money in PC's only in big iron.  Last I checked, "big iron"
doesn't include $25K 4 way machines, now does it?  You claimed that
Dell was making the majority of their profits from servers.  To refresh
your memory: "I bet they still make more money on servers than desktops
and notebooks combined".  Are you still claiming that?  If so, please
provide some data to back it up because, as Mark and others have pointed
out, the bulk of their servers are headless desktop machines in tower
or rackmount cases.  I fail to see how there are better margins on the
same hardware in a rackmount box for $800 when the desktop costs $750.
Those rack mount power supplies and cases are not as cheap as the desktop
ones, so I see no difference in the margins.

Let's get back to your position.  You want to shovel stuff in the kernel
for the benefit of the 32 way / 64 way etc boxes.  I don't see that as
wise.  You could prove me wrong.  Here's how you do it: go get oprofile
or whatever that tool is which lets you run apps and count cache misses.
Start including before/after runs of each microbench in lmbench and 
some time sharing loads with and without your changes.  When you can do
that and you don't add any more bus traffic, you're a genius and 
I'll shut up.

But that's a false promise because by definition, fine grained threading
adds more bus traffic.  It's kind of hard to not have that happen, the
caches have to stay coherent somehow.

> Some applications work well on clusters, which will give them cheaper 
> hardware, at the expense of a lot more complexity in userspace ... 
> depending on the scale of the system, that's a tradeoff that might go 
> either way. 

Tell it to Google.  That's probably one of the largest applications in
the world; I was the 4th engineer there, and I didn't think that the
cluster added complexity at all.  On the contrary, it made things go
one hell of a lot faster.

> You don't believe we can make it scale without screwing up the low end,
> I do believe we can do that. 

I'd like a little more than "I think I can, I think I can, I think I can".
The people who are saying "no you can't, no you can't, no you can't" have
seen this sort of work done before and there is no data which shows that
it is possible and all sorts of data which shows that it is not.

Show me one OS which scales to 32 CPUs on an I/O load and run lmbench 
on a single CPU.  Then take that same CPU and stuff it into a uniprocessor
motherboard and run the same benchmarks on under Linux.  The Linux one
will blow away the multi threaded one.  Come on, prove me wrong, show
me the data.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
