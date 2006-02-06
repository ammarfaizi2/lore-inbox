Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWBFScA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWBFScA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWBFScA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:32:00 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:26383 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932145AbWBFSb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:31:59 -0500
Message-ID: <43E795E5.2020705@cfl.rr.com>
Date: Mon, 06 Feb 2006 13:31:01 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: EVMS & SATA failure
References: <5a2cf1f60602060858x268cd05fud533ee554fb2db5a@mail.gmail.com>
In-Reply-To: <5a2cf1f60602060858x268cd05fud533ee554fb2db5a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2006 18:33:29.0903 (UTC) FILETIME=[D3966BF0:01C62B4B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14251.000
X-TM-AS-Result: No--24.699000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks to me like those are IO errors caused by the defective disk.  That 
appears to confuse Ubuntu's init scripts when they try to detect the 
EVMS stuff, and it goes into an infinite loop retrying instead of giving 
up.  You should probably report this bug to Ubuntu. 


jerome lacoste wrote:
> Hi,
>
> Trying to recover from a disk failure [1], we:
> - installed a fresh ubuntu 5.10 (modified kernel 2.6.12) on a new disk
> - stopped machine
> - connected failing SATA disk to board (in order to try to recover some data)
> - rebooted
>
> That doesn't work at all:
>
> * Setting up LVM Volumne Groups
> * Starting Enterprise Volume Management System...
> ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
> Buffer I/O error on device dm-3, logical block 1
> ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
> Buffer I/O error on device dm-3, logical block 2
> ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
> Buffer I/O error on device dm-3, logical block 3
> ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
> Buffer I/O error on device dm-3, logical block 4
> ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
> Buffer I/O error on device dm-3, logical block 5
> ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
> Buffer I/O error on device dm-3, logical block 6
> ....
>
> And the boot doesn't go further, the error messages keep looping from
> block 0 to 12.
>
> As I am trying to minimize my number of reboots (to not stress my
> failing disk), maybe someone has an idea what those messages could
> mean? Is that due to my failing disk? Is it some sort of SATA
> configuration issue? Or is there an EVMS issue?
>
> Otherwise I will prevent the EVMS daemon from starting at boot and see
> if that fixes my issue.
>
> Cheers,
>
> Jerome
>
>   

