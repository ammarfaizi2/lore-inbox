Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274215AbRIVHXK>; Sat, 22 Sep 2001 03:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274321AbRIVHXC>; Sat, 22 Sep 2001 03:23:02 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:28855
	"EHLO bozar") by vger.kernel.org with ESMTP id <S274215AbRIVHWs>;
	Sat, 22 Sep 2001 03:22:48 -0400
Date: Sat, 22 Sep 2001 17:22:21 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	safemode@speakeasy.net, Dieter.Nuetzel@hamburg.de,
	iafilius@xs4all.nl, ilsensine@inwind.it, george@mvista.com
In-Reply-To: <1000939458.3853.17.camel@phantasy> <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au> <1001139027.1245.28.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001139027.1245.28.camel@phantasy>
User-Agent: Mutt/1.3.20i
Message-Id: <1001143341.117502.5311.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 02:10:18AM -0400, Robert Love wrote:

> > i did a test of it on linux-2.4.10-pre13 with Benno Senoner's
> > lowlatency program, which i hacked up a bit to output
> > /proc/latencytimes after each of the graphs.  test results are at
> > 
> >     http://www.algorithm.com.au/hacking/linux-lowlatency/2.4.10-pre13-pes/
> > 
> > and since i stared at the results in disbelief, i won't even try
> > to guess what's going on :).  maybe you can make some sense of
> > it?
> 
> Well, its not hard to decipher...and really, its actually fairly good.
> the latency test program is giving you a max latency of around 12ms in
> each test, which is OK.

arrgh!  i just realised my script buggered up and was producing the same
graph for all the results.  please have a look at the page again, sorry.

apart from that, i'm still confused.  compared to other graphs produced
by the latencytest program, my system seems to have huge latencies.
unless i'm reading it wrongly, the graph is saying that i'm getting
latencies of up to 30ms, and a lot of overruns.  compare this to

    http://www.gardena.net/benno/linux/audio/2.4.0-test2/3x256.html

which shows latencytest on 2.4.0-test2, and

    http://www.gardena.net/benno/linux/audio/2.2.10-p133-3x128/3x128.html

which are the results for latencytest on 2.2.10.  admittedly these
kernels are much older, but i'm consistently getting far more latency
than those kernels.  that's the bit i'm confused about :)  i've tried
Andrew Morton's low-latency patches as well, to no avail.  i've made
sure i've tuned my hard disks correctly, and i don't have any other
realtime processes running.

am i concerned with a different issue than the one you're addressing?

> the preemption-test patch is showing _MAX_ latencies of 0.8ms through
> 12ms.  this is fine, too.

yep, i agree with that ... so why is latencytest showing scheduling
latencies of > 30ms?  i get the feeling i'm confusing two different
issues here.  from what i understand, /proc/latencytimes shows the
how long it takes for various functions in the kernel to finish, and
the latencytest result shows how long it takes for it to be
re-scheduled (represented by the white line on the graph).


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
