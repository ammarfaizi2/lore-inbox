Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311560AbSCNIXn>; Thu, 14 Mar 2002 03:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311561AbSCNIXe>; Thu, 14 Mar 2002 03:23:34 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:41743 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311560AbSCNIXY>; Thu, 14 Mar 2002 03:23:24 -0500
Date: Thu, 14 Mar 2002 09:23:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Daniela Engert <dani@ngrt.de>, LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <martin@dalecki.de>, Shawn Starr <spstarr@sh0n.net>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314092322.A32260@ucw.cz>
In-Reply-To: <20020314083038.A31923@ucw.cz> <20020314063843.E0E3210921@mail.medav.de> <20020314091808.B31998@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314091808.B31998@ucw.cz>; from vojtech@suse.cz on Thu, Mar 14, 2002 at 09:18:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 09:18:08AM +0100, Vojtech Pavlik wrote:
> On Thu, Mar 14, 2002 at 08:44:42AM +0100, Daniela Engert wrote:
> 
> > The PIIX3 bug is real, I have several user reports about it!
> 
> Thanks A LOT for the tables, added are some comments from me ...
> 
> >  Vendor
> >  | Device
> >  | | Revision			       ATA	ATAPI	     ATA66  ATA133
> >  | | | south/host bridge id	     PIO  DMA  PIO  DMA  ATA33 | ATA100|   Docs
> >  | | | | south/host bridge rev.     32bit  |  32bit  |	   |   |   |   |  avail
> >  | | | | |			      |    |	|    |	   |   |   |   |    |
> >  v v v v v			      v    v	v    v	   v   v   v   v    v
> > 
> >  0x8086 Intel
> >    0x1230 PIIX		      x    x	x    x	   -   -   -   -    x
> >      < 02			      x    -	x    -	   -   -   -   -    x
> 
> I suppose this means on PIIXes with rev 00 and 01 of the IDE controller
> DMA transfers don't work reliably, right?
> 
> >        0x84C4 Orion
> > 	 < 04			      x    -	x    -	   -   -   -   -    x
> 
> And this means that if there is an 84c4 PCI bridge in the system with
> rev less than 04 (04 is OK), then DMA transfers are broken again.

And there is one more Intel chip:

0x1234, the infamous MPIIX. Can do PIO only, 32 bit is OK, has a single
channel switchable to primary or secondary, IDETIM is located in
registers 6C-6D on the ISA bridge. Docs available.

-- 
Vojtech Pavlik
SuSE Labs
