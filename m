Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271501AbTGQPil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271508AbTGQPil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:38:41 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:38314 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271501AbTGQPik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:38:40 -0400
Date: Thu, 17 Jul 2003 17:52:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: John Bradford <john@grabjohn.com>
cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
In-Reply-To: <200307171558.h6HFwvju003135@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.GSO.4.21.0307171752040.10372-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, John Bradford wrote:
> > Another trick is the `IDE doubler' for Amiga (but I guess you can make it work
> > on any IDE interface): with a few diodes you can map the second bank of 8 IDE
> > registers to a second IDE chain, doubling the number of devices you can
> > attach.
> 
> Does Linux actually support that, (on any architecture)?

Yes, that's why there are tests for CONTROL_REG in the code in the first place.
Check out CONFIG_BLK_DEV_IDEDOUBLER in drivers/ide/.

> I was just imagining a RAID array on laptops which only have one IDE controller...

Cool ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

