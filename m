Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRKNKme>; Wed, 14 Nov 2001 05:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280430AbRKNKmZ>; Wed, 14 Nov 2001 05:42:25 -0500
Received: from eispost12.serverdienst.de ([212.168.16.111]:26119 "EHLO imail")
	by vger.kernel.org with ESMTP id <S280426AbRKNKmO>;
	Wed, 14 Nov 2001 05:42:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: "Sean Elble" <S_Elble@yahoo.com>, "Mike Fedyk" <mfedyk@matchmail.com>,
        "Brian" <hiryuu@envisiongames.net>
Subject: Re: File server FS?
Date: Wed, 14 Nov 2001 11:41:16 +0100
X-Mailer: KMail [version 1.3]
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <028201c16cb0$f489ccc0$0a00a8c0@intranet.mp3s.com>
In-Reply-To: <028201c16cb0$f489ccc0$0a00a8c0@intranet.mp3s.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200111141142227.SM00162@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. November 2001 03:05 schrieb Sean Elble:
> I'd have to recommend XFS for you . . . it supports the kernel
> mode NFS server very well, it supports LVM, an XFS file system
> can be enlarged (not reduced), and XFS has great quota support,
> just be sure you use a 3.0 or greater quota tools package. Why
> use XFS over Ext3 you ask? XFS is faster, and scales better,
> IMHO. Again just my opinion, but I hope that helps.
>

ACK.
We have built an 800 GB file server for a customer about three 
month ago using XFS on a 3ware RAID.
The server performs great, even under heay load.
The only drawback is that group quotas were not yet supported then.
I don't know if this has changed yet, but it should be fairly easy 
to find out..... :-)

cheers,
 Robert

> -----------------------------------------------
> Sean P. Elble
> Editor, Writer, Co-Webmaster
> ReactiveLinux.com (Formerly MaximumLinux.org)
> http://www.reactivelinux.com/
> elbles@reactivelinux.com
> -----------------------------------------------
>
> ----- Original Message -----
> From: "Mike Fedyk" <mfedyk@matchmail.com>
> To: "Brian" <hiryuu@envisiongames.net>
> Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
> Sent: Tuesday, November 13, 2001 8:53 PM
> Subject: Re: File server FS?
>
> > On Tue, Nov 13, 2001 at 05:03:34PM -0500, Brian wrote:
> > > We are about to build a fairly large (720GB) file server
> > > using Linux.
>
> No
>
> > > sane person would actually want to watch this thing fsck, but
> > > I've seen mixed reports about the functionality of the
> > > journaled FSes.
> >
> > Ext3!
> >
> > > Specifically, I need support for
> > >  * KNFSD - it is a file server, afterall
> >
> > Yep
> >
> > >  * LVM - For snapshots and to add space later
> >
> > Yep
> >
> > >  * Resizing - See last point
> >
> > There are two utilities to resize ext2, which ext3 is except
> > for an additional file (journal) after umount.
> >
> > >  * Quotas - Eventually, but we don't need it just yet
> >
> > A little tricky in Linus' kernel.  Should be sorted out soon.
> >
> > > Which, if any, of the journaled FSes support these?
> > > Which one should I go with for a wide range of file and
> > > directory sizes?
> >
> > How many files in a single dir?  Reiser is great for that, but
> > not so good for fragmentation after time on a 70% full or more
> > FS...
> >
> > There is indexing in development for ext2/3, but that'll be 2.5
> > work.
> >
> > Mike
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to
> > majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html Please read the FAQ
> > at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to
> majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html Please read the FAQ at
>  http://www.tux.org/lkml/

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
