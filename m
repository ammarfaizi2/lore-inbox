Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSHRSZb>; Sun, 18 Aug 2002 14:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSHRSZb>; Sun, 18 Aug 2002 14:25:31 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:53910 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315491AbSHRSZa>; Sun, 18 Aug 2002 14:25:30 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6un0rkuiyg.fsf@zork.zork.net>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode> <1029694235.520.9.camel@psuedomode> 
	<6un0rkuiyg.fsf@zork.zork.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 14:29:23 -0400
Message-Id: <1029695363.1357.5.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know i have no device nodes.  I removed them all before installing
devfs.  the devfs documentation says it doesn't need to have devfs
mounted to work, but this doesn't seem to be true at all.  Hence my
confusion. I know i can go download a bootable iso and get that burned
and working but I shouldn't have to do that.  









On Sun, 2002-08-18 at 14:20, Sean Neakums wrote:
> commence  Ed Sweetman quotation:
> 
> > It appears i'm completely unable to not use devfs.  Attempting to
> > run the kernel without mounting devfs results in it still being
> > mounted or if not compiled in, locks up during boot.  Attempts to
> > run the kernel and mv /dev does not work, umounting /dev does not
> > work and rm'ing /dev does not work.  I cant create the non-devfs
> > nodes while devfs is mounted and i cant boot the kernel without
> > devfs.  It seems that no uninstall procedure has been made and i've
> > read the documentation that comes with the kernel about devfs and it
> > says nothing about how to move back to the old device nodes from
> > devfs.
> >
> > anyone have any suggestions?
> 
> Where does the boot hang?  If it comaplains about not being able to
> open /dev/console or some other device node, it may be that your /dev
> has no nodes in it.  This happened to me when I eradicated devfs (I
> got fed up of fighting with devfsd to get my permission changes to
> stick, and had reshuffled FSes in the meantime) and so I booted from a
> rescue disk, mounted my root FS and recreated the device nodes in
> /mnt/dev.
> 
> -- 
>  /                          |
> [|] Sean Neakums            |  Questions are a burden to others;
> [|] <sneakums@zork.net>     |      answers a prison for oneself.
>  \                          |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


