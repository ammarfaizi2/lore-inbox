Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUFUNGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUFUNGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266228AbUFUNG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:06:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:23030 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266224AbUFUNDV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:03:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16598.56442.254480.281844@alkaid.it.uu.se>
Date: Mon, 21 Jun 2004 15:02:50 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
Cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile linux-2.4.27-rc1 ... ipt_REJECT.c
In-Reply-To: <Pine.OSF.4.51.0406211343160.157782@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0406211343160.157782@tao.natur.cuni.cz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ© writes:
 > Hi,
 >   has someone seen the following error? I can provide .config if required.
 > I think I've seen this in 2.4.27-pre6, not in -pre3.
 > Please Cc: me in replies. Thanks.
 > Martin
 > 
 > gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.27-rc1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipt_REJECT  -c -o ipt_REJECT.o ipt_REJECT.c
 > In file included from ipt_REJECT.c:8:
 > /usr/src/linux-2.4.27-rc1/include/linux/skbuff.h: In function `kmap_skb_frag':
 > /usr/src/linux-2.4.27-rc1/include/linux/skbuff.h:1121: warning: use of compound expressions as lvalues is deprecated
...
 > $ gcc --version
 > gcc (GCC) 3.4.0 20040601 (Gentoo Linux 3.4.0-r6, ssp-3.4-2, pie-8.7.6.3)

For this error you need to apply
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-rc1>.

If you're using ACPI you should also apply
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-mpparse-fix-2.4.27-rc1>.
