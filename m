Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbULXNXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbULXNXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 08:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbULXNXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 08:23:00 -0500
Received: from mail.dif.dk ([193.138.115.101]:49028 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261401AbULXNWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 08:22:46 -0500
Date: Fri, 24 Dec 2004 14:33:37 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
In-Reply-To: <Pine.LNX.4.61.0412241306340.19395@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0412241431580.3707@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0412241306340.19395@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, Jan Engelhardt wrote:

> >Hi,
> >
> >An allyesconfig build of 2.6.10-rc3-bk16 revealed the following build 
> >failures (which arefixed by the patch below) :
> >
> >  CC      drivers/char/mxser.o
> >drivers/char/mxser.c: In function `mxser_ioctl':
> >drivers/char/mxser.c:415: sorry, unimplemented: inlining failed in call to 
> >'mxser_check_modem_status': function body not available
> >drivers/char/mxser.c:1407: sorry, unimplemented: called from here
> >make[2]: *** [drivers/char/mxser.o] Error 1
> >make[1]: *** [drivers/char] Error 2
> >make: *** [drivers] Error 2
> 
> Add -funit-at-a-time to the CFLAGS, and the compiler is happy.
> 
But, does unit-at-a-time work reliably for all compilers on all archs back 
to and including gcc 2.95.3 ?   Isn't is safer/simpler to just uninline 
the functions or reorder the file?

-- 
Jesper Juhl

