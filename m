Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbULYVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbULYVFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULYVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:05:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:23243 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261566AbULYVFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:05:05 -0500
Date: Sat, 25 Dec 2004 22:15:57 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
In-Reply-To: <Pine.LNX.4.61.0412251226200.25122@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0412252214550.3495@dragon.hygekrogen.localhost>
References: <200412251101.iBPB1IpP009024@harpo.it.uu.se>
 <Pine.LNX.4.61.0412251226200.25122@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2004, Jan Engelhardt wrote:

> >>>> Add -funit-at-a-time to the CFLAGS, and the compiler is happy.
> >>>> 
> >>> But, does unit-at-a-time work reliably for all compilers on all archs back 
> >>> to and including gcc 2.95.3 ? 
> >>
> >>Unit-at-a-time is only available in GCC 3.4 and above.
> 
> No, it's already in my 3.3.0 (SUSE Linux 8.2) and continues to exist in 3.3.3 
> (9.2)
> 
> >The problem with unit-at-a-time isn't compiler availability,
> >but the fact that at least with gcc-3.4 on x86 it causes
> >significant stack usage increases, which in the kernel lead
> >to stack overflow problems. This is not a theoretical issue,
> >the overflows have been observed in normal kernels.
> >
> >So wrt inlining failures, the correct fix is to remove the
> >inlines or rearrange the code to allow inlining w/o unit-at-a-time.
> 
> Or making some pressure on gcc developers to fix the increase.
> 
But that won't do people using older gcc's to build the kernel any good.


-- 
Jesper Juhl


