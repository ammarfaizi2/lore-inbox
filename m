Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbTGIWhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbTGIWhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:37:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54194 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268678AbTGIWhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:37:09 -0400
Date: Thu, 10 Jul 2003 00:51:18 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
In-Reply-To: <Pine.LNX.4.44.0307091520570.16947-100000@home.osdl.org>
Message-ID: <Pine.SOL.4.30.0307100037140.6581-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jul 2003, Linus Torvalds wrote:

> On Wed, 9 Jul 2003, Jeff Garzik wrote:
> >
> > I'm curious where interrupts are re-enabled, though?
>
> The low-level drivers seem to do it at every IO. Don't ask me why. But it
> gets done automatically by any code that does
>
> 	hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
>
> which is pretty common (just grep for "IDE_CONTROL_REG" and you'll see
> what I mean).
>
> I note that I should have made this "disable irq" be dependent on
> IDE_CONTROL_REG being non-zero. Although I don't see when that register
> _can_ be zero, it would be a major bummer not to have access to the
> control register.
>
> (Obviously it must be zero for some architecture, though, or those
> conditionals woulnd't make sense. Alan?  Bartlomiej? What kind of sick
> pseudo-IDE controller doesn't have a control register?).

Amiga X-Surf and Amiga Gayle with IDE doubler...
--
Bartlomiej

> 			Linus

