Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbVKDFgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbVKDFgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbVKDFgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:36:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8129 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161052AbVKDFgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:36:13 -0500
Date: Thu, 3 Nov 2005 21:35:38 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pbadari@gmail.com, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, mingo@elte.hu,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       mbligh@mbligh.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103213538.7f037b3a.pj@sgi.com>
In-Reply-To: <20051103205202.4417acf4.akpm@osdl.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Similarly, that SGI patch which was rejected 6-12 months ago to kill off
> processes once they started swapping.  We thought that it could be done
> from userspace, but we need a way for userspace to detect when a task is
> being swapped on a per-task basis.
> 
> I'm thinking a few numbers in the mm_struct, incremented in the pageout
> code, reported via /proc/stat.

I just sent in a proposed patch for this - one more per-cpuset
number, tracking the recent rate of calls into the synchronous
(direct) page reclaim by tasks in the cpuset.

See the message sent a few minutes ago, with subject:

  [PATCH 5/5] cpuset: memory reclaim rate meter

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
