Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVHYUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVHYUpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVHYUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:45:18 -0400
Received: from web33303.mail.mud.yahoo.com ([68.142.206.118]:62093 "HELO
	web33303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932566AbVHYUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:45:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RsHrM3yicmDlT6PzYOlJHCa1GRy0okVbMMUykJCvxgzcDCwrBCifBspoHSv6hidg6jpDnVxP0sfG94NOcmXDedAIsHrYUU+WRlLyEY90dSJgGBX3QVQMaKsZp+a3s3J/3Ld8bHrZ5HjX6ZmORjYV+l3253mLDfC4VAUyIGaRHWw=  ;
Message-ID: <20050825204508.61645.qmail@web33303.mail.mud.yahoo.com>
Date: Thu, 25 Aug 2005 13:45:08 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Ben Greear <greearb@candelatech.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <430DF7FF.9080502@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ben Greear <greearb@candelatech.com> wrote:

> Danial Thom wrote:
> 
> > The tests I reported where on UP systems.
> Perhaps
> > the default settings are better for this in
> 2.4,
> > since that is what I used, and you used your
> > hacks for both.
> 
> My modifications to the kernel are unlikely to
> speed anything
> up, and probably will slow things down ever so
> slightly.
> 
> I can try with a UP kernel, but my machine at
> least has a single
> processor.  I'm using the SMP kernel to take
> advantage of HT.
> 
> > Are you getting drops or overruns (or both)?
> I
> > would assume drops is a decision to drop
> rather
> > than an overrun which is a ring overrun.
> Overruns
> > would imply more about performance than
> tuning,
> > I'd think.
> 
> I was seeing lots of NIC errors...in fact, it
> was showing a great many
> more errors than packets sent to it, so I just
> ignored them.
> 
> I increased the TxDescriptors and RxDescriptors
> and that helped a little.
> 
> Increasing the transmit queue for the NIC to
> 2000 also helped a little.
> 
> > I wouldn't think that HT would be appropriate
> for
> > this sort of setup...?
> 
> 2.6.11 seems to be faster when running SMP
> kernel on this system.

HT and SMP are not the same animal, are they? My
understanding is that an HT aware scheduler is
likely to make things worse most of the time,
particularly for systems not running a lot of
threads..


> > 
> > You're using a dual PCI-X NIC rather than the
> > onboard ports? Supermicro runs their onboard
> 
> Of course.  Never found a motherboard yet with
> decent built-in
> NICs.  The built-ins on this board are tg3 and
> they must be on
> a slow bus, because they cannot go faster than
> about 700Mbps
> (using big pkts).

If its the P8SCI or the same design they are on a
1X PCIE thats shared with the PCI-X. Pretty hokey
stuff. Its also a low-end controller amongst the
broadcom parts.

Danial


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
