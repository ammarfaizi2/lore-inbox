Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTANVLg>; Tue, 14 Jan 2003 16:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTANVLf>; Tue, 14 Jan 2003 16:11:35 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2311 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265275AbTANVLe>; Tue, 14 Jan 2003 16:11:34 -0500
Date: Tue, 14 Jan 2003 13:17:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ross Biro <rossb@google.com>, Alan Cox <alan@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
In-Reply-To: <1042566769.587.69.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10301141316200.23438-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ben, just because there does not appear to be a race in the code, does not
provide any information about the hardware.

On 14 Jan 2003, Benjamin Herrenschmidt wrote:

> On Tue, 2003-01-14 at 18:49, Ross Biro wrote:
> > Benjamin Herrenschmidt wrote:
> > 
> > >Ok, but PIIX runs on intel platforms with real IOs, so there is no need
> > >to perform a read... If we go the hwif->IOSYNC() way, we might well set
> > >it up to no-op on x86 PIO iops by default and read of alt-status on
> > >other archs if it's safe enough on other controllers/drives...
> > >
> > I believe that this will corrupt any inprogress UDMA transfer on the 
> > promise 20265 chip and probably others.  It would be better to read the 
> > dma registers for the Promise controllers.
> 
> You mean on the chip's other channel ? As we discussed earlier, we don't
> need to enforce this delay at all for DMA as we wait for the DMA
> controller to complete in the interrupt anyway. Or did I miss a race ?
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

