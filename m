Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWHNHfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWHNHfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWHNHfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:35:47 -0400
Received: from brick.kernel.dk ([62.242.22.158]:47888 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750743AbWHNHfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:35:46 -0400
Date: Mon, 14 Aug 2006 09:37:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-ID: <20060814073724.GJ4231@suse.de>
References: <20060812162857.d85632b9.akpm@osdl.org> <20060812.174324.77324010.davem@davemloft.net> <20060812174549.9a8f8aeb.akpm@osdl.org> <20060812.180944.51301787.davem@davemloft.net> <20060812182234.605b4fb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812182234.605b4fb4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12 2006, Andrew Morton wrote:
> On Sat, 12 Aug 2006 18:09:44 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Andrew Morton <akpm@osdl.org>
> > Date: Sat, 12 Aug 2006 17:45:49 -0700
> > 
> > > Is that also adding 150 usecs to each IO operation?
> > 
> > I have no idea, Jens hasn't done enough to narrow down the true cause
> > of the latencies he is seeing.  So pinpointing it on anything specific
> > is highly premature at this stage.
> 
> Determining whether pre-conversion scsi was impacted in the same manner
> would be part of that pinpointing process.
> 
> Deferring to softirq _has_ to add latency and any latency addition in
> synchronous disk IO is very bad.  That being said, 150 usecs per request is
> so bad that I'd be suspecting that it's not affecting most people, else
> we'd have heard.

Hopefully you often end up doing > 1 request for a busy IO sub system,
otherwise the softirq stuff is pointless. But it's still pretty bad for
single requests.

> > My point was merely to encourage you to find out the facts before
> > tossing accusations around. :-)
> 
> No, your point was that slotting this change into mainline without telling
> anyone was OK because SCSI has been doing something similar.

Not similar, identical. Andrew, there was _no_ real change there!

-- 
Jens Axboe

