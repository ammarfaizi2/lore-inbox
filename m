Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDSQPv>; Thu, 19 Apr 2001 12:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRDSQPm>; Thu, 19 Apr 2001 12:15:42 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:29569 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S131246AbRDSQPi>;
	Thu, 19 Apr 2001 12:15:38 -0400
Date: Thu, 19 Apr 2001 18:15:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Balazic <david.balazic@uni-mb.si>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ATA 100
Message-ID: <20010419181520.C1641@suse.cz>
In-Reply-To: <3ADEFA2B.2DCEAE41@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADEFA2B.2DCEAE41@uni-mb.si>; from david.balazic@uni-mb.si on Thu, Apr 19, 2001 at 04:46:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 04:46:03PM +0200, David Balazic wrote:

> Vojtech Pavlik (vojtech@suse.cz) wrote :
> 
> > On Wed, Apr 18, 2001 at 10:21:53PM -0400, Manuel Ignacio Monge Garcia wrote: 
> > 
> > > El Mié 18 Abr 2001 15:16, escribiste: 
> > > > I don't know about other possible problems with the kernel, but you must 
> > > > use an 80 wire IDE cable for UDMA66/100 to work. 
> > > > 
> > > > > -----------------------Primary IDE-------Secondary IDE------ 
> > > > > Cable Type: 40w 40w 
> > > 
> > > 
> > > Strange thing. With previous version of kernel (2.4.1 I think), I 
> > > haven't got this problem. May be a bios detection problem? 
> > > 
> > > Extract from /usr/src/linux/drivers/ide/via82cxxx..c: 
> > > 
> > > * 
> > > * PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-5 
> > > * 
> > > * (this includes UDMA33, 66 and 100) modes. UDMA66 and higher modes are 
> > > * autoenabled only in case the BIOS has detected a 80 wire cable. To ignore 
> > > * the BIOS data and assume the cable is present, use 'ide0=ata66' or 
> > > * 'ide1=ata66' on the kernel command line. 
> > > * 
> > > 
> > > I've tried with ide0=ata100, but this options doesn't work. 
> > 
> > Try ide0=ata66 instead. The option should have been named ide0=80wire, 
> > but, well, "ata66" was chosen as the name, because that was it at the 
> > time. 
> 
> Any chance of auto detecting this ?

None. It's different on each (pre-686b) VIA motherboard.

> I just hate when linux is relaying on the BIOS ...

We don't have any other chance here. Actually we'll have to rely on the
BIOS for even more in the next release of the driver to make it work on
all boards out there.

> BTW , why are there 666 CONFIG_.*IDE.*DMA.* switches ?

Ask Andre. :)

-- 
Vojtech Pavlik
SuSE Labs
