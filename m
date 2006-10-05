Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWJEVux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWJEVux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWJEVux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:50:53 -0400
Received: from mga07.intel.com ([143.182.124.22]:42602 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932254AbWJEVuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:50:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,266,1157353200"; 
   d="scan'208"; a="127517581:sNHT324270520"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: andrew.j.wade@gmail.com
Cc: Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
In-Reply-To: <200610051732.44669.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <200610050417.39518.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20061005013635.e016bf2b.akpm@osdl.org>
	 <200610051732.44669.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Content-Type: text/plain
Organization: Intel
Date: Thu, 05 Oct 2006 14:01:46 -0700
Message-Id: <1160082106.8035.214.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2006-10-05 at 17:31 -0400, Andrew James Wade wrote:
> On Thursday 05 October 2006 04:36, Andrew Morton wrote:
> > On Thu, 5 Oct 2006 04:13:07 -0400
> > Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> > 
> > > (...)
> > 
> > 
> > That all looks OK (by sheer luck).
> > 
> > Well.  What's the cache line size on that machine?  Every exit() will cause
> > a down_read() on task_exit_notifier's lock which might affect things.  And
> > I think you snipped the above list a bit short (depending on that line
> > size).
> > 
> > 
> > But still, we know that moving those things into __read_mostly didn't fix
> > it, yes?
> 
> No. To my knowledge Tim Chen hasn't tried __read_mostly, and I have not
> attempted to replicate the test case. (I only have a uniprocessor
> machine.) Core 2 machines have a cache line size of 64 bytes, but Tim
> Chen is likely using a different kernel/.config than I am so my objdump
> isn't definitive.
> 
> Tim, perhaps you can try the __read_mostly marking as Andrew suggests?
> 

I have run the workload with __read_mostly marking.  But it didn't make
a difference.  By the way, the cache line size of my machine is 64
bytes.

Thanks.

Tim
