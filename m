Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSGIKUg>; Tue, 9 Jul 2002 06:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSGIKUf>; Tue, 9 Jul 2002 06:20:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1448 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S313698AbSGIKUc>; Tue, 9 Jul 2002 06:20:32 -0400
Date: Tue, 9 Jul 2002 12:22:59 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <jbradford@dial.pipex.com>
cc: James Stevenson <mistral@stev.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI + cdwriter problem
In-Reply-To: <200207090941.KAA00806@darkstar.example.net>
Message-ID: <Pine.SOL.4.30.0207091218350.6859-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002 jbradford@dial.pipex.com wrote:
> Hi,
>
> > the other 2 drives are on a different controller not a prmoise its running
> > off the motherboard.
>
> Odd, I was positive you were going to say it was the Promise controller to blame :-)
>
> > its a via chipset motherboard which botht the old 2x writer and 44x are on
> > the secondary channel
> > the whole ide system looks a bit like this.
> > hda: IBM-DTTA-351680, ATA DISK drive
> > hdb: IBM-DTLA-305040, ATA DISK drive
> > hdc: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive
> > hdd: IDE/ATAPI CD-ROM 44X, ATAPI CD/DVD-ROM drive
> > hde: Maxtor 4G160J8, ATA DISK drive
> > hdf: Maxtor 4G160J8, ATA DISK drive
> > hdg: 32X10, ATAPI CD/DVD-ROM drive
>
> Can't see anything obviously wrong with that setup, but once you get the new CD-writer working, I'd re-arrange things like this:
>
> hda: IBM-DTTA-351680, ATA DISK drive
> hdb: IBM-DTLA-305040, ATA DISK drive
> hdc: 32X10, ATAPI CD/DVD-ROM drive
> hdd: IDE/ATAPI CD-ROM 44X, ATAPI CD/DVD-ROM drive
> hde: Maxtor 4G160J8, ATA DISK drive
> hdf: Maxtor 4G160J8, ATA DISK drive
> not connected: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive
>
> Unless you really need 2 CD-Writers available, (in which case, I would suggest moving over to SCSI anyway).

Dont punish performance and do not connect drives on the same channel
if you can, the same goes for cd and cdrw (if cd -> cdrw of course)...

Also there was some problem recently with running 2 ATAPI devices on the
same channel.

>
> Then you are only using 3 interfaces, and not 4, (which seems 'neater' to me, but you might dis-agree).  I don't think you're likely to see much performace advantage to having the CD-writer on the Promise card, to be honest.  You probably will for the Maxtor, (good choice), hard drives, though.
>
> > i have some time over the next few days so i could try to recreate crash
> > and try stuff.
>
> That might help, as I can't think of anything else to suggest off hand.
>
> John.

Regards
--
Bartlomiej

