Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTBVXeH>; Sat, 22 Feb 2003 18:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267960AbTBVXeH>; Sat, 22 Feb 2003 18:34:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:18613 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267955AbTBVXeD>; Sat, 22 Feb 2003 18:34:03 -0500
Date: Sat, 22 Feb 2003 15:44:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <3610000.1045957443@[10.10.2.4]>
In-Reply-To: <20030222231552.GA31268@work.bitmover.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, so now you've slid from talking about PCs to 2-way to 4-way ...
>> perhaps because your original arguement was fatally flawed.
> 
> Nice attempt at deflection but it won't work.  

On your part or mine? seemingly yours.

> Your position is that
> there is no money in PC's only in big iron.  Last I checked, "big iron"
> doesn't include $25K 4 way machines, now does it?  

I would call 4x a "big machine" which is what I originally said.

> You claimed that
> Dell was making the majority of their profits from servers. 

I think that's probably true (nobody can be certain, as we don't have the
numbers).

> To refresh
> your memory: "I bet they still make more money on servers than desktops
> and notebooks combined".  Are you still claiming that?  

Yup.

> If so, please
> provide some data to back it up because, as Mark and others have pointed
> out, the bulk of their servers are headless desktop machines in tower
> or rackmount cases. 

So what? they're still servers. I can no more provide data to back it up
than you can to contradict it, because they don't release those figures. 
Note my sentence began "I bet", not "I have cast iron evidence".
 
> Let's get back to your position.  You want to shovel stuff in the kernel
> for the benefit of the 32 way / 64 way etc boxes.  

Actually, I'm focussed on 16-way at the moment, and have never run on,
or published numbers for anything higher. If you need to exaggerate
to make your point, then go ahead, but it's pretty transparent.

> I don't see that as wise.  You could prove me wrong.  
> Here's how you do it: go get oprofile
> or whatever that tool is which lets you run apps and count cache misses.
> Start including before/after runs of each microbench in lmbench and 
> some time sharing loads with and without your changes.  When you can do
> that and you don't add any more bus traffic, you're a genius and 
> I'll shut up.

I don't feel the need to do that to prove my point, but if you feel the
need to do it to prove yours, go ahead.

> But that's a false promise because by definition, fine grained threading
> adds more bus traffic.  It's kind of hard to not have that happen, the
> caches have to stay coherent somehow.

Adding more bus traffic is fine if you increase throughput. Focussing
on just one tiny aspect of performance is ludicrous. Look at the big
picture. Run some non-micro benchmarks. Analyse the results. Compare
2.4 vs 2.5 (or any set of patches I've put into the kernel of your choice) 
On UP, 2P or whatever you care about.

You seem to think the maintainers are morons that we can just slide crap
straight by ... give them a little more credit than that.

> Tell it to Google.  That's probably one of the largest applications in
> the world; I was the 4th engineer there, and I didn't think that the
> cluster added complexity at all.  On the contrary, it made things go
> one hell of a lot faster.

As I've explained to you many times before, it depends on the system. 
Some things split easily, some don't.

>> You don't believe we can make it scale without screwing up the low end,
>> I do believe we can do that. 
> 
> I'd like a little more than "I think I can, I think I can, I think I can".
> The people who are saying "no you can't, no you can't, no you can't" have
> seen this sort of work done before and there is no data which shows that
> it is possible and all sorts of data which shows that it is not.

The only data that's relevant is what we've done to Linux. If you want
to run the numbers, and show some useful metric on a semi-realistic
benchmark, I'd love to seem.
 
> Show me one OS which scales to 32 CPUs on an I/O load and run lmbench 
> on a single CPU.  Then take that same CPU and stuff it into a uniprocessor
> motherboard and run the same benchmarks on under Linux.  The Linux one
> will blow away the multi threaded one.  

Nobody has every really focussed before on an OS that scales across the 
board from UP to big iron ... a closed development system is bad at 
resolving that sort of thing. The real interesting comparison is UP
or 2x SMP on Linux with and without the scalability changes that have 
made it into the tree.

> Come on, prove me wrong, show me the data.

I don't have to *prove* you wrong. I'm happy in my own personal knowledge
that you're wrong, and things seem to be going along just fine, thanks.
If you want to change the attitude of the maintainers, I suggest you
generate the data yourself.

M.



