Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSHEN5Z>; Mon, 5 Aug 2002 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318520AbSHEN5Z>; Mon, 5 Aug 2002 09:57:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50954 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318519AbSHEN5W>;
	Mon, 5 Aug 2002 09:57:22 -0400
Date: Mon, 5 Aug 2002 06:56:31 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Hans Reiser <reiser@namesys.com>
cc: Stephen Lord <lord@sgi.com>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
In-Reply-To: <3D4E80BA.5040701@namesys.com>
Message-ID: <Pine.LNX.4.33L2.0208050650240.6273-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Hans Reiser wrote:

| Stephen Lord wrote:
| >
| >>For a LinuxWorld presentation in August, I have asked each of the
| >>4 journaling filesystems (ext3, reiserfs, JFS, and XFS) what their
| >>filesystem/filesize limits are.  Here's what they have told me.
| >>
| >>                      ext3fs     reiserfs     JFS     XFS=
| >>max filesize:         16 TB#      1 EB       4 PB$   8 TB%
| >>max filesystem size:   2 TB      17.6 TB*    4 PB$   2 TB!
| >>
| >>Notes:
| >>#: think sparse files
| >>*: 4 KB blocks
| >>$: 16 TB on 32-bit architectures
| >>%: 4 KB pages
| >>!: block device limit
    =: all limits are kernel limits (probably true for JFS and reiser
       also)

Albert, your graph shows that the triple-indirect limit is
at 8 EB, right?

| >Randy,
| >
| >If those are the numbers you are presenting then make it clear that
| >for XFS those are the limits imposed by the the Linux kernel. The
| >core of XFS itself can support files and filesystems of 9 Exabytes.
| >I do not think all the filesystems are reporting their numbers in
| >the same way.
| >
| >Steve

Yes, that info was missing from this text-mode info, but it's
already on the slide.  I will be sure to make it More obvious,
and to make the numbers more consistent.

| You might also mention that I think the limits imposed by Linux are the
| only meaningful ones, as we would change our limits as soon as Linux
| did, and it was Linux that selected our limits for us.  We would have
| changed already if Linux didn't make it pointless to change it on Intel.
|  Reiser4 will have 64 bit blocknumbers that will be semi-pointless until
| 64 bit CPUs are widely deployed, and I am simply guessing this will be
| not very far into reiser4's lifecycle.  Really, the couple of #defines
| that constitute these size limits, plus some surrounding code, are not
| such a big thing to change (except that it constitutes a disk format
| change).

Right.  I'll make the point in general that Linux internals are the
reasons for many of these limits.

Thanks,
-- 
~Randy

