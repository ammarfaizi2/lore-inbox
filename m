Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUGIR5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUGIR5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUGIR5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:57:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:6042 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265127AbUGIR5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:57:11 -0400
Date: Fri, 9 Jul 2004 19:55:46 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
In-Reply-To: <40EEB1B2.7000800@kolivas.org>
Message-ID: <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk>
References: <40EEB1B2.7000800@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004, Con Kolivas wrote:

> Jesper Juhl wrote:
> > On Tue, 6 Jul 2004, Matthias Andree wrote:
> >
> >
> >>Hi,
> >>
> >>I've pulled from the linux-2.6 BK tree some post-2.6.7 version,
> compiled
> >>and installed it, and it breaks Java, standalone or plugged into
> >>firefox, the symptom is that the application catches SIGKILL. This
> >>didn't happen with stock 2.6.7 and doesn't happen with 2.6.6 either.
> >>
> >
> > I'm seeing the same thing. I'm using Eclipse a lot which is Java
> based,
> > and I noticed that wen I went from plain 2.6.7 to 2.6.7-mm3 Eclipse
> > started dying shortly after launch (it only manages to get the splash
> > screen up) with a message about the JVM dying. Since I had also
> upgraded
> > my Sun Java at the same time I initially suspected that and back down
> to
> > my old version, but the problem persisted. Then I tried the latest
> Java
> > release from Sun, with same result. Then I started suspecting the
> kernel
> > and tried 2.6.7-mm6, 2.6.7-bk20 and 2.6.7-mm7 - all with the same
> result
> > that Java breaks. Finally I went back to a plain 2.6.7 and the problem
> > went away - so it certainly looks kernel related.
> > I was using the same .config with all kernels (copied from my plain
> 2.6.7
> > kernel to the others and then running 'make oldconfig'), so I'm also
> > pretty sure it's not due to some new kernel option I've enabled that I
> > don't usually use.
> >
> > My hardware is AMD Athlon (t-bird) 1.4GHz CPU in a ASUS A7M266 mobo
> with
> > 512MB of DDR266 RAM.
> >
> >
> >
> >>Is there any particular change I should try backing out?
> >>
> >
> > I'm looking for the same thing, haven't found it yet unfortunately.
> Hello
> I've just started having a java application bomb out not long into
> running as well where previously it would run for hours without
> problems. However, unlike  yourselves I'm running -ck and the only
> change between the last working -ck and this kernel are the 3 security
> patches. I haven't investigated because I cant take the machine offline,
>
> but I suspect it's one of those possibly interfering. Looking at the
> patches in question I have no idea how they could do it. I guess if you
> can try backing them out it would be helpful. Here are links to the
> patches in question.
> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1100_ip_tabl
> es.patch
> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1105_CAN-200
> 4-0497.patch
> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1110_proc.pa
> tch

Thanks Con, I'll try playing with those tomorrow (got no time tonight),
and report back.

Ohh, and in case it's significant, I'm using gcc 3.4.0


--
Jesper Juhl <juhl-lkml@dif.dk>
