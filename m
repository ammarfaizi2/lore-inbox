Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTE0L1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTE0L1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:27:33 -0400
Received: from ns.suse.de ([213.95.15.193]:2059 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263285AbTE0L13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:27:29 -0400
Date: Tue, 27 May 2003 13:40:43 +0200
From: Andi Kleen <ak@suse.de>
To: Erich Focht <efocht@hpce.nec.com>
Cc: Andi Kleen <ak@suse.de>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Message-ID: <20030527114042.GH31510@wotan.suse.de>
References: <200305271031.55554.efocht@hpce.nec.com> <200305271154.52608.efocht@hpce.nec.com> <20030527100148.GE31510@wotan.suse.de> <200305271339.29151.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271339.29151.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I left the loadbalancer to decide on where the homenode should be. And
> the decision wasn't good enough (it lead to unbalanced nodes, that's
> certainly not the case on Opteron :-). So it made sense to have a
> specialized homenode chooser which considered the node loads instead
> of changing the normal load balancer.

I have that, but only on exec (similar to what 2.5 mainline does with the
NUMA scheduler)

> BTW: do you assign the homenode at first load balancing or at first
> cross-node balancing?

It's the same on Opteron: each CPU is an own node. The lazy homenode for
fork/clone is chosen on the first load balance of the new thread.


-Andi
