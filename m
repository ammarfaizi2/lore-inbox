Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752913AbWKHKjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbWKHKjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965574AbWKHKjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:39:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19942 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752913AbWKHKjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:39:16 -0500
Date: Wed, 8 Nov 2006 02:38:36 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset:  Explicit dynamic sched domain cpuset flag
Message-Id: <20061108023836.0f3bbd18.pj@sgi.com>
In-Reply-To: <20061031064300.10a97c13.pj@sgi.com>
References: <20061030212615.GA10567@in.ibm.com>
	<20061030212922.GA20369@in.ibm.com>
	<20061031064300.10a97c13.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,

Where do we stand on this patch?

Last I knew, as of a week ago:

  * I had (still have) a patch in *-mm to nuke the old connection
    between the cpu_exclusive flag and sched domain partitioning:
	cpuset-remove-sched-domain-hooks-from-cpusets.patch
  * and you have this patch posted on lkml, with some non-trivial
    comments from myself, to provide a new 'sched_domain' per-cpuset
    flag to control sched domain partitioning.

Ideally, we'd agree on this new 'sched_domain' (or whatever we call it)
flag, so that my patch to remove the old hooks could travel to 2.6.20
along with this present patch to provide new and improved hooks.

However ... I need to focus on some other stuff for roughly four
weeks, so can't focus on pushing this effort along right now.

My guess is that I will end up asking Andrew to hold the above
named "remove ... hooks" patch in *-mm until you and I get our
act together on the replacement, which most likely will mean he
holds it until we start work on what will become 2.6.21.

Do you see any better choices?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
