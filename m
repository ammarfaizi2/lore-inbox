Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTLKBdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLKBcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:32:50 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:59310 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264281AbTLKBb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:31:59 -0500
Date: Wed, 10 Dec 2003 20:31:40 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       <linux-kernel@vger.kernel.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031210231729.GC28912@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0312102027001.25222-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Roger Luethi wrote:

Hmmm, those definitions have changed a little from the
OS books I read ;))

> - It is light thrashing when load control has no advantage.

This used to be called "no thrashing" ;)

> - It is medium thrashing when using load control is a toss-up. Probably
>   better throughput, but somewhat higher latency.

This would be when the system load is so high that
decreasing the multiprocessing level would increase
system load, but performance would still be within
acceptable limits (say, 30% of top performance).

> - It is heavy thrashing when load control is a winner in both regards.

Heavy thrashing would be "no work gets done by the
processes in the system, nobody makes good progress".

In that case load control is needed to make the system
survive in a useful way.

> I just made this up. It neatly resolves all arguments about when load
> control is appropriate. Yeah, so it's a circular definition. Sue me.

Knowing what your definitions are has definately made it
easier for me to understand your previous mails.

Still, sticking to the textbook definitions might make it
even easier to talk about things, and compare the plans
for Linux with what's been done for other OSes.

Also, it would make the job of a load control mechanism
really easy to define:

	"Prevent the system from thrashing"

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

