Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270009AbRHEUir>; Sun, 5 Aug 2001 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270007AbRHEUii>; Sun, 5 Aug 2001 16:38:38 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:7439 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S270006AbRHEUic>;
	Sun, 5 Aug 2001 16:38:32 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 5 Aug 2001 21:39:38 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch (2.4.8-pre3)
In-Reply-To: <Pine.GSO.4.21.0108050301050.11005-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0108052135510.855-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2001, Alexander Viro wrote:

> 
> 
> On Sat, 4 Aug 2001, Ken Moffat wrote:
> 
> > On Thu, 2 Aug 2001, Alexander Viro wrote:
> > 
> > > 
> > > New version on ftp.math.psu.edu/pub/viro, namespaces-a-S8-pre3 and
> > > initramfs-a-S8-pre3 (the latter is against 3.4.8-pre3 + namespaces).
> > > 
> > [snip]
> > > 
> > > Please, help with testing. It's supposed to be a drop-in replacement -
> > > apply patches, build and boot. If it boots - fine, if it doesn't - it
> > > will panic before it could do any harm.
> 
> > Patches applied cleanly, but it doesn't build here (AMD K6, gcc3)
> > 
> > In file included from init/init.c:16:
> > init/libc.h:7: warning: `exit' was declared `extern' and later `static'
> > init/init.c:33: parse error before "mount_nfs_root"
> 
> /me looks at the line in question. In shame. Sorry - I'll put a fix for
> that typo (rediffed against -pre4, but that should apply to -pre3 as well)
> on anonftp in a minute. In the meanwhile, s/nt/int/ in the line 33
> (init/init.c). Sorry - builds during the last week were all with
> CONFIG_ROOT_NFS defined.
> 
>
Builds nicely now. If I'd known only one of the messages mattered, I'd
have looked more closely at the code.

Small problem, though

request_module[ramfs]: Root fs not mounted
Kernel panic. Can't create rootfs

Obviously I've not been paying attention. I ran "make oldconfig" and
didn't see any new options that were needed, so I didn't consider altering
my current config settings. Which one is it I need, please ? 

Ken
-- 
   Never drink more than two pangalacticgargleblasters !
Home page : http://www.kenmoffat.uklinux.net

