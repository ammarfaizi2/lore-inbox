Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRLAWeR>; Sat, 1 Dec 2001 17:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281917AbRLAWd6>; Sat, 1 Dec 2001 17:33:58 -0500
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:2945
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S281914AbRLAWdh>; Sat, 1 Dec 2001 17:33:37 -0500
Message-ID: <3C095B0B.7EA478C1@ruault.com>
Date: Sat, 01 Dec 2001 14:34:51 -0800
From: Charles-Edouard Ruault <ce@ruault.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:

> Charles-Edouard Ruault wrote:
>
> > Hi there,
> >
> > i've experienced very weird behaviour with kernel 2.4.16 ( on at least 2
> > different machines with different motherboards & CPUs ).
> > I'm having ext2 filesystem problems on both machines now, one is totally
> > unusable i need to reinstall it from scratch.
>
> Are you sure? perhaps a forced fsck of all
> filesystems would do the trick. New linux users
> coming from a microsoft background are too
> quick to reinstall as a means of maintenance.

Well i did a forced fsck on all my filesystems and now a bunch of files are
corrupted/missing in /usr so rather than figuring out which file is missing
and which package to reinstall i'll reinstall the whole system ( will be much
faster in my opinion ).

>
>
> >
> > I've noticed the problem on different points :
> > - first lots of problems with symlinks ....
> >  unable to compile the kernel for example it bails out with "too many
> > symlinks levels" ,
> >
> > /usr/include/asm/pgtable.h:109:33:
> > /usr/src/linux/include/asm/pgtable-2level.h: Too many levels of symbolic
> > links
>
> Yes, it looks like the filesystem is corrupted.
>
> > I backtracked to kernel 2.4.14 and now after doing an fsck on all my
> > partitions ( only one problem reported on /home ) , everything is back
> > to normal.
>
> Have you tried 2.4.16 since the fsck?

I did a fsck ( not forced ) then bootedup 2.4.16 and had the problem , then i
tried to compile 2.4.14 on the machine and it failed ( because of the symlink
problems ) , i compiled the kernel on another machine, installed it and
booted i had the same problem again. I then did the force fsck and booted
2.4.14 and it was fine. You might be right about 2.4.16 , i'll boot it again
and see if the problem is still there.
What's weird is that the fsck did not report any problem on my root partition
and i was seeing problem on it ...
The only problem it saw ( and fixed )  was in /home

>
>
> > I've read that there was a filesystem problem in 2.4.15 that is supposed
> > to be fixed in 2.4.16.
>
> That is the case,
>
> > These 2 machines did run 2.4.15 from it's birtday until 2.4.16 was born
> > so maybe the problem was created in 2.4.15 but showed up in 2.4.16 ...
> > If someone has an explanation to this behaviour, i would be really happy
>
> Of course.
>
> The 2.4.15 filesystem corruption problem occurred
> on shutdown. When you booted up into 2.4.16, the
> filesystem was corrupt and you began to see the
> strange symptoms. when you backtracked to 2.4.14
> and did the fsck, the problems were corrected.
>
> I'll bet $20 that 2.4.16 runs fine now as well.

I'll try and let you know !
thanks a lot for your quick reply !

>
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

