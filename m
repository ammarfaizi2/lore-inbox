Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTAGSjO>; Tue, 7 Jan 2003 13:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbTAGSjO>; Tue, 7 Jan 2003 13:39:14 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:35011 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267368AbTAGSjN> convert rfc822-to-8bit; Tue, 7 Jan 2003 13:39:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: root@chaos.analogic.com, Max Valdez <maxvaldez@yahoo.com>
Subject: Re: Undelete files on ext3 ??
Date: Tue, 7 Jan 2003 12:45:09 -0600
User-Agent: KMail/1.4.1
Cc: Jan Hudec <bulb@ucw.cz>, kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301071245.09561.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 January 2003 12:17 pm, Richard B. Johnson wrote:
> On 7 Jan 2003, Max Valdez wrote:
> > > By the way, there used to be undelete tool for ext2. It created a list
> > > of deleted inodes with correct stat, but no names, only their inode
> > > numbers. You could then pick the corect inode and give it a name, thus
> > > bringing it back to life. Since ext3 is just ext2 with journal, I guess
> > > it might work. It existed as a standalone tool and integrated to
> > > midnight commander.
> >
> > I think there must be some other differences between ext2 and ext3, I've
> > tryed e2undel and unrm, both made for ext2, and none of them found any
> > deleted inode.
> >
> > I umonted immediately the drive, and nothing has been writen on it after
> > the rm *
> >
> > Thanks for the comments !
> > I will keep searching !
> > Max
>
> There is a project waiting for someone who wants
> to contribute. It only slightly involves the kernel,
> but is quite useful.
>
> As more people are switching from the Redmond stuff
> to Linux, many have "learned" from the Redmond stuff
> that `rm` isn't permanent. You can always get it
> back from the `wastebasket`.  Of course, the Unix
> gurus know you can't. Therefore, it's time for somebody
> to put a 'dumpster` in all the Linux file-systems.
> Somebody should then modify `rm` and the kernel unlink
> to `mv' files to the dumpster directory on the
> file-system, instead of really deleting them. Then,
> just like the Redmond stuff, a separate program can
> be used to clear out the "dumpster" or `mv` them back.

Actually, it already exists - It's called "lost+found".

> Since sys_unlink() takes only a path-name, there isn't
> a current mechanism whereby it could take a flag to
> tell it to 'really' delete a file (or is there?). So,
> maybe we need a new kernel function? Just hacking existing
> utilities won't do the whole thing because we need programs
> that delete files to transparently put them into the
> dumpster as well.

You also have to figure out how to communicate with an absent
user for cron/batch/background operation. After all, the user that requested
the deletion may be logged out, even if the system has only one user.

It also won't help the current situation (there is  "rm -i ..." after all).

> The wastebasket should be called a hopper or a dumpster so
> Redmond doesn't get confused and send lawyers.

already named "lost+found".

This subject comes up about once every two years, and gets shot
down for the same reasons every time.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
