Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUANXQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266329AbUANXOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:14:39 -0500
Received: from mrout1.yahoo.com ([216.145.54.171]:12039 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S266315AbUANXND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:13:03 -0500
Message-ID: <4005CCCB.4030003@bigfoot.com>
Date: Wed, 14 Jan 2004 15:12:11 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <87hdyyxjgl.fsf@stark.xeocode.com>
In-Reply-To: <87hdyyxjgl.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>Intel ICH5
>>
>>Issue #2: Excessive interrupts are seen in some configurations.
> 
> 
> I guess I'm seeing this problem. I'm trying to get my P4P800 motherboard with
> an ICH5 chipset working completely. So far I've been living without the cdrom
> or DVD players. I see lots of other posts on linux-kernel about the same
> problems:
> 
> Whenever I try to access the cdrom my system becomes unusable. Due to high
> interrupts, typically over 150k/s. I thought libata would help, but I don't
> understand how to use the PATA drive and the cdrom drives while I'm using it.
> 
> The situation is that I have two SATA drives, a PATA drive and two cdrom
> drives (actually one CD burner and one DVD drive). They are 
> 
> Primary Master:   PATA Drive
> Secondary Master: CD Burner
> Secondary Slave:  DVD-Rom
> SATA-1:           SATA Drive
> SATA-2:           SATA Drive
> 
> I've tried 2.4.23pre4 (no libata), 2.6.1 (IDE drivers), and 2.6.1 (with scsi
> libata drivers) with the following results:
> 
> 2.4.23pre4: as soon as the cdrom is touched I see bursts of 150k interrupts
>     per second and the system becomes unresponsive momentarily every few
>     seconds.
> 
> 2.6.1 with regular IDE drivers: same as above except the system feels
>     responsive except for disk i/o. I see printks of "Disabling interrupt #18"
>     and all disk i/o freezes for a few seconds.
> 
> 2.6.1 with scsi ata_piix driver: the SATA drives show up and work fine but the
>     PATA drive and the cdroms doesn't show up at all. This is true even when I
>     compile with the CONFIG_IDE, CONFIG_BLK_DEV_IDE, and CONFIG_BLK_DEV_IDECD
>     enabled.

   I have intel D865PERL, three IDE HDs, one CD burner, one SATA disk, 
using scsi ata, kernel 2.4.21-ac4 with libata5 patches (libata patches 
needed beacause SATA driver is over 133GB), seems to be working fine, I 
am not using CD burner very often but I didn't see any instability when 
I used it (read or burn CDs).

   When I use cdparanoia to rip audio CDs the system is quite slow but 
that was always the case (even with different MB, no SATA, different 
kernels etc.)

   Using SATA disk as IDE disk caused the system to freeze during boot 
(right after the HDs were detected)

	erik

