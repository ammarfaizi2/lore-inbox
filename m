Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVCJUQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVCJUQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbVCJUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:16:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50313 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263107AbVCJUNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:13:17 -0500
Date: Thu, 10 Mar 2005 12:11:24 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9) +
 prezeroing (Version 4)
Message-Id: <20050310121124.488cb7c5.pj@engr.sgi.com>
In-Reply-To: <1110478613.16432.36.camel@localhost>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>
	<1110239966.6446.66.camel@localhost>
	<Pine.LNX.4.58.0503101421260.2105@skynet>
	<20050310092201.37bae9ba.pj@engr.sgi.com>
	<1110478613.16432.36.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Perhaps default policies inherited from a cpuset, but overridden by
> other APIs would be a good compromise.

Perhaps.  The madvise() and numa calls (mbind, set_mempolicy) only
affect the current task, as is usually appropriate for calls that allow
specification of specific address ranges (strangers shouldn't be messing
in my address space).  Some external means to set default policy for
whole tasks seems to be needed, as well, which could well be via the
cpuset.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
