Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTE0Le1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTE0Le0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:34:26 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:52433 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S263277AbTE0Le0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:34:26 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Date: Tue, 27 May 2003 13:50:16 +0200
User-Agent: KMail/1.5.1
Cc: LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200305271031.55554.efocht@hpce.nec.com> <200305271339.29151.efocht@hpce.nec.com> <20030527114042.GH31510@wotan.suse.de>
In-Reply-To: <20030527114042.GH31510@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271350.16321.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 13:40, Andi Kleen wrote:
> > I left the loadbalancer to decide on where the homenode should be. And
> > the decision wasn't good enough (it lead to unbalanced nodes, that's
> > certainly not the case on Opteron :-). So it made sense to have a
> > specialized homenode chooser which considered the node loads instead
> > of changing the normal load balancer.
>
> I have that, but only on exec (similar to what 2.5 mainline does with the
> NUMA scheduler)

Oh, that's fine, then. It's better than just on exec().

> > BTW: do you assign the homenode at first load balancing or at first
> > cross-node balancing?
>
> It's the same on Opteron: each CPU is an own node. The lazy homenode for
> fork/clone is chosen on the first load balance of the new thread.

Ah, you're right :-)

Erich


