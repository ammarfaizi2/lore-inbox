Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVABM3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVABM3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 07:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVABM3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 07:29:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38531 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261214AbVABM3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 07:29:07 -0500
Date: Sun, 2 Jan 2005 07:33:25 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: jgarzik@logos.cnet
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make libata for 2.4 compile on alpha
Message-ID: <20050102093325.GA29158@logos.cnet>
References: <200412270043.52692.stkn@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412270043.52692.stkn@gentoo.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff!

Got that one? 

On Mon, Dec 27, 2004 at 12:43:48AM +0100, Stefan Knoblich wrote:
> Hi,
> 
> linux-2.4.28 + 2.4.28-rc3-libata1 patch won't compile on alpha, attached patch 
> fixes that.
> 
> 
> Error messages:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.28/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2
>  -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mno-fp-regs 
> -ffixed-8 -mcpu=ev5 -Wa,-mev6
>  -nostdinc -iwithprefix include -DKBUILD_BASENAME=libata_core  -DEXPORT_SYMTAB 
> -c libata-core.c
> In file included from /usr/src/linux-2.4.28/include/linux/highmem.h:5,
>                  from libata-core.c:31:
> /usr/src/linux-2.4.28/include/asm/pgalloc.h: In function `flush_tlb_other':
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:63: error: dereferencing pointer 
> to incomplete type
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:63: warning: implicit declaration 
> of function `smp_processor_id'
> /usr/src/linux-2.4.28/include/asm/pgalloc.h: In function 
> `flush_icache_user_range':
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: dereferencing pointer 
> to incomplete type
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: `VM_EXEC' undeclared 
> (first use in this function)
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: (Each undeclared 
> identifier is reported only once
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:84: error: for each function it 
> appears in.)
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:85: error: dereferencing pointer 
> to incomplete type
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:86: error: `current' undeclared 
> (first use in this function)
> /usr/src/linux-2.4.28/include/asm/pgalloc.h:89: error: dereferencing pointer 
> to incomplete type
> /usr/src/linux-2.4.28/include/asm/pgalloc.h: In function 
> `ev4_flush_tlb_current_page':
> <SNIP>

> --- linux-2.4.28/drivers/scsi/libata-core.c.orig	2004-12-26 22:19:31.389841557 +0100
> +++ linux-2.4.28/drivers/scsi/libata-core.c	2004-12-26 22:19:48.910349155 +0100
> @@ -28,6 +28,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
> +#include <linux/mm.h>
>  #include <linux/highmem.h>
>  #include <linux/spinlock.h>
>  #include <linux/blkdev.h>



