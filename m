Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTD2UH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTD2UH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:07:27 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18705
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261661AbTD2UH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:07:26 -0400
Date: Tue, 29 Apr 2003 13:15:15 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tabris <tabris@sbcglobal.net>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
In-Reply-To: <200304282234.59745.tabris@sbcglobal.net>
Message-ID: <Pine.LNX.4.10.10304291301150.20264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Promise chipset use a second DMA engine at offset 0x24 respective of
the channel.  Mixing an ATA and ATAPI on that channel is almost impossible
to make the corner cases work.  Next, if there us a 48-bit ATA plus ATAPI
on the channel popping between the two enignes does not look sane at all
because one has to swithc the location of the hwif->sgtable.

On Mon, 28 Apr 2003, Tabris wrote:

> On Monday 28 April 2003 09:58 pm, Andre Hedrick wrote:
> > NO ATAPI DMA!
> >
> > I will not write the driver core to attempt to support the various
> > combinations.  The ATAPI DMA engine space is used support 48bit.
> > Use the onboard controller for ATAPI.
> > Andre Hedrick
> > LAD Storage Consulting Group
> 
> Can I object that it came built onto the board? okok... i'll take that 
> as a no for now...
> 
> Tho i'm still not quite sure how it makes a diff to be honest, unless 
> you mean that the Promise and HPT will never be supported for DMA?
> 
> and the only other thing i should say is that altho i'm not exactly a 
> n00b, the average user WILL expect it to work.
> 
> can i expect this to be fixed by 2.6? (yeah, i know... 2.4-ac-ide code 
> is similar to 2.5-ide code)
> --
> tabris
> 

Andre Hedrick
LAD Storage Consulting Group

