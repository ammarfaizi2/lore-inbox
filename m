Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKFPDB>; Mon, 6 Nov 2000 10:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129096AbQKFPCv>; Mon, 6 Nov 2000 10:02:51 -0500
Received: from windsormachine.com ([206.48.122.28]:35846 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129061AbQKFPCn>; Mon, 6 Nov 2000 10:02:43 -0500
Message-ID: <3A06C7F8.80D4484C@windsormachine.com>
Date: Mon, 06 Nov 2000 10:02:16 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: issues with ide-tape under 2.4.x and with 2.2.x+ide patches
In-Reply-To: <3A017F1E.C699593A@windsormachine.com> <20001102195403.A18806@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ide-tape: ht0: I/O error, pc = 1e, key =  5, asc = 20, ascq =  0
> > ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
> > ide-tape: ht0: I/O error, pc = 1e, key =  5, asc = 20, ascq =  0
> >
> > (normal, i get those cause of the lock drive/unlock drive, which the
> > drive doesn't support)
>
> Interesting, and this is test10? I submitted a patch for test10 to
> not attempt prevent-removal commands in the ide-tape drives that
> do not support it. If this is indeed test10, that would mean that
> the HP drive misreports that capability. It'd be nice to know.

Confirmed.

promise:~/crap# uname -a
Linux promise 2.4.0-test10 #4 Mon Oct 30 17:16:16 EST 2000 i686 unknown

And i think my clock chip is drifting, it's actually the 6th of November. =)

Anyways...... Spent 15 minutes trying to figure out why it couldn't read the
tape, and kept giving me the errors.  Then i remembered the whole point of
this bug-report WAS about it not reading tapes.  It's Monday morning, but my
brain is still out there in the wild blue yonder. :)

I'm interested in why the HP drive won't read tapes, but if i swap in my
Seagate, it reads them just fine.  Well, aside from media errors.  Seems HP
can't build a tape drive OR tape media that is reliable =)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
