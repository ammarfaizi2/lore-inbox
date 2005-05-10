Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVEJNHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVEJNHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEJNHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:07:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62873 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261630AbVEJNHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:07:14 -0400
Date: Tue, 10 May 2005 15:07:13 +0200
From: Andi Kleen <ak@suse.de>
To: Bernd Paysan <bernd.paysan@gmx.de>
Cc: Andi Kleen <ak@suse.de>, suse-amd64@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Message-ID: <20050510130709.GI25612@wotan.suse.de>
References: <200505081445.26663.bernd.paysan@gmx.de> <200505091517.30555.bernd.paysan@gmx.de> <20050510111223.GH25612@wotan.suse.de> <200505101355.00341.bernd.paysan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505101355.00341.bernd.paysan@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 01:54:53PM +0200, Bernd Paysan wrote:
> On Tuesday 10 May 2005 13:12, Andi Kleen wrote:
> > > So that explains why nobody sees this problem. But the TSC-based
> > > fallback timekeeping is still broken on SMP systems with PowerNow and
> > > distributed IRQ handling, which both together seem to be rare enough
> > > ;-).
> >
> > There is a patch pending for the TSC problem - using the pmtimer instead
> > in this case.
> >
> > But the distributed timer interrupt problem is weird. It should not
> > happen. You sure it was IRQ 0 that was duplicated and not "LOC" ?
> 
> Yes. Only one CPU actually gets and handles the timer interrupt, but which 
> one is somewhat random (for about 10 seconds, it's the same CPU, then it 
> switches over).

That could be irqbalance doing its thing. Does it go away when
you stop it?

-Andi

