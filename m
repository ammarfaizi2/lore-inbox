Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265947AbUFDSoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUFDSoC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUFDSoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:44:01 -0400
Received: from holomorphy.com ([207.189.100.168]:2216 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265945AbUFDSnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:43:47 -0400
Date: Fri, 4 Jun 2004 11:42:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604184214.GJ21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
	ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <16576.17673.548349.36588@alkaid.it.uu.se> <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com> <20040604114219.40e50737.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604114219.40e50737.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Without any way to reliably determine this, luserspace is fscked.

On Fri, Jun 04, 2004 at 11:42:19AM -0700, Paul Jackson wrote:
> I don't see why user code needs to determine NR_CPUS exactly.  Any
> reasonable upper bound should work - reasonable meaning doesn't waste
> too many unused words of memory.
> It's not really NR_CPUS that users need - its a reasonably close upper
> bound to the size of the space that sched_getaffinity() must be provided
> they need.  And your code does a pretty good job of providing that.

Wrong. Apps that want to reconfigure the system to e.g. online more cpus
in response to heightened load want to know.


-- wli
