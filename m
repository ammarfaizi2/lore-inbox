Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUHaFbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUHaFbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 01:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUHaFbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 01:31:11 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:24582 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266585AbUHaFbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 01:31:07 -0400
Date: Mon, 30 Aug 2004 22:30:55 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Tom Vier <tmv@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Userspace file systems & MKs (Re: silent semantic changes with reiser4)
Message-ID: <20040831053055.GA8654@nietzsche.lynx.com>
References: <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <413400B6.6040807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413400B6.6040807@pobox.com>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 12:38:14AM -0400, Jeff Garzik wrote:
> _My_ own definition of microkernel, which differs from traditional CS, 
> is where I would love to see Linux go:  move as much as humanly possible 
> to userspace, such that, the kernel only contains pagecache operations, 
> driver fast paths, and security checks.  Move slow paths, including ACPI 
> probing, PCI bus walking, driver init/reset paths, some of the ioctl 
> handling, to userspace.  Be willing to accept extra context switches as 
> a cost in all but the fast paths.

	http://www.dragonflybsd.org

DragonFly BSD, the only remotely functional open source BSD project on this
planet, has plans in place to push certain kernel components like their VFS
layer into userspace for easier debugging, testing and other things that go
with developing file systems easily. If they back it with something like C++
for doing constructor style type conversion on top of overloaded operators
to back VFS data structure translation, could easily import stuff like most
Linux file systems without major restructuring, say, if they had their
translation library written. In this case, userspace kernel systems have
some serious programming advantages over traditional kernels.

They're also pushing an async syscall model to support a non-1:1 threading
system for userspace unlike what Linux has done with futexes. It'll allow
for them to plug in various userspace schedulers at will for whatever
scheduling policy you want dynamically, even while the program is running.

This isn't mentioning their single system image clustering goals that have
abstracted various kernel systems like their VFS stuff to a messaging model
which should get them proccess migration as an intrinsic part of their OS
design. They've made a lot of progress over the last year and it's largely
because of Matt Dillon's ability to create a non-overly political group that
creates trust. He's a true leader, not some random loud mouth(s) unlike
other BSD efforts. It's much like the Linux community in this regard with
Linus.

bill

