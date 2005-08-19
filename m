Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVHSTWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVHSTWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHSTWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:22:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965061AbVHSTWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:22:49 -0400
Date: Fri, 19 Aug 2005 12:21:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: mark.fasheh@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-Id: <20050819122122.0852de3a.akpm@osdl.org>
In-Reply-To: <1124467911.9329.11.camel@kleikamp.austin.ibm.com>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<1124467911.9329.11.camel@kleikamp.austin.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:
>
> It seems that git-ocfs2.patch duplicates the
> update-filesystems-for-new-delete_inode-behavior.patch.  I noticed it
> adds duplicate statements like:
> 
> diff -puN fs/ext2/inode.c~git-ocfs2 fs/ext2/inode.c
> diff -puN fs/ext3/inode.c~git-ocfs2 fs/ext3/inode.c
> --- devel/fs/ext3/inode.c~git-ocfs2     2005-08-18 22:00:35.000000000 -0700
> +++ devel-akpm/fs/ext3/inode.c  2005-08-18 22:00:37.000000000 -0700
> @@ -189,6 +189,8 @@ void ext3_delete_inode (struct inode * i
> 
>         truncate_inode_pages(&inode->i_data, 0);
> 
> +       truncate_inode_pages(&inode->i_data, 0);
> +
>         if (is_bad_inode(inode))
>                 goto no_delete;

Oh crap, thanks.  I'll fix that up differently somehow.
