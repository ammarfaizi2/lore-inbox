Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQKNClQ>; Mon, 13 Nov 2000 21:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQKNClG>; Mon, 13 Nov 2000 21:41:06 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:37135 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129412AbQKNCku>; Mon, 13 Nov 2000 21:40:50 -0500
Date: Mon, 13 Nov 2000 18:10:43 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: initcalls in pre4?
Message-ID: <20001113181043.C1820@twiddle.net>
In-Reply-To: <3A0F815C.1EEDBFFA@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A0F815C.1EEDBFFA@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 12:51:24AM -0500, Jeff Garzik wrote:
> Alas...
> 
> --- include/linux/init.h        2000/10/30 19:37:38     1.1.1.5
> +++ include/linux/init.h        2000/11/13 04:30:02     1.1.1.6
> @@ -73,7 +73,7 @@
> -#define __init         __attribute__ ((__section__ (".text.init")))
> +#define __init         /* __attribute__ ((__section__ (".text.init")))

Arg!  This is my fault... -g does not give sensible line numbers on
Alpha in mdebug format when code is outside of .text.  I thought I
cropped it out of the patch I sent to Linus, but obviously not in
the final version.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
