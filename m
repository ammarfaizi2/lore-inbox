Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWIOC6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWIOC6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 22:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIOC6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 22:58:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63905 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751463AbWIOC6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 22:58:08 -0400
Date: Fri, 15 Sep 2006 12:57:45 +1000
From: David Chinner <dgc@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       xfs-masters@oss.sgi.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Message-ID: <20060915025745.GM3034@melbourne.sgi.com>
References: <20060913015850.GB3034@melbourne.sgi.com> <20060913042627.GE3024@melbourne.sgi.com> <6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com> <20060914035904.GF3034@melbourne.sgi.com> <450914C4.2080607@gmail.com> <6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com> <20060914090808.GS3024@melbourne.sgi.com> <6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com> <6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com> <6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 07:01:38PM +0200, Michal Piotrowski wrote:
> >>
> >> I'll build system with gcc 3.4
> >
> >It's not a compiler issue.
> >
> >Binary search should solve this mystery.
> 
> I was wrong - it's in vanilla tree
> (http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg1).
> 
> cat hunt | head -n 3
> origin.patch
> BAD
> libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch

Not sure what this means....

> I can reproduce this bug with all CONFIG_DEBUG_*=y.
> (only
> CONFIG_DEBUG_SYNCHRO_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> as modules)

I notice you're running i386 with 4k stacks - I wonder if you're blowing the
stack by running xfs on loopback. I've been testing on x86_64 and ia64
which don't have those issues. Can you try with 8K stacks instead of
4k stacks?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
