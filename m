Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbTCTISu>; Thu, 20 Mar 2003 03:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbTCTISu>; Thu, 20 Mar 2003 03:18:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55530 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261316AbTCTISt>;
	Thu, 20 Mar 2003 03:18:49 -0500
Date: Thu, 20 Mar 2003 09:29:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
Message-ID: <20030320082947.GM4990@suse.de>
References: <20030319232812.GJ2835@ca-server1.us.oracle.com> <20030319175726.59d08fba.akpm@digeo.com> <20030320003858.GM2835@ca-server1.us.oracle.com> <20030320080449.GL4990@suse.de> <20030320002050.44f13857.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320002050.44f13857.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Besides, deadline is still the most solid choice.
> 
> Deadline will always be the best choice for OLTP workloads.  Or CFQ - it
> should perform the same.
> 
> All this workload does is seeks all over the disk doing teeny synchronous
> I/O's.  It is the worst-case for AS.
> 
> What we are trying to do at present is to make AS not _too_ bad for these
> workloads so that people with mixed workloads or who are not familiar with
> kernel arcanery don't accidentally end up with something which is
> significantly slower than it should be.
> 
> It is an interesting test case.

I understand that. A deadline run is still interesting if there are
regressions from -mm2 to -mm3, for example. If deadline shows the same
regression, it's likely not a newly introduced AS bug.

-- 
Jens Axboe

