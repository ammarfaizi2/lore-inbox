Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266618AbUGKPjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266618AbUGKPjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUGKPjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 11:39:49 -0400
Received: from mail.dif.dk ([193.138.115.101]:41105 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266618AbUGKPjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 11:39:46 -0400
Date: Sun, 11 Jul 2004 17:38:19 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Con Kolivas <kernel@kolivas.org>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
In-Reply-To: <Pine.LNX.4.58.0407111728580.6988@alpha.polcom.net>
Message-ID: <Pine.LNX.4.56.0407111735490.23998@jjulnx.backbone.dif.dk>
References: <40EEB1B2.7000800@kolivas.org> <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.56.0407111713420.23979@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.58.0407111728580.6988@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Grzegorz Kulewski wrote:

> On Sun, 11 Jul 2004, Jesper Juhl wrote:
>
> > On Fri, 9 Jul 2004, Jesper Juhl wrote:
> >
> > > On Fri, 9 Jul 2004, Con Kolivas wrote:
> > >
> > > >
> > > > but I suspect it's one of those possibly interfering. Looking at the
> > > > patches in question I have no idea how they could do it. I guess if you
> > > > can try backing them out it would be helpful. Here are links to the
> > > > patches in question.
> > > > http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1100_ip_tabl
> > > > es.patch
> > > > http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1105_CAN-200
> > > > 4-0497.patch
> > > > http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1110_proc.pa
> > > > tch
> > >
> > > Thanks Con, I'll try playing with those tomorrow (got no time tonight),
> > > and report back.
> > >
> > Ok, got them all 3 backed out of 2.6.7-mm7 , but that doesn't change a
> > thing. The JVM still dies when I try to run eclipse.
>
> I can run Eclipse without any problems on 2.6.7-bk20-ck5 + few other not
> related patches. Maybe try using non -mm? Try 2.6.7-bk20 and then try
> reverting some patches. Maybe there is some other problem in -mm that
> gives similar results?
>

with plain 2.6.7-bk20 I see the issue, same with 2.6.7-mm7. Reverting
http://linux.bkbits.net:8080/linux-2.6/cset@1.1743 from -mm7 fixes the
issue. I'm currently building 2.6.7-bk20 minus that cset and I'll report
back on the results of that in a few minutes.

--
Jesper Juhl <juhl-lkml@dif.dk>
