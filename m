Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVDGOAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVDGOAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVDGOAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:00:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:51921 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262464AbVDGOAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:00:10 -0400
Date: Thu, 7 Apr 2005 19:30:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: george@mvista.com, mingo@elte.hu,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
Message-ID: <20050407140040.GD17268@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050407124629.GA17268@in.ibm.com> <425530AB.90605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425530AB.90605@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:07:55PM +1000, Nick Piggin wrote:
> 3. This is exactly one of the situations that the balancing backoff code
>    was designed for. Can you just schedule interrupts to fire when the
>    next balance interval has passed? This may require some adjustments to
>    the backoff code in order to get good powersaving, but it would be the
>    cleanest approach from the scheduler's point of view.


Hmm ..I guess we could restrict the max time a idle CPU will sleep taking
into account its balance interval. But whatever heuristics we follow to 
maximize balance_interval of about-to-sleep idle CPU, don't we still run the 
risk of idle cpu being woken up and going immediately back to sleep (because 
there was no imbalance)?

Moreover we may be greatly reducing the amount of time a CPU is allowed to 
sleep this way ...






-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
