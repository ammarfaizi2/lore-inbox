Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279442AbRJWOFa>; Tue, 23 Oct 2001 10:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279443AbRJWOFU>; Tue, 23 Oct 2001 10:05:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12985 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S279442AbRJWOFH>;
	Tue, 23 Oct 2001 10:05:07 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
To: Jens Axboe <axboe@suse.de>
Cc: Reto Baettig <baettig@scs.ch>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF74054AB1.2E23D4AC-ON85256AEE.004B503C@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Tue, 23 Oct 2001 10:05:32 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/23/2001 10:05:32 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>On Mon, Oct 22 2001, Shailabh Nagar wrote:
>>
>>
>> Unlike the SGI patch, the multiple block size patch continues to use
buffer
>> heads. So the biggest atomic transfer request that can be seen by a
device
>> driver with the multiblocksize patch is still 1 page.
>
>Not so. Given a 1MB contigious request broken into 256 pages, even if
>submitted in these chunks it will be merged into the biggest possible
>request the lower level driver can handle. This is typically 127kB, for
>SCSI it can be as much as 512kB currently and depending on the SCSI
>driver even more maybe.

My mistake - by device driver I wasn't referring to the lowest level
drivers but also
including the merging functionality.

>
>I haven't seen the SGI rawio patch, but I'm assuming it used kiobufs to
>pass a single unit of 1 meg down at the time. Yes currently we do incur
>significant overhead compared to that approach.
>
> Getting bigger transfers would require a single buffer head to be able to
> point to a multipage buffer or not use buffer heads at all.
> The former would obviously be a major change and suitable only for 2.5
> (perhaps as part of the much-awaited rewrite of the block I/O
>
> Ongoing effort.
>
> subsystem).The use of multipage transfers using a single buffer head
would
> also help non-raw I/O transfers. I don't know if anyone is working along
> those lines.

>It is being worked on.


Could you give some idea as to what are some of the ideas being
discussed/proposed ?
It would be nice to know some of the details as they are being worked on.

Thanks,
Shailabh Nagar




