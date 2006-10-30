Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965319AbWJ3RDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319AbWJ3RDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWJ3RDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:03:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:9869 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965319AbWJ3RDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:03:31 -0500
Subject: Re: [PATCH] jfs: Add splice support
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Daniel Drake <ddrake@brontes3d.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20061030163148.2412D7B40A0@zog.reactivated.net>
References: <20061030163148.2412D7B40A0@zog.reactivated.net>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 10:56:55 -0600
Message-Id: <1162227415.24229.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 16:31 +0000, Daniel Drake wrote:
> This allows the splice() and tee() syscalls to be used with JFS.

Gosh, that was easy.  Why couldn't I do that?  :-)

Answer: I would have had to test it.

I'm assuming you did?

Thanks,
Shaggy

> Signed-off-by: Daniel Drake <ddrake@brontes3d.com>
> 
> Index: linux-2.6.19-rc3/fs/jfs/file.c
> ===================================================================
> --- linux-2.6.19-rc3.orig/fs/jfs/file.c
> +++ linux-2.6.19-rc3/fs/jfs/file.c
> @@ -109,6 +109,8 @@ const struct file_operations jfs_file_op
>  	.aio_write	= generic_file_aio_write,
>  	.mmap		= generic_file_mmap,
>  	.sendfile	= generic_file_sendfile,
> +	.splice_read	= generic_file_splice_read,
> +	.splice_write	= generic_file_splice_write,
>  	.fsync		= jfs_fsync,
>  	.release	= jfs_release,
>  	.ioctl		= jfs_ioctl,
-- 
David Kleikamp
IBM Linux Technology Center

