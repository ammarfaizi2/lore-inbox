Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSAIQaq>; Wed, 9 Jan 2002 11:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSAIQa2>; Wed, 9 Jan 2002 11:30:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287710AbSAIQaH>; Wed, 9 Jan 2002 11:30:07 -0500
Date: Wed, 9 Jan 2002 17:29:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Greg KH <greg@kroah.com>, felix-dietlibc@fefe.de,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109162951.GA24175@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020109155608.GG21317@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0201090802390.865-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201090802390.865-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >> How many programs are we talking about here?  And what should they do?
> > > >
> > > >Very good question that we should probably answer first (I'll follow up
> > > >to your other points in a separate message).
> > > >
> > > >Here's what I want to have in my initramfs:
> > > >        - /sbin/hotplug
> > > >        - /sbin/modprobe
> > > >        - modules.dep (needed for modprobe, but is a text file)
> > > >
> > > >What does everyone else need/want there?
> > >
> > > It is planned to move partition discovery to userspace which would then
> > > instruct the kernel of the positions of various partitions.
> >
> > Hmm, and when you insert PCMCIA harddrive, what happens?
> 
> If you're booting from that hard drive, you make sure you have the modules
> to talk to the drive. In general, you only need to modules to mount the
> real root partition, right?

But that means that I'll need partition discovery code twice. Once on
initrd, and once on my root, because if I insert PCMCIA harddrive on
runtime, I'll need same detection.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
