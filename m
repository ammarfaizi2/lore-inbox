Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTLJR7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTLJR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:59:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:39050 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263871AbTLJR7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:59:08 -0500
Date: Wed, 10 Dec 2003 09:58:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <3FD75711.3060103@nortelnetworks.com>
Message-ID: <Pine.LNX.4.58.0312100944190.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <3FD75711.3060103@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Chris Friesen wrote:
>
> Linus Torvalds wrote:
>
> > But also note how it's only the BINARY MODULE that is a derived work. Your
> > source code is _not_ necessarily a derived work, and if you compile it for
> > another operating system, I'd clearly not complain.
> >
> > This is the "stand-alone short story" vs "extra chapter without meaning
> > outside the book" argument. See? One is a work in its own right, the other
> > isn't.
>
> We currently have a situation where an external company supplies us with
> a device driver containing a binary blob that was explicitly written as
> OS-agnostic, and a shim that is gpl'd (at least the linux shim is) to
> get the appropriate os-specific services.  I guess this would fall under
> the "not made just for linux" category in which you've placed the Nvidia
> driver?
>
> Carrying on your analogy, this could be a generic love scene, with
> blanks in which to insert the character's names and location.

Yes. Depending on how it is done (ie is the support for other operating
systems really a major thing that you really care about, and not intended
just as a smoke-screen), I personally believe that this is likely a valid
way to show that some part of the code (the binary blob) is not a derived
work. Clearly it no longer depends on the kernel, and you can show that to
be true by the obvious argument.

And I think this argument is _especially_ strong for things like firmware
etc, and I've been on record as saying that I think it's ok to upload
standard firmware for a driver as long as you don't call it directly (ie
it really lives on the hardware itself).

(At this point I should probably point out that other people disagree, and
there are people who feel strongly that the kernel cannot contain binary
firmware. Whish is obviously part of the reason for having the firmware
loader interfaces for drivers - adding an extra layer of separation).

However, even that doesn't necessarily make the issue 100% clear. It
clarifies the status of the binary blob itself - but arguably the _other_
part of the story (eg the shim layer) is not a whole work, and it could be
argued that that part in itself violates the GPL.

At that point I just say "I'm personally a reasonable person, and quite
frankly, personally the _last_ thing I'd want to do is to complain in a
court of law".

Quite frankly, you'd have to really really try to actively irritate me
with some flagrant crap for me to decide that it's time to try to enforce
anything. But I'm only speaking for myself here, and there are other
copyright holders that might be more trigger-happy.

So while I may be arguing vehemently here against binary-only modules,
please realize that I haven't sued anybody over them, and in fact I'm a
big believer in trying to make sure everybody is pretty happy adn not make
a big deal out of things.

Sometimes that "everybody is happy" means that I literally tell people
that they might want to use a *BSD kernel instead of Linux, if I don't see
them being able to make themselves _and_ the GPL people happy otherwise.

		Linus
