Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbTIHJV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTIHJV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:21:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13863 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261637AbTIHJV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:21:27 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Larry McVoy" <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Giuliano Pochini" <pochini@shiny.it>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
References: <BF1FE1855350A0479097B3A0D2A80EE009FD35@hdsmsx402.hd.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Sep 2003 03:21:10 -0600
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FD35@hdsmsx402.hd.intel.com>
Message-ID: <m1k78jmy9l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

> > 5) NUMA machines are slow.  There is not a single NUMA machine in the
> >    top 10 of the top500 supercomputers list.  Likely this has more to
> >    do with system sizes supported by the manufacture than inherent
> >    process inferiority, but it makes a difference.
> 
> Hardware that is good at running linpack (all you gotta run to get onto
> http://www.top500.org/ )isn't necessarily hardware that is any good at,
> say, http://www.tpc.org/

Quite true.  And there have been some very reasonable criticisms of linpack,
as it is cache friendly.   So I will not argue that clusters are the
proper solution for everything.

The barrier to submitting a TPC result is much higher so it captures
a smaller chunk of the market.  For the people who are their customers
this seems reasonable.  Though I find the absence of google
from the TPC-H fascinating.

But none of those machines have nearly the same number of cpus
as the machines in the top500.   And the point of Larry ideas are
an infrastructure that scales.  It is easy to scale things to 64
processors, 2.6 will do that today (though not necessarily
well).  Going an order a magnitude bigger is a very significant
undertaking.

I won't argue that a NUMA design is bad.  In fact I think it is quite a
nice hardware idea.  And optimizing for it if you got it is cool.

But I think if people are going to build software that scales
built of multiple kernels, it will probably be the cluster guys.
Because that is what they must do, and they already have the big
hardware.  And if the code works in a non-coherent mode it should only
get better when you tell it the machine is cache coherent.

Eric
