Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbRGWV6k>; Mon, 23 Jul 2001 17:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbRGWV6a>; Mon, 23 Jul 2001 17:58:30 -0400
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:5019 "EHLO
	bassia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267931AbRGWV6O>; Mon, 23 Jul 2001 17:58:14 -0400
Message-ID: <3B5C9E95.8BF61D7A@wanadoo.fr>
Date: Tue, 24 Jul 2001 00:00:53 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        maritza@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010723141751.W6820@work.bitmover.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Larry McVoy a écrit :

> Having been through this a time or two, a few points to consider:
> 
> a) This is a hard area to get right.  I've done it twice, I told Linus that
>    I could do it the second time in 6 months, and that was 3 years ago and
>    we're up to 6 full time people working on this.  Your mileage may vary.

Yeah, i'm not alone !

I absolutely don't know how much work it is. Will you work again on this
topic ?
You + Me + 5 persons which work with you = 7p

If we need 50p, there is place enought for 43 volunters !


> b) Filesystem support for SCM is really a flawed approach.  No matter how
>    much you hate all SCM systems out there, shoving the problem into the
>    kernel isn't the answer.  All that means is that you have an ongoing

A filesystem seems to be the best location to store files. My first
intend
was to get ride of additional layers and, being able to use all UNIX
tool
directly on data. As i say, i have only one idea in head: "do it simple"
!


>    battle to keep your VFS up to date with the kernel.  Ask Rational
>    how much fun that is...
>
> c) If you have to do a file system, may I suggest that you clone the SunOS
>    4.x TFS (translucent file system)?  It's a useful model, you "stack" a
>    directory on top of a directory and you can see through to the underlying
>    directory.  When you write to a file, the file is copied forward to the
>    top directory.  So a hack attack is
> 
>         mount -t TFS my_linux /usr/src/linux
>         cd my_linux
>         hack hack hack
>         ... many hours later
>         cd ..
>         umount my_linux
>         find . -type f -print   # this is your list of modified files
> 
>    It's a cool thing but only semi needed - most serious programmers already
>    know how to do the same thing with hard links.

I've yet done this kind of solution:
-copy every directories and sub-dircetories of v1/ into v2/
-create a symlink from v2 to v1 for each files.
-protect v1/

To work on a file, we just break and copy the link. But, i don't see how
to 
work with 2 versions of the same file with hard link.


> 
> More brains are better than less brains, so welcome to the SCM mess...

Ya, it's a true mess !


j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
