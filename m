Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSHZJ4S>; Mon, 26 Aug 2002 05:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHZJ4S>; Mon, 26 Aug 2002 05:56:18 -0400
Received: from msgbas1x.net.europe.agilent.com ([192.25.19.109]:65023 "EHLO
	msgbas1.net.europe.agilent.com") by vger.kernel.org with ESMTP
	id <S318017AbSHZJ4R>; Mon, 26 Aug 2002 05:56:17 -0400
Message-ID: <C12D24916888D311BC790090275414BB0B724755@oberon.britain.agilent.com>
From: barrie_spence@agilent.com
To: andre@linux-ide.org, szepe@pinerecords.com
Cc: mru@users.sourceforge.net, barrie_spence@agilent.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: RE: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
Date: Mon, 26 Aug 2002 12:00:21 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already tried "ideX=ata66" with no effect and they are definitely 80 pin cables (I thought the driver would complain if they weren't).

Barrie

-----Original Message-----
From: Andre Hedrick [mailto:andre@linux-ide.org]
Sent: 24 August 2002 21:23
To: Tomas Szepe
Cc: M?ns Rullg?rd; barrie_spence@agilent.com;
linux-kernel@vger.kernel.org; Alan Cox
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33



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
