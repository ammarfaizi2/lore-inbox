Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTLKWSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTLKWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:18:55 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:26875 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263765AbTLKWSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:18:52 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 16:18:18 -0600
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <3FD72F7E.4493.6296CE66@localhost> <3FD84B40.2288.66EB3B3C@localhost>
In-Reply-To: <3FD84B40.2288.66EB3B3C@localhost>
MIME-Version: 1.0
Message-Id: <03121116181800.02678@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 12:47, Kendall Bennett wrote:
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> > > You miss my point. I was talking about a single kernel version. For a
> > > single kernel version, the ABI is both *published* and *stable*. Sure
> > > it may not be what you consider a *clean* or *good* ABI, but it *IS* an
> > > ABI. Note that:
> > >
> > > 1. It is a published ABI because for that one kernel release, all the
> > > source code is available that documents the ABI (albiet badly IYO).
> > >
> > > 2. It is stable because that kernel version will never change on your
> > > machine.
> >
> > Huh? I frequently update the kernel, and the kernel minor version... as
> > well as switch from uniprocessor to SMP. The major version may not
> > change, but that minor one certanly does. And adding SMP changes the ABI
> > for that version. And patches CAN and DO change the ABI, even within the
> > major version.
>
> So what? You don't change it on *MY* machine, now do you? *MY* version
> remains stable regardless of what *YOU* do unless I update my source
> code.

You won't be able to update it... Even in the face of real problems that
must be updated (as in a major security problem).

> > How do you handle the differences in a single version for
> > something like SMP? It is still the same version, but a binary
> > driver for SMP will most likely NOT work on uniprocessor, and even
> > more likey not work if compiled for a uniprocessor under SMP.
>
> No, it is not the same version. One is the UNI version and one is the SMP
> version. By version of kernel I mean the version of the binary that I am
> building the loadable module to work with. You can just consider the
> UNI/SMP support to be an extension of the version and treat them as
> different versions (after all, you will need two separate modules to
> handle this anyway).

According to the kernel it is the same version - the binary module loaded, it
just doesn't work. And no way to get it working either.

This also applies to other minor options - like AMD optimizations, PII/P3/P4
optimizations... They all run the same Kernel version... Even when they are
uniprocessor only...

So now you ALSO have to have that third party to distribute BINARY versions
of the kernel to make that binary driver work. And you can't make any
changes.. because that may/would break the system... You can no longer
upgrade your system. You might be able to go from P2 to p3, but if the
driver was built for p3, expect problems on a p2.

And blow it out your ear if you want an IA64, or even a 64 bit AMD.

And you don't even know what options that third party used in building their
kernel, and can't create an equivalent...

And forget trying to get any help for a problem. Especially if there are
two such modules you need... If you think the finger pointing is bad now,
think about what happens then.

Which is why I don't buy, nor even recommend, devices that reqire closed
source drivers.

There are just too many combinations of options that make a single (or even
limited number of) version(s) of a binary module either unusable or
unsupportable.
