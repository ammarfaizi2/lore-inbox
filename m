Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVKVTHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVKVTHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVKVTHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:07:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9391 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965119AbVKVTHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:07:15 -0500
Date: Tue, 22 Nov 2005 20:05:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org,
       Diego Calleja <diegocg@gmail.com>
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122190519.GE1748@elf.ucw.cz>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <200511211252.04217.rob@landley.net> <20051122004531.GA15189@elf.ucw.cz> <200511220034.34266.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511220034.34266.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Sun is proposing it can predict what storage layout will be efficient for
> > > as yet unheard of quantities of data, with unknown access patterns, at
> > > least a couple decades from now.  It's also proposing that data
> > > compression and checksumming are the filesystem's job.  Hands up anybody
> > > who spots conflicting trends here already?  Who thinks the 128 bit
> > > requirement came from marketing rather than the engineers?
> >
> > Actually, if you are storing information in single protons, I'd say
> > you _need_ checksumming :-).
> 
> You need error correcting codes at the media level.  A molecular storage 
> system like this would probably look a lot more like flash or dram than it 
> would magnetic media.  (For one thing, I/O bandwidth and seek times become a 
> serious bottleneck with high density single point of access systems.)
> 
> > [I actually agree with Sun here, not trusting disk is good idea. At
> > least you know kernel panic/oops/etc can't be caused by bit corruption on
> > the disk.]
> 
> But who said the filesystem was the right level to do this at?

Filesystem level may not be the best level to do it at, but doing it
at all is still better than current state-of-the-art. Doing it at
media level is not enough, because then you get interference at IDE
cable or driver bugs etc.

DM layer might be better place to do checksums at, but perhaps
filesystem can do it more efficiently (it knows its own access
patterns), and is definitely easier to setup for the end user.

If you want compression anyway (and you want -- for performance
reasons, if you are working with big texts or geographical data),
doing checksums at the same level just makes sense.
								Pavel
-- 
Thanks, Sharp!
