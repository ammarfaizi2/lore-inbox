Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWI2AX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWI2AX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWI2AX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:23:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:17255 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1161203AbWI2AXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:23:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,232,1157353200"; 
   d="scan'208"; a="137932386:sNHT21840987"
Subject: Re: [PATCH] low performance of lib/sort.c , kernel 2.6.18
From: Zou Nan hai <nanhai.zou@intel.com>
To: Matt Mackall <mpm@selenic.com>
Cc: keios <keios.cn@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060928223341.GI6412@waste.org>
References: <76505a370609280818r3ffc9a4akf4cec6ed366d32e3@mail.gmail.com>
	 <20060928223341.GI6412@waste.org>
Content-Type: text/plain
Organization: 
Message-Id: <1159482868.5251.22.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Sep 2006 06:34:28 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 06:33, Matt Mackall wrote:
> On Thu, Sep 28, 2006 at 11:18:45PM +0800, keios wrote:
> > It is a non-standard heap-sort algorithm implementation because the
> > index of child node is wrong . The sort function still outputs right
> > result, but the performance is O( n * ( log(n) + 1 ) ) , about 10% ~
> > 20% worse than standard algorithm .
> >
> > Signed-off-by: keios <keios.cn@gmail.com>
> 
> Was a bit mystified by this as your patch matches what I've got
> in my userspace test harness from 2003.
> 
> Here's what I submitted, which is almost the same as yours:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/broken-out/lib-sort-heapsort-implementation-of-sort.patch
> 
> Then Zou Nan hai sent Andrew a fix for an off-by-one bug here (merged
> with my patch):
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/broken-out/lib-sort-heapsort-implementation-of-sort.patch
> 
> ..which introduced the performance regression.
> 
> And then I subsequently tweaked my local copy for use in another
> project, coming up with your version.
> 
> So this passes my test harness just fine (for both even and odd array
> sizes).
> 
> Acked-by: Matt Mackall <mpm@selenic.com>

 
  I think this patch is correct. 

  Thanks
  Zou Nan hai
