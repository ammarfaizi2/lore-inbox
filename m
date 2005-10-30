Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVJ3RRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVJ3RRk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVJ3RRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:17:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:28684 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932194AbVJ3RRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:17:39 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't use pdflush for filesystems has BDI_CAP_NO_WRITEBACK
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
	<87vezgd89q.fsf_-_@devron.myhome.or.jp>
	<87r7a4d7if.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 31 Oct 2005 02:15:47 +0900
In-Reply-To: <87r7a4d7if.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Sat, 29 Oct 2005 17:58:32 +0900")
Message-ID: <87wtjvexj0.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> diff -puN fs/hugetlbfs/inode.c~add-set_inode_noflush fs/hugetlbfs/inode.c
> --- linux-2.6.14/fs/hugetlbfs/inode.c~add-set_inode_noflush	2005-10-29 08:13:57.000000000 +0900
> +++ linux-2.6.14-hirofumi/fs/hugetlbfs/inode.c	2005-10-29 08:13:57.000000000 +0900
> @@ -394,6 +394,7 @@ static struct inode *hugetlbfs_get_inode
>  	inode = new_inode(sb);
>  	if (inode) {
>  		struct hugetlbfs_inode_info *info;
> +		set_inode_noflush(inode);
>  		inode->i_mode = mode;
>  		inode->i_uid = uid;
>  		inode->i_gid = gid;

Sigh, I'm forgetting block special file again. Sorry for wrong patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
