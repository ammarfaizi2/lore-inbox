Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUJQCTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUJQCTa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUJQCTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:19:06 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:52609 "EHLO
	beast.stev.org") by vger.kernel.org with ESMTP id S269001AbUJQCSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:18:54 -0400
Date: Sun, 17 Oct 2004 03:51:36 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Ian Pilcher <i.pilcher@comcast.net>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>,
       James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
In-Reply-To: <58cb370e04101412312fc42a57@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0410170347430.3660-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i did actually kind of get the card's working together but ran into
another problem.

when i boot with ide=nodma and then turn on dma manually on all the other 
cards / board chipset etc... they all function fine

then i can only turn the dma up to ATA/100 if i set it to ata/133 it will
cause the errors. I assume this is something todo with the promise bois
not setting up the 3rd card at boot time. It only shows drive listing for 
2 of the 3 cards.

Unfortunatly this generated another problem.
When read from both drives at the same time it functions normally and
see resonable performance. When i attempt to write to both drives it will
cause the machine to lockup.


	James

On Thu, 14 Oct 2004, Bartlomiej Zolnierkiewicz wrote:

> On Thu, 14 Oct 2004 13:12:42 -0500, Ian Pilcher <i.pilcher@comcast.net> wrote:
> > James Stevenson wrote:
> > >
> > > i seem to have run into an annoying problem with a machine which has
> > > 3 promise ata/133 card the PDC20269 type.
> > >
> > 
> > ....
> > 
> > >
> > > Does anyone have an explenation of why this can happen ?
> 
> * check power supply
> * compare PCI config space of the "failing" controller to the one which
>   is "working" (assuming that identical devices are connected to each),
>   maybe firmware/driver forgets to setup some settings
> 
> > Promise cards don't support more than two per machine.  If you can get a
> > third card to work in PIO mode, consider it an added (but unsupported)
> > bonus.
> 
> AFAIR people have been running 4-5 cards just fine
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
  3:40am  up 12:22,  1 user,  load average: 0.00, 0.00, 0.00

