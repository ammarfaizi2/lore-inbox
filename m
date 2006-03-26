Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWCZDjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCZDjI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 22:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWCZDjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 22:39:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49877 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751370AbWCZDjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 22:39:07 -0500
Date: Sun, 26 Mar 2006 09:08:38 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, suresh.b.siddha@intel.com,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
Message-ID: <20060326033838.GB12227@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060325082730.GA17011@in.ibm.com> <20060325180605.6e5bb4b9.akpm@osdl.org> <20060326024039.GA2998@in.ibm.com> <20060325184441.0f6ba5bc.akpm@osdl.org> <44260467.10402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44260467.10402@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 01:03:03PM +1000, Nick Piggin wrote:
> I agree, for bootup/hot-add.
> 
> Not so sure about exclusive cpusets.

I think even if memory allocation fails while making a cpuset exclusive,
we would still want have the cpuset marked exclusive. Dynamic scheduler
domains is just one implication of making a cpuset exclusive. There
maybe other implications (like only administrator controls what tasks
run in a exclusive cpuset?) which we want to retain even when there is
mem allocation failure while building dyn sched domains.

Paul can probably clarify this much better than me!

-- 
Regards,
vatsa
