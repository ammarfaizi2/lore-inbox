Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSEPH5g>; Thu, 16 May 2002 03:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSEPH5f>; Thu, 16 May 2002 03:57:35 -0400
Received: from zok.SGI.COM ([204.94.215.101]:4534 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316600AbSEPH5e>;
	Thu, 16 May 2002 03:57:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Joachim Martillo <martillo@telfordtools.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8 non-kernel files in wan/8253x
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 May 2002 17:57:08 +1000
Message-ID: <31587.1021535828@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/wan/8253x/Makefile contains these lines

8253xcfg: 8253xcfg.c
        $(CC)  -o 8253xcfg $(EXTRA_CFLAGS) -U__KERNEL__ 8253xcfg.c

8253xmac: 8253xmac.c
        $(CC)  -o 8253xmac $(EXTRA_CFLAGS) -U__KERNEL__ 8253xmac.c

8253xspeed: 8253xspeed.c
        $(CC)  -o 8253xspeed $(EXTRA_CFLAGS) -U__KERNEL__ 8253xspeed.c

8253xpeer: 8253xpeer.c
        $(CC)  -o 8253xpeer $(EXTRA_CFLAGS) -U__KERNEL__ 8253xpeer.c

eprom9050: eprom9050.c
        $(CC)  -o eprom9050 $(EXTRA_CFLAGS) -U__KERNEL__ eprom9050.c

All of those .c files are user space utilities, they do not fit the
kernel build system and do not belong in the kernel.  Please move these
files to a separate user space package and delete from 2.4.19-pre*.

