Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129848AbQKCCsQ>; Thu, 2 Nov 2000 21:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130094AbQKCCsH>; Thu, 2 Nov 2000 21:48:07 -0500
Received: from fw.SuSE.com ([202.58.118.35]:6140 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129848AbQKCCr5>;
	Thu, 2 Nov 2000 21:47:57 -0500
Date: Thu, 2 Nov 2000 19:54:03 -0800
From: Jens Axboe <axboe@suse.de>
To: Mike Dresser <mdresser@windsormachine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: issues with ide-tape under 2.4.x and with 2.2.x+ide patches
Message-ID: <20001102195403.A18806@suse.de>
In-Reply-To: <3A017F1E.C699593A@windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A017F1E.C699593A@windsormachine.com>; from mdresser@windsormachine.com on Thu, Nov 02, 2000 at 09:50:07AM -0500
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2000, Mike Dresser wrote:
> I'm currently running 2.4.0test10, running backups onto an IDE HP 7/14
> gb drive.  Using  tar -cpvf /dev/ht0 myfiles backs up fine, no errors.
> 
> But..
> 
> promise:~# tar -tf /dev/ht0
> tar: /dev/ht0: Cannot read: Input/output error
> tar: At beginning of tape, quitting now
> tar: Error is not recoverable: exiting now
> 
> and from dmesg:
> ide-tape: ht0: I/O error, pc = 1e, key =  5, asc = 20, ascq =  0
> ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
> ide-tape: ht0: I/O error, pc = 1e, key =  5, asc = 20, ascq =  0
> 
> (normal, i get those cause of the lock drive/unlock drive, which the
> drive doesn't support)

Interesting, and this is test10? I submitted a patch for test10 to
not attempt prevent-removal commands in the ide-tape drives that
do not support it. If this is indeed test10, that would mean that
the HP drive misreports that capability. It'd be nice to know.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
