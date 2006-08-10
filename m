Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161403AbWHJQKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161403AbWHJQKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWHJQKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:10:36 -0400
Received: from mxsf04.cluster1.charter.net ([209.225.28.204]:53925 "EHLO
	mxsf04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1161403AbWHJQKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:10:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17627.23159.236724.190546@stoffel.org>
Date: Thu, 10 Aug 2006 12:10:31 -0400
From: "John Stoffel" <john@stoffel.org>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
In-Reply-To: <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	<62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	<Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	<62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	<1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	<62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	<20060810030602.GA29664@mail>
	<62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Molle" == Molle Bestefich <molle.bestefich@gmail.com> writes:

Molle> I guess the problem is that I don't know a single Linux
Molle> packaging system that actually works well enough to keep a
Molle> system up to date at all times, and I don't have any free time
Molle> to spend on reinstalling systems all the time.

Debian works the best in my experience.  Yum sucks rocks, it's a pain
to configured and when it does pull in stuff, it pulls in *everything*
that you don't want.  

Not that apt-get is perfect, but it works well.  My main machine at
home is an old Debian Stable install upgraded pretty much daily.
Rarely do things break.  And rarely do you want packages updated
without you thinking about it.  

If you need to maintain a bunch of systems, all at the same rev, then
you will obviously need a master system to test on and from which to
push updates to the clients.  In this case, you'd setup your own
private repository which the clients would pull from.  

Molle> I think most of the package managers break because their
Molle> dependency system sucks.  Some of them doesn't suck, but they
Molle> break because there's no integrity checks, and package
Molle> maintainers can dump any kind of bizarre corrupt dependencies
Molle> they like into them.  That's how Gentoo works, for example.
Molle> Others have even more bizarre ways of breaking, again Gentoo as
Molle> an example requires the user to run a "switch to newer GCC"
Molle> command from time to time, otherwise random packages just start
Molle> breaking.

I tried gentoo a bunch of years ago and didn't like it, and it
certainly didn't give me the speedup it claimed it would have.  I've
been happy with Debian.  Thinking about Ubuntu more...

Molle> Surely it's possible to create a kernel interface where
Molle> processes can tell the kernel about which other processes
Molle> they'd like to outlive and which ones they'd like to get killed
Molle> before.

This has nothing to do with the kernel, it's all a userspace issue.  

Molle> The kernel could then coordinate the killing of processes in a
Molle> "shutdown" function, which the various distro's 'reboot' and
Molle> 'shutdown' scripts could call.

Again, userspace completely.  You're asking for policy in the kernel,
where it doesn't belong.  

Molle> And voila, that difficult task of assessing in which order to
Molle> do things is out of the hands of distros like Red Hat, and into
Molle> the hands of those people who actually make the binaries.

*bwah hah hah!*  And you think they'll get it right?  So what happens
when two packages, call them A and B, have a circular dependency on
each other?  Who wins then?

It's not as simple an issue as you think.  

John
