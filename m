Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSJ1Q4H>; Mon, 28 Oct 2002 11:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSJ1Q4H>; Mon, 28 Oct 2002 11:56:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61345 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261369AbSJ1Q4F>; Mon, 28 Oct 2002 11:56:05 -0500
Date: Mon, 28 Oct 2002 08:57:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <524720000.1035824241@flay>
In-Reply-To: <200210281734.41115.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de> <3128418467.1035736310@[10.10.2.3]> <200210281734.41115.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The pool data is needed to be able to loop over the CPUs of one node,
> only. I'm convinced we'll need to do that sometime, no matter how simple
> the core of the NUMA scheduler is.

Hmmm ... is using node_to_cpumask from the topology stuff, then looping
over that bitmask insufficient?
 
> The pool_lock is protecting that data while it is built. This can happen
> in future more often, if somebody starts hotplugging CPUs.

Heh .... when someone actually does that, we'll have a lot more problems
than just this to solve. Would be nice to keep this stuff simple for now, if 
possible.

> Sorry, the comment came from a former version...

No problem, I suspected that was all it was.
 
>> just block). If you really still need to do this, RCU is now
>> in the kernel ;-) If not, can we just chuck all that stuff?
> 
> I'm preparing a core patch which doesn't need the pool_lock. I'll send it
> out today.

Cool! Thanks,

M.

