Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTIKMfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTIKMfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:35:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:36241 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261261AbTIKMfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:35:37 -0400
Date: Thu, 11 Sep 2003 13:35:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911123535.GB28180@mail.jlokier.co.uk>
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911010702.W30046@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > Does your fix, which makes pages uncacheable andq disables write
> > combining (correct?) only fix your test results which intermittently
> > reported write buffer problems, or does it fix _all_ the ARM test
> > results I received, including those which don't report write buffer
> > problems?
> 
> It's relatively simple, and I'm not sure why its causing such
> misunderstanding.  Let me try one more time:
> 
> ARM caches are VIVT.  VIVT caches have inherent aliasing issues.  The
> kernel works around these issues by marking memory uncacheable where
> appropriate, and will continue to do so for VIVT cached ARM CPUs.

That I understand fully.

My question arises because I have 3 SA-110 results which report "cache
not coherent".  They do not report "store buffer not coherent".  All 3
are Rebel Netwinders, of different bogomips ratings.

The point is: those results _don't_ indicate write buffer problems.

It means that your VIVT explanation and workaround does not explain
those results, so I cannot have confidence that your workaround fixes
those particular ARM devices.

Now, if you can assure me that those results are _definitely_ due to
using very old kernels which don't even mark pages uncacheable, and
with newer kernels those Netwinders would exhibit coherent virtual
aliases, that's great.

Then I'll say that ARM Linux offers coherent virtual aliases on all
known ARM systems, provided they're running a sufficiently new kernel.

Otherwise, I can't say that.

-- Jamie
