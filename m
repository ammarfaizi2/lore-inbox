Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVGGPLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVGGPLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGGPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:09:35 -0400
Received: from [66.150.84.1] ([66.150.84.1]:24564 "EHLO
	rowdy.as.in.athenacr.com") by vger.kernel.org with ESMTP
	id S261424AbVGGPGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:06:55 -0400
From: Andres Salomon <dilinger@debian.org>
Subject: Re: tg3 driver fails
Date: Thu, 07 Jul 2005 11:06:37 -0400
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.07.07.15.06.31.28150@debian.org>
Newsgroups: gmane.linux.debian.ports.sparc
References: <Pine.LNX.4.61.0507061051020.2607@bobcat> <20050706.160821.74746394.davem@redhat.com> <Pine.LNX.4.61.0507062328370.3236@bobcat> <20050707.030818.102573301.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing lkml for relevance..

On Thu, 07 Jul 2005 03:08:18 -0400, David S.
Miller wrote:

> From: Jurij Smakov <jurij@wooyd.org>
> Date: Thu, 7 Jul 2005 00:38:00 -0400 (EDT)
> 
>> In fact, Debian is actively working on resolving this situation.
> 
> Keep defending yourselves.  This was a disaster regardless
> of the technical reasons or details of the situation.
> 
> No user wants to hear a story, they want their systems to work, and
> developers do too.  I don't want to hear a story either, because all I
> see are user's systems not working and nothing that can be done about
> it at this time.
> 

As one of the authors of a driver that had to be stripped due to it not
being distributable, I would be a bit more apologetic regarding this if I
was you. We (Debian) are simply trying to abide by the licenses that
people have made their works available under.  You'd probably get very
upset if we distributed a heavily modified/improved kernel without
providing sources (and thereby violating the GPL), and yet it's OK for us
to distribute firmware under a license that we cannot satisfy?

You're right, no one wants to hear a story, but I'm really quite curious
how the authors of the kernel justify distributing code that includes bits
like the smctr firmware [0]: 

 * The firmware this driver downloads into the tokenring card is a
 * separate program and is not GPL'd source code, even though the Linux
 * side driver and the routine that loads this data into the card are.
 *
 * This firmware is licensed to you strictly for use in conjunction
 * with the use of SMC TokenRing adapters. There is no waranty
 * expressed or implied about its fitness for any purpose.

The license covers use, but not redistribution.  Is it even allowed to be
redistributed?  The "strictly" bit leads me to believe it that the
firmware author(s) don't want other permission to be assumed.

This is the sort of thing that causes us (Debian) no end of headaches, and
why I've wasted much of my time dealing w/ stripping out drivers, talking
with companies like Broadcom and QLogic, and answering emails
like this one. And no, ladies and gentlemen; the GPL is *not* a valid
license for binary firmware.  The key wording here is "The source code for
a work means the preferred form of the work for making modifications to
it."  It doesn't matter whether the code actually executes on the host
processor or not (as this seems to be the common excuse for not providing
source). Unless the firmware was generated with a hex editor (which I
don't see proof for, for any of the 7 or so drivers we're removing), the
source for the firmware is not available upon request, so we cannot
distribute it.


> That's why many people are disappointed with the way the latest
Debian
> stable release turned out.  That's why many developers don't want to
> work on Debian any more, and want to move on to other distributions
> where it's not politics madness all the time.
> 

The release process isn't really relevant to this thread. 
Besides, I'm just as annoyed as you, having been stuck maintaining a
largely outdated kernel while freeze/release process dragged on and on. 
Lots of Debian Developers have been extremely frustrated with the release
process and the personalities involved in actually making things get done
wrt infrastructure changes. Ranting here won't fix anything, though.

I'm ignoring the rest of the email, as it's related more to release
process frustration than firmware and tg3 removal.

[0]
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=48994b043b7cf0e06e29b2f4424257edfae107b5;hb=c101f3136cc98a003d0d16be6fab7d0d950581a6;f=drivers/net/tokenring/smctr_firmware.h

