Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUGXCD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUGXCD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 22:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUGXCD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 22:03:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:31732 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268228AbUGXCDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 22:03:54 -0400
Date: Sat, 24 Jul 2004 04:03:51 +0200 (MEST)
Message-Id: <200407240203.i6O23p2L004061@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.27+stdarg+gcc-3.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2004 02:14:21 +0200, J.A. Magallon wrote:
>With gcc-3.4.1 I get the following error when building 2.4.27-rc3.
>Any suggestion ?
>
>gcc -D__KERNEL__ -nostdinc -iwithprefix include -I/usr/src/linux-2.4.27-rc3=
>-jam1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-alia=
>sing -fno-common -fomit-frame-pointer -mpreferred-stack-boundary=3D2 -msoft=
>-float -march=3Dpentium3 -fno-unit-at-a-time   -DKBUILD_BASENAME=3Ddo_mount=
>s -c -o init/do_mounts.o init/do_mounts.c
>init/do_mounts.c: In function `change_floppy':
>init/do_mounts.c:424: error: `va_list' undeclared (first use in this functi=
>on)
>init/do_mounts.c:424: error: (Each undeclared identifier is reported only o=
>nce
>init/do_mounts.c:424: error: for each function it appears in.)
>init/do_mounts.c:424: error: syntax error before "args"
>init/do_mounts.c:425: warning: implicit declaration of function `va_start'
>init/do_mounts.c:425: error: `args' undeclared (first use in this function)
>init/do_mounts.c:426: warning: implicit declaration of function `vsprintf'
>init/do_mounts.c:427: warning: implicit declaration of function `va_end'
>make: *** [init/do_mounts.o] Error 1

gcc picks stdarg.h from its own private install directory,
which you specified with --prefix=$prefix at configure-time.
$prefix/lib/gcc/i686-pc-linux-gnu/3.4.1/include/stdarg.h in my case.

I suspect you either mis-configured your gcc-3.4.1, or somehow
broke the installation.

/Mikael
