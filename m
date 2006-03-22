Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWCVRxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWCVRxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCVRxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:53:10 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:33412 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932238AbWCVRxJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:53:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mkVQ5jzEW11UfAW+669C/Oo4oevsWNQoeoDvJNJNzPCV2rka6eD5W7eyuZU5a/xkgcHJ490j+BLxnTu3J31LxvSPs8ZEEZuHwgTFF4y+3VlAoBX2e181+syb740FXvGSEvIY4Rm8ajaYaHNnXBHr77ycIwpIIbc7LttmjFDAdYY=
Message-ID: <311601c90603220953t291fdb85w9f6d0fb299a00ab2@mail.gmail.com>
Date: Wed, 22 Mar 2006 10:53:07 -0700
From: "Eric D. Mudama" <edmudama@gmail.com>
To: sander@humilis.net
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Cc: "Mark Lord" <lkml@rtr.ca>, "Linus Torvalds" <torvalds@osdl.org>,
       "Jeff Garzik" <jeff@garzik.org>, "Mark Lord" <liml@rtr.ca>,
       "Andrew Morton" <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060322170959.GA3222@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060321121354.GB24977@favonius>
	 <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org>
	 <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca>
	 <20060322170959.GA3222@favonius>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Sander <sander@humilis.net> wrote:
> I've applied the patch against 2.6.16-git4. I'm sorry to say the
> messages are still there:
>
> [ 1038.536894] kjournald starting.  Commit interval 5 seconds
> [ 1038.555040] EXT3 FS on md0, internal journal
> [ 1038.555072] EXT3-fs: mounted filesystem with writeback data mode.
> [ 1418.639290] ata11: status=0x50 { DriveReady SeekComplete }
> [ 1418.639356] ata11: error=0x50 { UncorrectableError SectorIdNotFound }
> [ 1418.639418] sdh: Current: sense key=0x0
> [ 1418.639448]     ASC=0x0 ASCQ=0x0
> [ 1418.639481] Info fld=0x505050
> [ 1684.727367] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 1684.727420] ata9: status=0xd0 { Busy }
> [ 2223.664107] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2223.664162] ata6: status=0xd0 { Busy }
> [ 2381.589354] ata11: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2381.589416] ata11: status=0xd0 { Busy }
> [ 2511.238690] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2511.238753] ata9: status=0xd0 { Busy }
> [ 2990.792908] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2990.792960] ata7: status=0xd0 { Busy }
> [ 4672.691569] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 4672.691623] ata8: status=0xd0 { Busy }
> [ 4988.884663] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 4988.884717] ata6: status=0xd0 { Busy }
>
>
> Could the ata11/sdh message be bogus? I re-create the raid5 and fs every
> reboot.

What, exactly, is timing out?  How long is the timeout period?  The
ata11 seems bogus, 50/50/50 doesn't seem right.
