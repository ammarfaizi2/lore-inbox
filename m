Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTJSUqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJSUqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:46:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:54183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262158AbTJSUq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:46:28 -0400
Date: Sun, 19 Oct 2003 22:46:26 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, bkz@linux-ide.org
MIME-Version: 1.0
References: <Pine.LNX.4.10.10310191329150.15306-100000@master.linux-ide.org>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <7755.1066596386@www23.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You do not enable TCQ on highpoint without using the hosted polling timer.
> Oh and I have not added it, and so hit Bartlomiej up for the additions.

good info :-)

but it sometimes seems to enable it

the 4 drives are identical,
and the drive failing is almost always different

and this doesn't explain the md/ lvm corupption,
even when TCQ is not enabled both in 2.4 and 2.5
 
/dev/hda:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       IC35L080AVVA07-0
        Serial Number:      VNC402A4CVHNEA
        Firmware Revision:  VA4OA52A
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 1
        Supported: 5 4 3 2 & some of 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  160836480
        device size with M = 1024*1024:       78533 MBytes
        device size with M = 1000*1000:       82348 MBytes (82 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 52     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                Release interrupt
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
.................................................................
           *    READ/WRITE DMA QUEUED
...................................................................

> > i have the same problems with epox 8k9a3+,
> > and may be even strange ones
> > (like fs coruption when soft raid & / or lvm is used)
> > 
> > and i never had the problems with 8k5a3+,
> > the drives were actually taken from the 8k5a3+
> > when it died (me silly tried to update to XP2700)
> > 
> > really strange, isn't it
> > 
> > both boards should be the same, except
> > 8k5a3+ uses kt333
> > 8k9a3+ uses kt400
> > 
> > only mainboard change -> hell of a lot unresolved problems
> > 
> > 
> > svetljo
> > kernels used 2.4.21-2.4.23-pre3 2.6.0-test3-test7bk8
> > 
> > and a nice log when i try to enable TCQ
> > 
> > all Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> > [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> > Badness in as_remove_dispatched_request at
> drivers/block/as-iosched.c:102
> 2
> > Call Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> > [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> > Badness in as_remove_dispatched_request at
> drivers/block/as-iosched.c:102
> 2
> > Call Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> > [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> > Badness in as_remove_dispatched_request at
> drivers/block/as-iosched.c:102
> 2
> > Call Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> > [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> > 
> > 
> > -- 
> > NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
> > Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService
> > 
> > Jetzt kostenlos anmelden unter http://www.gmx.net
> > 
> > +++ GMX - die erste Adresse für Mail, Message, More! +++
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> i
> n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

