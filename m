Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSKZM6Z>; Tue, 26 Nov 2002 07:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSKZM6Z>; Tue, 26 Nov 2002 07:58:25 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:54029 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265094AbSKZM6Y>; Tue, 26 Nov 2002 07:58:24 -0500
Date: Tue, 26 Nov 2002 14:05:38 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dennis Grant <trog@wincom.net>, linux-kernel@vger.kernel.org
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
Message-ID: <20021126130538.GM29196@louise.pinerecords.com>
References: <3de2eee3.16fd.0@wincom.net> <20021126034900.GB29196@louise.pinerecords.com> <20021126121329.GI24796@fs.tum.de> <20021126121545.GL29196@louise.pinerecords.com> <20021126124846.GK24796@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126124846.GK24796@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > /dev/hda:
> > > > > 
> > > > >  Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E106SZLE
> > > > >  Config={ Fixed }
> > > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > > >  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
> > > > >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60058656
> > > > >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > > > >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > > >  DMA modes:  mdma0 mdma1 mdma2
> > > > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
> > > >...
> > > > This is weird.  Your disk seems to be set up for udma6 (UATA133),
> > > > which should provide for transfer rates of at least 40MiB/s.
> > > >...
> > > 
> > > The information in "hdparm -i" shows the identification info of the
> > > drive. It doesn't show whether DMA is actually used (you need
> > > "hdparm -v" for this)...
> > 
> > While this is true, I fail to see why the -i output would report
> > udma6 as being the current transfer mode instead of a pio one if
> > DMA were disabled.
> 
> These were my thoughts until someone told me some time ago that this is
> wrong...
> 
> 1. "man hdparm" says: "-i Display the identification info that
>    was obtained from the drive at _boot time_", it doesn't give
>    information about the current state of the drive.
> 
> 2. Try to disable DMA using "hdparm -d0" (you can check it with
>    "hdparm -v") - the information displayed by "hdparm -i" won't
>    change.

Hmm, I wasn't aware of this.  The manpage confirms what you're saying
and adds that the information may or may not be reflecting the current
state.

However, Dennis's -I output also shows udma6 as the mode the drive is
in, and -I info -- according to the manual -- is obtained "directly
from the drive," which I read as "let's ask the drive what it's set
up like at this moment."

Dennis, could you possibly post the "hdparm -v" output too?

--
Tomas Szepe <szepe@pinerecords.com>
