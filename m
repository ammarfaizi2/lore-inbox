Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289097AbSAUJH0>; Mon, 21 Jan 2002 04:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAUJHQ>; Mon, 21 Jan 2002 04:07:16 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:56513 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287573AbSAUJHH>; Mon, 21 Jan 2002 04:07:07 -0500
Message-Id: <200201210906.g0L96vT2001762@tigger.cs.uni-dortmund.de>
To: Ville Herva <vherva@niksula.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors 
In-Reply-To: Message from Ville Herva <vherva@niksula.hut.fi> 
   of "Sun, 20 Jan 2002 23:08:41 +0200." <20020120210841.GU51774@niksula.cs.hut.fi> 
Date: Mon, 21 Jan 2002 10:06:57 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@niksula.hut.fi> said:
> On Sun, Jan 20, 2002 at 09:44:31PM +0100, you [Andreas Ferber] claimed:
> > On Sun, Jan 20, 2002 at 10:02:55PM +0200, Ville Herva wrote:
> > > 
> > > Just out of interest (I'm not actually suggesting this would be useful, or
> > > feasible): what about ilink(dev, inode_nr, "path") or iopen(dev, inode_nr)?
> > > 
> > > Or /proc/inodes/dev/<nr> ?
> > 
> > ...which would successfully defeat any access control scheme based on
> > directory permissions...
> 
> Yeah - it could be root-only.
> 
> But it's propably not useful anyway.

There are filesystems around (MSDOS, VFAT) that haven't got fixed inode
numbers for files. There are networked filesystems where this would need
radical changes to the server side. Some even make up inode numbers on the
fly IIRC.

If in dire need, you could hack something together for <favorite
filesystem> by groveling over the disk image. e2fsprogs' libraries should
come handy...
-- 
Horst von Brand			     http://counter.li.org # 22616
