Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUFDJ7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUFDJ7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUFDJ7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:59:41 -0400
Received: from holomorphy.com ([207.189.100.168]:47780 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264212AbUFDJ7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:59:37 -0400
Date: Fri, 4 Jun 2004 02:59:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Paul Jackson <pj@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604095929.GX21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, Paul Jackson <pj@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
	ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604093712.GU21007@holomorphy.com> <16576.17673.548349.36588@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16576.17673.548349.36588@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> If the marshalling code presents different formats to userspace
>> depending on BITS_PER_LONG then it's buggy.

On Fri, Jun 04, 2004 at 11:46:49AM +0200, Mikael Pettersson wrote:
> No. Read what I wrote: binary compatibility was the very problem I
> set out to solve, not cause.
> For a given cpumask_t value, user-space sees the same binary
> representation irregardless of how you combine 32 or 64-bit
> user-spaces with 32 or 64-bit kernels.
> This has all been worked out on x86 and amd64, and the conversion
> is endian-neutral so e.g. ppc32 on ppc64 should work.

cpumask_scnprintf() is correct to all appearances... testcase please.


-- wli
