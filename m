Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130115AbRBZCAn>; Sun, 25 Feb 2001 21:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130114AbRBZCAd>; Sun, 25 Feb 2001 21:00:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:37125
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130112AbRBZCAZ>; Sun, 25 Feb 2001 21:00:25 -0500
Date: Sun, 25 Feb 2001 17:59:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Guest section DW <dwguest@win.tue.nl>,
        Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: partition table: chs question
In-Reply-To: <002201c09f87$5ce75640$f6976dcf@nwfs>
Message-ID: <Pine.LNX.4.10.10102251757550.27588-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It does not matter because the usage of CHS will dies soon because it was
voted to death in Austin last week.  There will only be LBA addressing
from now on out.

On Sun, 25 Feb 2001, Jeff V. Merkey wrote:

> 
> Please also check vger.timpanogas.org/nwfs/nwfs.tar.gz:disk.c for NetWare
> specific calculations of the CHS values, a different method is used for
> NetWare partitions vs. everything else (Novell just had to be different).
> If you do not  use their methods on NetWare partitions, NetWare will not
> recognize the partition entries correctly, and will attempt to reinitialize
> the entire partition table on a system if they are wrong (Ouch!).  NetWare
> does a different calculation for conversion of cylinder values above 1024.
> 
> Jeff
> 
> 
> ----- Original Message -----
> From: "Guest section DW" <dwguest@win.tue.nl>
> To: "Andreas Jellinghaus" <aj@dungeon.inka.de>;
> <linux-kernel@vger.kernel.org>
> Sent: Sunday, February 25, 2001 2:47 PM
> Subject: Re: partition table: chs question
> 
> 
> > On Sun, Feb 25, 2001 at 04:35:34PM +0100, Andreas Jellinghaus wrote:
> >
> > > for partitions not in the first 8gb of a harddisk, what
> > > should the c/h/s start and end value be ?
> > >
> > > most fdisks seem to set start and end to 255/63/1023.
> > > but partition magic creates partitions with start set to
> > > 0/1/1023 and end set to 255/63/1023, and detects a problem
> > > if start is set to 255/63/1023.
> > >
> > > so, how should a partition table look like ?
> >
> > Since these values will never be used you can imagine that they
> > are not of great interest. Do whatever you like.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

