Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTICLUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTICLUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:20:17 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:60616 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261904AbTICLUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:20:11 -0400
Date: Wed, 3 Sep 2003 04:19:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903111934.GF10257@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 05:41:39AM -0400, Brown, Len wrote:
> > Latency is not bandwidth.
> 
> Bingo.
> 
> The way to address memory latency is by increasing bandwidth and
> increasing parallelism to use it -- thus amortizing the latency.  

And if the app is a pointer chasing app, as many apps are, that doesn't
help at all.

It's pretty much analogous to file systems.  If bandwidth was the answer
then we'd all be seeing data moving at 60MB/sec off the disk.  Instead 
we see about 4 or 5MB/sec.

Expecting more bandwidth to help your app is like expecting more platter
speed to help your file system.  It's not the platter speed, it's the
seeks which are the problem.  Same thing in system doesn't, it's not the
bcopy speed, it's the cache misses that are the problem.  More bandwidth
doesn't do much for that.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
