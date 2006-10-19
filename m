Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWJSHDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWJSHDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbWJSHDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:03:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34947 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030313AbWJSHDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:03:14 -0400
Date: Thu, 19 Oct 2006 00:03:03 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061019000303.f9d883e4.pj@sgi.com>
In-Reply-To: <45371D96.8060003@yahoo.com.au>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061017114306.A19690@unix-os.sc.intel.com>
	<20061017121823.e6f695aa.pj@sgi.com>
	<20061017190144.A19901@unix-os.sc.intel.com>
	<20061018000512.1d13aabd.pj@sgi.com>
	<45371D96.8060003@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> You don't have to worry about the details of the hierarchy. You just need
> to know where the partitions are

Cpusets is a hierarchical space.  What happens in a subtree
of the /dev/cpuset hierarchy should not be affecting others.

Partitioning sched domains is a flat space - dividing the
CPUs of a system into disjoint partitions.

Using details deep in the cpuset hierarchy to define global
partitions leads to chaos in the minds of those coming at
this from the cpuset side.

The lack of any means on a production system to view the
resulting partition leads to ignorance of how deep is the
chaos, a dangerous state of affairs.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
