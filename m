Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSLJFiI>; Tue, 10 Dec 2002 00:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbSLJFiI>; Tue, 10 Dec 2002 00:38:08 -0500
Received: from [144.135.24.137] ([144.135.24.137]:50374 "EHLO
	mta08bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S266555AbSLJFiH>; Tue, 10 Dec 2002 00:38:07 -0500
Message-ID: <3DF57FE0.7090300@bigpond.com>
Date: Tue, 10 Dec 2002 16:47:12 +1100
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.51
References: <Pine.LNX.4.44.0212091912180.17200-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212091912180.17200-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, big patch, but this is mostly all over the place with a lot of fairly 
> random small fixes (a lot of compile fixes for the build breakage from the 
> header file cleanups, for example).
> 
> The AGP reorg, fbdev merge, and the s390 updates also help make the patch
                  ^^^^^^^^^^^
> quite large.

Unfortunately not all went well with this:

make -f scripts/Makefile.build obj=drivers/video/matrox
   gcc -Wp,-MD,drivers/video/matrox/.matroxfb_base.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=athlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc 
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=matroxfb_base -DKBUILD_MODNAME=matroxfb_base 
-DEXPORT_SYMTAB  -c -o drivers/video/matrox/matroxfb_base.o drivers/video/matrox/matroxfb_base.c
In file included from drivers/video/matrox/matroxfb_base.c:105:
drivers/video/matrox/matroxfb_base.h:52:25: video/fbcon.h: No such file or directory

... and downwards thereafter.

