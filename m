Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132017AbRAMUBl>; Sat, 13 Jan 2001 15:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRAMUBc>; Sat, 13 Jan 2001 15:01:32 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36875
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132017AbRAMUBX>; Sat, 13 Jan 2001 15:01:23 -0500
Date: Sat, 13 Jan 2001 12:00:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <E14HWdQ-0006VF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101131156060.3339-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


COOL!

This will kill the VIA problem and allow us to clobber the timeout.
I know where and what to do but it is the how with the current mess of the
driver held togather with duct tape and paper clips and a little bit of
spit here and there.

I can not wait for 2.5 to get started to begin with "rm -rf ./drivers/ide"
and start with "mkdir ./drivers/ata" ;-))  Okay not quite that radical but
very close....

On Sat, 13 Jan 2001, Alan Cox wrote:

> >  		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_SIS5513) ||
> >  		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
> >  		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PIIX4NX) ||
> > -		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X))
> > +		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X)  ||
> > +		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VIA_IDE) ||
> > +		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VP_IDE))
> >  			autodma = 0;
> >  		if (autodma)
> >  			hwif->autodma = 1;
> 
> How about
> 
> 		    && !force_dma)
> 
> 
> __setup("force_dma") ...
> 
> So those who want to play fast can
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
