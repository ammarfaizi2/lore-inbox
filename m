Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSLQXhk>; Tue, 17 Dec 2002 18:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLQXhk>; Tue, 17 Dec 2002 18:37:40 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:40685 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S265201AbSLQXhj>; Tue, 17 Dec 2002 18:37:39 -0500
Message-ID: <3E0027E3.30503@centurytel.net>
Date: Wed, 18 Dec 2002 00:46:43 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
References: <Pine.LNX.4.33L2.0212171527070.17648-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> Just remove io_daemon.o from the fs/intermezzo/Makefile .
> 
Thanks your point out, it pass this problem at compile time, then it 
still terminate by another error



   gcc -Wp,-MD,drivers/block/.ps2esdi.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE 
-DKBUILD_BASENAME=ps2esdi -DKBUILD_MODNAME=ps2esdi   -c -o 
drivers/block/ps2esdi.o drivers/block/ps2esdi.c
drivers/block/ps2esdi.c:185: redefinition of `__initfn'
drivers/block/ps2esdi.c:171: `__initfn' previously defined here
drivers/block/ps2esdi.c: In function `__initfn':
drivers/block/ps2esdi.c:189: warning: initialization from incompatible 
pointer type
drivers/block/ps2esdi.c:192: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:192: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:193: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:196: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:197: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:199: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c: In function `__exitfn':
drivers/block/ps2esdi.c:207: warning: implicit declaration of function 
`mca_mark_as_unused'
drivers/block/ps2esdi.c:215: `i' undeclared (first use in this function)
drivers/block/ps2esdi.c:215: (Each undeclared identifier is reported 
only once
drivers/block/ps2esdi.c:215: for each function it appears in.)
drivers/block/ps2esdi.c: In function `ps2esdi_geninit':
drivers/block/ps2esdi.c:298: warning: implicit declaration of function 
`mca_find_adapter'
drivers/block/ps2esdi.c:298: `MCA_NOTFOUND' undeclared (first use in 
this function)
drivers/block/ps2esdi.c:309: warning: implicit declaration of function 
`mca_set_adapter_name'
drivers/block/ps2esdi.c:315: warning: implicit declaration of function 
`mca_mark_as_used'
drivers/block/ps2esdi.c:316: warning: passing arg 2 of 
`mca_set_adapter_procfn' from incompatible pointer type
drivers/block/ps2esdi.c:333: warning: implicit declaration of function 
`mca_read_stored_pos'
drivers/block/ps2esdi.c: In function `do_ps2esdi_request':
drivers/block/ps2esdi.c:508: warning: long long unsigned int format, 
different type arg (arg 3)
{standard input}: Assembler messages:
{standard input}:216: Error: symbol `__initfn' is already defined
make[2]: *** [drivers/block/ps2esdi.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


highly appreciate any advancer's advice

-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

