Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135574AbRDSGnU>; Thu, 19 Apr 2001 02:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbRDSGnK>; Thu, 19 Apr 2001 02:43:10 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:43904 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S135574AbRDSGm5>;
	Thu, 19 Apr 2001 02:42:57 -0400
Date: Thu, 19 Apr 2001 08:42:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Manuel Ignacio Monge Garcia <ignaciomonge@navegalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATA 100 & VIA and linux-2.4.3ac8
Message-ID: <20010419084250.A689@suse.cz>
In-Reply-To: <01041820505300.01783@localhost.localdomain> <3ADDE820.2050103@texoma.net> <01041822215300.01341@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041822215300.01341@localhost.localdomain>; from ignaciomonge@navegalia.com on Wed, Apr 18, 2001 at 10:21:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 10:21:53PM -0400, Manuel Ignacio Monge Garcia wrote:

> El Mié 18 Abr 2001 15:16, escribiste:
> > I don't know about other possible problems with the kernel, but you must
> > use an 80 wire IDE cable for UDMA66/100 to work.
> >
> > > -----------------------Primary IDE-------Secondary IDE------
> > > Cable Type:                   40w                 40w
> 
> 
>         Strange thing. With previous version of kernel (2.4.1 I think), I 
> haven't  got this problem. May be a bios detection problem?
> 
> Extract from /usr/src/linux/drivers/ide/via82cxxx..c:
> 
> *
> *   PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-5
> *
> * (this includes UDMA33, 66 and 100) modes. UDMA66 and higher modes are
> * autoenabled only in case the BIOS has detected a 80 wire cable. To ignore
> * the BIOS data and assume the cable is present, use 'ide0=ata66' or
> * 'ide1=ata66' on the kernel command line.
> *
> 
> I've tried with ide0=ata100, but this options doesn't work.

Try ide0=ata66 instead. The option should have been named ide0=80wire,
but, well, "ata66" was chosen as the name, because that was it at the
time.

-- 
Vojtech Pavlik
SuSE Labs
