Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSLZNOR>; Thu, 26 Dec 2002 08:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSLZNOR>; Thu, 26 Dec 2002 08:14:17 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:32168 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261456AbSLZNOQ>; Thu, 26 Dec 2002 08:14:16 -0500
Date: Thu, 26 Dec 2002 14:22:28 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
Cc: Mikael Olenfalk <mikael@netgineers.se>, linux-kernel@vger.kernel.org
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
Message-ID: <20021226132228.GE7348@louise.pinerecords.com>
References: <1040815160.533.6.camel@devcon-x> <20021225115820.GB7348@louise.pinerecords.com> <20021226123710.GA2442@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021226123710.GA2442@iapetus.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 25, 2002 at 12:58:20PM +0100, Tomas Szepe wrote:
> > > For some funny reason, a 2.4.20 kernel refuses to set the DMA-level on
> > > the new disks (all connected to a UDMA5-capable Ultra100 TX2 controller)
> > > to UDMA5,4,3 and settles it for UDMA2, which is the highest possibility
> > > for the OLD onboard-controller (but NOT for the promise card).
> > 
> > You need to boot 2.4.19 and 2.4.20 with 'ideX=ata66' where X is the
> > number of the channel where you wish to use transfer modes above UDMA2.
> > For instance, "ide0=ata66 ide1=ata66" will do the trick for the first two
> 
> hdparm -X69 /dev/hda will put it into UDMA5/ata100 mode as well
> (69 == 64 + UDMA mode). No need to specify it at boot time.

Not true.  You definitely need to use the ideX boot param AND
run hdparm -X?? /dev/hd? to make use of UDMA3+ on newer PDC
controllers (unless you apply the patch posted on Dec 24 by
Nikolai Zhubr).

-- 
Tomas Szepe <szepe@pinerecords.com>
