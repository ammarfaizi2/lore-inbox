Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbTACJnb>; Fri, 3 Jan 2003 04:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbTACJnb>; Fri, 3 Jan 2003 04:43:31 -0500
Received: from rth.ninka.net ([216.101.162.244]:28575 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267119AbTACJna>;
	Fri, 3 Jan 2003 04:43:30 -0500
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Aniruddha M Marathe <aniruddha.marathe@wipro.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E155903.F8C22286@digeo.com>
References: <94F20261551DC141B6B559DC4910867204491F@blr-m3-msg.wipro.com> 
	<3E155903.F8C22286@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 02:24:37 -0800
Message-Id: <1041589477.9242.5.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-03 at 01:33, Andrew Morton wrote:
> I'm sorry, but all you are doing with these tests is discrediting
> lmbench, AIM9, tiobench and unixbench.
 ...
> Possibly, it is all caused by cache colouring effects - the physical
> addresses at which critical kernel and userspace text and data
> happen to end up.
 ...
> The teeny little microbenchmarks are telling us that the rmap overhead
> hurts, that the uninlining of copy_*_user may have been a bad idea, that
> the addition of AIO has cost a little and that the complexity which
> yielded large improvements in readv(), writev() and SMP throughput were
> not free.  All of this is already known.

I think if anything, you are stating the true value of the
microbenchmarks.  They are showing us how the kernel is getting
more and more complex, causing basic operations to take longer
and longer.  That's bad. :-)

Last time I brought up an issue like this (a "nobody but weirdos use
feature which is costing us cycles everywhere"), it got redone until
it did cost nothing for people who don't use the feature.  See the
whole security layer fiasco for example.

I truly wish I could config out AIO for example, the overhead is just
stupid.  I know that if some thought is put into it, the cost could
be consumed completely.

People who don't see the true value of researching even minor jitters
in lmbench results (and fixing the causes or backing out the guilty
patch) aren't kernel developers in my opinion. :-)

