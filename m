Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBETxV>; Mon, 5 Feb 2001 14:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBETxL>; Mon, 5 Feb 2001 14:53:11 -0500
Received: from mail.valinux.com ([198.186.202.175]:37897 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129249AbRBETw4>;
	Mon, 5 Feb 2001 14:52:56 -0500
Message-ID: <3A7F0492.AD31A2FC@valinux.com>
Date: Mon, 05 Feb 2001 11:52:51 -0800
From: Samuel Flory <sflory@valinux.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre11-va1.7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Josh Durham <jmd@aoe.vt.edu>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] NFS and reiserfs
In-Reply-To: <Pine.LNX.4.21.0102051410440.22045-100000@hermes.aoe.vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I had some intial issues with my v3 mounts, but it appears that it was
related to hitting the ulimit on a make -j 16.  (It's nice to work for a
hardware company, and have access to an 8-way.)  In case since upping my
ulimit on the client kernel builds seem to work just with a server power
off in the middle.


  I generally run everything v2, and don't have the issue of non-linux
clients.  So I'm not sure how much help I can be.  I seem to remember
someone (you?) talking about v3 issues with SGI boxes under 2.4 on the
nfs list.  I didn't much pay much attention as it wasn't an issue I
could help with.

http://sourceforge.net/mail/?group_id=14


Josh Durham wrote:
> 
> Any problems with NFSv3?  I had tons of issues, but NFSv2 seems to work
> just fine.  It was with SGI clients.
> 
> - Josh
> 
> On Mon, 5 Feb 2001, Samuel Flory wrote:
> 
> > Dirk Mueller wrote:
> > >
> > > On Mon, 05 Feb 2001, Grahame Jordan wrote:
> > >
> > > > Should I convert all of my NFS filesystems to ext2 or is there another
> > > > option?
> > >
> > > If you use kernel 2.4.x: there are patches for NFS support.
> > >
> >
> >   You can also try the rpms below.  They seem to work for me, but your
> > results may vary.  If you really want to be able to gracefully recover
> > you need to force sync on all of your exports.
> >
> > http://ftp.valinux.com/pub/people/flory/2.4.1/
> >
> >
> > The patch is here:
> > ftp://ftp.namesys.com/pub/reiserfs-for-2.4/linux-2.4.0-reiserfs-3.6.25-nfs.diff
> >
> >

-- 
Solving people's computer problems always
requires more hardware be given to you.
(The Second Rule of Hardware Acquisition)
Samuel J. Flory  <sam@valinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
