Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWCCREO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWCCREO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWCCREO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:04:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:31622 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030242AbWCCREN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:04:13 -0500
Subject: Re: [PATCH 0/4] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060301175230.4b96e9ad.akpm@osdl.org>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	 <20060301175230.4b96e9ad.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 09:05:39 -0800
Message-Id: <1141405539.10542.68.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 17:52 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I noticed decent improvements (reduced sys time) on JFS, XFS and ext3.
> > (on simple "dd" read tests).
> > 
> >          (rc3.mm1)      (rc3.mm1 + patches)
> > real    0m18.814s       0m18.482s
> > user    0m0.000s        0m0.004s
> > sys     0m3.240s        0m2.912s
> 
> With which filesystem?  XFS and JFS implement a larger-than-b_size
> ->get_block, but ext3 doesn't.  I'd expect ext3 system time to increase a
> bit, if anything?

These numbers are on JFS. With the current ext3 (mainline) - I did
find not-really-noticible increase in sys time (due to code overhead).

I tested on ext3 with Mingming's ext3 getblocks() support in -mm also,
which showed reduction in sys time.

Thanks,
Badari

