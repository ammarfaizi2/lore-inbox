Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSHXUYx>; Sat, 24 Aug 2002 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSHXUYx>; Sat, 24 Aug 2002 16:24:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26378
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316677AbSHXUYw>; Sat, 24 Aug 2002 16:24:52 -0400
Date: Sat, 24 Aug 2002 13:22:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: M?ns Rullg?rd <mru@users.sourceforge.net>, barrie_spence@agilent.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
In-Reply-To: <20020824094847.GV14278@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10208241322160.20141-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not ignore just overloaded with trying to keep up w/ Alan.

On Sat, 24 Aug 2002, Tomas Szepe wrote:

> > > I'm running 2.4.19 with a Promise TX2 Ultra133, but even though the
> > > card BIOS reports UDMA mode 5/6 on the drives, they are reported as
> > > UDMA33 by the kernel.
> > > 
> > > Trying hdparm -X69 after boot gives the message "Speed warnings UDMA
> > > 3/4/5 is not functional."
> > 
> > I was waiting for this.  As I have pointed out several times before,
> > there needs to be added a line
> > 
> >     hwif->udma_four = 1;
> > 
> > at the appropriate place in pdc202xx.c.  I don't know where it should
> > be, so I can't write a patch.
> 
> Andre Hedrick pretty much ignored both of my posts on the issue.
> 
> Anyway, how does ide_init_pdc202xx() look to you (line 1141 in 2.4.20-pre4)?
> There's this "switch (hwif->pci_dev->device)" which would seem to me to be the
> proper place.
> 
> T.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

