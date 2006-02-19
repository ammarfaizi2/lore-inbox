Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWBSHOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWBSHOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 02:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWBSHOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 02:14:14 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:23136 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751171AbWBSHON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 02:14:13 -0500
Date: Sun, 19 Feb 2006 08:14:15 +0100
From: Sander <sander@humilis.net>
To: Mark Lord <lkml@rtr.ca>
Cc: sander@humilis.net, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
Message-ID: <20060219071414.GA31299@favonius>
Reply-To: sander@humilis.net
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca> <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca> <20060218204340.GA2984@favonius> <43F794D8.7000406@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F794D8.7000406@rtr.ca>
X-Uptime: 07:46:36 up 18 days, 23:28, 28 users,  load average: 3.22, 2.73, 2.52
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> Sander wrote:
> >Mark Lord wrote (ao):
> >>On Friday 17 February 2006 03:45, Jeff Garzik wrote:
> >>>Submit a patch... 
> >>You mean, something like this one?
> ...
> >[  633.449961] md: md1: sync done.
> >[  633.456070] RAID5 conf printout:
> >[  633.456117]  --- rd:9 wd:9 fd:0
> ...
> >[ 1872.338185] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
> >SK/ASC/ASCQ 0xb/47/00
> >[ 1872.338239] ata6: status=0xd0 { Busy }
> >[ 5749.285084] ata8: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
> >SK/ASC/ASCQ 0xb/47/00
> >[ 5749.285138] ata8: status=0xd0 { Busy }
> >[ 5906.008461] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
> >SK/ASC/ASCQ 0xb/47/00
> >[ 5906.008515] ata6: status=0xd0 { Busy }
> ...
> >This is with 2.6.16-rc3, your patch, and running nine Maxtors disks
> >over onboard nForce4 and MV88SX6081 8-port SATA II PCI-X Controller (rev 
> >09).
> >
> >for i in `seq 10`
> >do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
> >done
> >md5sum bigfile.*
> >
> >The errors mostly seem to happen during the md5sum (not during the dd).
> 
> SCSI opcode 0x2a is WRITE_10, so the errors are being reported
> in response to the writes to bigfile.$i.

Ah, my bad then.

> But these are different from the previously reported error status
> values -- I wonder why it's getting "Busy" back as a status here ??

Well, as I wrote, I am not the original reporter whoms thread you
responded to with your patch. I just thought I could use it to get
better errors messages for my bug reports.

I am using the sata_mv driver, which is beta. That might explain why it
behaves not totally as expected in your eyes. I have no clue anyway :-)

I hope my reports are of any use to Jeff wrt the sata_mv driver.

Thank you for your response.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
