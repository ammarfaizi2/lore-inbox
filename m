Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129554AbRB0QIX>; Tue, 27 Feb 2001 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRB0QIN>; Tue, 27 Feb 2001 11:08:13 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:30457 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129537AbRB0QH6>; Tue, 27 Feb 2001 11:07:58 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 IDE tape problem, with ide-scsi
From: Camm Maguire <camm@enhanced.com>
Date: 27 Feb 2001 11:06:34 -0500
In-Reply-To: jerry's message of "Mon, 26 Feb 2001 15:06:13 -0500"
Message-ID: <54u25g3yb9.fsf_-_@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!  Two ide tapes, both on second ide channel, both using
ide-scsi.  One works perfectly, the other basically works, but gives
errors, and occasionally doesn't write full 32k blocks to tape,
causing amanda errors. 

Feb 25 06:14:22 intech9 kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
Feb 25 06:14:22 intech9 kernel: ALI15X3: not 100%% native mode: will probe irqs later
Feb 25 06:14:22 intech9 kernel:     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
Feb 25 06:14:22 intech9 kernel: 
Feb 25 06:14:22 intech9 kernel: ************************************
Feb 25 06:14:22 intech9 kernel: *    ALi IDE driver (1.0 beta3)    *
Feb 25 06:14:22 intech9 kernel: *       Chip Revision is C1        *
Feb 25 06:14:22 intech9 kernel: *  Maximum capability is - UDMA 33 *
Feb 25 06:14:22 intech9 kernel: ************************************
Feb 25 06:14:22 intech9 kernel: 
Feb 25 06:14:22 intech9 kernel:     ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
Feb 25 06:14:22 intech9 kernel: hda: FUJITSU MPE3064AT, ATA DISK drive
Feb 25 06:14:22 intech9 kernel: hdb: ST32140A, ATA DISK drive
Feb 25 06:14:22 intech9 kernel: hdc: CONNER CTT8000-A, ATAPI TAPE drive
Feb 25 06:14:22 intech9 kernel: hdd: HP COLORADO 14GB, ATAPI TAPE drive
Feb 25 06:14:22 intech9 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 25 06:14:22 intech9 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 25 06:14:22 intech9 kernel:  ALI15X3: Ultra DMA enabled
Feb 25 06:14:22 intech9 kernel: hda: FUJITSU MPE3064AT, 6187MB w/512kB Cache, CHS=788/255/63, (U)DMA
Feb 25 06:14:22 intech9 kernel:  ALI15X3: MultiWord DMA enabled
Feb 25 06:14:22 intech9 kernel: hdb: ST32140A, 2015MB w/128kB Cache, CHS=4095/16/63, DMA
Feb 25 06:14:22 intech9 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Feb 25 06:14:22 intech9 kernel:  hdb: hdb1 hdb2

The Conner gives the problem:

Feb 27 06:23:16 intech9 kernel: st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
Feb 27 06:23:16 intech9 kernel: ASC=20 ASCQ= 0
Feb 27 06:23:16 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 

and occaisional 'gunzip: unexpected end of file' errors on verifying
the tape.

Take care,


-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
