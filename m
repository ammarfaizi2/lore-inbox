Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265896AbUFDRkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265896AbUFDRkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265894AbUFDRkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:40:40 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:46881 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265897AbUFDRjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:39:24 -0400
Date: Fri, 4 Jun 2004 10:47:56 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604104756.472fd542.pj@sgi.com>
In-Reply-To: <20040604162853.GB21007@holomorphy.com>
References: <40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III:
> I'm thoroughly disgusted.

Yup ... LOL.  One sick piece of code.

I didn't return the actual return from sched_getaffinity() because (1)
it's ok to estimate the mask size too high, and (2) given that the man
page and kernel don't agree on the return value of sched_getaffinity(),
I figured that the less I relied on it, the longer my user code would
continue functioning in a useful manner.  As always, the key to robust
code (code that withstands the perils of time) is minimizing risky
assumptions.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
