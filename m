Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVK1UkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVK1UkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVK1UkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:40:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932228AbVK1UkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:40:18 -0500
Date: Mon, 28 Nov 2005 12:40:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] fuse: support caching negative dentries
Message-Id: <20051128124007.1feb4473.akpm@osdl.org>
In-Reply-To: <E1Egp20-0006vv-00@dorka.pomaz.szeredi.hu>
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu>
	<E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu>
	<E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu>
	<E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu>
	<E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu>
	<E1Egozl-0006uy-00@dorka.pomaz.szeredi.hu>
	<E1Egp0p-0006vL-00@dorka.pomaz.szeredi.hu>
	<E1Egp20-0006vv-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> +void fuse_invalidate_attr(struct inode *inode)
>  +{
>  +	get_fuse_inode(inode)->i_time = jiffies - 1;
>  +}
>  +
>  +static void fuse_invalidate_entry_cache(struct dentry *entry)
>  +{
>  +	entry->d_time = jiffies - 1;
>  +}
>  +

I'd normally have a little whine about lack of comments here - pity the
poor programmer who is trying to work out why on earth that code is doing
that.

But fuse is pretty much a comment-free zone anyway.  Please don't go near
any buses.  
