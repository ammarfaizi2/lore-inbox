Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282547AbRLBAyA>; Sat, 1 Dec 2001 19:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282553AbRLBAxu>; Sat, 1 Dec 2001 19:53:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:42369 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282547AbRLBAxk>; Sat, 1 Dec 2001 19:53:40 -0500
Message-ID: <001e01c17acb$a44b69c0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "J Sloan" <jjs@pobox.com>
Cc: "Charles-Edouard Ruault" <ce@ruault.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com>
Subject: Re: File system Corruption with 2.4.16
Date: Sat, 1 Dec 2001 17:52:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "J Sloan" <jjs@pobox.com>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: "Charles-Edouard Ruault" <ce@ruault.com>; <linux-kernel@vger.kernel.org>
Sent: Saturday, December 01, 2001 4:54 PM
Subject: Re: File system Corruption with 2.4.16


> Jeff Merkey wrote:
>
> > I am seeing corruption on 2.4.16 (2.4.17-pre1/2) as well.  Whatever this
> > gentlemen is doing is making it show up quicker, but I am on my fourth
> > interation of fsck'ing 2.4.16 on my production server with NWFS builds.
I
> > am looking through Al Viros's inode code changes to see if there's hole
> > somewhere.  This problem appears to be related to low memory conditions.
I
> > see it when memory is getting low.  May be VM related as well.
>
> Just to be positive, can you reproduce the
> problem without nwfs?

Yes.  The problem shows up on ext2 partitions only.  I also have seen a
lockup in NWFS when
I have patched my FS into Linux.  The lockup indicates a deadlock in the
inode layers above
me.  I see this lockup when I have more than one file system mounted at a
time.  It does not happen
when only a single volume (superblock) has been mounted, only with
multiples.  Ditto the ext2
corruption.  It only shows up when more than one superblock is active.
Perhaps this will help
narrow down the problem.  Since I have a VFS of my own, I could help track
this down, but it
will be tommorrow, I am working on NWFS tools code today. :-)

Jeff

>
> cu
>
> jjs
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

