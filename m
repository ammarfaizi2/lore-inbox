Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbRGJUL5>; Tue, 10 Jul 2001 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbRGJULr>; Tue, 10 Jul 2001 16:11:47 -0400
Received: from eagle.datafocus.com ([204.255.0.2]:61106 "EHLO
	hercules.fairfax.datafocus.com") by vger.kernel.org with ESMTP
	id <S267120AbRGJUL0>; Tue, 10 Jul 2001 16:11:26 -0400
Message-ID: <00a401c1097c$343d45b0$4d0310ac@fairfax.mkssoftware.com>
From: "Eric Youngdale" <eric@andante.org>
To: "Jonathan Lahr" <lahr@us.ibm.com>, "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
In-Reply-To: <20010709123936.E6013@us.ibm.com> <20010709214453.U16505@suse.de> <20010710124903.H6013@us.ibm.com>
Subject: Re: io_request_lock patch?
Date: Tue, 10 Jul 2001 16:09:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    The bit that I had automated was to essentially fix each and every
low-level SCSI driver such that each low-level driver would be responsible
for it's own locking.  At this point the patches and the tool are on hold -
once the 2.5 kernel series gets underway, I can generate some fairly massive
patchsets.

-Eric

----- Original Message -----
From: "Jonathan Lahr" <lahr@us.ibm.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>; <linux-scsi@vger.kernel.org>
Sent: Tuesday, July 10, 2001 3:49 PM
Subject: Re: io_request_lock patch?


> Jens Axboe [axboe@suse.de] wrote:
> > On Mon, Jul 09 2001, Jonathan Lahr wrote:
> > >
> > > I have heard that a patch to reduce io_request_lock contention by
> > > breaking it into per queue locks was released in the past.  Does
> > > anyone know where I could find this patch if it exists?
> >
> > I had a patch about a year ago that did it safely for the block layer
> > and IDE at least, and also for selected SCSI hba's. Some of the latter
> > variety are pretty hard and/or tedious to fixup, Eric Y has done some
> > work automating this process almost completely. Until that is done, the
> > general patch has no chance of being integrated.
>
> I am investigating reducing io_request_lock contention in the shorter term
> if possible with smaller incremental modifications.  So I'm first trying
to
> discover any previous work that might have been done toward this purpose.
>
> --
> Jonathan Lahr
> IBM Linux Technology Center
> Beaverton, Oregon
> lahr@us.ibm.com
> 503-578-3385
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
>

