Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWJWGsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWJWGsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWJWGsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:48:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38591 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750878AbWJWGsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:48:19 -0400
Date: Sun, 22 Oct 2006 23:48:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061022234807.2000c888.pj@sgi.com>
In-Reply-To: <453C5E77.2050905@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061022225108.21716614.pj@sgi.com>
	<453C5E77.2050905@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be trivial to make such a script to parse the root cpuset and
> do exactly this, wouldn't it?

Ah - yes - that's doable.  A certain company I work for ships pretty
much that exact script, to its customers.  It works well to remove
all the unpinned tasks from the top level cpuset and put them in what
we call the 'boot' cpuset, where the classic Unix load (init, cron,
daemons, sysadmin login) is confined.  This frees up the rest of the
system to run "real" work.  It works quite well, if I do say so.

Perhaps I'm being overly pessimistic about the potential of driving
this partitioning off the cpus_allowed masks of the tasks.  As you
noted, it would be a cute trick to avoid some combinatorial explosion
of the computational costs.  But there are enough practical constraints
on this problem - that should be quite doable.

Hmmm ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
