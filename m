Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWHUWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWHUWcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHUWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:32:12 -0400
Received: from mga05.intel.com ([192.55.52.89]:57384 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751261AbWHUWcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:32:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,153,1154934000"; 
   d="scan'208"; a="119223512:sNHT36663333"
Date: Mon, 21 Aug 2006 15:19:10 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: generic sched_group cpu power setup
Message-ID: <20060821151910.A21718@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com> <20060815212455.c9fe1e34.pj@sgi.com> <20060816104551.A7305@unix-os.sc.intel.com> <20060818142347.A22846@unix-os.sc.intel.com> <20060818152954.1ef5aa34.pj@sgi.com> <20060818154230.A23214@unix-os.sc.intel.com> <20060818170945.43ced12b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060818170945.43ced12b.pj@sgi.com>; from pj@sgi.com on Fri, Aug 18, 2006 at 05:09:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 05:09:45PM -0700, Paul Jackson wrote:
> I'm still trying to figure out what the hell it is ;).

Please refer to the code comments in my recent patch. And also the
recent conversations between us about this. My OLS 2005 paper(CMP aware
kernel scheduler) might also help and finally the source code kernel/sched.c

> If all the CPUs in a system have the same computational capacity,
> then is it just the number of CPUs in a group (times a scale factor

No. It depends on the sched domain, its characteristics and depends
on performance/power-savings policy.

> If two CPUs, side by side, have the same computational capacity,
> but one consumes more electrical power (watts) than the other, do they
> have different cpu_power?

No.

> If I presumed correctly, then apparently what we're talking about here
> is computational capacity, as is typically measured in such units as
> MIPS, megaflops/sec or Drystones. In other words, what Andrew termed
> "computing power" when he fired the starter's pistol on this scrum.
> 
> Is that what this is -- computational capacity, aka computing power
> (appropriately scaled for the convenience of the arithmetic)?
> 
> And is the unit of measure just the number of CPUs in the group
> (times 128)?

No. That is the case only for some scenarios(for example when power
savings is enabled..). In the default performance policy mode, domain
characteristics will determine this value.

thanks,
suresh
