Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTLOULP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTLOULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:11:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18637 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263942AbTLOUKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:10:33 -0500
Date: Mon, 15 Dec 2003 21:04:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Toad <toad@amphibian.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11, reading an apparently duff DVD-R
Message-ID: <20031215200456.GB12192@suse.de>
References: <20031215135802.GA4332@amphibian.dyndns.org> <Pine.LNX.4.58.0312151043480.1631@home.osdl.org> <20031215191335.GG2267@suse.de> <Pine.LNX.4.58.0312151149550.1631@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312151149550.1631@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15 2003, Linus Torvalds wrote:
> 
> 
> On Mon, 15 Dec 2003, Jens Axboe wrote:
> > >
> > > The old ide-scsi reset function is just terminally broken, there's no way
> > > it can work. This patch _might_ make it work, but is more likely to just
> > > print out what it's trying to do.
> >
> > abort doesn't work well either, and ide-scsi needs to be ported to do
> > proper new error handling.
> 
> Yeah. But at least it doesn't look like it would lock up the machine by
> just being horribly wrong (like the reset code would). After all, all it
> does is to wait for the requests to finish.
> 
> So I'm hoping that with just the reset routine basically removed, the
> thing might limp along. But since I can't test it (and am not that
> horribly motivated by it), I'll just see if somebody reports any success
> at all with that patch.

So you're advocating a bandaid :)

However, if that patch makes ide-scsi limp along (it probably does),
then it will never get fixed for real. I suspect you don't care about
that, neither do I.

-- 
Jens Axboe

