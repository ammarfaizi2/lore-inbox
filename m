Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTH2QQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTH2QQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:16:18 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:63404 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261409AbTH2QPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:15:18 -0400
Date: Fri, 29 Aug 2003 18:15:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE wierdness
In-Reply-To: <1061394048.550.18.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0308291810150.3919-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2003, Alan Cox wrote:
> On Mer, 2003-08-20 at 16:09, Larry McVoy wrote:
> > It's clear to me that I don't want to use this drive but I'm wondering if
> > there is any interest in debugging the lock up.  I've only done it on
> > 2.4.18 as shipped by redhat but I could try 2.6 or whatever you like.
> > 
> > If the concensus is that it is OK that bad hardware locks you up then I'll
> > toss the drive and move on.
> 
> Some PIO transfers are regulated by the drive and the drive can lock the
> bus forever. Newer chipsets like the SI680/3112 support watchdog
> deadlock breakers for this but we don't really support them right now.
> 
> Getting different data off a failing drive is unusual because the blocks
> are ECC'd extensively (well more than ECC'd) and have checks, could be
> the RAM/CPU going I guess.

Although it can happen. I used to see corrupted data in /etc/motd (which is
rewritten on each boot up) and random SEGVs on an embedded box. A few weeks
later the drive started to report real errors. After mapping out the bad blocks
using e2fsck -c, and replacing the files that were affected, the problem
disappeared.

Looks like ECC is not always ECC...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

