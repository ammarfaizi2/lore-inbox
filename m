Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRHGPRJ>; Tue, 7 Aug 2001 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268427AbRHGPRA>; Tue, 7 Aug 2001 11:17:00 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:28736
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S268511AbRHGPQn>; Tue, 7 Aug 2001 11:16:43 -0400
Date: Tue, 7 Aug 2001 08:16:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@webofficenow.com>
Cc: Paul Flinders <ptf@ftel.co.uk>, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: SIS 630E perf problems?
Message-ID: <20010807081652.A11619@work.bitmover.com>
Mail-Followup-To: Rob Landley <landley@webofficenow.com>,
	Paul Flinders <ptf@ftel.co.uk>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108061713.f76HDaj16575@work.bitmover.com> <3B6F14E2.3030209@ftel.co.uk> <01080618523906.04153@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01080618523906.04153@localhost.localdomain>; from landley@webofficenow.com on Mon, Aug 06, 2001 at 06:52:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've used a few funky SIS chipsets, on and off, for a long time now, and they 
> always have one leeeetle problem...
> 
> Try benchmarking it with a lower screen resolution (like 640x480x256 colors). 
>  If the video is sharing main memory, it's sharing the memory bandwidth as 
> well.  So you've basically got a constant ultra-high-priority DMA going to 
> the screen, sucking up bandwidth and fighting with everything else.  
> (Everything else MUST lose or the display would sparkle.  
> 1280x1024x32bitsx70hz is HOW much bandwidth we're talking here?)

OK, a copuple of updates on this:

I wasn't running X when I ran the benchmarks.

I played around with the bios settings enough to make the machine not
pass POST anymore so I reset the CMOS.  Doing that, plus telling the
system to autodetect DRAM clocks dropped the latencies down to 260ns
outside of X and 281ns with X running.  Still not fantastic but good
enough I suppose.

In reference to the fans that someone else mentioned: I think it is the
CPU fan making the noise.  Regardless, the MTBF of the power supply fans
is one year.  I have about a dozen of generation 1 of these bookpcs and
the fans all started failing at 1 year and frying the power supplies.
Those dinky power supplies are hard to find so you want to avoid this.
We bought a pile of fans and replaced them all; one benefit is that the
higher quality fans are much less noisy.  Something to look into.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
