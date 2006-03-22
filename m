Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWCVRzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWCVRzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWCVRzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:55:46 -0500
Received: from rtr.ca ([64.26.128.89]:40345 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932260AbWCVRzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:55:45 -0500
Message-ID: <44218F95.9070301@rtr.ca>
Date: Wed, 22 Mar 2006 12:55:33 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: sander@humilis.net
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Mark Lord <liml@rtr.ca>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius>
In-Reply-To: <20060322170959.GA3222@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
>
> I've applied the patch against 2.6.16-git4. I'm sorry to say the
> messages are still there:

That's okay.  I have an alternate theory about those messages,
to be addressed in a later patch.

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
> Could the ata11/sdh message be bogus? I re-create the raid5 and fs every
> reboot.

Hard to tell.  It would be far more helpful if those messages included
info as to what was going on at the time.

Cheers
