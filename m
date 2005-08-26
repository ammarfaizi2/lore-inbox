Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbVHZWSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbVHZWSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 18:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbVHZWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 18:18:54 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:20103 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751593AbVHZWSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 18:18:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SO3z1rfLhRdX+7fgczDyW+Gbmtx2bHtwRRRnOJbnKlNBnqzdWHT/GpmhI9rp5aTzWs9B6hheCo9ykcvjzey3RX+DVhVcdyBbtUftWJxPw1QnREmH/kxKEQFMlnkgsOsqfLXGmrRJThsvM+qmasV+Yk6Ap0/P9QJfjXFDJZW6yA0=  ;
Message-ID: <20050826221852.56495.qmail@web33314.mail.mud.yahoo.com>
Date: Fri, 26 Aug 2005 15:18:52 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Ben Greear <greearb@candelatech.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20050826032938.59796.qmail@web33303.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Danial Thom <danial_thom@yahoo.com> wrote:

> 
> 
> --- Ben Greear <greearb@candelatech.com> wrote:
> 
> > Danial Thom wrote:
> > > 
> > > --- Ben Greear <greearb@candelatech.com>
> > wrote:
> > > 
> > > 
> > >>Danial Thom wrote:
> > >>
> > >>
> > >>>I think the concensus is that 2.6 has made
> > >>
> > >>trade
> > >>
> > >>>offs that lower raw throughput, which is
> > what
> > >>
> > >>a
> > >>
> > >>>networking device needs. So as a router or
> > >>>network appliance, 2.6 seems less
> suitable.
> > A
> > >>
> > >>raw
> > >>
> > >>>bridging test on a 2.0Ghz operton system:
> > >>>
> > >>>FreeBSD 4.9: Drops no packets at 900K pps
> > >>>Linux 2.4.24: Starts dropping packets at
> > 350K
> > >>
> > >>pps
> > >>
> > >>>Linux 2.6.12: Starts dropping packets at
> > 100K
> > >>
> > >>pps
> > >>
> > >>I ran some quick tests using kernel 2.6.11,
> > 1ms
> > >>tick (HZ=1000), SMP kernel.
> > >>Hardware is P-IV 3.0Ghz + HT on a new
> > >>SuperMicro motherboard with 64/133Mhz
> > >>PCI-X bus.  NIC is dual Intel pro/1000. 
> > Kernel
> > >>is close to stock 2.6.11.
> > 
> > > What GigE adapters did you use? Clearly
> every
> > > driver is going to be different. My
> > experience is
> > > that a 3.4Ghz P4 is about the performance
> of
> > a
> > > 2.0Ghz Opteron. I have to try your tuning
> > script
> > > tomorrow.
> > 
> > Intel pro/1000, as I mentioned.  I haven't
> > tried any other
> > NIC that comes close in performance to the
> > e1000.
> > 
> > > If your test is still set up, try compiling
> > > something large while doing the test. The
> > drops
> > > go through the roof in my tests.
> > 
> > Installing RH9 on the box now to try some
> > tests...
> > 
> > Disk access always robs networking, in my
> > experience, so
> > I am not supprised you see bad ntwk
> performance
> > while
> > compiling.
> > 
> > Ben
> 
> It would be useful if there were some way to
> find
> out "what" is getting "robbed". If networking
> has
> priority, then what is keeping it from getting
> back to processing the rx interrupts? 
> 
> Ah, the e1000 has built-in interrupt
> moderation.
> I can't get into my lab until tomorrow
> afternoon,
> but if you get a chance try setting ITR in
> e1000_main.c to something larger, like 20K. and
> see if it makes a difference. At 200K pps that
> would cause an interrupt every 10 packets,
> which
> may allow the routine to grab back the cpu more
> often.
> 
> 
> Danial
> 

Just FYI, setting interrupt moderation to 20,000
didn't make much difference. 


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
