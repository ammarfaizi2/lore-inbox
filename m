Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbTFWLGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbTFWLGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:06:36 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:60041 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265997AbTFWLGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:06:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Mon, 23 Jun 2003 21:21:46 +1000
User-Agent: KMail/1.5.2
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net> <200306230737.17766.kernel@kolivas.org> <1056366975.587.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056366975.587.2.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306232121.46533.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003 21:16, Felipe Alfaro Solana wrote:
> On Sun, 2003-06-22 at 23:37, Con Kolivas wrote:
> > > > > Yes Mike's patches are definitely better. My patches are designed
> > > > > for the 2.4-ck patchset which has other workarounds that augment
> > > > > this patch; however these workarounds are harder to stomach for
> > > > > mainstream kernels (read nasty hacks). I thought I'd offer the not
> > > > > so nasty sleep_decay patch in 2.5 form for perusal and comments
> > > > > since people are more willing to test 2.5 patches.
> > > >
> > > > Well, it's nice to know.
> > > > I'm willing to test nearly any 2.5 patch. So, I'll gladly test any
> > > > other ideas or patches you (or others) might have.
> > >
> > > ANY?
> > >
> > > Ok well I guess I have to give away my secret then. This is the change
> > > that turns 2.5 into a desktop kernel. Note the very slight change to
> > > Ingo's addon ;-)
>
> OK, I've tested this patch but I still can easily make XMMS starve for
> briefs periods of time and can also make X to start behaving jerky. If I
> put the system under load (while true; do a=2; done) dragging a window
> fast enough for a long time makes the X server priority decreases to a
> point where the window moving is not smooth and very jerky. If I stop
> dragging the window, after a while, the X server prority is restablished
> and I can start all over again.

Yeah sure if you do it for long enough. Just change the best_sleep_decay from 
10 seconds to something like 60 if you plan to do that. Are you really going 
to madly drag a window around for 10 seconds? If so, change it to 60. That's 
how it works.

You didn't specify how you made XMMS starve easily... I don't know if I have 
an answer for that, but I need to know the question.

Con

