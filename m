Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTBJUkX>; Mon, 10 Feb 2003 15:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTBJUkW>; Mon, 10 Feb 2003 15:40:22 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:21925 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265139AbTBJUkT>; Mon, 10 Feb 2003 15:40:19 -0500
Date: Mon, 10 Feb 2003 14:49:36 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Kay Sievers <lkml@vrfy.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 defconfig+CONFIG_MODVERSIONS=y -> syntax error
In-Reply-To: <20030210203702.GA16226@vrfy.org>
Message-ID: <Pine.LNX.4.44.0302101448280.3320-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Kay Sievers wrote:

> the compilation of a fresh 2.5.60-kernel failed with:
> 
>   gcc -Wp,-MD,arch/i386/kernel/.time.o.d -D__KERNEL__ -Iinclude -Wall
>   -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
>   -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4
>   -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
>   -DKBUILD_BASENAME=time -DKBUILD_MODNAME=time -c -o
>   arch/i386/kernel/.tmp_time.o arch/i386/kernel/time.c
>   ld:arch/i386/kernel/.tmp_time.ver:1: syntax error
>   make[1]: *** [arch/i386/kernel/time.o] Error 1
>   make: *** [arch/i386/kernel] Error 2
> 
> It's the "make defconfig .config" with CONFIG_MODVERSIONS switched on.

Interesting. Thanks for testing CONFIG_MODVERSIONS. I cannot reproduce it
here, unfortunately (not even with the same .config). What does
arch/i386/kernel/.tmp_time.ver look like?

--Kai


