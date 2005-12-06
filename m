Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbVLFACN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbVLFACN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVLFACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:02:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65216 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751505AbVLFACN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:02:13 -0500
Date: Tue, 6 Dec 2005 01:01:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206000154.GD1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <1133791084.3872.53.camel@laptop.cunninghams> <20051205172938.GC25114@atrey.karlin.mff.cuni.cz> <200512052344.01506.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512052344.01506.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, it is not completely fair. But as I started to use X32 with good
> > battery... well I'm not really using swsusp any more.
> 
> Unfortunately I can't make my box suspend to RAM ... :-(

Yes, debugging suspend-to-RAM is hard, but it is not impossible. Try
with minimal config (noapic, 32-bit kernel, ...) then add
features. Hopefully minimum kernel will work...

> > > > * compress the image. Needs to be done in userspace, so it needs
> > > > uswsusp to be merged, first. Patches for that are available. Should
> > > > speed it up about twice.
> 
> Frankly, I would think that compression could be done in the kernel.

Unfortunately cryptoapi only supports gzip compression, and that's
useless for swsusp. (Slows it down, 10 times). And adding LZW to
kernel just for swusp is wrong  thing to do.

> > If goal is "make it work with least effort", answer is of course
> > suspend2; but I need someone to help me doing it right.
> 
> Well, in the Andy's case this may or may not help.  Actually I'd like him to try
> and say what's the result, but only if he's so kind, has some free time
> to was^H^H^Hdo this, etc. ;-)
     ~~~~~~~~~~~
	I think I'm missing something here.
								Pavel
-- 
Thanks, Sharp!
