Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWEQSzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWEQSzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEQSzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:55:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750962AbWEQSzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:55:44 -0400
Date: Wed, 17 May 2006 14:55:21 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andi Kleen <ak@suse.de>, Martin Peschke <mp3@de.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       arjan@infradead.org, James.Smart@emulex.com,
       James.Bottomley@steeleye.com, ltt-dev@shafik.org
Subject: Re: [RFC] [Patch 0/8] statistics infrastructure
Message-ID: <20060517185521.GM17707@redhat.com>
References: <446A0F77.70202@de.ibm.com> <y0msln8wooo.fsf@ton.toronto.redhat.com> <200605172005.44588.ak@suse.de> <20060517182808.GL17707@redhat.com> <200605171844.k4HIiPd1028516@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605171844.k4HIiPd1028516@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Wed, May 17, 2006 at 02:44:24PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 17 May 2006 14:28:08 EDT, "Frank Ch. Eigler" said:
> > I am not suggesting a single solution for all needs.  I wanted to
> > focus only one aspect: the marking of those points in the kernel where
> > something probeworthy occurs with hooks.  [...]
> 
> The problem is that the "common pool" ends up being a very wide swamp
> very fast.  [...]
> So under your plan, all 3 groups now use a "common pool" that includes
> slap, timing, latency, and other stuff - and nobody's using more than
> 1/3 of it, but paying the performance penalty for the 2/3 unused hooks....

It may not be clear, but by "pool", I mean some group of individually
activated hooks, doing little but calling some routine of
instrumentation with a few parameters.  Special-interest data like
timing, latency would be computed in the instrumentation code, not
necessarily at the hook site, so that part need incur no waste for
disinterested users.

Not-activated (dormant) hooks would indeed cost a little.  The
question is how much time/space cost is acceptable, in order to reap
the benefits of widely available probing.

- FChE
