Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSHXJsV>; Sat, 24 Aug 2002 05:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSHXJsU>; Sat, 24 Aug 2002 05:48:20 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:26129 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315458AbSHXJsU>; Sat, 24 Aug 2002 05:48:20 -0400
Date: Sat, 24 Aug 2002 11:48:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: barrie_spence@agilent.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
Message-ID: <20020824094847.GV14278@louise.pinerecords.com>
References: <C12D24916888D311BC790090275414BB0B724742@oberon.britain.agilent.com> <yw1xvg60liua.fsf@storstrut.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xvg60liua.fsf@storstrut.e.kth.se>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 80 days, 1:31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm running 2.4.19 with a Promise TX2 Ultra133, but even though the
> > card BIOS reports UDMA mode 5/6 on the drives, they are reported as
> > UDMA33 by the kernel.
> > 
> > Trying hdparm -X69 after boot gives the message "Speed warnings UDMA
> > 3/4/5 is not functional."
> 
> I was waiting for this.  As I have pointed out several times before,
> there needs to be added a line
> 
>     hwif->udma_four = 1;
> 
> at the appropriate place in pdc202xx.c.  I don't know where it should
> be, so I can't write a patch.

Andre Hedrick pretty much ignored both of my posts on the issue.

Anyway, how does ide_init_pdc202xx() look to you (line 1141 in 2.4.20-pre4)?
There's this "switch (hwif->pci_dev->device)" which would seem to me to be the
proper place.

T.
