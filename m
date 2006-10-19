Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWJSG2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWJSG2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161289AbWJSG2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:28:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17079 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161019AbWJSG2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:28:16 -0400
Date: Wed, 18 Oct 2006 23:28:06 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: suresh.b.siddha@intel.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, rohitseth@google.com,
       dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061018232806.a6145f0f.pj@sgi.com>
In-Reply-To: <20061018174925.GB7885@in.ibm.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061018174925.GB7885@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> IMO this change is counter intuitive and pointless

If we intend to make the cpuset to sched_domain interaction
functional, something like this was needed.

However I am now leaning toward thinking that the entire
effort to manipulate sched_domain definitions by cpusets
(the cpu_exclusive flag) has been counter intuitive, and
is borked.

So I will be sending out patches to remove it, and replace
with a trivial mechanism to allow for runtime manipulation
of the cpu_isolated_map.

Coming soon ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
