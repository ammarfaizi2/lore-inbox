Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTLQTvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTLQTvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:51:33 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48985 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264526AbTLQTva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:51:30 -0500
Date: Wed, 17 Dec 2003 14:51:05 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, <kernel@kolivas.org>,
       <chris@cvine.freeserve.co.uk>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031217192742.GB22443@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0312171448430.28701-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, William Lee Irwin III wrote:

> Limited sets of configurations may have left holes in the testing.
> Upper zones much larger than lower zones basically want the things
> to be unequal. It probably wants the replacement load spread
> proportionally in general or some such nonsense.

Yeah. In some configurations 2.4-rmap takes care of this
automagically since part of the replacement isn't as
pressure driven as in 2.4 mainline and 2.6, ie. some of
the aging is done independantly of allocation pressure.

Still, inter-zone balancing is HARD to get right. I'm
currently trying to absorb all of the 2.6 VM balancing
into my mind (*sound effects of brain turning to slush*)
to find any possible imbalances.

Some of the test results I have seen make me very
suspicious...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

