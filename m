Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271206AbTHREZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 00:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271210AbTHREZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 00:25:42 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:30637 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S271206AbTHREZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 00:25:40 -0400
Date: Sun, 17 Aug 2003 22:25:38 -0600
From: Val Henson <val@nmt.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818042538.GA525@speare5-1-14>
References: <20030809173329.GU31810@waste.org> <20030815004004.52f94f9a.davem@redhat.com> <20030815095503.C2784@pclin040.win.tue.nl> <20030815202235.GB13384@speare5-1-14> <bhkit0$nu1$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhkit0$nu1$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 06:27:44AM +0000, David Wagner wrote:
> Val Henson  wrote:
> >If entropy(x) == entropy(y), then:
> >
> >entropy(x) >= entropy(x xor y)
> >entropy(y) >= entropy(x xor y)
> 
> No, that's still wrong.  Please see my earlier email with a counterexample.
> That counterexample disproves not only the earlier claim, but also this more
> recent revised claim.

Sigh.  Yes, I was thinking of the case where x and y already have
maximum entropy, in which case

entropy(x) >= entropy(x xor y)

For any y.  The point I was really trying to make (badly) is that
xoring won't increase entropy on average in this particular case
(folding the output of SHA-1).  In other words, xoring won't make
anything better, and has the possibility of making things worse.  In
any way I evaluate it, folding and truncating are just as good for
this particular case, except that folding costs more
computationally. (The computational cost was significant enough to
have a measurable effect on throughput, so I'm not arm-chair
optimizing here.)

I sacrifice any earlier points I attempted to make on the altar of
hasty mathematics.

-VAL
