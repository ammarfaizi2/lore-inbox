Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311385AbSCMVu7>; Wed, 13 Mar 2002 16:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311390AbSCMVut>; Wed, 13 Mar 2002 16:50:49 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9979
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311385AbSCMVub>; Wed, 13 Mar 2002 16:50:31 -0500
Date: Wed, 13 Mar 2002 13:51:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Message-ID: <20020313215118.GA460@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au> <E16kkcq-0001rV-00@starship> <3C8E6C63.E8B72195@zip.com.au> <E16l7Oe-0000Dk-00@starship> <3C8FAD88.1C425F9B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8FAD88.1C425F9B@zip.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 11:50:32AM -0800, Andrew Morton wrote:
> Now, I think it's fair to say that the ext2/ext3 inter-file fragmentation
> issue is one of the three biggest performance problems in Linux.  (The
> other two being excessive latency in the page allocator due to VM writeback
> and read latency in the I/O scheduler).
> 
> The fix for interfile fragmentation lies inside ext2/ext3, not inside
> any generic layers of the kernel.    And this really is a must-fix,
> because the completion time for writeback is approximately proportional
> to the size of the filesystem.  So we're getting, what? Fifty percent
> slower per year?
> 
> The `tar xfz linux.tar.gz ; sync' workload can be sped up 4x-5x by
> using find_group_other() for directories.  I spent a week or so
> poking at this when it first came up.  Basically, *everything*
> which I did to address the rapid-growth problem ended up penalising
> the slow-growth fragmentation - long-term intra-file fragmentation
> suffered at the expense of short-term inter-file fragmentation.

I know ReiserFS has similar problems.

Can anyone say wheather JFS or XFS has this problem also?
