Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVHYO0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVHYO0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVHYO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:26:49 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:43860 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965019AbVHYO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:26:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TGQw1QYqrz4lyYjNNrjoYKcnlCVvO+OLDD/Ph7Za/P6k8dL8rW0C8qqVUq6LuM9cwHu37FKi410AmBMdu8uQS5JIHgxj/Z79zaFPXcgyrTK7yONRZFJgGiskpsa8LvzY94rutASoc2CgjVzZCBiDpuY7imeqRD11JV0msPDLGhk=  ;
Message-ID: <20050825142647.70995.qmail@web33314.mail.mud.yahoo.com>
Date: Thu, 25 Aug 2005 07:26:47 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Ben Greear <greearb@candelatech.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <430D668A.6030306@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ben Greear <greearb@candelatech.com> wrote:

> Danial Thom wrote:
> > 
> > --- Ben Greear <greearb@candelatech.com>
> wrote:
> > 
> > 
> >>Danial Thom wrote:
> >>
> >>
> >>>I think the concensus is that 2.6 has made
> >>
> >>trade
> >>
> >>>offs that lower raw throughput, which is
> what
> >>
> >>a
> >>
> >>>networking device needs. So as a router or
> >>>network appliance, 2.6 seems less suitable.
> A
> >>
> >>raw
> >>
> >>>bridging test on a 2.0Ghz operton system:
> >>>
> >>>FreeBSD 4.9: Drops no packets at 900K pps
> >>>Linux 2.4.24: Starts dropping packets at
> 350K
> >>
> >>pps
> >>
> >>>Linux 2.6.12: Starts dropping packets at
> 100K
> >>
> >>pps
> >>
> >>I ran some quick tests using kernel 2.6.11,
> 1ms
> >>tick (HZ=1000), SMP kernel.
> >>Hardware is P-IV 3.0Ghz + HT on a new
> >>SuperMicro motherboard with 64/133Mhz
> >>PCI-X bus.  NIC is dual Intel pro/1000. 
> Kernel
> >>is close to stock 2.6.11.
> >>
> >>I used brctl to create a bridge with the two
> >>GigE adapters in it and
> >>used pktgen to stream traffic through it
> >>(250kpps in one direction, 1kpps in
> >>the other.)
> >>
> >>I see a reasonable amount of drops at 250kpps
> >>(60 byte packets):
> >>about 60,000,000 packets received, 20,700
> >>dropped.
> 
> I get slightly worse performance on this system
> when running RH9
> with kernel 2.4.29 (my hacks, HZ=1000, SMP). 
> Tried increasing
> e1000 descriptors to 2048 tx and rx, but that
> didn't help, or at least
> not much.
> 
> Will try some other tunings, but I doubt it
> will affect performance
> enough to come close to the discrepency that
> you show between 2.4
> and 2.6 kernels...
> 
> I tried copying a 500MB CDROM to HD on my RH9
> system, and only 6kpps
> of the 250kpps get through the bridge...btw.

The tests I reported where on UP systems. Perhaps
the default settings are better for this in 2.4,
since that is what I used, and you used your
hacks for both.

Are you getting drops or overruns (or both)? I
would assume drops is a decision to drop rather
than an overrun which is a ring overrun. Overruns
would imply more about performance than tuning,
I'd think.

I wouldn't think that HT would be appropriate for
this sort of setup...?

You're using a dual PCI-X NIC rather than the
onboard ports? Supermicro runs their onboard
controllers at 32bit/33mhz for some mindless
reason.

Danial

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
