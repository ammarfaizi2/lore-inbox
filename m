Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTFQGNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 02:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTFQGNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 02:13:22 -0400
Received: from CPE-203-51-33-218.nsw.bigpond.net.au ([203.51.33.218]:12416
	"EHLO didi") by vger.kernel.org with ESMTP id S264608AbTFQGNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 02:13:21 -0400
Date: Tue, 17 Jun 2003 16:27:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
To: rwhron@earthlink.net
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: i/o benchmarks on 2.5.70* kernels
Message-ID: <20030617062706.GB6300@didi>
Mail-Followup-To: rwhron@earthlink.net, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <20030617053232.GA6218@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617053232.GA6218@rushmore>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 01:32:32AM -0400, rwhron@earthlink.net wrote:
> Some benchmarks on 2.5.70* kernels.  Hardware is quad P3 xeon
> with 3.75 GB ram.  For some workloads, -mm has higher numbers
> than 2.5.70, for others, 2.5.70 is better.  Overall, 2.5.70
> seems to give more balanced results on these benchmarks.
> 

Thanks.

Recent mm's have had some experimental fair request
allocation code in them which should be sorted now
(not yet in a released mm), and should improve
performance of "queue full" loads such as many
writers or readers.

It might not get the throughput of mainline kernels,
but I have seen 5x better max latency in some cases.
It would be interesting to see how it goes on a big
box.

Don't know whats going on with AIM7, but there have
been a few bugs in AS being fixed.

tiobench on SMP results are not very good, lots of
fragmentation, the random IO throughput drops is
probably due to AS strangling TCQ though. You are
using SMP and TCQ, right?

