Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSC1Aay>; Wed, 27 Mar 2002 19:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSC1Aao>; Wed, 27 Mar 2002 19:30:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13830
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310917AbSC1Aaf>; Wed, 27 Mar 2002 19:30:35 -0500
Date: Wed, 27 Mar 2002 16:30:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: James Mayer <james.mayer@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
In-Reply-To: <20020328002123.GA10950@archimedes>
Message-ID: <Pine.LNX.4.10.10203271628310.6006-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, James Mayer wrote:

> On Thu, Mar 28, 2002 at 12:04:33AM +0000, Alan Cox wrote:
> > > After adding printk calls to alim15x3.c, it seems to hang during the
> > > pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02) call on line 588.
> > 
> > Does it work if you comemtn that line out ?
> 
> No, if the line is commented out I get:
> 
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hda: drive not ready for command

Translation the HOST is not setup and the enable hooks are broken.
If you write to those bits it will tank the controller, and that is as
much as I can come forward on at this point.  This is appears to be
exclusive to the TransMeta based NorthBridge + ALI south bridge.

Regards,

Andre Hedrick
LAD Storage Consulting Group

