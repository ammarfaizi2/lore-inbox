Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129424AbRB0RQu>; Tue, 27 Feb 2001 12:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRB0RQb>; Tue, 27 Feb 2001 12:16:31 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:31482 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129424AbRB0RQS>; Tue, 27 Feb 2001 12:16:18 -0500
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <Pine.LNX.4.10.10102271153560.29323-100000@coffee.psychology.mcmaster.ca>
From: Camm Maguire <camm@enhanced.com>
Date: 27 Feb 2001 12:16:09 -0500
In-Reply-To: Mark Hahn's message of "Tue, 27 Feb 2001 11:55:11 -0500 (EST)"
Message-ID: <547l2c2giu.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thanks for your reply!

Mark Hahn <hahn@coffee.psychology.mcmaster.ca> writes:

> > Greetings!  Two ide tapes, both on second ide channel, both using
> 
> mixing devices from different vendors on the same channel
> often gives this kind of problem.  sticking in even a cheap
> PCI ide controller would pretty dramatically improve your 
> system (since you could put one device on each channel).
> 
> 

Good advice, but the problem persists even when the offending drive is
alone on the secondary ide channel.  In fact, this the configuration
in which I first came upon the problem.  I installed the second drive
later, and when that worked, I suspected a model-specific bug in the
driver. 

One gets an analogous kernel error when using the straight ide-tape
driver.  

Take care,

> 
> > ide-scsi.  One works perfectly, the other basically works, but gives
> > errors, and occasionally doesn't write full 32k blocks to tape,
> > causing amanda errors. 
> > 
> > Feb 25 06:14:22 intech9 kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
> > Feb 25 06:14:22 intech9 kernel: ALI15X3: not 100%% native mode: will probe irqs later
> > Feb 25 06:14:22 intech9 kernel:     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
> > Feb 25 06:14:22 intech9 kernel: 
> > Feb 25 06:14:22 intech9 kernel: ************************************
> > Feb 25 06:14:22 intech9 kernel: *    ALi IDE driver (1.0 beta3)    *
> > Feb 25 06:14:22 intech9 kernel: *       Chip Revision is C1        *
> > Feb 25 06:14:22 intech9 kernel: *  Maximum capability is - UDMA 33 *
> > Feb 25 06:14:22 intech9 kernel: ************************************
> > Feb 25 06:14:22 intech9 kernel: 
> > Feb 25 06:14:22 intech9 kernel:     ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
> > Feb 25 06:14:22 intech9 kernel: hda: FUJITSU MPE3064AT, ATA DISK drive
> > Feb 25 06:14:22 intech9 kernel: hdb: ST32140A, ATA DISK drive
> > Feb 25 06:14:22 intech9 kernel: hdc: CONNER CTT8000-A, ATAPI TAPE drive
> > Feb 25 06:14:22 intech9 kernel: hdd: HP COLORADO 14GB, ATAPI TAPE drive
> > Feb 25 06:14:22 intech9 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > Feb 25 06:14:22 intech9 kernel: ide1 at 0x170-0x177,0x376 on irq 15
> > Feb 25 06:14:22 intech9 kernel:  ALI15X3: Ultra DMA enabled
> > Feb 25 06:14:22 intech9 kernel: hda: FUJITSU MPE3064AT, 6187MB w/512kB Cache, CHS=788/255/63, (U)DMA
> > Feb 25 06:14:22 intech9 kernel:  ALI15X3: MultiWord DMA enabled
> > Feb 25 06:14:22 intech9 kernel: hdb: ST32140A, 2015MB w/128kB Cache, CHS=4095/16/63, DMA
> > Feb 25 06:14:22 intech9 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> > Feb 25 06:14:22 intech9 kernel:  hdb: hdb1 hdb2
> > 
> > The Conner gives the problem:
> > 
> > Feb 27 06:23:16 intech9 kernel: st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> > Feb 27 06:23:16 intech9 kernel: ASC=20 ASCQ= 0
> > Feb 27 06:23:16 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 
> > 
> > and occaisional 'gunzip: unexpected end of file' errors on verifying
> > the tape.
> > 
> > Take care,
> > 
> > 
> > 
> 
> -- 
> operator may differ from spokesperson.	            hahn@coffee.mcmaster.ca
>                                               http://java.mcmaster.ca/~hahn
> 
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
