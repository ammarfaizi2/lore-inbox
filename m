Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVLISIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVLISIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVLISIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:08:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49114 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964839AbVLISIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:08:50 -0500
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix
	coding style
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Rustad <mrustad@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
	 <1134148609.30856.22.camel@localhost>
	 <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 10:08:16 -0800
Message-Id: <1134151696.3278.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 11:55 -0600, Mark Rustad wrote:
> On Dec 9, 2005, at 11:16 AM, Dave Hansen wrote:
> 
> > What driver needs to map huge pages?  Is it in the kernel tree  
> > now?  If
> > not, can you post the source, please?
> 
> It is a funky driver for an embedded system. I can't imagine it ever  
> being in the kernel tree, because not many people want to share 768M  
> of contiguous physical memory.
> 
> I can post the source, but it really is a bunch of random stuff for  
> am embedded application. We do make it available as part of our GPL  
> source release to customers.

You'd be surprised.  If we know what you're actually trying to do, we
might be able to suggest another option.  As Adam said, having userspace
mmap a hugetlb area, then hand it to the driver would certainly keep
your kernel modifications to a minimum.

-- Dave

