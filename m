Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSGIIED>; Tue, 9 Jul 2002 04:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSGIIEC>; Tue, 9 Jul 2002 04:04:02 -0400
Received: from jack.stev.org ([217.79.103.51]:54554 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S317334AbSGIIEB>;
	Tue, 9 Jul 2002 04:04:01 -0400
Message-ID: <016e01c22720$1be7ad80$0cfea8c0@ezdsp.com>
From: "James Stevenson" <mistral@stev.org>
To: <jbradford@dial.pipex.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200207090708.IAA00510@darkstar.example.net>
Subject: Re: ATAPI + cdwriter problem
Date: Tue, 9 Jul 2002 09:10:36 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > seems strange ide-scsi is the only thing i have ever had problems with.
> > i know it also does not work with the other 2 cd drives in the machine
as
> > well.
>
> On the same ATA controller?
>
> > 1 is an old HP 2x2x6 7200+ writer (writes ok reading problems)
> > and a normall 44x reader(will causes opps on reading bad media)
>
> That makes me strongly suspect at it it the ATA interface to blame.  Can
you try the CD-writer on another one?

the other 2 drives are on a different controller not a prmoise its running
off the motherboard.

its a via chipset motherboard which botht the old 2x writer and 44x are on
the secondary channel
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x41 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xc000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       DMA      UDMA
Address Setup:       30ns      30ns      60ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      90ns      30ns
Cycle Time:          60ns      60ns     180ns      60ns
Transfer Rate:   33.3MB/s  33.3MB/s  11.1MB/s  33.3MB/s

the whole ide system looks a bit like this.

hda: IBM-DTTA-351680, ATA DISK drive
hdb: IBM-DTLA-305040, ATA DISK drive
hdc: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive
hdd: IDE/ATAPI CD-ROM 44X, ATAPI CD/DVD-ROM drive
hde: Maxtor 4G160J8, ATA DISK drive
hdf: Maxtor 4G160J8, ATA DISK drive
hdg: 32X10, ATAPI CD/DVD-ROM drive

i have some time over the next few days so i could try to recreate crash
and try stuff.

> > > > i have  bunch of messages like these and a hung cd writer
> > > >
> > > > scsi : aborting command due to timeout : pid 28231, scsi0, channel
0, id
> > 2,
> > > > lun 0 Test Unit Ready 00 00 00 00 00
> > > > SCSI host 0 abort (pid 28231) timed out - resetting
> > > > SCSI bus is being reset for host 0 channel 0.
> > > > hdg: ATAPI reset timed-out, status=0xd0
> > > > PDC202XX: Secondary channel reset.
> > > > ide3: reset: success
> > > > hdg: irq timeout: status=0xc0 { Busy }
> > > > hdg: status timeout: status=0xd0 { Busy }
> > > > hdg: drive not ready for command
> > > >
> > > >
> > > > anyone be able to suggest any action to help prevent it in the
future ?
> > > >
> > > > thanks
> > > >     James
> > > >
> > > > --------------------------
> > > > Mobile: +44 07779080838
> > > > http://www.stev.org
> > > >   7:10pm  up 57 min,  3 users,  load average: 2.05, 1.84, 1.10


