Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280907AbRKOPgf>; Thu, 15 Nov 2001 10:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKOPgZ>; Thu, 15 Nov 2001 10:36:25 -0500
Received: from lol1122.lss.emc.com ([168.159.27.122]:12673 "EHLO
	lol1122.lss.emc.com") by vger.kernel.org with ESMTP
	id <S280907AbRKOPgV>; Thu, 15 Nov 2001 10:36:21 -0500
Date: Thu, 15 Nov 2001 10:36:15 -0500
Message-Id: <200111151536.fAFFaFI32118@lol1122.lss.emc.com>
To: linux-kernel@vger.kernel.org
From: Preston Crow <pc-lkml141101@crowcastle.net>
Subject: Re: Compile failed on fs.o for 2.4.15-pre4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> After making the patch to setup.c so that it would compile, I ran into a
> linking error.  I have a fairly standard uniprocessor PIII system.  I can
> make my config file available to anyone that thinks it will help.

> fs/fs.o: In function `dput':
> fs/fs.o(.text+0x10fb8): undefined reference to `atomic_dec_and_lock'
> make: *** [vmlinux] Error 1

Dick Johnson replied:
> Assuming that your version is similar to mine....
>
> In ...linux/fs/dcache.c add ...
> #include <linux/spinlock.h>

I tried that.  The error is coming from fs/dcache.c, and it does look like
including that file is a good idea, but no matter where I put the #include
directive, I still get the same error.

[Please CC responses to me]

--PC
