Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUFDShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUFDShc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUFDShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:37:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:25582 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265916AbUFDShK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:37:10 -0400
Date: Fri, 4 Jun 2004 11:42:19 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604114219.40e50737.pj@sgi.com>
In-Reply-To: <20040604181233.GF21007@holomorphy.com>
References: <16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Without any way to reliably determine this, luserspace is fscked.

I don't see why user code needs to determine NR_CPUS exactly.  Any
reasonable upper bound should work - reasonable meaning doesn't waste
too many unused words of memory.

It's not really NR_CPUS that users need - its a reasonably close upper
bound to the size of the space that sched_getaffinity() must be provided
they need.  And your code does a pretty good job of providing that.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
