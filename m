Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbRBBVEV>; Fri, 2 Feb 2001 16:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129794AbRBBVEM>; Fri, 2 Feb 2001 16:04:12 -0500
Received: from www.wen-online.de ([212.223.88.39]:58129 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129043AbRBBVEF>;
	Fri, 2 Feb 2001 16:04:05 -0500
Date: Fri, 2 Feb 2001 22:03:53 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: RAMFS
In-Reply-To: <20010202214122.C753@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.Linu.4.10.10102022151400.490-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Ingo Oeser wrote:

> On Fri, Feb 02, 2001 at 08:24:19PM +0100, Mike Galbraith wrote:
> > On Fri, 2 Feb 2001, Ingo Oeser wrote:
> > > No, so have to unlock it also, if you return -ENOSPC.
> > > 
> > > So the correct fix seems to be:
> [...]
> > > This currently works for me (but using 2.4.0 + dwg-ramfs.patch + this patch)
> >
> > Have you stressed it?  (I see leakiness)
> 
> I do reads and writes to it every 5 seconds and sometimes more (
> mounted on /tmp, /var/run and the like ) and had an uptime of
> about a week (I use it in an embedded-like system and we
> sometimes change the system image).
> 
> There might be a dentry or inode leak, but that doesn't bite me,
> because I only create the files I need once and extend or shrink
> them.

That won't show it. I can do that kind of stuff all day long, no
problem whatsoever.

> But I couldn't stress it too much.
> 
> Where exactly do you see the leaks?

(I don't have a solid grip yet.. just starting to seek)

> PS: For reference, I put the diff to 2.4.0 that I use to
>    http://www.tu-chemnitz.de/~ioe/dwg-ramfs.patch
> 
>    The original patch has _not_ been done by me, but by
>    David Gibson, Linuxcare Australia.

I'll take a look at this.. thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
