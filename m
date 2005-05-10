Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVEJFbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVEJFbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 01:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEJFbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 01:31:00 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12261 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261562AbVEJFay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 01:30:54 -0400
Date: Tue, 10 May 2005 07:30:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jensen galan <jrgalan@yahoo.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Adding a system call to kernel
In-Reply-To: <20050510052311.93996.qmail@web40909.mail.yahoo.com>
Message-ID: <Pine.LNX.4.62.0505100730260.6388@numbat.sonytel.be>
References: <20050510052311.93996.qmail@web40909.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, jensen galan wrote:
> I am trying to add a system call to a 2.4 kernel. 
> It's a simple system call which merely prints the
> value of xtime.  The kernel recompiles OK, and my
> user-space program (p5_a.c) actually works using the
> added system call when I use syscall() and do not
> generate a stub. (The 2 versions of my user-space
> programs are included below).  However, when I try to
> generate a stub in my user-space program using
> _syscall2(), I receive the following compilation
> error:
> 
> # gcc -Wall -D__KERNEL__ -I
> /lib/modules/2.4.28-gentoo-r5/build/include -o p5_b
> p5_b.c
> /tmp/cc5nBrjZ.o(.text+0x23): In function
> 'pedagogictime':
> : undefined reference to 'errno'
> collect2: ld returned 1 exit status

Please include <errno.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
