Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbUB2Jvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 04:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUB2Jvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 04:51:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30899 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262027AbUB2Jvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 04:51:44 -0500
Date: Sun, 29 Feb 2004 10:51:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Daniel Robbins <drobbins@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Message-ID: <20040229095139.GH3149@suse.de>
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228021040.GA14836@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27 2004, Greg KH wrote:
> On Fri, Feb 27, 2004 at 07:01:22PM -0700, Daniel Robbins wrote:
> > However, 2.6.3-bk9's USB printing support appears to be dead. I can't
> > get it to work reliably. Tested on Epson Stylus Photo 960 and a Brother
> > Laser printer. catting files to /dev/usb/lp? tends to fail (process will
> > get "stuck") and printer data stops flowing. This is on an Athlon XP
> > (NForce2) system using the on-board USB. The official 2.6.3 release
> > works fine. I'd expect these USB printing death symptoms to be easily
> > reproducable on quite a few systems -- the problems hit me in the first
> > few seconds of print testing. If they end up being more elusive, I can
> > try to dig up more info for anyone who's interested in trying to isolate
> > the problem.
> 
> Yes, I am.  Do you get any error messages in your syslog when the
> printer hangs?

FWIW, saw the same thing here today. 2.6.2-mm1 was the previous kernel
and it worked, 2.6.3-mm4 gives me a bunch of:

kernel: drivers/usb/class/usblp.c: usblp0: off-line
kernel: drivers/usb/class/usblp.c: usblp0: ok
kernel: drivers/usb/class/usblp.c: usblp0: off-line
kernel: drivers/usb/class/usblp.c: usblp0: ok
kernel: drivers/usb/class/usblp.c: usblp0: off-line
kernel: drivers/usb/class/usblp.c: usblp0: ok
kernel: drivers/usb/class/usblp.c: usblp0: off-line
kernel: drivers/usb/class/usblp.c: usblp0: ok
kernel: drivers/usb/class/usblp.c: usblp0: off-line
kernel: drivers/usb/class/usblp.c: usblp0: ok

No usb 2.x at all on this box.

-- 
Jens Axboe

