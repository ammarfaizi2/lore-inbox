Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUHIInW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUHIInW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUHIInW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:43:22 -0400
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:10112 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266273AbUHIImg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:42:36 -0400
Date: Mon, 9 Aug 2004 10:42:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: What PM should be and do (Was Re: Solving suspend-level confusion)
Message-ID: <20040809084212.GA737@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston> <200408032030.41410.david-b@pacbell.net> <1091594872.3191.71.camel@laptop.cunninghams> <1091595224.1899.99.camel@gaston> <1091595545.3303.80.camel@laptop.cunninghams> <20040808165416.GB2668@elf.ucw.cz> <1092002119.6215.7.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092002119.6215.7.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Yes. I'm not trying to give drivers an inconsistent state, just delaying
> > > suspending some until the last minute....
> > > 
> > > Suspend 2 algorithm:
> > > 
> > > 1. Prepare image (freeze processes, allocate memory, eat memory etc)
> > > 2. Power down all drivers not used while writing image
> > > 3. Write LRU pages. ('pageset 2')
> > > 4. Quiesce remaining drivers, save CPU state, to atomic copy of
> > > remaining ram.
> > > 5. Resume quiesced drivers.
> > 
> > Hmm, this means pretty complex subtree handling.. Perhaps it would be
> > possible to make "quiesce/unquiesce" support in drivers so that this
> > is not needed?
> 
> That would be great from my point of view. It's why I talked before in
> terms of quiesced etc rather than S3, S4 and so on.

Well, for "common" hardware (like all modern notebooks), I guess
making it reasonably fast should be easy to do... Uncommon hardware
will be harder, but if someone tries to suspend server with firewire,
he can probably survive some delay...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
