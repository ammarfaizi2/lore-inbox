Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUHaGul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUHaGul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUHaGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:50:40 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:48647 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266883AbUHaGu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:50:29 -0400
Date: Mon, 30 Aug 2004 23:50:18 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Linus Torvalds <torvalds@osdl.org>,
       Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Userspace file systems & MKs (Re: silent semantic changes with reiser4)
Message-ID: <20040831065017.GA11932@nietzsche.lynx.com>
References: <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <413400B6.6040807@pobox.com> <20040831053055.GA8654@nietzsche.lynx.com> <4134131D.6050001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4134131D.6050001@pobox.com>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:56:45AM -0400, Jeff Garzik wrote:
> Bill Huey (hui) wrote:
> >DragonFly BSD, the only remotely functional open source BSD project on this
> >planet, has plans in place to push certain kernel components like their VFS
> >layer into userspace for easier debugging, testing and other things that go
> 
> That violates Jeff's First Rule, put the fast path stuff in the kernel.

It's not for native file system, but one that are coming around. I kind
of misspoke when I said that the VFS layer is going to be pushed into
userspace. It's not. Access to the VFS layer is going to be exported to
userspace. The system is interesting because of its potential programming
flexibility.

> >with developing file systems easily. If they back it with something like 
> >C++
> >for doing constructor style type conversion on top of overloaded operators
> >to back VFS data structure translation, could easily import stuff like most
> >Linux file systems without major restructuring, say, if they had their
> >translation library written. In this case, userspace kernel systems have
> >some serious programming advantages over traditional kernels.
> 
> Sounds like security would be a pain in the ass :)

Don't know. But if you can get away from the typical C programming errors, then
it could be a win.

> >They're also pushing an async syscall model to support a non-1:1 threading
> >system for userspace unlike what Linux has done with futexes. It'll allow
> 
> messaging passing is also known as "really slow C function calls"
> 
> My PCI bus passes messages all the time.  A message is in the eye of the 
> beholder.

Message passing is used as a method of concurrency in that system outside
of the typical use of function calles. It makes access to kernel facilities,
remote or local, transparent. They also don't use a mutex for their locking,
but something called a token which is per-CPU kind of locking primitive. It's
definitely an interesting system with a lot of potential.

bill

