Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTLJVEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTLJVEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:04:43 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:52885 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264118AbTLJVEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:04:41 -0500
Date: Wed, 10 Dec 2003 16:04:16 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       <linux-kernel@vger.kernel.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031210135829.GA18370@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0312100919090.3900-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Roger Luethi wrote:

> For me this discussion just confirmed that my approach fails to draw
> much interest, either because there are better alternatives or because
> heavy paging and medium thrashing are generally not considered
> interesting problems.

I'm willing to take over this work if you really want
to throw in the towel.  It has to be done, simply to
make Linux better able to deal with load spikes.

> Our apparent differences come from the fact that we try to solve
> different problems as you correctly noted: You are concerned with
> extreme overcommit, while I am concerned that 2.6 takes several times
> longer than 2.4 to complete a task under slight overcommit.

Agreed, the slight to medium overcommit needs to be
addressed well.  This is way more important than very
highly overcommitted systems, because computers are
powerful enough for their workloads anyway.

The thing Linux needs to deal with are unexpected
load spikes.  The thing that needs to be done is
making sure that such a load spike doesn't send
Linux into a death spiral.

If such a load control mechanism also solves the
highly overloaded scenario, that's just a nice
bonus.

> The key question with regards to load control remains: How do you keep a
> load controled system responsive? Cleverly detect interactive processes
> and spare them, or wake them up again quickly enough? How? Or is the
> plan to use load control where responsiveness doesn't matter anyway?

Under light to moderate overload, a load controlled system
will be more responsive than a thrashing system.

Heavy overload is probably a "docter, it hurts ..." case.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


