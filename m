Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVCHGFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVCHGFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVCHGEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:04:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:53639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261523AbVCHGDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:03:02 -0500
Date: Mon, 7 Mar 2005 22:00:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       paul@linuxaudiosystems.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308060011.GH5389@shell0.pdx.osdl.net>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <422D3AB2.9020409@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422D3AB2.9020409@bigpond.net.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Williams (pwil3058@bigpond.net.au) wrote:
> Andrew Morton wrote:
> >Matt Mackall <mpm@selenic.com> wrote:
> >
> >>I think Chris Wright's last rlimit patch is more sensible and ready to
> >>go.
> >
> >
> >I must say that I like rlimits - very straightforward, although somewhat
> >awkward to use from userspace due to shortsighted shell design.
> >
> >Does anyone have serious objections to this approach?
> 
> I don't object to rlimits per se and I think that they are useful but 
> not as a sole solution to this problem.  Being able to give a task 
> preferential treatment is a permissions issue and should be solved as one.
> 
> Having RT cpu usage limits on tasks is a useful tool to have when 
> granting normal users the privilege of running tasks as RT tasks so that 
> you can limit the damage that they can do BUT the presence of a limit on 
> a task is not a very good criterion for granting that privilege.
> 
> The granting of the ability to switch to and from RT mode should require 
> a means to specify which users it applies to and also which programs it 
> applies to.  The RT rlimits mechanism doesn't meet these criteria.
> 
> In summary, IMHO you should put them both in but modify the RT rlimits 
> patch so that it plays no part in the decision as to whether the task is 
> allowed to run as RT or not.

I'm not sure I follow you.  This patch just sets the max RT priority a
process can have (defaults to 0, as w/out the patch).  Increasing that
value is a form of permission granting, giving the process the ability
to increase its RT prio if it chooses to ask for it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
