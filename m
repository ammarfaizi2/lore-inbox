Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbTHVD0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 23:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTHVD0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 23:26:00 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:3207 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S263003AbTHVDZt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 23:25:49 -0400
Subject: Re: Bind Mount Extensions (ro for --bind)
From: Shawn <core@enodev.com>
To: herbert@13thfloor.at
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20030822024726.GA10598@www.13thfloor.at>
References: <20030822024726.GA10598@www.13thfloor.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1061522719.6682.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 22:25:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty cool. Guess I missed that one the first time.

Hope it doesn't bit-rot!

On Thu, 2003-08-21 at 21:47, Herbert Pötzl wrote:
> Hi Linus!
> Hi Andrew!
> Hi Marcelo!
> 
> a few weeks ago, I posted a patch on lkml, which allows 
> ro --bind mounts, at least regarding ...
> 
>  - open (read/write/trunc), create
>  - link, symlink, unlink
>  - mknod (reg/block/char/fifo), mkfifo
>  - mkdir, rmdir
>  - (f)chown, (f)chmod, utimes
>  - ioctl (gen/ext2/ext3/reiser)
>  - access, truncate
> 
> it doesn't handle update_atime() yet, because Al Viro
> hasn't had the time to answer my email, and it doesn't
> change current intermezzo code (but this would be easy
> to add, because it's almost the same as the vfs_*()s at
> least regarding ro --bind mounts)
> 
> actually patches are available and tested for 2.4.22-rc2 
> and 2.6.0-test3 up to 2.6.0-test3-bk9 ...
> 
> I would like to see this or similar code in 2.6 and 2.4 ...
> please let me know, what would be required to get them
> in, or why you dislike those patches, in case you do ...
> 
> TIA,
> Herbert
> 
> -----
> http://www.13thfloor.at/Patches/patch-2.4.22-rc2-bme0.03.diff
> http://www.13thfloor.at/Patches/patch-2.4.22-rc2-bme0.03.diff.bz2
> http://www.13thfloor.at/Patches/patch-2.6.0-test3-bme0.03.diff
> http://www.13thfloor.at/Patches/patch-2.6.0-test3-bme0.03.diff.bz2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
