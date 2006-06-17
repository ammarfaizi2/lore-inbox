Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWFQQvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWFQQvK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWFQQvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 12:51:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38571 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750721AbWFQQvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 12:51:08 -0400
Date: Sat, 17 Jun 2006 22:18:12 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
Message-ID: <20060617164812.GB4643@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4493C1D1.4020801@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 06:48:17PM +1000, Nick Piggin wrote:
> Srivatsa Vaddagiri wrote:
> >	- Do we need mechanisms to control CPU usage of tasks, further to 
> >	what
> >	  already exists (like nice)?  IMO yes.
> 
> Can we get back to the question of need? And from there, work out what
> features are wanted.
> 
> IMHO, having containers try to virtualise all resources (memory, pagecache,
> slab cache, CPU, disk/network IO...) seems insane: we may just as well use
> virtualisation.
> 
> So, from my POV, I would like to be convinced of the need for this first.
> I would really love to be able to keep core kernel simple and fast even if
> it means edge cases might need to use a slightly different solution.

I think a proportional-share scheduler (which is what a CPU controller
may provide) has non-container uses also. Do you think nice (or sched policy) 
is enough to, say, provide guaranteed CPU usage for applications or limit 
their CPU usage? Moreover it is more flexible if guarantee/limit can be 
specified for a group of tasks, rather than individual tasks even in
non-container scenarios (like limiting CPU usage of all web-server 
tasks togther or for limiting CPU usage of make -j command).

-- 
Regards,
vatsa
