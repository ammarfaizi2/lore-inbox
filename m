Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTEKRYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTEKRYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:24:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:40850 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261797AbTEKRYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:24:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 May 2003 10:38:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Jos Hulzink <josh@stack.nl>, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
In-Reply-To: <20030511140144.GA5602@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50.0305111033590.7563-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
 <200305111137.29743.josh@stack.nl> <20030511140144.GA5602@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Jamie Lokier wrote:

> Jos Hulzink wrote:
> > On Sunday 11 May 2003 05:50, Linus Torvalds wrote:
> > > Hmm.. Doesnt' a _real_ hardware reset actually use a magic segment that
> > > isn't even really true real mode? I have this memory that the reset value
> > > for a i386 has CS=0xf000, but the shadow base register actually contains
> > > 0xffff0000. In other words, the CPU actually starts up in "unreal" mode,
> > > and will fetch the first instruction from physical address 0xfffffff0.
> > >
> > > At least that was true on an original 386. It's something that could
> > > easily have changed since.
>
> I got my info from an article on the net which says that a 386 does
> behave as you say, but it is possible for the system designer to
> arrange that it boots into the 286-compatible vector at physical
> address 0x000ffff0.  It states that the feature is specifically so
> that system designers don't have to create a "memory hole" (that's as
> much detail as it gives).

Guys, mem[0xfffffff0,...] == mem[0x000ffff0,...] since the hw remaps the
bios. Being picky about Intel specs, it should be f000:fff0 though.



- Davide

