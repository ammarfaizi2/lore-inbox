Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284156AbRLARPC>; Sat, 1 Dec 2001 12:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284157AbRLAROw>; Sat, 1 Dec 2001 12:14:52 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:45074 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S284156AbRLAROs>; Sat, 1 Dec 2001 12:14:48 -0500
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path changes
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Dec 2001 02:14:15 +0900
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz>
Message-ID: <87667qrhg8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linux.realnet.co.sz> writes:

>  out_fail:
> -	if (opts.iocharset) {
> -		printk("FAT: freeing iocharset=%s\n", opts.iocharset);
> -		kfree(opts.iocharset);
> -	}
> -	if(sbi->private_data)
> -		kfree(sbi->private_data);
> +	printk("FAT: freeing iocharset=%s\n", opts.iocharset);

In all failed cases, this message will be outputted. I think I shouldn't do
so. (or remove this message.)

> +	kfree(opts.iocharset);
> +
> +	kfree(sbi->private_data);
>  	sbi->private_data = NULL;
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
