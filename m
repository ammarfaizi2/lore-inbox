Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUCGQQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUCGQQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:16:08 -0500
Received: from ns.suse.de ([195.135.220.2]:55684 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262143AbUCGQPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:15:52 -0500
Date: Sun, 7 Mar 2004 17:15:50 +0100
From: Olaf Hering <olh@suse.de>
To: nathans@sgi.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: linux-2.5 cset 1.1654.1.2  xfs filemap_flush() unresolved
Message-ID: <20040307161550.GA2812@suse.de>
References: <20040307052556.4BABC468E4@mandarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040307052556.4BABC468E4@mandarine.suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



filemap_flush() is not an exported symbol, at least not in my tree.


> ChangeSet
>   1.1654.1.2 04/03/06 14:47:10 nathans@sgi.com +1 -0
>   [XFS] Fix out-of-space deadlock when flushing delalloc data with pages locked under write.
>   
>   SGI Modid: xfs-linux:xfs-kern:167948a
> 
>   fs/xfs/linux/xfs_super.c
>     1.70 04/03/06 14:46:51 nathans@sgi.com +1 -1
>     [XFS] Fix out-of-space deadlock when flushing delalloc data with pages locked under write.
> 
> .........................................................................
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1654.1.1 -> 1.1654.1.2
> #	fs/xfs/linux/xfs_super.c	1.69    -> 1.70   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 04/03/06	nathans@sgi.com	1.1654.1.2
> # [XFS] Fix out-of-space deadlock when flushing delalloc data with pages locked under write.
> # 
> # SGI Modid: xfs-linux:xfs-kern:167948a
> # --------------------------------------------
> #
> diff -Nru a/fs/xfs/linux/xfs_super.c b/fs/xfs/linux/xfs_super.c
> --- a/fs/xfs/linux/xfs_super.c	Sun Mar  7 06:25:54 2004
> +++ b/fs/xfs/linux/xfs_super.c	Sun Mar  7 06:25:54 2004
> @@ -247,7 +247,7 @@
>  {
>  	struct inode	*inode = LINVFS_GET_IP(XFS_ITOV(ip));
>  
> -	filemap_fdatawrite(inode->i_mapping);
> +	filemap_flush(inode->i_mapping);
>  }
>  
>  void
> .........................................................................
> # vim: syntax=diff
> 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
