Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135687AbRDSOqi>; Thu, 19 Apr 2001 10:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135688AbRDSOqU>; Thu, 19 Apr 2001 10:46:20 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:29704 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S135687AbRDSOqP>;
	Thu, 19 Apr 2001 10:46:15 -0400
Date: Thu, 19 Apr 2001 16:46:03 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: ATA 100
To: vojtech@suse.cz,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3ADEFA2B.2DCEAE41@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik (vojtech@suse.cz) wrote :

> On Wed, Apr 18, 2001 at 10:21:53PM -0400, Manuel Ignacio Monge Garcia wrote: 
> 
> > El Mié 18 Abr 2001 15:16, escribiste: 
> > > I don't know about other possible problems with the kernel, but you must 
> > > use an 80 wire IDE cable for UDMA66/100 to work. 
> > > 
> > > > -----------------------Primary IDE-------Secondary IDE------ 
> > > > Cable Type: 40w 40w 
> > 
> > 
> > Strange thing. With previous version of kernel (2.4.1 I think), I 
> > haven't got this problem. May be a bios detection problem? 
> > 
> > Extract from /usr/src/linux/drivers/ide/via82cxxx..c: 
> > 
> > * 
> > * PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-5 
> > * 
> > * (this includes UDMA33, 66 and 100) modes. UDMA66 and higher modes are 
> > * autoenabled only in case the BIOS has detected a 80 wire cable. To ignore 
> > * the BIOS data and assume the cable is present, use 'ide0=ata66' or 
> > * 'ide1=ata66' on the kernel command line. 
> > * 
> > 
> > I've tried with ide0=ata100, but this options doesn't work. 
> 
> Try ide0=ata66 instead. The option should have been named ide0=80wire, 
> but, well, "ata66" was chosen as the name, because that was it at the 
> time. 

Any chance of auto detecting this ?
I just hate when linux is relaying on the BIOS ...

BTW , why are there 666 CONFIG_.*IDE.*DMA.* switches ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
