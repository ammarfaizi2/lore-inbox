Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271865AbRIDAPH>; Mon, 3 Sep 2001 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271863AbRIDAO6>; Mon, 3 Sep 2001 20:14:58 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:47073 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271862AbRIDAOt>; Mon, 3 Sep 2001 20:14:49 -0400
Date: Mon, 3 Sep 2001 20:14:06 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200109040014.f840E6m00316@devserv.devel.redhat.com>
To: mikpe@csd.uu.se, Floydsmith@aol.com
Cc: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org
Subject: Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
In-Reply-To: <mailman.999367801.660.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.999367801.660.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Kernel 2.4.9-ac5 on  i686
> >then
> >ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
> >tar: /dev/ht0: Cannot read: Input/output error
> >(writes work OK though)

> - block size: The 2.4 ide-tape driver only works reliably if you
>   write data with the correct block size. If you don't write full
>   blocks the last block of data may not be readable.

I fixed that some time ago, it's in current -ac
if not in Linus's tree. The bug has nothing to do
with the ASC=2c problem the original poster complained.

> - HP's not-quite ATAPI drives: Don't know about your model, but the
>   HP 14(?)GB model is believed to deviate from ATAPI standards.

Colorado sucks... I think I have a bug pending about it,
did not look well yet. IIRC it was giving ASC=24, not 2c.
I'll look it up.

-- Pete
