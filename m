Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSKBQhC>; Sat, 2 Nov 2002 11:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSKBQhB>; Sat, 2 Nov 2002 11:37:01 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:14208 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261292AbSKBQhB>;
	Sat, 2 Nov 2002 11:37:01 -0500
Date: Sat, 2 Nov 2002 10:42:45 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Gerd Knorr <kraxel@bytesex.org>
cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.45: initrd broken?
In-Reply-To: <20021101224327.GA3303@bytesex.org>
Message-ID: <Pine.LNX.4.44.0211021041040.1936-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Gerd Knorr wrote:

> > Patch below fixes these.  It also changes order of blkdev_put()/del_gendisk()
> > in initrd_release() - better safe than sorry.
> > 
> > It got initrd working on my boxen...
> 
> [ patch snipped ]
> 
> Initrd works now, thanks.
> 
> The box still doesn't boot through, the initrd fails to load the ext3
> module due to unresolved symbols (mb_cache_*).  That issue looks like a
> kbuild problem to me:  I have ACL's enabled (which builds the mbcache.o
> module).  I also have the nfs server with v4 support enabled (which
> doesn't build currently).  Running "make -k modules_install" does _not_
> install the mbcache.o in /lib/modules/2.5.45.  I suspect this happens
> due to the build error in the nfsd subdirectory.

So do I mark my problem report for initrd broken as closed, or wait until 
it appears in bk?

