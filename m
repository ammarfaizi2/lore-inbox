Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262967AbSJBE6w>; Wed, 2 Oct 2002 00:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbSJBE6w>; Wed, 2 Oct 2002 00:58:52 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:5755 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S262967AbSJBE6v>; Wed, 2 Oct 2002 00:58:51 -0400
Date: Wed, 2 Oct 2002 07:04:16 +0200 (CEST)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: joseph@3dfx.com
Subject: problems compiling external modules on 2.4.20-pre8
Message-ID: <Pine.LNX.4.44.0210020658110.3075-100000@diapolon.int.fabbione.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I have a small problem compiling the old 3dfx module (shipped
with debian) but i can't really understand what I am missing here.
Any help would be really really appreciated. (even a nice RTFM that can
point me somewhere ;) ).

Thanks
Fabio

cc -DMODULE -D__KERNEL__ -I/usr/src/linux/include -O2 -m486
-fomit-frame-pointer -fno-strength-reduce -malign-loops=2 -malign-jumps=2
-malign-functions=2 -c -o 3dfx.o 3dfx_driver.c
In file included from /usr/src/linux/include/linux/string.h:25,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from 3dfx_driver.c:116:
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux/include/asm/string.h:300: warning: return makes pointer
from integer without a cast
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:307: warning: return makes pointer
from integer without a cast
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/vmalloc.h:8,
                 from /usr/src/linux/include/asm/io.h:47,
                 from /usr/src/linux/include/asm/pci.h:35,
                 from /usr/src/linux/include/linux/pci.h:622,
                 from 3dfx_driver.c:119:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_fast':
/usr/src/linux/include/asm/pgalloc.h:78: `boot_cpu_data_R0657d037'
undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h:78: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/pgalloc.h:78: for each function it appears in.)
/usr/src/linux/include/asm/pgalloc.h: In function `free_pgd_fast':
/usr/src/linux/include/asm/pgalloc.h:89: `boot_cpu_data_R0657d037'
undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one_fast':
/usr/src/linux/include/asm/pgalloc.h:122: `boot_cpu_data_R0657d037'
undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_free_fast':
/usr/src/linux/include/asm/pgalloc.h:132: `boot_cpu_data_R0657d037'
undeclared (first use in this function)
make: *** [3dfx.o] Error 1


