Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUBZLqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 06:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUBZLqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 06:46:35 -0500
Received: from zadnik.org ([194.12.244.90]:24535 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262774AbUBZLqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 06:46:32 -0500
Date: Thu, 26 Feb 2004 13:46:15 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <403D2030.8080606@matchmail.com>
Message-ID: <Pine.LNX.4.44.0402261303490.21036-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Mike Fedyk wrote:

> > Yes. However, you won't have to do this switch often. Request for
> > allocating a protected memory, or deallocating it, usually happens once
> > when you run a process, and once when you close it. Even if a poorly
> > written program requests byte-by-byte additional memory, grouping these
> > requests is rather trivial for a memory manager. Memory protection
> > violations are also rare in the reality, so one can afford the load.
> >
> > In addition, this scheme solves one more problem: the fixed two-level
> > memory management - "kernelspace and userspace". Like the "root and users"
> > notion, it is good to some extent, but limits the system. The layered
> > kernel memory management scheme would have to allow tree-like memory
> > management, as a part of the tree-like resources management, thus allowing
> > both more flexibility and more control at the same time.
>
> That is a micro-kernel.  While there is a possibility micro-kernel based
> systems can be as efficient as monolithic, it is harder, and walking in
> the direction of "we can take the load" won't get you there.

I just wrote a message about why it is not microkernel, and were is the
difference. And walking in the direction "while it is possible, it is
hard" will take us nowhere. Imagine Linux Torwalds thinking this way
before starting to write Linux...

> >>One way or another, you'd have to have a "personality".  With Linux
> >>there is one in the kernel, and possibly many in userspace.  You won't
> >>find many here that will agree it should be any other way.
> >
> >
> > Yes. But if you have one hardcoded in the kernel, you run it every time,
> > even if you don't need it. Then, you run some other personality on top of
> > it, and possibly more libraries and programs to support and compensate
> > for the difference. All this is a platform burden. If you can use a more
> > lightweight approach, this will both increase productivity and simplify
> > things. Not speaking about all other advantages (see the original post).
>
> That is why you have the source to most of the user space programs you
> run, right?
>
> Running windows, or anything in Linux with a different personality won't
>   give you the same as the native platform.  There *will* be differences
> that programs depend upon.  Moving that into the kernel will *not* help
> you in this area.

It will. As pointed out above, it will save me the need to roll on an
excess personality and possibly more programs. This will simplify the
system, will decrease the resources needed , and will increase the
productivity.

> WINE or not, that is why ports of apps to Linux is encouraged more than
> getting Wine to work bug for bug like windows.

I agree that Windows could do better, for all resources drained into it.
However, the amout of Windows software that will have to be ported to
Linux, as a work, will be magnitudes over the work needed to implement not
only a full layering model, with a complete support for all Windows
versions that exist and will ever exist, but also a good dozen other
platforms.

And while porting applications may be problem of their vendors, making
Linux kernel better is our problem. I believe that this is what the
discussion is about.

> I can see little purpose in this thread, since little will come out of
> it unless you are willing to start a project yourself, contribute code,
> and eventually recruit a community to work on it.

I don't see the need for starting a project.

First, if unsuccssful, no reason to start it. And if successful, it will
fork the kernel development, with all negative implications following.
I see no sense in doing what eventually will damage the kernel
development, instead of improving it.

Second, the development of the kernel is already going this way,
regardless of our discussion. This is its logic. You can see no use of the
discussion, but you cannot see no use in following the kernel development
logic.

What I offer is merely to see where the road that we tread now goes, and
can't we avoid some of the sideswings and the muddy parts.


Grigor

