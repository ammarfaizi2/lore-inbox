Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273233AbRIWDTr>; Sat, 22 Sep 2001 23:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273240AbRIWDTj>; Sat, 22 Sep 2001 23:19:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22510 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S273233AbRIWDTY>; Sat, 22 Sep 2001 23:19:24 -0400
Message-ID: <3BAD5493.EC4F845A@mvista.com>
Date: Sat, 22 Sep 2001 20:18:43 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Pang <ozone@algorithm.com.au>
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
        safemode@speakeasy.net, Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl,
        ilsensine@inwind.it
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <1000939458.3853.17.camel@phantasy> <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au> <1001139027.1245.28.camel@phantasy> <1001143341.117502.5311.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Pang wrote:
> 
> On Sat, Sep 22, 2001 at 02:10:18AM -0400, Robert Love wrote:
> 
> > > i did a test of it on linux-2.4.10-pre13 with Benno Senoner's
> > > lowlatency program, which i hacked up a bit to output
> > > /proc/latencytimes after each of the graphs.  test results are at
> > >
> > >     http://www.algorithm.com.au/hacking/linux-lowlatency/2.4.10-pre13-pes/
> > >
> > > and since i stared at the results in disbelief, i won't even try
> > > to guess what's going on :).  maybe you can make some sense of
> > > it?
> >
> > Well, its not hard to decipher...and really, its actually fairly good.
> > the latency test program is giving you a max latency of around 12ms in
> > each test, which is OK.
> 
> arrgh!  i just realised my script buggered up and was producing the same
> graph for all the results.  please have a look at the page again, sorry.
> 
> apart from that, i'm still confused.  compared to other graphs produced
> by the latencytest program, my system seems to have huge latencies.
> unless i'm reading it wrongly, the graph is saying that i'm getting
> latencies of up to 30ms, and a lot of overruns.  compare this to
> 
>     http://www.gardena.net/benno/linux/audio/2.4.0-test2/3x256.html
> 
> which shows latencytest on 2.4.0-test2, and
> 
>     http://www.gardena.net/benno/linux/audio/2.2.10-p133-3x128/3x128.html
> 
> which are the results for latencytest on 2.2.10.  admittedly these
> kernels are much older, but i'm consistently getting far more latency
> than those kernels.  that's the bit i'm confused about :)  i've tried
> Andrew Morton's low-latency patches as well, to no avail.  i've made
> sure i've tuned my hard disks correctly, and i don't have any other
> realtime processes running.
> 
> am i concerned with a different issue than the one you're addressing?
> 
> > the preemption-test patch is showing _MAX_ latencies of 0.8ms through
> > 12ms.  this is fine, too.
> 
> yep, i agree with that ... so why is latencytest showing scheduling
> latencies of > 30ms?  i get the feeling i'm confusing two different
> issues here.  from what i understand, /proc/latencytimes shows the
> how long it takes for various functions in the kernel to finish, and
> the latencytest result shows how long it takes for it to be
> re-scheduled (represented by the white line on the graph).

The one thing the latancytimes patch doesn't monitor is interrupt off
time.  Maybe it should...


George
