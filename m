Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUFXOjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUFXOjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUFXOjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:39:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:46346 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264658AbUFXOjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:39:15 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allow root to choose vfat policy to UTF8
References: <20040624073858.GA17435@devserv.devel.redhat.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 24 Jun 2004 23:39:00 +0900
In-Reply-To: <20040624073858.GA17435@devserv.devel.redhat.com>
Message-ID: <87n02tkol7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> --- linux-2.6.7/fs/fat/inode.c~	2004-06-24 11:20:43.941750760 +0200
> +++ linux-2.6.7/fs/fat/inode.c	2004-06-24 11:20:43.943750521 +0200
> @@ -499,9 +499,8 @@
>  	}
>  	/* UTF8 doesn't provide FAT semantics */
>  	if (!strcmp(opts->iocharset, "utf8")) {
> -		printk(KERN_ERR "FAT: utf8 is not a valid IO charset"
> -		       " for FAT filesystems\n");
> -		return -EINVAL;
> +		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
> +		       " for FAT filesystems, filesystem will be case sensitive!\n");
>  	}

Umm.. why don't use "iocharset=<xxx>,utf8" instead?  This is less
unsatisfactory than it option.

Would we still need it? If we still need, I think patch should be applied.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
