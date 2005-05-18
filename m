Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVERVDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVERVDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVERVDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:03:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9601 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262373AbVERVCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:02:43 -0400
Date: Wed, 18 May 2005 14:02:13 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [Lse-tech] Re: [RFT PATCH] Dynamic sched domains (v0.6)
Message-Id: <20050518140213.39f59450.pj@sgi.com>
In-Reply-To: <20050518180652.GA4293@in.ibm.com>
References: <20050517041031.GA4596@in.ibm.com>
	<20050517225354.025c3cca.pj@sgi.com>
	<20050518180652.GA4293@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> >  * The name 'nodemask' for the cpumask_t of CPUs that are siblings to CPU i
> >    is a bit confusing (yes, that name was already there).  How about
> >    something like 'siblings' ?
> 
> Not sure which code you are referring to here ?? I dont see any nodemask
> referring to SMT siblings ? 

This comment was referring to lines such as the following, which appear
a few places in your patch (though not lines you wrote, just nearby
lines, in all but one case):

 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));

I was thinking to change such a line to:

 		cpumask_t sibling = node_to_cpumask(cpu_to_node(i));

However, it is no biggie, and since it is not in your actual new
code, probably should not be part of your patch anyway.

There is one place, arch_destroy_sched_domains(), where you added such a
line, but there you should probably use the same 'nodemask' name as the
other couple of places, unless and until these places change together.

So bottom line - nevermind this comment.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
