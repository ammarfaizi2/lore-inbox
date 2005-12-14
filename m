Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVLNW15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVLNW15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVLNW15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:27:57 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:63970 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965004AbVLNW14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:27:56 -0500
Date: Wed, 14 Dec 2005 23:24:19 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/hfsplus/: move the hfsplus_inode_check() prototype
 to hfsplus_fs.h
In-Reply-To: <20051213170137.GL23349@stusta.de>
Message-ID: <Pine.LNX.4.61.0512142319170.1609@scrub.home>
References: <20051213170137.GL23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Dec 2005, Adrian Bunk wrote:

> --- linux-2.6.15-rc2-mm1-full/fs/hfsplus/inode.c.old	2005-11-23 16:37:34.000000000 +0100
> +++ linux-2.6.15-rc2-mm1-full/fs/hfsplus/inode.c	2005-11-23 16:37:48.000000000 +0100
> @@ -183,7 +183,6 @@
>  	hlist_add_head(&inode->i_hash, &HFSPLUS_SB(sb).rsrc_inodes);
>  	mark_inode_dirty(inode);
>  	{
> -	void hfsplus_inode_check(struct super_block *sb);
>  	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
>  	hfsplus_inode_check(sb);
>  	}
> @@ -322,7 +321,6 @@
>  		return NULL;
>  
>  	{
> -	void hfsplus_inode_check(struct super_block *sb);
>  	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
>  	hfsplus_inode_check(sb);
>  	}

As this is only a debug function I don't see much point in cleaning it up.
I'd rather remove it completely (including all references to 
last_inode_cnt and inode_cnt).

bye, Roman
