Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265803AbUFDQ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUFDQ43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265798AbUFDQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:56:28 -0400
Received: from holomorphy.com ([207.189.100.168]:15271 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265803AbUFDQ4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:56:20 -0400
Date: Fri, 4 Jun 2004 09:56:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604165601.GC21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Mikael Pettersson <mikpe@csd.uu.se>,
	nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
	ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604090314.56d64f4d.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael writes:
>> Case in point: the perfctr kernel extension needs to communicate ...

On Fri, Jun 04, 2004 at 09:03:14AM -0700, Paul Jackson wrote:
> Nice example.  Thank-you.
> Yes - doing that 1-bit at a time in a per-cpu loop would be ugly.
> We should leave cpus_addr() around, at least until such time as the
> cpumask ADT provided routines to support exactly what you are doing -
> copying up masks to user space as length specified arrays of uint.

This is patently ridiculous. Make a compat_sched_getaffinity(), and
likewise for whatever else is copying unsigned long arrays to userspace.


-- wli
