Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVHUVM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVHUVM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVHUVM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:12:29 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751106AbVHUVM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:12:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ccdzGpFdCj0NnblVIVx7Pr2TO95m2NXEV/7ybU/r8giVJNBN/X1Qkn/oVCf4WTxo+zAqdM9s7kB1qx8RtAikt6mKzmbUh5/GgGCf3NFRoMa16Fdo3OdTxF1bWy8tTt1mT6tdxs5E9gLWB6KDdrIc7sK+731fLp1AUePlxrhYkEI=  ;
Message-ID: <20050821202141.78795.qmail@web33305.mail.mud.yahoo.com>
Date: Sun, 21 Aug 2005 13:21:41 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9a87484905082111205d27c1aa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 8/21/05, Jesper Juhl <jesper.juhl@gmail.com>
> wrote:
> > On 8/21/05, Danial Thom
> <danial_thom@yahoo.com> wrote:
> > > >
> > > Ok, well you'll have to explain this one:
> > >
> > > "Low latency comes at the cost of decreased
> > > throughput - can't have both"
> > >
> > > Seems to be a bit backwards. Threading the
> kernel
> > > adds latency, so its the additional latency
> in
> > > the kernel that causes the drop in
> throughput. Do
> > > you mean that kernel performance has been
> > > sacrificed in order to be able to service
> other
> > > threads more quickly, even when there are
> no
> > > other threads to be serviced?
> > >
> > 
> > Ok, let me start with the way HZ influences
> things.
> > 
> [snip]
> 
> A small followup.
> 
> I'm not saying that the value of HZ or your
> preempt setting (whatever
> it may be) is definately the cause of your
> problem. All I'm saying is
> that it might be a contributing factor, so it's
> probably something
> that's worth a little bit of time testing.
> 
> In many cases people running a server on
> resonably new hardware with
> HZ=1000 and full preempt won't even notice, but
> that's depending on
> the load on the server and what jobs it has.
> For some tasks it
> matters, for some the differences in
> performance is negligible.
> 
> You problem could very well be something else
> entirely, but try a
> kernel build with PREEMPT_NONE and HZ=100 and
> see if it makes a big
> difference (or if that's your current config,
> then try the opposite,
> HZ=1000 and PREEMPT). If it does make a
> difference, then that's a
> valuable piece of information to report on the
> list. If it turns out
> it makes next to no difference at all, then
> that as well is relevant
> information as then people will know that HZ &
> preempt is not the
> cause and can focus on finding the problem
> elsewhere.
> 
Yes. Hz isn't going to make much difference on a
2.0Ghz opteron, but I can see how premption can
cause packet loss. Shouldn't packet processing be
the highest priority process? It seems pointless
to "keep the audio buffers full" if you're
dropping packets as a result. 

Also some clown typing on the keyboard shouldn't
cause packet loss. Trading network integrity for
snappy responsiveness is a bad trade.

Danial


		
__________________________________ 
Yahoo! Mail for Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
