Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTKFENR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 23:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTKFENQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 23:13:16 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7430 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263339AbTKFENN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 23:13:13 -0500
Date: Wed, 5 Nov 2003 20:11:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Steven Adams <steve@drifthost.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: no DRQ after issuing WRITE
In-Reply-To: <01ba01c3a3f7$1da22100$dfb21ad3@drifthost>
Message-ID: <Pine.LNX.4.10.10311052011140.28485-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It means DMA got disabled!

It also means improper exit from the FSM.

Andre Hedrick
LAD Storage Consulting Group

On Thu, 6 Nov 2003, Steven Adams wrote:

> anyone?
> ----- Original Message ----- 
> From: <steve@drifthost.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, November 05, 2003 2:05 PM
> Subject: hda: no DRQ after issuing WRITE
> 
> 
> > Hey guys,
> >
> > i keep getting things like this in my dmesg
> >
> > ============================================
> > hda: status timeout: status=0xd0 { Busy }
> >
> > hda: no DRQ after issuing WRITE
> > ide0: reset: success
> > hda: status timeout: status=0xd0 { Busy }
> >
> > hda: no DRQ after issuing WRITE
> > ide0: reset: success
> > =============================================
> >
> > From hdparm
> > ============================================
> > /dev/hda:
> >
> >  Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CBRJLA
> >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
> >  BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=off
> >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160836480
> >  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> >  DMA modes:  mdma0 mdma1 mdma2
> >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
> >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
> > =================================================
> >
> > Ive searched high and low to try find out what this means, all ive found
> > it people keep saying its all different kinds of things..
> >
> > I was wondering if this means my hdd is drying or is ti a setting?
> >
> > Thanks guys,
> > Steve
> >
> >
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

