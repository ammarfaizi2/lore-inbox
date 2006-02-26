Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWBZN4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWBZN4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWBZN4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:56:15 -0500
Received: from rtr.ca ([64.26.128.89]:64898 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750812AbWBZN4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:56:14 -0500
Message-ID: <4401B378.3030005@rtr.ca>
Date: Sun, 26 Feb 2006 08:56:08 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44019E96.20804@superbug.co.uk>
In-Reply-To: <44019E96.20804@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
>
> I have what looks like similar problems. The issue I have is that I 

Nope.  Different issues.

> ) #1 Sat Dec 3 18:47:19 GMT 2005
> Dec 16 22:51:57 games kernel: hdc: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x40 { 
> UncorrectableError }, LBAsect=53058185, sector=53057951

The disk really does have bad sectors in this case (above).

> The other has the following errors:
> Linux version 2.6.15.1 (root@localhost) (gcc version 3.4.5 (Gentoo 
> 3.4.5, ssp-3.4.5-1.0, pi
> e-8.7.9)) #3 SMP PREEMPT Fri Feb 3 23:19:05 GMT 2006
> Feb 10 23:30:07 localhost kernel: ata3: command 0xb0 timeout, stat 0xd0 
> host_stat 0x0
> Feb 10 23:30:07 localhost kernel: ata3: translated ATA stat/err 0xd0/00 
> to SCSI SK/ASC/ASCQ 0xb/47/00
> Feb 10 23:30:07 localhost kernel: ata3: status=0xd0 { Busy }
> Feb 10 23:30:07 localhost kernel: ATA: abnormal status 0xD0 on port 
> 0xF880E087
> Feb 10 23:30:07 localhost last message repeated 3 times
> Feb 10 23:30:10 localhost kernel: ata3: PIO error
> Feb 10 23:30:10 localhost kernel: ata3: status=0x50 { DriveReady 
> SeekComplete }
> Feb 11 10:18:10 localhost kernel: ata2: command 0xb0 timeout, stat 0xd0 
> host_stat 0x0
> Feb 11 10:18:10 localhost kernel: ata2: translated ATA stat/err 0xd0/00 
> to SCSI SK/ASC/ASCQ 0xb/47/00
> Feb 11 10:18:10 localhost kernel: ata2: status=0xd0 { Busy }
> Feb 11 10:18:10 localhost kernel: ATA: abnormal status 0xD0 on port 0x177
> Feb 11 10:18:10 localhost last message repeated 3 times

PIO errors?  Are you using Alan Cox's experimental PATA code for libata?

-ml
