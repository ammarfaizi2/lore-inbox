Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276627AbRJUTNg>; Sun, 21 Oct 2001 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbRJUTNZ>; Sun, 21 Oct 2001 15:13:25 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:57219 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S276627AbRJUTNI>; Sun, 21 Oct 2001 15:13:08 -0400
Date: Mon, 22 Oct 2001 03:13:38 +0800 (PHT)
From: Federico Sevilla III <jijo@leathercollection.ph>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ext2 vs. ext3?
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEKODPAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.40.0110220306280.21933-100000@gusi.leathercollection.ph>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2001 at 11:52, M. Edward Borasky wrote:
> Can I get a management-level (features and benefits, traderoffs, etc.)
> guide to the differences between the ext2 and ext3 filesystems? I just
> loaded Red Hat 7.1.94 aka 7.2 beta aka Roswell on my system and it
> offered me the choice, with no guidance as to the tradeoffs.

I don't know if this is the kind of "management-level" information you're
looking for, but the main website of the ext3 project (as listed by
Freshmeat) is <http://beta.redhat.com/index.cgi?action=ext3>. Good
information in the overview section which comes after all the download
links.

Basically ext3 builds on ext2 to add journalling support, which means
significantly less (almost nil) fsck time in the eventuality of an unclean
powerdown.

There are other journalling filesystems for Linux right now aside from
ext3: ReiserFS by Hans Reiser's Namesys <http://www.namesys.com/>, SGI's
XFS <http://oss.sgi.com/projects/xfs/>, and IBM's JFS
<http://oss.lotus.com/jfs/>.

However only ext3 provides a smooth upgrade/downgrade path from ext2 which
is the default on most Linux systems. All the rest require you to backup
your data, redo your filesystem, then restore your data. Also, only
ReiserFS in the mainstream Linus kernel tree. Ext3 is added in the Alan
Cox tree. XFS and JFS are yet to be merged. Maybe in 2.5 (the next
development tree), and hopefully 2.6 as a stable. But that's yet to be
seen of course, as they haven't started.

For now XFS and JFS provide patches to allow you to get working kernel
support for them. I personally use XFS and have found that it is very
stable, as have a lot of other fellow XFS users. I'm not saying it's the
absolute best. But I'm saying it's great, and is fairly stable. :)

 --> Jijo

--
Federico Sevilla III  :: jijo@leathercollection.ph
Network Administrator :: The Leather Collection, Inc.
GnuPG Key: <http://jijo.leathercollection.ph/jijo.gpg>

