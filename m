Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752411AbWCPRBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbWCPRBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbWCPRBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:01:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46002 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752410AbWCPRBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:01:50 -0500
Date: Thu, 16 Mar 2006 22:31:35 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive feature of cpuset broken?
Message-ID: <20060316170135.GB6548@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060316152848.GA6548@in.ibm.com> <20060316083836.f598ff45.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316083836.f598ff45.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:38:36AM -0800, Paul Jackson wrote:
> While you created a subcpuset 'a', you changed the
> cpus and cpu_exclusive in the root cpuset.  This
> changed -all- tasks to only be allowed to run on
> cpu 7.

oops sorry  ..i did mean to say that i was trying to change
cpu-exclusive flag of a (and not the root cpuset).

> 
> I'd guess you have some kernel thread or such that
> really, really wants to run on some other cpu.
> 
> When I read you transcript, I expected it to say:
> 
> 	# mkdir /dev/cpuset
> 	# mount -t cpuset cpuset /dev/cpuset	# s/none/cpuset/ - clearer
> 	# cd /dev/cpuset
> 	# mkdir a
> 	# cd a					# the missing step

Yes ..you are right. I did run 'cd a' and then ran the below commands.

> 	# /bin/echo 7 > cpus
> 	# /bin/echo 1 > cpu_exclusive

> When I do your commands (without the 'cd a'), I don't
> see any problem or hang on my Altix test box.  But that
> probably just means I am not critically depending at that
> moment on some kernel thread running on any particular cpu.

Did you try with the 'cd a' (in other words turn on exclusive 
property of cpuset 'a')?

-- 
Regards,
vatsa
