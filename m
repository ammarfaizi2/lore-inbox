Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVGFKJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVGFKJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVGFKGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:06:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51162 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262199AbVGFIQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:16:00 -0400
Date: Wed, 6 Jul 2005 10:15:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [14/48] Suspend2 2.1.9.8 for 2.6.12: 404-check-mounts-support.patch
Message-ID: <20050706081523.GD1412@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164403506@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164403506@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 06-07-05 12:20:40, Nigel Cunningham wrote:
> diff -ruNp 405-clear-swapfile-bdev-in-swapoff.patch-old/mm/swapfile.c 405-clear-swapfile-bdev-in-swapoff.patch-new/mm/swapfile.c
> --- 405-clear-swapfile-bdev-in-swapoff.patch-old/mm/swapfile.c	2005-07-06 11:22:01.000000000 +1000
> +++ 405-clear-swapfile-bdev-in-swapoff.patch-new/mm/swapfile.c	2005-07-04 23:14:19.000000000 +1000
> @@ -1162,6 +1162,7 @@ asmlinkage long sys_swapoff(const char _
>  	swap_file = p->swap_file;
>  	p->swap_file = NULL;
>  	p->max = 0;
> +	p->bdev = NULL;
>  	swap_map = p->swap_map;
>  	p->swap_map = NULL;
>  	p->flags = 0;

I guess some explanation is needed here; and if it is bugfix it should
just go in...
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
