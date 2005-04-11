Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVDKNrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVDKNrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVDKNrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:47:10 -0400
Received: from unthought.net ([212.97.129.88]:42927 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261793AbVDKNrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:47:04 -0400
Date: Mon, 11 Apr 2005 15:47:03 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050411134703.GC13369@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
References: <20050406160123.GH347@unthought.net> <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net> <1112890671.10366.44.camel@lade.trondhjem.org> <20050409213549.GW347@unthought.net> <1113083552.11982.17.camel@lade.trondhjem.org> <20050411074806.GX347@unthought.net> <1113222939.14281.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113222939.14281.17.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 08:35:39AM -0400, Trond Myklebust wrote:
...
> That certainly shouldn't be the case (and isn't on any of my setups). Is
> the behaviour identical same on both the PIII and the Opteron systems?

The dual opteron is the nfs server

The dual athlon is the 2.4 nfs client

The dual PIII is the 2.6 nfs client

> As for the WRITE rates, could you send me a short tcpdump from the
> "sequential write" section of the above test? Just use "tcpdump -s 90000
> -w binary.dmp"  just for a couple of seconds. I'd like to check the
> latencies, and just check that you are indeed sending unstable writes
> with not too many commit or getattr calls.

Certainly;

http://unthought.net/binary.dmp.bz2

I got an 'invalid snaplen' with the 90000 you suggested, the above dump
is done with 9000 - if you need another snaplen please just let me know.

A little explanation for the IPs you see;
 sparrow/10.0.1.20 - nfs server
 raven/10.0.1.7 - 2.6 nfs client
 osprey/10.0.1.13 - NIS/DNS server

Thanks,

-- 

 / jakob

