Return-Path: <linux-kernel-owner+w=401wt.eu-S1753932AbWLWXrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbWLWXrr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 18:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbWLWXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 18:47:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40246 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbWLWXrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 18:47:46 -0500
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2006 18:47:46 EST
Date: Sun, 24 Dec 2006 00:29:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Siddha@elte.hu, Suresh B <suresh.b.siddha@intel.com>,
       Clark Williams <williams@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] suspend: fix suspend on single-CPU systems
Message-ID: <20061223232915.GA2763@atrey.karlin.mff.cuni.cz>
References: <20061223155529.GA18924@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223155529.GA18924@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [patch] suspend: fix suspend on single-CPU systems
> From: Ingo Molnar <mingo@elte.hu>
> 
> Clark Williams reported that suspend doesnt work on his laptop on 
> 2.6.20-rc1-rt kernels. The bug was introduced by the following cleanup 
> commit:
> 
>  commit 112cecb2cc0e7341db92281ba04b26c41bb8146d
>  Author: Siddha, Suresh B <suresh.b.siddha@intel.com>
>  Date:   Wed Dec 6 20:34:31 2006 -0800
> 
>     [PATCH] suspend: don't change cpus_allowed for task initiating the suspend
> 
> because with this change 'error' is not initialized to 0 anymore, if 
> there are no other online CPUs. (i.e. if the system is single-CPU).
> 
> the fix is the initialize it to 0. The really weird thing is that my 
> version of gcc does not warn about this non-initialized variable 
> situation ...
> 
> (also fix the kernel printk in the error branch, it was missing a
>  newline)
> 
> Reported-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Looks okay to me.

-- 
Thanks, Sharp!
