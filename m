Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTCDXSn>; Tue, 4 Mar 2003 18:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTCDXSn>; Tue, 4 Mar 2003 18:18:43 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:10415 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266981AbTCDXSm>;
	Tue, 4 Mar 2003 18:18:42 -0500
Date: Wed, 5 Mar 2003 10:28:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: sys32_ioctl -> compat_ioctl -- generic
Message-Id: <20030305102849.61469d19.sfr@canb.auug.org.au>
In-Reply-To: <20030303232122.GA24018@elf.ucw.cz>
References: <20030303232122.GA24018@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, 4 Mar 2003 00:21:22 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>
> This is generic part of sys32_ioctl -> compat_ioctl. Please apply,

Thanks for this - you saved me a headache :-)

Some comments:

> --- clean/kernel/compat.c	2003-03-03 23:39:39.000000000 +0100
> +++ linux/kernel/compat.c	2003-02-20 10:48:21.000000000 +0100

All this really belongs in fs/compat.c ...

One thing that Linus (and I) wanted from the compatability layer is
to try to keep all 32 bit assumptions out of the generic code - I
understand that this my not be possible, but we would like to try.

So maybe you could start by changing ioctl32 to compat_ioctl everywhere -
I know that this is just cosmetic, but it gives the better impression of
what the code is about ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
