Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTETU6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTETU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:58:53 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:8602 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261192AbTETU6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:58:52 -0400
Subject: Re: aic7(censored) compile error
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1053463220.3107.1.camel@chevrolet.hybel>
References: <1053463220.3107.1.camel@chevrolet.hybel>
Content-Type: text/plain
Message-Id: <1053465144.3102.8.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 20 May 2003 23:12:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 20.05.2003 kl. 22.40 skrev Stian Jordet:
> Hello,
> 
> Am I just blind, or haven't this been reported? Haven't been able to
> compile 2.5.69 since bk4, I think. This is with gcc-3.3.

Hmm. I fixed this with changing line 767 to:

next_len = 0x100000000LL - (addr & 0xFFFFFFFF);

Don't know if this is the right fix, but it works :)

> make -f scripts/Makefile.build obj=drivers/scsi/aic7xxx
>   gcc -Wp,-MD,drivers/scsi/aic7xxx/.aic7xxx_osm.o.d -D__KERNEL__
> -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=pentium3 -Iinclude/asm-i386/mach-default -fomit-frame-pointer
> -nostdinc -iwithprefix include  -Idrivers/scsi -Werror 
> -DKBUILD_BASENAME=aic7xxx_osm -DKBUILD_MODNAME=aic7xxx -c -o
> drivers/scsi/aic7xxx/aic7xxx_osm.o drivers/scsi/aic7xxx/aic7xxx_osm.c
> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_map_seg':
> drivers/scsi/aic7xxx/aic7xxx_osm.c:767: warning: integer constant is too
> large for "long" type
> make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1
> make[2]: *** [drivers/scsi/aic7xxx] Error 2
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

Best regards,
Stian

