Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVHUVmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVHUVmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVHUVmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:42:45 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45517 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751179AbVHUVmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2BNQsrNbeXz3EO18iv2qsT5uic8OvTCoBrLTbv3e7p3M197u8kF+8elidofowluqP/C/E4Wxcqwi1aCOjxofPkX3kqdzsXv/4QVNMOgmHF/pDIOBY7Z+XqEcYf7yRaqK9d3hR5cbaRNBTwm2oUy1WL6IKcCC0Lt0SLPonBVZoAI=  ;
Message-ID: <20050821165723.5531.qmail@web33304.mail.mud.yahoo.com>
Date: Sun, 21 Aug 2005 09:57:22 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 8/21/05, Danial Thom <danial_thom@yahoo.com>
> wrote:
> > I just started fiddling with 2.6.12, and
> there
> > seems to be a big drop-off in performance
> from
> > 2.4.x in terms of networking on a
> uniprocessor
> > system. Just bridging packets through the
> > machine, 2.6.12 starts dropping packets at
> > ~100Kpps, whereas 2.4.x doesn't start
> dropping
> > until over 350Kpps on the same hardware
> (2.0Ghz
> > Opteron with e1000 driver). This is pitiful
> > prformance for this hardware. I've
> > increased the rx ring in the e1000 driver to
> 512
> > with little change (interrupt moderation is
> set
> > to 8000 Ints/second). Has "tuning" for MP
> > destroyed UP performance altogether, or is
> there
> > some tuning parameter that could make a
> 4-fold
> > difference? All debugging is off and there
> are
> > no messages on the console or in the error
> logs.
> > The kernel is the standard kernel.org dowload
> > config with SMP turned off and the intel
> ethernet
> > card drivers as modules without any other
> > changes, which is exactly the config for my
> 2.4
> > kernels.
> > 
> 
> If you have preemtion enabled you could disable
> it. Low latency comes
> at the cost of decreased throughput - can't
> have both. Also try using
> a HZ of 100 if you are currently using 1000,
> that should also improve
> throughput a little at the cost of slightly
> higher latencies.
> 
> I doubt that it'll do any huge difference, but
> if it does, then that
> would probably be valuable info.
> 
Ok, well you'll have to explain this one:

"Low latency comes at the cost of decreased
throughput - can't have both"

Seems to be a bit backwards. Threading the kernel
adds latency, so its the additional latency in
the kernel that causes the drop in throughput. Do
you mean that kernel performance has been
sacrificed in order to be able to service other
threads more quickly, even when there are no
other threads to be serviced?

Danial



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
