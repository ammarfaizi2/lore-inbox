Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbTFWLCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbTFWLCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:02:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24333 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265993AbTFWLCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:02:12 -0400
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
In-Reply-To: <200306230737.17766.kernel@kolivas.org>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
	 <1056298486.601.25.camel@teapot.felipe-alfaro.com>
	 <200306230724.39194.kernel@kolivas.org>
	 <200306230737.17766.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056366975.587.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 13:16:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-22 at 23:37, Con Kolivas wrote:
> > > > Yes Mike's patches are definitely better. My patches are designed for
> > > > the 2.4-ck patchset which has other workarounds that augment this
> > > > patch; however these workarounds are harder to stomach for mainstream
> > > > kernels (read nasty hacks). I thought I'd offer the not so nasty
> > > > sleep_decay patch in 2.5 form for perusal and comments since people are
> > > > more willing to test 2.5 patches.
> > >
> > > Well, it's nice to know.
> > > I'm willing to test nearly any 2.5 patch. So, I'll gladly test any other
> > > ideas or patches you (or others) might have.
> >
> > ANY?
> >
> > Ok well I guess I have to give away my secret then. This is the change that
> > turns 2.5 into a desktop kernel. Note the very slight change to Ingo's
> > addon ;-)

OK, I've tested this patch but I still can easily make XMMS starve for
briefs periods of time and can also make X to start behaving jerky. If I
put the system under load (while true; do a=2; done) dragging a window
fast enough for a long time makes the X server priority decreases to a
point where the window moving is not smooth and very jerky. If I stop
dragging the window, after a while, the X server prority is restablished
and I can start all over again.

