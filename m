Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTK2HZk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 02:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTK2HZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 02:25:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11525 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263698AbTK2HZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 02:25:38 -0500
Date: Sat, 29 Nov 2003 08:24:47 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Baptiste Malguy <baptiste@malguy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VT driver/char/console.c, kernel 2.4.22
Message-ID: <20031129072447.GA17722@alpha.home.local>
References: <3FC7DF1E.3090807@malguy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC7DF1E.3090807@malguy.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 12:49:50AM +0100, Baptiste Malguy wrote:
 
> In relation to this patch, I want to say that many many websites, FAQs, 
> ... say that you must
> have something like console="/dev/ttyX CONSOLE=/dev/ttyN" to redirect 
> the kernel and init
> messages.
> 
> About 'CONSOLE=', that's true because this is a environment variable 
> that /sbin/init obtains.
> About 'console=', it's completly wrong ! 'console=' expects a driver 
> name (example: "tty",
> "tty1", "ttyS0"), not device file name. Only the Linux source code 
> reading and a few websites
> says the right usage of 'console='.

If there really are FAQ reporting this, it might be simpler to make the
kernel accept /dev/XXX than to try to fix all FAQs, and it would be more
intuitive to people who type on lilo command line.

> Is the way I attached the patch "correct"  ?

You'd better send an "unified diff" (diff -u) which includes one level of
kernel directory. You diff then starts like this :
--- linux-2.4.22/drivers/char/console
+++ linux-2.4.22-bm1/drivers/char/console

And all close changes are merged in a chunk with lines starting with + and -.
Then it's more convenient to compare small changes.

Please take a look at Documentation/SubmittingPatches for more info.

> Must I Cc: it to Marcello or someone else ? I didn't
> find the ideal maintainer in linux/MAINTAINERS.

It's good to Cc Marcelo when you're sure it's an obvious patch that must be
applied, but if you think it may be discussed here, it's better not to flood
his mailbox, considering many people reply to all recipients.

Cheers,
Willy

