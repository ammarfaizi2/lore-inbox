Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTJCWjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbTJCWjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:39:12 -0400
Received: from aneto.able.es ([212.97.163.22]:8120 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261298AbTJCWjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:39:07 -0400
Date: Sat, 4 Oct 2003 00:39:04 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031003223904.GE30751@werewolf.able.es>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv> <20031003070422.GA8627@werewolf.able.es> <Pine.LNX.4.44.0310031227460.17548-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0310031227460.17548-100000@serv> (from zippel@linux-m68k.org on Fri, Oct 03, 2003 at 12:30:36 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.03, Roman Zippel wrote:
> Hi,
> 
> On Fri, 3 Oct 2003, J.A. Magallon wrote:
> 
> > Two notes:
> > - You should give a patch or at least give a notice that linux/include/hfs* have
> >   to be killed (or move hfs_fs.h there).
> 
> You did apply linux-2.4.hfs.diff? I don't understand why you had to move 
> hfs_fs.h, it should be picked up from the current directory.
> 

I applied it, it just keeps mainstream files from including old hfs* files
in include/linux, but the old files stay around (you end with two
versions of hfs_fs.h, one in include/linux and other in fs/hfs...)
I did not move anything, just deleted those old files. But as other
filesystems put their xxxx_fs.h in include/linux, I thought that
perhaps hfs(plus) should do the same.

> > - I had to include linux/sched.h in hfs/sysdep.c to get the definition for
> >   'current', that was neded in some subinclude of linux/smp_lock. This can be
> >   caused by any other of my patches, but it doesn't hurt.
> 
> Simply move <linux/smp_lock.h> past "hfs_fs.h".
> 

Thanks.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre6-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
