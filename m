Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTA1KhK>; Tue, 28 Jan 2003 05:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbTA1KhJ>; Tue, 28 Jan 2003 05:37:09 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:22990 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S265130AbTA1KhH>; Tue, 28 Jan 2003 05:37:07 -0500
Date: Tue, 28 Jan 2003 10:46:26 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-ntfs-dev@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
In-Reply-To: <20030123230137.GC906@zaurus>
Message-ID: <Pine.SOL.3.96.1030128104050.26720A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Pavel Machek wrote:
> > This is a massive update featuring an almost complete rewrite of the ntfs
> > library (the API should hopefully remain stable from now on) as well as
> > several new utilities: ntfslabel, ntfsresize, and ntfsundelete.
> 
> So you can resize ntfs but not (safely) write to it?

The library can write to ntfs quite safely indeed as can the new kernel
driver (present in 2.5.x and available as patch for 2.4.x from
http://linux-ntfs.sf.net/download.html.  But the only thing that is
implemented in both is file overwrite, no change of file size is possible
at present. Also it is not possible to create/delete files/hard links/sym
links. Please note this is not due to a lack of knowledge, its just a
matter of having the time to implement it all... I am currently working on
adding truncate support to the library (the code will be later ported to
the kernel of course) and I have my new ntfstruncate utility working for
certain types of inodes and certain cases of truncation. But it is going
to take a while to have it completed. A lot of support code needs to be
written to cope with all cases... E.g. need to be able to allocate/free
clusters and inodes for a start (clusters are pretty much done, inode
freeing is done, too), resize attribute records, work with attribute list
attributes, ... Ntfs is complicated unfortunately...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

