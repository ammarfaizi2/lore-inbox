Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSKZMlf>; Tue, 26 Nov 2002 07:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbSKZMlf>; Tue, 26 Nov 2002 07:41:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54753 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264818AbSKZMle>; Tue, 26 Nov 2002 07:41:34 -0500
Date: Tue, 26 Nov 2002 13:48:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Dennis Grant <trog@wincom.net>, linux-kernel@vger.kernel.org
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
Message-ID: <20021126124846.GK24796@fs.tum.de>
References: <3de2eee3.16fd.0@wincom.net> <20021126034900.GB29196@louise.pinerecords.com> <20021126121329.GI24796@fs.tum.de> <20021126121545.GL29196@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126121545.GL29196@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 01:15:45PM +0100, Tomas Szepe wrote:

> > > > /dev/hda:
> > > > 
> > > >  Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E106SZLE
> > > >  Config={ Fixed }
> > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > >  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
> > > >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60058656
> > > >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > > >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > >  DMA modes:  mdma0 mdma1 mdma2
> > > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
> > >...
> > > This is weird.  Your disk seems to be set up for udma6 (UATA133),
> > > which should provide for transfer rates of at least 40MiB/s.
> > >...
> > 
> > The information in "hdparm -i" shows the identification info of the
> > drive. It doesn't show whether DMA is actually used (you need
> > "hdparm -v" for this)...
> 
> While this is true, I fail to see why the -i output would report
> udma6 as being the current transfer mode instead of a pio one if
> DMA were disabled.

These were my thoughts until someone told me some time ago that this is
wrong...

1. "man hdparm" says: "-i Display the identification info that
   was obtained from the drive at _boot time_", it doesn't give
   information about the current state of the drive.

2. Try to disable DMA using "hdparm -d0" (you can check it with
   "hdparm -v") - the information displayed by "hdparm -i" won't
   change.

> Tomas Szepe <szepe@pinerecords.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

