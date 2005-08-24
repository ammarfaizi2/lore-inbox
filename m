Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVHXR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVHXR0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVHXR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:26:37 -0400
Received: from web33309.mail.mud.yahoo.com ([68.142.206.124]:62570 "HELO
	web33309.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751247AbVHXR0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:26:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LemCofWJ2FzT5csVlWwgr1ynxBNJPGUI+ZK9Kmrk5fHPYS9URGc7cDcuaJwozxsFrD0dsDCliLkTqHjUbDs1NpO40Kb/B3WzSXF3GhKxxVFey8kP+q5axCz4JzJ4lumefsYRClFXpZQYMLp/Upul7geQNUiSLT+FdtY2zC3BQm0=  ;
Message-ID: <20050824172631.11829.qmail@web33309.mail.mud.yahoo.com>
Date: Wed, 24 Aug 2005 10:26:31 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a87484905082409356c549512@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 8/24/05, Danial Thom <danial_thom@yahoo.com>
> wrote:
> > --- Patrick McHardy <kaber@trash.net> wrote:
> > 
> > > Danial Thom wrote:
> > > > I think part of the problem is the
> continued
> > > > misuse of the word "latency". Latency, in
> > > > language terms, means "unexplained
> delay".
> > > Its
> > > > wrong here because for one, its
> explainable.
> > > But
> > > > it also depends on your perspective. The
> > > > "latency" is increased for kernel tasks,
> > > while it
> > > > may be reduced for something that is
> getting
> > > the
> > > > benefit of preempting the kernel. So you
> > > really
> > > > can't say "the price of reduced latency
> is
> > > lower
> > > > throughput", because thats simply
> backwards.
> > > > You've increased the kernel tasks latency
> by
> > > > allowing it to be pre-empted. Reduced
> latency
> > > > implies higher efficiency. All you've
> done
> > > here
> > > > is shift the latency from one task to
> > > another, so
> > > > there is no reduction overall, in fact
> there
> > > is
> > > > probably a marginal increase due to the
> > > overhead
> > > > of pre-emption vs doing nothing.
> > >
> > > If instead of complaining you would provide
> the
> > > information
> > > I've asked for two days ago someone might
> > > actually be able
> > > to help you.
> > 
> > Because gaining an understanding of how the
> > settings work is better than having 30 guys
> > telling me to tune something that is only
> going
> > to make a marginal difference. I didn't ask
> you
> > to tell me what was wrong with my setup, only
> > whether its expected that 2.6 would be less
> > useful in a UP setup than 2.4, which I think
> > you've answered.
> > 
> 
> I hope you're implying that the answer is; no,
> it's not expected that
> 2.6 is less useful in a UP setup than 2.4  :-)

I think the concensus is that 2.6 has made trade
offs that lower raw throughput, which is what a
networking device needs. So as a router or
network appliance, 2.6 seems less suitable. A raw
bridging test on a 2.0Ghz operton system:

FreeBSD 4.9: Drops no packets at 900K pps
Linux 2.4.24: Starts dropping packets at 350K pps
Linux 2.6.12: Starts dropping packets at 100K pps

Now the 2.6.12 keyboard is always nice and
snappy, but thats not what I need. I can't have a
box drop traffic if some admin decides to
recompile some application. Linux is fine on
low-medium speed networks, but at a certain
capacity, depending on the specs of the machine
of course, linux drops packets. 

If I do a "make install" in BSD when on a busy
network, it takes a long time, but it doesn't
drop packets. Linux compiles a lot faster, but it
drops buckets of packets. Its just not the
priority thats needed for a networking device.

Danial



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
