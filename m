Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWCCGec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWCCGec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWCCGec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:34:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11657 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751648AbWCCGeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:34:31 -0500
Date: Thu, 2 Mar 2006 22:33:48 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com, neilb@cse.unsw.edu.au, steiner@sgi.com,
       hawkes@sgi.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060302223348.56f661ad.pj@sgi.com>
In-Reply-To: <20060302135227.012134f9.akpm@osdl.org>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
	<20060301154040.a7cb2afd.pj@sgi.com>
	<20060301202058.42975408.akpm@osdl.org>
	<20060301221429.c61b4ae6.pj@sgi.com>
	<20060301234215.62010fec.akpm@osdl.org>
	<20060302111201.cf61552f.pj@sgi.com>
	<20060302135227.012134f9.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> We presently ignore the return values from initcalls.  But that can carry
> useful debugging information.  So print it out if it's non-zero.
> 
> Also make that warning message more friendly by printing the name of the
> initcall function.

I tried this patch on my sicko kernel, and the following
additional line came out, as expected:

  initcall at 0xa0000001007cc4c0: topology_init+0x0/0x280(): returned with error code -12

Looks good.

Acked-by: Paul Jackson <pj@sgi.com>


> > I should stare at the code between this point of initial failure and
> > the point that the house of cards finally collapsed and see if
> > something should have squeaked sooner.
> 
> Probably a panic() in your topology_init().

Yup - a panic it should be.

I guess that patch should be sent via my friendly ia64 arch maintainer.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
