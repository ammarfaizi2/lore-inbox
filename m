Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTFXSXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTFXSXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:23:00 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:47373 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263971AbTFXSW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:22:57 -0400
Subject: Re: Problems when compile kernel 2.5.73-mm1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: jds <jds@soltis.cc>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030624151611.M70129@soltis.cc>
References: <20030624151611.M70129@soltis.cc>
Content-Type: text/plain
Message-Id: <1056479823.587.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 24 Jun 2003 20:37:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 17:18, jds wrote:
> Hi Andrew:
> 
>    I have problems whe try the compile kernel. the messages is:
> 
> [root@toshiba linux-2.5]# make bzImage
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-i386/asm_offsets.h
>   CC      init/main.o
> In file included from include/linux/pagemap.h:7,
>                  from include/linux/blkdev.h:10,
>                  from include/linux/blk.h:2,
>                  from init/main.c:26:
> include/linux/mm.h: In function `lowmem_page_address':
> include/linux/mm.h:344: `__PAGE_OFFSET' undeclared (first use in this function)
> include/linux/mm.h:344: (Each undeclared identifier is reported only once
> include/linux/mm.h:344: for each function it appears in.)
> In file included from include/linux/bio.h:28,
>                  from include/linux/blkdev.h:14,
>                  from include/linux/blk.h:2,
>                  from init/main.c:26:
> include/asm/io.h: In function `virt_to_phys':
> include/asm/io.h:74: `__PAGE_OFFSET' undeclared (first use in this function)
> include/asm/io.h: In function `phys_to_virt':
> include/asm/io.h:92: `__PAGE_OFFSET' undeclared (first use in this function)
> include/asm/io.h: In function `isa_check_signature':
> include/asm/io.h:245: `__PAGE_OFFSET' undeclared (first use in this function)
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> [root@toshiba linux-2.5]#
> 
> Helpme please 

Please, do:

1. make oldconfig
2. make bzImage

This should help

