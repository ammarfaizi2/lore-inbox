Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTAGSGl>; Tue, 7 Jan 2003 13:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTAGSGl>; Tue, 7 Jan 2003 13:06:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267559AbTAGSGj>; Tue, 7 Jan 2003 13:06:39 -0500
Date: Tue, 7 Jan 2003 13:17:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Max Valdez <maxvaldez@yahoo.com>
cc: Jan Hudec <bulb@ucw.cz>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: Undelete files on ext3 ??
In-Reply-To: <1041961118.13635.10.camel@garaged.fis.unam.mx>
Message-ID: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2003, Max Valdez wrote:

> 
> > 
> > By the way, there used to be undelete tool for ext2. It created a list
> > of deleted inodes with correct stat, but no names, only their inode
> > numbers. You could then pick the corect inode and give it a name, thus
> > bringing it back to life. Since ext3 is just ext2 with journal, I guess
> > it might work. It existed as a standalone tool and integrated to
> > midnight commander.
> > 
> I think there must be some other differences between ext2 and ext3, I've
> tryed e2undel and unrm, both made for ext2, and none of them found any
> deleted inode.
> 
> I umonted immediately the drive, and nothing has been writen on it after
> the rm *
> 
> Thanks for the comments !
> I will keep searching !
> Max


There is a project waiting for someone who wants
to contribute. It only slightly involves the kernel,
but is quite useful.

As more people are switching from the Redmond stuff
to Linux, many have "learned" from the Redmond stuff
that `rm` isn't permanent. You can always get it
back from the `wastebasket`.  Of course, the Unix
gurus know you can't. Therefore, it's time for somebody
to put a 'dumpster` in all the Linux file-systems.
Somebody should then modify `rm` and the kernel unlink
to `mv' files to the dumpster directory on the
file-system, instead of really deleting them. Then,
just like the Redmond stuff, a separate program can
be used to clear out the "dumpster" or `mv` them back.

Since sys_unlink() takes only a path-name, there isn't
a current mechanism whereby it could take a flag to
tell it to 'really' delete a file (or is there?). So,
maybe we need a new kernel function? Just hacking existing
utilities won't do the whole thing because we need programs
that delete files to transparently put them into the
dumpster as well.

The wastebasket should be called a hopper or a dumpster so
Redmond doesn't get confused and send lawyers.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


