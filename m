Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBCEkU>; Fri, 2 Feb 2001 23:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129096AbRBCEkK>; Fri, 2 Feb 2001 23:40:10 -0500
Received: from [65.192.23.216] ([65.192.23.216]:16644 "EHLO anomaly.xbill.org")
	by vger.kernel.org with ESMTP id <S129053AbRBCEjz>;
	Fri, 2 Feb 2001 23:39:55 -0500
Date: Fri, 2 Feb 2001 20:39:41 -0800 (PST)
From: Brian Wellington <bwelling@xbill.org>
To: Brian May <bam@snoopy.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
In-Reply-To: <848znojt10.fsf@snoopy.apana.org.au>
Message-ID: <Pine.LNX.4.21.0102022039210.12394-100000@anomaly.xbill.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Feb 2001, Brian May wrote:

> >>>>> "Keith" == Keith Owens <kaos@ocs.com.au> writes:
> 
>     >> {PB} This was necessary for libc5, but is not correct when
>     >> using glibc. Including the kernel header files directly in user
>     >> programs usually does not work (see question 3.5). glibc
>     >> provides its own <net/*> and <scsi/*> header files to replace
>     >> them, and you may have to remove any symlink that you have in
>     >> place before you install glibc. However, /usr/include/asm and
>     >> /usr/include/linux should remain as they were.
>     >> 
>     >> Keith, are you saying that glibc is wrong?
> 
>     Keith> Not me, Linus says that glibc is wrong.
> 
>     Keith>   "I've asked glibc maintainers to stop the symlink
>     Keith> insanity for the last few years now, but it doesn't seem to
>     Keith> happen.
> 
>     Keith>   Basically, that symlink should not be a symlink.  It's a
>     Keith> symlink for historical reasons, none of them very good any
>     Keith> more (and haven't been for a long time), and it's a
>     Keith> disaster unless you want to be a C library developer.
>     Keith> Which not very many people want to be.
> 
>     Keith>   The fact is, that the header files should match the
>     Keith> library you link against, not the kernel you run on."
> 
> 
> I read Keith's response as: the symlink is wrong.
> I read the glib FAQ as:     the symlink is wrong.
> I read Linus' response as:  the symlink is wrong.
> 
> Who is contradicting who here?
> 
> (perhaps that last sentence in the glibc FAQ is confusing, however the
> rest of it clearly says that glibc contains its own version of those
> files, and a symlink should *not* be used. I think the part "[...] you
> may have to remove any symlink [...]" is clear enough).

No, it clearly says that glibc contains its own versions of the net/* and
scsi/* files, and that /usr/include/asm and /usr/include/linux should
remain as they were.  Since they were symlinks in libc5 (which is what
'originally' seems to be referring to), they should still be symlinks.

Brian (who really doesn't care either way)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
