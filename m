Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTDOIBz (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTDOIBz (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:01:55 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:64900 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S264391AbTDOIBy (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:01:54 -0400
Date: Tue, 15 Apr 2003 10:11:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <20030415044505.GA25139@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0304151010240.26578-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, Jamie Lokier wrote:
> Geert Uytterhoeven wrote:
> > > Since __ide_mm_insw doesn't get told whether it is transferring normal
> > > sector data or drive ID data, it can't necessarily do the right thing
> > > in both situations.
> > 
> > Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
> > on-disk data to be that way, for compatibility with e.g. TOS.
> 
> Isn't that best solved in the TOS filesystem code?

There's also a partition table to read. BTW, Atari uses MS-DOS style
partitioning.

> That way, Ataris running Linux can read ext2 disks from other systems
> properly, and other systems can read TOS disks written by Ataris
> properly.

That's why there's also an option to swap all diskdata at the IDE level, so you
can take your Atari disks to a PC and vice versa.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

