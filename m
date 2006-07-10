Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWGJTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWGJTXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWGJTXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:23:00 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21211 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422673AbWGJTW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:22:59 -0400
Date: Mon, 10 Jul 2006 12:22:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Marcelo Tosatti <marcelo@kvack.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>, dgc@sgi.com,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Lee Schermerhorn <Lee.Schermerhorn@hp.com>, jes@sgi.com,
       Adam Litke <agl@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       steiner@sgi.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, akpm@osdl.org
Subject: Agenda for NUMA BOF @OLS & NUMA paper
Message-ID: <Pine.LNX.4.64.0607101146170.5556@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have given a number of talks about various NUMA issues in the last 
months and tried to put the most important points together in a 
paper that begins to explain NUMA from scratch and then gets into some 
of the current issues. That paper is available at 
http://ftp.kernel.org/pub/linux/kernel/people/christoph/pmig/numamemory.pdf

Also there will be a NUMA BOF at the OLS on Thursday July 20th 18:00
in Room B. Some of the items that we may discuss are 
mentioned at the end of the paper.

Here is a one liner for each subject that may be useful to discuss. I'd be 
interested in hearing if there are any other issues that would need our 
attention or maybe some of these are not that important (Probably too many 
subjects already ...). Maybe this thread will allow those who will not be 
at the OLS to give us some imput.

A. Scalability
	- Lockless page cache / Concurrent page cache
	- Page Dirty handling (per node write throttling?)
	- How to effectively deal with per cpu data at high
		processor counts (f.e. 1024p)
	- Issues with the number of objects increasing by the
		power of two for higher counts (f.e. alien slab caches, 
		pagesets)
	- Effective per node slab reclaim for dentry and inode cache.
	- TLB pressure issues for large memory (huge pages???)

B. Page Migration
	- Automatic page migration approaches
	- Use of page migration to defragment memory
	- Memory hotplug and page migration

C. Memory Policies / Cpusets
	- Memory policies for the page cache?
	- Is the current situation okay that memory policies apply only
		to a single zone per node? (Okay for SGI because we only 
		have a single zone per node.... but how about others?)
	- Cpuset interference with subsystems managing their own
	  locality (vmalloc, slab, drivers).

D. Scheduler
	- Accounting for interrupt load?
	- Fairer cpu load balancing

General future vision things:
	- Increasing scheduler complexity for NUMA.
	- NUMA scheduler in user space that can be much more intelligent
		than possible in the kernel?
	- Functional overlap between memory policies and cpusets.
		Is there some scheme to unify these two and make it
		more general?
	- General memory balancing / dirty load balancing. Is there some
	  scheme to make it better and avoid some of the current manual
	  tuning?
