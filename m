Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319594AbSIMKRv>; Fri, 13 Sep 2002 06:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319595AbSIMKRv>; Fri, 13 Sep 2002 06:17:51 -0400
Received: from dns.vamo.orbitel.bg ([195.24.63.30]:49669 "EHLO
	dns.vamo.orbitel.bg") by vger.kernel.org with ESMTP
	id <S319594AbSIMKRq>; Fri, 13 Sep 2002 06:17:46 -0400
Date: Fri, 13 Sep 2002 13:22:22 +0300 (EEST)
From: Ivan Ivanov <ivandi@vamo.orbitel.bg>
To: Nero <neroz@iinet.net.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: XFS?
In-Reply-To: <3D81B09B.7030405@iinet.net.au>
Message-ID: <Pine.LNX.4.44.0209131250480.8722-100000@magic.vamo.orbitel.bg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Sep 2002, Nero wrote:

> Ivan Ivanov wrote:
> > I think that you missed the main problem with all this new "great"
> > filesystems. And the main problem is potential data loss in case of a
> > crash. Only ext3 supports ordered or journal data mode.
> >
> > XFS and JFS are designed for large multiprocessor machines powered by UPS
> > etc., where the risk of power fail, or some kind of tecnical problem is
> > veri low.
> >
> > On the other side Linux works in much "risky" environment - old
> > machines, assembled from "yellow" parts, unstable power suply and so on.
> >
> > With XFS every time when power fails while writing to file the entire file
> > is lost. The joke is that it is normal according FAQ :)
> > JFS has the same problem.
> > With ReiserFS this happens sometimes, but much much rarely. May be v4 will
> > solve this problem at all.
> >
> > The above three filesystems have problems with badblocks too.
> >
> > So the main problem is how usable is the filesystem. I mean if a company
> > spends a few tousand $ to provide a "low risky" environment, then may be
> > it will use AIX or IRIX, but not Linux.
> > And if I am running a <$1000 "server" I will never use XFS/JFS.
>
> This just is not the issue. If we only wanted filesystems which behaved
> like ext2/3, we would only have ext2/3. The issue, if you have all
> forgotten, is Linus not providing information on why XFS is a problem to
> be merged. He asked them to make it easy to merge - they have done so.
> Now they ask why the patch is ignored, and are promptly ignored further.
>

I think that it is not fair to insist for merging of XFS only. There ara
many other projects that are of bigger value for linux then iet another
filesystem - RSBAC,OpenMosix,LSM,HTree and more.
Some people like Linus, Alan, Marchelo etc. have the responsibility to
provide users with a usable, stable kernel.
And if somebody doesn't like their way of work he is free to make it's own
kernel tree.

I am not an expert, just a sysadmin, and I am testing XFS since kernel
2.4.6 ( I am writing this mail from a test machine with kernel 2.4.18
and XFS root filesystem ), and I also think that XFS is not ready for
production ( I lost some unimportant files after a crash yesterday ).

And after all do you think that such kind of presure over kernel
maintainers is the way of making free software.

--------------------
Cheers
Ivan



