Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbTCFG1U>; Thu, 6 Mar 2003 01:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTCFG1T>; Thu, 6 Mar 2003 01:27:19 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:54616 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S267852AbTCFG1S>; Thu, 6 Mar 2003 01:27:18 -0500
Date: Thu, 6 Mar 2003 07:28:03 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <33061.4.64.238.61.1046931564.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.30.0303060716390.28143-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, Randy.Dunlap wrote:

> > Could you try to turn on debugging in the NTFS driver (compile option in the
> > menus), then once ntfs module is loaded (or otherwise anytime) as root do:
> >
> > echo -1 > /proc/sys/fs/ntfs-debug
> >
> > Then mount and to the directory changes. Assuming that you get the bug again
> > could you send me the captured kernel log output? (Note there will be
> > massive amounts of output.)
> >
> > The code looks ok and I can't reproduce here so it would be helpful to see
> > if there are any oddities on your partition. Just to make sure it is not the
> > compiler, could you do a "make fs/ntfs/inode.S" and send me that as well?
> >
> > Thanks,
>
> Anton,
>
> I'll get to this in another day or so.
>
> The help text for NTFS_DEBUG says to use 1 to enable it
> or 0 to disable it.  What does -1 do?

Same as 1. However I doubt NTFS_DEBUG gives any useful in your case
and if you had some NTFS "oddities" then it would be reproducible.

What would be really useful is to disassemble __ntfs_init_inode what I
asked 2 days ago (note, not the above 'make fs/ntfs/inode.S' because
it will not tell what machine code you have on disk), your .config and
exact CPU version (cat /proc/cpuinfo).

	Szaka

