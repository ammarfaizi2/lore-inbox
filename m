Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSKZMLn>; Tue, 26 Nov 2002 07:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSKZMLn>; Tue, 26 Nov 2002 07:11:43 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:45325 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264654AbSKZMLm>; Tue, 26 Nov 2002 07:11:42 -0500
Date: Tue, 26 Nov 2002 13:15:45 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dennis Grant <trog@wincom.net>, linux-kernel@vger.kernel.org
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
Message-ID: <20021126121545.GL29196@louise.pinerecords.com>
References: <3de2eee3.16fd.0@wincom.net> <20021126034900.GB29196@louise.pinerecords.com> <20021126121329.GI24796@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126121329.GI24796@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > /dev/hda:
> > > 
> > >  Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E106SZLE
> > >  Config={ Fixed }
> > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > >  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
> > >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60058656
> > >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> > >  DMA modes:  mdma0 mdma1 mdma2
> > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
> >...
> > This is weird.  Your disk seems to be set up for udma6 (UATA133),
> > which should provide for transfer rates of at least 40MiB/s.
> >...
> 
> The information in "hdparm -i" shows the identification info of the
> drive. It doesn't show whether DMA is actually used (you need
> "hdparm -v" for this)...

While this is true, I fail to see why the -i output would report
udma6 as being the current transfer mode instead of a pio one if
DMA were disabled.

-- 
Tomas Szepe <szepe@pinerecords.com>
