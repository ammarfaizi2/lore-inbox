Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUG0KJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUG0KJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 06:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUG0KJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 06:09:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4030 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262406AbUG0KJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 06:09:19 -0400
Date: Tue, 27 Jul 2004 12:07:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ed Sweetman <safemode@comcast.net>,
       Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
Message-ID: <20040727100724.GA11189@suse.de>
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <410500FD.8070206@comcast.net> <4105D7ED.5040206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4105D7ED.5040206@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27 2004, Nick Piggin wrote:
> Ed Sweetman wrote:
> 
> >This is not the same problem as I and other are describing.  There is 
> >no free memory when the OOM killer activates in our situation.  The 
> >kernel has allocated all available ram and as such, the OOM killer 
> >can't kill the memory hog because it's the kernel, itself.  So the OOM 
> >killer kills all the big apps running ...but it's to no use because 
> >the kernel just keeps trying to use more until the cd is completed.   
> >After which the memory is still never released.
> >Your thread has nothing to do with mine.
> >
> 
> I believe it could be the same problem. Jan-Frode's system has all
> ZONE_NORMAL memory used up. The free memory would be highmem which
> would be unsuable for those allocations that are causing OOM.
> 
> The vfs_cache_pressure change could possibly be responsible for the
> problem...  I don't have the code in front of me, but I think it
> divides by 100 first, then multiplies by vfs_cache_pressure. I
> wouldn't have thought this would have such a large impact though.

Ed,

Can you please try Nicks suggestion? A vm problem makes sense to me,
what doesn't make sense is that we leak memory on some hardware while
burning and don't on others.

-- 
Jens Axboe

