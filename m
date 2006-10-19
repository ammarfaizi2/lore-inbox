Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWJSIbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWJSIbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWJSIbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:31:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57041 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030316AbWJSIbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:31:44 -0400
Date: Thu, 19 Oct 2006 01:31:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061019013130.d374b7ba.pj@sgi.com>
In-Reply-To: <45373478.1030004@yahoo.com.au>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<45361B32.8040604@yahoo.com.au>
	<20061018231559.8d3ede8f.pj@sgi.com>
	<45371CBB.2030409@yahoo.com.au>
	<20061018235746.95343e77.pj@sgi.com>
	<4537238A.7060106@yahoo.com.au>
	<20061019003316.f6a77b34.pj@sgi.com>
	<45373478.1030004@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So make the new rule "cpu_exclusive && direct-child-of-root-cpuset".
> Your problems go away, and they haven't been pushed to userspace.

I don't know of anyone that has need for this feature.

Do you?  If you do - good - lets consider them anew.

If such needs arise, I doubt I would recommend meeting them with the
cpu_exclusive flag, in any way shape or form.  That would probably not
be a particularly clear and intuitive interface for whatever it was we
needed.

> If a user wants to, for some crazy reason, have a set of cpu_exclusive
> sets deep in the cpuset hierarchy, such that no load balancing happens
> between them... just tell them they can't; they should just make those
> cpusets children of the root.

I have no problem telling users what the limits are on mechanisms.

I have serious problems trying to push mechanisms on them that I
couldn't understand until after repeated attempts over many months,
that are counter intuitive and dangerous (at least unless such odd
rules are imposed) to use, and that provide no useful feedback to the
user as to what they are doing.

It doesn't increase my sympathy for this code that it has been my
biggest source of customer maintenance costs due to a couple of
serious bugs, in all of the cpuset code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
