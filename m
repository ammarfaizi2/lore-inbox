Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422960AbWJVEy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960AbWJVEy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 00:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422971AbWJVEy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 00:54:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2957 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422960AbWJVEy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 00:54:56 -0400
Date: Sat, 21 Oct 2006 21:54:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061021215436.09d03444.pj@sgi.com>
In-Reply-To: <4539FB9C.10204@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
	<20061019115652.562054ca.pj@sgi.com>
	<4537CC1E.60204@yahoo.com.au>
	<20061019203744.09b8c800.pj@sgi.com>
	<453882AC.3070500@yahoo.com.au>
	<20061020130141.b5e986dd.pj@sgi.com>
	<4539BAB2.3010501@yahoo.com.au>
	<20061021002400.fb25f327.pj@sgi.com>
	<4539FB9C.10204@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Well, it was supposed to be used for sched-domains partitioning, and
> its uselessness for anything else I guess is what threw me.

The use of cpu_exclusive for sched domain partitioning was added
later, by a patch from Dinikar, in April or May of 2005.

In hindsight, I think I made a mistake in agreeing to, and probably
encouraging, this particular overloading of cpu_exclusive.  I had
difficulty adequately understanding what was going on.

Granted, as we've noted elsewhere on this thread, the cpu_exclusive
flag is underutilized.  It gives cpusets so marked a certain limited
exclusivity to its cpus, relative to its siblings, but it doesn't do
much else, other than this controversial partitioning of sched domains.

There may well be a useful role for the cpu_exclusive flag in managing
sched domains and partitioning.  The current role is flawed, in my view.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
