Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293548AbSBZJGb>; Tue, 26 Feb 2002 04:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293549AbSBZJGV>; Tue, 26 Feb 2002 04:06:21 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:29705 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293548AbSBZJGK>;
	Tue, 26 Feb 2002 04:06:10 -0500
Date: Tue, 26 Feb 2002 00:59:53 -0800
From: Greg KH <greg@kroah.com>
To: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unneeded inode semaphores from driverfs
Message-ID: <20020226085952.GA30564@kroah.com>
In-Reply-To: <20020226085946.GB278@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020226085946.GB278@pazke.ipt>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 29 Jan 2002 06:48:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 11:59:46AM +0300, Andrey Panin wrote:
> Hi,
> 
> __remove_file() in driverfs/inode.c calls down(&dentry->d_inode->i_sem)
> before calling vfs_unlink(dentry->d_parent->d_inode,dentry) which 
> tries to claim the same semaphore causing the livelock.
> driverfs_remove_dir() makes the same calling vfs_rmdir().

What kernel version did you generate this patch for?  This patch doesn't
apply at all to 2.5.5, and it looks like this problem is already fixed.

thanks,

greg k-h
