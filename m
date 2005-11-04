Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbVKDFsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbVKDFsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVKDFsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:48:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161072AbVKDFsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:48:36 -0500
Date: Thu, 3 Nov 2005 21:48:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>, bron@bronze.corp.sgi.com (Bron Nelson)
Cc: pbadari@gmail.com, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, mingo@elte.hu,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       mbligh@mbligh.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103214807.68a3063c.akpm@osdl.org>
In-Reply-To: <20051103213538.7f037b3a.pj@sgi.com>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
	<20051103213538.7f037b3a.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > Similarly, that SGI patch which was rejected 6-12 months ago to kill off
> > processes once they started swapping.  We thought that it could be done
> > from userspace, but we need a way for userspace to detect when a task is
> > being swapped on a per-task basis.
> > 
> > I'm thinking a few numbers in the mm_struct, incremented in the pageout
> > code, reported via /proc/stat.
> 
> I just sent in a proposed patch for this - one more per-cpuset
> number, tracking the recent rate of calls into the synchronous
> (direct) page reclaim by tasks in the cpuset.
> 
> See the message sent a few minutes ago, with subject:
> 
>   [PATCH 5/5] cpuset: memory reclaim rate meter
> 

uh, OK.  If that patch is merged, does that make Bron happy, so I don't
have to reply to his plaintive email?

I was kind of thinking that the stats should be per-process (actually
per-mm) rather than bound to cpusets.  /proc/<pid>/pageout-stats or something.
