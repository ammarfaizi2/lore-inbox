Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbULXMHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbULXMHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 07:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbULXMHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 07:07:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25255 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261395AbULXMHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 07:07:14 -0500
Date: Fri, 24 Dec 2004 13:06:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Alan Cox <alan@redhat.com>, Moxa Technologies <support@moxa.com.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
In-Reply-To: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412241306340.19395@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>An allyesconfig build of 2.6.10-rc3-bk16 revealed the following build 
>failures (which arefixed by the patch below) :
>
>  CC      drivers/char/mxser.o
>drivers/char/mxser.c: In function `mxser_ioctl':
>drivers/char/mxser.c:415: sorry, unimplemented: inlining failed in call to 
>'mxser_check_modem_status': function body not available
>drivers/char/mxser.c:1407: sorry, unimplemented: called from here
>make[2]: *** [drivers/char/mxser.o] Error 1
>make[1]: *** [drivers/char] Error 2
>make: *** [drivers] Error 2

Add -funit-at-a-time to the CFLAGS, and the compiler is happy.


Jan Engelhardt
-- 
ENOSPC
