Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132132AbRAHTUD>; Mon, 8 Jan 2001 14:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAHTTx>; Mon, 8 Jan 2001 14:19:53 -0500
Received: from barn.holstein.com ([198.134.143.193]:28937 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S131358AbRAHTTj>;
	Mon, 8 Jan 2001 14:19:39 -0500
Date: Mon, 8 Jan 2001 19:18:53 GMT
Message-Id: <200101081918.f08JIrT06681@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: andrea@suse.de
Cc: toddroy@softhome.net, linux-kernel@vger.kernel.org
In-Reply-To: <20001227205336.A10446@athlon.random> (message from Andrea
	Arcangeli on Wed, 27 Dec 2000 20:53:36 +0100)
Subject: Re: lvm 0.8 to 0.9 conversion?
Reply-To: troy@holstein.com
In-Reply-To: <3A45192F.8C149F93@softhome.net> <20001227205336.A10446@athlon.random>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 01/08/2001 02:06:09 PM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 01/08/2001 02:06:10 PM,
	Serialize complete at 01/08/2001 02:06:10 PM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been on vacation....

Nope, no snapshots.

Well, I couldn't get my orginal volume group visible under both
lvm 0.8 and 0.9.  I don't know why.  So I grabbed a big empty hard disk,
created a new volume group that was visible under both, dded all the logical
volumes over to it, updated fstab  and removed the offending vg.  I've yet to
recreate the original vg, copy stuff back and remove the new drive.
I should point out that the offending vg was relatively ancient, I think I
created it when 0.7 was king under some something like 2.2.14.  Now I'm 
running 2.4.0-ac4 and all works well.



>  Date: Wed, 27 Dec 2000 20:53:36 +0100
>  From: Andrea Arcangeli <andrea@suse.de>
>  Cc: linux-kernel@vger.kernel.org
>  Content-Type: text/plain; charset=us-ascii
>  Content-Disposition: inline
>  X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
>  X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
>  
>  On Sat, Dec 23, 2000 at 04:29:19PM -0500, Todd M. Roy wrote:
>  > group is visible, and you just told meit should be, then I can just
>  > copy volumes over under test13-pre3 and destroy and recreate the
>  > first volume group.
>  
>  Is it possible you had a snapshot in the volume group when you started
>  lvm 0.9 the first time? snapshots are not persistent on pre3 so it doesn't make
>  sense to left them before rebooting the kernel, and maybe lvmtools 0.9 doesn't
>  cope correctly with non persistent snapshot created by 0.8 driver (trivial to
>  temporarly workaround, just delete any snapshot volume before using 0.9 lvm :).
>  
>  Andrea
>  
>  
**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
