Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSBZQyk>; Tue, 26 Feb 2002 11:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291297AbSBZQya>; Tue, 26 Feb 2002 11:54:30 -0500
Received: from air-2.osdl.org ([65.201.151.6]:39064 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S291258AbSBZQyP>;
	Tue, 26 Feb 2002 11:54:15 -0500
Date: Tue, 26 Feb 2002 08:53:04 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: Andrey Panin <pazke@orbita1.ru>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove unneeded inode semaphores from driverfs
In-Reply-To: <20020226101208.GA285@pazke.ipt>
Message-ID: <Pine.LNX.4.33.0202260851280.31464-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Feb 2002, Andrey Panin wrote:

> On Tue, Feb 26, 2002 at 12:59:53AM -0800, Greg KH wrote:
> > On Tue, Feb 26, 2002 at 11:59:46AM +0300, Andrey Panin wrote:
> > > Hi,
> > > 
> > > __remove_file() in driverfs/inode.c calls down(&dentry->d_inode->i_sem)
> > > before calling vfs_unlink(dentry->d_parent->d_inode,dentry) which 
> > > tries to claim the same semaphore causing the livelock.
> > > driverfs_remove_dir() makes the same calling vfs_rmdir().
> > 
> > What kernel version did you generate this patch for?  This patch doesn't
> > apply at all to 2.5.5, and it looks like this problem is already fixed.
> 
> It's against 2.5.5-pre1, I was out of the net for some days and
> couldn't check final 2.5.5.

>From the changelog, it is only the mysterious "device model/driverfs 
updates", but it should have indeed been fixed in 2.5.5.

Thanks,

	-pat

