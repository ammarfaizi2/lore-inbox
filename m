Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbQKCOjP>; Fri, 3 Nov 2000 09:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbQKCOjF>; Fri, 3 Nov 2000 09:39:05 -0500
Received: from windsormachine.com ([206.48.122.28]:46098 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129207AbQKCOjE>; Fri, 3 Nov 2000 09:39:04 -0500
Message-ID: <3A02CE02.DD690B0B@windsormachine.com>
Date: Fri, 03 Nov 2000 09:38:58 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: issues with ide-tape under 2.4.x and with 2.2.x+ide patches
In-Reply-To: <3A017F1E.C699593A@windsormachine.com> <20001102195403.A18806@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(forgot to CC: this to the list when i replied to Jens, and decided to add
another paragraph)

I just tried my Seagate drive, and i can read my tapes in it.  If i swap
over to the HP, i can't read the tapes.  I'll look today, whether the
Seagate replies with a bunch of those I/O Errors.  It's not like i'm doing
anything but working on making this damn tape drive work =)

Considering the HP 7/14 gig format is already a proprietory format(<sarcasm>
THANKS HP! </sarcasm>), it wouldn't surprise me if something else is non
standard.  It's weird that i can read 7/14 gig tapes in the 10/20 Seagate
though.  Nice of Seagate to include support for someone else's mistake =)

Jens Axboe wrote:

> On Thu, Nov 02 2000, Mike Dresser wrote:
> > I'm currently running 2.4.0test10, running backups onto an IDE HP 7/14
> > gb drive.  Using  tar -cpvf /dev/ht0 myfiles backs up fine, no errors.
> >
> > But..
> >
> > promise:~# tar -tf /dev/ht0
> > tar: /dev/ht0: Cannot read: Input/output error
> > tar: At beginning of tape, quitting now
> > tar: Error is not recoverable: exiting now
> >
> > and from dmesg:
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
>
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
