Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTLKPaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbTLKPaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:30:06 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:64762 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265128AbTLKPaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:30:00 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Kendall Bennett" <KendallB@scitechsoft.com>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 09:29:19 -0600
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <3FD7081D.31093.61FCFA36@localhost> <3FD72F7E.4493.6296CE66@localhost>
In-Reply-To: <3FD72F7E.4493.6296CE66@localhost>
MIME-Version: 1.0
Message-Id: <03121109291901.01687@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 16:36, Kendall Bennett wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Wed, Dec 10, 2003 at 11:48:45AM -0800, Kendall Bennett wrote:
> > > Linus Torvalds <torvalds@osdl.org> wrote:
> > > > In fact, a user program written in 1991 is actually still likely
> > > > to run, if it doesn't do a lot of special things. So user programs
> > > > really are a hell of a lot more insulated than kernel modules, which
> > > > have been known to break weekly.
> > >
> > > IMHO (and IANAL of course), it seems a bit tenuous to me the argument
> > > that just because you deliberating break compatibility at the module
> > > level on a regular basis, that they are automatically derived works.
> > > Clearly the module interfaces could be stabilised and published, and if
> > > you consider the instance of a single kernel version in time, that
> > > module ABI *is* published and *is* stable *for that version*. Just
> > > because you make an active effort to change things and actively *not*
> > > document the ABI other than in the source code across kernel versions,
> > > doesn't automatically make a module a derived work.
> >
> > Oh, for crying out loud!  Had you ever looked at that "API"?
> >
> > At least 90% of it are random functions exposing random details of
> > internals. Most of them are there only because some in-tree piece
> > of code had been "modularized".  Badly.
>
> The fact that an API is 'badly' implemented does not detract from the
> fact that it is an API. It is still published as the mechanism that a
> module would use to load and interface to the kernel, via that API.
>
> > In 2.7 we need to get the export list back to sanity.  Right now it's a
> > such a junkpile that speaking about even a relative stability for it...
> > Not funny.
>
> You miss my point. I was talking about a single kernel version. For a
> single kernel version, the ABI is both *published* and *stable*. Sure it
> may not be what you consider a *clean* or *good* ABI, but it *IS* an ABI.
> Note that:
>
> 1. It is a published ABI because for that one kernel release, all the
> source code is available that documents the ABI (albiet badly IYO).
>
> 2. It is stable because that kernel version will never change on your
> machine.

Huh? I frequently update the kernel, and the kernel minor version... as
well as switch from uniprocessor to SMP. The major version may not change,
but that minor one certanly does. And adding SMP changes the ABI for
that version. And patches CAN and DO change the ABI, even within the
major version.

> Given that it is a stable and published ABI for a single kernel version,
> then what makes a kernel module different from a user program? The fact
> that binary only modules are *only* guaranteed to work with one single
> kernel version, the fact that the ABI changes from version to version is
> completely irrelevant to determing whether a binary module is derived
> from the kernel or not.

How do you handle the differences in a single version for something like
SMP? It is still the same version, but a binary driver for SMP will most
likely NOT work on uniprocessor, and even more likey not work if compiled
for a uniprocessor under SMP.
