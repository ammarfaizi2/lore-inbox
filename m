Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTICRJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTICRJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:09:19 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:49095 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263980AbTICRHP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:07:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Scaling noise
Date: Wed, 3 Sep 2003 13:07:03 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Scaling noise
Thread-Index: AcNyDViXINEmBkkURQis4H4W7gertAALFwbA
From: "Brown, Len" <len.brown@intel.com>
To: "Larry McVoy" <lm@bitmover.com>
Cc: "Giuliano Pochini" <pochini@shiny.it>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Sep 2003 17:07:08.0829 (UTC) FILETIME=[CF0504D0:01C3723D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortunately seek time on RAM is lower than disk;-)  Sure, parallel
systems are a waste of effort for running a single copy of a single
threaded app, but when you have multiple apps, or better yet MT apps,
you win.  If system performance were limited over time to the rate of
decrease in RAM latency, then we'd be in sorry shape.

Back to the original off-topic...
An OEM can spin their motivation to focus on smaller systems in 3 ways:

1. large server sales are a small % of industry units
2. large server sales are a small % of industry revenue
3. large server sales are a small % of industry profits

Only 1 is true.

Cheers,
-Len

#include <std/disclaimer.h>


> -----Original Message-----
> From: Larry McVoy [mailto:lm@bitmover.com] 
> Sent: Wednesday, September 03, 2003 7:20 AM
> To: Brown, Len
> Cc: Giuliano Pochini; Larry McVoy; linux-kernel@vger.kernel.org
> Subject: Re: Scaling noise
> 
> 
> On Wed, Sep 03, 2003 at 05:41:39AM -0400, Brown, Len wrote:
> > > Latency is not bandwidth.
> > 
> > Bingo.
> > 
> > The way to address memory latency is by increasing bandwidth and
> > increasing parallelism to use it -- thus amortizing the latency.  
> 
> And if the app is a pointer chasing app, as many apps are, 
> that doesn't
> help at all.
> 
> It's pretty much analogous to file systems.  If bandwidth was 
> the answer
> then we'd all be seeing data moving at 60MB/sec off the disk. 
>  Instead 
> we see about 4 or 5MB/sec.
> 
> Expecting more bandwidth to help your app is like expecting 
> more platter
> speed to help your file system.  It's not the platter speed, it's the
> seeks which are the problem.  Same thing in system doesn't, 
> it's not the
> bcopy speed, it's the cache misses that are the problem.  
> More bandwidth
> doesn't do much for that.
> -- 
> ---
> Larry McVoy              lm at bitmover.com          
> http://www.bitmover.com/lm
> 
