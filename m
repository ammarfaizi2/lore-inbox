Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbTIDHY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTIDHY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:24:57 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:4495 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264767AbTIDHYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:24:55 -0400
Date: Wed, 3 Sep 2003 13:47:14 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>
Subject: Re: Scaling noise
Message-ID: <20030903114714.GH27875@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903111934.GF10257@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003, Larry McVoy wrote:

> Expecting more bandwidth to help your app is like expecting more platter
> speed to help your file system.  It's not the platter speed, it's the
> seeks which are the problem.  Same thing in system doesn't, it's not the
> bcopy speed, it's the cache misses that are the problem.  More bandwidth
> doesn't do much for that.

Platter speed IS a problem for random access involving seeks, because
platter speed reduces the rotational latency. Whether it takes 7.1 ms
average for a block to rotate past the heads in your average notebook
4,200/min drive or 2 ms in your 15,000/min drive does make a difference.

Even if the drive knows where the sectors are and folds rotational
latency into positioning latency to the maximum possible extent, for
short seeks (track-to-track) it's not going to help.

Unless you're going to add more heads or use other media than spinning
disc, that is.

However, head positioning times, being a tradeoff between noise and
speed, aren't that good particularly with many of the quieter drives, so
the marketing people use the enormous sequential data rate on outer
tracks for advertising. Head positioning time hasn't improved to the
extent throughput has, but that doesn't mean higher rotational frequency
is useless for random access delays.
