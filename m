Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279991AbRKNCH6>; Tue, 13 Nov 2001 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279992AbRKNCHs>; Tue, 13 Nov 2001 21:07:48 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:63431 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279991AbRKNCHe>; Tue, 13 Nov 2001 21:07:34 -0500
Message-ID: <028201c16cb0$f489ccc0$0a00a8c0@intranet.mp3s.com>
Reply-To: "Sean Elble" <S_Elble@yahoo.com>
From: "Sean Elble" <S_Elble@yahoo.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>, "Brian" <hiryuu@envisiongames.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com>
Subject: Re: File server FS?
Date: Tue, 13 Nov 2001 21:05:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd have to recommend XFS for you . . . it supports the kernel mode NFS
server very well, it supports LVM, an XFS file system can be enlarged (not
reduced), and XFS has great quota support, just be sure you use a 3.0 or
greater quota tools package. Why use XFS over Ext3 you ask? XFS is faster,
and scales better, IMHO. Again just my opinion, but I hope that helps.

-----------------------------------------------
Sean P. Elble
Editor, Writer, Co-Webmaster
ReactiveLinux.com (Formerly MaximumLinux.org)
http://www.reactivelinux.com/
elbles@reactivelinux.com
-----------------------------------------------

----- Original Message -----
From: "Mike Fedyk" <mfedyk@matchmail.com>
To: "Brian" <hiryuu@envisiongames.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 13, 2001 8:53 PM
Subject: Re: File server FS?


> On Tue, Nov 13, 2001 at 05:03:34PM -0500, Brian wrote:
> > We are about to build a fairly large (720GB) file server using Linux.
No
> > sane person would actually want to watch this thing fsck, but I've seen
> > mixed reports about the functionality of the journaled FSes.
> >
>
> Ext3!
>
> > Specifically, I need support for
> >  * KNFSD - it is a file server, afterall
>
> Yep
>
> >  * LVM - For snapshots and to add space later
>
> Yep
>
> >  * Resizing - See last point
>
> There are two utilities to resize ext2, which ext3 is except for an
> additional file (journal) after umount.
>
> >  * Quotas - Eventually, but we don't need it just yet
> >
>
> A little tricky in Linus' kernel.  Should be sorted out soon.
>
> > Which, if any, of the journaled FSes support these?
> > Which one should I go with for a wide range of file and directory sizes?
> >
>
> How many files in a single dir?  Reiser is great for that, but not so good
> for fragmentation after time on a 70% full or more FS...
>
> There is indexing in development for ext2/3, but that'll be 2.5 work.
>
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

