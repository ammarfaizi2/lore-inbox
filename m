Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSKAAFA>; Thu, 31 Oct 2002 19:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKAAE4>; Thu, 31 Oct 2002 19:04:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57754 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265516AbSKAAEw>;
	Thu, 31 Oct 2002 19:04:52 -0500
Date: Thu, 31 Oct 2002 19:11:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Bob Miller <rem@osdl.org>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.45] Export blkdev_ioctl for raw block driver.
In-Reply-To: <20021031165719.A26498@doc.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210311909010.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Bob Miller wrote:

> diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
> --- a/kernel/ksyms.c	Thu Oct 31 16:47:14 2002
> +++ b/kernel/ksyms.c	Thu Oct 31 16:47:14 2002
> @@ -349,6 +349,7 @@
>  EXPORT_SYMBOL(blkdev_open);
>  EXPORT_SYMBOL(blkdev_get);
>  EXPORT_SYMBOL(blkdev_put);
> +EXPORT_SYMBOL(blkdev_ioctl);

Why not use ioctl_by_bdev() in the first place?  (and yes, it's very likely
my fault - I hadn't realized that raw.c went modular at some point).

