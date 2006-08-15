Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWHOS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWHOS7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWHOS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:59:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13584 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965224AbWHOS6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:58:43 -0400
Date: Tue, 15 Aug 2006 15:25:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] Register ext3dev filesystem
Message-ID: <20060815152513.GC4032@ucw.cz>
References: <1155172642.3161.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155172642.3161.74.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Register ext4 filesystem as ext3dev filesystem in kernel.
> 
> Signed-Off-By: Mingming Cao<cmm@us.ibm.com>
> 
> 
> ---
> 
>  linux-2.6.18-rc4-ming/fs/Kconfig                |   74 ++++++++++++++++++++++--
>  linux-2.6.18-rc4-ming/fs/Makefile               |    1 
>  linux-2.6.18-rc4-ming/fs/ext4/Makefile          |   10 +--
>  linux-2.6.18-rc4-ming/fs/ext4/acl.h             |    6 -
>  linux-2.6.18-rc4-ming/fs/ext4/file.c            |    2 
>  linux-2.6.18-rc4-ming/fs/ext4/inode.c           |    2 
>  linux-2.6.18-rc4-ming/fs/ext4/namei.c           |    6 -
>  linux-2.6.18-rc4-ming/fs/ext4/super.c           |   20 +++---
>  linux-2.6.18-rc4-ming/fs/ext4/symlink.c         |    4 -
>  linux-2.6.18-rc4-ming/fs/ext4/xattr.c           |    8 +-
>  linux-2.6.18-rc4-ming/fs/ext4/xattr.h           |    8 +-
>  linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h |    4 -
>  12 files changed, 106 insertions(+), 39 deletions(-)
> 
> diff -puN fs/ext4/super.c~register-ext3dev fs/ext4/super.c
> --- linux-2.6.18-rc4/fs/ext4/super.c~register-ext3dev	2006-08-09 15:41:29.273105685 -0700
> +++ linux-2.6.18-rc4-ming/fs/ext4/super.c	2006-08-09 15:41:29.317106042 -0700
> @@ -447,7 +447,7 @@ static struct inode *ext4_alloc_inode(st
>  	ei = kmem_cache_alloc(ext4_inode_cachep, SLAB_NOFS);
>  	if (!ei)
>  		return NULL;
> -#ifdef CONFIG_EXT4_FS_POSIX_ACL
> +#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL

Is it really neccessary to rename *all* the config options?

-- 
Thanks for all the (sleeping) penguins.
