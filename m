Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTCFMQ5>; Thu, 6 Mar 2003 07:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267778AbTCFMQ5>; Thu, 6 Mar 2003 07:16:57 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:56040 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266953AbTCFMQz>; Thu, 6 Mar 2003 07:16:55 -0500
Date: Thu, 6 Mar 2003 12:27:26 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <33061.4.64.238.61.1046931564.squirrel@www.osdl.org>
Message-ID: <Pine.SOL.3.96.1030306122447.1983A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Randy.Dunlap wrote:

> > Hi Randy,
> >
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

It doesn't matter. We just test "if not zero do debug output". The old
ntfs driver used to use different bits for different error messages so -1
would enable all of them and I have stuck to using -1...

Thanks,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

