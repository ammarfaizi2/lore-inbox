Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315959AbSEGUB6>; Tue, 7 May 2002 16:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315960AbSEGUB5>; Tue, 7 May 2002 16:01:57 -0400
Received: from air-2.osdl.org ([65.201.151.6]:20879 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S315959AbSEGUB5>;
	Tue, 7 May 2002 16:01:57 -0400
Date: Tue, 7 May 2002 12:58:22 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <200205071921.g47JLAV00682@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0205071248450.6307-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh, it's certainly more that 6 hours of work. But it *will* get done.

Even the mtrr driver was a good 8 hours to clean up, make readable and 
more object-oriented. I wish you luck, as well as anyone that has to 
attempt to decipher it. 

> > > At that point devfs will mostly be:
> > > - an API
> > > - a way fo supporting the devfsd protocol.
> > 
> > I argue that you shouldn't need a separate daemon. We already have
> > the /sbin/hotplug interface. It's simple and sweet. We shouldn't
> > need to rely on an entirely separate daemon.
> 
> The devfsd protocol is more lightweight. Plus it doesn't require
> fork(2)+execve(2) overheads. And more importantly, you can capture
> lookup() events.

These events are not performance critical, so the overhead is less 
important. Besides, almost all systems have /sbin/hotplug, since it can be 
anything - a shell script, a perl script, a tiny C executable. 

The hotplug interface doesn't rely on any particular implementation. It 
only relies on something on the other side implementing a particular 
interface. The implementation can be replaced, as well as the format of 
the policy, based on the constratints of the system or the whims of 
the distro. 

It also doesn't rely on a process running to capture events. What happens 
if the devfsd process is killed?

	-pat

