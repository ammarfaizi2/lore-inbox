Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVCJU1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVCJU1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVCJUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:22:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:249 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261713AbVCJURk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:17:40 -0500
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9)
	+ prezeroing (Version 4)
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: mel@csn.ul.ie, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310121124.488cb7c5.pj@engr.sgi.com>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>
	 <1110239966.6446.66.camel@localhost>
	 <Pine.LNX.4.58.0503101421260.2105@skynet>
	 <20050310092201.37bae9ba.pj@engr.sgi.com>
	 <1110478613.16432.36.camel@localhost>
	 <20050310121124.488cb7c5.pj@engr.sgi.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 12:17:15 -0800
Message-Id: <1110485835.24355.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 12:11 -0800, Paul Jackson wrote:
> Dave wrote:
> > Perhaps default policies inherited from a cpuset, but overridden by
> > other APIs would be a good compromise.
> 
> Perhaps.  The madvise() and numa calls (mbind, set_mempolicy) only
> affect the current task, as is usually appropriate for calls that allow
> specification of specific address ranges (strangers shouldn't be messing
> in my address space).  Some external means to set default policy for
> whole tasks seems to be needed, as well, which could well be via the
> cpuset.

Shouldn't a particular task know what the policy should be when it is
launched?  If the policy is only per-task and known at task exec time,
I'd imagine that a simple exec wrapper setting a flag would be much more
effective than even defining the policy in a cpuset.  

-- Dave

