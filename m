Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCAJtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUCAJtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:49:40 -0500
Received: from fungus.teststation.com ([212.32.186.211]:21773 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261186AbUCAJti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:49:38 -0500
Date: Mon, 1 Mar 2004 10:48:51 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: James Morris <jmorris@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [SELINUX] Handle fuse binary mount data.
In-Reply-To: <Xine.LNX.4.44.0402291938140.22392-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0403011007300.6156-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, James Morris wrote:

> It seems more like a property of the filesystem type: perhaps add 
> FS_BINARY_MOUNTDATA to fs_flags for such filesystems, per the patch below.
...
> diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/smbfs/inode.c linux-2.6.3-mm4.w/fs/smbfs/inode.c
> --- linux-2.6.3-mm4.o/fs/smbfs/inode.c	2003-10-15 08:53:19.000000000 -0400
> +++ linux-2.6.3-mm4.w/fs/smbfs/inode.c	2004-02-29 19:50:58.172037088 -0500
> @@ -778,6 +778,7 @@
>  	.name		= "smbfs",
>  	.get_sb		= smb_get_sb,
>  	.kill_sb	= kill_anon_super,
> +	.fs_flags	= FS_BINARY_MOUNTDATA,
>  };
>  
>  static int __init init_smb_fs(void)

smbfs does not have a binary mountdata, unless the smbmount used is really
old (samba 2.0). If that means that it should get a FS_BINARY_MOUNTDATA
flag or not, I don't know.

/Urban

