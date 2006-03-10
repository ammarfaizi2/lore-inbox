Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752185AbWCJJBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbWCJJBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 04:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWCJJBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 04:01:23 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:6871 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1752185AbWCJJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 04:01:22 -0500
Date: Fri, 10 Mar 2006 10:01:21 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: [ck] Re: [PATCH] mm: yield during swap prefetching
Message-ID: <20060310090121.GA15315@rhlx01.fht-esslingen.de>
References: <200603081013.44678.kernel@kolivas.org> <200603081212.03223.kernel@kolivas.org> <440FEDF7.2040008@aitel.hist.no> <200603092008.16792.kernel@kolivas.org> <4410AFD3.7090505@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4410AFD3.7090505@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 10, 2006 at 09:44:35AM +1100, Peter Williams wrote:
> I'm working on a patch to add soft and hard CPU rate caps to the 
> scheduler and the soft caps may be useful for what you're trying to do. 
>  They are a generalization of your SCHED_BATCH implementation in 
> staircase (which would have been better called SCHED_BACKGROUND :-) 
Which SCHED_BATCH? ;) I only know it as SCHED_IDLEPRIO, which, come to think
of it, is a better name, I believe :-)
(renamed due to mainline introducing a *different* SCHED_BATCH mechanism)

> IMHO) in that a task with a soft cap will only use more CPU than that 
> cap if it (the cpu) would otherwise go unused.  The main difference 
> between this mechanism and staircase's SCHED_BATCH mechanism is that you 
> can specify how much (as parts per thousand of a CPU) the task can use 
> instead of just being background or not background.  With the soft cap 
> set to zero the effect would be essentially the same.
Interesting. Hopefully it will bring some nice results!

Andreas
