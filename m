Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287731AbSAIQDq>; Wed, 9 Jan 2002 11:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAIQDg>; Wed, 9 Jan 2002 11:03:36 -0500
Received: from air-1.osdl.org ([65.201.151.5]:39554 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S287731AbSAIQDW>;
	Wed, 9 Jan 2002 11:03:22 -0500
Date: Wed, 9 Jan 2002 08:04:44 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pavel Machek <pavel@suse.cz>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
        <felix-dietlibc@fefe.de>, <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <20020109155608.GG21317@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0201090802390.865-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Pavel Machek wrote:

> Hi!
>
> > >> How many programs are we talking about here?  And what should they do?
> > >
> > >Very good question that we should probably answer first (I'll follow up
> > >to your other points in a separate message).
> > >
> > >Here's what I want to have in my initramfs:
> > >        - /sbin/hotplug
> > >        - /sbin/modprobe
> > >        - modules.dep (needed for modprobe, but is a text file)
> > >
> > >What does everyone else need/want there?
> >
> > It is planned to move partition discovery to userspace which would then
> > instruct the kernel of the positions of various partitions.
>
> Hmm, and when you insert PCMCIA harddrive, what happens?

If you're booting from that hard drive, you make sure you have the modules
to talk to the drive. In general, you only need to modules to mount the
real root partition, right?

Will we need cardmgr in the future, or will be able to get away with
/sbin/hotplug?

	-pat

