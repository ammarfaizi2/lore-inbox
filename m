Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUCNSon (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCNSon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:44:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:35262 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261942AbUCNSom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:44:42 -0500
Date: Sun, 14 Mar 2004 10:44:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mason@suse.com, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] lockfs patch for 2.6
Message-Id: <20040314104439.7c381a09.akpm@osdl.org>
In-Reply-To: <20040314140032.A8901@infradead.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	<20040313131447.A25900@infradead.org>
	<1079191213.4187.243.camel@watt.suse.com>
	<20040313163346.A27004@infradead.org>
	<20040314140032.A8901@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> + * This takes the block device bd_mount_sem to make sure no new mounts
>  + * happen on bdev until unlockfs is called.  If a super is found on this
>  + * block device, we hould a read lock on the s->s_umount sem to make sure
>  + * nobody unmounts until the snapshot creation is done
>  + */
>  +struct super_block *freeze_bdev(struct block_device *bdev)

I think you do need s_umount, as the comments say.  But this patch doesn't
touch it.

