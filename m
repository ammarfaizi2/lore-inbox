Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTFQXUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbTFQXUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:20:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12693 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265006AbTFQXT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:19:59 -0400
Date: Wed, 18 Jun 2003 00:33:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [2.5 patch] 2.5.72: moxa.c doesn't compile
Message-ID: <20030617233354.GW6754@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com> <20030617192929.GB26107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617192929.GB26107@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 09:29:29PM +0200, Adrian Bunk wrote:
 
> The following patch fixes it. Additionally, it kills two unused 
> variables. I've tested the compilation with 2.5.72.
 
Thanks.  Linus, apply it, please.

> --- linux-2.5.72/drivers/char/moxa.c.old	2003-06-17 21:22:23.000000000 +0200
> +++ linux-2.5.72/drivers/char/moxa.c	2003-06-17 21:26:56.000000000 +0200
> @@ -339,7 +339,6 @@
>  {
>  	int i, n, numBoards;
>  	struct moxa_str *ch;
> -	int ret1, ret2;
>  
>  	printk(KERN_INFO "MOXA Intellio family driver version %s\n", MOXA_VERSION);
>  	moxaDriver = alloc_tty_driver(MAX_PORTS + 1);
> @@ -615,7 +614,7 @@
>  	}
>  	ch->asyncflags |= ASYNC_CLOSING;
>  
> -	ch->cflag = *tty->termios->c_cflag;
> +	ch->cflag = tty->termios->c_cflag;
>  	if (ch->asyncflags & ASYNC_INITIALIZED) {
>  		setup_empty_event(tty);
>  		tty_wait_until_sent(tty, 30 * HZ);	/* 30 seconds timeout */
