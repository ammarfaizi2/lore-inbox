Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129542AbQKBVvl>; Thu, 2 Nov 2000 16:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQKBVvb>; Thu, 2 Nov 2000 16:51:31 -0500
Received: from fw.SuSE.com ([202.58.118.35]:51694 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129542AbQKBVvZ>;
	Thu, 2 Nov 2000 16:51:25 -0500
Date: Thu, 2 Nov 2000 14:57:58 -0800
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: blk-7 fails to boot (against 2.4.0-test10)
Message-ID: <20001102145758.B11439@suse.de>
In-Reply-To: <3A01C8B2.23D6E9C4@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A01C8B2.23D6E9C4@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Thu, Nov 02, 2000 at 03:04:02PM -0500
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2000, David Mansfield wrote:
> Hi Jens.
> 
> I wanted to try out blk-7 to see if it cured the abysmal I/O
> performance  
> on 2.4.0-test10, but it won't boot on my system.  The last message I
> see  
> is the banner of the SCSI host adapter init (it found the card) but
> it    

Yes, known bug. The two scsi queueing functions need to plug the
device, it's fixed here. I don't have a clean blk-7 tree atm, but
I'll put up a blk-8 in an hour or so with that fix and others.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
