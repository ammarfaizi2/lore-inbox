Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263468AbSJGVu1>; Mon, 7 Oct 2002 17:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbSJGVu1>; Mon, 7 Oct 2002 17:50:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:21381 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263468AbSJGVu0>; Mon, 7 Oct 2002 17:50:26 -0400
Date: Mon, 7 Oct 2002 16:56:03 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Alastair Stevens <alastair@altruxsolutions.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compile failure with 2.5.41 in serial/core.o
In-Reply-To: <1034024024.1962.15.camel@dolphin.entropy.net>
Message-ID: <Pine.LNX.4.44.0210071654250.14294-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Oct 2002, Alastair Stevens wrote:

> Here's the error when doing "make modules" from a clean build. The "make
> bzImage" works fine:
> 
>   gcc -Wp,-MD,drivers/serial/.core.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DMODULE -include include/linux/modversions.h   -DKBUILD_BASENAME=core  
> -c -o drivers/serial/core.o drivers/serial/core.c
> drivers/serial/core.c:2456: parse error before
> `this_object_must_be_defined_as_export_objs_in_the_Makefile'

Hmmh, I cannot reproduce this, nor do I see how this would happen -
Does your drivers/serial/Makefile have the line

	export-objs     := core.o 8250.o suncore.o

?

If you can reproduce this, could you mail me your .config?

--Kai


