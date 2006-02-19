Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWBSRQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWBSRQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBSRQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:16:49 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:54646 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932166AbWBSRQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:16:48 -0500
Date: Sun, 19 Feb 2006 18:16:51 +0100
From: Sander <sander@humilis.net>
To: Mark Lord <lkml@rtr.ca>
Cc: sander@humilis.net, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
Message-ID: <20060219171651.GA8986@favonius>
Reply-To: sander@humilis.net
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca> <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca> <20060218204340.GA2984@favonius> <43F794D8.7000406@rtr.ca> <20060219071414.GA31299@favonius> <43F88F30.1070208@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F88F30.1070208@rtr.ca>
X-Uptime: 18:04:19 up 19 days,  9:48, 29 users,  load average: 3.10, 2.72, 2.60
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> Sander wrote:
> >Mark Lord wrote (ao):
> >>Sander wrote:
> >>>Mark Lord wrote (ao):
> >>>>On Friday 17 February 2006 03:45, Jeff Garzik wrote:
> >>>>>Submit a patch... 
> >>>>You mean, something like this one?
> >>...
> >>>[  633.449961] md: md1: sync done.
> >>>[  633.456070] RAID5 conf printout:
> >>>[  633.456117]  --- rd:9 wd:9 fd:0
> >>...
> >>>[ 1872.338185] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
> >>>SK/ASC/ASCQ 0xb/47/00
> >>>[ 1872.338239] ata6: status=0xd0 { Busy }
> >>>[ 5749.285084] ata8: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
> >>>SK/ASC/ASCQ 0xb/47/00
> >>>[ 5749.285138] ata8: status=0xd0 { Busy }
> >>>[ 5906.008461] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
> >>>SK/ASC/ASCQ 0xb/47/00
> >>>[ 5906.008515] ata6: status=0xd0 { Busy }
> ...
> >>SCSI opcode 0x2a is WRITE_10, so the errors are being reported
> >>in response to the writes to bigfile.$i.
> ...
> >I am using the sata_mv driver, which is beta. That might explain why it
> >behaves not totally as expected in your eyes. I have no clue anyway :-)
> 
> Ahh.. that's useful to know.

I'm sorry for omitting that information in my previous mail.

> I expect to be taking a long hard look at the innards of the sata_mv
> code in the near future, so whatever is wrong here just might get
> fixed soon.

Consider me your happy and willing patch test victim :-)

I can easily reproduce data corruption with sata_mv.

FWIW, I like this card very much. It is cheap, seems to perform well,
and Marvell seems to be Linux friendly, providing the docs (according to
http://linux-ata.org/sata-status.html#marvell).

I'm not subscribed to linux-ide, but am to linux-kernel. If you post it
there (or cc me) I'll see and try it.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
